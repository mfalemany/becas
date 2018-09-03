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

	//-----------------------------------------------------------------------------------
	//---- cu_postulaciones -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_postulaciones(becas_ei_cuadro $cuadro)
	{
		$filtro = ($this->s__filtro) ? $this->s__filtro : array();
		
		//Solo inscripciones cerradas y admitidas
		$filtro['admisible'] =  'S';
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
			'enlace_plan_trab'  => urldecode($plan)
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
		$template_completo = file_get_contents(__DIR__.'/template_evaluacion.php');
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
		$template_director = file_get_contents(__DIR__.'/template_director.php');
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
			$template_cargos = file_get_contents(__DIR__.'/template_cargo.php');
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