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

}
?>