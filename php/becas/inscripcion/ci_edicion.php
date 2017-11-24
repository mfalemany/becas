<?php
class ci_edicion extends becas_ci
{

	//protected $s__detalles_inscripcion;
	function conf()
	{
		/*if($this->pantalla()->get_etiqueta() != 'Plan de Trabajo'){
			$this->controlador()->pantalla()->eliminar_evento('guardar');
			$this->controlador()->pantalla()->eliminar_evento('eliminar');
		};*/


		
		//obtengo los datos de la inscripcion
		$datos = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();

		//si se est?modificando una inscripcion, es necesario validar algunas cosas...
		if($datos){
			//y los datos de la convocatoria
			$conv = array_shift(toba::consulta_php('co_convocatoria_beca')->get_convocatorias(array('id_convocatoria'=>$datos['id_convocatoria'])));
			
			//si ya pas?la fecha de fin de la convocatoria, no se puede editar la inscripcion
			if($conv['fecha_hasta'] < date('Y-m-d')){
				//bloqueo el formulario para evitar que se modifiquen  los datos
				$this->dep('form_inscripcion')->set_solo_lectura();
				$this->dep('form_inscripcion')->agregar_notificacion('No se pueden modificar los datos de la inscripción debido a que finalizó la convocatoria.','warning');

				//elimino todas las pantallas que no sean el formulario de inscripci?
				$this->pantalla()->eliminar_tab('pant_alumno');
				$this->pantalla()->eliminar_tab('pant_director');

				//elimino los eventos que me permiten alterar los datos de la inscripcion
				$this->controlador()->pantalla()->eliminar_evento('guardar');
				$this->controlador()->pantalla()->eliminar_evento('eliminar');
			}
		}

		if( ! $this->get_datos('inscripcion','inscripcion_conv_beca')->esta_cargada()){
			$this->controlador()->pantalla()->eliminar_evento('eliminar');
		}
		//si no est? cargados el codirector y/o subdirector, se deshabilitan las pesta?s correspondientes
		if( ! $this->get_datos(NULL,'director')->get()){
			$this->pantalla()->tab('pant_director')->desactivar();
		}
		//si no est? cargados el codirector y/o subdirector, se deshabilitan las pesta?s correspondientes
		if( ! $this->get_datos(NULL,'codirector')->get()){
			$this->pantalla()->eliminar_tab('pant_codirector');
		}
		if( ! $this->get_datos(NULL,'subdirector')->get()){
			$this->pantalla()->eliminar_tab('pant_subdirector');
		}
	}



	

	//-----------------------------------------------------------------------------------
	//---- form_inscripcion -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_inscripcion(becas_ei_formulario $form)
	{
		$datos = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		if($datos){
			//se bloquean las opciones de convocatorias para que el usuario no pueda modicarlos
			$form->set_solo_lectura(array('id_convocatoria','id_tipo_beca'));

			//asigno los datos al formulario
			$form->set_datos($datos);

			//se completa el label que contiene el nombre y apellido del director
			$director = $datos['id_tipo_doc_dir'].'||'.$datos['nro_documento_dir'];
			$form->set_datos(array('director'=>toba::consulta_php('co_personas')->get_ayn($director)));

		}else{
			$this->pantalla()->tab('pant_director')->desactivar();
		}
	}

	function evt__form_inscripcion__modificacion($datos)
	{
		//se asignan los datos del formulario al datos_dabla
		$this->get_datos('inscripcion','inscripcion_conv_beca')->set($datos);

		//se setean variables de sesion para facilitar el manejo de los demás datos_tabla
		//$this->setear_entidades($datos);

		//esta funcion carga los datos del alumno (si es posible encontrarlo en wl WS o en la base local). En caso contrario envía al usuario a la pantalla de carga de datos de alumno
		$this->set_alumno($datos['id_tipo_doc'],$datos['nro_documento']);    
		

		//esta funcion carga los datos del director (si es posible encontrarlo en wl WS o en la base local). En caso contrario envía al usuario a la pantalla de carga de datos de director
		if( ! $this->get_datos(NULL,'director')->get()){
			$this->set_director($datos['id_tipo_doc_dir'],$datos['nro_documento_dir']);
		}

		//cargo el datos_tabla codirector (si es posible)
		if($datos['id_tipo_doc_codir'] && $datos['nro_documento_codir']){
			$this->set_codirector($datos['id_tipo_doc_codir'],$datos['nro_documento_codir']);
		}

		//cargo el datos_tabla subdirector (si es posible)
		//cargo el datos_tabla codirector (si es posible)
		if($datos['id_tipo_doc_subdir'] && $datos['nro_documento_subdir']){
			$this->set_subdirector($datos['id_tipo_doc_subdir'],$datos['nro_documento_subdir']);
		}


		$this->get_datos('inscripcion','inscripcion_conv_beca')->set(array( 'estado'      => 'A',
																			'fecha_hora'  => date('Y-m-d'),
																			'es_titular'  => 'S',
																			'puntaje'     => $this->calcular_puntaje(),
																			'nro_carpeta' => substr(time(),0,7)
															));

	}

