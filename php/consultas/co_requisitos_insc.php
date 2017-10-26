<?php

class co_requisitos_insc
{
	function get_requisitos_insc($id_convocatoria,$id_tipo_doc,$nro_documento)
	{
		$sql = "SELECT req_con.id_requisito, 
				        req_con.requisito, 
				        case req_con.obligatorio when 'S' then 'SI' when 'N' then 'NO' end AS obligatorio, 
				        req_ins.cumplido, 
				        req_ins.fecha
				FROM requisitos_convocatoria AS req_con
				LEFT JOIN requisitos_insc AS req_ins on req_ins.id_requisito = req_con.id_requisito
				                                        AND req_ins.id_tipo_doc = ".quote($id_tipo_doc)."
				                                        AND req_ins.nro_documento = ".quote($nro_documento)."
				WHERE req_con.id_convocatoria = ".quote($id_convocatoria)."
				order by req_con.id_requisito";
		return toba::db()->consultar($sql);
	}

}

?>