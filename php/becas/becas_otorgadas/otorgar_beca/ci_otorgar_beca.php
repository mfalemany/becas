<?php
class ci_otorgar_beca extends becas_ci
{
	protected $s__filtro;
		
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__guardar()
	{
		try {
			$this->get_datos()->sincronizar();
			$this->set_pantalla('pant_seleccion');
		} catch (toba_error_db $e) {
			toba::notificacion()->agregar("Ocurrió un error: ".$e->get_mensaje());
		}
	}

	function evt__cancelar()
	{
		$this->get_datos()->resetear();
		$this->set_pantalla('pant_seleccion');
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

	//-----------------------------------------------------------------------------------
	//---- postulaciones ----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__postulaciones(becas_ei_cuadro $cuadro)
	{
		$filtro = (isset($this->s__filtro)) ? $this->s__filtro : array();
		$cuadro->set_datos(toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones($filtro));
	}

	function evt__postulaciones__seleccion($seleccion)
	{
		$this->get_datos()->cargar($seleccion);
		$this->set_pantalla('pant_edicion');
	}

	//-----------------------------------------------------------------------------------
	//---- form_otorgar -----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_otorgar(becas_ei_formulario $form)
	{
		$postulante = $this->get_datos('inscripcion_conv_beca')->get();
		
		//Para obtener las descripciones
		$filtro = array('id_convocatoria'=> $postulante['id_convocatoria'],
						'nro_documento'  => $postulante['nro_documento'],
						'id_tipo_beca'   => $postulante['id_tipo_beca']);
		
		//Obtengo las descripciones
		$detalles = toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones($filtro);
		$detalles = array_shift($detalles);

		$datos = $this->get_datos('becas_otorgadas')->get();
		if($datos){
			$detalles = array_merge($detalles,$datos);
		}
		$form->set_datos($detalles);
	}

	function evt__form_otorgar__modificacion($datos)
	{
		$this->get_datos('inscripcion_conv_beca')->set(
			array(
				'nro_documento_dir'    => $datos['nro_documento_dir'],
				'nro_documento_codir'  => $datos['nro_documento_codir'],
				'nro_documento_subdir' => $datos['nro_documento_subdir']
			)
		);
		//Se agrega esta linea porque sino da error de concurrencia
		//Cuando trata de actualizar becas_otorgadas, su fila padre ya cambió 
		$this->get_datos('inscripcion_conv_beca')->sincronizar();
		$this->get_datos('becas_otorgadas')->set($datos);

	}

	//-----------------------------------------------------------------------------------
	//---- ml_licencias -----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_licencias(becas_ei_formulario_ml $form_ml)
	{
		$datos = $this->get_datos('licencias')->get_filas();
		if($datos){
			$form_ml->set_datos($datos);
		}
	}

	function evt__ml_licencias__modificacion($datos)
	{
		$this->get_datos('licencias')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- auxiliares -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function get_datos($tabla = NULL)
	{
		return ($tabla) ? $this->dep('datos')->tabla($tabla) : $this->dep('datos');
	}

}
?>