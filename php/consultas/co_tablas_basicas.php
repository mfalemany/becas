<?php 
class co_tablas_basicas{
	function get_parametro_conf($parametro)
	{
		$sql = "SELECT valor AS parametro FROM sap_configuraciones WHERE parametro = ".quote($parametro);
		$resultado = toba::db()->consultar_fila($sql);
		return (count($resultado)) ? $resultado['parametro'] : FALSE;
	}
	
}
?>