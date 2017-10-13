<?php
class co_inscripcion_conv_beca
{

	function get_inscripciones()
	{
		$sql = "SELECT
			t_d.nombre as id_dependencia_nombre,
			t_icb.nro_documento,
			t_icb.id_tipo_doc,
			t_icb.id_convocatoria,
			t_icb.fecha_hora,
			t_icb.admisible,
			t_icb.puntaje,
			t_icb.beca_otorgada,
			t_ac.area_conocimiento as id_area_conocimiento_nombre,
			t_icb.titulo_plan_beca,
			t_icb.justif_codirector,
			t_c.carrera as id_carrera_nombre,
			t_icb.materias_plan,
			t_icb.materias_aprobadas,
			t_icb.prom_hist_egresados,
			t_icb.prom_hist,
			t_icb.carrera_posgrado,
			t_icb.nombre_inst_posgrado,
			t_icb.titulo_carrera_posgrado,
			t_icb.nro_carpeta,
			t_icb.observaciones,
			t_icb.estado,
			t_icb.cant_fojas,
			t_icb.es_titular,
			t_icb.id_tipo_beca
		FROM
			inscripcion_conv_beca as t_icb	LEFT OUTER JOIN dependencias as t_d ON (t_icb.id_dependencia = t_d.id_dependencia)
			LEFT OUTER JOIN area_conocimiento as t_ac ON (t_icb.id_area_conocimiento = t_ac.id_area_conocimiento)
			LEFT OUTER JOIN carreras as t_c ON (t_icb.id_carrera = t_c.id_carrera)
		ORDER BY admisible";
		return toba::db('becas')->consultar($sql);
	}

}
?>