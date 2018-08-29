<?php
class ci_comision_evaluacion_seleccion extends becas_ci
{
	protected $s__filtro;
	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf()
	{
	}

	//-----------------------------------------------------------------------------------
	//---- cu_postulaciones -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cu_postulaciones(becas_ei_cuadro $cuadro)
	{
		$filtro = ($this->s__filtro) ? $this->s__filtro : array();
		
		//Solo inscripciones cerradas y admitidas
		$filtro['admisible'] =  'S';
		$filtro['estado'] = 'C';

		$cuadro->set_datos(toba::consulta_php('co_inscripcion_conv_beca')->get_inscripciones($filtro));
	}

	function evt__cu_postulaciones__seleccion($seleccion)
	{
		$this->get_datos()->cargar($seleccion);
		$this->set_pantalla('pant_edicion');

	}

	//-----------------------------------------------------------------------------------
	//---- form_filtro ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_filtro(becas_ei_formulario $form)
	{
		if(isset($this->s__filtro)){
			$form->set_datos($this->s__filtro);
		}
	}

	function evt__form_filtro__filtrar($datos)
	{
		$this->s__filtro = $datos;
	}

	function evt__form_filtro__cancelar()
	{
		unset($this->s__filtro);
	}


	function get_datos($tabla = NULL)
	{
		return ($tabla) ? $this->dep('datos')->tabla($tabla) : $this->dep('datos');
	}

	


	function conf__pant_edicion(toba_ei_pantalla $pantalla)
	{
		$seleccion = $this->get_datos('inscripcion_conv_beca')->get();
		$detalles = toba::consulta_php('co_inscripcion_conv_beca')->get_detalles_comprobante($seleccion);
		ei_arbol($detalles);
		
		//ruta al plan de trabajo
		$ruta = 'http://becas.cyt.unne.edu.ar/documentos';
		$plan = $ruta.'/becas/doc_por_convocatoria/'.$detalles['beca']['convocatoria']."/".$detalles['beca']['tipo_beca']."/".$detalles['postulante']['nro_documento']."/Plan de Trabajo.pdf";
		
		//la variable datos contendrá todos los valores que irán al template
		$datos = array(
			'titulo_plan_beca'  => $detalles['beca']['titulo_plan_beca'],
			'proyecto_nombre'   => $detalles['proyecto']['proyecto'],
			'nombre_postulante' => $detalles['postulante']['apellido'].", ".$detalles['postulante']['nombres'],
			'cuil'              => $detalles['postulante']['cuil'],
			'carrera'           => $detalles['postulante']['carrera'],
			'tipo_beca'         => $detalles['beca']['tipo_beca'],
			'nro_carpeta'       => $detalles['beca']['nro_carpeta'],
			'area_conocimiento' => $detalles['beca']['area_conocimiento'],
			'enlace_plan_trab'  => urldecode($plan)
		);


		//Armo el template de director
		$director = toba::consulta_php('co_inscripcion_conv_beca')->get_detalles_director($seleccion);
		$cargos = toba::consulta_php('co_cargos_persona')->get_cargos_persona($seleccion['nro_documento']);
		$cargos = 'FALTA ARMAR';
		$datos_template_director = array(
			'rol'           => 'Director',
			'ayn'           => $director['apellido'].", ".$director['nombres'],
			'dni'           => $director['nro_documento'],
			'categoria_inc' => $director['catinc'],
			'categoria_con' => $director['catconicet'],
			'enlace_cvar'   => $ruta."/docum_personal/".$director['nro_documento']."/cvar.pdf",
			'cargos'        => $cargos_director
		);
		$template_director = file_get_contents(__DIR__.'/template_director.php');
		foreach ($datos_template_director as $clave => $valor) {
			$template_director = str_replace("{{".$clave."}}",$valor,$template_director);
		}
		$datos['direccion'] = $template_director;

		$template_completo = file_get_contents(__DIR__.'/template_evaluacion.php');
		foreach ($datos as $clave => $valor) {
			$template_completo = str_replace("{{".$clave."}}",$valor,$template_completo);
		}
		$pantalla->set_template($template_completo);
	}

}
?>