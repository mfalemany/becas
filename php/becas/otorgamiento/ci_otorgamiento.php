<?php
class ci_otorgamiento extends becas_ci
{
	protected $s__filtro;
	
	


	//-----------------------------------------------------------------------------------
	//---- ml_postulantes ---------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_postulantes(becas_ei_formulario_ml $form_ml)
	{
		$filtro = array('admisible'=>'S','beca_otorgada'=>'N','id_tipo_beca'=>$this->s__filtro['id_tipo_beca']);
		$postulantes = toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones($filtro);
		foreach($postulantes as $postulante){
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