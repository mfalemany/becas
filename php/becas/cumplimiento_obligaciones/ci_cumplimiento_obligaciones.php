<?php
class ci_cumplimiento_obligaciones extends becas_ci
{
	protected $s__beca;
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__volver()
	{
		if(isset($this->s__beca)){
			unset($this->s__beca);
		}
		$this->set_pantalla('pant_seleccion');
	}

	//-----------------------------------------------------------------------------------
	//---- cu_seleccion -----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_seleccion(becas_ei_cuadro $cuadro)
	{
		$cuadro->agregar_notificacion('Seleccione un becario para poder registrar cumplimiento de obligaciones','info');
		$dir = toba::usuario()->get_id();
		$cuadro->set_datos(toba::consulta_php('co_cumplim_obligaciones')->get_becarios_vigentes($dir));
	}

	function evt__cu_seleccion__seleccion($seleccion)
	{
		$seleccion['meses'] = $this->obtener_meses($seleccion);
		$this->s__beca = $seleccion;
		$this->set_pantalla('pant_edicion');
		
	}

	/**
	 * Retorna un array con los meses que el becario debe cumplir. Omite (obviamente) los meses ya cumplidos y los meses que todavia no pasaron. En otras palabras, retorna un array de meses no cumplidos, y que el 31 de ese mes ya haya pasado (solo se permite el registro de cumplimientos a mes vencido).
	 * @param  array $beca Array con la clave de la beca (nro_documento,id_convocatoria,id_tipo_beca)
	 * @return array       Array de meses por cumplir
	 */
	protected function obtener_meses($beca)
	{
		$meses = array();
		//Obtengo todos los meses que dura la beca, y que el becario aun no cumplió
		$duracion = toba::consulta_php('co_cumplim_obligaciones')->get_duracion_meses_beca($beca);
		
		$desde=date_create($beca['fecha_desde']);
		
		$mes = $desde->format('m');
		$anio = $desde->format('Y');
		
		for($i=0 ; $i <= $duracion ; $i++ ){
			if( strtotime($anio."-".$mes."-28") < strtotime(date('Y-m-d')) ){
				$meses[] = array('mes'      => $mes,
								 'anio'     => $anio,
								 'mes_desc' => $this->get_mes_desc($mes));
			}	
			if($mes == 12){
				$mes = 1;
				$anio++;
			}else{
				$mes++;
			}
		}
		return $meses;
	}

	//-----------------------------------------------------------------------------------
	//---- cu_cumplimientos -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_cumplimientos(becas_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		if(!isset($this->s__beca)){
			throw new toba_error('No se ha seleccionado una beca para la carga de cumplimiento de obligaciones');
		}
		$cuadro->set_datos($this->s__beca['meses']);
	}

	function evt__cu_cumplimientos__seleccion($seleccion)
	{
		$cumplido = array_merge($seleccion,$this->s__beca);
		if(toba::consulta_php('co_cumplim_obligaciones')->marcar_cumplido($cumplido)){
			toba::notificacion()->agregar('Se ha marcado como cumplido!','info');
		}

	}

	function conf_evt__cu_cumplimientos__seleccion(toba_evento_usuario $evento, $fila)
	{
		$periodo = explode('||',$evento->get_parametros());
		$mes = $periodo[0];
		$anio = $periodo[1];
		if(!toba::consulta_php('co_cumplim_obligaciones')->mes_cumplido($this->s__beca,$mes,$anio)){
			$evento->activar();
			$evento->set_etiqueta('Marcar como cumplido');
		}else{
			$evento->desactivar();
			$evento->set_etiqueta('Mes Cumplido!');
		}
	}
}
?>