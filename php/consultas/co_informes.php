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
					tipbec.tipo_beca,
					dep.nombre AS dependencia,
					lugtrab.nombre AS lugar_trabajo
				FROM be_becas_otorgadas AS oto 
				LEFT JOIN be_inscripcion_conv_beca AS insc ON (
					insc.nro_documento = oto.nro_documento 
					AND insc.id_convocatoria = oto.id_convocatoria 
					AND insc.id_tipo_beca = oto.id_tipo_beca
				)
				LEFT JOIN sap_personas AS per ON per.nro_documento = insc.nro_documento
				LEFT JOIN be_convocatoria_beca AS conv ON conv.id_convocatoria = insc.id_convocatoria
				LEFT JOIN be_tipos_beca AS tipbec ON tipbec.id_tipo_beca = insc.id_tipo_beca
				LEFT JOIN sap_dependencia AS dep ON dep.id = insc.id_dependencia
				LEFT JOIN sap_dependencia AS lugtrab ON lugtrab.id = insc.lugar_trabajo_becario
				-- Que la beca no haya vencido hace mas de 120  días
				WHERE (CURRENT_DATE - oto.fecha_hasta) <= 120";
		if(isset($filtro['nro_documento'])){
			$where[] = "insc.nro_documento = " . quote($filtro['nro_documento']);
		}
		if(isset($filtro['becario'])){
			$where[] = "insc.nro_documento IN (SELECT nro_documento FROM sap_personas WHERE apellido ILIKE " . quote('%'.$filtro['becario'].'%') . " OR nombres ILIKE ". quote('%'.$filtro['becario'].'%') .")";
		}
		if(isset($filtro['id_area_conocimiento']) && $filtro['id_area_conocimiento']){
			$where[] = "insc.id_area_conocimiento = " . quote($filtro['id_area_conocimiento']);
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

	private function get_estado_evaluacion($postulacion,$nro_informe)
	{
		//Aca hay que determinar el estado de evaluacion, en base a las evaluaciones realizadas
		return FALSE;
	}

	private function get_fecha_debe_ser_presentado($postulacion,$nro_informe)
	{
		$where = $this->get_where_informe($postulacion, $nro_informe);
		//Esta consulta suma los meses (en dias) necesarios para obtener la fecha en que debe ser presentado el informe numero X (si la fecha de ser presentado es posterior a la fecha_hasta, se devuelve esta última (caso de bajas))
		$sql = "SELECT CASE WHEN fecha_debe_ser_presentado > fecha_hasta THEN fecha_debe_ser_presentado ELSE fecha_hasta END AS fecha_debe_ser_presentado 
			FROM (
				SELECT oto.fecha_hasta, (oto.fecha_desde::date + (( (
						SELECT meses_present_avance 
						FROM be_tipos_beca 
						WHERE id_tipo_beca = oto.id_tipo_beca)  * $nro_informe)*30)::integer 
					) AS fecha_debe_ser_presentado
				FROM be_becas_otorgadas as oto
				WHERE oto.id_convocatoria = " . quote($postulacion['id_convocatoria']) . "
				AND oto.id_tipo_beca = " . quote($postulacion['id_tipo_beca']) . "
				AND oto.nro_documento = " . quote($postulacion['nro_documento']) ."
			) AS tmp";
		$resultado = toba::db()->consultar_fila($sql);
		return (isset($resultado['fecha_debe_ser_presentado'])) ? $resultado['fecha_debe_ser_presentado'] : NULL;
	}

	/**
	 * Esta funcion calcula y retorna todos los informes que debe presentar una postulación a lo largo de su vigencia. Para obtener un listado de los informes ya presentados (para la evaluación por ejemplo) use el método get_informes_presentados()
	 * @param  array $postulacion Array con las claves correspondientes a la postulacion
	 * @return array              Array con los informes que debe presentar la postulación
	 */
	function get_informes_postulacion($postulacion)
	{
		//Acá hay que ver como devuelvo un array con los informes que debe presentar la postulacion (solo aquellos para los cuales ya llegó la fecha)
		$cant_informes = $this->get_cantidad_informes($postulacion['id_tipo_beca']);
		$informes = array();
		for($i=1; $i <= $cant_informes; $i++){
			$estado = $this->estado_informe($postulacion,$i);

			//Algunas variaciones dependiendo del tipo de informe (avance o final)
			if($i == $cant_informes){
				$tipo_informe = array('id'=>'F','desc'=>'Final');
				//Si el informe es final, tiene 60 dias desde la fecha de fin de beca para presentar el informe
				$fecha = new Datetime($estado['fecha_debe_ser_presentado']);
				$fecha = $fecha->add(new DateInterval('P60D'));
				$fecha_debe_ser_presentado = $fecha->format('Y-m-d');
			}else{
				$tipo_informe = array('id'=>'A','desc'=>'Avance');
				$fecha_debe_ser_presentado = $estado['fecha_debe_ser_presentado'];
			}
			
			$informes[] = array(
				'id_convocatoria'           => $postulacion['id_convocatoria'],
				'id_tipo_beca'              => $postulacion['id_tipo_beca'],
				'nro_documento'             => $postulacion['nro_documento'],
				'nro_informe'               => $i, 
				'tipo_informe'              => $tipo_informe['id'],
				'tipo_informe_desc'         => $tipo_informe['desc'],
				'estado'                    => ($estado['existe']) ? 'Presentado' : 'No presentado', 
				'fecha_debe_ser_presentado' => $fecha_debe_ser_presentado,
				'estado_eval'               => $estado['estado_eval']
			);
		}
		return $informes;
	}

	function get_informes_presentados($postulacion,$solo_evaluables=FALSE)
	{
		$cant = toba::consulta_php('co_tablas_basicas')->get_parametro_conf('inf_beca_cant_eval_postivas');
		if( ! $cant) throw new toba_error('No se ha definido el parámetro "inf_beca_cant_eval_postivas", necesario para la evaluación de informes de becas. Por favor, establezca ese parámetro en las configuraciones del sistema.');
		
		$sql = "SELECT *,
					CASE estado_eval WHEN 'P' THEN 'Pendiente' WHEN 'A' THEN 'Aprobado' END AS estado_eval_desc,
					CASE eval_usuario WHEN 'A' THEN 'Aprobado' WHEN 'M' THEN 'Solicita Modificaciones' WHEN 'N' THEN 'No aprobado' ELSE 'No evaluado' END as eval_usuario_desc 
				FROM (
					SELECT *,
					CASE ib.tipo_informe WHEN 'A' THEN 'Avance' WHEN 'F' THEN 'Final' END AS tipo_informe_desc,
					CASE WHEN (SELECT COUNT(*) 
						FROM be_informe_evaluacion 
						WHERE resultado = 'A' 
						AND id_informe = ib.id_informe
						) >= 3 THEN 'A' ELSE 'P' END AS estado_eval,
					(SELECT resultado FROM be_informe_evaluacion WHERE id_informe = ib.id_informe AND nro_documento_evaluador = '" . toba::usuario()->get_id()."') AS eval_usuario
					FROM be_informe_beca AS ib
					WHERE ib.id_convocatoria = " . quote($postulacion['id_convocatoria']) . "
					AND ib.id_tipo_beca =      " . quote($postulacion['id_tipo_beca']) . "
					AND ib.nro_documento =     " . quote($postulacion['nro_documento']);
					if($solo_evaluables){
						$sql .= " AND ib.evaluable = true";
					}
		$sql .= ") AS tmp";
		return toba::db()->consultar($sql);
	}

	function get_plazos($solo_vigentes = FALSE, $tipo_plazo = FALSE, $tipo_informes = FALSE)
	{
		$where = array();
		$sql = "SELECT *, 
		CASE tipo_plazo WHEN 'P' THEN 'Presentación' WHEN 'E' THEN 'Evaluación' END as tipo_plazo_desc,
		CASE tipo_informes 
			WHEN 'A' THEN 'Avance' 
			WHEN 'F' THEN 'Finales'
			WHEN 'T' THEN 'Todos' END as tipo_informes_desc
		FROM be_informe_plazos";
		if($solo_vigentes){
			$where[] = "CURRENT_DATE BETWEEN fecha_desde AND fecha_hasta";
		}
		if($tipo_plazo){
			$where[] = "tipo_plazo = " . quote($tipo_plazo);
		}
		
		if($tipo_informes){
			$where[] = "tipo_informes = " . quote($tipo_informes);
		}
		
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
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

	private function existe_informe($postulacion, $nro_informe){
		$where = $this->get_where_informe($postulacion, $nro_informe);
		$sql = sql_concatenar_where("SELECT * FROM be_informe_beca LIMIT 1",$where);
		return (count(toba::db()->consultar($sql)) > 0);
	}

	public function hay_plazo_abierto_informes($tipo_plazo)
	{
		return count($this->get_plazos(TRUE,$tipo_plazo));
	}


	


}

?>