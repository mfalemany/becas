<?php
class co_tipos_beca
{

	function get_tipos_beca()
	{
		$sql = "SELECT
			tip.id_tipo_beca,
			tip_con.tipo_convocatoria,
			tip.tipo_beca,
			tip.cupo_maximo,
			tip.id_color,
			col.color
		FROM tipos_beca as tip	
		LEFT JOIN tipos_convocatoria as tip_con ON tip.id_tipo_convocatoria = tip_con.id_tipo_convocatoria
		LEFT JOIN color_carpeta as col on col.id_color = tip.id_color
		ORDER BY tipo_beca";
		return toba::db('becas')->consultar($sql);
	}


}
?>