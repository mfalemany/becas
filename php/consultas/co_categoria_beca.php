<?php
class co_categoria_beca
{

	function get_categorias_beca()
	{
		$sql = "SELECT
			cat.id_categoria,
			cat.categoria,
			cat.duracion_meses,
			cat.meses_present_avance
		FROM
			categoria_beca as cat
		ORDER BY categoria";
		return toba::db('becas')->consultar($sql);
	}

}
?>