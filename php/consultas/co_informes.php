<?php

class co_informes
{
	//Se considera vigente a aquellas becas que lo estén, o bien que hayan finalizado hace menos de 70 días
	function get_becas_vigentes($filtro = array())
	{
		$where = array();
		$sql = "SELECT 
					per.nro_documento,
					per.apellido||', '||per.nombres AS postulante,	
					conv.id_convocatoria,
					conv.convocatoria,
					tipbec.id_tipo_beca,
					tipbec.tipo_beca
				FROM be_becas_otorgadas AS oto 
				LEFT JOIN be_inscripcion_conv_beca AS insc ON (
					insc.nro_documento = oto.nro_documento 
					AND insc.id_convocatoria = oto.id_convocatoria 
					AND insc.id_tipo_beca = oto.id_tipo_beca
				)
				LEFT JOIN sap_personas AS per ON per.nro_documento = insc.nro_documento
				LEFT JOIN be_convocatoria_beca AS conv ON conv.id_convocatoria = insc.id_convocatoria
				LEFT JOIN be_tipos_beca AS tipbec ON tipbec.id_tipo_beca = insc.id_tipo_beca
				-- Que la beca no haya vencido hace mas de 70  días
				WHERE (CURRENT_DATE - oto.fecha_hasta) <= 70";
		if(isset($filtro['nro_documento'])){
			$where[] = "insc.nro_documento = " . quote($filtro['nro_documento']);
			
		}
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	/**
	 * Retorna la cantidad de informes que debe presentar un becario, incluyendo informes de avance y final.
	 * @param  integer $id_tipo_beca ID del tipo de beca
	 * @return integer               Cantidad de informes que se deben presentar a lo largo de la beca
	 */
	protected function get_cantidad_informes($id_tipo_beca){
		$duracion_meses = toba::consulta_php('co_tipos_beca')->get_campo('duracion_meses',$id_tipo_beca);
		$meses_present_avance = toba::consulta_php('co_tipos_beca')->get_campo('meses_present_avance',$id_tipo_beca);
		return intval($duracion_meses / $meses_present_avance);
	}
	private function get_where_informe($postulacion,$nro_informe)
	{
		//Datos necesarios para buscar un informe de beca
		if( ! (isset($postulacion['id_convocatoria']) && 
			isset($postulacion['id_tipo_beca']) && 
			isset($postulacion['nro_documento'])) ){
			throw new toba_error('No se recibieron los datos necesarios para buscar el informe de beca.');
		}
		//Condiciones
		$where[] = 'id_convocatoria = ' . quote($postulacion['id_convocatoria']);
		$where[] = 'id_tipo_beca = '    . quote($postulacion['id_tipo_beca']);
		$where[] = 'nro_documento = '   . quote($postulacion['nro_documento']);
		$where[] = 'nro_informe = '     . quote($nro_informe);
		return $where;
	}

	private function existe_informe($postulacion, $nro_informe){
		$where = $this->get_where_informe($postulacion, $nro_informe);
		$sql = sql_concatenar_where("SELECT * FROM be_informe_beca LIMIT 1",$where);
		return (count(toba::db()->consultar($sql)) > 0);
	}
	private function get_estado_evaluacion($postulacion,$nro_informe)
	{
		$where = $this->get_where_informe($postulacion, $nro_informe);
		$sql = sql_concatenar_where("SELECT estado_eval FROM be_informe_beca LIMIT 1",$where);
		$resultado = toba::db()->consultar_fila($sql);
		return (isset($resultado['estado_eval'])) ? $resultado['estado_eval'] : NULL;
	}

	private function get_fecha_debe_ser_presentado($postulacion,$nro_informe)
	{
		$where = $this->get_where_informe($postulacion, $nro_informe);
		//Esta consulta suma los meses (en dias) necesarios para obtener la fecha en que debe ser presentado el informe numero X
		$sql = "SELECT (oto.fecha_desde::date + (( (
						SELECT meses_present_avance 
						FROM be_tipos_beca 
						WHERE id_tipo_beca = oto.id_tipo_beca)  * $nro_informe)*30)::integer 
					) AS fecha_debe_ser_presentado
				FROM be_becas_otorgadas as oto
				WHERE oto.id_convocatoria = " . quote($postulacion['id_convocatoria']) . "
				AND oto.id_tipo_beca = " . quote($postulacion['id_tipo_beca']) . "
				AND oto.nro_documento = " . quote($postulacion['nro_documento']);
		$resultado = toba::db()->consultar_fila($sql);
		return (isset($resultado['fecha_debe_ser_presentado'])) ? $resultado['fecha_debe_ser_presentado'] : NULL;
	}

	protected function estado_informe($postulacion,$nro_informe)
	{
		$estado = array('existe'=>FALSE,'estado_eval'=>NULL,'fecha_debe_ser_presentado'=>NULL);
		//Existe el informe?
		$estado['existe'] = $this->existe_informe($postulacion,$nro_informe);
		//Si existe, verifico el estado y la feche que corresponde presentarlo
		if($estado['existe']){
			$estado['estado_eval'] = $this->get_estado_evaluacion($postulacion,$nro_informe);
		}
		$estado['fecha_debe_ser_presentado'] = $this->get_fecha_debe_ser_presentado($postulacion,$nro_informe);
		return $estado;
	}

	function get_informes_postulacion($postulacion)
	{
		//Acá hay que ver como devuelvo un array con los informes que debe presentar la postulacion (solo aquellos para los cuales ya llegó la fecha)
		$cant_informes = $this->get_cantidad_informes($postulacion['id_tipo_beca']);
		$informes = array();
		for($i=1; $i <= $cant_informes; $i++){
			$tipo_informe = ($i == $cant_informes) ? 'Final' : 'Avance';
			$estado = $this->estado_informe($postulacion,$i);
			$informes[] = array(
				'id_convocatoria'           => $postulacion['id_convocatoria'],
				'id_tipo_beca'              => $postulacion['id_tipo_beca'],
				'nro_documento'             => $postulacion['nro_documento'],
				'nro_informe'               => $i, 
				'tipo_informe'              => $tipo_informe,
				'estado'                    => ($estado['existe']) ? 'Presentado' : 'No presentado', 
				'fecha_debe_ser_presentado' => $estado['fecha_debe_ser_presentado'],
				'estado_eval'               => $estado['estado_eval']
			);
		}
		return $informes;
	}

}

?>