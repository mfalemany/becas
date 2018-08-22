<?php
class ci_comision_evaluacion_seleccion extends becas_ci
{
	protected $s__filtro;
	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf()
	{
	}

	//-----------------------------------------------------------------------------------
	//---- cu_postulaciones -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_postulaciones(becas_ei_cuadro $cuadro)
	{
		$filtro = ($this->s__filtro) ? $this->s__filtro : array();
		
		//Solo inscripciones cerradas y admitidas
		$filtro['admisible'] =  'S';
		$filtro['estado'] = 'C';

		$cuadro->set_datos(toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones($filtro));
	}

	function evt__cu_postulaciones__seleccion($seleccion)
	{
		//$this->get_datos()->cargar($seleccion);
		$this->set_pantalla('pant_edicion');

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
	}

	function evt__form_filtro__cancelar()
	{
		unset($this->s__filtro);
	}


	function get_datos($tabla = NULL)
	{
		return ($tabla) ? $this->dep('datos')->tabla($tabla) : $this->dep('datos');
	}

	


	function conf__pant_edicion(toba_ei_pantalla $pantalla)
	{
		$template = file_get_contents(__DIR__.'/template_evaluacion.php');
		$pantalla->set_template($template);
	}

}
?>