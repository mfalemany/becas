<?php
class co_color_carpeta
{
	function get_colores()
	{
		$sql = "SELECT
			t_cc.id_color,
			t_cc.color
		FROM
			be_color_carpeta as t_cc
		ORDER BY color";
		return toba::db()->consultar($sql);
	}


}
?>