	protected function set_alumno($id_tipo_doc,$nro_documento)
	{
		//Consulto si la persona existe en la BD local (si no existe, se intenta importar desde el WS)
		$existe_persona = toba::consulta_php('co_personas')->existe_persona($id_tipo_doc,$nro_documento,'alumno');
		//si no existe el alumno, se obliga al usuario a completar los datos en el formulario "alumno"
		if( ! $existe_persona){
			$this->get_datos('alumno')->resetear();
			$this->get_datos('alumno','alumno')->set(array(
				'nro_documento' => $nro_documento,
				'id_tipo_doc'   => $id_tipo_doc
			));
			
			$this->set_pantalla('pant_alumno');

			throw new toba_error('El Nro. de Documento del alumno ingresado no se corresponde con ningún alumno registrado en el sistema. Por favor, complete los datos personales solicitados a continuación.');

		}else{
			$this->get_datos('alumno')->cargar(array('id_tipo_doc'   => $id_tipo_doc,
														'nro_documento' => $nro_documento));

		}
	}

	protected function set_director($id_tipo_doc,$nro_documento)
	{

		//Consulto si la persona existe en la BD local (si no existe, se intenta importar desde el WS)
		$existe_persona = toba::consulta_php('co_personas')->existe_persona($id_tipo_doc,$nro_documento,'docente');
		
		//si no existe el alumno, se obliga al usuario a completar los datos en el formulario "alumno"
		if( ! $existe_persona){
			$this->get_datos(NULL,'director')->resetear();
			throw new toba_error('El Nro. de Documento del director ingresado no se corresponde con ningúna persona registrada en el sistema. Por favor, Comuniquese con la Secretaría General de Ciencia y Técnica para obtener una solución.');
		}else{
			//si existe, se cargan los datos del alumno en el datos tabla para la sincronizacion
			$this->get_datos(NULL,'director')->cargar(array(
				'nro_documento' => $nro_documento,
				'id_tipo_doc'   => $id_tipo_doc
			));
			if( ! $this->get_datos(NULL,'director')->esta_cargada()){
				throw new toba_error('El Nro. de Documento del director ingresado corresponde a un persona registrada en el sistema, pero no es docente. Por favor, Comuniquese con la Secretaría General de Ciencia y Técnica para obtener una solución.');
			}
		}
	}

	protected function set_codirector($id_tipo_doc,$nro_documento)
	{
		//Consulto si la persona existe en la BD local (si no existe, se intenta importar desde el WS)
		$existe_persona = toba::consulta_php('co_personas')->existe_persona($id_tipo_doc,$nro_documento,'docente');
		
		//si no existe el alumno, se obliga al usuario a completar los datos en el formulario "alumno"
		if( ! $existe_persona){
			$this->get_datos(NULL,'codirector')->resetear();
			throw new toba_error('El Nro. de Documento del co-director ingresado no se corresponde con ningúna persona registrada en el sistema. Por favor, Comuniquese con la Secretaría General de Ciencia y Técnica para obtener una solución.');
		}else{
			//si existe, se cargan los datos del alumno en el datos tabla para la sincronizacion
			$this->get_datos(NULL,'codirector')->cargar(array(
				'nro_documento' => $nro_documento,
				'id_tipo_doc'   => $id_tipo_doc
			));
			if( ! $this->get_datos(NULL,'codirector')->esta_cargada()){
				throw new toba_error('El Nro. de Documento del co-director ingresado corresponde a un persona registrada en el sistema, pero no es docente. Por favor, Comuniquese con la Secretaría General de Ciencia y Técnica para obtener una solución.');
			}
		}
	}

