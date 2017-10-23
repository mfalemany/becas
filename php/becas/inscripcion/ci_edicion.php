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
		$datos = $this->get_datos('inscripcion_conv_beca')->get();
		if($datos){
			$form->set_datos($datos);
			$director = $datos['id_tipo_doc_dir'].'||'.$datos['nro_documento_dir'];
			$form->set_datos(array('director'=>toba::consulta_php('co_personas')->get_ayn($director)));
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

		$this->get_datos('inscripcion_conv_beca')->set(array('estado'    => 'A','fecha_hora'=> date('Y-m-d')));

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
		$form->desactivar_efs(array('cuil','fecha_nac','celular','email','telefono','id_pais','id_provincia','id_localidad'));
	}

	function evt__form_director__modificacion($datos)
	{
		$this->get_datos('director')->set($datos);
	}

	function conf__form_director_docente(becas_ei_formulario $form)
	{
		if($this->get_datos('director_docente')->get()){
			$form->set_datos($this->get_datos('director_docente')->get());
			$form->desactivar_efs(array('legajo','id_tipo_doc','nro_documento'));
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
			$form->desactivar_efs(array('cuil','fecha_nac','celular','email','telefono','id_pais','id_provincia','id_localidad'));
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
			$form->desactivar_efs(array('legajo','id_tipo_doc','nro_documento'));
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
			$form->desactivar_efs(array('cuil','fecha_nac','celular','email','telefono','id_pais','id_provincia','id_localidad'));
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
			$form->desactivar_efs(array('legajo','id_tipo_doc','nro_documento'));
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
		$insc = $this->get_datos('inscripcion_conv_beca')->get();
		if($insc){
			$resumen = $this->get_resumen_insc($insc['id_convocatoria'],$insc['id_tipo_beca'],$insc['id_tipo_doc'],$insc['nro_documento']);
			$form->set_datos($insc);
			$form->set_datos(array('resumen'=>$resumen));
		}else{

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

	function ajax__get_persona($datos, toba_ajax_respuesta $respuesta)
	{
		$ayn = toba::consulta_php('co_personas')->get_ayn($datos['tipo'].'||'.$datos['nro']);
		if( ! $ayn){
			$respuesta->set(array('director'=>'Persona no encontrada'));
		}else{
			$respuesta->set(array('director'=>$ayn));
		}
		
	}
	/**
	 * [get_resumen_insc Obtiene un resumen de los detalles de la inscripcion, que son útiles al momento del proceso de admisibilidad. ]
	 * @param  integer $id_convocatoria id de la convocatoria donde se registra la inscripcion
	 * @param  integer $id_tipo_beca    tipo de beca de la inscripcion
	 * @param  integer $id_tipo_doc     tipo de documento del becario
	 * @param  string $nro_documento   nro_documento del becario
	 * @return array                  array con los detalles de la inscripción
	 */
	function get_resumen_insc($id_convocatoria,$id_tipo_beca,$id_tipo_doc,$nro_documento)
	{
		$detalles = toba::consulta_php('co_inscripcion_conv_beca')->get_resumen_insc($id_convocatoria,$id_tipo_beca,$id_tipo_doc,$nro_documento);
		return implode('------',$detalles[0]);
	}

}
?>