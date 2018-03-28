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
			area.area_conocimiento as area_conocimiento,
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
		LEFT JOIN be_area_conocimiento as area ON (insc.id_area_conocimiento = area.id_area_conocimiento)
		LEFT JOIN be_carreras as carr ON (insc.id_carrera = carr.id_carrera)
		ORDER BY admisible";
		if(count($where)){
			$sql = sql_concatenar_where($sql, $where);
		}
		//echo nl2br($sql);
		return toba::db()->consultar($sql);
	}

	function get_ultimo_nro_carpeta($id_convocatoria,$id_tipo_beca)
	{
		$sql = "SELECT nro_carpeta 
				FROM be_inscripcion_conv_beca
				WHERE id_convocatoria = ".quote($id_convocatoria)."
				AND id_tipo_beca = ".quote($id_tipo_beca)."
				ORDER BY fecha_hora DESC
				LIMIT 1";
		$resultado = toba::db()->consultar_fila($sql);
		return ($resultado['nro_carpeta']) ? $resultado['nro_carpeta'] : FALSE;
	}

	

	

}
?>