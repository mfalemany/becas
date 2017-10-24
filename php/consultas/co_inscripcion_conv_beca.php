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

	function get_detalles_director($id_convocatoria, $id_tipo_beca, $id_tipo_doc, $nro_documento)
	{
			$sql = "SELECT dir.id_tipo_doc as id_tipo_doc_dir,
						   td.tipo_doc,
						   dir.nro_documento as nro_documento_dir,
						   dir.apellido,
						   dir.nombres,
						   dir.cuil,
						   niv.nivel_academico,
						   cat_inc.categoria as cat_incentivos,
						   cat_con.categoria as cat_conicet
			FROM inscripcion_conv_beca AS insc
			LEFT JOIN docentes AS doc ON doc.nro_documento = insc.nro_documento_dir AND doc.id_tipo_doc = insc.id_tipo_doc_dir
			LEFT JOIN categorias_incentivos AS cat_inc ON cat_inc.id_cat_incentivos = doc.id_cat_incentivos
			LEFT JOIN categorias_conicet AS cat_con ON cat_con.id_cat_conicet = doc.id_cat_conicet
			LEFT JOIN personas AS dir ON dir.nro_documento = insc.nro_documento_dir AND dir.id_tipo_doc = insc.id_tipo_doc_dir 
			LEFT JOIN niveles_academicos AS niv ON niv.id_nivel_academico = dir.id_nivel_academico
			LEFT JOIN tipo_documento AS td ON td.id_tipo_doc = dir.id_tipo_doc
			WHERE insc.id_tipo_doc = ".quote($id_tipo_doc)."
			AND insc.nro_documento = ".quote($nro_documento)."
			AND insc.id_convocatoria = ".quote($id_convocatoria)."
			AND insc.id_tipo_beca = ".quote($id_tipo_beca);
			return toba::db('becas')->consultar_fila($sql);

	}

}
?>