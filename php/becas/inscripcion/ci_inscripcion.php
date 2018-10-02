<?php
class ci_inscripcion extends becas_ci
{
	protected $s__filtro;
	function conf()
	{
		//si no existen convocatorias con inscripcion abierta, elimino el evento 'agregar (Nueva Inscripcion'
		if( ! toba::consulta_php('co_convocatoria_beca')->existen_convocatorias_vigentes()){
			$this->pantalla()->eliminar_evento('agregar');
			$this->dep('cuadro')->agregar_notificacion('No existen convocatorias con periodo de inscripción abierto');
		}
		//si el usuario es becario, solo puede ver sus propias inscripciones
		if(!in_array('admin',toba::usuario()->get_perfiles_funcionales())){
			if($this->pantalla()->existe_dependencia('form_filtro')){
				$this->pantalla('pant_seleccion')->eliminar_dep('form_filtro');	
			}
		}
	}
	//---- Cuadro Inscripciones ------------------------------------------------------------

	function conf__cuadro(toba_ei_cuadro $cuadro)
	{
		$filtro = (isset($this->s__filtro)) ? $this->s__filtro : array();
		
		//si el usuario es becario, solo puede ver sus propias inscripciones
		if(!in_array('admin',toba::usuario()->get_perfiles_funcionales())){
			$filtro['nro_documento'] = toba::usuario()->get_id();	
		}
		$cuadro->set_datos(toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones($filtro));
		
	}

	function evt__cuadro__seleccion($datos)
	{
		//se carga la relaci?  de "Alumno"
		$alumno = array('nro_documento'=>$datos['nro_documento']);
		$this->get_datos('alumno')->cargar($alumno);

		//se cargan los detalles de la inscripci?
		$this->get_datos('inscripcion')->cargar($datos);

		$this->set_pantalla('pant_edicion');
	}

	function evt__cuadro__ver_seguimiento($seleccion)
	{
		$this->get_datos('inscripcion')->cargar($seleccion);
		$this->set_pantalla('pant_seguimiento');

	}

	function conf_evt__cuadro__ver_seguimiento(toba_evento_usuario $evento, $fila)
	{
		$clave = toba_ei_cuadro::recuperar_clave_fila('2948',$fila);
		if(!$clave){
			$evento->ocultar();
			return;
		}
		//Si la postulación tiene al menos la admisibilidad hecha, entonces el usuario puede ver el botón
		$tiene_admisibilidad = toba::consulta_php('co_inscripcion_conv_beca')->get_campo(array('admisible'),$clave);
		if(in_array($tiene_admisibilidad[0]['admisible'],array('S','N') ) ){
			$evento->mostrar();
		}else{
			$evento->ocultar();	
		}
	}

	function servicio__generar_comprobante()
	{
		$params = toba::memoria()->get_parametros();
		$clave = toba_ei_cuadro::recuperar_clave_fila('2948',$params['fila']);
		$this->generar_comprobante($clave);
		//validar si existe el archivo, sino, hay que generarlo.
	}

	function generar_comprobante($clave)
	{
		if(!count($clave)){
			return;
		}
		$detalles = toba::consulta_php('co_inscripcion_conv_beca')->get_detalles_comprobante($clave);
		//ei_arbol($detalles);
		$reporte = new becas_inscripcion_comprobante($detalles);
		$reporte->mostrar();

	}

	/*function conf_evt__cuadro__generar_comprobante(toba_evento_usuario $evento, $fila)
	{
		$clave = toba_ei_cuadro::recuperar_clave_fila('2948',$fila);
		if(count($clave) == 0){
			$evento->ocultar();
			return;
		}
		$estado = toba::consulta_php('co_inscripcion_conv_beca')->get_campo(array('estado'),$clave);
		if($estado[0]['estado'] == 'A'){
			$evento->ocultar();
		}else{
			$evento->mostrar();
		}
		//si el estado es cerrado, hay que mostrar el boton
	}*/

	function resetear()
	{
		$this->get_datos('alumno')->resetear();
		$this->get_datos('inscripcion')->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	//---- EVENTOS CI -------------------------------------------------------------------
	function evt__ver_comprobante()
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$clave = array('nro_documento' => $insc['nro_documento'], 'id_tipo_beca' => $insc['id_tipo_beca'], 'id_convocatoria' => $insc['id_convocatoria']);
		
		$this->generar_comprobante($clave);
	}
	function evt__agregar()
	{
		$this->set_pantalla('pant_edicion');
	}

	function evt__volver()
	{
		$this->resetear();
		$this->set_pantalla('pant_seleccion');
	}
	
