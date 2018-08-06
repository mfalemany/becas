<?php 
class ci_crear_usuario extends toba_ci
{

	protected $s__persona;
	
	//---- Eventos CI -------------------------------------------------------

	function evt__procesar($datos) 
	{
		
	}

	function evt__cancelar() 
	{   
		toba::vinculador()->navegar_a('becas','3581');
	}

	//---- frm_datos_personales -------------------------------------------------------
	
	function conf__frm_datos_personales($form)
	{
		if(isset($this->s__persona)){
			$form->set_datos($this->s__persona);
		}
	}

	function evt__frm_datos_personales__modificacion($datos)
	{
		$this->s__persona = $datos;
		//var_dump(toba::proyecto()->get_parametro('usuario_subclase')); return false;
		//verifico la disponibilidad del nombre de usuario
		if( toba::usuario()->existe_usuario($datos['nro_documento']) ){
			toba::notificacion()->agregar('Ya existe el usuario que intenta crear. Elija la opción: "Olvide mi contrase&ntilde;a"');
			return false;
		}else{
			if( $datos['clave'] <> $datos['repetir_clave']) {
				toba::notificacion()->agregar('Las claves ingresadas no coinciden');
				return false;
			}
			if( strlen($datos['clave']) <= 5 ){
				toba::notificacion()->agregar('Debe ingresar una clave de al menos seis caracteres','error');
				return;
			}
		}

		//unifico los campos apellido y nombre
		$datos['ayn'] = $datos['apellido'].", ".$datos['nombre'];
		
		//guardo en local
		toba::db()->ejecutar('INSERT INTO sap_personas (nro_documento,apellido,nombres,mail) 
							  VALUES ('.quote($datos['nro_documento']).','.quote($datos['apellido']).','.quote($datos['nombre']).','.quote($datos['mail']).')');

		//elimino indices innecesarios            
		unset($datos['apellido']);
		unset($datos['nombre']);
		unset($datos['repetir_clave']);


		toba::db()->abrir_transaccion();
		try {
			
			toba::instancia()->agregar_usuario($datos['nro_documento'], $datos['ayn'], $datos['clave'],array('email'=>$datos['mail']));
			toba::instancia()->vincular_usuario('becas', $datos['nro_documento'], array('becario'));

			toba::db()->cerrar_transaccion();

			//guardo el mensaje para mostrarlo al usuario despues de la redireccion
			toba::memoria()->set_dato("mensaje", "Usuario generado con éxito!");
			toba::vinculador()->navegar_a('becas','3581');

		} catch (Exception $e) {
			toba::db()->abortar_transaccion(); 
			toba::notificacion()->agregar('Ocurrio un error al intentar generar el usuario'.$e->getMessage());
		}
	}
}

