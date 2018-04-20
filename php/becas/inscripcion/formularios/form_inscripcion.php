<?php
class form_inscripcion extends becas_ei_formulario
{
	
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		
		//---- Validacion de EFs -----------------------------------
		
		// ------- Se activa o desactiva el campo fecha_egreso en funcion de si es egresado o no --------
		{$this->objeto_js}.evt__es_egresado__procesar = function(es_inicial){
			activo = {$this->objeto_js}.ef('es_egresado').get_estado(); 

			if(activo){
				{$this->objeto_js}.ef('materias_aprobadas').set_estado({$this->objeto_js}.ef('materias_plan').get_estado());
			}else{
				{$this->objeto_js}.ef('anio_egreso').set_estado('');
			}
			{$this->objeto_js}.ef('anio_egreso').set_solo_lectura(!(activo == 1));
			
		};
		
		
		/* ========================================================================================== */
		// Si se carga un DNI, se carga mediante ajax el nombre y apellido del director
		{$this->objeto_js}.ef('nro_documento_dir').cuando_cambia_valor('buscar_director({$this->objeto_js}.ef(\'nro_documento_dir\').get_estado(),\'director\')');

		// lo mismo para el co-director
		{$this->objeto_js}.ef('nro_documento_codir').cuando_cambia_valor('buscar_director({$this->objeto_js}.ef(\'nro_documento_codir\').get_estado(),\'codirector\')');

		//y para el subdirector
		{$this->objeto_js}.ef('nro_documento_subdir').cuando_cambia_valor('buscar_director({$this->objeto_js}.ef(\'nro_documento_subdir\').get_estado(),\'subdirector\')');

		
		// Busco el director usando ajax
		function buscar_director(nro_documento,campo)
		{
			datos = {'nro_documento':nro_documento,'campo':campo};
			{$this->controlador()->objeto_js}.ajax('get_persona',datos,this,mostrar_director);
		}
		
		// Asigno el valor obtenido por ajax al label Director
		function mostrar_director(params)
		{    
			if( ! params.error){
				{$this->objeto_js}.controlador.activar_tab('pant_'+params.campo);
				{$this->objeto_js}.ef(params.campo).set_estado(params.persona);
			}else{
				{$this->objeto_js}.ef(params.campo).set_estado('Persona no encontrada');
				{$this->objeto_js}.controlador.desactivar_tab('pant_'+params.campo);
			}
		}
		/* ========================================================================================= */
		
		
		
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__id_area_conocimiento__procesar = function(es_inicial)
		{
			area = this.ef('id_area_conocimiento').get_estado();
			if(area != 'nopar'){
				{$this->controlador()->objeto_js}.ajax('get_disciplinas_incluidas',area,this,listar_disciplinas);	
			}
			
		}
		
		function listar_disciplinas(respuesta)
		{
			$('#disciplinas_incluidas').html('Disciplinas incluídas: '+respuesta);	
		}
		
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__nro_documento__procesar = function(es_inicial)
		{
			if( ! es_inicial){
				if(this.ef('nro_documento').get_estado().length){
					var params = {nro_documento : this.ef('nro_documento').get_estado(),
								  id_tipo_beca  : this.ef('id_tipo_beca').get_estado()};
					{$this->controlador()->objeto_js}.ajax('validar_edad',params,this,alertar_edad);
				}
			}
		}
		
		function alertar_edad(edad_valida){
			if(edad_valida === false){
				notificacion.agregar('La persona indicada como postulante supera la edad límite para el tipo de beca al que intenta inscribirse. Esto hará que la inscripción resulte inadmisible.','error');
				notificacion.ventana_modal();
				notificacion.limpiar();
			}
		}	
		
		// ================== VALIDACIONES AL MOMENTO DE SUBMIT =======================================
		
		
		// --------------- si no se carga un codirector, se desactiva ese tab -------------------------
		{$this->objeto_js}.evt__nro_documento_codir__validar = function()
		{
			if( ! this.ef('nro_documento_codir').get_estado().length){
				this.controlador.desactivar_tab('pant_codirector');
			}else{
				this.controlador.activar_tab('pant_codirector');
			}
			return true;
		}
		
		// ------------ si no se carga un subdirector, se desactiva ese tab ---------------------------
		{$this->objeto_js}.evt__nro_documento_subdir__validar = function()
		{
			if( ! this.ef('nro_documento_subdir').get_estado().length){
				this.controlador.desactivar_tab('pant_subdirector');
			}else{
				this.controlador.activar_tab('pant_subdirector');
			}
			return true;
		}
		//---- Validacion general ----------------------------------
		
		{$this->objeto_js}.evt__validar_datos = function()
		{
			
			
			if(this.ef('anio_ingreso').get_estado() > new Date().getFullYear()){
				notificacion.agregar('El año de ingreso no puede ser posterior al año actual');
				false;
			}
			if(this.ef('es_egresado').get_estado()){
				if(this.ef('materias_aprobadas').get_estado() != this.ef('materias_plan').get_estado()){
					notificacion.agregar('Si el postulante es egresado, la cantidad de materias aprobadas debe ser igual a la cantidad de materias del plan de estudios.');
					return false;
				}
				if(this.ef('anio_egreso').get_estado() <= this.ef('anio_ingreso').get_estado()){
					notificacion.agregar('El año de egreso debe ser posterior al año de ingreso');
					return false;
				}
				if(this.ef('anio_egreso').get_estado() > new Date().getFullYear()){
					notificacion.agregar('El año de egreso no puede ser posterior al año actual');
					return false;
				}
			}
			return true;
		}
		";
	}







}
?>