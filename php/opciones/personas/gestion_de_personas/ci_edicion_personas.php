<?php
class ci_edicion_personas extends becas_ci
{
	//---- Formulario -------------------------------------------------------------------

	function conf__formulario(toba_ei_formulario $form)
	{
		if ($this->get_datos(NULL)->esta_cargada()) {
			$form->set_datos($this->get_datos(NULL,'sap_personas')->get());
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
		$this->get_datos(NULL,'sap_personas')->set($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- ml_cargos --------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_cargos(becas_ei_formulario_ml $form_ml)
	{
		if($this->get_datos(NULL,'sap_cargos_persona')->get_filas()){
			$form_ml->set_datos($this->get_datos(NULL,'sap_cargos_persona')->get_filas());	
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
		$this->get_datos(NULL,'sap_cargos_persona')->procesar_filas($datos);
	}

	function conf__ml_cat_incentivos(becas_ei_formulario_ml $form_ml)
	{
		if ($this->get_datos(NULL)->esta_cargada()) {
			$form_ml->set_datos($this->get_datos(NULL,'sap_cat_incentivos')->get_filas());
		} 
	}

	function evt__ml_cat_incentivos__modificacion($datos)
	{
		$this->get_datos(NULL,'sap_cat_incentivos')->procesar_filas($datos);
	}


	function conf__form_cat_conicet(becas_ei_formulario $form)
	{
		if ($this->get_datos(NULL)->esta_cargada()) {
			$form->set_datos($this->get_datos(NULL,'cat_conicet_persona')->get());
		} 
	}

	function evt__form_cat_conicet__modificacion($datos)
	{
		$this->get_datos(NULL,'cat_conicet_persona')->set($datos);
	}


	function get_datos($relacion,$tabla=NULL)
	{
		$relacion = ( ! $relacion ) ? 'datos' : $relacion;
		return $this->controlador()->get_datos($relacion,$tabla);
	}

}

?>