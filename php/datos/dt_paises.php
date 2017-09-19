<?php
class dt_paises extends becas_datos_tabla
{
	function get_descripciones()
	{
		$sql = "SELECT id_pais, pais FROM paises ORDER BY pais";
		return toba::db('becas')->consultar($sql);
	}

}

?>