	protected function set_subdirector($id_tipo_doc,$nro_documento)
	{
		//Consulto si la persona existe en la BD local (si no existe, se intenta importar desde el WS)
		$existe_persona = toba::consulta_php('co_personas')->existe_persona($id_tipo_doc,$nro_documento,'docente');
		
		//si no existe el alumno, se obliga al usuario a completar los datos en el formulario "alumno"
		if( ! $existe_persona){
			$this->get_datos(NULL,'subdirector')->resetear();
			throw new toba_error('El Nro. de Documento del sub-director ingresado no se corresponde con ningúna persona registrada en el sistema. Por favor, Comuniquese con la Secretaría General de Ciencia y Técnica para obtener una solución.');
		}else{
			//si existe, se cargan los datos del alumno en el datos tabla para la sincronizacion
			$this->get_datos(NULL,'subdirector')->cargar(array(
				'nro_documento' => $nro_documento,
				'id_tipo_doc'   => $id_tipo_doc
			));
			if( ! $this->get_datos(NULL,'subdirector')->esta_cargada()){
				throw new toba_error('El Nro. de Documento del sub-director ingresado corresponde a un persona registrada en el sistema, pero no es docente. Por favor, Comuniquese con la Secretaría General de Ciencia y Técnica para obtener una solución.');
			}
		}
	}



	/**
		* Esta funcion genera los registros que tienen que ver con la inscriopcion, pero que pertenecen a otras tablas, 
		* como por ejemplo, los registros en la tabla 'requisitos_insc' que registra cuales de los requisitos de esa
		* convocatoria fueron entregados por el alumno
	**/
	function generar_registros_relacionados()
	{
		//obtengo los datos principales de la inscripcion
		$datos = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		//verifico si ya se crearon los registros para el cumplimiento de requisitos
		$requisitos_inscripcion = toba::consulta_php('co_requisitos_insc')->get_requisitos_insc($datos['id_convocatoria'],$datos['id_tipo_beca'],$datos['id_tipo_doc'],$datos['nro_documento']);
		
		//la insercion de los requisitos iniciales se realiza solo una vez
		if( ! $requisitos_inscripcion){
			$datos = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
			$requisitos = toba::consulta_php('co_requisitos_convocatoria')->get_requisitos_iniciales($datos['id_convocatoria']);

			foreach($requisitos as $requisito){

				$this->get_datos('inscripcion','requisitos_insc')->nueva_fila($requisito);
			}
		}
	}
	
	//-----------------------------------------------------------------------------------
	//---- form_alumno ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_alumno(becas_ei_formulario $form)
	{	
		$alumno = $this->get_datos('alumno','alumno')->get();
		if($alumno){
			$form->set_datos($this->get_datos('alumno','alumno')->get());
			//se bloquean los efs principales
			$form->set_solo_lectura(array('id_tipo_doc','nro_documento'));
			if(isset($alumno['apellido'])){
				$form->set_solo_lectura(array('apellido'));
			}
			if(isset($alumno['nombres'])){
				$form->set_solo_lectura(array('nombres'));
			}

		}
	}

	function evt__form_alumno__modificacion($datos)
	{
		$this->get_datos('alumno','alumno')->set($datos);
		$this->get_datos('alumno')->sincronizar($datos);
	}

	

	//-----------------------------------------------------------------------------------
	//---- form_director ----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_director(becas_ei_formulario $form)
	{
		$dir = $this->get_datos(NULL,'director')->get();
		if($dir){
			$director = array_shift(toba::consulta_php('co_personas')->get_personas(array(
				'id_tipo_doc'   => $dir['id_tipo_doc'],
				'nro_documento' => $dir['nro_documento']
			)));
			$form->set_datos($director);
		}
		
		$form->desactivar_efs(array('id_tipo_doc','nro_documento','cuil','fecha_nac','celular','email','telefono','id_localidad'));
		$form->set_solo_lectura();
	}

	function conf__form_director_docente(becas_ei_formulario $form)
	{
		$form->desactivar_efs(array('legajo','id_tipo_doc','nro_documento'));
		if($this->get_datos(NULL,'director')->get()){
			$form->set_datos($this->get_datos(NULL,'director')->get());
			
		}
	}

	function evt__form_director_docente__modificacion($datos)
	{
		$this->get_datos(NULL,'director')->set($datos);
		$this->get_datos(NULL,'director')->sincronizar();
	}


	//-----------------------------------------------------------------------------------
	//---- form_codirector --------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	
	function conf__form_codirector(becas_ei_formulario $form)
	{
		$dir = $this->get_datos(NULL,'codirector')->get();
		if($dir){
			$director = array_shift(toba::consulta_php('co_personas')->get_personas(array(
				'id_tipo_doc'   => $dir['id_tipo_doc'],
				'nro_documento' => $dir['nro_documento']
			)));
			$form->set_datos($director);
		}
		
		$form->desactivar_efs(array('id_tipo_doc','nro_documento','cuil','fecha_nac','celular','email','telefono','id_localidad'));
		$form->set_solo_lectura();
	}

