<?php
class co_categorias_conicet
{

	function get_categorias_conicet()
	{
		$sql = "SELECT
			cat.id_cat_conicet,
			cat.nro_categoria,
			cat.categoria
		FROM
			categorias_conicet as cat
		ORDER BY categoria";
		return toba::db('becas')->consultar($sql);
	}

}
?>