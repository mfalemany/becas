	<?php
class ci_resoluciones extends becas_ci
{
	protected $s__datos_filtro;
	protected $s__datos_resol;

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
		$cuadro->desactivar_modo_clave_segura();
		if (isset($this->s__datos_filtro)) {
			$cuadro->set_datos(toba::consulta_php('co_resoluciones')->obtener($this->s__datos_filtro));
		} else {
			$cuadro->set_datos(toba::consulta_php('co_resoluciones')->obtener());
		}
	}

	function evt__cuadro__eliminar($datos)
	{
		$this->dep('datos')->resetear();
		$this->dep('datos')->cargar($datos);
		$this->dep('datos')->eliminar_todo();
		$this->dep('datos')->resetear();
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
			$this->s__datos_resol = $this->dep('datos')->tabla('be_resoluciones')->get();
			$form->set_datos($this->dep('datos')->tabla('be_resoluciones')->get());
		} else {
			$this->pantalla()->eliminar_evento('eliminar');
		}
	}

	function evt__formulario__modificacion($datos)
	{
		//asigno el nombre que le corresponde al PDF ("aÃ±o"-"mes"-"dia"-"id_tipo_resol"-"nro_resol".pdf)
		$pdf = $datos['anio'].'-'.$datos['nro_resol'].'-'.$this->get_tipo_resol_corto($datos['id_tipo_resol']).'.pdf';

		//si la persona selecciona un PDF, directamente hay que asignarlo y guardarlo
		if ($datos['archivo_pdf']) {
			$efs_archivos = array(array('ef' => 'archivo_pdf',
										'descripcion' => 'Resolucion',
										'nombre'      => $pdf
										)
								);
			toba::consulta_php('helper_archivos')->procesar_campos($efs_archivos,$datos,'resoluciones/');
		}	
		$this->dep('datos')->tabla('be_resoluciones')->set($datos);
	}

	function resetear()
	{
		$this->dep('datos')->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	function servicio__ver_pdf()
	{

		$params = toba::memoria()->get_parametros();
		$pdf = $params['anio']."-".$params['nro_resol']."-".$this->get_tipo_resol_corto($params['id_tipo_resol']).".pdf";
		//echo "Existe ".toba::proyecto()->get_www()['path']."resoluciones/".$pdf."? <br>";
		//var_dump(file_exists(toba::proyecto()->get_www()['path']."/resoluciones/".$pdf)); return;
		if(file_exists(toba::proyecto()->get_www()['path']."/resoluciones/".$pdf)){
			//muestro el PDF
			header("Location: ".toba::proyecto()->get_www()['url']."/resoluciones/".$pdf);	
		}else{
			toba::notificacion()->agregar('La resolución no tiene documento digital','error');
			header("Location: ".toba::proyecto()->get_www()['url']);
		}
		
	}

	/* Se configura el evento para que muestre u oculte el 
	   boton "Ver PDF" dependiendo si existe o no el archivo en PDF 
	   El nombre de archivo es: anio-nro_resol-tipo_resol_corto (Ej: 2012-169-CD.pdf)*/
	function conf_evt__cuadro__ver_pdf(toba_evento_usuario $evento, $fila) 
	{
		//obtengo un array con los parametros del evento
		$params = explode('||',$evento->get_parametros());

		//obtengo el nombre corto del tipo de resolucion
		$tipo_resol_corto = $this->get_tipo_resol_corto($params[2]);
		//obtengo (si tiene) el nombre del archivo PDF correspondiente
		$pdf = $params[0].'-'.$params[1].'-'.$tipo_resol_corto.".pdf";
		//var_dump($pdf); return;
		//si el archivo no existe, o no tiene asignado un nombre de archivo, se oculta el evento
		if( ! (file_exists(toba::proyecto()->get_www()['path']."resoluciones/".$pdf)) || ( ! $pdf)){
			$evento->ocultar();	
		}else{
			$evento->mostrar();
		}
		
		
	}

	function get_tipo_resol_corto($id_tipo_resol)
	{
		return strtolower(str_replace(array(' ','.'),'',toba::consulta_php('co_tipos_resolucion')->get_nombre_corto($id_tipo_resol)));
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

}

?>