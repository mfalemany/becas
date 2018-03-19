<?php
class co_categorias_incentivos
{

	function get_categorias_incentivos()
	{
		$sql = "SELECT
			t_ci.id_cat_incentivos,
			t_ci.cat_incentivos,
			t_ci.descripcion
		FROM
			cat_incentivos as t_ci
		ORDER BY cat_incentivos";
		return toba::db('becas')->consultar($sql);
	}

}
?>