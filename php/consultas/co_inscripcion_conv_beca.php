<?php
class co_inscripcion_conv_beca
{

	function get_inscripciones()
	{
		$sql = "SELECT
			insc.id_dependencia,
			dep.nombre as dependencia,
			insc.id_tipo_beca,
			tip_bec.tipo_beca,
			insc.nro_documento,
			becario.apellido||', '||becario.nombres as becario,
			director.apellido||', '||director.nombres as director,
			insc.id_tipo_doc,
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
			
		FROM inscripcion_conv_beca as insc	
		LEFT JOIN convocatoria_beca as conv on conv.id_convocatoria = insc.id_convocatoria
		LEFT JOIN personas as becario on becario.id_tipo_doc = insc.id_tipo_doc AND becario.nro_documento = insc.nro_documento
		LEFT JOIN personas as director 
			ON director.id_tipo_doc = insc.id_tipo_doc_dir
			AND director.nro_documento = insc.nro_documento_dir
		LEFT JOIN tipos_beca as tip_bec on tip_bec.id_tipo_beca = insc.id_tipo_beca
		LEFT JOIN dependencias as dep ON (insc.id_dependencia = dep.id_dependencia)
		LEFT JOIN area_conocimiento as area ON (insc.id_area_conocimiento = area.id_area_conocimiento)
		LEFT JOIN carreras as carr ON (insc.id_carrera = carr.id_carrera)
		ORDER BY admisible";
		return toba::db('becas')->consultar($sql);
	}

	function get_resumen_insc($id_convocatoria, $id_tipo_beca, $id_tipo_doc, $nro_documento)
	{
			$sql = "select doc.id_cat_incentivos,doc.id_cat_conicet,carunne.cargo,ded.dedicacion,car.fecha_desde,car.fecha_hasta
			from inscripcion_conv_beca as insc
			left join docentes as doc on doc.id_tipo_doc = insc.id_tipo_doc and doc.nro_documento = insc.nro_documento
			left join cargos_docente as car on car.id_tipo_doc = doc.id_tipo_doc and car.nro_documento = doc.nro_documento
			left join cargos_unne as carunne on carunne.id_cargo_unne = car.id_cargo_unne
			left join dedicacion as ded on ded.id_dedicacion = car.id_dedicacion
			where insc.id_tipo_doc = ".quote($id_tipo_doc)."
			and insc.nro_documento = ".quote($nro_documento)."
			and insc.id_convocatoria = ".quote($id_convocatoria)."
			and insc.id_tipo_beca = ".quote($id_tipo_beca)."
			and current_date between car.fecha_desde and car.fecha_hasta";
		return toba::db('becas')->consultar($sql);

	}

}
?>