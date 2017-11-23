<?php
class co_dedicaciones
{

	function get_dedicaciones()
	{
		$sql = "SELECT
			ded.dedicacion,
			ded.id_dedicacion
		FROM
			dedicacion as ded
		ORDER BY dedicacion";
		return toba::db('becas')->consultar($sql);
	}

}
?>