	function conf__form_codirector_docente(becas_ei_formulario $form)
	{
		$form->desactivar_efs(array('legajo','id_tipo_doc','nro_documento'));
		if($this->get_datos(NULL,'codirector')->get()){
			$form->set_datos($this->get_datos(NULL,'codirector')->get());
			
		}
	}

	function evt__form_codirector_docente__modificacion($datos)
	{
		$this->get_datos(NULL,'codirector')->set($datos);
		$this->get_datos(NULL,'codirector')->sincronizar();

	}

	//-----------------------------------------------------------------------------------
	//---- form_codirector_justif -------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_codirector_justif(becas_ei_formulario $form)
	{
		if($this->get_datos('inscripcion','inscripcion_conv_beca')->get()){
			$datos = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
			$form->set_datos(array('justif_codirector' => $datos['justif_codirector']));
			
		}
	}

	function evt__form_codirector_justif__modificacion($datos)
	{
		$this->get_datos('inscripcion','inscripcion_conv_beca')->set($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_subdirector -------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	
	

	function conf__form_subdirector(becas_ei_formulario $form)
	{
		$dir = $this->get_datos(NULL,'subdirector')->get();
		if($dir){
			$director = array_shift(toba::consulta_php('co_personas')->get_personas(array(
				'id_tipo_doc'   => $dir['id_tipo_doc'],
				'nro_documento' => $dir['nro_documento']
			)));
			$form->set_datos($director);
		}
		
		$form->desactivar_efs(array('id_tipo_doc','nro_documento','cuil','fecha_nac','celular','email','telefono','id_localidad'));
		$form->set_solo_lectura();
	}

	function conf__form_subdirector_docente(becas_ei_formulario $form)
	{
		$form->desactivar_efs(array('legajo','id_tipo_doc','nro_documento'));
		if($this->get_datos(NULL,'subdirector')->get()){
			$form->set_datos($this->get_datos(NULL,'subdirector')->get());
		}
	}

	function evt__form_subdirector_docente__modificacion($datos)
	{
		$this->get_datos(NULL,'subdirector')->set($datos);
		$this->get_datos(NULL,'subdirector')->sincronizar();
	}


	//-----------------------------------------------------------------------------------
	//---- form_plan_trabajo ------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_plan_trabajo(becas_ei_formulario $form)
	{
		if($this->get_datos('inscripcion','plan_trabajo')->get()){
			$form->set_datos($this->get_datos('inscripcion','plan_trabajo')->get());
		}
	}

	function evt__form_plan_trabajo__modificacion($datos)
	{
		$this->get_datos('inscripcion','plan_trabajo')->set($datos);
	}


	//-----------------------------------------------------------------------------------
	//---- form_activ_docentes ----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_activ_docentes(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_activ_docentes')->get_filas()){
			$form_ml->set_datos($this->get_datos('alumno','antec_activ_docentes')->get_filas());
		}
		
		//se arma un array para cargar el combo "anio_egreso"
		$anios['nopar'] = "Vigente";
		for($i=date("Y");$i>(date("Y")-50);$i--){
			$anios[$i] = $i;
		}
		//se llena el combo "anio_egreso"
		$form_ml->ef('anio_egreso')->set_opciones($anios);
		//solo se quita la opcion "Vigente", y se llena el combo "anio_ingreso"
		unset($anios['nopar']);
		$form_ml->ef('anio_ingreso')->set_opciones($anios);
	}

	function evt__form_activ_docentes__modificacion($datos)
	{
		$this->get_datos('alumno','antec_activ_docentes')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_estudios_afines ---------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_estudios_afines(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_estudios_afines')->get_filas()){
			$form_ml->set_datos($this->get_datos('alumno','antec_estudios_afines')->get_filas());
		}
		
		//se arma un array para cargar los combos de añois
		for($i=date("Y");$i>(date("Y")-50);$i--){
			$anios[$i] = $i;
		}
		$form_ml->ef('anio_desde')->set_opciones($anios);
		$form_ml->ef('anio_hasta')->set_opciones($anios);
	}

	function evt__form_estudios_afines__modificacion($datos)
	{
		$this->get_datos('alumno','antec_estudios_afines')->procesar_filas($datos);
	}


