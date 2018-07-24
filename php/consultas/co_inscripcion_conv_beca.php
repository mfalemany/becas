<?php
class co_inscripcion_conv_beca
{
	function get_inscripciones($filtro = array())
	{
		$where = array();
		if(isset($filtro['id_tipo_doc'])){
			$where[] = 'becario.id_tipo_doc = '.quote($filtro['id_tipo_doc']);	
		}
		if(isset($filtro['nro_documento'])){
			$where[] = 'insc.nro_documento = '.quote($filtro['nro_documento']);	
		}
		if(isset($filtro['id_convocatoria'])){
			$where[] = 'insc.id_convocatoria = '.quote($filtro['id_convocatoria']);	
		}
		if(isset($filtro['id_tipo_beca'])){
			$where[] = 'insc.id_tipo_beca = '.quote($filtro['id_tipo_beca']);	
		}
		if(isset($filtro['id_tipo_convocatoria'])){
			$where[] = 'tip_con.id_tipo_convocatoria = '.quote($filtro['id_tipo_convocatoria']);	
		}

		$sql = "SELECT
			insc.id_dependencia,
			dep.nombre as dependencia,
			insc.id_tipo_beca,
			tip_bec.tipo_beca,
			insc.nro_documento,
			becario.apellido||', '||becario.nombres as becario,
			director.apellido||', '||director.nombres as director,
			becario.id_tipo_doc,
			insc.id_convocatoria,
			conv.convocatoria,
			insc.fecha_hora,
			insc.admisible,
			insc.puntaje,
			insc.beca_otorgada,
			area.nombre as area_conocimiento,
			insc.titulo_plan_beca,
			insc.justif_codirector,
			carr.carrera as carrera,
			insc.materias_plan,
			insc.materias_aprobadas,
			insc.prom_hist_egresados,
			insc.prom_hist,
			insc.carrera_posgrado,
			insc.nombre_inst_posgrado,
			insc.titulo_carrera_posgrado,
			insc.archivo_insc_posgrado,
			insc.nro_carpeta,
			insc.observaciones,
			insc.estado,
			insc.cant_fojas,
			insc.es_titular
			
		FROM be_inscripcion_conv_beca as insc	
		LEFT JOIN be_convocatoria_beca as conv on conv.id_convocatoria = insc.id_convocatoria
		LEFT JOIN sap_personas as becario on becario.nro_documento = insc.nro_documento
		LEFT JOIN sap_personas as director 
			ON director.nro_documento = insc.nro_documento_dir
		LEFT JOIN be_tipos_beca as tip_bec on tip_bec.id_tipo_beca = insc.id_tipo_beca
		LEFT JOIN be_tipos_convocatoria as tip_con ON 
			(tip_con.id_tipo_convocatoria = tip_bec.id_tipo_convocatoria 
			AND tip_con.id_tipo_convocatoria = conv.id_tipo_convocatoria)
		LEFT JOIN sap_dependencia as dep ON (insc.id_dependencia = dep.id)
		LEFT JOIN sap_area_conocimiento as area ON (insc.id_area_conocimiento = area.id)
		LEFT JOIN be_carreras as carr ON (insc.id_carrera = carr.id_carrera)
		ORDER BY admisible";
		if(count($where)){
			$sql = sql_concatenar_where($sql, $where);
		}
		//echo nl2br($sql);
		return toba::db()->consultar($sql);
	}

	/**
	 * Obtiene un numero de carpeta que no est?en uso. El nombre de la funci? se debe a que anteriormente la funci? devolv? el ?ltimo n?mero que se hab? asignado (con la intenci? de incrementarlo en una unidad al nuevo registro). Despues, la funci? fue modificada para que, en caso de eliminarse una inscripci? a beca, y exista un "hueco" entre los n?meros de carpeta, esta funci? pueda re-asignarlos y lograr una secuencia limpia.
	 * Es posible que esta funci? falle (asigne dos numeros de carpeta a un mismo proyecto) cuando se guardan simultaneamente. Se deja a prueba de la primera convocatoria (A? 2018)
	 * @param integer $id_convocatoria 
	 * @param integer $id_tipo_beca 
	 * @return String String formateado para asignar como n?mero de carpeta a una nueva inscripci?.
	 */
	
	function get_ultimo_nro_carpeta($id_convocatoria,$id_tipo_beca)
	{
		//se obtiene el prefijo de carpeta para el tipo de beca actual
		$prefijo = toba::consulta_php('co_tipos_beca')->get_campo('prefijo_carpeta',$id_tipo_beca);
		if(!$prefijo){
			throw new toba_error("No se ha definido un prefijo de carpeta para el tipo de beca seleccionado. Por favor, pongase en contacto con la Secretar? General de Ciencia y T?ica");
		}
		// Esta consulta retorna un string con formato json conteniendo todos los numeros de carpetas existentes.
		$sql = "SELECT array_to_json(array_agg(nro_carpeta)) as existentes
				FROM be_inscripcion_conv_beca
				WHERE id_convocatoria = ".quote($id_convocatoria)."
				AND id_tipo_beca = ".quote($id_tipo_beca);

		$resultado = toba::db()->consultar_fila($sql);

		if(count($resultado)){
			//convierto el resultado de la consulta a un array
			$existentes = json_decode($resultado['existentes']);

			//una vez que tengo todos los numeros de carpeta existentes en un array, lo recorro hasta encontrar uno que no exista. Esto permite llenar los "huecos" generados por la eliminaci? de numeros de carpetas.
			for($i=1;$i<9999;$i++){
				//genero el numero de tres digitos con relleno de ceros: 001, 002, 003, etc...
				$nro = sprintf("%'.03d",$i);
				//lo concateno con el prefijo de carpeta de la beca seleccionada
				$nro_carpeta = $prefijo."-".$nro;

				//si ya existe, contin?o el bucle hasta encontrar uno que no existe
				if(is_array($existentes)){
					if(in_array($nro_carpeta,$existentes)){
						continue;
					}else{
						//si no existe, BINGO!! Se retorna ese numero de carpeta para ser utilizado
						return $nro_carpeta;
					}
				}else{
					return $prefijo."-001";
				}
			}
		}else{
			//si no obtuve resultados, es porque se est?cargando el primer numero de carpeta
			return $prefijo."-001";
		}
	}

	/**
	 * Obtiene todos los datos necesarios para generar el comprobante de inscripción que presenta el alumno en papel, con los avales de las autoridades necesarias.
	 * @param array $inscripcion Array que contiene el id_convocatoria, el id_tipo_beca y el nro_documento que identifican a una inscripción
	 * @return array
	 */
	function get_detalles_comprobante($inscripcion = array())
	{
		/*- convocatoria
		- tipo_beca
		- area_conocimiento
		- titulo_plan_beca
		- titulo_proyecto
		- lugar_trabajo_becario
		- area_dpto_laboratoria
		- alumno
		- alumno.facultad_o_instituto
		- alumno.carrera
		- alumno.anio_ingreso
		- alumno.*/
	}
}
?>