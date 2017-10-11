<?php
class co_inscripcion_conv_beca
{

	function get_inscripciones($filtro=array())
	{
		$where = array();
		if (isset($filtro['id_dependencia'])) {
			$where[] = "id_dependencia = ".quote($filtro['id_dependencia']);
		}
		if (isset($filtro['nro_documento'])) {
			$where[] = "nro_documento ILIKE ".quote("%{$filtro['nro_documento']}%");
		}
		if (isset($filtro['id_tipo_doc'])) {
			$where[] = "id_tipo_doc = ".quote($filtro['id_tipo_doc']);
		}
		if (isset($filtro['id_convocatoria'])) {
			$where[] = "id_convocatoria = ".quote($filtro['id_convocatoria']);
		}
		if (isset($filtro['admisible'])) {
			$where[] = "admisible ILIKE ".quote("%{$filtro['admisible']}%");
		}
		if (isset($filtro['beca_otorgada'])) {
			$where[] = "beca_otorgada = ".quote($filtro['beca_otorgada']);
		}
		if (isset($filtro['id_area_conocimiento'])) {
			$where[] = "id_area_conocimiento = ".quote($filtro['id_area_conocimiento']);
		}
		if (isset($filtro['titulo_plan_beca'])) {
			$where[] = "titulo_plan_beca ILIKE ".quote("%{$filtro['titulo_plan_beca']}%");
		}
		if (isset($filtro['id_carrera'])) {
			$where[] = "id_carrera = ".quote($filtro['id_carrera']);
		}
		if (isset($filtro['nro_carpeta'])) {
			$where[] = "nro_carpeta ILIKE ".quote("%{$filtro['nro_carpeta']}%");
		}
		if (isset($filtro['estado'])) {
			$where[] = "estado ILIKE ".quote("%{$filtro['estado']}%");
		}
		if (isset($filtro['es_titular'])) {
			$where[] = "es_titular ILIKE ".quote("%{$filtro['es_titular']}%");
		}
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
			t_icb.es_titular
		FROM
			inscripcion_conv_beca as t_icb	LEFT OUTER JOIN dependencias as t_d ON (t_icb.id_dependencia = t_d.id_dependencia)
			LEFT OUTER JOIN area_conocimiento as t_ac ON (t_icb.id_area_conocimiento = t_ac.id_area_conocimiento)
			LEFT OUTER JOIN carreras as t_c ON (t_icb.id_carrera = t_c.id_carrera)
		ORDER BY admisible";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

	/**
	 * Retorna un conjunto de datos que son un resumen de una inscripcion puntual.
	 * @param  integer $id_convocatoria ID de la convocatoria
	 * @param  integer $id_tipo_doc     Tipo de documento del alumno
	 * @param  string $nro_documento    Número de Documento del alumno
	 * @return array                    Retorna un array conteniendo los datos de resumen de la inscripcion
	 */
	function get_resumen_insc($id_convocatoria,$id_tipo_doc,$nro_documento)
	{
		$sql = "select  insc.id_convocatoria, 
						insc.id_dependencia, 
						insc.id_area_conocimiento,
						insc.titulo_plan_beca,
						insc.id_tipo_doc,
						insc.nro_documento,
						dir.id_tipo_doc as id_tipo_doc_dir,
						dir.nro_documento as nro_documento_dir,
						codir.id_tipo_doc as id_tipo_doc_codir,
						codir.nro_documento as nro_documento_codir,
						subdir.id_tipo_doc as id_tipo_doc_subdir,
						subdir.nro_documento as nro_documento_subdir
					from inscripcion_conv_beca as insc
					left join direccion_beca as dir
							on dir.nro_documento = insc.nro_documento 
							and dir.id_tipo_doc = insc.id_tipo_doc
							and dir.id_convocatoria = insc.id_convocatoria
							and dir.tipo = 'D'
					left join direccion_beca as codir
							on codir.nro_documento = insc.nro_documento 
							and codir.id_tipo_doc = insc.id_tipo_doc
							and codir.id_convocatoria = insc.id_convocatoria
							and codir.tipo = 'C'
					left join direccion_beca as subdir
							on subdir.nro_documento = insc.nro_documento 
							and subdir.id_tipo_doc = insc.id_tipo_doc
							and subdir.id_convocatoria = insc.id_convocatoria
							and subdir.tipo = 'S'
					where insc.id_convocatoria = $id_convocatoria
					and insc.id_tipo_doc = $id_tipo_doc
					and insc.nro_documento = $nro_documento";

		return toba::db('becas')->consultar_fila($sql);
	}

}
?>