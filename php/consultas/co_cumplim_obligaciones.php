<?php
class co_cumplim_obligaciones
{
	//Retorna todos los a�os distintos donde se registraron cumplimientos de obligaciones. Se usa para filtros
	function get_anios_cumplimientos()
	{
		return toba::db()->consultar('SELECT DISTINCT anio FROM be_cumplimiento_obligacion ORDER BY 1 DESC');

	}
	function get_becarios_vigentes($dir = NULL)
	{
		$sql = "SELECT per.nro_documento, 
					per.apellido||', '||per.nombres AS becario, 
					ins.id_dependencia, 
					ins.id_convocatoria,
					dep.nombre AS dependencia,
					ins.id_tipo_beca,
					tb.tipo_beca,
					ot.fecha_desde,
					ot.fecha_hasta
				FROM be_becas_otorgadas AS ot
				LEFT JOIN be_inscripcion_conv_beca AS ins 
					ON ins.nro_documento = ot.nro_documento
					AND ins.id_convocatoria = ot.id_convocatoria
					AND ins.id_tipo_beca = ot.id_tipo_beca
				LEFT JOIN sap_personas AS per ON per.nro_documento = ins.nro_documento
				LEFT JOIN sap_dependencia AS dep ON dep.id = ins.id_dependencia
				LEFT JOIN be_tipos_beca AS tb ON tb.id_tipo_beca = ins.id_tipo_beca ";
				if($dir){
					$sql .= "WHERE (ins.nro_documento_dir = ".quote($dir)." OR ins.nro_documento_codir = ".quote($dir)." OR ins.nro_documento_subdir = ".quote($dir).")";
				}
		return toba::db()->consultar($sql);
	}

	function get_cumplimientos_mes($filtro = array())
	{
		if( ! (isset($filtro['mes']) && isset($filtro['anio']))){
			throw new toba_error('Debe establecer un mes y a�o');
		}
		$where = array();

		$fecha_ref = sprintf('%s-%02d-01', $filtro['anio'], $filtro['mes']);

		$sql = "SELECT 
					conv.convocatoria,
					tb.tipo_beca,
					insc.nro_documento,
					per.apellido||', '||per.nombres as postulante,
					per.mail,
					insc.nro_documento_dir,
					dir.apellido||', '||dir.nombres as director,
					dir.mail AS mail_director,
					(co.fecha_cumplimiento IS NOT NULL) AS cumplido,
					co.fecha_cumplimiento,
					bo.fecha_desde,
					bo.fecha_hasta
				FROM be_becas_otorgadas AS bo 
				LEFT JOIN be_inscripcion_conv_beca AS insc 
					ON  insc.nro_documento   = bo.nro_documento
					AND insc.id_convocatoria = bo.id_convocatoria
					AND insc.id_tipo_beca    = bo.id_tipo_beca
				LEFT JOIN sap_personas AS per ON per.nro_documento = bo.nro_documento
				LEFT JOIN sap_personas AS dir ON dir.nro_documento = insc.nro_documento_dir
				LEFT JOIN be_convocatoria_beca AS conv ON conv.id_convocatoria = bo.id_convocatoria
				LEFT JOIN be_tipos_beca AS tb ON tb.id_tipo_beca = bo.id_tipo_beca
				LEFT JOIN be_cumplimiento_obligacion AS co 
					ON  co.nro_documento   = bo.nro_documento
					AND co.id_convocatoria = bo.id_convocatoria
					AND co.id_tipo_beca    = bo.id_tipo_beca
					AND co.mes = {$filtro['mes']}
					AND co.anio = {$filtro['anio']}
				WHERE " . quote($fecha_ref) . " BETWEEN bo.fecha_desde AND bo.fecha_hasta
				ORDER BY convocatoria, tipo_beca, postulante";

		if(isset($filtro['id_dependencia']) && $filtro['id_dependencia']){
			$where[] = "insc.id_dependencia = " . quote($filtro['id_dependencia']);
		}
		
		if(isset($filtro['estado_cumplimiento']) && $filtro['estado_cumplimiento']){
			if($filtro['estado_cumplimiento'] == 'C'){
				$where[] = 'co.fecha_cumplimiento IS NOT NULL';
			}
			if($filtro['estado_cumplimiento'] == 'N'){
				$where[] = 'co.fecha_cumplimiento IS NULL';
			}
		}
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	function get_cumplimientos_becario($nro_documento,$id_convocatoria,$id_tipo_beca){
		$sql = "SELECT *,
					CASE mes 
						WHEN '01' THEN 'Enero'
						WHEN '02' THEN 'Febrero'
						WHEN '03' THEN 'Marzo'
						WHEN '04' THEN 'Abril'
						WHEN '05' THEN 'Mayo'
						WHEN '06' THEN 'Junio'
						WHEN '07' THEN 'Julio'
						WHEN '08' THEN 'Agosto'
						WHEN '09' THEN 'Septiembre'
						WHEN '10' THEN 'Octubre'
						WHEN '11' THEN 'Noviembre'
						WHEN '12' THEN 'Diciembre'
					END AS mes_desc
				FROM be_cumplimiento_obligacion
				WHERE nro_documento = ".quote($nro_documento)."
				AND id_convocatoria = ".quote($id_convocatoria)."
				AND id_tipo_beca = ".quote($id_tipo_beca)."
				ORDER BY anio DESC, mes DESC";
		return toba::db()->consultar($sql);
	}

	function get_duracion_meses_beca($inscripcion)
	{
		$sql = "SELECT 
					--Extraigo la cantidad de a�os de la beca, y lo multiplico por 12 (para pasarlo a meses)
					(EXTRACT(YEAR FROM AGE(fecha_hasta,fecha_desde))*12) +
					--y le sumo los meses restantes
					(EXTRACT(MONTH FROM AGE(fecha_hasta,fecha_desde))) AS duracion
				FROM be_becas_otorgadas AS bo
				WHERE bo.id_convocatoria = ".quote($inscripcion['id_convocatoria'])."
				AND bo.id_tipo_beca = ".quote($inscripcion['id_tipo_beca'])."
				AND bo.nro_documento = ".quote($inscripcion['nro_documento']);
		$res = toba::db()->consultar_fila($sql);
		return $res['duracion'];

	}
	

	function mes_cumplido($beca,$mes,$anio)
	{
		$sql = "SELECT * 
				FROM be_cumplimiento_obligacion
				WHERE nro_documento = ".quote($beca['nro_documento'])."
				AND id_tipo_beca = ".quote($beca['id_tipo_beca'])."
				AND id_convocatoria = ".quote($beca['id_convocatoria'])."
				AND mes = $mes
				AND anio = $anio";
		return count(toba::db()->consultar($sql));
	}

	function marcar_cumplido($cumplido)
	{
		$sql = "INSERT INTO be_cumplimiento_obligacion (nro_documento,id_convocatoria,id_tipo_beca,mes,anio,fecha_cumplimiento) 
			VALUES (".
				quote($cumplido['nro_documento']).",".
				quote($cumplido['id_convocatoria']).",".
				quote($cumplido['id_tipo_beca']).",".
				quote($cumplido['mes']).",".
				quote($cumplido['anio']).",".
				quote(date('Y-m-d')).")";
		return toba::db()->ejecutar($sql);

	}



}
?>