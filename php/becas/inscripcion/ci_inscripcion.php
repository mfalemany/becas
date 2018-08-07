<?php
class ci_inscripcion extends becas_ci
{
	function conf()
	{
		//si no existen convocatorias con inscripcion abierta, elimino el evento 'agregar (Nueva Inscripcion'
		if( ! toba::consulta_php('co_convocatoria_beca')->existen_convocatorias_vigentes()){
			$this->pantalla()->eliminar_evento('agregar');
			$this->dep('cuadro')->agregar_notificacion('No existen convocatorias con periodo de inscripción abierto');
		}
	}
	//---- Cuadro Inscripciones ------------------------------------------------------------

	function conf__cuadro(toba_ei_cuadro $cuadro)
	{
		$filtro = array();
		
		//si el usuario es becario, solo puede ver sus propias inscripciones
		if(!in_array('admin',toba::usuario()->get_perfiles_funcionales())){
			$filtro['nro_documento'] = toba::usuario()->get_id();	
		}
		$cuadro->set_datos(toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones($filtro));
		
	}

	function evt__cuadro__seleccion($datos)
	{
		//se carga la relaci? de "Alumno"
		$alumno = array('nro_documento'=>$datos['nro_documento']);
		$this->get_datos('alumno')->cargar($alumno);

		//se cargan los detalles de la inscripci?
		$this->get_datos('inscripcion')->cargar($datos);

		$this->set_pantalla('pant_edicion');
	}

	function servicio__generar_comprobante()
	{
		$params = toba::memoria()->get_parametros();
		$clave = toba_ei_cuadro::recuperar_clave_fila('2948',$params['fila']);
		$detalles = toba::consulta_php('co_inscripcion_conv_beca')->get_detalles_comprobante($clave);
		//ei_arbol($detalles);
		$reporte = new becas_inscripcion_comprobante($detalles);
		$reporte->mostrar();
		//validar si existe el archivo, sino, hay que generarlo.
	}

	function conf_evt__cuadro__generar_comprobante(toba_evento_usuario $evento, $fila)
	{
		$clave = toba_ei_cuadro::recuperar_clave_fila('2948',$fila);
		if(count($clave) == 0){
			$evento->ocultar();
			return;
		}
		$estado = toba::consulta_php('co_inscripcion_conv_beca')->get_campo(array('estado'),$clave);
		if($estado[0]['estado'] == 'A'){
			$evento->ocultar();
		}else{
			$evento->mostrar();
		}
		//si el estado es cerrado, hay que mostrar el boton
	}

	function resetear()
	{
		$this->get_datos('alumno')->resetear();
		$this->get_datos('inscripcion')->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	//---- EVENTOS CI -------------------------------------------------------------------

	function evt__agregar()
	{
		$this->set_pantalla('pant_edicion');
	}

	function evt__volver()
	{
		$this->resetear();
		$this->set_pantalla('pant_seleccion');
	}
	
	function evt__eliminar()
	{
		$this->get_datos('inscripcion','requisitos_insc')->eliminar();
		$this->get_datos('inscripcion','plan_trabajo')->eliminar();
		$this->get_datos('inscripcion','inscripcion_conv_beca')->eliminar();
		$this->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	function evt__guardar()
	{
		try{
			$this->dep('ci_edicion')->generar_registros_relacionados();
			$this->dep('ci_edicion')->generar_nro_carpeta();
			
			//verifico campos obligatorios (por si no se recorrieron todas las solapas)
			$alumno = $this->get_datos('alumno','persona')->get();
			if(!$alumno['archivo_cuil']){
				$this->dep('ci_edicion')->set_pantalla('pant_alumno');
				throw new toba_error("No se ha cargado la constancia de CUIL del solicitante");
			}

			$this->get_datos('alumno')->sincronizar();
			$this->get_datos('inscripcion')->sincronizar();
			$this->resetear();	
		}catch(toba_error_db $e){
			switch ($e->get_sqlstate()) {

				case 'db_23505':
					toba::notificacion()->agregar('Se ha producido un error al intentar guardar. Posiblemente, el alumno ingresado ya tenga una solicitud de beca para esta convocatoria y tipo de beca.');	
					break;
				
				default:
					toba::notificacion()->agregar('Ocurrió un error inesperado al intentar guardar la inscripción. por favor, comuniquese con la Secretaría General de Ciencia y Técica para solucionarlo (cyt.unne@gmail.com). Código de error: '.$e->get_mensaje_motor());	
					break;
			}
		}catch(toba_error $e){
			toba::notificacion()->agregar($e->get_mensaje());
		}
		
	}

	function evt__cerrar_inscripcion()
	{
		$this->get_datos('inscripcion','inscripcion_conv_beca')->set(array('estado'=>'C'));
		$this->evt__guardar();
	}

	function &get_datos($relacion, $tabla = NULL)
	{
		$datos = FALSE;
		if($tabla){
			if($relacion){
				$datos = $this->dep($relacion)->tabla($tabla);
			}else{
				$datos = $this->dep($tabla);
			}
		}else{
			if($relacion){
				$datos = $this->dep($relacion);
			}
		}
		return $datos;

	}


}
?>