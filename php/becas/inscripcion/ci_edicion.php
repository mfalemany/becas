<?php
class ci_edicion extends becas_ci
{
	protected $s__estado_inicial;
	protected $s__insc_actual;
	protected $s__convocatoria;

	//protected $s__detalles_inscripcion;
	function conf()
	{
		$this->agregar_notificacion('<b>Informaci�n importante</b>: una vez que cierre su postulaci�n, su director/a deber� acceder al sistema (con su respectivo usuario) para avalar la postulaci�n. De la misma manera lo har�n el Secretario de Investigaci�n y el Decano de la unidad acad�mica correspondiente. <br> 
			<div class="centrado"><img src="img/coronavirus1.png" height="36px" width="36px"></div>
			<div style="color:#F00; text-align:center; font-weight:bold;">No debe imprimir, firmar ni presentar ninguna documentaci�n en papel.</div><div class="centrado">Todo el proceso se realiza 100% en linea.</div>','warning');
		$es_admin = in_array('admin',toba::usuario()->get_perfiles_funcionales());
		//recupero la convocatoria seleccionada por el usuario
		/*if(toba::memoria()->get_dato('id_convocatoria')){
			$this->s__convocatoria = toba::memoria()->get_dato('id_convocatoria');
			toba::memoria()->eliminar_dato('id_convocatoria');
		}*/

		if($this->get_datos('inscripcion','inscripcion_conv_beca')->get()){
			//obtengo los datos de la inscripcion
			$this->s__insc_actual = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();

			//si la inscripci�n no est� abierta...
			if($this->s__insc_actual['estado'] != 'A'){
				$this->bloquear_formularios();
				$this->controlador()->pantalla()->agregar_evento('ver_comprobante');

			}
			//Si el tipo de beca de la solicitud actual, se encuentra inactivo, el solicitante ya no podr� realizar modificaciones a la misma
			$estado = toba::consulta_php('co_tipos_beca')->get_campo('estado',$this->s__insc_actual['id_tipo_beca']);
			//Estado == INACTIVO??
			if($estado == 'I'){
				$this->bloquear_formularios();
			}
		}else{
			unset($this->s__insc_actual);
			$this->controlador()->pantalla()->eliminar_evento('cerrar_inscripcion');
			$this->controlador()->pantalla()->eliminar_evento('eliminar');
		}
		
		//se carga solamente si se est� editando una inscripci�n existente
		unset($this->s__convocatoria);

		//si se est� modificando una inscripci�n, es necesario validar algunas cosas...
		if(isset($this->s__insc_actual)){
			//y los datos de la convocatoria
			$conv = toba::consulta_php('co_convocatoria_beca')->get_convocatorias(array('id_convocatoria'=>$this->s__insc_actual['id_convocatoria']));
			$this->s__convocatoria = array_shift($conv);
			
			//si ya pas� la fecha de fin de la convocatoria, no se puede editar la inscripcion (salvo que llame pekermannnn o seas administrador)
			if(($this->s__convocatoria['fecha_hasta'] < date('Y-m-d')) && (!$es_admin) ){
				//bloqueo el formulario para evitar que se modifiquen  los datos
				$this->dep('form_inscripcion')->agregar_notificacion('No se pueden modificar los datos de la inscripci�n debido a que finaliz� la convocatoria.','warning');
				$this->bloquear_formularios();

				//elimino todas las pantallas que no sean el formulario de inscripci?
				$this->pantalla()->eliminar_tab('pant_alumno');
				$this->pantalla()->eliminar_tab('pant_director');

				//elimino los eventos que me permiten alterar los datos de la inscripcion
				$this->controlador()->pantalla()->eliminar_evento('guardar');
				$this->controlador()->pantalla()->eliminar_evento('eliminar');
			}
		}
		//si se est?cargando una nueva inscripci?, se valida si es un usuario normal o un admin
		if( ! $es_admin){
			//si es un usuario normal, solo puede cargar una solicitud para s?mismo
			$this->dep('form_inscripcion')->ef('nro_documento')->set_estado(toba::usuario()->get_id());
			$this->dep('form_inscripcion')->set_solo_lectura(array('nro_documento'));

		}
		

		//si no est? cargados el codirector y/o subdirector, se deshabilitan las pesta?s correspondientes
		if( (!isset($this->s__insc_actual['nro_documento_dir'])) || (!$this->s__insc_actual['nro_documento_dir']) ){
			$this->pantalla()->tab('pant_director')->desactivar();
		}
		//si no est? cargados el codirector y/o subdirector, se deshabilitan las pesta?s correspondientes
		if( (!isset($this->s__insc_actual['nro_documento_codir'])) || (!$this->s__insc_actual['nro_documento_codir']) ){
			$this->pantalla()->eliminar_tab('pant_codirector');
		}
		if( (!isset($this->s__insc_actual['nro_documento_subdir'])) || (!$this->s__insc_actual['nro_documento_subdir']) ){
			$this->pantalla()->eliminar_tab('pant_subdirector');
		}
	}

	private function bloquear_formularios()
	{
		//obtengo todos los formularios que dependen del CI
		$deps = $this->get_dependencias_clase('form');
		foreach($deps as $dep){
			//y los marco como solo lectura (el usuario no puede modificar nada)
			$this->dep($dep)->set_solo_lectura();
			//y si es un ML, desactivo el agregado de filas
			if(method_exists($this->dep($dep), 'desactivar_agregado_filas')){
				$this->dep($dep)->desactivar_agregado_filas();
			}
		}
		//adem?, elimino todos los eventos que puedan modificar la solicitud
		$this->controlador()->pantalla()->eliminar_evento('eliminar');
		$this->controlador()->pantalla()->eliminar_evento('guardar');
		$this->controlador()->pantalla()->eliminar_evento('cerrar_inscripcion');

	}

	//-----------------------------------------------------------------------------------
	//---- form_inscripcion -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_inscripcion(becas_ei_formulario $form)
	{
		/* SE EVAL�A SI HAY QUE CARGAR SOLO LA OPCION DE CONVOCATORIA ACTUAL O TODAS LAS ANTERIORES */
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$opciones['nopar'] = '-- Seleccione --';
		if($insc){
			$opciones[$insc['id_convocatoria']] = toba::consulta_php('co_convocatoria_beca')->get_campo('convocatoria',$insc['id_convocatoria']);
		}else{
			$convs = toba::consulta_php('co_convocatoria_beca')->get_convocatorias(array(),TRUE);
			foreach ($convs as $conv) {
				$opciones[$conv['id_convocatoria']] = $conv['convocatoria']; 
			}
		}
		/* ================================================================================ */

		$form->ef('id_convocatoria')->set_opciones($opciones);

		if(isset($this->s__insc_actual)){
			//se bloquean las opciones de convocatorias para que el usuario no pueda modicarlos
			$form->set_solo_lectura(array('id_tipo_beca','id_convocatoria'));
			
			//asigno los datos al formulario
			$form->set_datos($this->s__insc_actual);

			//se completa el label que contiene el nombre y apellido del director
			$form->set_datos(array('director'=>toba::consulta_php('co_personas')->get_ayn($this->s__insc_actual['nro_documento_dir'])));

			//se completa el label que contiene el nombre y apellido del codirector
			if($this->s__insc_actual['nro_documento_codir']){
				$form->set_datos(array('codirector'=>toba::consulta_php('co_personas')->get_ayn($this->s__insc_actual['nro_documento_codir'])));	
			}
			//se completa el label que contiene el nombre y apellido del subdirector
			if($this->s__insc_actual['nro_documento_subdir']){
				$form->set_datos(array('subdirector'=>toba::consulta_php('co_personas')->get_ayn($this->s__insc_actual['nro_documento_subdir'])));	
			}

			$efs_involucrados = array('archivo_insc_posgrado','titulo_carrera_posgrado','nombre_inst_posgrado','carrera_posgrado','fecha_insc_posgrado');
			//verifico si el tipo de beca requiere o no una inscripcion a posgrado.
			$requiere = toba::consulta_php('co_tipos_beca')->requiere_posgrado($this->s__insc_actual['id_tipo_beca']);
			//en caso de no requerir inscripci? a Posgrado, desactivo todos los efs relacionados
			if(!$requiere){
				
				foreach ($efs_involucrados as $ef) {
					if($form->existe_ef($ef)){
						$form->desactivar_efs($ef);
					}
				}
			}else{
				$form->set_efs_obligatorios($efs_involucrados);
			}

		}else{
			$this->pantalla()->tab('pant_director')->desactivar();
		}
		
	}

	function evt__form_inscripcion__modificacion($datos)
	{

		/* ================== UPLOAD DEL CERTIFICADO ANAL?ICO =================== */
		$conv = toba::consulta_php('co_convocatoria_beca')->get_campo('convocatoria',$datos['id_convocatoria']);
		$tipo_beca = toba::consulta_php('co_tipos_beca')->get_campo('tipo_beca',$datos['id_tipo_beca']);
		$ruta = 'becas/doc_por_convocatoria/'.$conv.'/'.$tipo_beca.'/'.$datos['nro_documento'].'/';
		$efs_archivos[] = array('ef'          => 'archivo_analitico',
						  		'descripcion' => 'Certificado Analitico',
						  		'nombre'      => 'Cert. Analitico.pdf'
								);
		$efs_archivos[] = array('ef'          => 'archivo_insc_posgrado',
							  	'descripcion' => 'Const. Inscripcion a Posgrado(o compromiso) ',
							  	'nombre'      => 'Insc. o Compromiso Posgrado.pdf'
								);
		toba::consulta_php('helper_archivos')->procesar_campos($efs_archivos,$datos,$ruta);
		/* ========================================================================= */

		/* ============ UPLOAD DE LA CONST. INSCRIPCI? A POSGRADO ================= */
/*		if(isset($datos['archivo_insc_posgrado'])){
			if( ! $datos['archivo_insc_posgrado']['error']){
				$ruta = 'doc_por_convocatoria/'.$conv.'/'.$tipo_beca.'/'.$datos['nro_documento'].'/';
				$efs_archivos = array(array('ef'          => 'archivo_insc_posgrado',
									  		'descripcion' => 'Const. Inscripci? a Posgrado(o compromiso) ',
									  		'nombre'      => 'Insc. o Compromiso Posgrado.pdf')
									);

				toba::consulta_php('helper_archivos')->procesar_campos($efs_archivos,$datos,$ruta);
			}
		}*/
		/* ========================================================================= */


		//se asignan los datos del formulario al datos_dabla
		$this->get_datos('inscripcion','inscripcion_conv_beca')->set($datos);
		$estado = ($this->s__insc_actual['estado']) ? $this->s__insc_actual['estado'] : 'A';
		$fecha_hora = ($this->s__insc_actual['fecha_hora']) ? $this->s__insc_actual['fecha_hora'] : date('Y-m-d H:i:s');
		$this->get_datos('inscripcion','inscripcion_conv_beca')->set(array( 'estado'      => $estado,
																			'fecha_hora'  => $fecha_hora,
																			'es_titular'  => 'S',
																			'puntaje'     => $this->calcular_puntaje()
																			
															));

		

		
		//esta funcion carga los datos del director (si es posible encontrarlo en wl WS o en la base local). En caso contrario env? al usuario a la pantalla de carga de datos de director
		if( ! $this->existe_persona($datos['nro_documento_dir'])){
			throw new toba_error('El Nro. de Documento del director ingresado no se corresponde con ninguna persona registrada en el sistema. Por favor, Comuniquese con la Secretar�a General de Ciencia y T�cnica para obtener una soluci�n.');
		}
		if($datos['nro_documento_codir']){
			if( ! $this->existe_persona($datos['nro_documento_codir'])){
				throw new toba_error('El Nro. de Documento del Co-Director ingresado no se corresponde con ninguna persona registrada en el sistema. Por favor, Comuniquese con la Secretar�a General de Ciencia y T�cnica para obtener una soluci�n.');
			}
		}

		if($datos['nro_documento_subdir']){
			if( ! $this->existe_persona($datos['nro_documento_subdir'])){
				throw new toba_error('El Nro. de Documento del Sub-Director ingresado no se corresponde con ninguna persona registrada en el sistema. Por favor, Comuniquese con la Secretar�a General de Ciencia y T�cnica para obtener una soluci�n.');
			}
		}

		//esta funcion carga los datos del alumno (si es posible encontrarlo en wl WS o en la base local). En caso contrario env? al usuario a la pantalla de carga de datos de alumno
		if( ! $this->existe_persona($datos['nro_documento']) ){
			$this->get_datos('alumno')->resetear();
			$this->get_datos('alumno','persona')->set(array(
				'nro_documento' => $datos['nro_documento']
			));
			$this->set_pantalla('pant_alumno');

			throw new toba_error('El Nro. de Documento del alumno ingresado no se corresponde con ning�n alumno registrado en el sistema. Por favor, complete los datos personales solicitados a continuaci�n.');
		}

	}

	private function existe_persona($nro_documento)
	{
		return toba::consulta_php('co_personas')->existe_persona($nro_documento);
	}


	/**
		* Esta funcion genera los registros que tienen que ver con la inscriopcion, pero que pertenecen a otras tablas, 
		* como por ejemplo, los registros en la tabla 'requisitos_insc' que registra cuales de los requisitos de esa
		* convocatoria fueron entregados por el alumno
	**/
	function generar_registros_relacionados()
	{
		//si ya tiene los requisitos generados, no se generan nuevamente
		if($this->get_datos('inscripcion','requisitos_insc')->get_filas()){
			return;
		}

		if(isset($this->s__insc_actual)){
			$insc = $this->s__insc_actual;
		}else{
			//si no se est?modificando una solicitud existente, utilizo los datos recien cargados al datos_tabla
			$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		}

		//verifico si ya se crearon los registros para el cumplimiento de requisitos
		$requisitos_inscripcion = toba::consulta_php('co_requisitos_insc')->get_requisitos_insc(
			$insc['id_convocatoria'],
			$insc['id_tipo_beca'],
			$insc['nro_documento']
		);
		
		//la insercion de los requisitos iniciales se realiza solo una vez
		if($requisitos_inscripcion){
			return;
		}
		
		$requisitos = toba::consulta_php('co_requisitos_convocatoria')->get_requisitos_iniciales($insc['id_convocatoria']);
		
		foreach($requisitos as $requisito){
			$this->get_datos('inscripcion','requisitos_insc')->nueva_fila($requisito);
		}
	}
	
	//-----------------------------------------------------------------------------------
	//---- form_alumno ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_alumno(becas_ei_formulario $form)
	{	
		//borra el estado de los efs (bug por la reutilizaci�n del form_personas)
		unset($form->_memoria['efs']);
		
		//seteo como obligatorios los campos necesarios
		$form->ef('archivo_cuil')->set_obligatorio();
		$form->ef('archivo_dni')->set_obligatorio();

		//desactivo los efs innecesarios para un alumno
		if($form->existe_ef('id_disciplina')){
			$form->desactivar_efs(array('id_disciplina','archivo_cvar','id_nivel_academico'));		
		}
		
		

		//si existe una inscripci�n actual
		if($this->s__insc_actual){
			$alu = toba::consulta_php('co_personas')->get_personas(array('nro_documento' => $this->s__insc_actual['nro_documento']));
			$alu = array_shift($alu);
			$alu['nro_documento'] = ($alu['nro_documento']) ? $alu['nro_documento'] : $this->s__insc_actual['nro_documento']; 
			if(isset($alu['cuil'])){
				$alu['cuil'] = str_replace("-","",$alu['cuil']);
			}

			//El campo archivo_dni no se guarda en la BD, solo se valida con la existencia del archivo
			$archivo = toba::consulta_php('helper_archivos')->ruta_base()."/docum_personal/".$alu['nro_documento']."/dni.pdf";
			
			if(file_exists($archivo)){
				$alu['archivo_dni'] = 'dni.pdf';
			}	

			$form->set_datos($alu);
			
			$form->set_efs_obligatorios(array('cuil','celular'));
			$form->set_solo_lectura(array('nro_documento'));

			if(isset($alu['apellido'])){
				$form->set_solo_lectura(array('apellido'));
			}
			if(isset($alu['nombres'])){
				$form->set_solo_lectura(array('nombres'));
			}



		}
	}

	function evt__form_alumno__modificacion($datos)
	{
		if(isset($datos['cuil'])){
			$datos['cuil'] = str_replace("-","",$datos['cuil']);
		}
		$efs_archivos = array(array('ef'          => 'archivo_titulo_grado',
							 	    'descripcion' => 'Titulo de Grado',
							 	    'nombre'      => 'Titulo Grado.pdf') ,
							  array('ef'          => 'archivo_cuil',
							  	    'descripcion' => 'Constancia de CUIL',
							  	    'nombre'      => 'CUIL.pdf'),
							  array('ef'          => 'archivo_dni',
							 	    'descripcion' => 'Copia de DNI',
							 	    'nombre'      => 'dni.pdf')
							);
							 
		$ruta = 'docum_personal/'.$datos['nro_documento'].'/';
		toba::consulta_php('helper_archivos')->procesar_campos($efs_archivos,$datos,$ruta);
		$this->sincronizar_datos_persona($datos);
	}

	
	

	//-----------------------------------------------------------------------------------
	//---- form_director ----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_director(becas_ei_formulario $form)
	{
		//borra el estado de los efs (bug por la reutilizaci�n del form_personas)
		unset($form->_memoria['efs']);

		if(isset($this->s__insc_actual['nro_documento_dir']) && $this->s__insc_actual['nro_documento_dir']){
			$dir = $this->s__insc_actual['nro_documento_dir'];	
		
			$director = toba::consulta_php('co_personas')->get_personas(array('nro_documento' => $dir));
			$director = array_shift($director);
			$form->set_datos($director);
		}
		$form->set_efs_obligatorios(array('cuil','celular'));
		$form->desactivar_efs(array('id_tipo_doc','fecha_nac','telefono','id_localidad','archivo_titulo_grado','archivo_cuil','archivo_dni','id_nivel_academico'));
		$form->set_solo_lectura(array('nro_documento','apellido','nombres'));
	}

	function evt__form_director__modificacion($datos)
	{
		if(isset($datos['cuil'])){
			$datos['cuil'] = str_replace("-","",$datos['cuil']);
		}
		$this->procesar_cvar_director($datos);
		$this->sincronizar_datos_persona($datos);
		
	}

	function procesar_cvar_director(&$datos)
	{
		//campos que contienen archivos
		$ruta = 'docum_personal/'.$datos['nro_documento'].'/';
		$efs_archivos = array(array('ef'          => 'archivo_cvar',
									'descripcion' => 'CVAr',
									'nombre'      => "cvar.pdf"
									));
		toba::consulta_php('helper_archivos')->procesar_campos($efs_archivos,$datos,$ruta);
	}

	//-----------------------------------------------------------------------------------
	//---- form_codirector --------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	
	function conf__form_codirector(becas_ei_formulario $form)
	{
		
		//borra el estado de los efs (bug por la reutilizaci�n del form_personas)
		unset($form->_memoria['efs']);

		if(isset($this->s__insc_actual['nro_documento_codir']) && $this->s__insc_actual['nro_documento_codir']){
			$dir = $this->s__insc_actual['nro_documento_codir'];
			$director = toba::consulta_php('co_personas')->get_personas(array(
				'nro_documento' => $dir
			));
			$director = array_shift($director);
			$form->set_datos($director);	
		}
		$form->set_efs_obligatorios(array('cuil','celular'));
		$form->desactivar_efs(array('id_tipo_doc','fecha_nac','telefono','id_localidad','archivo_titulo_grado','archivo_cuil','archivo_dni','id_nivel_academico'));
		$form->set_solo_lectura(array('nro_documento','apellido','nombres'));
		
	}

	function evt__form_codirector__modificacion($datos)
	{
		if(isset($datos['cuil'])){
			$datos['cuil'] = str_replace("-","",$datos['cuil']);
		}

		$this->procesar_cvar_director($datos);
		$this->sincronizar_datos_persona($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_codirector_justif -------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_codirector_justif(becas_ei_formulario $form)
	{
		if($this->s__insc_actual && isset($this->s__insc_actual['justif_codirector'])){
			$form->set_datos(array('justif_codirector' => $this->s__insc_actual['justif_codirector']));
			
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
		//borra el estado de los efs (bug por la reutilizaci�n del form_personas)
		unset($form->_memoria['efs']);

		if(isset($this->s__insc_actual['nro_documento_subdir']) && $this->s__insc_actual['nro_documento_subdir']){
			$dir = $this->s__insc_actual['nro_documento_subdir'];
			$director = toba::consulta_php('co_personas')->get_personas(array('nro_documento' => $dir));
			$director = array_shift($director);
			$form->set_datos($director);	
		}
		
		
		$form->set_efs_obligatorios(array('cuil','celular'));
		$form->desactivar_efs(array('id_tipo_doc','fecha_nac','telefono','id_localidad','archivo_titulo_grado','archivo_cuil','archivo_dni','id_nivel_academico'));
		$form->set_solo_lectura(array('nro_documento'));
	}

	function evt__form_subdirector__modificacion($datos)
	{
		if(isset($datos['cuil'])){
			$datos['cuil'] = str_replace("-","",$datos['cuil']);
		}
		$this->procesar_cvar_director($datos);
		$this->sincronizar_datos_persona($datos);
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
			//conformaci? de la ruta donde se almacenar?el plan de trabajo
			$ruta = 'becas/doc_por_convocatoria/'.$convocatoria.'/'.$tipo_beca.'/'.$insc['nro_documento'].'/';
			//campos que contienen archivos
			$efs_archivos = array(array('ef'          => 'doc_probatoria',
										'descripcion' => 'Plan de Trabajo',
										'nombre'      => "Plan de Trabajo.pdf"
										));
			toba::consulta_php('helper_archivos')->procesar_campos($efs_archivos,$datos,$ruta);
		}else{
			unset($datos['doc_probatoria']);
		}
		$this->get_datos('inscripcion','plan_trabajo')->set($datos);
	}

	function conf__pant_plan_trabajo(toba_ei_pantalla $pantalla)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		
		if($insc){
			$template = "<table width='100%'>
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
		$this->get_datos('alumno')->cargar(array('nro_documento'=>$this->s__insc_actual['nro_documento']));
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

		//se sincroniza porque el datos tabla que referencia a "sap_personas" se utiliza tanto para alumnos como para director, codirector y subdirector. Esto provoca que el datos_relacion "Alumno" se resetee entre cambios de pesta? y provocando la perdida de las tablas hijas, como antec_activ_docentes
		$this->get_datos('alumno')->sincronizar();
	}

	//-----------------------------------------------------------------------------------
	//---- form_estudios_afines ---------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_estudios_afines(becas_ei_formulario_ml $form_ml)
	{
		$this->get_datos('alumno')->cargar(array('nro_documento'=>$this->s__insc_actual['nro_documento']));
		$datos = $this->get_datos('alumno','antec_estudios_afines')->get_filas();
		if($datos){
			$form_ml->set_datos($datos);
			$this->s__estado_inicial = $datos;
		}
		
		//se arma un array para cargar los combos de a?is
		for($i=date("Y");$i>(date("Y")-50);$i--){
			$anios[$i] = $i;
		}
		$form_ml->ef('anio_desde')->set_opciones($anios);
		$form_ml->ef('anio_hasta')->set_opciones($anios);
	}

	function evt__form_estudios_afines__modificacion($datos)
	{
		
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
		//se sincroniza porque el datos tabla que referencia a "sap_personas" se utiliza tanto para alumnos como para director, codirector y subdirector. Esto provoca que el datos_relacion "Alumno" se resetee entre cambios de pesta? y provocando la perdida de las tablas hijas
		$this->get_datos('alumno')->sincronizar();
	}


	//-----------------------------------------------------------------------------------
	//---- form_becas_obtenidas ---------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_becas_obtenidas(form_ml_becas_obtenidas $form_ml)
	{
		$this->get_datos('alumno')->cargar(array('nro_documento'=>$this->s__insc_actual['nro_documento']));
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
		//se sincroniza porque el datos tabla que referencia a "sap_personas" se utiliza tanto para alumnos como para director, codirector y subdirector. Esto provoca que el datos_relacion "Alumno" se resetee entre cambios de pesta? y provocando la perdida de las tablas hijas
		$this->get_datos('alumno')->sincronizar();
	}

	//-----------------------------------------------------------------------------------
	//---- form_trabajos_publicados -----------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_trabajos_publicados(becas_ei_formulario_ml $form_ml)
	{
		$this->get_datos('alumno')->cargar(array('nro_documento'=>$this->s__insc_actual['nro_documento']));
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
		//se sincroniza porque el datos tabla que referencia a "sap_personas" se utiliza tanto para alumnos como para director, codirector y subdirector. Esto provoca que el datos_relacion "Alumno" se resetee entre cambios de pesta? y provocando la perdida de las tablas hijas
		$this->get_datos('alumno')->sincronizar();
	}

	//-----------------------------------------------------------------------------------
	//---- form_present_reuniones -------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_present_reuniones(becas_ei_formulario_ml $form_ml)
	{
		$this->get_datos('alumno')->cargar(array('nro_documento'=>$this->s__insc_actual['nro_documento']));
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
		//se sincroniza porque el datos tabla que referencia a "sap_personas" se utiliza tanto para alumnos como para director, codirector y subdirector. Esto provoca que el datos_relacion "Alumno" se resetee entre cambios de pesta? y provocando la perdida de las tablas hijas
		$this->get_datos('alumno')->sincronizar();
	}

	//-----------------------------------------------------------------------------------
	//---- form_conoc_idiomas -----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_conoc_idiomas(becas_ei_formulario_ml $form_ml)
	{
		$this->get_datos('alumno')->cargar(array('nro_documento'=>$this->s__insc_actual['nro_documento']));
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
		//se sincroniza porque el datos tabla que referencia a "sap_personas" se utiliza tanto para alumnos como para director, codirector y subdirector. Esto provoca que el datos_relacion "Alumno" se resetee entre cambios de pesta? y provocando la perdida de las tablas hijas
		$this->get_datos('alumno')->sincronizar();

	}

	//-----------------------------------------------------------------------------------
	//---- form_otras_actividades -------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_otras_actividades(becas_ei_formulario_ml $form_ml)
	{
		$this->get_datos('alumno')->cargar(array('nro_documento'=>$this->s__insc_actual['nro_documento']));
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
		//se sincroniza porque el datos tabla que referencia a "sap_personas" se utiliza tanto para alumnos como para director, codirector y subdirector. Esto provoca que el datos_relacion "Alumno" se resetee entre cambios de pesta? y provocando la perdida de las tablas hijas
		$this->get_datos('alumno')->sincronizar();
	}

	//-----------------------------------------------------------------------------------
	//---- form_part_dict_cursos --------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_part_dict_cursos(becas_ei_formulario_ml $form_ml)
	{
		$this->get_datos('alumno')->cargar(array('nro_documento'=>$this->s__insc_actual['nro_documento']));
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
		//se sincroniza porque el datos tabla que referencia a "sap_personas" se utiliza tanto para alumnos como para director, codirector y subdirector. Esto provoca que el datos_relacion "Alumno" se resetee entre cambios de pesta? y provocando la perdida de las tablas hijas
		$this->get_datos('alumno')->sincronizar();
	}

	//-----------------------------------------------------------------------------------
	//---- form_cursos_perfec_aprob -----------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_cursos_perfec_aprob(becas_ei_formulario_ml $form_ml)
	{
		$this->get_datos('alumno')->cargar(array('nro_documento'=>$this->s__insc_actual['nro_documento']));
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
		//se sincroniza porque el datos tabla que referencia a "sap_personas" se utiliza tanto para alumnos como para director, codirector y subdirector. Esto provoca que el datos_relacion "Alumno" se resetee entre cambios de pesta? y provocando la perdida de las tablas hijas
		$this->get_datos('alumno')->sincronizar();
	}


	/**
		* Retorna un datos_relaci? (si no se especifica ninguna tabla en particular), sino, devuelve el datos tabla solicitado
		* @param  string $tabla Nombre de la tabla que se desea obtener (null para obtener el datos_relacion)
		* @return datos_tabla o datos_relacion 
		*/
	function get_datos($relacion,$tabla=NULL)
	{
		return $this->controlador()->get_datos($relacion,$tabla);
	}

	/**
		* Retorna el nombre y apellido de un docente
		* @param  array              $datos     Array asociativo que contiene el tipo_doc y el nro_doc
		* @param  toba_ajax_respuesta $respuesta Respuesta que se env? al cliente
		*/
	function ajax__get_persona($datos, toba_ajax_respuesta $respuesta)
	{
		if( ! toba::consulta_php('co_personas')->existe_persona($datos['nro_documento'])){
			$respuesta->set(array('persona'=>NULL,'error'=>TRUE,'campo'=>$datos['campo']));
		}
		$ayn = toba::consulta_php('co_personas')->get_ayn($datos['nro_documento']);
		if( ! $ayn){
			$respuesta->set(array('persona'=>NULL,'error'=>TRUE,'campo'=>$datos['campo']));
		}else{
			$respuesta->set(array('persona'=>$ayn,'error'=>FALSE,'campo'=>$datos['campo']));
		}
		
	}

	function ajax__get_disciplinas_incluidas($id_area_conocimiento, toba_ajax_respuesta $respuesta)
	{
		$respuesta->set(toba::consulta_php('co_areas_conocimiento')->get_disciplinas_incluidas($id_area_conocimiento));
	}

	function ajax__validar_edad($params, toba_ajax_respuesta $respuesta)
	{
		//$mensaje = ($this->edad_permitida_para_beca($params['id_tipo_doc'],$params['nro_documento'],$params['id_tipo_beca']))? TRUE : FALSE;
		$permitida = $this->edad_permitida_para_beca($params['nro_documento'],$params['id_tipo_beca']);
		if( ! $permitida){
			$respuesta->set(array('error'=>1,'mensaje'=>'La persona indicada como postulante supera la edad l�mite para el tipo de beca al que intenta inscribirse. Esto har� que la inscripci�n resulte inadmisible.' ));
		}else{
			$respuesta->set(array('error'=>0,'mensaje'=>'La edad del postulante es correcta'));
		}
		
	}

	function ajax__validar_minimo_materias_exigidas($params, toba_ajax_respuesta $respuesta)
	{
		$exigido = toba::consulta_php('co_tablas_basicas')->get_parametro_conf('beca_pregrado_porcentaje_min_aprobacion');
		if($exigido){
			if( ($params['materias_aprobadas'] / $params['materias_plan'] * 100) < floatval($exigido) ){
				$respuesta->set(array('error'=>1,'mensaje'=>"Usted no cumple con el $exigido% de materias aprobadas exigidas para este tipo de becas. Por ello, su postulaci�n podr�a resultar no admitida"));
			}else{
				$respuesta->set(array('error'=>0,'mensaje'=>'El postulante tiene las materias minimas exigidas'));
			}
		}
	}

	function ajax__requiere_inscripcion_posgrado($params, toba_ajax_respuesta $respuesta)
	{
		$requiere = toba::consulta_php('co_tipos_beca')->requiere_posgrado($params);
		$respuesta->set($requiere);
		
	}

	function edad_permitida_para_beca($nro_documento, $id_tipo_beca)
	{
		$edad_limite  = toba::consulta_php('co_tipos_beca')->get_campo('edad_limite',$id_tipo_beca);
		//se asegura que exista la persona en la BD local, sino, lo busca en WS
		if( ! toba::consulta_php('co_personas')->existe_persona($nro_documento)){
			return NULL;
		}

		$edad_persona =  $this->get_edad($nro_documento,date('Y-12-31'));
		if($edad_persona){
			return $edad_persona <= $edad_limite;
		}else{
			return NULL;
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
		//Si es un tipo de beca que no suma puntaje por antecedentes academicos, suma 0.
		if( ! toba::consulta_php('co_tipos_beca')->suma_puntaje_academico($datos['id_tipo_beca'])){
			return 0;
		}
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
		if(isset($insc['nro_carpeta'])){
			return;
		}

		$nro = toba::consulta_php('co_inscripcion_conv_beca')->get_ultimo_nro_carpeta($insc['id_convocatoria'],$insc['id_tipo_beca']);
		$this->get_datos('inscripcion','inscripcion_conv_beca')->set(array('nro_carpeta' => $nro));
	}

	function sincronizar_datos_persona($datos)
	{
		//reseteo el datos table, sincronizo, y vuelvo al estado original
		$this->get_datos('alumno','persona')->resetear();
		$this->get_datos('alumno','persona')->cargar(array('nro_documento'=>$datos['nro_documento']));

		$this->get_datos('alumno','persona')->set($datos);
		$this->get_datos('alumno','persona')->sincronizar();


		$this->get_datos('alumno','persona')->resetear();
		$this->get_datos('alumno','persona')->cargar(array('nro_documento'=>$datos['nro_documento']));
	}

	//se usa para llenar los tres formularios de categoria conicet
	private function get_categoria_conicet($nro_documento)
	{
		return toba::consulta_php('co_cat_conicet_persona')->get_categoria_persona($nro_documento);
	}

	//se usa para setear los tres formularios de categorias conicet
	private function set_categoria_conicet($datos){
		if(isset($datos['id_cat_conicet']) && isset($datos['lugar_trabajo'])){
			$cat = toba::consulta_php('co_cat_conicet_persona')->get_categoria_persona($datos['nro_documento']);
			if(count($cat)){
				$this->get_datos(NULL,'cat_conicet_persona')->cargar(array('nro_documento'=>$datos['nro_documento']));
			}
			$this->get_datos(NULL,'cat_conicet_persona')->set($datos);
			$this->get_datos(NULL,'cat_conicet_persona')->sincronizar();
			$this->get_datos(NULL,'cat_conicet_persona')->resetear();
		}

	}

	

	
}
?>