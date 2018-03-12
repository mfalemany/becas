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

		/* ================================== DIRECTOR ================================ */
		$det = toba::consulta_php('co_docentes')->get_resumen_docente($insc['nro_documento_dir']);

		$detalles_cargos = toba::consulta_php('co_docentes')->get_cargos_docente($insc['nro_documento_dir']);
		$detalles = array_merge($det,array('cargos'=>$detalles_cargos));
		$resumen_dir = $this->mostrar_detalles_director($detalles);
		/* ============================================================================ */

		unset($det);
		unset($detalles_cargos);

		/* ================================= CODIRECTOR =============================== */
		if($insc['nro_documento_codir']){
			$det = toba::consulta_php('co_docentes')->get_resumen_docente($insc['nro_documento_codir']);
			$detalles_cargos = toba::consulta_php('co_docentes')->get_cargos_docente($insc['nro_documento_codir']);
			$detalles = array_merge($det,array('cargos'=>$detalles_cargos));
			$resumen_codir = $this->mostrar_detalles_director($detalles);	
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
		}
		/* ============================================================================ */

		$edad_asp = toba::consulta_php('co_personas')->get_edad(array('nro_documento' => $insc['nro_documento']),
																date('Y-12-31'));
		$edad_limite = toba::consulta_php('co_tipos_beca')->get_campo('edad_limite',$insc['id_tipo_beca']);
		if($edad_limite){
			$clase_css = ($edad_asp > $edad_limite) ? 'etiqueta_error' : 'etiqueta_success';
		}
		$template = "<table>
						<tr>
							<td style='vertical-align: top;'>
								<p class='".$clase_css." centrado'>Edad del aspirante al 31 de Diciembre: ".$edad_asp." años.</p>
								[dep id=form_admisibilidad]
								[dep id=ml_requisitos]
							</td>
							<td>
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

	function mostrar_detalles_director($detalles)
	{
		////se arma el template (tiene un encabezado que resume los datos del director)
		$resumen = "<p>Director: <b class='etiqueta_info'>".$detalles['apellido'].", ".$detalles['nombres']."</b> (".$detalles['tipo_doc'].". ".$detalles['nro_documento'].")</p>";
		//$resumen .= "<p>CUIL: ".$detalles['cuil']."</p>";
		$resumen .= "<p>M&aacute;ximo Grado: ".$detalles['nivel_academico']."</p>";
		$resumen .= "<p>Cat. Incentivos: ".$detalles['cat_incentivos']."</p>";
		$resumen .= "<p>Cat. CONICET: ".$detalles['cat_conicet']."</p>";
		$resumen .= "Cargos:<ul>";
		foreach($detalles['cargos'] as $indice => $cargo){
			if($cargo['fecha_desde']){
				$desde = new DateTime($cargo['fecha_desde']);
			}
			if($cargo['fecha_hasta']){
				$hasta = new DateTime($cargo['fecha_hasta']);
			}
			$hoy = new DateTime();
			$resumen .= ($hoy >= $desde && $hoy <= $hasta) ? "<li class=cargo_vigente>" : "<li>";
				
			$resumen .= "Cargo: ".$cargo['cargo']." - Dedicaci&oacute;n: ".$cargo['dedicacion']." (".$cargo['dependencia'].").";
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