<?php
class ci_edicion extends becas_ci
{
	function conf()
	{
		$datos = $this->get_datos('inscripcion_conv_beca')->get();
		if( ! $datos['nro_documento_codir']){
			$this->pantalla()->eliminar_tab('pant_codirector');
		}
		if( ! $datos['nro_documento_subdir']){
			$this->pantalla()->eliminar_tab('pant_subdirector');
		}
	}
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
		
		$this->get_datos('inscripcion_conv_beca')->set($datos);
		$this->get_datos('alumno')->cargar(array(
			'nro_documento' => $datos['nro_documento'],
			'id_tipo_doc'   => $datos['id_tipo_doc']
		));
		$this->get_datos('director')->cargar(array(
			'nro_documento' => $datos['nro_documento_dir'],
			'id_tipo_doc'   => $datos['id_tipo_doc_dir']
		));
		$this->get_datos('director_docente')->cargar(array(
			'nro_documento' => $datos['nro_documento_dir'],
			'id_tipo_doc'   => $datos['id_tipo_doc_dir']
		));
		if($datos['nro_documento_codir']){
			$this->get_datos('codirector')->cargar(array(
				'nro_documento' => $datos['nro_documento_codir'],
				'id_tipo_doc'   => $datos['id_tipo_doc_codir']
			));
			$this->get_datos('codirector_docente')->cargar(array(
				'nro_documento' => $datos['nro_documento_codir'],
				'id_tipo_doc'   => $datos['id_tipo_doc_codir']
			));
		}


		if($datos['nro_documento_subdir']){
			$this->get_datos('subdirector')->cargar(array(
				'nro_documento' => $datos['nro_documento_subdir'],
				'id_tipo_doc'   => $datos['id_tipo_doc_subdir']
			));
			$this->get_datos('subdirector_docente')->cargar(array(
				'nro_documento' => $datos['nro_documento_subdir'],
				'id_tipo_doc'   => $datos['id_tipo_doc_subdir']
			));
		}

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
	//---- form_director ----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_director(becas_ei_formulario $form)
	{

		if($this->get_datos('director')->get()){
			$form->set_datos($this->get_datos('director')->get());
		}
	}

	function evt__form_director__modificacion($datos)
	{
		$this->get_datos('director')->set($datos);
	}

	function conf__form_director_docente(becas_ei_formulario $form)
	{
		if($this->get_datos('director_docente')->get()){
			$form->set_datos($this->get_datos('director_docente')->get());
		}
		
	}

	function evt__form_director_docente__modificacion($datos)
	{
		$this->get_datos('director_docente')->set($datos);
	}


	//-----------------------------------------------------------------------------------
	//---- form_codirector --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_codirector(becas_ei_formulario $form)
	{
		if($this->get_datos('codirector')->get()){
			$form->set_datos($this->get_datos('codirector')->get());
		}
	}

	function evt__form_codirector__modificacion($datos)
	{
		$this->get_datos('codirector')->set($datos);
	}
	function conf__form_codirector_docente(becas_ei_formulario $form)
	{
		if($this->get_datos('codirector_docente')->get()){
			$form->set_datos($this->get_datos('codirector_docente')->get());
		}
	}

	function evt__form_codirector_docente__modificacion($datos)
	{
		$this->get_datos('codirector_docente')->set($datos);

	}

	//-----------------------------------------------------------------------------------
	//---- form_subdirector -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_subdirector(becas_ei_formulario $form)
	{
		if($this->get_datos('subdirector')->get()){
			$form->set_datos($this->get_datos('subdirector')->get());
		}
	}

	function evt__form_subdirector__modificacion($datos)
	{
		$this->get_datos('subdirector')->set($datos);
	}

	function conf__form_subdirector_docente(becas_ei_formulario $form)
	{
		if($this->get_datos('subdirector_docente')->get()){
			$form->set_datos($this->get_datos('subdirector_docente')->get());
		}
	}

	function evt__form_subdirector_docente__modificacion($datos)
	{
		$this->get_datos('subdirector_docente')->set($datos);
	}



	

	//-----------------------------------------------------------------------------------
	//---- form_admisibilidad -----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_admisibilidad(becas_ei_formulario $form)
	{
	
	}

	function evt__form_admisibilidad__modificacion($datos)
	{
	}

	//-----------------------------------------------------------------------------------
	//---- form_codirector_justif -------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_codirector_justif(becas_ei_formulario $form)
	{
		if($this->get_datos('inscripcion_conv_beca')->get()){
			$datos = $this->get_datos('inscripcion_conv_beca')->get();
			$form->set_datos(array('justif_codirector' => $datos['justif_codirector']));
		}
	}

	function evt__form_codirector_justif__modificacion($datos)
	{
		$this->get_datos('inscripcion_conv_beca')->set($datos);
	}


	function get_datos($tabla)
	{
		return $this->controlador()->get_datos($tabla);
	}

}
?>