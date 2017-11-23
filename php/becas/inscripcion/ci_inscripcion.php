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
	//---- Cuadro -----------------------------------------------------------------------

	function conf__cuadro(toba_ei_cuadro $cuadro)
	{
		$filtro = array();
		
		if(in_array('becario',toba::usuario()->get_perfiles_funcionales())){
			$filtro = array('nro_documento' => toba::usuario()->get_id());
			$cuadro->eliminar_evento('admitir');
		}

		$cuadro->set_datos(toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones($filtro));
		
	}
	

	function evt__cuadro__seleccion($datos)
	{
		//se carga la relación de "Alumno"
		$alumno = array('id_tipo_doc'=>$datos['id_tipo_doc'],'nro_documento'=>$datos['nro_documento']);
		$this->get_datos('alumno')->cargar($alumno);

		//se cargan los detalles de la inscripción
		$this->get_datos('inscripcion')->cargar($datos);

		$insc = $this->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$this->get_datos(NULL,'director')->cargar(array('id_tipo_doc'   => $insc['id_tipo_doc_dir'],
											 'nro_documento' => $insc['nro_documento_dir']));

		if($insc['id_tipo_doc_codir']){
			$this->get_datos(NULL,'codirector')->cargar(array('id_tipo_doc'   => $insc['id_tipo_doc_codir'],
											       'nro_documento' => $insc['nro_documento_codir']));
		}

		if($insc['id_tipo_doc_subdir']){
			$this->get_datos(NULL,'subdirector')->cargar(array('id_tipo_doc'   => $insc['id_tipo_doc_subdir'],
											        'nro_documento' => $insc['nro_documento_subdir']));
		}

		$this->set_pantalla('pant_edicion');
	}

	function evt__cuadro__admitir($datos)
	{
		$this->get_datos('inscripcion','inscripcion_conv_beca')->cargar($datos);
		$this->set_pantalla('pant_admisibilidad');
	}
	

	function resetear()
	{
		$this->get_datos('alumno')->resetear();
		$this->get_datos('inscripcion')->resetear();
		$this->get_datos('director')->resetear();
		$this->get_datos('codirector')->resetear();
		$this->get_datos('subdirector')->resetear();


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
	}

	function evt__eliminar()
	{
		$this->get_datos('inscripcion','requisitos_insc')->eliminar();
		$this->get_datos('inscripcion','inscripcion_conv_beca')->eliminar();
		$this->resetear();
	}

	function evt__guardar()
	{
		$this->dep('ci_edicion')->generar_registros_relacionados();
		$this->get_datos('alumno')->sincronizar();
		$this->get_datos('inscripcion')->sincronizar();
		$this->resetear();
	}

	function get_datos($relacion = NULL, $tabla = NULL)
	{
		if($tabla){
			if($relacion){
				return $this->dep($relacion)->tabla($tabla);	
			}else{
				return $this->dep($tabla);
			}
		}else{
			if($relacion){
				return $this->dep($relacion);
			}else{
				return false;
			}
		}
	}

}
?>