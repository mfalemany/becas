<?php
class ci_recuperar_clave_invitado extends toba_ci
{
	protected $s__datos;

	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__recuperar()
	{
		$persona = toba::usuario()->existe_usuario($this->s__datos['nro_documento']);
		if( ! $persona){
			toba::notificacion()->agregar('No existe ninguna persona registrada con el n�mero de documento indicado.');
			return;
		}
		
		//datos del servidor y del proyecto (para la redirecci�n)
		//$url_proyecto = toba::proyecto()->get_www()['url'];
		//$servidor = "http://" . $_SERVER['SERVER_NAME'];

		// Clave aleatoria
		$clave = toba::usuario()->generar_clave_aleatoria(8);
		
		//obtengo los detalles del usuario (ayn, mail, etc)
		$datos_usuario = toba::instancia()->get_info_usuario($this->s__datos['nro_documento']);
		
		if( empty($datos_usuario['email']) ){
			toba::notificacion()->agregar('El usuario indicado no posee una direcci�n de correo asociada. Por favor, comuniquese con la Secretar�a General de Ciencia y T�cnica');
			return;
		}
		$cuerpo = "<h2 style='background-color: #3a42a7; color:#FFEEEE; padding:3px 0px 3px 10px;'>Solicitud de Cambio de Contrase�a - Becas</h2>
		Se ha solicitado la recuperaci�n de contrase�a para el usuario <b>".$datos_usuario['id']."</b> (".$datos_usuario['nombre']."). <br> Puede inciar sesi�n con la siguiente clave: <span style='color:#FF3333; font-weight: bold;'>".$clave."</span>  (<a href='".toba::vinculador()->crear_vinculo('becas','3581', array(), array('validar'=>false))."'>Iniciar sesi�n ahora</a>)";
		

		


		$mail = new toba_mail($datos_usuario['email'],'Recuperaci�n de Contrase�a',$cuerpo,'rhcyt');
		$mail->set_configuracion_smtp('instalacion2');
		$mail->set_remitente('RR.HH. SGCyT');	
		$mail->set_reply('rhcyt@unne.edu.ar');
		$mail->set_html();
		
		// Mando el e-mail
		try {
			$mail->ejecutar();
			
			//guardo el mensaje para mostrarlo al usuario despues de la redireccion
			toba::memoria()->set_dato("mensaje", "Su clave ha sido enviada a la siguiente direcci�n: ".$datos_usuario['email'].". Si no lo encuentra, por favor revise el buz�n de spam.");

			//le cambio la clave al usuario
			toba::usuario()->set_clave_usuario($clave,$datos_usuario['id']);
			//navego al inicio
			toba::vinculador()->navegar_a('becas','3581');
		} catch (toba_error $e) {
			toba::memoria()->set_dato('mensaje', 'Error al intentar enviar la clave por mail. Consulte con el administrador del sistema.' . $e->get_mensaje());
			//navego al inicio
			toba::vinculador()->navegar_a('becas','3581');
		}
			
	
	}

	function evt__cancelar(){
		toba::vinculador()->navegar_a('becas','3581');
	}


	//-----------------------------------------------------------------------------------
	//---- frm_documento ----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__frm_documento__modificacion($datos)
	{
		$this->s__datos = $datos;
	}

	function conf__frm_documento(becas_ei_formulario $form)
	{
		if(isset($this->s__datos)){
			$form->set_datos($this->s__datos);
		}
	}

}
?>