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
		if(isset($filtro['postulante'])){
			$where[] = 'quitar_acentos(becario.apellido||becario.nombres) ILIKE quitar_acentos('.quote('%'.$filtro['postulante'].'%').")";	
		}

		if(isset($filtro['id_convocatoria'])){
			$where[] = 'insc.id_convocatoria = '.quote($filtro['id_convocatoria']);	
		}
		if(isset($filtro['id_area_conocimiento'])){
			$where[] = 'area.id = '.quote($filtro['id_area_conocimiento']);	
		}
		if(isset($filtro['id_tipo_beca'])){
			$where[] = 'insc.id_tipo_beca = '.quote($filtro['id_tipo_beca']);	
		}
		if(isset($filtro['nro_carpeta'])){
			$where[] = 'lower(insc.nro_carpeta) = lower('.quote($filtro['nro_carpeta']).")";	
		}
		if(isset($filtro['id_tipo_convocatoria'])){
			$where[] = 'tip_con.id_tipo_convocatoria = '.quote($filtro['id_tipo_convocatoria']);	
		}
		if(isset($filtro['id_dependencia'])){
			$where[] = 'insc.id_dependencia = '.quote($filtro['id_dependencia']);	
		}
		if(isset($filtro['admisible'])){
			if($filtro['admisible'] == 'P'){
				$where[] = 'insc.admisible IS null';
			}else{
				$where[] = 'insc.admisible = '.quote($filtro['admisible']);	
			}
			
		}
		if(isset($filtro['beca_otorgada'])){
			$where[] = "insc.beca_otorgada = ".quote($filtro['beca_otorgada']);
		}
		if(isset($filtro['estado'])){
			$where[] = 'insc.estado = '.quote($filtro['estado']);	
		}
		if(isset($filtro['estado_evaluacion'])){
			$clausula = ($filtro['estado_evaluacion'] == 'N') ? 'NOT EXISTS' : 'EXISTS';
			$where[] = "$clausula (SELECT * FROM be_dictamen_detalle as det
				where tipo_dictamen = 'C'
				and det.nro_documento = insc.nro_documento
				and det.id_tipo_beca = insc.id_tipo_beca
				and det.id_convocatoria = insc.id_convocatoria)";	
		}
		$sql = "SELECT
			insc.id_dependencia,
			dep.nombre as dependencia,
			insc.id_tipo_beca,
			tip_bec.tipo_beca,
			insc.nro_documento,
			initcap(becario.apellido)||', '||initcap(becario.nombres) as becario,
			becario.cuil as becario_cuil,
			becario.mail as mail_becario,
			initcap(director.apellido)||', '||initcap(director.nombres) as director,
			director.mail as mail_director,
			initcap(codirector.apellido)||', '||initcap(codirector.nombres) as codirector,
			initcap(subdirector.apellido)||', '||initcap(subdirector.nombres) as subdirector,
			becario.id_tipo_doc,
			insc.id_convocatoria,
			conv.convocatoria,
			insc.fecha_hora,
			insc.admisible,
			case (insc.admisible) when 'S' then 'Admitido' when 'N' then 'No admitido' else 'Sin admisibilidad' end as admisible_desc,
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
			insc.area_trabajo,
			insc.nro_carpeta,
			insc.observaciones,
			insc.estado,
			case insc.estado when 'A' then 'Abierta' when 'C' then 'Cerrada' else 'No definido' end as estado_desc,
			insc.cant_fojas,
			insc.es_titular,
			lugtrab.nombre AS lugar_trabajo_becario,
			((coalesce(insc.puntaje,0)) + (SELECT coalesce(SUM(det.puntaje),0) 
							from be_dictamen_detalle as det
							where tipo_dictamen = 'C'
							and det.nro_documento = insc.nro_documento
							and det.id_tipo_beca = insc.id_tipo_beca
							and det.id_convocatoria = insc.id_convocatoria)
			) as puntaje_comision,
			((coalesce(insc.puntaje,0)) + (SELECT coalesce(SUM(det.puntaje),0) 
							from be_dictamen_detalle as det
							where tipo_dictamen = 'J'
							and det.nro_documento = insc.nro_documento
							and det.id_tipo_beca = insc.id_tipo_beca
							and det.id_convocatoria = insc.id_convocatoria)
			) as puntaje_junta,
			(select case when count(*) = 0 then 'N' else 'S' end as evaluado
				from be_dictamen_detalle as det
				where tipo_dictamen = 'C'
				and det.nro_documento = insc.nro_documento
				and det.id_tipo_beca = insc.id_tipo_beca
				and det.id_convocatoria = insc.id_convocatoria
			) as evaluado_comision,
			(select case when count(*) = 0 then 'N' else 'S' end as evaluado
				from be_dictamen_detalle as det
				where tipo_dictamen = 'J'
				and det.nro_documento = insc.nro_documento
				and det.id_tipo_beca = insc.id_tipo_beca
				and det.id_convocatoria = insc.id_convocatoria
			) as evaluado_junta

		FROM be_inscripcion_conv_beca as insc	
		LEFT JOIN be_convocatoria_beca as conv on conv.id_convocatoria = insc.id_convocatoria
		LEFT JOIN sap_personas as becario on becario.nro_documento = insc.nro_documento
		LEFT JOIN sap_personas as director ON director.nro_documento = insc.nro_documento_dir
		LEFT JOIN sap_personas as codirector ON codirector.nro_documento = insc.nro_documento_codir
		LEFT JOIN sap_personas as subdirector ON subdirector.nro_documento = insc.nro_documento_subdir
		LEFT JOIN be_tipos_beca as tip_bec on tip_bec.id_tipo_beca = insc.id_tipo_beca
		LEFT JOIN be_tipos_convocatoria as tip_con ON 
			(tip_con.id_tipo_convocatoria = tip_bec.id_tipo_convocatoria 
			AND tip_con.id_tipo_convocatoria = conv.id_tipo_convocatoria)
		LEFT JOIN sap_dependencia as dep ON (insc.id_dependencia = dep.id)
		LEFT JOIN sap_area_conocimiento as area ON (insc.id_area_conocimiento = area.id)
		LEFT JOIN be_carreras as carr ON (insc.id_carrera = carr.id_carrera)
		LEFT JOIN sap_dependencia AS lugtrab ON lugtrab.id = insc.lugar_trabajo_becario";
		if(isset($filtro['campos_ordenacion'])){
			$sql .= " ORDER BY ".$filtro['campos_ordenacion'];
		}else{
			$sql .= " ORDER BY admisible,becario";
		}
		
		if(count($where)){
			$sql = sql_concatenar_where($sql, $where);
		}
		
		return toba::db()->consultar($sql);
	}

	/**
	 * Obtiene un numero de carpeta que no est?en uso. El nombre de la funci? se debe a que anteriormente la funci? devolv? el ?ltimo n?mero que se hab? asignado (con la intenci? de incrementarlo en una unidad al nuevo registro). Despues, la funci? fue modificada para que, en caso de eliminarse una inscripci? a beca, y exista un "hueco" entre los n?meros de carpeta, esta funci? pueda re-asignarlos y lograr una secuencia limpia.
	 * Es posible que esta funci? falle (
	 * asigne dos numeros de carpeta a un mismo proyecto) cuando se guardan simultaneamente. Se deja a prueba de la primera convocatoria (A? 2018)
	 * @param integer $id_convocatoria 
	 * @param integer $id_tipo_beca 
	 * @return String String formateado para asignar como n?mero de carpeta a una nueva inscripci?.
	 */
	
	function get_ultimo_nro_carpeta($id_convocatoria,$id_tipo_beca)
	{
		//se obtiene el prefijo de carpeta para el tipo de beca actual
		$prefijo = toba::consulta_php('co_tipos_beca')->get_campo('prefijo_carpeta',$id_tipo_beca);
		if(!$prefijo){
			throw new toba_error("No se ha definido un prefijo de carpeta para el tipo de beca seleccionado. Por favor, pongase en contacto con la Secretaría General de Ciencia y Técnica");
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


	function get_campo($campos,$filtro = array())
	{
		$where = array();
		if(count($filtro)){
			foreach($filtro as $campo => $valor){
				$where[] = $campo." = ".quote($valor);
			}	
		}
		if(!is_array($campos)){
			$campos = array($campos);
		}
		$sql = "SELECT ".implode(',',$campos)." FROM be_inscripcion_conv_beca";
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	/**
	 * Obtiene todos los datos necesarios para generar el comprobante de inscripci? que presenta el alumno en papel, con los avales de las autoridades necesarias.
	 * @param array $inscripcion Array que contiene el id_convocatoria, el id_tipo_beca y el nro_documento que identifican a una inscripci?
	 * @return array
	 */
	function get_detalles_comprobante($inscripcion = array())
	{
		$detalles = array();
		/* ============================================================================================== */
		$sql = "SELECT 
				per.apellido,
				per.nombres,
				insc.nro_documento,
				insc.id_dependencia,
				dep.nombre as nombre_dependencia,
				coalesce(per.cuil,'No declarado') AS cuil,
				per.fecha_nac,
				coalesce(per.celular,'No declarado') AS celular,
				coalesce(per.telefono,'No declarado') AS telefono,
				insc.prom_hist_egresados, 
				insc.prom_hist,
				insc.nro_documento_codir,
				insc.nro_documento_subdir,
				insc.justif_codirector,
				insc.materias_plan,
				insc.materias_aprobadas,
				insc.puntaje,
				carr.carrera,
				((coalesce(insc.puntaje,0)) + (SELECT coalesce(SUM(det.puntaje),0) 
							from be_dictamen_detalle as det
							where tipo_dictamen = 'C'
							and det.nro_documento = insc.nro_documento
							and det.id_tipo_beca = insc.id_tipo_beca
							and det.id_convocatoria = insc.id_convocatoria)
				) as puntaje_comision,
				((coalesce(insc.puntaje,0)) + (SELECT coalesce(SUM(det.puntaje),0) 
							from be_dictamen_detalle as det
							where tipo_dictamen = 'J'
							and det.nro_documento = insc.nro_documento
							and det.id_tipo_beca = insc.id_tipo_beca
							and det.id_convocatoria = insc.id_convocatoria)
				) as puntaje_junta
				FROM be_inscripcion_conv_beca AS insc
				LEFT JOIN sap_personas AS per ON per.nro_documento = insc.nro_documento
				LEFT JOIN sap_dependencia AS dep ON dep.id = insc.id_dependencia
				LEFT JOIN be_carreras AS carr ON carr.id_carrera = insc.id_carrera
				WHERE per.nro_documento = ".quote($inscripcion['nro_documento'])."
				AND insc.id_convocatoria = ".quote($inscripcion['id_convocatoria'])."
				AND insc.id_tipo_beca = ".quote($inscripcion['id_tipo_beca'])."
				AND insc.estado <> 'A'
				LIMIT 1";
		$detalles['postulante'] = toba::db()->consultar_fila($sql);

		/* ============================================================================================== */
		$sql = "SELECT insc.nro_carpeta, 
						conv.convocatoria, 
						tipbec.tipo_beca, 
						areacon.nombre AS area_conocimiento, 
						insc.titulo_plan_beca,
						insc.lugar_trabajo_becario AS lugar_trabajo_becario_id,
						lugtrab.nombre AS lugar_trabajo_becario,
						insc.area_trabajo,
						tipbec.requiere_insc_posgrado,
						tipbec.suma_puntaje_academico,
						tipbec.puntaje_academico_maximo
				FROM be_inscripcion_conv_beca AS insc
				LEFT JOIN be_convocatoria_beca AS conv ON conv.id_convocatoria = insc.id_convocatoria
				LEFT JOIN be_tipos_beca AS tipbec ON tipbec.id_tipo_beca = insc.id_tipo_beca
				LEFT JOIN sap_area_conocimiento AS areacon ON areacon.id = insc.id_area_conocimiento
				LEFT JOIN sap_dependencia AS lugtrab ON lugtrab.id = insc.lugar_trabajo_becario
				WHERE insc.nro_documento = ".quote($inscripcion['nro_documento'])."
				AND insc.id_convocatoria = ".quote($inscripcion['id_convocatoria'])."
				AND insc.id_tipo_beca = ".quote($inscripcion['id_tipo_beca'])."
				AND insc.estado <> 'A'
				LIMIT 1";
		$detalles['beca'] = toba::db()->consultar_fila($sql);
		/* ============================================================================================== */
		$sql = "SELECT cri.id_convocatoria,
						cri.id_tipo_beca,
						cri.id_criterio_evaluacion,
						cri.puntaje_maximo,
						cri.criterio_evaluacion
				FROM be_tipo_beca_criterio_eval AS cri
				WHERE id_convocatoria = ".quote($inscripcion['id_convocatoria'])."
				AND id_tipo_beca = ".quote($inscripcion['id_tipo_beca']);
		$detalles['criterios_eval'] = toba::db()->consultar($sql);



		/* ============================================================================================== */
		/*-------------- PROMEDIOS (SE OBTIENE DE LA VARIABLE $persona) ---------------------
		- promedio_hist_carrera
		- promedio_hist_alumno */

		$detalles['promedio'] = array('prom_hist_egresados' => $detalles['postulante']['prom_hist_egresados'],
										'prom_hist'         => $detalles['postulante']['prom_hist']);
		
		/* ============================================================================================== */
		$detalles['director'] = $this->get_detalles_director($inscripcion);

		/* ============================================================================================== */
		if($detalles['postulante']['nro_documento_codir']){
			$detalles['codirector'] = $this->get_detalles_director($inscripcion,'codir');	
		}

		/* ============================================================================================== */
		if($detalles['postulante']['nro_documento_subdir']){
			$detalles['subdirector'] = $this->get_detalles_director($inscripcion,'subdir');	
		}

		/* ============================================================================================== */
		$sql = "SELECT proy.descripcion AS proyecto,
						proy.codigo, 
						proy.nro_documento_dir AS nro_documento, 
						per.apellido, 
						per.nombres,
						proy.fecha_hasta
				FROM be_inscripcion_conv_beca AS insc
				LEFT JOIN sap_proyectos AS proy ON proy.id = insc.id_proyecto
				LEFT JOIN sap_personas AS per ON per.nro_documento = proy.nro_documento_dir
				WHERE insc.nro_documento = ".quote($inscripcion['nro_documento'])."
					AND insc.id_convocatoria = ".quote($inscripcion['id_convocatoria'])."
					AND insc.id_tipo_beca = ".quote($inscripcion['id_tipo_beca'])."
					AND insc.estado <> 'A'
					LIMIT 1";
		$detalles['proyecto'] = toba::db()->consultar_fila($sql);

		/* ============================================================================================== */
		return $detalles;

		
	}

	function get_detalles_director($inscripcion, $tipo = 'dir')
	{
		$sql = "SELECT 
					insc.nro_documento_".$tipo." AS nro_documento, 
					per.apellido, 
					per.nombres, 
					per.cuil, 
					coalesce(per.celular,'No declarado') as celular, 
					coalesce(per.telefono,'No declarado') as telefono,
					coalesce(per.mail,'No declarado') as mail,
					nivac.nivel_academico,
					coalesce(catcon.cat_conicet,'No declarado') as catconicet,
					coalesce(catconper.lugar_trabajo,'No declarado') as lugar_trabajo_conicet,
					catinc.categoria AS catinc,
					coalesce(catinc.convocatoria) AS catinc_conv
					FROM be_inscripcion_conv_beca AS insc
					LEFT JOIN sap_personas AS per ON per.nro_documento = insc.nro_documento_".$tipo."
					LEFT JOIN be_niveles_academicos AS nivac ON nivac.id_nivel_academico = per.id_nivel_academico
					LEFT JOIN be_cat_conicet_persona AS catconper ON catconper.nro_documento = per.nro_documento
					LEFT JOIN be_cat_conicet AS catcon ON catcon.id_cat_conicet = catconper.id_cat_conicet
					LEFT JOIN sap_cat_incentivos AS catinc ON catinc.nro_documento = per.nro_documento 
					                                      AND catinc.convocatoria  = (SELECT MAX(convocatoria) FROM sap_cat_incentivos WHERE nro_documento = per.nro_documento)
					WHERE insc.nro_documento = ".quote($inscripcion['nro_documento'])."
					AND insc.id_convocatoria = ".quote($inscripcion['id_convocatoria'])."
					AND insc.id_tipo_beca = ".quote($inscripcion['id_tipo_beca'])."
					AND insc.estado <> 'A'
					LIMIT 1";
		return toba::db()->consultar_fila($sql);

	}

	public function abrir_solicitud($filtro=array())
	{
		if(isset($filtro['nro_documento']) && isset($filtro['id_convocatoria']) && isset($filtro['id_tipo_beca'])){
			$sql = "UPDATE be_inscripcion_conv_beca SET estado = 'A'
					 WHERE nro_documento = ".quote($filtro['nro_documento'])." 
					 AND id_convocatoria = ".quote($filtro['id_convocatoria'])." 
					 AND id_tipo_beca = ".quote($filtro['id_tipo_beca']);	
			return toba::db()->ejecutar($sql);
		}else{
			return FALSE;
		}
	}

	function dirige_beca_otorgada($nro_documento)
	{
		$sql = "SELECT * FROM be_inscripcion_conv_beca 
				WHERE (nro_documento_dir = ".quote($nro_documento)." 
				OR nro_documento_codir = ".quote($nro_documento)." 
				OR nro_documento_subdir = ".quote($nro_documento).")
				AND beca_otorgada = 'S'";
		return count(toba::db()->consultar($sql));
	}

	/**
	 * Determina si una postulación (en base al tipo de beca) integra el orden de mérito. En el caso de las becas de PREGRADO, se divide por unidad académica y se cuentan los primeros diez. En el caso de Iniciación y Perfeccionamiento, se toman los primeros 10 puntajes
	 * @param  array $postulante Array con los datos del postulante (debe tener al menos los valores id_tipo_beca,id_convocatoria y nro_documento)
	 * @return boolean             
	 */
	function integra_orden_merito($postulante)
	{
		$filtro = array(
						'limite_resultados' => 10, 
						'id_convocatoria'   => $postulante['id_convocatoria'],
						'id_tipo_beca'      => $postulante['id_tipo_beca']
						);
		
		if($postulante['id_tipo_beca'] == 1){
			$filtro['id_dependencia'] = $postulante['id_dependencia'];
		}

		$orden = toba::consulta_php('co_junta_coordinadora')->get_orden_merito($filtro);

		return in_array($postulante['nro_documento'],array_column($orden, 'nro_documento'));
	}

	
}
?>