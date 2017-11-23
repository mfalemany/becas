<?php
class co_dependencias
{

	function get_dependencias($filtro=array())
	{
		$where = array();
		if (isset($filtro['nombre'])) {
			$where[] = "dep.nombre ILIKE ".quote("%{$filtro['nombre']}%");
		}
		if (isset($filtro['descripcion_corta'])) {
			$where[] = "dep.descripcion_corta ILIKE ".quote("%{$filtro['descripcion_corta']}%");
		}
		if (isset($filtro['id_universidad'])) {
			$where[] = "dep.id_universidad = ".quote($filtro['id_universidad']);
		}
		if (isset($filtro['id_pais'])) {
			$where[] = "dep.id_pais = ".quote($filtro['id_pais']);
		}
		if (isset($filtro['id_localidad'])) {
			$where[] = "dep.id_localidad = ".quote($filtro['id_localidad']);
		}
		if (isset($filtro['id_provincia'])) {
			$where[] = "dep.id_provincia = ".quote($filtro['id_provincia']);
		}
		$sql = "SELECT
			dep.id_dependencia,
			dep.nombre,
			dep.descripcion_corta,
			uni.universidad as id_universidad_nombre,
			dep.id_localidad,
			loc.localidad,
			prov.provincia,
			pai.pais
		FROM dependencias AS dep
		LEFT JOIN universidades as uni ON dep.id_universidad = uni.id_universidad
		LEFT JOIN localidades as loc on loc.id_localidad = dep.id_localidad
		LEFT JOIN provincias as prov on prov.id_provincia = loc.id_provincia
		LEFT JOIN paises as pai on pai.id_pais = prov.id_pais
		ORDER BY nombre";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

	function get_univ_dependencias($id_universidad = NULL)
	{
		$sql = "SELECT dep.id_dependencia, uni.sigla||' - '||dep.nombre as nombre
				FROM dependencias AS dep
				LEFT JOIN universidades AS uni ON uni.id_universidad = dep.id_universidad";
		if($id_universidad){
			$sql .= " WHERE dep.id_universidad = $id_universidad";
		}
		$sql .=	" ORDER BY nombre";
		return toba::db('becas')->consultar($sql);

	}

}
?>