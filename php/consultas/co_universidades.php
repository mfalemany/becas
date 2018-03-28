<?php
class co_universidades
{

	function get_universidades($filtro=array())
	{
		$where = array();
		if (isset($filtro['universidad'])) {
			$where[] = "universidad ILIKE ".quote("%{$filtro['universidad']}%");
		}
		if (isset($filtro['id_pais'])) {
			$where[] = "t_u.id_pais = ".quote($filtro['id_pais']);
		}
		$sql = "SELECT
			t_u.id_universidad,
			t_u.universidad,
			t_u.sigla,
			t_p.pais as id_pais_nombre
		FROM
			be_universidades as t_u	LEFT OUTER JOIN be_paises as t_p ON (t_u.id_pais = t_p.id_pais)
		ORDER BY universidad";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}
	function get_descripciones()
	{
		$sql = "SELECT id_universidad, universidad FROM be_universidades ORDER BY universidad";
		return toba::db()->consultar($sql);
	}

}
?>