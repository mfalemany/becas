<?php
class ci_inscripcion extends becas_ci
{
	function conf()
	{
		//si no existen convocatorias con inscripcion abierta, elimino el evento 'agregar (Nueva Inscripcion'
		if( ! toba::consulta_php('co_convocatoria_beca')->existen_convocatorias_vigentes()){
			$this->pantalla()->eliminar_evento('agregar');
			$this->dep('cuadro')->agregar_notificacion('No existen convocatorias con periodo de inscripción abierto');
		}
	}
	//---- Cuadro -----------------------------------------------------------------------

	function conf__cuadro(toba_ei_cuadro $cuadro)
	{
		$filtro = array();
		
		if(in_array('becario',toba::usuario()->get_perfiles_funcionales())){
			$filtro = array('nro_documento' => toba::usuario()->get_id());
			$cuadro->eliminar_evento('admitir');
		}

		$cuadro->set_datos(toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones($filtro));
		
	}
	

	function evt__cuadro__seleccion($datos)
	{
		$this->get_datos('inscripcion_conv_beca')->set($datos);
		$this->get_datos()->cargar();
		//ei_arbol($this->get_datos('alumno')->get_filas());
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
		$this->dep('datos')->tabla('requisitos_insc')->eliminar();
		$this->dep('datos')->tabla('inscripcion_conv_beca')->eliminar();
		$this->resetear();
	}

	function evt__guardar()
	{
		$this->dep('ci_edicion')->generar_registros_relacionados();
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