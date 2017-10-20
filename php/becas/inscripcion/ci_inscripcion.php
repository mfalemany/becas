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

		/**
		 * VER ACÁ QUE ES LO QUE SE CARGA Y COMO, PARA TENER LOS DATOS DISPONIBLES EN EL CI_EDICION
		 * 
		 */
		
		$persona = array('id_tipo_doc'=>$datos['id_tipo_doc'],'nro_documento'=>$datos['nro_documento']);
		$this->dep('datos')->tabla('alumno')->cargar($persona);
		$this->dep('datos')->tabla('inscripcion_conv_beca')->cargar($datos);
		//$this->dep('datos')->tabla('director_docente')->cargar($persona);
		//ei_arbol($this->dep('datos')->tabla('inscripcion_conv_beca')->get()); return;
		$this->set_pantalla('pant_edicion');
	}

	//---- Formulario -------------------------------------------------------------------

	function conf__formulario(toba_ei_formulario $form)
	{
		if ($this->dep('datos')->esta_cargada()) {
			$form->set_datos($this->dep('datos')->tabla('inscripcion_conv_beca')->get());
		} else {
			$this->pantalla()->eliminar_evento('eliminar');
		}
	}

	function evt__formulario__modificacion($datos)
	{
		$this->dep('datos')->tabla('inscripcion_conv_beca')->set($datos);
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