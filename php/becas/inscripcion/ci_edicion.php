<?php
class ci_edicion extends becas_ci
{
	protected $s__estado_inicial;

	//protected $s__detalles_inscripcion;
	function conf()
	{
		/*if($this->pantalla()->get_etiqueta() != 'Plan de Trabajo'){
			$this->controlador()->pantalla()->eliminar_evento('guardar');
			$this->controlador()->pantalla()->eliminar_evento('eliminar');
		};*/

		//obtengo los datos de la inscripcion
		$datos = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();

		//si se está modificando una inscripción, es necesario validar algunas cosas...
		if($datos){
			//y los datos de la convocatoria
			$conv = array_shift(toba::consulta_php('co_convocatoria_beca')->get_convocatorias(array('id_convocatoria'=>$datos['id_convocatoria'])));
			
			//si ya pasó la fecha de fin de la convocatoria, no se puede editar la inscripcion
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
		}else{
			//si se está cargando una nueva inscripción, se valida si es un usuario normal o un admin
			if( ! in_array('admin',toba::usuario()->get_perfiles_funcionales())){
				//si es un usuario normal, solo puede cargar una solicitud para sí mismo
				$this->dep('form_inscripcion')->ef('nro_documento')->set_estado(toba::usuario()->get_id());
				$this->dep('form_inscripcion')->set_solo_lectura(array('nro_documento'));
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
		//$sql = "SELECT id, descripcion FROM sap_proyectos WHERE descripcion ILIKE ".quote("%".$patron."%")." LIMIT 10";
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
		/* ================== UPLOAD DEL CERTIFICADO ANALÍTICO =================== */
		$conv = toba::consulta_php('co_convocatoria_beca')->get_campo('convocatoria',$datos['id_convocatoria']);
		$tipo_beca = toba::consulta_php('co_tipos_beca')->get_campo('tipo_beca',$datos['id_tipo_beca']);
		$ruta = 'doc_por_convocatoria/'.$conv.'/'.$tipo_beca.'/'.$datos['nro_documento'].'/';
		$efs_archivos = array(array('ef'          => 'archivo_analitico',
							  		'descripcion' => 'Certificado Analítico',
							  		'nombre'      => 'Cert. Analitico.pdf')
							);

		toba::consulta_php('helper_archivos')->procesar_campos($efs_archivos,$datos,$ruta);
		/* ========================================================================= */
		//se asignan los datos del formulario al datos_dabla
		$this->get_datos('inscripcion','inscripcion_conv_beca')->set($datos);
		$this->get_datos('inscripcion','inscripcion_conv_beca')->set(array( 'estado'      => 'A',
																			'fecha_hora'  => date('Y-m-d'),
																			'es_titular'  => 'S',
																			'puntaje'     => $this->calcular_puntaje()
																			
															));

		//esta funcion carga los datos del alumno (si es posible encontrarlo en wl WS o en la base local). En caso contrario envía al usuario a la pantalla de carga de datos de alumno
		$this->set_alumno($datos['nro_documento']);    
		
		//esta funcion carga los datos del director (si es posible encontrarlo en wl WS o en la base local). En caso contrario envía al usuario a la pantalla de carga de datos de director
		if( ! $this->get_datos(NULL,'director')->get()){
			$this->set_director($datos['nro_documento_dir']);
		}

		//cargo el datos_tabla codirector (si es posible)
		if($datos['nro_documento_codir']){
			$this->set_codirector($datos['nro_documento_codir']);
		}

		//cargo el datos_tabla subdirector (si es posible)
		//cargo el datos_tabla codirector (si es posible)
		if($datos['nro_documento_subdir']){
			$this->set_subdirector($datos['nro_documento_subdir']);
		}




		

	}

	protected function set_alumno($nro_documento)
	{
		//Consulto si la persona existe en la BD local (si no existe, se intenta importar desde el WS)
		$existe_persona = toba::consulta_php('co_personas')->existe_persona($nro_documento,'alumno');
		//si no existe el alumno, se obliga al usuario a completar los datos en el formulario "alumno"
		if( ! $existe_persona){
			$this->get_datos('alumno')->resetear();
			$this->get_datos('alumno','alumno')->set(array(
				'nro_documento' => $nro_documento
			));

			
			$this->set_pantalla('pant_alumno');

			throw new toba_error('El Nro. de Documento del alumno ingresado no se corresponde con ningún alumno registrado en el sistema. Por favor, complete los datos personales solicitados a continuación.');

		}else{
			$this->get_datos('alumno')->cargar(array('nro_documento' => $nro_documento));

		}
	}

	protected function set_director($nro_documento)
	{

		//Consulto si la persona existe en la BD local (si no existe, se intenta importar desde el WS)
		$existe_persona = toba::consulta_php('co_personas')->existe_persona($nro_documento,'docente');
		
		//si no existe el alumno, se obliga al usuario a completar los datos en el formulario "alumno"
		if( ! $existe_persona){
			$this->get_datos(NULL,'director')->resetear();
			throw new toba_error('El Nro. de Documento del director ingresado no se corresponde con ningúna persona registrada en el sistema. Por favor, Comuniquese con la Secretaría General de Ciencia y Técnica para obtener una solución.');
		}else{
			//si existe, se cargan los datos del alumno en el datos tabla para la sincronizacion
			$this->get_datos(NULL,'director')->cargar(array(
				'nro_documento' => $nro_documento
			));
			if( ! $this->get_datos(NULL,'director')->esta_cargada()){
				throw new toba_error('El Nro. de Documento del director ingresado corresponde a un persona registrada en el sistema, pero no es docente. Por favor, Comuniquese con la Secretaría General de Ciencia y Técnica para obtener una solución.');
			}
		}
	}

	protected function set_codirector($nro_documento)
	{
		//Consulto si la persona existe en la BD local (si no existe, se intenta importar desde el WS)
		$existe_persona = toba::consulta_php('co_personas')->existe_persona($nro_documento,'docente');
		//si no existe el alumno, se obliga al usuario a completar los datos en el formulario "alumno"
		if( ! $existe_persona){
			$this->get_datos(NULL,'codirector')->resetear();
			throw new toba_error('El Nro. de Documento del co-director ingresado no se corresponde con ningúna persona registrada en el sistema. Por favor, Comuniquese con la Secretaría General de Ciencia y Técnica para obtener una solución.');
		}else{
			//si existe, se cargan los datos del alumno en el datos tabla para la sincronizacion
			$this->get_datos(NULL,'codirector')->cargar(array(
				'nro_documento' => $nro_documento
			));
			if( ! $this->get_datos(NULL,'codirector')->esta_cargada()){
				throw new toba_error('El Nro. de Documento del co-director ingresado corresponde a un persona registrada en el sistema, pero no es docente. Por favor, Comuniquese con la Secretaría General de Ciencia y Técnica para obtener una solución.');
			}
		}
	}

	protected function set_subdirector($id_tipo_doc,$nro_documento)
	{
		//Consulto si la persona existe en la BD local (si no existe, se intenta importar desde el WS)
		$existe_persona = toba::consulta_php('co_personas')->existe_persona($nro_documento,'docente');
		
		//si no existe el alumno, se obliga al usuario a completar los datos en el formulario "alumno"
		if( ! $existe_persona){
			$this->get_datos(NULL,'subdirector')->resetear();
			throw new toba_error('El Nro. de Documento del sub-director ingresado no se corresponde con ningúna persona registrada en el sistema. Por favor, Comuniquese con la Secretaría General de Ciencia y Técnica para obtener una solución.');
		}else{
			//si existe, se cargan los datos del alumno en el datos tabla para la sincronizacion
			$this->get_datos(NULL,'subdirector')->cargar(array(
				'nro_documento' => $nro_documento
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
		$requisitos_inscripcion = toba::consulta_php('co_requisitos_insc')->get_requisitos_insc($datos['id_convocatoria'],$datos['id_tipo_beca'],$datos['nro_documento']);
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
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		if( ! $insc['es_egresado']){
			$form->desactivar_efs(array('archivo_titulo_grado'));
		}
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

		$efs_archivos = array(array('ef'          => 'archivo_titulo_grado',
							 	    'descripcion' => 'Titulo de Grado',
							 	    'nombre'      => 'Titulo Grado.pdf') ,
							  array('ef'          => 'archivo_cuil',
							  	    'descripcion' => 'Constancia de CUIL',
							  	    'nombre'      => 'CUIL.pdf')
							);
							 
		$ruta = 'doc_probatoria/'.$datos['nro_documento'].'/';
		toba::consulta_php('helper_archivos')->procesar_campos($efs_archivos,$datos,$ruta);
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
				'nro_documento' => $dir['nro_documento']
			)));
			$form->set_datos($director);
		}
		
		$form->desactivar_efs(array('id_tipo_doc','nro_documento','cuil','fecha_nac','celular','email','telefono','id_localidad'));
		$form->set_solo_lectura();
	}

	function conf__form_director_docente(becas_ei_formulario $form)
	{
		$form->desactivar_efs(array('legajo','nro_documento'));
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
			$codirector = array_shift(toba::consulta_php('co_personas')->get_personas(array(
				'nro_documento' => $dir['nro_documento']
			)));
			$form->set_datos($codirector);
		}
		
		$form->desactivar_efs(array('id_tipo_doc','nro_documento','cuil','fecha_nac','celular','email','telefono','id_localidad'));
		$form->set_solo_lectura();
	}

