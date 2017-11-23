<?php
class co_categorias_incentivos
{

	function get_categorias_incentivos()
	{
		$sql = "SELECT
			t_ci.id_cat_incentivos,
			t_ci.nro_categoria,
			t_ci.categoria
		FROM
			categorias_incentivos as t_ci
		ORDER BY categoria";
		return toba::db('becas')->consultar($sql);
	}

}
?>