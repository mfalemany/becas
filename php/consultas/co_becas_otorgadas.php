<?php

class co_becas_otorgadas
{
	function get_becas_otorgadas($filtro = array())
	{
		$where = array();
		$sql = "SELECT 
			insc.nro_documento,
			insc.id_convocatoria,
			insc.id_tipo_beca,
			per.apellido||', '||per.nombres AS postulante,
			conv.convocatoria,
			tb.tipo_beca,
			dep.nombre AS dependencia
		FROM be_becas_otorgadas AS oto
		LEFT JOIN be_inscripcion_conv_beca AS insc USING (id_convocatoria, id_tipo_beca, nro_documento)
		LEFT JOIN sap_dependencia AS dep ON dep.id = insc.id_dependencia
		LEFT JOIN sap_personas AS per ON per.nro_documento = insc.nro_documento
		LEFT JOIN be_convocatoria_beca AS conv ON conv.id_convocatoria = insc.id_convocatoria
		LEFT JOIN be_tipos_beca AS tb ON tb.id_tipo_beca = insc.id_tipo_beca
		ORDER BY per.apellido, per.nombres";
		if(isset($filtro['id_convocatoria']) && $filtro['id_convocatoria']){
			$where[] = "conv.id_convocatoria = ".quote($filtro['id_convocatoria']);
		}
		if(isset($filtro['id_tipo_beca']) && $filtro['id_tipo_beca']){
			$where[] = "tb.id_tipo_beca = ".quote($filtro['id_tipo_beca']);
		}
		if(isset($filtro['id_dependencia']) && $filtro['id_dependencia']){
			$where[] = "dep.id = ".quote($filtro['id_dependencia']);
		}
		if(isset($filtro['dnis_postulantes']) && $filtro['dnis_postulantes']){
			$dnis = implode(',',array_map('quote',explode(',',$filtro['dnis_postulantes'])));
			$where[] = "per.nro_documento in ($dnis)";
		}
		if(count($where)){
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}

	function actualizar_campos($registros,$valores)
	{
		$consultas = array();

		foreach($registros as $registro){	
			$set = array();
			foreach ($valores as $campo => $valor) {
				if($valor){
					$set[] = $campo . " = " . quote($valor); 
				}
			}
			$set = implode(',',$set);
			$sql = "UPDATE be_becas_otorgadas 
					SET $set 
					WHERE id_convocatoria = " . quote($registro['id_convocatoria']) ."
					AND id_tipo_beca      = " . quote($registro['id_tipo_beca']) ."
					AND nro_documento     = " . quote($registro['nro_documento']);
			$consultas[] = $sql;
		}

		try {
			toba::db()->abrir_transaccion();
			foreach ($consultas as $consulta) {
				toba::db()->ejecutar($consulta);
			}
			toba::db()->cerrar_transaccion();
			return TRUE;
		} catch (toba_error_db $e) {
			return $e->get_mensaje();
		}
		
	}
}

?>