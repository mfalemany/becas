<?php
class co_areas_conocimiento
{

	function get_areas_conocimiento()
	{
		$sql = "SELECT id, area_conocimiento, area_conocimiento_corto,disciplinas_incluidas
				FROM sap_area_conocimiento";
		return toba::db()->consultar($sql);
	}


	 function get_disciplinas_incluidas($id_area_conocimiento)
    {
    	$sql = "SELECT disciplinas_incluidas FROM sap_area_conocimiento WHERE id = ".quote($id_area_conocimiento);
    	$resultado = toba::db()->consultar_fila($sql);
    	return count($resultado) ? $resultado['disciplinas_incluidas'] : '';
    }

}
?>