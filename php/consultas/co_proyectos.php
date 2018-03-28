<?php

class co_proyectos
{

	function get_proyectos($filtro)
	{
		$filtro = quote("%{$filtro}%");
		$sql = "SELECT id_proyecto, proyecto FROMsap_proyectos AS proy WHERE proyecto ILIKE $filtro LIMIT 20";
		return toba::db()->consultar($sql);
	}

	function get_proyecto_busqueda($id_proyecto)
	{
		$id_proyecto = quote("{$id_proyecto}");
		$sql = "SELECT sap_proyecto FROM proyectos WHERE id_proyecto = $id_proyecto";
		//$sql = "SELECT id_proyecto FROM proyectos AS proy WHERE proy.proyecto ILIKE '%".quote($criterio)."%'";
		$resultado = toba::db()->consultar_fila($sql);
		return $resultado['proyecto'] ? $resultado['proyecto'] : array();
	}

}

?>