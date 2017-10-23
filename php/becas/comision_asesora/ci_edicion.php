<?php
class ci_edicion extends becas_ci
{
	//-----------------------------------------------------------------------------------
	//---- formulario  ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function conf__formulario(becas_ei_formulario $form)
	{
		if($this->get_datos('comision_asesora')->esta_cargada()){
			$form->set_datos($this->get_datos('comision_asesora')->get());
			$form->set_solo_lectura();
		}
	}

	function evt__formulario__modificacion($datos)
	{
		$this->get_datos('comision_asesora')->set($datos);
	}


	//-----------------------------------------------------------------------------------
	//---- ml_integrantes ---------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	//
	function conf__ml_integrantes(becas_ei_formulario_ml $form)
	{
		if($this->get_datos('integrante_comision_asesora')->esta_cargada()){
			$integrantes = $this->get_datos('integrante_comision_asesora')->get_filas();
			foreach($integrantes as $i => $registro){
				$integrantes[$i]['persona'] = $registro['id_tipo_doc']."||".$registro['nro_documento']; 
			}
			
			$form->set_datos($integrantes);
		}
	}

	function evt__ml_integrantes__modificacion($datos)
	{
		$integrantes = array();
		foreach($datos as $registro){
			$integrantes[] = array('id_tipo_doc'           => $registro['persona'][0], 
								  'nro_documento'         => $registro['persona'][1],
								  'x_dbr_clave'           => $registro['x_dbr_clave'],
								  'apex_ei_analisis_fila' => $registro['apex_ei_analisis_fila']);
		}
		$this->get_datos('integrante_comision_asesora')->procesar_filas($integrantes);
	}

	function &get_datos($tabla = NULL)
	{
		if( ! $tabla){
			return $this->controlador()->dep('datos');
		}else{
			return $this->controlador()->dep('datos')->tabla($tabla);
		}
	}
}
?>