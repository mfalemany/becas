<?php
class ci_admisibilidad extends becas_ci
{
	//-----------------------------------------------------------------------------------
	//---- form_admisibilidad -----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_admisibilidad(becas_ei_formulario $form)
	{
		$insc = $this->get_datos('inscripcion_conv_beca')->get();
		if($insc){
			//$detalles = $this->get_detalles_insc($insc['id_convocatoria'],$insc['id_tipo_beca'],$insc['id_tipo_doc'],$insc['nro_documento']);
			$form->set_datos($insc);
			//$resumen = $this->formatear_resumen($detalles);
			//$form->set_datos(array('resumen'=>$resumen));
		}else{

		}
		
	}
	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__pant_inicial(toba_ei_pantalla $pantalla)
	{
		$insc = $this->get_datos('inscripcion_conv_beca')->get();

		//se obtienen los detalles de la inscripcion
		$det_doc = toba::consulta_php('co_inscripcion_conv_beca')->get_detalles_director($insc['id_convocatoria'],$insc['id_tipo_beca'],$insc['id_tipo_doc'],$insc['nro_documento']);


		//se obtienen los detalles de los cargos del docente
		$detalles_cargos = toba::consulta_php('co_docentes')->get_cargos_docente($det_doc['id_tipo_doc_dir'],$det_doc['nro_documento_dir']);
		//se unifican ambos arrays
		$detalles = array_merge($det_doc,array('cargos'=>$detalles_cargos));
		//ei_arbol($detalles);
		////se arma el template (tiene un encabezado que resume los datos del director)
		$resumen = "<p>Director: <b class='etiqueta_importante'>".$detalles['apellido'].", ".$detalles['nombres']."</b> (".$detalles['tipo_doc'].". ".$detalles['nro_documento_dir'].")</p>";
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
		$pantalla->set_template("<table>
									<tr>
										<td>[dep id=form_admisibilidad]</td>
										<td>
											<fieldset>
												<legend>Resumen del director de la beca</legend>
												$resumen
											</fieldset>
										</td>
									</tr>
									<tr>
										<td>[dep id=ml_requisitos]</td>
									</tr>
								</table>");
	}

	function evt__form_admisibilidad__modificacion($datos)
	{
		$this->get_datos('inscripcion_conv_beca')->set($datos);
	}


	function get_datos($tabla = NULL)
	{
		return $this->controlador()->get_datos($tabla);
	}

	//-----------------------------------------------------------------------------------
	//---- ml_requisitos ----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_requisitos(becas_ei_formulario_ml $form_ml)
	{
		$datos = $this->get_datos('inscripcion_conv_beca')->get();
		if($datos){
			$form_ml->set_datos(toba::consulta_php('co_requisitos_insc')->get_requisitos_insc(
				$datos['id_convocatoria'],
				$datos['id_tipo_doc'],
				$datos['nro_documento']
			));
		}
	}

	function evt__ml_requisitos__modificacion($datos)
	{
		$this->get_datos('requisitos_insc')->procesar_filas($datos);
	}

}
?>