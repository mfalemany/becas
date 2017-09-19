<?php
class co_localidades
{

	function get_localidades($filtro=array())
	{
		$where = array();
		if (isset($filtro['localidad'])) {
			$where[] = "localidad ILIKE ".quote("%{$filtro['localidad']}%");
		}
		$sql = "SELECT
			loc.id_provincia,
			loc.id_pais,
			loc.id_localidad,
			loc.localidad,
			prov.provincia,
			pai.pais
		FROM
			localidades as loc
		LEFT JOIN provincias as prov on prov.id_provincia = loc.id_provincia 
									AND prov.id_pais = loc.id_pais
		LEFT JOIN paises as pai on pai.id_pais = loc.id_pais
		ORDER BY localidad";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

}
?>