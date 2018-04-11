<?php 
class co_cargos_persona{
	function get_cargos_persona($nro_documento,$solo_vigentes=false)
	{
		$sql = "SELECT * FROM sap_cargos_persona WHERE nro_documento = ".quote($nro_documento);
		if($solo_vigentes){
			$sql .= " and current_date between fecha_desde and fecha_hasta";
		}
		return toba::db()->consultar($sql);
	}
}
?>