<?php
class ci_otorgamiento extends becas_ci
{
	protected $s__filtro;
	
	


	//-----------------------------------------------------------------------------------
	//---- ml_postulantes ---------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_postulantes(becas_ei_formulario_ml $form_ml)
	{
	
		$form_ml->agregar_notificacion('Los cambios se aplicarán solo a los registros que tengan la casilla \'Seleccionado\' activada','info');

		$filtro = $this->s__filtro;
		//Si la distribución de las becas es por facultad, los resultados se muestran ordenados de esa manera
		if($filtro['distribucion'] == 'F'){
			$filtro['campos_ordenacion'] = array('id_dependencia'=>'desc','puntaje_final'=>'desc');
		}

		unset($filtro['cantidad_becas']);
		$postulantes = toba::consulta_php('co_junta_coordinadora')->get_orden_merito($filtro);

		$primeros = array();
						
		foreach($postulantes as $postulante){
			if($filtro['distribucion'] == 'F'){
				$lugar = $postulante['lugar'];
				
				//Se calculan los primeros N por facultad (se calcula solo una vez)
				if(! isset($primeros[$lugar])){
					$primeros[$lugar] = array_filter($postulantes,function($p) use ($lugar){
						return ($p['lugar'] == $lugar);
					});
					$primeros[$lugar] = array_slice($primeros[$lugar],0,$this->s__filtro['cantidad_becas']);
				}
				//Si está entre los primeros N, se lo marca como seleccionado
				if(in_array($postulante['nro_documento'],array_column($primeros[$lugar],'nro_documento'))){
					$postulante['seleccionado'] = 1;	
				}
			}else{
				$primeros = array_slice($postulantes,0,$this->s__filtro['cantidad_becas']);	
				//Lo mismo, pero en un ranking general (cuando no es por facultad)
				if(in_array($postulante['nro_documento'],array_column($primeros,'nro_documento'))){
					$postulante['seleccionado'] = 1;	
				}
			}
			
			$form_ml->agregar_registro($postulante);
		}
	}

	function evt__ml_postulantes__modificacion($datos)
	{
		foreach($datos as $clave => $postulante){
			if($datos[$clave]['seleccionado']){
				$datos[$clave] = array_merge($postulante,$this->s__filtro);
			}else{
				unset($datos[$clave]);
			}
		}
		$this->get_datos('becas_otorgadas')->procesar_filas($datos);
		
	}

	//-----------------------------------------------------------------------------------
	//---- form_filtro ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_filtro(becas_ei_formulario $form)
	{	
		if(isset($this->s__filtro)){
			$form->set_datos($this->s__filtro);
		}
	}

	function evt__form_filtro__filtrar($datos)
	{
		$this->s__filtro = $datos;
		$this->set_pantalla('pant_otorgamiento');
	}
	function evt__form_filtro__cancelar()
	{
		unset($this->s__filtro);
	}


	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__guardar()
	{
		$this->get_datos()->sincronizar();
	}

	function evt__cancelar()
	{
		$this->get_datos()->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	//-----------------------------------------------------------------------------------
	//---- Auxiliares -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function get_datos($tabla = NULL)
	{
		return ($tabla) ? $this->dep('datos')->tabla($tabla) : $this->dep('datos');
	}


}
?>