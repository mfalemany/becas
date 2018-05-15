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
			
			return true;
		}

		// ---------- Cuando se elije el tipo de beca, se determina si será obligatorio o no la carga
		// de una inscripción/compromiso a carrera de posgrado
		{$this->objeto_js}.ef('id_tipo_beca').cuando_cambia_valor('requiere_inscripcion_posgrado({$this->objeto_js}.ef(\'id_tipo_beca\').get_estado())');

		function requiere_inscripcion_posgrado(id_tipo_beca){
			if(id_tipo_beca != 'nopar'){
				{$this->controlador()->objeto_js}.ajax('requiere_inscripcion_posgrado',id_tipo_beca,this,datos_posgrado);
			}else{
				this.datos_posgrado(true);
			}
			
		}
		function datos_posgrado(requerir){
			if(!requerir){
				{$this->objeto_js}.ef('archivo_insc_posgrado').desactivar();
				{$this->objeto_js}.ef('nombre_inst_posgrado').desactivar();
				{$this->objeto_js}.ef('carrera_posgrado').desactivar();
				{$this->objeto_js}.ef('fecha_insc_posgrado').desactivar();	
				{$this->objeto_js}.ef('titulo_carrera_posgrado').desactivar();	
			}else{
				{$this->objeto_js}.ef('archivo_insc_posgrado').activar();
				{$this->objeto_js}.ef('nombre_inst_posgrado').activar();
				{$this->objeto_js}.ef('carrera_posgrado').activar();
				{$this->objeto_js}.ef('fecha_insc_posgrado').activar();	
				{$this->objeto_js}.ef('titulo_carrera_posgrado').activar();	
			}
			
		}
		";
	}







}
?>