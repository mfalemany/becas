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
		$sql = "SELECT
			dep.id,
			dep.nombre,
			dep.sigla_mapuche,
			dep.id_universidad
		FROM sap_dependencia AS dep
		ORDER BY nombre";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}

	function get_univ_dependencias($id_universidad = NULL)
	{
		$sql = "SELECT dep.id, (uni.sigla||' - '||dep.nombre) as nombre
				FROM sap_dependencia AS dep
				LEFT JOIN be_universidades AS uni ON uni.id_universidad = dep.id_universidad";
		if($id_universidad){
			$sql .= " WHERE dep.id_universidad = $id_universidad";
		}
		$sql .=	" ORDER BY nombre";
		return toba::db()->consultar($sql);

	}

}
?>