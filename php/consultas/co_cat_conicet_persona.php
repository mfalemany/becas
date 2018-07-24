<?php

class co_cat_conicet_persona
{
	function get_categoria_persona($nro_documento)
	{
		$sql = "SELECT nro_documento, id_cat_conicet, lugar_trabajo FROM be_cat_conicet_persona WHERE nro_documento = ".quote($nro_documento);
		return toba::db()->consultar_fila($sql);
	}
}

?>