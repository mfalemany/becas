<?php
class form_ml_integrantes extends becas_ei_formulario_ml
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Validacion general ----------------------------------
		
		{$this->objeto_js}.evt__validar_datos = function()
		{
		}
		
		//---- Validacion de EFs -----------------------------------
		
		{$this->objeto_js}.evt__persona__validar = function(fila)
		{
		}
		";
	}

}
?>