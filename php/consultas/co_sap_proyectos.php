<?php 
class co_sap_proyectos
{
	function get_proyectos($patron)
	{
		$sql = "SELECT id, descripcion FROM sap_proyectos WHERE descripcion ILIKE ".quote("%".$patron."%");
		return toba::db()->consultar($sql);
	}

	function get_descripcion($id)
	{
		$sql = "SELECT descripcion FROM sap_proyectos WHERE id = ".quote($id);
		$resultado = toba::db()->consultar_fila($sql);
		return $resultado['descripcion'];
	}
}
?>