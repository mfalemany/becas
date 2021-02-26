<?php
class ci_presentacion_informe extends becas_ci
{
	//Contiene un array del tipo ('plazo'=>'tipo_informes_permitidos'). Ej: array('P'=>'T','E'=>'A'): para presentacion, todos. Para evaluacion, solo de avances 
	private $tipos_informe_permitidos;

	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function conf(){
		$plazos = toba::consulta_php('co_informes')->get_plazos(TRUE);
		if(count($plazos)){
			$this->tipos_informe_permitidos = array_column($plazos, 'tipo_informes','tipo_plazo');
		}
	}

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
		$cuadro->desactivar_modo_clave_segura();
		if( ! toba::consulta_php('co_informes')->hay_plazo_abierto_informes('P')){
			$cuadro->set_eof_mensaje('No hay plazos vigentes para la presentación de informes de becas');
			return;	
		} 
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
		$params = explode('||',$evento->get_parametros());
		//Si no hay plazos de presentación abiertos, no se muestra el botón
		if( ! isset($this->tipos_informe_permitidos['P']) ){
			$evento->ocultar();
		}else{
			//Si el tipo de informe actual, está dentro de los permitidos en el plazo abierto actualmente...
			if($params[4] == $this->tipos_informe_permitidos['P'] || $this->tipos_informe_permitidos['P'] == 'T'){
				$evento->mostrar();
			}else{
				$evento->ocultar();
			}
		}
	}

	//-----------------------------------------------------------------------------------
	//---- form_informe_beca ------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_informe_beca(becas_ei_formulario $form)
	{
		$informe = $this->get_datos('informe_beca')->get();
		

		$ruta_base = toba::consulta_php('co_tablas_basicas')->get_parametro_conf('ruta_base_documentos');
		$url_base = toba::consulta_php('co_tablas_basicas')->get_parametro_conf('url_base_documentos');

		if( ! ($ruta_base && strlen($ruta_base) >0 && is_dir($ruta_base))){
			throw new toba_error('No está definido el parámetro \'ruta_base_documentos\' en la configuración del sistema (o no es una ruta válida)');
		}
		$sub_ruta = sprintf("/becas/doc_por_convocatoria/%s/%s/%s/informes/%s.pdf",
			$informe['id_convocatoria'],
			$informe['id_tipo_beca'],
			$informe['nro_documento'],
			$informe['nro_informe']);

		$informe['archivo'] = (file_exists($ruta_base . $sub_ruta));

		if($informe['archivo']){
			$form->agregar_notificacion('Ya existe un documento cargado. Si quiere reemplazarlo, haga click en el botón "Cambiar el archivo", y luego seleccione uno nuevo.','warning');
		}
		$form->set_datos($informe);
	}

	function evt__form_informe_beca__guardar($datos)
	{
		$datos['fecha_presentacion'] = date('Y-m-d');

		if(isset($datos['archivo']) && $datos['archivo']['size'] > 0){
			if(mime_content_type($datos['archivo']['tmp_name']) != 'application/pdf'){
				throw new toba_error("El archivo que intenta cargar no es un documento PDF válido");
			}
			$carpeta = sprintf("/becas/doc_por_convocatoria/%s/%s/%s/informes",$datos['id_convocatoria'],$datos['id_tipo_beca'],$datos['nro_documento']);
			
			if(toba::consulta_php('helper_archivos')->subir_archivo($datos['archivo'],$carpeta,$datos['nro_informe'].'.pdf')){
				unset($datos['archivo']);
				$this->get_datos('informe_beca')->set($datos);
				$this->get_datos()->sincronizar();
				toba::notificacion()->agregar('Informe cargado con éxito!','info');
			}else{
				toba::notificacion()->agregar('Ocurrió un error al intentar presentar el informe','error');
			}
		}

	}

	function evt__form_informe_beca__volver()
	{
		$this->set_pantalla('pant_seleccion_informe');
	}

}
?>