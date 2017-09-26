<?php
class co_tipos_cumpl_oblig
{

	function get_tipos_cumplimiento()
	{
		$sql = "SELECT
			tip.id_tipo_cumpl_oblig,
			tip.tipo_cumpl_oblig
		FROM
			tipo_cumpl_obligacion as tip
		ORDER BY tipo_cumpl_oblig";
		return toba::db('becas')->consultar($sql);
	}

}
?>