<?php 
class co_disciplinas
{
	function get_listado()
	{
		$sql = "SELECT
			t_d.id_disciplina,
			t_d.disciplina
		FROM
			disciplinas as t_d
		ORDER BY disciplina";
		return toba::db('becas')->consultar($sql);
	}

}
?>