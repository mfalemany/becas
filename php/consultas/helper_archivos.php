<?php

class helper_archivos
{
	function subir_archivo($detalles = array(),$carpeta,$nombre_archivo)
	{

		if(!count($detalles)){
			return;
		}
		$www = toba::proyecto()->get_www();
		//se utiliza el mismo directorio que SAP
		$www = str_replace('becas','sap',$www['path']);
		
		
		if( ! is_dir($www.$carpeta)){
			if( ! mkdir($www.$carpeta,0777,TRUE)){
				throw new toba_error('No se puede crear el directorio '.$carpeta.' en el directorio navegable del servidor. Por favor, pongase en contacto con el administrador del sistema');
				return false;
			}
		}
		$archivo = toba::proyecto()->get_www_temp($detalles['name']);
		return move_uploaded_file($detalles['tmp_name'], $www.$carpeta."/".$nombre_archivo);
	}

	function eliminar_archivo($archivo)
	{
		unlink($archivo);
	}

	function procesar_campos($efs_archivos,&$datos_form,$ruta)
	{
		foreach($efs_archivos as $archivo){

			if(array_key_exists($archivo['ef'], $datos_form)){
			
				if($datos_form[$archivo['ef']]){
					if( ! $this->subir_archivo($datos_form[$archivo['ef']],utf8_encode($ruta),$archivo['nombre'])){
						toba::notificacion()->agregar('No se pudo cargar el archivo '.$archivo['descripcion'].'. Por favor, intentelo nuevamente. Si el problema persiste, pongase en contacto con la Secretaría General de Ciencia y Ténica');
					}else{
						$datos_form[$archivo['ef']] = $archivo['nombre'];
					}
				}else{
					unset($datos_form[$archivo['ef']]);
				}	
			}
		}
	}

	/**
	 * Esta funcion procesa los archivos involucrados en un formulario ML. Por cada linea pasada al ML, esta funcion procesa si se trata de un Alta, Baja o Modificaci?, y en consecuencia, Sube, Modifica o Elimina archivos vinculados a cada linea. Recibe como par?etros el estado inicial del ML, el estado luego de la moficiacion, la ruta donde se almacenar? los archivos y los nombres de los campos del ML que se utilizar? para darle el nombre a cada archivo
	 * @param  array $estado_inicial_ml     Estado del ML al cargar el formulario
	 * @param  array $estado_actual_ml      Estado del ML luego de que el usuario realiza cambios
	 * @param  string $ruta                 Ruta donde se almacenar?/eliminaran los archivos involucrados
	 * @param  array $campos_nombre_archivo Campos del ML que se utilizan para formatear el nombre del archivo subido
	 * @param  string $nombre_input         Nombre del ef_upload que contiene el/los archivos subidos
	 * @return void                        
	 */
	function procesar_ml_con_archivos($estado_inicial_ml,&$estado_actual_ml,$ruta,$campos_nombre_archivo,$nombre_input)
	{
		//para cada linea de actividad docente
		foreach($estado_actual_ml as $fila => $item){
			
			//se genera el nombre del archivo
			$nombre = '';
			foreach($campos_nombre_archivo as $campo){
				//agrega un gui? medio entre cada palabra del nombre
				if(strlen($nombre)>0){
					$nombre .= "-";
				}
				$nombre .=  ($item[$campo['nombre']]) ? $item[$campo['nombre']] : $campo['defecto'];
			}
			$nombre .= '.pdf'; 

			// =========== ALTA Y MODIFICACI? ===============
			
			if($item['apex_ei_analisis_fila'] == 'A' || $item['apex_ei_analisis_fila'] == 'M'){
				if($item[$nombre_input]){
					//en el caso de una modificaci?, se elimina el archivo previo
					if(isset($estado_inicial_ml)){
						if($estado_inicial_ml[$nombre_input]){
							$this->eliminar_archivo($ruta,$estado_inicial_ml[$nombre_input]);	
						}
					}
					
					//se sube el nuevo archivo
					if( ! $this->subir_archivo($item[$nombre_input],$ruta,utf8_encode($nombre))){
						//se utiliza substr y strlen para quitar el ".pdf" al final del nombre de la actividad
						toba::notificacion()->agregar("No se pudo subir la documentaci? probatoria correspondiente a la actividad: ".substr($nombre,0,(strlen($nombre)-4) ) );
					}
					$estado_actual_ml[$fila][$nombre_input] = $nombre;
				}else{
					if(file_exists($ruta.utf8_encode($estado_inicial_ml[$fila][$nombre_input])) && is_file($ruta.utf8_encode($estado_inicial_ml[$fila][$nombre_input]) )){
						rename($ruta.utf8_encode($estado_inicial_ml[$fila][$nombre_input]),$ruta.utf8_encode($nombre) );
						$estado_actual_ml[$fila][$nombre_input] = $nombre;
					}else{
						//esta linea sirve para que el formulario (cuando no se define un nuevo archivo) no pise el estado anterior
						unset($estado_actual_ml[$fila][$nombre_input]);		
					}
					
				}
			}
				
			//si se est?dando de baja un registro, se busca su nombre de archivo y se lo elimina tambien
			if($item['apex_ei_analisis_fila'] == 'B'){
				foreach($estado_inicial_ml as $linea){
					if($linea['x_dbr_clave'] == $fila){
						$archivo = $ruta.utf8_encode($linea[$nombre_input]);
						$this->eliminar_archivo($archivo);
					}
				}
			}
		}
	}

}

?>