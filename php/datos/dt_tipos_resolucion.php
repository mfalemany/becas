<?php
class dt_tipos_resolucion extends becas_datos_tabla
{
	function get_descripciones()
	{
		$sql = "SELECT id_tipo_resol, tipo_resol FROM tipos_resolucion ORDER BY tipo_resol";
		return toba::db('becas')->consultar($sql);
	}
}
?>