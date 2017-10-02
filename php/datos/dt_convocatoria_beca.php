<?php
class dt_convocatoria_beca extends becas_datos_tabla
{
	function get_descripciones()
	{
		$sql = "SELECT id_convocatoria, color_carpeta FROM convocatoria_beca ORDER BY color_carpeta";
		return toba::db('becas')->consultar($sql);
	}

}

?>