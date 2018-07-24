<?php

class co_cat_incentivos_personas
{
	function get_categorias_incentivos_personas($filtro = array())
	{
		$where = array();
		if(isset($filtro['nro_documento'])){
			$where[] = "nro_documento = ".quote($filtro['nro_documento']);
		}

		$sql = "SELECT cat_per.convocatoria, cat_per.nro_documento, cat_per.cuil, cat_per.categoria 
				FROM sap_cat_incentivos_personas as cat_per
				LEFT JOIN sap_cat_incentivos as cat_inc ON cat_inc.;";
		if(count($where)){
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}

}

?>