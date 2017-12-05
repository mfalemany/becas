<?php
class ci_admisibilidad extends becas_ci
{
	//-----------------------------------------------------------------------------------
	//---- form_admisibilidad -----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_admisibilidad(becas_ei_formulario $form)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		if($insc){
			//$detalles = $this->get_detalles_insc($insc['id_convocatoria'],$insc['id_tipo_beca'],$insc['id_tipo_doc'],$insc['nro_documento']);
			$form->set_datos($insc);
			//$resumen = $this->formatear_resumen($detalles);
			//$form->set_datos(array('resumen'=>$resumen));
		}else{

		}
		
	}

	function evt__form_admisibilidad__modificacion($datos)
	{
		$this->get_datos('inscripcion','inscripcion_conv_beca')->set($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- ml_requisitos ----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_requisitos(becas_ei_formulario_ml $form_ml)
	{
		//obtengo los detalles de la inscripcion
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();

		//cargo la tabla de requisitos
		$this->get_datos('inscripcion','requisitos_insc')->cargar();
		
		//obtengo el estado de presentacion de requisitos del aspirante
		$req = toba::consulta_php('co_requisitos_insc')->get_requisitos_insc($insc['id_convocatoria'],$insc['id_tipo_beca'],$insc['id_tipo_doc'],$insc['nro_documento']);
		$form_ml->set_datos($req);
	}

	function evt__ml_requisitos__modificacion($datos)
	{
		$this->get_datos('inscripcion','requisitos_insc')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__pant_inicial(toba_ei_pantalla $pantalla)
	{
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();

		/* ================================== DIRECTOR ================================ */
		$det = toba::consulta_php('co_docentes')->get_resumen_docente($insc['id_tipo_doc_dir'],$insc['nro_documento_dir']);

		$detalles_cargos = toba::consulta_php('co_docentes')->get_cargos_docente($insc['id_tipo_doc_dir'],$insc['nro_documento_dir']);
		$detalles = array_merge($det,array('cargos'=>$detalles_cargos));
		$resumen_dir = $this->mostrar_detalles_director($detalles);
		/* ============================================================================ */

		unset($det);
		unset($detalles_cargos);

		/* ================================= CODIRECTOR =============================== */
		if($insc['id_tipo_doc_codir'] && $insc['nro_documento_codir']){
			$det = toba::consulta_php('co_docentes')->get_resumen_docente($insc['id_tipo_doc_codir'],$insc['nro_documento_codir']);
			$detalles_cargos = toba::consulta_php('co_docentes')->get_cargos_docente($insc['id_tipo_doc_codir'],$insc['nro_documento_codir']);
			$detalles = array_merge($det,array('cargos'=>$detalles_cargos));
			$resumen_codir = $this->mostrar_detalles_director($detalles);	
		}
		/* ============================================================================ */

		unset($det);
		unset($detalles_cargos);

		/* ================================= SUBDIRECTOR =============================== */
		if($insc['id_tipo_doc_subdir'] && $insc['nro_documento_subdir']){
			$det = toba::consulta_php('co_docentes')->get_resumen_docente($insc['id_tipo_doc_subdir'],$insc['nro_documento_subdir']);
			$detalles_cargos = toba::consulta_php('co_docentes')->get_cargos_docente($insc['id_tipo_doc_subdir'],$insc['nro_documento_subdir']);
			$detalles = array_merge($det,array('cargos'=>$detalles_cargos));
			$resumen_subdir = $this->mostrar_detalles_director($detalles);	
		}
		/* ============================================================================ */

		$edad_asp = toba::consulta_php('co_personas')->get_edad(array('id_tipo_doc'   => $insc['id_tipo_doc'],
																	  'nro_documento' => $insc['nro_documento']),
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
								<fieldset>
									<legend>Resumen del Director de la beca</legend>
									$resumen_dir
								</fieldset>";
		if(isset($resumen_codir)){
			$template .= "	<br><fieldset>
									<legend>Resumen del Co-Director de la beca</legend>
									$resumen_codir
								</fieldset>";
		}
		if(isset($resumen_subdir)){
			$template .= "	<br><fieldset>
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

	


	function get_datos($relacion = NULL, $tabla = NULL)
	{
		return $this->controlador()->get_datos($relacion, $tabla);
	}

	

}
?>