<?php
class ci_cumplimiento_obligaciones extends becas_ci
{
	protected $s__filtro;
	protected $s__becario;
	protected $s__filtro_general;
	//-----------------------------------------------------------------------------------
	//---- PANTALLA: REPORTE POR BECARIO POR BECARIO ------------------------------------
	//-----------------------------------------------------------------------------------
	
	//---- filtro -----------------------------------------------------------------------

	function conf__filtro(becas_ei_formulario $form)
	{
		if(isset($this->s__filtro)){
			$form->set_datos($this->s__filtro);
		}
	}

	function evt__filtro__filtrar($datos)
	{
		$this->s__filtro = $datos;
	}

	function evt__filtro__cancelar()
	{
		unset($this->s__filtro);
		unset($this->s__becario);
	}
	//---- becarios ---------------------------------------------------------------------

	function conf__becarios(becas_ei_cuadro $cuadro)
	{
		if( ! isset($this->s__filtro)){
			$cuadro->set_titulo('Debe establecer un filtro para ver datos en este cuadro');
		}else{
			$cuadro->set_datos(toba::consulta_php('co_becas_otorgadas')->get_becas_otorgadas($this->s__filtro));
		}
	}

	function evt__becarios__seleccion($seleccion)
	{
		$this->s__becario = $seleccion;
	}

	//---- cumplimientos ----------------------------------------------------------------

	function conf__cumplimientos(becas_ei_cuadro $cuadro)
	{
		if( ! isset($this->s__becario)){
			$cuadro->set_titulo('Debe seleccionar un becario en el cuadro de arriba para ver aquí sus cumplimientos');
		}else{
			extract($this->s__becario);
			$cuadro->set_datos(toba::consulta_php('co_cumplim_obligaciones')->get_cumplimientos_becario($nro_documento,$id_convocatoria,$id_tipo_beca));
		}
	}

	//-----------------------------------------------------------------------------------
	//---- PANTALLA: REPORTE GENERAL ----------------------------------------------------
	//-----------------------------------------------------------------------------------

	//---- filtro_general ---------------------------------------------------------------
	function conf__filtro_general(becas_ei_formulario $form)
	{
		if(isset($this->s__filtro_general)){
			$form->set_datos($this->s__filtro_general);
		}
	}

	function evt__filtro_general__filtrar($datos)
	{
		$this->s__filtro_general = $datos;
	}

	function evt__filtro_general__cancelar()
	{
		unset($this->s__filtro_general);
	}

	//---- cumplimientos_mes ------------------------------------------------------------
	function conf__cumplimientos_mes(becas_ei_cuadro $cuadro)
	{
		if(isset($this->s__filtro_general) && $this->s__filtro_general){
			$cuadro->set_datos(toba::consulta_php('co_cumplim_obligaciones')->get_cumplimientos_mes($this->s__filtro_general));
		}
	}


}
?>