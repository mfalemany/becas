<?php
class ci_edicion extends becas_ci
{
	function conf()
	{
		if( ! $this->get_datos('codirector')->get()){
			$this->pantalla()->eliminar_tab('pant_codirector');
		}
		if( ! $this->get_datos('subdirector')->get()){
			$this->pantalla()->eliminar_tab('pant_subdirector');
		}
	}
	//-----------------------------------------------------------------------------------
	//---- form_inscripcion -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_inscripcion(becas_ei_formulario $form)
	{
		/**
		 * ACA ME QUEDÉ: hay que ver porque cuando selecciono una inscripcion desde el cuadro no se carga en el formulario de edicion.
		 */
		

		
		//obtengo datos de la inscripcion
		if($this->get_datos('inscripcion_conv_beca')->get()){
			$inscripcion = $this->get_datos('inscripcion_conv_beca')->get();
		}

		//obtengo los datos del director
		if($this->get_datos('director')->get()){
			$tmp = $this->get_datos('director')->get();
			$director = array('id_tipo_doc_dir'   => $tmp['id_tipo_doc'],
							  'nro_documento_dir' => $tmp['nro_documento']);
		}
		
		//obtengo los datos del subdirector
		$codirector = ($this->get_datos('codirector')->get()) ? array('id_tipo_doc_codir'   => $tmp['id_tipo_doc'], 'nro_documento_codir' => $tmp['nro_documento']) : array();

		//obtengo los datos del subdirector
		$subdirector = ($this->get_datos('subdirector')->get()) ? array('id_tipo_doc_subdir'   => $tmp['id_tipo_doc'], 'nro_documento_subdir' => $tmp['nro_documento']) : array();

		$datos = array_merge($inscripcion,$director,$codirector,$subdirector);
		$form->set_datos($datos);
	}

