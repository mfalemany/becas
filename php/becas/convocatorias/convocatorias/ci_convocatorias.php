<?php
class ci_convocatorias extends becas_ci
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
			$cuadro->set_datos(toba::consulta_php('co_convocatoria_beca')->get_convocatorias($this->s__datos_filtro));
		} else {
			$cuadro->set_datos(toba::consulta_php('co_convocatoria_beca')->get_convocatorias());
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
			$form->set_datos($this->dep('datos')->tabla('convocatoria_beca')->get());
		} else {
			$this->pantalla()->eliminar_evento('eliminar');
		}
	}

	function evt__formulario__modificacion($datos)
	{
		$errores = $this->validar($datos);
		if(count($errores)){
			$errores = implode('/n',$errores);
			toba::notificacion()->agregar('Ocurrieron los siguientes erores: '.$errores);
			return false;
		}else{
			$this->dep('datos')->tabla('convocatoria_beca')->set($datos);	
		}
		
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

	private function validar($datos)
	{
		extract($datos);
		$errores = array();
		if($fecha_desde >= $fecha_hasta){
			$errores[] = 'El campo \'Fecha Desde\' debe ser menor que el campo \'Fecha Hasta\'';
		}
		if($fecha_hasta > $limite_movimientos){
			$errores[] = 'El campo \'Limite de Movimientos\' debe ser mayor o igual que el campo \'Fecha Hasta\'';
		}
		if($cupo_maximo <= 0){
			$errores[] = 'El campo \'Cupo Máximo\' debe ser mayor a cero';	
		}
		return $errores;
		
	}

}

?>