<?php
class co_antecedentes
{
	function get_antec_activ_docentes($filtro = array())
	{
		$where = array();
		if(isset($filtro['nro_documento'])){
			$where[] = "ant.nro_documento = ".quote($filtro['nro_documento']);
		}
		$sql = "SELECT * FROM be_antec_activ_docentes AS ant";
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	function get_campos($campos,$tabla,$condicion,$fila_unica=TRUE)
	{
		if(!is_array($campos) || count($campos) == 0 || strlen($tabla) == 0){
			return array();
		}
		$campos = implode(',',$campos);
		$sql = "SELECT $campos FROM $tabla WHERE $condicion";
		return ($fila_unica) ? toba::db()->consultar_fila($sql) : toba::db()->consultar($sql);
		
	}

}

?>