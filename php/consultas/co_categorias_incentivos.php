<?php

class co_categorias_incentivos
{
	function get_categorias_incentivos($filtro = array())
	{
		$where = array();
		if(isset($filtro['nro_documento'])){
			$where[] = "nro_documento = ".quote($filtro['nro_documento']);
		}

		$sql = "SELECT convocatoria, nro_documento, cuil, categoria FROM sap_cat_incentivos;";
		if(count($where)){
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}

}

?>