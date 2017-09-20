<?php
class co_carreras
{

	function get_carreras($filtro=array())
	{
		$where = array();
		if (isset($filtro['carrera'])) {
			$where[] = "carrera ILIKE ".quote("%{$filtro['carrera']}%");
		}
		$sql = "SELECT
			t_c.id_carrera,
			t_c.carrera,
			t_c.cod_araucano
		FROM
			carreras as t_c
		ORDER BY carrera";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

}
?>