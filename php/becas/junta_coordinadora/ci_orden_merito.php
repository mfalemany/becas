<?php
class ci_orden_merito extends becas_ci
{
	protected $s__filtro;
	//-----------------------------------------------------------------------------------
	//---- cu_orden_merito --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_orden_merito(becas_ei_cuadro $cuadro)
	{
		$filtro = (isset($this->s__filtro)) ? $this->s__filtro : array();
		$datos = toba::consulta_php('co_junta_coordinadora')->get_orden_merito($filtro);
		$cuadro->set_datos($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- form_filtro ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_filtro(becas_ei_formulario $form)
	{
		$filtro = (isset($this->s__filtro)) ? $this->s__filtro : array();
		$form->set_datos($filtro);
	}

	function evt__form_filtro__filtrar($datos)
	{
		$this->s__filtro = $datos;
	}

	function evt__form_filtro__cancelar()
	{
		unset($this->s__filtro);
	}

}
?>