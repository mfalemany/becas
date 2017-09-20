<?php
class co_dependencias
{

	function get_dependencias($filtro=array())
	{
		$where = array();
		if (isset($filtro['nombre'])) {
			$where[] = "t_d.nombre ILIKE ".quote("%{$filtro['nombre']}%");
		}
		if (isset($filtro['descripcion_corta'])) {
			$where[] = "t_d.descripcion_corta ILIKE ".quote("%{$filtro['descripcion_corta']}%");
		}
		if (isset($filtro['id_universidad'])) {
			$where[] = "t_d.id_universidad = ".quote($filtro['id_universidad']);
		}
		if (isset($filtro['id_dependencia'])) {
			$where[] = "t_d.id_dependencia = ".quote($filtro['id_dependencia']);
		}
		$sql = "SELECT
			t_d.id_dependencia,
			t_d.nombre,
			t_d.descripcion_corta,
			t_u.universidad as id_universidad_nombre
		FROM
			dependencias as t_d	LEFT OUTER JOIN universidades as t_u ON (t_d.id_universidad = t_u.id_universidad)
		ORDER BY nombre";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

	//retorna las dependencias que NO tiene asignada una determinada carrera
	function dep_disponibles_carrera($id_carrera = NULL)
	{
		$sql = "SELECT dep.id_dependencia
				FROM dependencias AS dep
				LEFT JOIN universidades AS uni ON uni.id_universidad = dep.id_universidad";
		if($id_carrera){
			$sql .= " WHERE NOT EXISTS (SELECT * 
									   FROM carrera_dependencia 
									   WHERE id_carrera = $id_carrera 
									   AND id_dependencia = dep.id_dependencia)";
		}
		return toba::db('becas')->consultar($sql);
	}

}
?>