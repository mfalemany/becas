<?php
class co_tipos_documento
{
	function get_tipos_documento()
	{
		$sql = "SELECT
			t_td.id_tipo_doc,
			t_td.tipo_doc
		FROM
			tipo_documento as t_td
		ORDER BY tipo_doc";
		return toba::db('becas')->consultar($sql);
	}

}
?>