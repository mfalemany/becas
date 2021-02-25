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
		$this->get_datos()->cargar($seleccion);
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
		$otorgada = $this->get_datos('becas_otorgadas')->get();
		$cuadro->set_titulo(sprintf('Duracion de la beca: del %s al %s',$this->fecha_dmy($otorgada['fecha_desde']),$this->fecha_dmy($otorgada['fecha_hasta'])));
		$cuadro->set_datos(toba::consulta_php('co_informes')->get_informes_postulacion($otorgada));
	}

	function evt__cu_informes__presentar($seleccion)
	{
		$this->get_datos('informe_beca')->set($seleccion);
		$this->set_pantalla('pant_informe');

	}

	function conf_evt__cu_informes__presentar(toba_evento_usuario $evento, $fila)
	{
		//Aca hay que validar la fecha de presentacion para mostrar/ocultar el evento
	}

	//-----------------------------------------------------------------------------------
	//---- form_informe_beca ------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_informe_beca(becas_ei_formulario $form)
	{
		$informe = $this->get_datos('informe_beca')->get();

		$ruta_base = toba::consulta_php('co_tablas_basicas')->get_parametro_conf('ruta_base_documentos');
		if( ! ($ruta_base && strlen($ruta_base) >0 && is_dir($ruta_base))){
			throw new toba_error('No está definido el parámetro \'ruta_base_documentos\' en la configuración del sistema (o no es una ruta válida)');
		}
		$sub_ruta = sprintf("/becas/doc_por_convocatoria/%s/%s/%s/informes/%s.pdf",
			$informe['id_convocatoria'],
			$informe['id_tipo_beca'],
			$informe['nro_documento'],
			$informe['nro_informe']);
		if(file_exists($sub_ruta)){
			$form->set_datos(array('archivo'=>$informe['nro_informe'].".pdf"));
		}
	}

	function evt__form_informe_beca__modificacion($datos)
	{

		if(isset($datos['archivo']) && $datos['archivo']){
			
			//validar TIPO MIME DE ARCHIVOç
			
			$carpeta = sprintf("/becas/doc_por_convocatoria/%s/%s/%s/informes",
			$informe['id_convocatoria'],
			$informe['id_tipo_beca'],
			$informe['nro_documento']);
			
			toba::consulta_php('helper_archivos')->subir_archivo();
		}
	}

}
?>