	function evt__form_inscripcion__modificacion($datos)
	{
		/* ====================== ALUMNO =============================*/
		$this->get_datos('alumno')->cargar(
			array('id_tipo_doc'   => $datos['id_tipo_doc'],
				  'nro_documento' => $datos['nro_documento']));


		/* ==================== INSCRIPCION ===========================*/
		$copia = $datos;
		unset($copia['id_tipo_doc_dir']);
		unset($copia['nro_documento_dir']);
		unset($copia['id_tipo_doc_codir']);
		unset($copia['nro_documento_codir']);
		unset($copia['id_tipo_doc_subdir']);
		unset($copia['nro_documento_subdir']);
		$copia['estado']     = 'A';
		$copia['es_titular'] = 'S';
		$this->get_datos('inscripcion_conv_beca')->set($copia);
		unset($copia);

		
		/* ===================== DIRECTOR ============================*/
		//cargo los datos del director
		$this->get_datos('director')->cargar(
			array('id_tipo_doc'   => $datos['id_tipo_doc_dir'],
				  'nro_documento' => $datos['nro_documento_dir']));
		//cargo los datos del director (datos de docente)
		$this->get_datos('director_docente')->cargar(
			array('id_tipo_doc'   => $datos['id_tipo_doc_dir'],
				  'nro_documento' => $datos['nro_documento_dir']));
		//cargo los datos del director (tabla direccion beca)
		$this->get_datos('director_beca')->set(
			array('id_tipo_doc_dir'   => $datos['id_tipo_doc_dir'],
				  'nro_documento_dir' => $datos['nro_documento_dir'],
				  'tipo'              => "D"));

		
		/* ==================== CO-DIRECTOR ===========================*/
		if($datos['id_tipo_doc_codir'] && $datos['nro_documento_codir']){
			//cargo los datos del codirector
			$this->get_datos('codirector')->cargar(
				array('id_tipo_doc'   => $datos['id_tipo_doc_codir'],
					  'nro_documento' => $datos['nro_documento_codir']));
			//cargo los datos del codirector (datos de docente)
			$this->get_datos('codirector_docente')->cargar(
				array('id_tipo_doc'   => $datos['id_tipo_doc_codir'],
					  'nro_documento' => $datos['nro_documento_codir']));
			//cargo los datos del director (tabla direccion beca)
			$this->get_datos('director_beca')->set(
				array('id_tipo_doc_dir'   => $datos['id_tipo_doc_codir'],
					  'nro_documento_dir' => $datos['nro_documento_codir'],
					  'tipo'              => "C"));
		}else{
			$this->get_datos('codirector')->resetear();
		}


		/* ==================== SUB-DIRECTOR ===========================*/
		if($datos['id_tipo_doc_subdir'] && $datos['nro_documento_subdir']){
			//cargo los datos del subdirector
			$this->get_datos('subdirector')->cargar(
				array('id_tipo_doc'   => $datos['id_tipo_doc_subdir'],
					  'nro_documento' => $datos['nro_documento_subdir']));
			//cargo los datos del subdirector (datos de docente)
			$this->get_datos('subdirector_docente')->cargar(
				array('id_tipo_doc'   => $datos['id_tipo_doc_subdir'],
					  'nro_documento' => $datos['nro_documento_subdir']));
			//cargo los datos del director (tabla direccion beca)
			$this->get_datos('director_beca')->set(
				array('id_tipo_doc_dir'   => $datos['id_tipo_doc_subdir'],
					  'nro_documento_dir' => $datos['nro_documento_subdir'],
					  'tipo'              => "S"));
		}else{
			$this->get_datos('subdirector')->resetear();
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
	}

	function conf__form_director_docente(becas_ei_formulario $form)
	{
		$form->desactivar_efs(array('id_tipo_doc','nro_documento'));
		if($this->get_datos('director_docente')->get()){

			$form->set_datos($this->get_datos('director_docente')->get());
		}
	}

	function evt__form_director_docente__modificacion($datos)
	{

	}


	//-----------------------------------------------------------------------------------
	//---- form_codirector --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_codirector(becas_ei_formulario $form)
	{
		$insc = $this->get_datos('inscripcion_conv_beca')->get();
		if(isset($insc['justif_codirector'])){
			$form->ef('justif_codirector')->set_estado($insc['justif_codirector']);
		}
		if($this->get_datos('codirector')->get()){
			$form->set_datos($this->get_datos('codirector')->get());
		}
	}

	function evt__form_codirector__modificacion($datos)
	{
		if($datos['justif_codirector']){
			$this->get_datos('inscripcion_conv_beca')->set(array('justif_codirector'=>$datos['justif_codirector']));
			unset($datos['justif_codirector']);	
		}
		
	}
	function conf__form_codirector_docente(becas_ei_formulario $form)
	{
		$form->desactivar_efs(array('id_tipo_doc','nro_documento'));
		if($this->get_datos('codirector_docente')->get()){

			$form->set_datos($this->get_datos('codirector_docente')->get());
		}
	}

	function evt__form_codirector_docente__modificacion($datos)
	{

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
	}

	function conf__form_subdirector_docente(becas_ei_formulario $form)
	{
		$form->desactivar_efs(array('id_tipo_doc','nro_documento'));
		if($this->get_datos('subdirector_docente')->get()){
			$form->set_datos($this->get_datos('subdirector_docente')->get());
		}
	}

	function evt__form_subdirector_docente__modificacion($datos)
	{

	}



	

	//-----------------------------------------------------------------------------------
	//---- form_admisibilidad -----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_admisibilidad(becas_ei_formulario $form)
	{
		//obtengo datos de la inscripcion
		if($this->get_datos('inscripcion_conv_beca')->get()){
			$form->set_datos($this->get_datos('inscripcion_conv_beca')->get());
		}
	}

	function evt__form_admisibilidad__modificacion($datos)
	{
		$this->get_datos('inscripcion_conv_beca')->set($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_codirector_justif -------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_codirector_justif(becas_ei_formulario $form)
	{
	}

	function evt__form_codirector_justif__modificacion($datos)
	{
	}


	function get_datos($tabla)
	{
		return $this->controlador()->get_datos($tabla);
	}

}
?>