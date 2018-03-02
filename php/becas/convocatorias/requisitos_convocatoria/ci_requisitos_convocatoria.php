<?php
class ci_requisitos_convocatoria extends becas_ci
{
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__procesar()
	{
	}

	function evt__cancelar()
	{
	}

	function evt__volver()
	{
	}

	//-----------------------------------------------------------------------------------
	//---- cuadro_convocatorias ---------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro_convocatorias(becas_ei_cuadro $cuadro)
	{
		$cuadro->set_datos(toba::consulta_php('co_convocatoria_beca')->get_convocatorias());
	}

	function evt__cuadro_convocatorias__seleccion($seleccion)
	{
	}

	//-----------------------------------------------------------------------------------
	//---- ml_requisitos_conv -----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_requisitos_conv(becas_ei_formulario_ml $form_ml)
	{
	}

	function evt__ml_requisitos_conv__modificacion($datos)
	{
	}

}

?>