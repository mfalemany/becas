<?php
class dt_area_conocimiento extends becas_datos_tabla
{
	function get_descripciones()
	{
		$sql = "SELECT id_area_conocimiento, area_conocimiento FROM area_conocimiento ORDER BY area_conocimiento";
		return toba::db('becas')->consultar($sql);
	}

}

?>