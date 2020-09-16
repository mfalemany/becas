<?php
class ci_carga_masiva extends becas_ci
{
	protected $datos_form;
	private $errores;
	private $cabeceras;
	//-----------------------------------------------------------------------------------
	//---- form_carga_masiva ------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__form_carga_masiva(becas_ei_formulario $form)
	{
		if(isset($this->datos_form)){
			unset($this->datos_form['archivo']);
			$form->set_datos($this->datos_form);
		}
	}

	function evt__form_carga_masiva__modificacion($datos)
	{
		$this->datos_form = $datos;
		$becas = $this->procesar_archivo($datos['archivo']['tmp_name'],$datos);
		if($becas === FALSE){
			return; //Se muestran todas las notificaciones agregadas en el bucle
		}
		$exito = 0;
		$mensajes = array();

		foreach ($becas as $beca) {
			
			$this->get_datos()->resetear();
			
			$dni = $beca['inscripcion']['nro_documento'];
			$conv = $beca['inscripcion']['id_convocatoria'];
			$tipo_beca = $beca['inscripcion']['id_tipo_beca'];

			//Si no existe la inscripcion, se crea todo
			if( ! toba::consulta_php('co_inscripcion_conv_beca')->existe_inscripcion($dni,$conv,$tipo_beca)){
				
				//Genero la inscripción
				$this->get_datos('inscripcion_conv_beca')->cargar_con_datos(array($beca['inscripcion']));
				
				// y su correspondiente beca otorgada
				$this->get_datos('becas_otorgadas')->set($beca['beca_otorgada']);

				//Intento sincronizar, y lo registro como éxito y fallo, según corresponda
				$resultado = $this->intentar_sincronizar();
				if($resultado !== TRUE){
					$mensajes[] = array("texto" => "Error en el becario con DNI $dni: " . $resultado, "tipo"=>"error");
				}else{
					$exito++;
				}
			}else{
				if( ! toba::consulta_php('co_inscripcion_conv_beca')->existe_beca_otorgada($dni,$conv,$tipo_beca)){
					$this->get_datos('inscripcion_conv_beca')->cargar($beca['inscripcion']);
					$this->get_datos('becas_otorgadas')->nueva_fila($beca['beca_otorgada']);
					$resultado = $this->intentar_sincronizar();
					if($resultado !== TRUE){
						$mensajes[] = array("texto" => "Error en el becario con DNI $dni: " . $resultado,"tipo"=>"error");
					}else{
						$exito++;
					}
				}else{
					$mensajes[] = array("texto" => "El becario con DNI $dni ya tiene la beca otorgada. Se omite.","tipo"=>"warning");
					continue;
				}
			}

			
		}
		toba::notificacion()->agregar("Becas generadas: $exito",'info');
		foreach ($mensajes as $mensaje) {
			toba::notificacion()->agregar($mensaje['texto'],$mensaje['tipo']);
		}
		
	}

	private function intentar_sincronizar($tabla = NULL)
	{
		//Esta instrucción hace que todos los datos tabla marquen todas sus filas como "Nuevas", generando INSERTS para todas
		$this->get_datos()->forzar_insercion();
		try {
			$this->get_datos($tabla)->sincronizar();
			return TRUE;
		} catch (toba_error $e) {
			return $e->get_mensaje_motor();
		}
	}

