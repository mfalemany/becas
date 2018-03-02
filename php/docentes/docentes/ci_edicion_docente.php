<?php
class ci_edicion_docente extends becas_ci
{
	//-----------------------------------------------------------------------------------
	//---- form_docente -----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_docente(becas_ei_formulario $form)
	{
		
		//var_dump($this->controlador()->datos()->tabla('docentes')->get_filas());
		if($this->controlador()->datos()->tabla('docentes')->get()){
			$form->set_datos($this->controlador()->datos()->tabla('docentes')->get());
		}
		//cuando el docente ya existe como tal en la base, no se puede editar el tipo y dni
		if($this->controlador()->datos()->tabla('docentes')->esta_cargada()){
			$form->ef('id_tipo_doc')->set_solo_lectura();
			$form->ef('nro_documento')->set_solo_lectura();
		}
	}

	
	function evt__form_docente__modificacion($datos)
	{
		$this->controlador()->datos()->tabla('personas')->cargar(
			array('id_tipo_doc' => $datos['id_tipo_doc'], 'nro_documento' => $datos['nro_documento'])
		);
		$this->controlador()->datos()->tabla('personas')->set(
				array('id_tipo_doc' => $datos['id_tipo_doc'], 'nro_documento' => $datos['nro_documento'])
		);
		$this->controlador()->datos()->tabla('docentes')->set($datos);
	}
	//-----------------------------------------------------------------------------------
	//---- form_persona -----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_persona(becas_ei_formulario $form)
	{
		$form->set_datos($this->controlador()->datos()->tabla('personas')->get());
		//se hacen de solo lectura porque estos datos se modifican en la pestaña de datos del docente
		$this->dep('form_persona')->ef('id_tipo_doc')->set_solo_lectura();
		$this->dep('form_persona')->ef('nro_documento')->set_solo_lectura();
	}

	function evt__form_persona__modificacion($datos)
	{	
		$efs_archivos = array(array('ef'          => 'archivo_titulo_grado',
							 	    'descripcion' => 'Titulo de Grado',
							 	    'nombre'      => 'Titulo Grado.pdf') ,
							  array('ef'          => 'archivo_cuil',
							  	    'descripcion' => 'Constancia de CUIL',
							  	    'nombre'      => 'CUIL.pdf')
							);
		$ruta = 'doc_probatoria/'.$datos['id_tipo_doc'].'-'.$datos['nro_documento'].'/';
		toba::consulta_php('helper_archivos')->procesar_campos($efs_archivos,$datos,$ruta);
		$this->controlador()->datos()->tabla('personas')->set($datos);
	}



	//-----------------------------------------------------------------------------------
	//---- ml_cargos --------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_cargos(becas_ei_formulario_ml $form_ml)
	{
		if($this->controlador()->datos()->tabla('cargos_docente')->get_filas()){
			$form_ml->set_datos($this->controlador()->datos()->tabla('cargos_docente')->get_filas());
		}


	}

	function evt__ml_cargos__modificacion($datos)
	{
		$this->controlador()->datos()->tabla('cargos_docente')->procesar_filas($datos);
	}


}
?>