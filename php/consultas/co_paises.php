<?php
class co_paises
{

	function get_paises($filtro=array())
	{
		$where = array();
		if (isset($filtro['pais'])) {
			$where[] = "pais ILIKE ".quote("%{$filtro['pais']}%");
		}
		if (isset($filtro['id_pais'])) {
			$where[] = "pai.id_pais = ".quote("%{$filtro['id_pais']}%");
		}
		$sql = "SELECT
			pai.id_pais,
			pai.pais
		FROM
			paises as pai
		ORDER BY pai.pais";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

}
?>