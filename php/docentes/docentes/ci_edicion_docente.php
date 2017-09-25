<?php
class ci_edicion_docente extends becas_ci
{
	//-----------------------------------------------------------------------------------
	//---- form_docente -----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_docente(becas_ei_formulario $form)
	{
		//cuando el docente ya existe como tal en la base, no se puede editar el tipo y dni
		if($this->controlador()->datos()->tabla('docentes')->esta_cargada()){
			$form->ef('id_tipo_doc')->set_solo_lectura();
			$form->ef('nro_documento')->set_solo_lectura();
		}

		if($this->controlador()->datos()->tabla('docentes')->get()){
			$form->set_datos($this->controlador()->datos()->tabla('docentes')->get());
		}
	}

	
	function evt__form_docente__modificacion($datos)
	{
		$this->controlador()->datos()->resetear();
		//hago un cargar() por si la persona existe en la BD 	
		$this->controlador()->datos()->tabla('personas')->cargar(
			array('id_tipo_doc' => $datos['id_tipo_doc'], 'nro_documento' => $datos['nro_documento'])
		);
		//y luego un "set()" por si no existía, se asignan esos valores a los dos campos
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
		$this->controlador()->datos()->tabla('personas')->set($datos);
	}



}
?>