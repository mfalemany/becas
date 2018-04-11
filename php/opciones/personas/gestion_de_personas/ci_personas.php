<?php
class ci_personas extends becas_ci
{
	protected $s__datos_filtro;


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
		$cuadro->agregar_notificacion('Debe filtrar para visualizar los datos','info');
		if (isset($this->s__datos_filtro)) {
			$cuadro->set_datos(toba::consulta_php('co_personas')->get_personas($this->s__datos_filtro));
		}
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
			$form->set_datos($this->dep('datos')->tabla('sap_personas')->get());
		} else {
			$this->pantalla()->eliminar_evento('eliminar');
		}
	}

	function evt__formulario__modificacion($datos)
	{

		$efs_archivos = array(array('ef'          => 'archivo_titulo_grado',
							 	    'descripcion' => 'Titulo de Grado',
							 	    'nombre'      => 'Titulo Grado.pdf') ,
							  array('ef'          => 'archivo_cuil',
							  	    'descripcion' => 'Constancia de CUIL',
							  	    'nombre'      => 'CUIL.pdf')
							);
							 
		$ruta = 'doc_probatoria/'.$datos['nro_documento'].'/';
		toba::consulta_php('helper_archivos')->procesar_campos($efs_archivos,$datos,$ruta);
		$this->dep('datos')->tabla('sap_personas')->set($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- ml_cargos --------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_cargos(becas_ei_formulario_ml $form_ml)
	{
		if($this->dep('datos')->tabla('sap_cargos_persona')->get_filas()){
			$form_ml->set_datos($this->dep('datos')->tabla('sap_cargos_persona')->get_filas());	
		}
	}

	function evt__ml_cargos__modificacion($datos)
	{
		foreach($datos as $indice => $valor){
			switch (substr($datos[$indice]['cargo'],3,1)) {
				case 'E':
					$datos[$indice]['dedicacion'] = 'EXCL';
					break;
				case 'S':
					$datos[$indice]['dedicacion'] = 'SEMI';
					break;
				case '1':
					$datos[$indice]['dedicacion'] = 'SIMP';
					break;
			}
		}
		$this->dep('datos')->tabla('sap_cargos_persona')->procesar_filas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- ml_cargos --------------------------------------------------------------------
	//-----------------------------------------------------------------------------------	

	function resetear()
	{
		$this->dep('datos')->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	function conf__ml_cat_incentivos(becas_ei_formulario_ml $form_ml)
	{
		if ($this->dep('datos')->esta_cargada()) {
			$form_ml->set_datos($this->dep('datos')->tabla('sap_cat_incentivos')->get_filas());
		} 
	}

	function evt__ml_cat_incentivos__modificacion($datos)
	{
		$this->dep('datos')->tabla('sap_cat_incentivos')->procesar_filas($datos);
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