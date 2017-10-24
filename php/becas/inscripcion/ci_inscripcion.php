<?php
class ci_inscripcion extends becas_ci
{
	//---- Cuadro -----------------------------------------------------------------------

	function conf__cuadro(toba_ei_cuadro $cuadro)
	{
		$cuadro->set_datos(toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones());
	}

	function evt__cuadro__seleccion($datos)
	{
		$this->get_datos('inscripcion_conv_beca')->cargar($datos);
		$this->set_pantalla('pant_edicion');
	}

	function evt__cuadro__admitir($datos)
	{
		$this->get_datos('inscripcion_conv_beca')->cargar($datos);
		$this->set_pantalla('pant_admisibilidad');
	}

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

	function conf__pant_admisibilidad(toba_ei_pantalla $pantalla)
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
								</table>");
	}

	function evt__form_admisibilidad__modificacion($datos)
	{
		$this->get_datos('inscripcion_conv_beca')->set($datos);
	}

	//---- Formulario -------------------------------------------------------------------

/*	function conf__formulario(toba_ei_formulario $form)
	{
		if ($this->dep('datos')->esta_cargada()) {
			$form->set_datos($this->dep('datos')->tabla('inscripcion_conv_beca')->get());
		} else {
			$this->pantalla()->eliminar_evento('eliminar');
		}
	}*/

	/*function evt__formulario__modificacion($datos)
	{
		$this->dep('datos')->tabla('inscripcion_conv_beca')->set($datos);
	}*/

	function resetear()
	{
		$this->dep('datos')->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	//---- EVENTOS CI -------------------------------------------------------------------

	function evt__agregar()
	{
		$this->set_pantalla('pant_edicion');
	}

	function evt__volver()
	{
		$this->resetear();
	}

	function evt__eliminar()
	{
		$this->dep('datos')->eliminar_todo();
		$this->resetear();
	}

	function evt__guardar()
	{
		$this->dep('datos')->sincronizar();
		$this->resetear();
	}

	function get_datos($tabla = NULL)
	{
		if( ! $tabla){
			return $this->dep('datos');
		}else{
			return $this->dep('datos')->tabla($tabla);
		}
	}

}

?>