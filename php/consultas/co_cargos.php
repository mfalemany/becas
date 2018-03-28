<?php 
class co_cargos{
	function get_descripciones($filtro=array())
	{
		$sql = "SELECT cargo, descripcion FROM sap_cargos_descripcion WHERE activo = 'S'";
		return toba::db()->consultar($sql);
	}
}
?>
