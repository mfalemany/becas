<?php
class ci_criterios_evaluacion extends becas_ci
{
	protected $s__conv_tiene_inscripciones;
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function evt__cancelar()
	{
		$this->get_datos()->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	function evt__guardar()
	{
		$this->get_datos()->sincronizar();
		$this->get_datos()->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	function get_datos($tabla = NULL)
	{
		return ($tabla) ? $this->dep('datos')->tabla($tabla) : $this->dep('datos');
	}

	//-----------------------------------------------------------------------------------
	//---- cu_convocatorias -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_convocatorias(becas_ei_cuadro $cuadro)
	{
		$cuadro->set_datos(toba::consulta_php('co_convocatoria_beca')->get_convocatorias_todas());
	}

	function evt__cu_convocatorias__seleccion($seleccion)
	{
		$this->s__conv_tiene_inscripciones = toba::consulta_php('co_convocatoria_beca')->existen_inscripciones($seleccion['id_convocatoria']);
		$this->get_datos()->cargar($seleccion);
		$this->set_pantalla('pant_edicion');
	}

	//-----------------------------------------------------------------------------------
	//---- ml_criterios -----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_criterios(becas_ei_formulario_ml $form_ml)
	{
		$datos = $this->get_datos('be_tipo_beca_criterio_eval')->get_filas();
		if($datos){
			$form_ml->set_datos($datos);
		}
		if($this->s__conv_tiene_inscripciones){
			$form_ml->set_solo_lectura();
			$form_ml->desactivar_agregado_filas();
			$form_ml->agregar_notificacion('No se pueden realizar modificaciones debido a que ya existen inscripciones a esta convocatoria','warning');
		}

	}

	function evt__ml_criterios__modificacion($datos)
	{
		$this->get_datos('be_tipo_beca_criterio_eval')->procesar_filas($datos);
	}

}
?>