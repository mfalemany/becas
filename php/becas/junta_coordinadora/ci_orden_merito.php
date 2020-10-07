<?php
class ci_orden_merito extends becas_ci
{
	protected $s__filtro;
	//-----------------------------------------------------------------------------------
	//---- cu_orden_merito --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_orden_merito(becas_ei_cuadro $cuadro)
	{
		$id_conv = toba::consulta_php('co_convocatoria_beca')->get_id_ultima_convocatoria(TRUE);
		$filtro = array('id_convocatoria'=>$id_conv);
		$filtro = (isset($this->s__filtro)) ? array_merfe($this->s__filtro,$filtro) : $filtro;
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
		$form->set_solo_lectura('id_convocatoria');
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