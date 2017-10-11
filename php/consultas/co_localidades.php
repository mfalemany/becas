<?php
class co_localidades
{

	function get_localidades($filtro=array())
	{
		$where = array();
		if (isset($filtro['localidad'])) {
			$where[] = "localidad ILIKE ".quote("%{$filtro['localidad']}%");
		}
		if (isset($filtro['id_pais'])) {
			$where[] = "loc.id_pais = ".quote("%{$filtro['id_pais']}%");
		}
		if (isset($filtro['id_provincia'])) {
			$where[] = "loc.id_provincia = ".quote("%{$filtro['id_provincia']}%");
		}
		if (isset($filtro['codigo_postal'])) {
			$where[] = "loc.codigo_postal = ".quote("%{$filtro['codigo_postal']}%");
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

	function get_localidades_prov($id_pais,$id_provincia)
	{
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
		WHERE loc.id_pais = $id_pais AND loc.id_provincia = $id_provincia
		ORDER BY localidad";
		return toba::db('becas')->consultar($sql);
	}

}
?>