	function evt__eliminar()
	{
		$this->get_datos('inscripcion','requisitos_insc')->eliminar();
		$this->get_datos('inscripcion','plan_trabajo')->eliminar();
		$this->get_datos('inscripcion','inscripcion_conv_beca')->eliminar();
		$this->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	function evt__guardar()
	{
		try{
			$this->dep('ci_edicion')->generar_registros_relacionados();
			$this->dep('ci_edicion')->generar_nro_carpeta();
			
			//verifico campos obligatorios (por si no se recorrieron todas las solapas)
			$alumno = $this->get_datos('alumno','persona')->get();
			/*if(!$alumno['archivo_cuil']){
				$this->dep('ci_edicion')->set_pantalla('pant_alumno');
				throw new toba_error("No se ha cargado la constancia de CUIL del solicitante");
			}*/
			$this->get_datos('alumno')->sincronizar();
			$this->get_datos('inscripcion')->sincronizar();
			
		}catch(toba_error_db $e){
			switch ($e->get_sqlstate()) {

				case 'db_23505':
					toba::notificacion()->agregar('Se ha producido un error al intentar guardar. Posiblemente, el alumno ingresado ya tenga una solicitud de beca para esta convocatoria y tipo de beca.');	
					break;
				
				default:
					toba::notificacion()->agregar('Ocurrió un error inesperado al intentar guardar la inscripción. por favor, comuniquese con la Secretaría General de Ciencia y Técnica para solucionarlo (cyt.unne@gmail.com). Código de error: '.$e->get_mensaje_motor());	
					break;
			}
		}catch(toba_error $e){
			toba::notificacion()->agregar($e->get_mensaje());
		}
		
	}

	function validar_datos_obligatorios($inscripcion,$plan_trabajo)
	{	
		$obligatorios = array(
			array(
				'pantalla'     => 'Alumno',
				'campo'        => 'nro_documento',
				'obligatorios' => array('sexo','cuil','mail','fecha_nac','celular','archivo_cuil')
			),
			array(
				'pantalla'     => 'Director',
				'campo'        => 'nro_documento_dir',
				'obligatorios' => array('sexo','cuil','mail','celular','nivel_academico','id_disciplina','archivo_cvar')
			)
		);
		if($inscripcion['nro_documento_codir']){
			$obligatorios[] = array(
				'pantalla'     => 'Co-Director',
				'campo'        => 'nro_documento_codir',
				'obligatorios' => array('sexo','cuil','mail','celular','nivel_academico','id_disciplina','archivo_cvar')
			);
		}

		if($inscripcion['nro_documento_subdir']){
			$obligatorios[] = array(
				'pantalla'     => 'Sub-Director',
				'campo'        => 'nro_documento_subdir',
				'obligatorios' => array('sexo','cuil','mail','celular','nivel_academico','id_disciplina','archivo_cvar')
			);
		}
			
		$faltantes = array();
		
		foreach($obligatorios as $obligatorio) {
			$buscado = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
			$persona = toba::consulta_php('co_personas')->get_resumen_director($buscado[$obligatorio['campo']]);
			foreach ($obligatorio['obligatorios'] as $campo) {
				if(array_key_exists($campo,$persona)){
					if($persona[$campo] == NULL){
						$faltantes[$obligatorio['pantalla']][] = $campo; 
					}	
				}
			}
		}
		if( ($inscripcion['nro_documento_codir'] || $inscripcion['nro_documento_codir']) &&  !$inscripcion['justif_codirector']){
			$faltantes['Co-Director'][] = 'Justificación del Co-Director/Sub-Director';
		}
		if(!$plan_trabajo['doc_probatoria']){
			$faltantes['Plan Trabajo'][] = 'Archivo PDF con el plan de trabajo';
		}
		return $faltantes;
		
	}

	function evt__cerrar_inscripcion()
	{
		$this->evt__guardar();
		
		$faltantes = $this->validar_datos_obligatorios($this->get_datos('inscripcion','inscripcion_conv_beca')->get(),$this->get_datos('inscripcion','plan_trabajo')->get());
		
		if(count($faltantes) > 0){
			$mensaje = "<ul>";
			foreach ($faltantes as $pantalla => $campos) {
				$mensaje .= "<li>Sección '$pantalla': ".implode(', ',$campos)."</li>";
			}
			$mensaje .= "</ul>";
			throw new toba_error('Faltan datos por completar: '.$mensaje);
		}else{
			toba::notificacion()->agregar('Se ha cerrado correctamente la solicitud. En la parte inferior de esta pantalla puede descargar el comprobante de inscripción, el cual debe ser entregado a la SGCyT.','info');
			$this->get_datos('inscripcion','inscripcion_conv_beca')->set(array('estado'=>'C'));
			$this->evt__guardar();
		}
		
		
		
	}

	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__cuadro__abrir($seleccion)
	{
		toba::consulta_php('co_inscripcion_conv_beca')->abrir_solicitud($seleccion);
	}

	function conf_evt__cuadro__abrir(toba_evento_usuario $evento, $fila)
	{
		if(!in_array('admin',toba::usuario()->get_perfiles_funcionales())){
			$evento->ocultar();
		}
	}

	//-----------------------------------------------------------------------------------
	

	function &get_datos($relacion, $tabla = NULL)
	{
		$datos = FALSE;
		if($tabla){
			if($relacion){
				$datos = $this->dep($relacion)->tabla($tabla);
			}else{
				$datos = $this->dep($tabla);
			}
		}else{
			if($relacion){
				$datos = $this->dep($relacion);
			}
		}
		return $datos;

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

	

}
?>