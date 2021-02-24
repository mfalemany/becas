<?php
class ci_presentacion_informe extends becas_ci
{

	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__volver()
	{
		$this->get_datos()->resetear();
		$this->set_pantalla('pant_presentacion');
	}
	//-----------------------------------------------------------------------------------
	//---- cu_postulaciones ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_postulaciones(becas_ei_cuadro $cuadro)
	{
		$filtro = ( ! $this->soy_admin()) ? array('nro_documento' => toba::usuario()->get_id()) : array();
		$cuadro->set_datos(toba::consulta_php('co_informes')->get_becas_vigentes($filtro));
	}

	function evt__cu_postulaciones__ver($seleccion)
	{
		$this->get_datos('inscripcion_conv_beca')->set($seleccion);
		$this->set_pantalla('pant_seleccion_informe');
	}

	function conf_evt__cu_postulaciones__ver(toba_evento_usuario $evento, $fila)
	{

	}

	//-----------------------------------------------------------------------------------
	//---- cu_informes -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_informes(becas_ei_cuadro $cuadro)
	{
		$postulacion = $this->get_datos('inscripcion_conv_beca')->get();
		$cuadro->set_datos(toba::consulta_php('co_informes')->get_informes_postulacion($postulacion));
	}

	function evt__cu_informes__presentar($datos)
	{
	}

	function conf_evt__cu_informes__presentar(toba_evento_usuario $evento, $fila)
	{
		
	}





}
?>