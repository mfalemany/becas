<?php
class ci_criterios_evaluacion extends becas_ci
{
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__agregar()
	{
		$this->get_datos()->resetear();
		$this->set_pantalla('pant_edicion');
	}

	function evt__cancelar()
	{
		$this->get_datos()->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	function evt__eliminar()
	{
		$this->get_datos('be_tipo_beca_criterio_eval')->eliminar_todo();
		$this->get_datos()->resetear();
		toba::notificacion()->agregar('Eliminado con éxito','info');
		$this->set_pantalla('pant_seleccion');
	}

	function evt__guardar()
	{
		$this->get_datos()->sincronizar();
		$this->get_datos()->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	//-----------------------------------------------------------------------------------
	//---- cu_criterios -----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_criterios(becas_ei_cuadro $cuadro)
	{
		$cuadro->set_datos(toba::consulta_php('co_tipos_beca')->get_criterios_evaluacion());
	}

	function evt__cu_criterios__seleccion($seleccion)
	{
		$this->get_datos()->cargar($seleccion);
		$this->set_pantalla('pant_edicion');
	}

	//-----------------------------------------------------------------------------------
	//---- form_criterio_eval -----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_criterio_eval(becas_ei_formulario $form)
	{
		if($this->get_datos()->esta_cargada()){
			$form->set_datos($this->get_datos('be_tipo_beca_criterio_eval')->get());
		}
	}

	function evt__form_criterio_eval__modificacion($datos)
	{
		$this->get_datos('be_tipo_beca_criterio_eval')->set($datos);
	}

	
	function get_datos($tabla = NULL)
	{
		return ($tabla) ? $this->dep('datos')->tabla($tabla) : $this->dep('datos');
	}

}
?>