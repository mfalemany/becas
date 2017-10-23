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

		$this->get_datos('inscripcion_conv_beca')->set(array('estado'    => 'A','fecha_hora'=> date('Y-m-d'),'es_titular'=>'S'));

		$this->get_datos('inscripcion_conv_beca')->set(array('puntaje'=>$this->calcular_puntaje()));

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
			$detalles = $this->get_detalles_insc($insc['id_convocatoria'],$insc['id_tipo_beca'],$insc['id_tipo_doc'],$insc['nro_documento']);
			$form->set_datos($insc);
			$resumen = $this->formatear_resumen($detalles);
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
	function get_detalles_insc($id_convocatoria,$id_tipo_beca,$id_tipo_doc,$nro_documento)
	{
		$det_doc = toba::consulta_php('co_inscripcion_conv_beca')->get_detalles_director($id_convocatoria,$id_tipo_beca,$id_tipo_doc,$nro_documento);
		$doc = array('id_tipo_doc'=>$det_doc['id_tipo_doc'],'nro_documento'=>$det_doc['nro_documento']);
		$detalles_cargos = toba::consulta_php('co_docentes')->get_cargos_docente($doc['id_tipo_doc'],$doc['nro_documento']);
		return array_merge($det_doc,array('cargos'=>$detalles_cargos));
	}

	function formatear_resumen($detalles)
	{
		$resumen = "<p>Director: <b class='etiqueta_importante'>".$detalles['apellido'].", ".$detalles['nombres']."</b> (".$detalles['tipo_doc'].": ".$detalles['nro_documento'].")</p>";
		$resumen .= "<p>CUIL: ".$detalles['cuil']."</p>";
		$resumen .= "<p>M&aacute;ximo Grado: ".$detalles['nivel_academico']."</p>";
		$resumen .= "<p>Cat. Incentivos: ".$detalles['cat_incentivos']."</p>";
		$resumen .= "<p>Cat. CONICET: ".$detalles['cat_conicet']."</p>";
		$resumen .= "Cargos:<ul>";
		foreach($detalles['cargos'] as $indice => $cargo){
			$resumen .= "<li>Cargo: ".$cargo['cargo']." - Dedicaci&oacute;n: ".$cargo['dedicacion']." (".$cargo['dependencia'].").";
			if($cargo['fecha_desde']){
				$desde = new DateTime($cargo['fecha_desde']);
				$resumen .= " Desde el ".$desde->format('d/m/Y');
			}
			if($cargo['fecha_hasta']){
				$hasta = new DateTime($cargo['fecha_hasta']);
				$resumen .= " y hasta el ".$hasta->format('d/m/Y');
			}
			$resumen .= "</li>";
		}
		$resumen .= "</ul>";
		return $resumen;
	}

	function calcular_puntaje()
	{
		return "42.3";
	}

}
?>	