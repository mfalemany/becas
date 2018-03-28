<?php

class co_requisitos_convocatoria
{
	function get_requisitos_iniciales($id_convocatoria)
	{
		$sql = "SELECT 	id_requisito, 
						id_convocatoria,
						'N' as cumplido,
						null as fecha 
				FROM be_requisitos_convocatoria 
				WHERE id_convocatoria = ".quote($id_convocatoria);
		return toba::db()->consultar($sql);
	}

}

?>