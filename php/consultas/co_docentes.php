<?php
class co_docentes
{

	function get_docentes($filtro=array())
	{
		$where = array();
		if (isset($filtro['id_tipo_doc'])) {
			$where[] = "doc.id_tipo_doc = ".quote("{$filtro['id_tipo_doc']}");
		}
		if (isset($filtro['nro_documento'])) {
			$where[] = "doc.nro_documento ILIKE ".quote("%{$filtro['nro_documento']}%");
		}
		if (isset($filtro['legajo'])) {
			$where[] = "doc.legajo ILIKE ".quote("%{$filtro['legajo']}%");
		}
		if (isset($filtro['id_cat_incentivos'])) {
			$where[] = "doc.id_cat_incentivos = ".quote($filtro['id_cat_incentivos']);
		}
		if (isset($filtro['apellido'])) {
			$where[] = "per.apellido ILIKE ".quote("%{$filtro['apellido']}%");
		}
		if (isset($filtro['nombres'])) {
			$where[] = "per.nombres ILIKE ".quote("%{$filtro['nombres']}%");
		}

		$sql = "SELECT
			doc.nro_documento,
			doc.id_tipo_doc,
			tip.tipo_doc,
			per.apellido||', '||per.nombres as docente,
			doc.legajo,
			cat.categoria as id_cat_incentivos_nombre,
			niv.nivel_academico
		FROM docentes as doc
		LEFT JOIN categorias_incentivos as cat ON (doc.id_cat_incentivos = cat.id_cat_incentivos)
		LEFT JOIN personas as per ON (per.id_tipo_doc = doc.id_tipo_doc AND per.nro_documento = doc.nro_documento)
		LEFT JOIN tipo_documento as tip ON tip.id_tipo_doc = doc.id_tipo_doc
		LEFT JOIN niveles_academicos as niv on niv.id_nivel_academico = per.id_nivel_academico
		ORDER BY nro_documento";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

	function get_cargos_docente($id_tipo_doc,$nro_documento,$solo_vigentes = FALSE)
	{
		$sql = "SELECT car_unne.cargo,
					   ded.dedicacion,
					   dep.nombre as dependencia,
					   car.fecha_desde,
					   car.fecha_hasta
				FROM cargos_docente AS car
				LEFT JOIN cargos_unne AS car_unne on car_unne.id_cargo_unne = car.id_cargo_unne
				LEFT JOIN dedicacion AS ded ON ded.id_dedicacion = car.id_dedicacion 
				LEFT JOIN dependencias AS dep ON dep.id_dependencia = car.id_dependencia
				WHERE car.id_tipo_doc = ".quote($id_tipo_doc)."
				AND car.nro_documento = ".quote($nro_documento);
				if($solo_vigentes){
					$sql .= " AND current_date BETWEEN car.fecha_desde AND car.fecha_hasta";
				}
				$sql .= " ORDER BY car.fecha_desde"; 
		return toba::db('becas')->consultar($sql);
	}



}
?>