	//-----------------------------------------------------------------------------------
	//---- form_trabajos_publicados -----------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_trabajos_publicados(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_trabajos_publicados')->get_filas()){
			$form_ml->set_datos($this->get_datos('alumno','antec_trabajos_publicados')->get_filas());
		}
	}

	function evt__form_trabajos_publicados__modificacion($datos)
	{
		$this->get_datos('alumno','antec_trabajos_publicados')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_becas_obtenidas ---------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_becas_obtenidas(form_ml_becas_obtenidas $form_ml)
	{
		if($this->get_datos('alumno','antec_becas_obtenidas')->get_filas()){
			$form_ml->set_datos($this->get_datos('alumno','antec_becas_obtenidas')->get_filas());
		}
	}

	function evt__form_becas_obtenidas__modificacion($datos)
	{
		$this->get_datos('alumno','antec_becas_obtenidas')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_present_reuniones -------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_present_reuniones(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_present_reuniones')->get_filas()){
			$form_ml->set_datos($this->get_datos('alumno','antec_present_reuniones')->get_filas());
		}
	}

	function evt__form_present_reuniones__modificacion($datos)
	{
		$this->get_datos('alumno','antec_present_reuniones')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_conoc_idiomas -----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_conoc_idiomas(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_conoc_idiomas')->get_filas()){
			$form_ml->set_datos($this->get_datos('alumno','antec_conoc_idiomas')->get_filas());
		}
	}

	function evt__form_conoc_idiomas__modificacion($datos)
	{
		$this->get_datos('alumno','antec_conoc_idiomas')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_otras_actividades -------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_otras_actividades(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_otras_actividades')->get_filas()){
			$form_ml->set_datos($this->get_datos('alumno','antec_otras_actividades')->get_filas());
		}
	}

	function evt__form_otras_actividades__modificacion($datos)
	{
		$this->get_datos('alumno','antec_otras_actividades')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_part_dict_cursos --------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_part_dict_cursos(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_particip_dict_cursos')->get_filas()){
			$form_ml->set_datos($this->get_datos('alumno','antec_particip_dict_cursos')->get_filas());
		}
	}

	function evt__form_part_dict_cursos__modificacion($datos)
	{
		$this->get_datos('alumno','antec_particip_dict_cursos')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_cursos_perfec_aprob -----------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_cursos_perfec_aprob(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_particip_dict_cursos')->get_filas()){
			$form_ml->set_datos($this->get_datos('alumno','antec_particip_dict_cursos')->get_filas());
		}
	}

	function evt__form_cursos_perfec_aprob__modificacion($datos)
	{
		$this->get_datos('alumno','antec_particip_dict_cursos')->procesar_filas($datos);
	}


	/**
		* Retorna un datos_relación (si no se especifica ninguna tabla en particular), sino, devuelve el datos tabla solicitado
		* @param  string $tabla Nombre de la tabla que se desea obtener (null para obtener el datos_relacion)
		* @return datos_tabla o datos_relacion 
		*/
	function get_datos($relacion,$tabla)
	{
		return $this->controlador()->get_datos($relacion,$tabla);
	}

	/**
		* Retorna el nombre y apellido de un docente
		* @param  array              $datos     Array asociativo que contiene el tipo_doc y el nro_doc
		* @param  toba_ajax_respuesta $respuesta Respuesta que se envía al cliente
		*/
	function ajax__get_docente($datos, toba_ajax_respuesta $respuesta)
	{
		$ayn = toba::consulta_php('co_docentes')->get_ayn($datos['tipo'].'||'.$datos['nro']);
		if( ! $ayn){
			$respuesta->set(array('director'=>'Docente no encontrado','error'=>TRUE));
		}else{
			$respuesta->set(array('director'=>$ayn,'error'=>FALSE));
		}
		
	}

	function ajax__get_disciplinas_incluidas($id_area_conocimiento, toba_ajax_respuesta $respuesta)
	{
		$respuesta->set(toba::consulta_php('co_areas_conocimiento')->get_disciplinas_incluidas($id_area_conocimiento));
	}



	function calcular_puntaje()
	{
		$datos = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		if( ! $datos['id_tipo_beca']){
			return false;
		}
		$factor = toba::consulta_php('co_tipos_beca')->get_factor($datos['id_tipo_beca']);
		if(!$factor){
			return false;
		}
		$puntaje = ($factor * $datos['prom_hist']) - 
					  ($datos['prom_hist_egresados'] / $datos['prom_hist']) +  
				      ($datos['prom_hist_egresados'] * $datos['prom_hist'] / 100);
		return round ($puntaje,3);

	}

}
?>