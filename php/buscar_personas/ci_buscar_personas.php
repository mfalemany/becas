<?php
class ci_buscar_personas extends becas_ci
{
	protected $s__filtro;
	//-----------------------------------------------------------------------------------
	//---- cu_personas ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_personas(becas_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		if(isset($this->s__filtro)){
			$cuadro->set_datos(toba::consulta_php("co_personas")->get_personas_busqueda($this->s__filtro));
		}
	}

	//-----------------------------------------------------------------------------------
	//---- form_filtro_personas ---------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_filtro_personas(becas_ei_formulario $form)
	{
		if(isset($this->s__filtro)){
			$form->set_datos($this->s__filtro);
		}
	}

	function evt__form_filtro_personas__filtrar($datos)
	{
		$this->s__filtro = $datos;
	}

	function evt__form_filtro_personas__cancelar()
	{
		unset($this->s__filtro);
	}

}
?>