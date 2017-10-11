<?php
class ci_edicion extends becas_ci
{

	function conf()
	{
		if( ! $this->get_datos('codirector')->get()){
			$this->pantalla()->tab('pant_codirector')->ocultar();
		}
		if( ! $this->get_datos('subdirector')->get()){
			$this->pantalla()->tab('pant_subdirector')->ocultar();
		}
		
	}
	//-----------------------------------------------------------------------------------
	//---- form_convocatoria ------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_convocatoria(becas_ei_formulario $form)
	{
		if($this->get_datos('inscripcion_conv_beca')->get()){
			//obtengo los datos propios de la inscripcion
			$inscripcion = $this->get_datos('inscripcion_conv_beca')->get();
			
			//obtengo los datos del director
			$dir = $this->get_datos('director')->get();
			$director = array('id_tipo_doc_dir'     => $dir['id_tipo_doc'],
							  'nro_documento_dir'   => $dir['nro_documento']);
			unset($dir);

			//obtengo los datos del codirector
			$codirector = array();
			if($this->get_datos('codirector')->get()){
				$codir = $this->get_datos('codirector')->get();
				$codirector = array('id_tipo_doc_codir'     => $codir['id_tipo_doc'],
								  'nro_documento_codir'   => $codir['nro_documento']);
				unset($codir);
			}

			//obtengo los datos del subdirector
			$subdirector = array();
			if($this->get_datos('subdirector')->get()){
				$subdir = $this->get_datos('subdirector')->get();
				$subdirector = array('id_tipo_doc_subdir'     => $subdir['id_tipo_doc'],
								  'nro_documento_subdir'   => $subdir['nro_documento']);
				unset($codir);
			}

			//mezclo los datos para obtener datos de portada
			$datos = array_merge($inscripcion,$director,$codirector,$subdirector);

			//asigno los datos al formulario
			$form->set_datos($datos);
		}
	}

	function evt__form_convocatoria__modificacion($datos)
	{
		//separo los datos para cargar el DT correspondiente al alumno
		$alumno = array('id_tipo_doc'   => $datos['id_tipo_doc'],
						 'nro_documento' => $datos['nro_documento']);
		$this->get_datos('alumno')->cargar($alumno);

		//separo los datos para cargar el DT correspondiente al director de la beca
		$director = array('id_tipo_doc'   => $datos['id_tipo_doc_dir'],
						 'nro_documento' => $datos['nro_documento_dir']);
		$this->get_datos('director')->cargar($director);

		
		//separo los datos para cargar el DT correspondiente al co-director de la beca
		if($datos['id_tipo_doc_codir'] && $datos['nro_documento_codir']){
			$codirector = array('id_tipo_doc'   => $datos['id_tipo_doc_codir'],
						 'nro_documento' => $datos['nro_documento_codir']);	
			$this->get_datos('codirector')->cargar($codirector);
		}else{
			$this->get_datos('codirector')->resetear();
		}
		

		//separo los datos para cargar el DT correspondiente al sub-director de la beca
		if($datos['id_tipo_doc_subdir'] && $datos['nro_documento_subdir']){
			$subdirector = array('id_tipo_doc'   => $datos['id_tipo_doc_subdir'],
							 'nro_documento' => $datos['nro_documento_subdir']);
			$this->get_datos('subdirector')->cargar($subdirector);
		}else{
			$this->get_datos('subdirector')->resetear();
		}

		$inscripcion = array(
							'id_dependencia'           => $datos['id_dependencia'],
							'nro_documento'            => $datos['nro_documento'],
							'id_tipo_doc'              => $datos['id_tipo_doc'],
							'id_convocatoria'          => $datos['id_convocatoria'],
							'fecha_hora'               => date('Y-m-d H:i:s'),
							'id_area_conocimiento'     => $datos['id_area_conocimiento'],
							'titulo_plan_beca'         => $datos['titulo_plan_beca'],
							'nro_carpeta'              => $datos['nro_carpeta'],
							'cant_fojas'               => $datos['cant_fojas'],
							'observaciones'            => $datos['observaciones'],
							'estado'                   => $datos['estado'],
							'es_titular'               => $datos['es_titular']
						);
		$this->get_datos('inscripcion_conv_beca')->set($inscripcion);
		


	}

	//-----------------------------------------------------------------------------------
	//---- form_alumno -----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_alumno(becas_ei_formulario $form)
	{
		if($this->get_datos('alumno')->esta_cargada()){
			$form->set_datos($this->get_datos('alumno')->get());
		}
	}

	function evt__form_alumno__modificacion($datos)
	{
		$this->get_datos('alumno')->set($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_director -----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_director(becas_ei_formulario $form)
	{
		if($this->get_datos('director')->esta_cargada()){
			$form->set_datos($this->get_datos('director')->get());
		}
	}

	function evt__form_director__modificacion($datos)
	{
		$this->get_datos('director')->set($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_codirector -----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_codirector(becas_ei_formulario $form)
	{
		if($this->get_datos('codirector')->esta_cargada()){
			$form->set_datos($this->get_datos('codirector')->get());
		}
	}

	function evt__form_codirector__modificacion($datos)
	{
		$this->get_datos('codirector')->set($datos);
	}



	//-----------------------------------------------------------------------------------
	//---- form_subdirector -----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_subdirector(becas_ei_formulario $form)
	{
		if($this->get_datos('subdirector')->esta_cargada()){
			$form->set_datos($this->get_datos('subdirector')->get());
		}
	}

	function evt__form_subdirector__modificacion($datos)
	{
		$this->get_datos('subdirector')->set($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- Extensión en JS --------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function extender_objeto_js()
	{
		echo "
		//se evita que se cambie a una solapa para la cual no fue declarado el DNI
		{$this->objeto_js}
			.dep('form_convocatoria')
			.ef('nro_documento_codir')
			.cuando_cambia_valor(\"if( ! $(this).prop('value').length){{$this->objeto_js}.desactivar_tab('pant_codirector');}\");
		{$this->objeto_js}
			.dep('form_convocatoria')
			.ef('nro_documento_subdir')
			.cuando_cambia_valor(\"if( ! $(this).prop('value').length){ {$this->objeto_js}.desactivar_tab('pant_subdirector'); }\");";
		//echo "{$this->objeto_js}.desactivar_tab('pant_alumno');";
	}



	//-----------------------------------------------------------------------------------
	//---- acceso a datos ---------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function get_datos($tabla = NULL)
	{
		return $this->controlador()->get_datos($tabla);
	}
}
?>