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
			if(isset($insc['materias_aprobadas']) && isset($insc['materias_plan'])){
				$insc['porcentaje_aprobacion'] = $insc['materias_aprobadas'] / $insc['materias_plan'] * 100;
				$insc['mat_para_egresar'] = $insc['materias_plan'] - $insc['materias_aprobadas'];
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
		
		/* esta variable va a contener todo lo necesario para determinar si la solicitud es admisible.
		   Se compone de los datos de cargos del director y codirector, edad del aspirante, porcentaje
		   de materias aprobadas del alumno, materias que adeuda para recibirse, si está inscripto a un posgrado,
		   al máximo grado del director y codirector y la cantidad de becarios a cargo. */
		$datos_admisibilidad = array(
									'nivel_academico' => NULL,
									'cargo_unne'      => NULL,
									'dedicacion'      => NULL,
									'cat_incentivos'  => NULL
									);

		/* ================================== DIRECTOR ================================ */
		$det = toba::consulta_php('co_docentes')->get_resumen_docente($insc['nro_documento_dir']);

		$detalles_cargos = toba::consulta_php('co_docentes')->get_cargos_docente($insc['nro_documento_dir']);
		$detalles = array_merge($det,array('cargos'=>$detalles_cargos));
		$resumen_dir = $this->mostrar_detalles_director($detalles);
		/* ============================================================================ */

		//comparo los datos del director con los datos de admisibilidad
		$this->set_datos_admisibilidad($datos_admisibilidad,$det,$detalles_cargos);

		unset($det);
		unset($detalles_cargos);

		/* ================================= CODIRECTOR =============================== */
		if($insc['nro_documento_codir']){
			$det = toba::consulta_php('co_docentes')->get_resumen_docente($insc['nro_documento_codir']);
			$detalles_cargos = toba::consulta_php('co_docentes')->get_cargos_docente($insc['nro_documento_codir']);
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
			$det = toba::consulta_php('co_docentes')->get_resumen_docente($insc['nro_documento_subdir']);
			$detalles_cargos = toba::consulta_php('co_docentes')->get_cargos_docente($insc['nro_documento_subdir']);
			$detalles = array_merge($det,array('cargos'=>$detalles_cargos));
			$resumen_subdir = $this->mostrar_detalles_director($detalles);	

			//comparo los datos del co-director con los datos de admisibilidad
			$this->set_datos_admisibilidad($datos_admisibilidad,$det,$detalles_cargos);
		}
		/* ============================================================================ */

		$edad_asp = toba::consulta_php('co_personas')->get_edad(array('nro_documento' => $insc['nro_documento']),
																date('Y-12-31'));
		$edad_limite = toba::consulta_php('co_tipos_beca')->get_campo('edad_limite',$insc['id_tipo_beca']);
		if($edad_limite){
			$clase_css_edad = ($edad_asp > $edad_limite) ? 'etiqueta_error' : 'etiqueta_success';
		}
		
		$clase_css_cargos = ($datos_admisibilidad['cargo_unne']) ? "etiqueta_success" : "etiqueta_error";
		
		
		
		$clase_css_dedic = (in_array($datos_admisibilidad['dedicacion'],array('3','2'))) ? "etiqueta_success" : "etiqueta_error";


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

		$template = "<table>
						<tr>
							<td style='vertical-align: top;'>
								[dep id=form_admisibilidad]
								[dep id=ml_requisitos]
								<p class='".$clase_css_edad." centrado'>Edad del aspirante al 31 de Diciembre: ".$edad_asp." años.</p>
								<p class='".$clase_css_cargos." centrado'>Cargos</p>
								<p class='".$clase_css_dedic." centrado'>Mayor Dedicación</p>
								<p class='".$clase_css_categ." centrado'>Grado/Categoría</p>
							</td>
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
		
		//guardo el mayor nivel academico
		if( ! $datos_admisibilidad['cat_incentivos']){
			$datos_admisibilidad['cat_incentivos'] = $det['nro_categoria'];
		}else{
			if($datos_admisibilidad['cat_incentivos'] < $det['nro_categoria']){
				$datos_admisibilidad['cat_incentivos'] = $det['nro_categoria'];
			}
		}

		//guardo el mayor cargo
		foreach($detalles_cargos as $cargo){
			// Los cargos mas altos tienen numeros mas bajos: 1-Titular -- 2-Adjunto -- 3-JTP
			if( ! $datos_admisibilidad['cargo_unne']){
				$datos_admisibilidad['cargo_unne'] = $cargo['id_cargo_unne'];
			}else{
				if($datos_admisibilidad['cargo_unne'] > $cargo['id_cargo_unne']){
					$datos_admisibilidad['cargo_unne'] = $cargo['id_cargo_unne'];
				}
			}
			// Las dedicaciones mas altas, tienen numeros mas altas: 3-Exclusiva -- 2-Semi-Exclusiva -- 1-Simple
			if( ! $datos_admisibilidad['dedicacion']){
				$datos_admisibilidad['dedicacion'] = $cargo['id_dedicacion'];
			}else{
				if($datos_admisibilidad['dedicacion'] < $cargo['id_dedicacion']){
					$datos_admisibilidad['dedicacion'] = $cargo['id_dedicacion'];
				}
			}
		}
	}

	function mostrar_detalles_director($detalles)
	{
		////se arma el template (tiene un encabezado que resume los datos del director)
		$resumen = "<p><b>Apellido y Nombre:</b> <b class='etiqueta_info'>".$detalles['apellido'].", ".$detalles['nombres']."</b> (".$detalles['tipo_doc'].". ".$detalles['nro_documento'].")</p>";
		//$resumen .= "<p>CUIL: ".$detalles['cuil']."</p>";
		$resumen .= "<p><b>M&aacute;ximo Grado:</b> ".$detalles['nivel_academico']."</p>";
		$resumen .= "<p><b>Cat. Incentivos:</b> ".$detalles['cat_incentivos']."</p>";
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
		$this->disparar_limpieza_memoria();
		$this->set_pantalla('pant_seleccion');

	}

	function evt__volver()
	{
		$this->get_datos('inscripcion')->resetear();
		$this->disparar_limpieza_memoria();
		$this->set_pantalla('pant_seleccion');
	}



	//-----------------------------------------------------------------------------------
	//---- Datos ------------------------------------------------------------------------
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



}
?>