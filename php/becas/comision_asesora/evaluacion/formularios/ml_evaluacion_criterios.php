<?php
class ml_evaluacion_criterios extends becas_ei_formulario_ml
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Validacion de EFs -----------------------------------
		
		{$this->objeto_js}.evt__puntaje__validar = function(fila)
		{
			asignado = this.ef('puntaje').ir_a_fila(fila).get_estado();
			maximo = this.ef('puntaje_maximo').ir_a_fila(fila).get_estado()
			this.ef('puntaje').set_error('El puntaje asignado es mayor al máximo permitido (o el campo está vacío)');
			return ((asignado <= maximo) && (asignado));
		}
		";
	}

}
?>