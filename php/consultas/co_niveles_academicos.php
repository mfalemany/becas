<?php
class co_niveles_academicos
{

	function get_niveles_academicos()
	{
		$sql = "SELECT
			niv.id_nivel_academico,
			niv.nivel_academico,
			niv.orden
		FROM
			be_niveles_academicos as niv
		ORDER BY niv.orden ASC";
		return toba::db()->consultar($sql);
	}
}
?>