	function conf__form_codirector_docente(becas_ei_formulario $form)
	{
		$form->desactivar_efs(array('legajo','nro_documento'));
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
				'nro_documento' => $dir['nro_documento']
			)));
			$form->set_datos($director);
		}
		
		$form->desactivar_efs(array('id_tipo_doc','nro_documento','cuil','fecha_nac','celular','email','telefono','id_localidad'));
		$form->set_solo_lectura();
	}

	function conf__form_subdirector_docente(becas_ei_formulario $form)
	{
		$form->desactivar_efs(array('legajo','nro_documento'));
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
		if($datos['doc_probatoria']){
			//detalles de la inscripcion
			$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
			//nombre de la convocatoria
			$convocatoria = toba::consulta_php('co_convocatoria_beca')->get_campo('convocatoria',$insc['id_convocatoria']);
			//nombre del tipo de beca
			$tipo_beca = toba::consulta_php('co_tipos_beca')->get_campo('tipo_beca',$insc['id_tipo_beca']);
			//conformación de la ruta donde se almacenará el plan de trabajo
			$ruta = 'doc_por_convocatoria/'.$convocatoria.'/'.$tipo_beca.'/'.$insc['nro_documento'].'/';
			//campos que contienen archivos
			$efs_archivos = array(array('ef'          => 'doc_probatoria',
										'descripcion' => 'Plan de Trabajo',
										'nombre'      => "Plan de Trabajo.pdf"
										));
			toba::consulta_php('helper_archivos')->procesar_campos($efs_archivos,$datos,$ruta);
		}
		$this->get_datos('inscripcion','plan_trabajo')->set($datos);
	}

	function conf__pant_plan_trabajo(toba_ei_pantalla $pantalla)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		
		if($insc){
			$template = "<table>
							<tr>
								<td><h1 class='centrado sombreado'>".quote($insc['titulo_plan_beca'])."</h1></td>
							</tr>
							<tr>
								<td>[dep id=form_plan_trabajo]</td>
							</tr>
						</table>";
			$pantalla->set_template($template);	
		}
		
	}


	//-----------------------------------------------------------------------------------
	//---- form_activ_docentes ----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_activ_docentes(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_activ_docentes')->get_filas()){
			$datos = $this->get_datos('alumno','antec_activ_docentes')->get_filas();
			$form_ml->set_datos($datos);
			$this->s__estado_inicial = $datos;
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
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$ruta = "doc_probatoria/".$insc['nro_documento']."/activ_docente/";
		
		$campos = array(
						array('nombre' => 'anio_ingreso'),
						array('nombre' => 'anio_egreso', 'defecto' => 'Actualidad'),
						array('nombre' => 'institucion'),
						array('nombre' => 'cargo')
						);
		
		toba::consulta_php('helper_archivos')->procesar_ml_con_archivos($this->s__estado_inicial,$datos,$ruta,$campos,'doc_probatoria');
		
		$this->get_datos('alumno','antec_activ_docentes')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_estudios_afines ---------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_estudios_afines(becas_ei_formulario_ml $form_ml)
	{
		$datos = $this->get_datos('alumno','antec_estudios_afines')->get_filas();
		if($datos){
			$form_ml->set_datos($datos);
			$this->s__estado_inicial = $datos;
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
		//var_dump($datos); return;
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$ruta = "doc_probatoria/".$insc['nro_documento']."/estudios_afines/";
		$campos = array(
						array('nombre' => 'anio_desde'),
						array('nombre' => 'anio_hasta', 'defecto' => 'Actualidad'),
						array('nombre' => 'institucion'),
						array('nombre' => 'titulo')
						);
		
		toba::consulta_php('helper_archivos')->procesar_ml_con_archivos($this->s__estado_inicial,$datos,$ruta,$campos,'doc_probatoria');
		$this->get_datos('alumno','antec_estudios_afines')->procesar_filas($datos);
	}


	//-----------------------------------------------------------------------------------
	//---- form_becas_obtenidas ---------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_becas_obtenidas(form_ml_becas_obtenidas $form_ml)
	{
		if($this->get_datos('alumno','antec_becas_obtenidas')->get_filas()){
			$datos = $this->get_datos('alumno','antec_becas_obtenidas')->get_filas();
			$form_ml->set_datos($datos);
			$this->s__estado_inicial = $datos;
		}
	}

	function evt__form_becas_obtenidas__modificacion($datos)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$ruta = "doc_probatoria/".$insc['nro_documento']."/becas_obtenidas/";
		$campos = array(
						array('nombre' => 'fecha_desde'),
						array('nombre' => 'fecha_hasta'),
						array('nombre' => 'institucion'),
						array('nombre' => 'tipo_beca')
						);
		
		toba::consulta_php('helper_archivos')->procesar_ml_con_archivos($this->s__estado_inicial,$datos,$ruta,$campos,'doc_probatoria');
		$this->get_datos('alumno','antec_becas_obtenidas')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_trabajos_publicados -----------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_trabajos_publicados(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_trabajos_publicados')->get_filas()){
			$datos = $this->get_datos('alumno','antec_trabajos_publicados')->get_filas();
			$form_ml->set_datos($datos);
			$this->s__estado_inicial = $datos;
		}
	}

	function evt__form_trabajos_publicados__modificacion($datos)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$ruta = "doc_probatoria/".$insc['nro_documento']."/trabajos_publicados/";
		$campos = array(
						array('nombre' => 'fecha'),
						array('nombre' => 'autores')
						);
		
		toba::consulta_php('helper_archivos')->procesar_ml_con_archivos($this->s__estado_inicial,$datos,$ruta,$campos,'doc_probatoria');
		$this->get_datos('alumno','antec_trabajos_publicados')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_present_reuniones -------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_present_reuniones(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_present_reuniones')->get_filas()){
			$datos = $this->get_datos('alumno','antec_present_reuniones')->get_filas();
			$form_ml->set_datos($datos);
			$this->s__estado_inicial = $datos;
		}
	}

	function evt__form_present_reuniones__modificacion($datos)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$ruta = "doc_probatoria/".$insc['nro_documento']."/presentacion_reuniones/";
		$campos = array(
						array('nombre' => 'fecha'),
						array('nombre' => 'autores')
						);
		
		toba::consulta_php('helper_archivos')->procesar_ml_con_archivos($this->s__estado_inicial,$datos,$ruta,$campos,'doc_probatoria');
		$this->get_datos('alumno','antec_present_reuniones')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_conoc_idiomas -----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_conoc_idiomas(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_conoc_idiomas')->get_filas()){
			$datos = $this->get_datos('alumno','antec_conoc_idiomas')->get_filas();
			$form_ml->set_datos($datos);
			$this->s__estado_inicial = $datos;
		}
	}

	function evt__form_conoc_idiomas__modificacion($datos)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$ruta = "doc_probatoria/".$insc['nro_documento']."/conocimiento_idiomas/";
		$campos = array(
						array('nombre' => 'idioma')
						);
		
		toba::consulta_php('helper_archivos')->procesar_ml_con_archivos($this->s__estado_inicial,$datos,$ruta,$campos,'doc_probatoria');
		$this->get_datos('alumno','antec_conoc_idiomas')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_otras_actividades -------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_otras_actividades(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_otras_actividades')->get_filas()){
			$datos = $this->get_datos('alumno','antec_otras_actividades')->get_filas();
			$form_ml->set_datos($datos);
			$this->s__estado_inicial = $datos;
		}
	}

	function evt__form_otras_actividades__modificacion($datos)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$ruta = "doc_probatoria/".$insc['nro_documento']."/otras_actividades/";
		$campos = array(
						array('nombre' => 'institucion'),
						array('nombre' => 'actividad')
						);
		
		toba::consulta_php('helper_archivos')->procesar_ml_con_archivos($this->s__estado_inicial,$datos,$ruta,$campos,'doc_probatoria');
		$this->get_datos('alumno','antec_otras_actividades')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_part_dict_cursos --------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_part_dict_cursos(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_particip_dict_cursos')->get_filas()){
			$datos = $this->get_datos('alumno','antec_particip_dict_cursos')->get_filas();
			$form_ml->set_datos($datos);
			$this->s__estado_inicial = $datos;
		}
	}

	function evt__form_part_dict_cursos__modificacion($datos)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$ruta = "doc_probatoria/".$insc['nro_documento']."/part_dict_cursos/";
		$campos = array(
						array('nombre' => 'fecha'),
						array('nombre' => 'institucion')
						);
		
		toba::consulta_php('helper_archivos')->procesar_ml_con_archivos($this->s__estado_inicial,$datos,$ruta,$campos,'doc_probatoria');
		$this->get_datos('alumno','antec_particip_dict_cursos')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_cursos_perfec_aprob -----------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_cursos_perfec_aprob(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos('alumno','antec_cursos_perfec_aprob')->get_filas()){
			$datos = $this->get_datos('alumno','antec_cursos_perfec_aprob')->get_filas();
			$form_ml->set_datos($datos);
			$this->s__estado_inicial = $datos;
		}
	}

	function evt__form_cursos_perfec_aprob__modificacion($datos)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$ruta = "doc_probatoria/".$insc['nro_documento']."/cursos_perfec_aprob/";
		$campos = array(
						array('nombre' => 'fecha'),
						array('nombre' => 'institucion')
						);
		
		toba::consulta_php('helper_archivos')->procesar_ml_con_archivos($this->s__estado_inicial,$datos,$ruta,$campos,'doc_probatoria');
		$this->get_datos('alumno','antec_cursos_perfec_aprob')->procesar_filas($datos);
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
		$ayn = toba::consulta_php('co_docentes')->get_ayn($datos['nro']);
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

	function ajax__validar_edad($params, toba_ajax_respuesta $respuesta)
	{
		//$mensaje = ($this->edad_permitida_para_beca($params['id_tipo_doc'],$params['nro_documento'],$params['id_tipo_beca']))? TRUE : FALSE;
		$mensaje = $this->edad_permitida_para_beca($params['nro_documento'],$params['id_tipo_beca']);
		$respuesta->set($mensaje);
	}

	function edad_permitida_para_beca($nro_documento, $id_tipo_beca)
	{
		$edad_limite  = toba::consulta_php('co_tipos_beca')->get_campo('edad_limite',$id_tipo_beca);
		//se asegura que exista la persona en la BD local, sino, lo busca en WS
		toba::consulta_php('co_personas')->existe_persona($nro_documento,'alumno');
		$edad_persona =  $this->get_edad($nro_documento,date('Y-12-31'));
		if($edad_persona){
			return $edad_persona <= $edad_limite;
		}
	}

	function get_edad($nro_documento, $fecha)
	{
		$persona = array('nro_documento'=>$nro_documento);
		return toba::consulta_php('co_personas')->get_edad($persona,$fecha);
	}



	function calcular_puntaje()
	{
		$datos = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		if( ! $datos['id_tipo_beca']){
			return false;
		}
		$factor = toba::consulta_php('co_tipos_beca')->get_campo('factor',$datos['id_tipo_beca']);
		if(!$factor){
			return false;
		}
		$puntaje = ($factor * $datos['prom_hist']) - 
					  ($datos['prom_hist_egresados'] / $datos['prom_hist']) +  
				      ($datos['prom_hist_egresados'] * $datos['prom_hist'] / 100);
		return round ($puntaje,3);

	}

	function generar_nro_carpeta(){
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		//si ya tiene numero de carpeta asignado no se hace nada
		if($insc['nro_carpeta']){
			return;
		}
		//se obtiene el prefijo de carpeta para el tipo de beca actual
		$prefijo = toba::consulta_php('co_tipos_beca')->get_campo('prefijo_carpeta',$insc['id_tipo_beca']);
		
		$nro = NULL;
		
		//si el tipo de beca actual tiene asignado un prefijo de carpeta, se busca el último número (o se genera el primero)
		if($prefijo) {
			$nro_carpeta = toba::consulta_php('co_inscripcion_conv_beca')->get_ultimo_nro_carpeta($insc['id_convocatoria'],$insc['id_tipo_beca']);
			if($nro_carpeta){
				if(strpos($nro_carpeta,$prefijo) !== FALSE){
					$partes = explode('-',$nro_carpeta);
					$nro = $prefijo."-".sprintf("%'.03d\n",($partes[1] + 1));
				}
			}else{
				$nro = $prefijo."-001";
				
			}
		}
		$this->get_datos('inscripcion','inscripcion_conv_beca')->set(array('nro_carpeta' => $nro)) ;
	}

	

	
}
?>