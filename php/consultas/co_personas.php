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
			per.nro_documento,
			per.apellido,
			per.nombres,
			per.cuil,
			per.fecha_nac,
			per.celular,
			per.mail,
			per.telefono,
			per.id_localidad,
			loc.localidad,
			prov.provincia,
			pai.pais,
			per.id_nivel_academico,
			niv.nivel_academico
		FROM
			sap_personas as per	
		LEFT JOIN be_niveles_academicos as niv ON per.id_nivel_academico = niv.id_nivel_academico
		LEFT JOIN be_localidades AS loc ON loc.id_localidad = per.id_localidad
		LEFT JOIN be_provincias as prov on prov.id_provincia = loc.id_provincia
		LEFT JOIN be_paises as pai on pai.id_pais = prov.id_pais
		ORDER BY apellido";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		//echo nl2br($sql);
		return toba::db()->consultar($sql);
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
		FROM sap_personas as per
		WHERE 1=1";
		if($nro_documento){
			$sql .= " AND per.nro_documento = ".quote($nro_documento);
		}
		if($id_tipo_doc){
			$sql .= " AND per.id_tipo_doc = ".quote($id_tipo_doc);
		}
		if($apellido){
			$sql .= " AND per.apellido ILIKE ".quote('%'.$apellido.'%');
		}
		if($nombres){
			$sql .= " AND per.nombres ILIKE ".quote('%'.$nombres.'%');
		}
		$sql .= " ORDER BY persona";
		//ei_arbol(toba::db()->consultar($sql));
		return toba::db()->consultar($sql);
	}

	/**
	 * Retorna el apellido y nombres de una persona espec�fica seg�n tipo y nro de documento
	 * @param  [string] $nro_documento [recibe un string con formato [id_tipo_doc]||[nro_documento]  ]
	 * @return [string]         [retorna un string simple con formato [Apellido],[nombres]  ]
	 */
	static function get_ayn($nro_documento)
	{
		$sql = "SELECT
			per.apellido||', '||per.nombres as persona
		FROM sap_personas as per
		WHERE per.nro_documento = ".quote($nro_documento);
		$resultado = toba::db()->consultar_fila($sql);
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
	function existe_persona($nro_documento,$tipo)
	{
		if(!$nro_documento){
			return false;
		}
		if($this->existe_en_local($nro_documento)){
			return true;
		}else{
			$persona = $this->buscar_en_ws($nro_documento); 
			if($persona){
				return $this->guardar_en_local($persona,$tipo);
			}else{
				return false;
			}
		}
	}

	protected function existe_en_local($nro_documento)
	{

		$sql = "SELECT * FROM sap_personas WHERE nro_documento = ".quote($nro_documento)." limit 1";	
		$resultado = toba::db()->consultar_fila($sql);
		return ( ! empty($resultado));
	}

	protected function buscar_en_ws($nro_documento)
	{
		$cliente = toba::servicio_web_rest('ws_unne')->guzzle();
		$response = $cliente->get('agentes/'.$nro_documento.'/datoscomedor');
		return rest_decode($response->json());
	}
	protected function guardar_en_local($persona, $tipo)
	{
		/* ******************** OBTENCI�N DE LOS DATOS **************************/
		$datos = array(	'nro_documento' => '',
						'apellido'      => '',
						'nombres'       => '',
						'fecha_nac'     => '1900-01-01', //fecha_nac por defecto
						'mail'         => '',
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
			$datos['apellido'] = utf8_decode(ucwords(strtolower($guarani['apellido'])));
			$datos['nombres'] = utf8_decode(ucwords(strtolower($guarani['nombres'])));
			$datos['fecha_nac'] = ($guarani['fecha_nac']) ? $guarani['fecha_nac'] : $datos['fecha_nac'];
			$datos['mail'] = ($guarani['email']) ? strtolower($guarani['email']) : '';
			$datos['sexo'] = ($guarani['sexo']) ? $guarani['sexo'] : '';

		}
		
		extract($datos);
		
		/* **********************************************************************/

		if(strtolower(trim($tipo)) === 'alumno'){
			
			$sql = "INSERT INTO sap_personas (id_tipo_doc,nro_documento,apellido,nombres,fecha_nac,mail,sexo,cuil) 
			        VALUES (1,'$nro_documento','".ucwords(strtolower($apellido))."','".ucwords(strtolower($nombres))."','$fecha_nac','$mail','$sexo','$cuil')";
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
				FROM sap_personas 
				WHERE nro_documento = ".quote($persona['nro_documento'])."
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