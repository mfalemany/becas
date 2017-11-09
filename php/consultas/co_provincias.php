<?php
class co_provincias
{
	function get_provincias_pais($id_pais)
	{
		$sql = "SELECT
			prov.id_pais,
			prov.id_provincia,
			prov.provincia,
			pai.pais
		FROM provincias as prov
		LEFT JOIN paises as pai ON prov.id_pais = pai.id_pais
		WHERE prov.id_pais = $id_pais
		ORDER BY prov.provincia, pai.pais";

		return toba::db('becas')->consultar($sql);
	}

	function get_provincias($filtro=array())
	{

		//$archivo = fopen('pepe.txt','w+');
		//fwrite($archivo, $id_pais);
		$where = array();
		if (isset($filtro['provincia'])) {
			$where[] = "prov.provincia ILIKE ".quote("%{$filtro['provincia']}%");
		}
		if (isset($filtro['id_provincia'])) {
			$where[] = "prov.id_provincia = ".quote("%{$filtro['id_provincia']}%");
		}
		if (isset($filtro['id_pais'])) {
			$where[] = "prov.id_pais = ".quote("{$filtro['id_pais']}");
		}
		$sql = "SELECT
			prov.id_pais,
			prov.id_provincia,
			prov.provincia,
			pai.pais
		FROM provincias as prov
		LEFT JOIN paises as pai ON prov.id_pais = pai.id_pais
		ORDER BY pai.pais,prov.provincia";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

}
?>