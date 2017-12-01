<?php
class co_personas
{

	function get_personas($filtro=array())
	{
		$where = array();
		if (isset($filtro['nro_documento'])) {
			$where[] = "per.nro_documento ILIKE ".quote("%{$filtro['nro_documento']}%");
		}
		if (isset($filtro['apellido'])) {
			$where[] = "per.apellido ILIKE ".quote("%{$filtro['apellido']}%");
		}
		if (isset($filtro['nombres'])) {
			$where[] = "per.nombres ILIKE ".quote("%{$filtro['nombres']}%");
		}
		if (isset($filtro['fecha_nac'])) {
			$where[] = "per.fecha_nac = ".quote($filtro['fecha_nac']);
		}
		if (isset($filtro['id_localidad'])) {
			$where[] = "per.id_localidad = ".quote($filtro['id_localidad']);
		}
		if (isset($filtro['id_nivel_academico'])) {
			$where[] = "per.id_nivel_academico = ".quote($filtro['id_nivel_academico']);
		}
		$sql = "SELECT
			per.id_tipo_doc,
			tip.tipo_doc,
			per.nro_documento,
			per.id_tipo_doc,
			per.apellido,
			per.nombres,
			per.cuil,
			per.fecha_nac,
			per.celular,
			per.email,
			per.telefono,
			per.id_localidad,
			loc.localidad,
			prov.provincia,
			pai.pais,
			per.id_nivel_academico,
			niv.nivel_academico
		FROM
			personas as per	
		LEFT JOIN niveles_academicos as niv ON per.id_nivel_academico = niv.id_nivel_academico
		LEFT JOIN tipo_documento AS tip ON tip.id_tipo_doc = per.id_tipo_doc
		LEFT JOIN localidades AS loc ON loc.id_localidad = per.id_localidad
		LEFT JOIN provincias as prov on prov.id_provincia = loc.id_provincia
		LEFT JOIN paises as pai on pai.id_pais = prov.id_pais
		ORDER BY apellido";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

	function get_personas_busqueda($filtro = NULL)
	{
		if( ! $filtro){
			return;
		}
		extract($filtro);
		$sql = "SELECT
			per.id_tipo_doc,
			per.nro_documento,
			per.apellido||', '||per.nombres as persona
		FROM personas as per
		WHERE 1=1";
		if($id_tipo_doc){
			$sql .= " AND per.id_tipo_doc = ".quote($id_tipo_doc);
		}
		if($nro_documento){
			$sql .= " AND per.nro_documento = ".quote($nro_documento);
		}
		$sql .= "ORDER BY persona";
		return toba::db('becas')->consultar($sql);
	}

	/**
	 * Retorna el apellido y nombres de una persona espec�fica seg�n tipo y nro de documento
	 * @param  [string] $params [recibe un string con formato [id_tipo_doc]||[nro_documento]  ]
	 * @return [string]         [retorna un string simple con formato [Apellido],[nombres]  ]
	 */
	static function get_ayn($params)
	{
		//toba::logger()->var_dump($params);



		$filtro = explode('||',$params);
		$sql = "SELECT
			per.apellido||', '||per.nombres as persona
		FROM personas as per
		WHERE per.id_tipo_doc = $filtro[0]
		AND per.nro_documento = ".quote($filtro[1]);
		$resultado = toba::db('becas')->consultar_fila($sql);
		if(count($resultado)){
			return $resultado['persona'];
		}
	}

	/**
	 * Este m�todo consulta en  la BD local para verificar la existencia de la persona. En caso de no
	 * encontrarla, se conecta al servicio web para obtener los datos y guardarlos en la BD local.
	 * 
	 * @param  varchar $id_tipo_doc   Tipo de documento de la persona que se est� buscando
	 * @param  varchar $nro_documento N�mero de documento de la persona que se est� buscando
	 * @param  varchar $tipo          El par�metro tipo indica que tipo de persona se busca. En caso de ser alumno, si no se lo encuentra en la BD local, se lo importa desde el WS (a la base de personas y alumnos). En cambio, si se est� buscando un docente, y no se lo encuentra en local, se realiza el mismo proceso de busqueda en el WS pero luego se lo guarda en la tabla de personas y en la de docentes
	 * @return boolean                Retorna true en caso de encontrar la persona (en local o en el ws). Falso en caso contrario
	 */
	function existe_persona($id_tipo_doc,$nro_documento,$tipo)
	{
		
		if($this->existe_en_local($id_tipo_doc,$nro_documento)){
			return true;
		}else{
			$persona = $this->buscar_en_ws($nro_documento); 
			if($persona){
				return $this->guardar_en_local($id_tipo_doc,$persona,$tipo);
			}else{
				return false;
			}
		}
	}

	protected function existe_en_local($id_tipo_doc,$nro_documento)
	{
		$sql = "SELECT id_tipo_doc, nro_documento FROM personas WHERE nro_documento = ".quote($nro_documento)." AND id_tipo_doc = ".quote($id_tipo_doc);	
		
		$resultado = toba::db()->consultar_fila($sql);
		return ( ! empty($resultado));
	}

	protected function buscar_en_ws($nro_documento)
	{
		$cliente = toba::servicio_web_rest('ws_unne')->guzzle();
		$response = $cliente->get('agentes/'.$nro_documento.'/datoscomedor');
		return rest_decode($response->json());
	}
	protected function guardar_en_local($id_tipo_doc, $persona, $tipo)
	{
		/* ******************** OBTENCI�N DE LOS DATOS **************************/
		$datos = array(	'id_tipo_doc'   => 1,
						'nro_documento' => '',
						'apellido'      => '',
						'nombres'       => '',
						'fecha_nac'     => '1900-01-01', //fecha_nac por defecto
						'email'         => '',
						'sexo'          => '',
						'cuil'          => '');
		
		if(array_key_exists('MAPUCHE', $persona)){
			$datos['nro_documento']	= $persona['MAPUCHE'][0]['nro_documento'];
			$datos['apellido']      = array_shift(explode(',',$persona['MAPUCHE'][0]['ayn']));
			$datos['nombres']       = array_pop(explode(',',$persona['MAPUCHE'][0]['ayn']));
			$datos['cuil']          = $persona['MAPUCHE'][0]['cuit'];
		}
		
		
		$guarani = $this->array_a_minusculas($persona['GUARANI'][0]);
		
		if(array_key_exists('GUARANI', $persona)){
			$datos['nro_documento'] = $guarani['nro_doc'];
			$datos['apellido'] = ucwords(strtolower($guarani['apellido']));
			$datos['nombres'] = ucwords(strtolower($guarani['nombres']));
			$datos['fecha_nac'] = ($guarani['fecha_nac']) ? $guarani['fecha_nac'] : $datos['fecha_nac'];
			$datos['email'] = ($guarani['email']) ? strtolower($guarani['email']) : '';
			$datos['sexo'] = ($guarani['sexo']) ? $guarani['sexo'] : '';

		}
		
		extract($datos);
		
		/* **********************************************************************/

		if(strtolower(trim($tipo)) === 'alumno'){
			
			$sql = "INSERT INTO personas (id_tipo_doc,nro_documento,apellido,nombres,fecha_nac,email,sexo,cuil) 
			        VALUES ($id_tipo_doc,'$nro_documento','".ucwords(strtolower($apellido))."','".ucwords(strtolower($nombres))."','$fecha_nac','$email','$sexo','$cuil')";
			$afectados = toba::db()->ejecutar($sql);
			return ($afectados >= 1);
		}
		if(strtolower(trim($tipo)) === 'docente'){
			//ac� hay que hacer la inserci�n del registro del docente y de los cargos	
		}	
		
		

	}
	private function array_a_minusculas($array)
	{
		$resultado = array();
		foreach($array as $indice => $valor){
			if(is_array($valor)){
				$resultado[strtolower($indice)] = $this->array_a_minusculas($valor);
			}else{
				$resultado[strtolower($indice)] = $valor;
			}
		}
		return $resultado;
	}

	/**
	 * Retorna la edad de una persona. Si se pasa una fecha (como segundo argumento), este m�todo retorna la edad de la persona'a esa fecha 
	 * @param  array $persona array que contien el id_tipo_doc y el nro_documento de la persona
	 * @param  date $fecha   Fecha a la que se quiere saber la edad de la persona. Si no se establece, se asume la fecha actual
	 * @return integer       Edad de la persona a la fecha establecida
	 */
	function get_edad($persona,$fecha)
	{
		$fecha = ($fecha) ? $fecha : date("Y-m-d");
		$sql = "SELECT fecha_nac
				FROM personas 
				WHERE id_tipo_doc = ".quote($persona['id_tipo_doc'])."
				AND nro_documento = ".quote($persona['nro_documento'])."
				LIMIT 1";
		$resultado = toba::db()->consultar_fila($sql);
		if(count($resultado)){
			$nac = new Datetime($resultado['fecha_nac']);
			$fec = new Datetime($fecha);
			return $nac->diff($fec)->y;	
		}else{
			return FALSE;
		}
		
	}

}
?>