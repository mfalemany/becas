<?php
class ci_admisibilidad extends becas_ci
{
	protected $s__filtro;

	//-----------------------------------------------------------------------------------
	//---- FILTRO DE SOLICITUDES --------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro_solicitud(becas_ei_formulario $form)
	{
		if(isset($this->s__filtro)){
			$form->set_datos($this->s__filtro);	
		}
	}

	function evt__filtro_solicitud__filtrar($datos)
	{
		$this->s__filtro = $datos;
	}

	function evt__filtro_solicitud__cancelar()
	{
		unset($this->s__filtro);
	}

	//-----------------------------------------------------------------------------------
	//---- CUADRO SELECCION DE SOLICITUDES  ---------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_solicitudes(becas_ei_cuadro $cuadro)
	{
		$filtro = (isset($this->s__filtro) ? $this->s__filtro : array());
		$filtro['estado'] = 'C';
		$cuadro->set_datos(toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones($filtro));
	}

	function evt__cu_solicitudes__seleccion($seleccion)
	{
		$this->get_datos('inscripcion')->cargar($seleccion);
		$this->set_pantalla('pant_edicion');

	}

	//-----------------------------------------------------------------------------------
	//---- form_admisibilidad -----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_admisibilidad(becas_ei_formulario $form)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();

		
		if($insc){
			//se calcula el porcentaje de aprobacion y la cantidad de materias que adeuda para egresar.
			if(isset($insc['materias_aprobadas']) && isset($insc['materias_plan'])){
				$insc['porcentaje_aprobacion'] = $insc['materias_aprobadas'] / $insc['materias_plan'] * 100;
				$insc['mat_para_egresar'] = $insc['materias_plan'] - $insc['materias_aprobadas'];
			}
			$persona = toba::consulta_php('co_personas')->get_personas(array('nro_documento'=>$insc['nro_documento']));
			
			//muestro el nombre y apellido del postulante
			$form->agregar_notificacion("Postulante:" . $persona[0]['apellido'].', '.$persona[0]['nombres'],'info');
			
			if(count($persona)){
				$insc['es_egresado'] = ($persona[0]['archivo_titulo_grado']) ? 'Si' : 'No';
			}else{
				$insc['es_egresado'] = 'No';
			}
			$form->set_datos($insc);
		}
	}

	function evt__form_admisibilidad__modificacion($datos)
	{
		//se eliminan los efs que solo muestran información relevante para la toma de decision de admisibilidad
		unset($datos['porcentaje_aprobacion']);
		unset($datos['mat_para_egresar']);

		//se asignan los datos as datos_tabla
		$this->get_datos('inscripcion','inscripcion_conv_beca')->set($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- ml_requisitos ----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_requisitos(becas_ei_formulario_ml $form_ml)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$req = toba::consulta_php('co_requisitos_insc')->get_requisitos_insc($insc['id_convocatoria'],$insc['id_tipo_beca'],$insc['nro_documento']);
		$form_ml->set_datos($req);
		
	}

	function evt__ml_requisitos__modificacion($datos)
	{
		$this->get_datos('inscripcion','requisitos_insc')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__pant_edicion(toba_ei_pantalla $pantalla)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		
		/* =========================== AVALES ============================ */
		$avales = toba::consulta_php('co_inscripcion_conv_beca')->get_estado_aval_solicitud($insc);
		if($avales){
			$avales_tmp = $avales;
			$aval_completo = array_reduce($avales_tmp, function($estado,$aval){
				return ($estado && $aval) ;
			}, TRUE);
			if( ! $aval_completo){
				$this->mostrar_estado_avales($avales);
				//return;
			}
		}else{
			toba::notificacion()->agregar('Esta postulación no recibió ningun aval','error');
		}


		/* esta variable va a contener todo lo necesario para determinar si la solicitud es admisible.
		   Se compone de los datos de cargos del director y codirector, edad del aspirante, porcentaje
		   de materias aprobadas del alumno, materias que adeuda para recibirse, si está inscripto a un posgrado,
		   al máximo grado del director y codirector y la cantidad de becarios a cargo. */
		$datos_admisibilidad = array(
									'nivel_academico' => NULL,
									'mayor_dedicacion'=> FALSE,
									'cat_incentivos'  => NULL
									);

		/* ================================== DIRECTOR ================================ */
		$det = toba::consulta_php('co_personas')->get_resumen_director($insc['nro_documento_dir']);
		$detalles_cargos = toba::consulta_php('co_cargos_persona')->get_cargos_persona($insc['nro_documento_dir']);
		$detalles = array_merge($det,array('cargos'=>$detalles_cargos));
		$resumen_dir = $this->mostrar_detalles_director($detalles);
		/* ============================================================================ */

		//comparo los datos del director con los datos de admisibilidad
		$this->set_datos_admisibilidad($datos_admisibilidad,$det,$detalles_cargos);

		unset($det);
		unset($detalles_cargos);

		/* ================================= CODIRECTOR =============================== */
		if($insc['nro_documento_codir']){
			$det = toba::consulta_php('co_personas')->get_resumen_director($insc['nro_documento_codir']);
			$detalles_cargos = toba::consulta_php('co_cargos_persona')->get_cargos_persona($insc['nro_documento_codir']);
			$detalles = array_merge($det,array('cargos'=>$detalles_cargos));
			$resumen_codir = $this->mostrar_detalles_director($detalles);	
		
			//comparo los datos del co-director con los datos de admisibilidad
			$this->set_datos_admisibilidad($datos_admisibilidad,$det,$detalles_cargos);
		}
		/* ============================================================================ */

		unset($det);
		unset($detalles_cargos);

		/* ================================= SUBDIRECTOR =============================== */
		if($insc['nro_documento_subdir']){
			$det = toba::consulta_php('co_personas')->get_resumen_director($insc['nro_documento_subdir']);
			$detalles_cargos = toba::consulta_php('co_cargos_persona')->get_cargos_persona($insc['nro_documento_subdir']);
			$detalles = array_merge($det,array('cargos'=>$detalles_cargos));
			$resumen_subdir = $this->mostrar_detalles_director($detalles);	

			//comparo los datos del co-director con los datos de admisibilidad
			$this->set_datos_admisibilidad($datos_admisibilidad,$det,$detalles_cargos);
		}
		/* ============================================================================ */

		//obtengo los detalles del tipo de beca seleccionado
		$det_tipo_beca = toba::consulta_php('co_tipos_beca')->get_tipos_beca(array('id_tipo_beca'=>$insc['id_tipo_beca']));
		if(count($det_tipo_beca)){
			$det_tipo_beca = $det_tipo_beca[0];
		}

		//obtengo la edad del aspirante
		$edad_asp = toba::consulta_php('co_personas')->get_edad(array('nro_documento' => $insc['nro_documento']),
																date('Y-12-31'));

		//se valida la edad del aspirante. En caso de no cumplir, se muestra un mensaje en rojo
		if($det_tipo_beca['edad_limite']){
			$clase_css_edad = ($edad_asp > $det_tipo_beca['edad_limite']) ? 'etiqueta_error' : 'etiqueta_success';
		}
		//lo mismo para la dedicación
		$clase_css_dedic = ($datos_admisibilidad['mayor_dedicacion']) ? "etiqueta_success" : "etiqueta_error";

		//si no tiene una categoria de incentivos 1, 2 o 3
		if( ! $datos_admisibilidad['cat_incentivos'] <= 3){
			//debe ser magister o doctor (nivel academico 6 o 6)
			if($datos_admisibilidad['nivel_academico'] >= 5){
				$clase_css_categ = "etiqueta_success";
			}else{
				$clase_css_categ = "etiqueta_error";
			}
		}else{
			$clase_css_categ = "etiqueta_success";
		}

		//se valida si la beca exige inscripción a un posgrado (o compromiso)
		if($det_tipo_beca['requiere_insc_posgrado'] === 'S'){
			if($insc['archivo_insc_posgrado']){
				$clase_css_insc_posgrado = 'etiqueta_success';		
			}else{
				$clase_css_insc_posgrado = 'etiqueta_error';		
			}
		}else{
			unset($clase_css_insc_posgrado);
		}

		//se valida si la beca exige inscripción a un posgrado (o compromiso)
		if(isset($det_tipo_beca['debe_adeudar_hasta'])){
			if(is_numeric($det_tipo_beca['debe_adeudar_hasta']) && $det_tipo_beca['debe_adeudar_hasta'] != 0){
				//se valida si el postulante adeuda menos materias que las exigidas
				if( ($insc['materias_plan'] - $insc['materias_aprobadas']) <= $det_tipo_beca['debe_adeudar_hasta']){
					$clase_css_adeuda_materias = 'etiqueta_success';		
				}else{
					$clase_css_adeuda_materias = 'etiqueta_error';		
				}
			}
		}
		/* ================================= PARAMETRO MINIMO MATERIAS =============================== */
		//Si la beca es de PRE-GRADO
		if($insc['id_tipo_beca'] == 1){
			$minimo_exigido = toba::consulta_php('co_tablas_basicas')->get_parametro_conf('beca_pregrado_porcentaje_min_aprobacion');
			if($minimo_exigido){
				$clase_css_minimo_materias = 'etiqueta_success';
				$porcentaje_aprobacion = $insc['materias_aprobadas'] / $insc['materias_plan'] * 100;
				if(floatval($porcentaje_aprobacion) < floatval($minimo_exigido)){
					$clase_css_minimo_materias = 'etiqueta_error';
				}
			}else{
				$this->dep('form_admisibilidad')->agregar_notificacion('No se estableció un minimo exigible de materias aprobadas (parametro beca_pregrado_porcentaje_min_aprobacion en "tablas básicas" de SAP)','warning');
			}
		}



		$template = "<table width='100%'>
						<tr>
							<td style='vertical-align:'>
								[dep id=form_admisibilidad]
								[dep id=ml_requisitos]

								<p class='".$clase_css_edad." centrado'>Edad del aspirante al 31 de Diciembre: ".$edad_asp." años.</p>
								<p class='".$clase_css_dedic." centrado'>Mayor Dedicación</p>
								<p class='".$clase_css_categ." centrado'>Grado/Categoría</p>";

		//si el tipo de beca requiere inscripción a posgrado, se muestra la validación
		if(isset($clase_css_insc_posgrado)){
			$template .= 		"<p class='".$clase_css_insc_posgrado." centrado'>Inscripción o compromiso a un posgrado</p>";
		}

		//si el tipo de beca requiere un limite de materias adeudadas, se muestra la validacion
		if(isset($clase_css_adeuda_materias)){
			$template .= "<p class='".$clase_css_adeuda_materias." centrado'>Cantidad de materias que adeuda</p>";
		}
		if(isset($clase_css_minimo_materias)){
			$template .= "<p class='".$clase_css_minimo_materias." centrado'>Cantidad de materias aprobadas en su plan de estudios</p>";	
		}							
		$template .=		"</td>
							<td style='vertical-align: top;'>
								<fieldset class='detalle_director'>
									<legend>Resumen del Director de la beca</legend>
									$resumen_dir
								</fieldset>";
		if(isset($resumen_codir)){
			$template .= "	<br><fieldset class='detalle_director'>
									<legend>Resumen del Co-Director de la beca</legend>
									$resumen_codir
								</fieldset>";
		}
		if(isset($resumen_subdir)){
			$template .= "	<br><fieldset class='detalle_director'>
									<legend>Resumen del Sub-Director de la beca</legend>
									$resumen_subdir
								</fieldset>";
		}

		$template .=		"</td>
						</tr>
					</table>";
		$pantalla->set_template($template);
	}

	function set_datos_admisibilidad(&$datos_admisibilidad,$det,$detalles_cargos)
	{
		//guardo el mayor nivel academico
		if( ! $datos_admisibilidad['nivel_academico']){
			$datos_admisibilidad['nivel_academico'] = $det['id_nivel_academico'];
		}else{
			if($datos_admisibilidad['nivel_academico'] < $det['id_nivel_academico']){
				$datos_admisibilidad['nivel_academico'] = $det['id_nivel_academico'];
			}
		}
		//_arbol($det);
		//guardo el mayor nivel academico
		if( ! $datos_admisibilidad['cat_incentivos']){
			$datos_admisibilidad['cat_incentivos'] = $det['cat_incentivos'];
		}else{
			if($datos_admisibilidad['cat_incentivos'] < $det['cat_incentivos']){
				$datos_admisibilidad['cat_incentivos'] = $det['cat_incentivos'];
			}
		}

		//verifico si existe mayor dedicacion
		foreach($detalles_cargos as $cargo){
			if(in_array($cargo['dedicacion'],array('EXCL','SEMI'))){
				$datos_admisibilidad['mayor_dedicacion'] = TRUE;
			}
		}
	}

	function mostrar_detalles_director($detalles)
	{
		////se arma el template (tiene un encabezado que resume los datos del director)
		$resumen = "<p><b>Apellido y Nombre:</b> <b class='etiqueta_info'>".$detalles['apellido'].", ".$detalles['nombres']."</b> (".$detalles['tipo_doc'].". ".$detalles['nro_documento'].")</p>";
		//$resumen .= "<p>CUIL: ".$detalles['cuil']."</p>";
		$resumen .= "<p><b>M&aacute;ximo Grado:</b> ".$detalles['nivel_academico']."</p>";
		$resumen .= "<p><b>Cat. Incentivos:</b> ".$detalles['cat_incentivos_descripcion']."</p>";
		$resumen .= "<p><b>Cat. CONICET: </b>".$detalles['cat_conicet']."</p>";
		$resumen .= "<b>Cargos:</b><ul class='lista_cargos'>";
		foreach($detalles['cargos'] as $indice => $cargo){
			if($cargo['fecha_desde']){
				$desde = new DateTime($cargo['fecha_desde']);
			}
			if($cargo['fecha_hasta']){
				$hasta = new DateTime($cargo['fecha_hasta']);
			}
			$hoy = new DateTime();
			$resumen .= ($hoy >= $desde && $hoy <= $hasta) ? "<li class=cargo_vigente>" : "<li>";
				
			$resumen .= "<b>Cargo: </b>".$cargo['cargo']." - <b>Dedicaci&oacute;n: </b>".$cargo['dedicacion']." (".$cargo['dependencia'].").";
			if(isset($desde)){
				$resumen .= " Desde el ".$desde->format('d/m/Y');
			}
			if(isset($hasta)){
				$resumen .= " y hasta el ".$hasta->format('d/m/Y');
			}
			$resumen .= "</li>";
		}
		$resumen .= "</ul>";
		return $resumen;
		
	}

	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__guardar()
	{
		$this->get_datos('inscripcion')->sincronizar();
		$this->get_datos('inscripcion')->resetear();
		$this->set_pantalla('pant_seleccion');

	}

	function evt__volver()
	{
		$this->get_datos('inscripcion')->resetear();
		$this->set_pantalla('pant_seleccion');
	}



	//-----------------------------------------------------------------------------------
	//---- AUXILIARES -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------	


	function get_datos($relacion = NULL, $tabla = NULL)
	{
		if($relacion){
			if($tabla){
				return $this->dep($relacion)->tabla($tabla);
			}else{
				return $this->dep($relacion);
			}
		}else{
			if($tabla){
				return $this->dep($tabla);
			}else{
				return false;
			}
		}
	}

	function mostrar_estado_avales($avales){
		$dir = ($avales['aval_director']) ? "Avalado" : "No avalado";
		$sec = ($avales['aval_secretaria']) ? "Avalado" : "No avalado";
		$dec = ($avales['aval_decanato']) ? "Avalado" : "No avalado";
		$msg = "Esta postulación no tuvo alguno de los avales necesarios:
				<table border=1 style='margin: 10px auto; border-collapse: collapse;'>
					<tr><td style='padding: 5px;'>Director Beca: </td><td style='padding: 5px;'>$dir</td></tr>
					<tr><td style='padding: 5px;'>Sec. Investigación: </td><td style='padding: 5px;'>$sec</td></tr>
					<tr><td style='padding: 5px;'>Decanato/Dir. Instituto: </td><td style='padding: 5px;'>$dec</td></tr>
				</table>";
		toba::notificacion()->agregar($msg);
	}





}
?>