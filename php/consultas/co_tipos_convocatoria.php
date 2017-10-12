<?php
class co_tipos_convocatoria
{

	function get_tipos_convocatoria()
	{
		$sql = "SELECT
			t_tc.id_tipo_convocatoria,
			t_tc.tipo_convocatoria
		FROM
			tipos_convocatoria as t_tc
		ORDER BY tipo_convocatoria";
		return toba::db('becas')->consultar($sql);
	}

}
?>