<?php

class co_requisitos_insc
{
	function get_requisitos_insc($id_convocatoria,$id_tipo_beca,$nro_documento)
	{
		$sql = "SELECT 	req_con.id_requisito, 
				        req_con.requisito, 
				        case req_con.obligatorio when 'S' then 'SI' when 'N' then 'NO' end AS obligatorio, 
				        req_ins.cumplido, 
				        req_ins.fecha
				FROM requisitos_insc AS req_ins
				LEFT JOIN requisitos_convocatoria AS req_con on req_ins.id_requisito = req_con.id_requisito
				WHERE req_ins.nro_documento = ".quote($nro_documento)."
				AND req_ins.id_tipo_beca = ".quote($id_tipo_beca)."
				AND req_con.id_convocatoria = ".quote($id_convocatoria)."
				order by req_con.id_requisito";
		return toba::db()->consultar($sql);
	}

}

?>