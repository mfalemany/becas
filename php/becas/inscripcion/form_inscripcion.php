<?php
class form_inscripcion extends becas_ei_formulario
{
	
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		$id_js = toba::escaper()->escapeJs($this->objeto_js);
		echo "
		
		//---- Validacion de EFs -----------------------------------
		
		// ------- Se activa o desactiva el campo fecha_egreso en funcion de si es egresado o no --------
		{$id_js}.ef('es_egresado').cuando_cambia_valor('\
			activo = {$id_js}.ef(\'es_egresado\').get_estado(); \
			{$id_js}.ef(\'anio_egreso\').set_estado(\'\');\
			{$id_js}.ef(\'anio_egreso\').set_solo_lectura(!activo);\
		');
		
		//--------Si se carga un DNI, se hace tambien obligatorio el campo id_tipo_doc_codir ------------
		{$id_js}.ef('nro_documento_codir').cuando_cambia_valor('\
			if($(this).prop(\'value\').length){\
				{$id_js}.ef(\'id_tipo_doc_codir\').set_obligatorio(true);\
			}else{\
				{$id_js}.ef(\'id_tipo_doc_codir\').set_obligatorio(false);\
			}\
		');
		
		
		//--------Si se carga un DNI, se carga mediante ajax el nombre y apellido del director----------
		{$id_js}.ef('nro_documento_dir').cuando_cambia_valor('buscar_director()');
		
		


		// ---------CUANDO SE CAMBIA EL VALOR DEL CAMPO 'TIPO DE DOCUMENTO' DEL DIRECTOR -------
		{$id_js}.ef('id_tipo_doc_dir').cuando_cambia_valor('\
			if({$id_js}.ef(\'id_tipo_doc_dir\').get_estado() == \'nopar\'){ \
				{$id_js}.ef(\'director\').set_estado(\'No se ha seleccionado un Tipo de Documento\');\
				{$id_js}.ef(\'nro_documento_dir\').set_estado(\'\');\
				{$this->objeto_js}.controlador.desactivar_tab(\'pant_director\');\
				return false;\
			}else{\
				{$id_js}.ef(\'director\').set_estado(\'\');\
			}\
		');



		//---------- Busco el director usando ajax -----------------------------------------------------
		function buscar_director(tipo,nro)
		{
			datos = {'tipo':{$id_js}.ef('id_tipo_doc_dir').get_estado(),'nro':{$id_js}.ef('nro_documento_dir').get_estado()};
			{$this->controlador()->objeto_js}.ajax('get_docente',datos,this,mostrar_director);
		}
		
		// ------------ Asigno el valor obtenido por ajax al label Director ----------------------------
		function mostrar_director(params)
		{    
			{$id_js}.ef('director').set_estado(params.director);
			if( ! params.error){
				{$this->objeto_js}.controlador.activar_tab('pant_director');
			}else{
				{$this->objeto_js}.controlador.desactivar_tab('pant_director');
			}
		}

		
		
		//------- Si se carga un DNI, se hace tambien obligatorio el campo id_tipo_doc_subdir ----------
		{$id_js}.ef('nro_documento_subdir').cuando_cambia_valor('\
			if($(this).prop(\'value\').length){\
				{$id_js}.ef(\'id_tipo_doc_subdir\').set_obligatorio(true);\
			}else{\
				{$id_js}.ef(\'id_tipo_doc_subdir\').set_obligatorio(false);\
			}\
		');
		
		// --------------- si no se carga un codirector, se desactiva ese tab -------------------------
		{$id_js}.evt__nro_documento_codir__validar = function()
		{
			if( ! this.ef('nro_documento_codir').get_estado().length){
				this.controlador.desactivar_tab('pant_codirector');
			}else{
				this.controlador.activar_tab('pant_codirector');
			}
			return true;
		}
		
		// ------------ si no se carga un subdirector, se desactiva ese tab ---------------------------
		{$id_js}.evt__nro_documento_subdir__validar = function()
		{
			if( ! this.ef('nro_documento_subdir').get_estado().length){
				this.controlador.desactivar_tab('pant_subdirector');
			}else{
				this.controlador.activar_tab('pant_subdirector');
			}
			return true;
		}
		";
	}


}
?>