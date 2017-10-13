<?php

class co_tipos_convocatoria
{
	function get_tipos_convocatoria()
	{
		$sql = "SELECT id_tipo_convocatoria, tipo_convocatoria FROM tipos_convocatoria ORDER BY tipo_convocatoria";
		return toba::db()->consultar($sql);
	}

}

?>