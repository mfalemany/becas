<?php
class co_categoria_beca
{

	function get_categorias_beca()
	{
		$sql = "SELECT
			cat.id_categoria,
			cat.categoria
		FROM
			categoria_beca as cat
		ORDER BY categoria";
		return toba::db('becas')->consultar($sql);
	}

}
?>