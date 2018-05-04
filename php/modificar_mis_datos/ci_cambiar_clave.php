<?php
class ci_cambiar_clave extends becas_ci
{
	private $s__datos;
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__procesar($datos)
	{

	}

	function evt__cancelar()
	{
		toba::vinculador()->navegar_a('becas','2');
	}

	//-----------------------------------------------------------------------------------
	//---- form_cambio_clave ------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_cambio_clave(becas_ei_formulario $form)
	{
		$datos = toba::instancia()->get_info_usuario(toba::usuario()->get_id());
		$mail = $datos['email'];
		if($mail){
			$this->s__datos['mail'] = $mail;	
			$form->set_datos($this->s__datos);
		}
	}

	function evt__form_cambio_clave__guardar($datos)
	{
		
		//le asigno la clave y el permiso al proyecto
		if( ! empty($datos['clave_nueva'])){
			if( ! ($datos['clave_nueva'] == $datos['clave_nueva_repetir'])){
				toba::notificacion()->agregar('Las claves ingresadas no coinciden','error');
				return;
			}
			if( strlen($datos['clave_nueva']) <= 5 ){
				toba::notificacion()->agregar('Debe ingresar una clave de al menos seis caracteres','error');
				return;
			}
			toba::usuario()->set_clave_usuario($datos['clave_nueva'], toba::usuario()->get_id());
		}

		//guardo el mensaje para mostrarlo al usuario despues de la redireccion
		toba::memoria()->set_dato("mensaje", "Cambios guardados con &eacute;xito!");

		if(empty($datos['mail'])){
			toba::notificacion()->agregar('Debe ingresar una dirección de correo','error');
			return;
		}
		$this->actualizar_mail(toba::usuario()->get_id(),$datos['mail']);
		
    	toba::vinculador()->navegar_a('becas','2');
    	
	}

	function actualizar_mail($usuario,$mail)
	{

		if(empty($usuario) || empty($mail)){
			return false;
		}
		$sql = "UPDATE apex_usuario SET email = ".quote($mail)." WHERE usuario = ".quote($usuario);
		
		//falta validar la respuesta de ejecucion de esta consulta!!!
		toba::instancia()->get_db()->ejecutar($sql);
	}

}

?>