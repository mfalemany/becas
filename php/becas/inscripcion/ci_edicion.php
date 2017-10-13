<?php
class ci_edicion extends becas_ci
{
	//-----------------------------------------------------------------------------------
	//---- form_inscripcion -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_inscripcion(becas_ei_formulario $form)
	{
		if($this->get_datos('inscripcion_conv_beca')->get()){
			$form->set_datos($this->get_datos('inscripcion_conv_beca')->get());
		}
	}

	function evt__form_inscripcion__modificacion($datos)
	{
		$this->get_datos('alumno')->cargar(array('id_tipo_doc'   => $datos['id_tipo_doc'],
												 'nro_documento' => $datos['nro_documento']));
		$this->get_datos('inscripcion_conv_beca')->set($datos);

	}
	//-----------------------------------------------------------------------------------
	//---- form_alumno ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_alumno(becas_ei_formulario $form)
	{
		if($this->get_datos('alumno')->get()){
			$form->set_datos($this->get_datos('alumno')->get());
		}
	}

	function evt__form_alumno__modificacion($datos)
	{
		$this->get_datos('alumno')->set($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_codirector --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_codirector(becas_ei_formulario $form)
	{
	}

	function evt__form_codirector__modificacion($datos)
	{
	}

	//-----------------------------------------------------------------------------------
	//---- form_director ----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_director(becas_ei_formulario $form)
	{
	}

	function evt__form_director__modificacion($datos)
	{
	}

	

	//-----------------------------------------------------------------------------------
	//---- form_subdirector -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_subdirector(becas_ei_formulario $form)
	{
	}

	function evt__form_subdirector__modificacion($datos)
	{
	}



	function get_datos($tabla)
	{
		return $this->controlador()->get_datos($tabla);
	}

}

?>