<?php
class form_ml_requisitos extends becas_ei_formulario_ml
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
		
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__cumplido__procesar = function(es_inicial, fila)
		{
			
		}
		";
	}

}
?>