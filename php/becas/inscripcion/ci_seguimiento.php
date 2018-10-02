<?php
class ci_seguimiento extends becas_ci
{
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