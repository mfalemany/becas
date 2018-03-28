
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
			$where[] = "pai.id_pais = ".quote("%{$filtro['id_pais']}%");
		}
		if (isset($filtro['id_provincia'])) {
			$where[] = "pai.id_provincia = ".quote("%{$filtro['id_provincia']}%");
		}
		if (isset($filtro['codigo_postal'])) {
			$where[] = "loc.codigo_postal = ".quote("%{$filtro['codigo_postal']}%");
		}
		$sql = "SELECT
			pai.id_pais,
			pai.pais,
			prov.id_provincia,
			prov.provincia,
			loc.id_localidad,
			loc.localidad
		FROM
			be_localidades AS loc
		LEFT JOIN be_provincias AS prov on prov.id_provincia = loc.id_provincia 
		LEFT JOIN be_paises AS pai on pai.id_pais = prov.id_pais
		ORDER BY localidad";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}


	function get_localidades_prov($id_pais,$id_provincia)
	{
		$sql = "SELECT
			loc.id_provincia,
			prov.id_pais,
			loc.id_localidad,
			loc.localidad,
			prov.provincia,
			pai.pais
		FROM
			be_localidades as loc
		LEFT JOIN be_provincias as prov on prov.id_provincia = loc.id_provincia 
		LEFT JOIN be_paises as pai on pai.id_pais = prov.id_pais
		WHERE prov.id_pais = $id_pais AND prov.id_provincia = $id_provincia
		ORDER BY localidad";
		return toba::db()->consultar($sql);
	}

	function buscar_localidad($patron)
	{
		$sql = "SELECT id_localidad, 
						loc.localidad||' - '||prov.provincia||' - '||pai.pais AS localidad 
				FROM be_localidades as loc
				LEFT JOIN be_provincias as prov on prov.id_provincia = loc.id_provincia
				LEFT JOIN be_paises as pai ON pai.id_pais = prov.id_pais
				WHERE localidad ilike ".quote('%'.$patron.'%');
		return toba::db()->consultar($sql);
	}

	function get_localidad_provincia_pais($id_localidad)
	{
		$sql = "SELECT loc.localidad||' - '||prov.provincia||' - '||pai.pais as localidad
				FROM be_localidades as loc
				LEFT JOIN be_provincias as prov on prov.id_provincia = loc.id_provincia
				LEFT JOIN be_paises as pai ON pai.id_pais = prov.id_pais
				WHERE loc.id_localidad = ".quote($id_localidad);
		$resultado = toba::db()->consultar_fila($sql);
		return $resultado['localidad'];
	}

}
?>