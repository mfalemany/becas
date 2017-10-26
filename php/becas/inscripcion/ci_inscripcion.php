<?php
class ci_inscripcion extends becas_ci
{
	//---- Cuadro -----------------------------------------------------------------------

	function conf__cuadro(toba_ei_cuadro $cuadro)
	{
		$cuadro->set_datos(toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones());
	}

	function evt__cuadro__seleccion($datos)
	{
		$this->get_datos('inscripcion_conv_beca')->cargar($datos);
		$this->set_pantalla('pant_edicion');
	}

	function evt__cuadro__admitir($datos)
	{
		$this->get_datos('inscripcion_conv_beca')->cargar($datos);
		$this->set_pantalla('pant_admisibilidad');
	}
	

	function resetear()
	{
		$this->dep('datos')->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	//---- EVENTOS CI -------------------------------------------------------------------

	function evt__agregar()
	{
		$this->set_pantalla('pant_edicion');
	}

	function evt__volver()
	{
		$this->resetear();
	}

	function evt__eliminar()
	{
		$this->dep('datos')->eliminar_todo();
		$this->resetear();
	}

	function evt__guardar()
	{
		$this->dep('datos')->sincronizar();
		$this->resetear();
	}

	function get_datos($tabla = NULL)
	{
		if( ! $tabla){
			return $this->dep('datos');
		}else{
			return $this->dep('datos')->tabla($tabla);
		}
	}

}

?>