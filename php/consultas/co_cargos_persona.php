<?php 
class co_cargos_persona{
	function get_cargos_persona($nro_documento,$solo_vigentes=false)
	{
		$sql = "SELECT *
				FROM sap_cargos_persona as carper 
				LEFT JOIN sap_cargos_descripcion as cardes ON cardes.cargo = carper.cargo
				WHERE carper.nro_documento = ".quote($nro_documento);
		if($solo_vigentes){
			$sql .= " and current_date between carper.fecha_desde and carper.fecha_hasta";
		}
		return toba::db()->consultar($sql);
	}
}
?>