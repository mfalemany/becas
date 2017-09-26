<?php
class co_cargos
{

	function get_cargos()
	{
		$sql = "SELECT
			car.cargo,
			car.id_cargo_unne
		FROM
			cargos_unne as car
		ORDER BY cargo";
		return toba::db('becas')->consultar($sql);
	}

}
?>