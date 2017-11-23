<?php
class co_areas_dependencia
{

	function get_areas_dependencia($filtro=array())
	{
		$where = array();
		if (isset($filtro['area'])) {
			$where[] = "are.area ILIKE ".quote("%{$filtro['area']}%");
		}
		if (isset($filtro['id_dependencia'])) {
			$where[] = "are.id_dependencia = ".quote($filtro['id_dependencia']);
		}
		$sql = "SELECT
			are.id_area,
			are.area,
			dep.nombre as id_dependencia_nombre
		FROM
			areas_dependencia as are LEFT OUTER JOIN dependencias as dep ON (are.id_dependencia = dep.id_dependencia)
		ORDER BY are.area";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

}
?>