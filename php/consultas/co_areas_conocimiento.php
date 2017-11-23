<?php
class co_areas_conocimiento
{

	function get_areas_conocimiento()
	{
		$sql = "SELECT
			area.id_area_conocimiento,
			area.area_conocimiento,
			area.area_conocimiento_corto
		FROM
			area_conocimiento as area
		ORDER BY area_conocimiento";
		return toba::db('becas')->consultar($sql);
	}

	 function get_disciplinas_incluidas($id_area_conocimiento)
    {
    	$sql = "SELECT disciplinas_incluidas FROM area_conocimiento WHERE id_area_conocimiento = ".quote($id_area_conocimiento);
    	$resultado = toba::db()->consultar_fila($sql);
    	return count($resultado) ? $resultado['disciplinas_incluidas'] : '';
    }

}
?>