	protected function procesar_archivo($archivo,$detalles_convocatoria){
		//Contendrá todos los datos que se retornarán, ya validados y listos para su inserción en la BD
		$becas = array();
		//Array que contendrá todos los errores (si ocurrieron)
		$this->errores = array();
		//Cabeceras que son requeridas para guardar una beca
		$cabeceras_obligatorias = array('nro_documento','nro_documento_dir');
		//Abro el archivo subido
		$archivo = fopen($archivo,'r');
		
		$actual = 0;
		//Leo cada linea del archivo
		while($linea = fgets($archivo)){
			$actual++;
			//Si es la primera iteración, se obtienen las cabeceras del CSV
			if( ! $this->cabeceras){
				$this->cabeceras = array_flip(explode(',',trim(strtolower($linea))));
				//Valido que el archivo contenga todas las cabeceras obligatorias
				foreach ($cabeceras_obligatorias as $obligatoria) {
					if( ! array_key_exists($obligatoria, $this->cabeceras )){
						toba::notificacion()->agregar("El archivo seleccionado no contiente la cabecera obligatoria $obligatoria",'error');
						return;
					}
				}
				//Una vez obtenidas las cabeceras, se continúa
				continue;
			}
			$campos = explode(',',$linea);

			//Verificar becario
			if( ! $this->verificar_persona('nro_documento','Becario',TRUE, $campos, $actual)){
				continue;
			}

			//Verificar director
			if( ! $this->verificar_persona('nro_documento_dir','Director',TRUE, $campos, $actual)){
				continue;
			}

			//Verificar co-director
			if( ! $this->verificar_persona('nro_documento_codir','Co-Director',FALSE, $campos, $actual)){
				continue;
			}

			//Si está establecida la cabecera 'Condicion' se establece, sino, se asume titular
			$es_titular = (isset($this->cabeceras['condicion']) && $campos[$this->cabeceras['condicion']]) 
				? (strtolower(trim($campos[$this->cabeceras['condicion']])) == 'titular') ? 'S' : 'N'
				: 'S';




			//Si se encontraron todas las personas, genero la postulación y la beca otorgada
			$inscripcion = array(
				'nro_documento'        => $this->limpiar($campos[$this->cabeceras['nro_documento']]),
				'id_convocatoria'      => $detalles_convocatoria['id_convocatoria'],
				'id_tipo_beca'         => $detalles_convocatoria['id_tipo_beca'],
				'admisible'            => 'S',
				'beca_otorgada'        => 'S',
				'estado'               => 'C',
				'es_titular'           => $es_titular,
				'nro_documento_dir'    => $this->limpiar($campos[$this->cabeceras['nro_documento_dir']]),
				'nro_documento_codir'  => $this->limpiar($campos[$this->cabeceras['nro_documento_codir']])
			);
			//Si no hay codirector, se elimina el indice (evita insertar NULL en la BD y el fallo por la FK con personas)
			if( ! $inscripcion['nro_documento_codir']) unset($inscripcion['nro_documento_codir'])
				;
			$beca_otorgada = array(
				'nro_documento'        => $this->limpiar($campos[$this->cabeceras['nro_documento']]),
				'id_convocatoria'      => $detalles_convocatoria['id_convocatoria'],
				'id_tipo_beca'         => $detalles_convocatoria['id_tipo_beca'],
				'fecha_desde'          => $detalles_convocatoria['fecha_desde'],
				'fecha_hasta'          => $detalles_convocatoria['fecha_hasta']
			);

			$becas[] = array('inscripcion' => $inscripcion, 'beca_otorgada' => $beca_otorgada);;
		}

		if(count($this->errores)){
			foreach($this->errores as $error){
				toba::notificacion()->agregar($error);
			}
			return FALSE;
		}else{
			return $becas;
		}
	}

	function verificar_persona($campo, $tipo, $es_obligatorio, $campos, $actual){
		$dni = $this->limpiar($campos[$this->cabeceras[$campo]]);
		if($dni){
			if( ! toba::consulta_php('co_personas')->existe_persona($dni,TRUE)){
				$this->errores[] = 'No se pudo encontrar la persona con DNI ' . $campos[$this->cabeceras[$campo]] . " ($tipo de la linea $actual)";
				return false;
			}
		}else{
			if($es_obligatorio){
				$this->errores[] = "La linea $actual contiene un DNI vacío y es un campo obligatorio";
				return false;
			}else{
				$campos[$this->cabeceras[$campo]] = null;	
			}
		}
		return true;
	}

	function limpiar($dni){
		return trim(str_replace(array('.',' ',',','-'),'',$dni));
	}


	function get_datos($tabla = NULL){
		return ($tabla) ? $this->dep('datos')->tabla($tabla) : $this->dep('datos');
	}
}
?>