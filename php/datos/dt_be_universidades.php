<?php
class dt_be_universidades extends becas_datos_tabla
{
		function get_descripciones()
		{
			$sql = "SELECT id_universidad, universidad FROM be_universidades ORDER BY universidad";
			return toba::db('sap')->consultar($sql);
		}



	function get_descripciones()
	{
		$sql = "SELECT id_universidad, universidad FROM be_universidades ORDER BY universidad";
		return toba::db('sap')->consultar($sql);
	}

}
?>