<?php
class form_ml_estudios_afines extends becas_ei_formulario_ml
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Validacion de EFs -----------------------------------
		
		{$this->objeto_js}.evt__anio_desde__validar = function(fila)
		{
			return (this.ef('anio_desde').ir_a_fila(fila).get_estado() <= ".date('Y').");
		}
		
		{$this->objeto_js}.evt__anio_hasta__validar = function(fila)
		{
			return (this.ef('anio_hasta').ir_a_fila(fila).get_estado() >= this.ef('anio_desde').ir_a_fila(fila).get_estado() && this.ef('anio_hasta').ir_a_fila(fila).get_estado() <= ".date('Y').");
		}
		";
	}

}
?>