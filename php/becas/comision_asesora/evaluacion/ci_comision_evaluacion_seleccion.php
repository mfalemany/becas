<?php
class ci_comision_evaluacion_seleccion extends becas_ci
{
	protected $s__filtro;
	protected $ruta_documentos; //url
	protected $path_documentos; //ruta local
	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf()
	{
		//ubicacion del directorio donde se guardan los documentos
		$this->ruta_documentos = 'http://becas.cyt.unne.edu.ar/documentos';
		$this->path_documentos = '/mnt/datos/cyt';
	}

	function evt__volver()
	{
		$this->get_datos()->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	function evt__guardar()
	{
		try {

			$this->get_datos()->sincronizar();	
			$this->get_datos()->resetear();
			$this->set_pantalla('pant_seleccion');
		}catch(toba_error_db $e){
			toba::notificacion()->agregar($e->get_mensaje_motor(),'error');
		}catch (Exception $e) {
			toba::notificacion()->agregar($e->getMessage(),'error');
		}
		
		
	}

	//-----------------------------------------------------------------------------------
	//---- cu_postulaciones -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_postulaciones(becas_ei_cuadro $cuadro)
	{
		$filtro = ($this->s__filtro) ? $this->s__filtro : array();
		
		//Solo inscripciones cerradas y admitidas
		$filtro['admisible'] = 'S';
		$filtro['estado'] = 'C';

		$cuadro->set_datos(toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones($filtro));
	}

	function evt__cu_postulaciones__seleccion($seleccion)
	{
		$this->get_datos()->cargar($seleccion);
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


	function conf__pant_edicion(toba_ei_pantalla $pantalla)
	{
		//Obtengo el array con las claves seleccionadas por el usuario
		$seleccion = $this->get_datos('inscripcion_conv_beca')->get();
		//busco todos los detalles de la postulación
		$detalles = toba::consulta_php('co_inscripcion_conv_beca')->get_detalles_comprobante($seleccion);
		
		//si el tipo de beca contempla el puntaje académico, lo muestro al evaluador
		$puntaje = ($detalles['beca']['suma_puntaje_academico'] == 'S') ? "<h1 id='puntaje_inicial'>Puntaje Inicial: ".$detalles['postulante']['puntaje']."</h1>" : "";
		
		/* EL TEMPLATE COMPLETO SE ARMA EN FORMA ESCALONADA: EN EL NIVEL MAS BAJO, SE GENERA EL TEMPLATE CON LOS CARGOS DEL DIRECTOR (CO-DIRECTOR Y/O SUB-DIRECTO). ESE MINI-TEMPLATE SE EMBEBE DENTRO DEL TEMPLATE DE DIRECTOR, Y LUEGO, AMBOS DENTRO DEL TEMPLATE COMPLETO */

		//ruta al plan de trabajo
		$plan = $this->ruta_documentos.'/becas/doc_por_convocatoria/'.$detalles['beca']['convocatoria']."/".$detalles['beca']['tipo_beca']."/".$detalles['postulante']['nro_documento']."/Plan de Trabajo.pdf";
		
		//la variable datos contendrá todos los valores que irán al template
		$datos = array(
			'titulo_plan_beca'  => $detalles['beca']['titulo_plan_beca'],
			'proyecto_nombre'   => $detalles['proyecto']['proyecto'],
			'nombre_postulante' => $detalles['postulante']['apellido'].", ".$detalles['postulante']['nombres'],
			'cuil'              => $detalles['postulante']['cuil'],
			'carrera'           => $detalles['postulante']['carrera'],
			'tipo_beca'         => ucwords(strtolower($detalles['beca']['tipo_beca'])),
			'nro_carpeta'       => $detalles['beca']['nro_carpeta'],
			'area_conocimiento' => ucwords(strtolower($detalles['beca']['area_conocimiento'])),
			'enlace_plan_trab'  => urldecode($plan),
			'puntaje_inicial'   => $puntaje
		);

		//Obtengo los detalles del director de esta solicitud y genero el template con sus datos
		$director = toba::consulta_php('co_inscripcion_conv_beca')->get_detalles_director($seleccion);
		$datos['direccion'] = $this->armar_template_direccion($director,'Director');
		
		//lo mismo para el co-director y el sub-director (si existen)
		if(isset($seleccion['nro_documento_codir'])){
			$director = toba::consulta_php('co_inscripcion_conv_beca')->get_detalles_director($seleccion,'codir');
			$datos['direccion'] .= $this->armar_template_direccion($director,'Co-Director');
		}
		if(isset($seleccion['nro_documento_subdir'])){
			$director = toba::consulta_php('co_inscripcion_conv_beca')->get_detalles_director($seleccion,'subdir');
			$datos['direccion'] .= $this->armar_template_direccion($director,'Sub-Director');
		}
		
		//Armo el template completo
		$template_completo = file_get_contents(__DIR__.'/templates/template_evaluacion.php');
		foreach ($datos as $clave => $valor) {
			$template_completo = str_replace("{{".$clave."}}",$valor,$template_completo);
		}

		$pantalla->set_template($template_completo);
	}

	function armar_template_direccion($director,$rol)
	{
		//ei_arbol($director);
		//Armo el template de los cargos
		$cargos = toba::consulta_php('co_cargos_persona')->get_cargos_persona($director['nro_documento']);
		$lista_cargos = $this->armar_template_cargos($cargos);
		
		//Armo el template de director
		$cat_incentivos = array(1=>'Categoría I',2=>'Categoría II',3=>'Categoría III',4=>'Categoría IV',5=>'Categoría V');
		$datos_template_director = array(
			'rol'           => $rol,
			'ayn'           => $director['apellido'].", ".$director['nombres'],
			'dni'           => $director['nro_documento'],
			'categoria_inc' => (isset($cat_incentivos[$director['catinc']]) ) ? $cat_incentivos[$director['catinc']] :'No categorizado',
			'categoria_con' => $director['catconicet'],
			'enlace_cvar'   => $this->ruta_documentos."/docum_personal/".$director['nro_documento']."/cvar.pdf",
			'cargos'        => $lista_cargos,

		);
		$template_director = file_get_contents(__DIR__.'/templates/template_director.php');
		foreach ($datos_template_director as $clave => $valor) {
			$template_director = str_replace("{{".$clave."}}",$valor,$template_director);
		}
		return $template_director;
	}

	function armar_template_cargos($cargos)
	{
		$lista_cargos = "";
		//por cada cargo, se agrega una nueva linea al template
		foreach ($cargos as $cargo){
			//se obtiene el template vacío
			$template_cargos = file_get_contents(__DIR__.'/templates/template_cargo.php');
			$cargo['clase_css'] = ($cargo['fecha_hasta'] >= date('Y-m-d')) ? 'cargo_vigente' : ''; 
			$cargo['fecha_desde'] = (new DateTime($cargo['fecha_desde']))->format('d-m-Y');
			$cargo['fecha_hasta'] = (new DateTime($cargo['fecha_hasta']))->format('d-m-Y');

			//$cargo['fecha_desde'] = $cargo['fecha_desde']->format('d-m-Y');
			foreach ($cargo as $clave => $valor) {
				$template_cargos = str_replace("{{".$clave."}}",$valor,$template_cargos);  	
			}
			//agrego el cargo generado a la lista
			$lista_cargos .= $template_cargos;
		}
		return $lista_cargos;
	}

	/** =============================================================================
	 *              CONFIGURACION DE LOS CUADROS DE ANTECEDENTES
	 * ============================================================================= */
	/* =============== ANTECEDENTES DE DOCENCIA =================*/
	function conf__cu_actividades_docentes(becas_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		$postulacion = $this->get_datos('inscripcion_conv_beca')->get();
		$cuadro->set_datos(toba::consulta_php('co_antecedentes')->get_antec_activ_docentes($postulacion));
	}

	function servicio__antec_docencia_pdf()
	{
		$params = toba::memoria()->get_parametros();
		$campos = toba::consulta_php('co_antecedentes')->get_campos(array('doc_probatoria','nro_documento'),'be_antec_activ_docentes','id_antecedente = '.$params['id_antecedente']);
		
		$ruta = $this->ruta_documentos."/doc_probatoria/".$campos['nro_documento']."/activ_docente/".$campos['doc_probatoria'];

		$this->mostrar_pdf($ruta);
	}

	/* =============== ESTUDIOS AFINES =================*/
	function conf__cu_estudios_afines(becas_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		$postulacion = $this->get_datos('inscripcion_conv_beca')->get();
		$cuadro->set_datos(toba::consulta_php('co_antecedentes')->get_antec_estudios_afines($postulacion));
	}
	function servicio__antec_estudio_afin_pdf()
	{
		$params = toba::memoria()->get_parametros();
		$campos = toba::consulta_php('co_antecedentes')->get_campos(array('doc_probatoria','nro_documento'),'be_antec_estudios_afines','id_estudio_afin = '.$params['id_estudio_afin']);
		
		$ruta = $this->ruta_documentos."/doc_probatoria/".$campos['nro_documento']."/estudios_afines/".$campos['doc_probatoria'];

		$this->mostrar_pdf($ruta);
	}

	/* =============== ANTECEDENTES DE BECAS OBTENIDAS =================*/
	function conf__cu_becas_obtenidas(becas_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		$postulacion = $this->get_datos('inscripcion_conv_beca')->get();
		$cuadro->set_datos(toba::consulta_php('co_antecedentes')->get_antec_becas_obtenidas($postulacion));
	}

	function servicio__antec_becas_obtenidas_pdf()
	{
		$params = toba::memoria()->get_parametros();
		$campos = toba::consulta_php('co_antecedentes')->get_campos(array('doc_probatoria','nro_documento'),'be_antec_becas_obtenidas','id_beca_obtenida = '.$params['id_beca_obtenida']);
		
		$ruta = $this->ruta_documentos."/doc_probatoria/".$campos['nro_documento']."/becas_obtenidas/".$campos['doc_probatoria'];

		$this->mostrar_pdf($ruta);
	}

	/* =============== ANTECEDENTES DE TRABAJOS PUBLICADOS =================*/
	function conf__cu_trabajos_publicados(becas_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		$postulacion = $this->get_datos('inscripcion_conv_beca')->get();
		$cuadro->set_datos(toba::consulta_php('co_antecedentes')->get_antec_trabajos_publicados($postulacion));
	}

	function servicio__antec_trabajos_publicados_pdf()
	{
		$params = toba::memoria()->get_parametros();
		$campos = toba::consulta_php('co_antecedentes')->get_campos(array('doc_probatoria','nro_documento'),'be_antec_trabajos_publicados','id_trabajo_publicado = '.$params['id_trabajo_publicado']);
		
		$ruta = $this->ruta_documentos."/doc_probatoria/".$campos['nro_documento']."/trabajos_publicados/".$campos['doc_probatoria'];

		$this->mostrar_pdf($ruta);
	}

	/* =============== ANTECEDENTES DE PRESENTACIÓN EN REUNIONES =================*/
	function conf__cu_present_reuniones(becas_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		$postulacion = $this->get_datos('inscripcion_conv_beca')->get();
		$cuadro->set_datos(toba::consulta_php('co_antecedentes')->get_antec_present_reuniones($postulacion));
	}

	function servicio__antec_present_reuniones_pdf()
	{
		$params = toba::memoria()->get_parametros();
		$campos = toba::consulta_php('co_antecedentes')->get_campos(array('doc_probatoria','nro_documento'),'be_antec_present_reuniones','id_present_reunion = '.$params['id_present_reunion']);
		
		$ruta = $this->ruta_documentos."/doc_probatoria/".$campos['nro_documento']."/presentacion_reuniones/".$campos['doc_probatoria'];

		$this->mostrar_pdf($ruta);
	}

	/* =============== ANTECEDENTES DE CONOCIMIENTO IDIOMAS =================*/
	function conf__cu_idiomas(becas_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		$postulacion = $this->get_datos('inscripcion_conv_beca')->get();
		$cuadro->set_datos(toba::consulta_php('co_antecedentes')->get_antec_conocimiento_idiomas($postulacion));
	}

	function servicio__antec_conocimiento_idiomas_pdf()
	{
		$params = toba::memoria()->get_parametros();
		$campos = toba::consulta_php('co_antecedentes')->get_campos(array('doc_probatoria','nro_documento'),'be_antec_conoc_idiomas','id_conocimiento_idioma = '.$params['id_conocimiento_idioma']);
		
		$ruta = $this->ruta_documentos."/doc_probatoria/".$campos['nro_documento']."/conocimiento_idiomas/".$campos['doc_probatoria'];

		$this->mostrar_pdf($ruta);
	}

	/* =============== ANTECEDENTES DE OTRAS ACTIVIDADES =================*/
	function conf__cu_otras_actividades(becas_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		$postulacion = $this->get_datos('inscripcion_conv_beca')->get();
		$cuadro->set_datos(toba::consulta_php('co_antecedentes')->get_antec_otras_actividades($postulacion));
	}

	function servicio__antec_otras_actividades_pdf()
	{
		$params = toba::memoria()->get_parametros();
		ei_arbol($params);
		$campos = toba::consulta_php('co_antecedentes')->get_campos(array('doc_probatoria','nro_documento'),'be_antec_otras_actividades','id_otra_actividad = '.$params['id_otra_actividad']);
		
		$ruta = $this->ruta_documentos."/doc_probatoria/".$campos['nro_documento']."/otras_actividades/".$campos['doc_probatoria'];

		$this->mostrar_pdf($ruta);
	}

	/* =============== ANTECEDENTES DE PARTICIPACION EN DICTADO DE CURSOS =================*/
	function conf__cu_part_dict_cursos(becas_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		$postulacion = $this->get_datos('inscripcion_conv_beca')->get();
		$cuadro->set_datos(toba::consulta_php('co_antecedentes')->get_antec_particip_dict_cursos($postulacion));
	}

	function servicio__antec_particip_dict_cursos_pdf()
	{
		$params = toba::memoria()->get_parametros();
		ei_arbol($params);
		$campos = toba::consulta_php('co_antecedentes')->get_campos(array('doc_probatoria','nro_documento'),'be_antec_particip_dict_cursos','id_particip_cursos = '.$params['id_particip_cursos']);
		
		$ruta = $this->ruta_documentos."/doc_probatoria/".$campos['nro_documento']."/part_dict_cursos/".$campos['doc_probatoria'];

		$this->mostrar_pdf($ruta);
	}

	/* =============== ANTECEDENTES DE PARTICIPACION EN DICTADO DE CURSOS =================*/
	function conf__cu_cursos_perfeccionamiento(becas_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		$postulacion = $this->get_datos('inscripcion_conv_beca')->get();
		$cuadro->set_datos(toba::consulta_php('co_antecedentes')->get_antec_cursos_perfeccionamiento($postulacion));
	}

	function servicio__antec_cursos_perfeccionamiento_pdf()
	{
		$params = toba::memoria()->get_parametros();
		ei_arbol($params);
		$campos = toba::consulta_php('co_antecedentes')->get_campos(array('doc_probatoria','nro_documento'),'be_antec_cursos_perfec_aprob','id_curso_perfec_aprob = '.$params['id_curso_perfec_aprob']);
		
		$ruta = $this->ruta_documentos."/doc_probatoria/".$campos['nro_documento']."/cursos_perfec_aprob/".$campos['doc_probatoria'];

		$this->mostrar_pdf($ruta);
	}

	//-----------------------------------------------------------------------------------
	//---- form_evaluacion --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_evaluacion_fijo(becas_ei_formulario $form)
	{
		$dictamen = $this->get_datos('be_dictamen')->get();
		if($dictamen){
			$form->set_datos($dictamen);
		}	
	}

	function evt__form_evaluacion_fijo__modificacion($datos)
	{
		$datos['tipo_dictamen'] = 'C';
		$datos['fecha'] = (isset($datos['fecha'])) ? $datos['fecha'] : date('Y-m-d');
		$this->get_datos('be_dictamen')->set($datos);
	}

	function conf__form_evaluacion_criterios(becas_ei_formulario_ml $ml)
	{
		//obtengo los detalles de la postulación y los criterios de evaluación que le corresponden por su tipo
		$insc = $this->get_datos('inscripcion_conv_beca')->get();
		$criterios = toba::consulta_php('co_comision_asesora')->get_criterios_evaluacion($insc);
		
		//si ya existe una evaluacion previa, solo la asigno al formulario ML
		$filas = $this->get_datos('be_dictamen_detalle')->get_filas();
		if($filas){
			$ml->set_datos($filas);
		}else{
			//si no existe una evaluación previa, genero las filas con los criterios que le corresponde
			foreach($criterios as $criterio){
				$ml->agregar_registro(array('id_criterio_evaluacion'=>$criterio['id_criterio_evaluacion'],
											  'criterio_evaluacion' =>$criterio['criterio_evaluacion'],
											  'puntaje'             =>'',
											  'puntaje_maximo'      =>$criterio['puntaje_maximo']));
			}
		}
	}

	function evt__form_evaluacion_criterios__modificacion($datos)
	{
		$this->get_datos('be_dictamen_detalle')->procesar_filas($datos);

	}

	//-----------------------------------------------------------------------------------
	//---- ml_evaluadores ---------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_evaluadores(becas_ei_formulario $form)
	{
		//obtengo los detalles de la inscripcion
		$insc = $this->get_datos('inscripcion_conv_beca')->get();
		$evaluadores = toba::consulta_php('co_comision_asesora')->get_integrantes_comision($insc);
		ei_arbol($evaluadores);
		foreach ($evaluadores as $evaluador) {
			$lista[] = "(".$evaluador['nro_documento'].") - ".$evaluador['evaluador'];
		}
		ei_arbol($lista);
		$form->set_datos(array('evaluador'=>'pepe,tito,raul'));

		
		
		
	}

	function evt__form_evaluadores__modificacion($datos)
	{
		
	}

	

	function get_datos($tabla = NULL)
	{
		return ($tabla) ? $this->dep('datos')->tabla($tabla) : $this->dep('datos');
	}

	function mostrar_pdf($archivo)
	{	
		header("Location: ".utf8_encode($archivo));
	}

	



}
?>