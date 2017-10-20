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
		{$this->objeto_js}.ef('es_egresado').cuando_cambia_valor('\
			activo = {$this->objeto_js}.ef(\'es_egresado\').get_estado(); \
			{$this->objeto_js}.ef(\'anio_egreso\').set_estado(\'\');\
			{$this->objeto_js}.ef(\'anio_egreso\').set_solo_lectura(!activo);\
		');

		{$this->objeto_js}.ef('nro_documento_codir').cuando_cambia_valor('\
			if($(this).prop(\'value\').length){\
				{$this->objeto_js}.ef(\'id_tipo_doc_codir\').set_obligatorio(true);\
			}else{\
				{$this->objeto_js}.ef(\'id_tipo_doc_codir\').set_obligatorio(false);\
			}\
		');
		{$this->objeto_js}.ef('nro_documento_subdir').cuando_cambia_valor('\
			if($(this).prop(\'value\').length){\
				{$this->objeto_js}.ef(\'id_tipo_doc_subdir\').set_obligatorio(true);\
			}else{\
				{$this->objeto_js}.ef(\'id_tipo_doc_subdir\').set_obligatorio(false);\
			}\
		');

		{$this->objeto_js}.evt__nro_documento_codir__validar = function()
		{
			if( ! this.ef('nro_documento_codir').get_estado().length){
				this.controlador.desactivar_tab('pant_codirector');
			}else{
				this.controlador.activar_tab('pant_codirector');
			}
			return true;
		}
		
		{$this->objeto_js}.evt__nro_documento_subdir__validar = function()
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