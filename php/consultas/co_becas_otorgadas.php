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
			oto.fecha_desde,
			oto.fecha_hasta,
			oto.fecha_toma_posesion,
			oto.nro_resol,
			per.nro_documento,
			per.apellido||', '||per.nombres AS postulante,
			insc.nro_documento_dir,
			dir.apellido||', '||dir.nombres AS director,
			codir.apellido||', '||codir.nombres AS codirector,
			conv.convocatoria,
			tb.tipo_beca,
			dep.nombre AS dependencia
		FROM be_becas_otorgadas AS oto
		LEFT JOIN be_inscripcion_conv_beca AS insc USING (id_convocatoria, id_tipo_beca, nro_documento)
		LEFT JOIN sap_dependencia AS dep ON dep.id = insc.id_dependencia
		LEFT JOIN sap_personas AS per ON per.nro_documento = insc.nro_documento
		LEFT JOIN sap_personas AS dir ON dir.nro_documento = insc.nro_documento_dir
		LEFT JOIN sap_personas AS codir ON codir.nro_documento = insc.nro_documento_codir
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
		if(isset($filtro['solo_vigentes']) && $filtro['solo_vigentes']){
			$where[] = "current_date BETWEEN oto.fecha_desde AND oto.fecha_hasta";
		}
		if(isset($filtro['id_area_conocimiento']) && $filtro['id_area_conocimiento']){
			$where[] = "insc.id_area_conocimiento = " . quote($filtro['id_area_conocimiento']);
		}
		if(isset($filtro['dnis_postulantes']) && $filtro['dnis_postulantes']){
			$dnis = implode(',',array_map('quote',explode(',',$filtro['dnis_postulantes'])));
			$where[] = "per.nro_documento in ($dnis)";
		}
		if(isset($filtro['becario']) && $filtro['becario']){
			$where[] = "per.apellido       ILIKE quitar_acentos(" .quote('%'.$filtro['becario'].'%'). ")
					 OR per.nombres        ILIKE quitar_acentos(" .quote('%'.$filtro['becario'].'%'). ")
					 OR per.nro_documento  ILIKE quitar_acentos(" .quote('%'.$filtro['becario'].'%'). ")";
		}
		if(isset($filtro['director']) && $filtro['director']){
			$where[] = "dir.apellido       ILIKE quitar_acentos(" .quote('%'.$filtro['director'].'%'). ")
					 OR dir.nombres        ILIKE quitar_acentos(" .quote('%'.$filtro['director'].'%'). ")
					 OR dir.nro_documento  ILIKE quitar_acentos(" .quote('%'.$filtro['director'].'%'). ")";
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

	function registrar_recibo($detalles)
	{
		if( ! (isset($detalles['nro_documento']) 
			&& isset($detalles['id_recibo']) 
			&& isset($detalles['fecha_emision']) 
		)) {
			throw new toba_error('No se han recibido los parametros para registrar el recibo de sueldo');
		}
		$sql = sprintf("INSERT INTO be_recibos_sueldo VALUES ('%s',%u,'%s') ON CONFLICT DO NOTHING",$detalles['nro_documento'],$detalles['id_recibo'],$detalles['fecha_emision']);
		return toba::db()->ejecutar($sql);
	}

	function get_recibos_sueldo($filtro = array())
	{
		$where = array();
		$sql = "SELECT per.apellido||', '||per.nombres AS becario, rec.* 
				FROM be_recibos_sueldo AS rec
				LEFT JOIN sap_personas AS per ON per.nro_documento = rec.nro_documento
				ORDER BY becario";
		if(isset($filtro['becario']) && $filtro['becario']){
			$where[] = "per.apellido      ILIKE quitar_acentos(".quote('%'.$filtro['becario'].'%').") OR 
						per.nombres       ILIKE quitar_acentos(".quote('%'.$filtro['becario'].'%').") OR
						per.nro_documento ILIKE quitar_acentos(".quote('%'.$filtro['becario'].'%').")"; 
		}
		if(isset($filtro['mes']) && $filtro['mes']){
			$where[] = 'EXTRACT(month FROM rec.fecha_emision) = ' . quote($filtro['mes']);
		}
		if(isset($filtro['anio']) && $filtro['anio']){
			$where[] = 'EXTRACT(year FROM rec.fecha_emision) = ' . quote($filtro['anio']);
		}
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	function borrar_recibos($filtro = array())
	{
		if(count($filtro) == 0) throw new toba_error('No se pueden eliminar recibos de sueldo sin establecer un criterio de filtro');
		$where = array();
		$sql = 'SELECT * FROM be_recibos_sueldo';
		if(isset($filtro['mes']) && $filtro['mes']){
			$where[] = "extract(month from fecha_emision) = {$filtro['mes']}";
		}
		if(isset($filtro['anio']) && $filtro['anio']){
			$where[] = "extract(year from fecha_emision) = {$filtro['anio']}";
		}
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		$recibos = toba::db()->consultar($sql);
		
		if(count($recibos) == 0) return;

		foreach($recibos as $recibo){
			$fecha = new Datetime($recibo['fecha_emision']);
			$archivo = sprintf('%s_%u_%s.pdf',$recibo['nro_documento'],$recibo['id_recibo'],$fecha->format('d-m-Y'));
			toba::consulta_php('helper_archivos')->eliminar_archivo('recibos_sueldo/'.$archivo);
			toba::db()->ejecutar('DELETE FROM be_recibos_sueldo WHERE id_recibo = '.quote($recibo['id_recibo']));
		}
	}
	/**
	 * Obtiene todods los años distintos para los cuales hay recibos de sueldo (se usa para filtros)
	 * @return array Array con todos los años distintos
	 */
	function get_anios_recibos_sueldo()
	{
		return toba::db()->consultar("SELECT DISTINCT EXTRACT(year FROM fecha_emision) AS anio FROM be_recibos_sueldo");
	}
}

?>