<?php
class ci_carreras extends becas_ci
{
	protected $s__datos_filtro;


	//---- Filtro -----------------------------------------------------------------------

	function conf__filtro(toba_ei_formulario $filtro)
	{
		if (isset($this->s__datos_filtro)) {
			$filtro->set_datos($this->s__datos_filtro);
		}
	}

	function evt__filtro__filtrar($datos)
	{
		$this->s__datos_filtro = $datos;
	}

	function evt__filtro__cancelar()
	{
		unset($this->s__datos_filtro);
	}

	//---- Cuadro -----------------------------------------------------------------------

	function conf__cuadro(toba_ei_cuadro $cuadro)
	{
		if (isset($this->s__datos_filtro)) {
			$cuadro->set_datos(toba::consulta_php('co_carreras')->get_carreras($this->s__datos_filtro));
		} else {
			$cuadro->set_datos(toba::consulta_php('co_carreras')->get_carreras());
		}
	}

	function evt__cuadro__seleccion($datos)
	{
		$this->dep('datos')->cargar($datos);
		$this->set_pantalla('pant_edicion');
	}

	//---- Formulario -------------------------------------------------------------------

	function conf__formulario(toba_ei_formulario $form)
	{
		if ($this->dep('datos')->esta_cargada()) {
			$form->set_datos($this->dep('datos')->tabla('carreras')->get());
		} else {
			$this->pantalla()->eliminar_evento('eliminar');
		}
	}

	function evt__formulario__modificacion($datos)
	{
		$this->dep('datos')->tabla('carreras')->set($datos);
	}

	function resetear()
	{
		$this->dep('datos')->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	//---- ml_carrera_dependencia --------------------------------------------------------

	function conf__ml_carrera_dependencia(becas_ei_formulario_ml $form_ml)
	{
		if ($this->dep('datos')->esta_cargada()) {
			$form_ml->set_datos($this->dep('datos')->tabla('carrera_dependencia')->get_filas());
		}
	}

	/*function evt__ml_carrera_dependencia__modificacion($datos)
	{
		foreach($datos as $clave => $registro){
			if($registro['apex_ei_analisis_fila'] == 'A'){

			}
			if($registro['apex_ei_analisis_fila'] == 'M'){
				
			}
			if($registro['apex_ei_analisis_fila'] == 'B'){
				
			}
		}
		
		
	}*/
	function evt__ml_carrera_dependencia__registro_alta($registro, $id)
    {
        $this->dep('datos')->tabla('carrera_dependencia')->nueva_fila($registro);

    }

    function evt__ml_carrera_dependencia__registro_baja($id)
    {
        $this->dep('datos')->tabla('carrera_dependencia')->eliminar_fila($id);
    }

    function evt__ml_carrera_dependencia__registro_modificacion($reg, $id)
    {
    	//para permitir esta modificacion, en Toba_editor debe estar tildado "Permitir mod. de claves" en el datos_tabla
        $this->dep('datos')->tabla('carrera_dependencia')->modificar_fila($id,array('id_dependencia'=>$reg['id_dependencia']));
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
		if( ! $this->validar_dependencias()){
			toba::notificacion()->error('No se puede asignar dos veces la misma dependencia. Por favor, elimine las dependencias duplicadas');
			return false;
		}
		$this->dep('datos')->sincronizar();
		$this->resetear();
	}

	//-----------------------------------------------------------------------------------

	//verifico que, en el array de dependencias, no esté definida dos veces la misma dependencia
	function validar_dependencias(){
		$dependencias = array();
		foreach($this->dep('datos')->tabla('carrera_dependencia')->get_filas() as $dep){
			if(in_array($dep['id_dependencia'], $dependencias)){
				//si ya existe definida la dependencia, retorno false
				return false;
			}else{
				//caso contrario, agrego la dependencia al array para futuras comparaciones.
				$dependencias[] = $dep['id_dependencia'];
			}
		}
		return true;
	}


}
?>