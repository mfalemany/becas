<?php
class co_dependencias
{

	function get_dependencias($filtro=array())
	{
		$where = array();
		if (isset($filtro['nombre'])) {
			$where[] = "nombre ILIKE ".quote("%{$filtro['nombre']}%");
		}
		if (isset($filtro['id_universidad'])) {
			$where[] = "dep.id_universidad = ".quote($filtro['id_universidad']);
		}
		$sql = "SELECT
			dep.id,
			dep.nombre,
			dep.descripcion,
			dep.sigla_mapuche,
			uni.universidad as id_universidad
		FROM
			sap_dependencia as dep	
		LEFT JOIN be_universidades AS uni ON dep.id_universidad = uni.id_universidad
		ORDER BY dep.nombre";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}


	function get_univ_dependencias($id_universidad = NULL)
	{
		$sql = "SELECT dep.id, (coalesce(uni.sigla,'Otra'))||' - '||dep.nombre as nombre
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