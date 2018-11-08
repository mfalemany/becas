<?php
class ci_seguimiento extends becas_ci
{
	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__pant_inicial(toba_ei_pantalla $pantalla)
	{
		//defino la ubicación del archivo template
		$ubicacion_template = __DIR__ . '/templates/template_seguimiento.php';

		//obtengo todos los datos necesarios para el seguimiento de la solicitud
		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		
		if(count($insc)){
			$datos = toba::consulta_php('co_comision_asesora')->get_detalles_seguimiento($insc);
			$datos['publicar_adm'] = toba::consulta_php('co_convocatoria_beca')->get_campo('publicar_admisibilidad',$insc['id_convocatoria']);
			$datos['publicar_res'] = toba::consulta_php('co_convocatoria_beca')->get_campo('publicar_resultados',$insc['id_convocatoria']);
		}

		
		
		$template = $this->armar_template($ubicacion_template,$datos);
		$pantalla->set_template($template);
	}

	//-----------------------------------------------------------------------------------
	//---- form_seguimiento -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_seguimiento(becas_ei_formulario $form)
	{
		$form->set_datos($this->get_datos('inscripcion','inscripcion_conv_beca')->get());
	}

	function &get_datos($relacion, $tabla = NULL)
	{
		$datos = FALSE;
		if($tabla){
			if($relacion){
				$datos = $this->controlador()->dep($relacion)->tabla($tabla);
			}else{
				$datos = $this->controlador()->dep($tabla);
			}
		}else{
			if($relacion){
				$datos = $this->controlador()->dep($relacion);
			}
		}
		return $datos;

	}

	

}
?>