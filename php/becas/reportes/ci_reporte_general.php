<?php
class ci_reporte_general extends becas_ci
{
	protected $s__filtro;
	//-----------------------------------------------------------------------------------
	//---- cu_becas ---------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_becas(becas_ei_cuadro $cuadro)
	{
		if(isset($this->s__filtro)){
			$cuadro->set_datos(toba::consulta_php('co_becas_otorgadas')->get_becas_otorgadas($this->s__filtro));
		}else{
			$cuadro->set_titulo('Debe filtrar para ver resultados en este cuadro');
		}
	}

	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

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
	}

}
?>