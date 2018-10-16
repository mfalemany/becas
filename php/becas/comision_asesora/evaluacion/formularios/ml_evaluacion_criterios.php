<?php
class ml_evaluacion_criterios extends becas_ei_formulario_ml
{
	
	function ini()
	{
		$url_base = toba::consulta_php('helper_archivos')->url_base();
		$tpl_reglamento = "<a href='{$url_base}becas/estaticos/reglamento.pdf' TARGET='_BLANK'>Ver reglamento</a>";
		$tpl_pautas = "<a href='{$url_base}becas/estaticos/pautas.pdf' TARGET='_BLANK'>Ver pautas de evaluación</a>";
		$this->agregar_notificacion($tpl_reglamento."&nbsp;&nbsp;-&nbsp;&nbsp;".$tpl_pautas,'info');
	}
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function extender_objeto_js()
	{
		echo "
		var filas = {$this->objeto_js}.filas()
		
		function actualizar_total()
		{
			var asignados = 0;
			for (id_fila in filas) {
				var puntaje = {$this->objeto_js}.ef('puntaje').ir_a_fila(filas[id_fila]).get_estado();
				if($.isNumeric(puntaje)){
					asignados += puntaje;	
				}
				
			}
			$('#puntaje_final_valor').html(asignados+parseFloat($('#puntaje_inicial_valor').html()));
			
		}

		//---- Validacion de EFs -----------------------------------
		for (id_fila in filas) {
			{$this->objeto_js}.ef('puntaje').ir_a_fila(filas[id_fila]).cuando_cambia_valor('actualizar_total()');
		}	
		
		{$this->objeto_js}.evt__puntaje__validar = function(fila)
		{
			asignado = this.ef('puntaje').ir_a_fila(fila).get_estado();
			maximo = this.ef('puntaje_maximo').ir_a_fila(fila).get_estado()
			this.ef('puntaje').set_error('El puntaje asignado es mayor al máximo permitido (o el campo está vacío)');
			return (asignado <= maximo) && (asignado >= 0) && (asignado.toString().length > 0);
		}

		";
	}

}
?>