<?php
class ci_reporte_general extends becas_ci
{
	protected $filtro;
	//-----------------------------------------------------------------------------------
	//---- cu_becas ---------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_becas(becas_ei_cuadro $cuadro)
	{
		if(isset($this->filtro)){
			$cuadro->set_datos(toba::consulta_php('co_becas_otorgadas')->get_becas_otorgadas($this->filtro));
		}else{
			$cuadro->set_titulo('Debe filtrar para ver resultados en este cuadro');
		}
	}

	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro(becas_ei_formulario $form)
	{
		if(isset($this->filtro)){
			$form->set_datos($this->filtro);
		}
	}

	function evt__filtro__filtrar($datos)
	{
		$this->filtro = $datos;
	}

	function evt__filtro__cancelar()
	{
		unset($this->filtro);
	}

}
?>