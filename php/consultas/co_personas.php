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
		if (isset($filtro['id_provincia'])) {
			$where[] = "per.id_provincia = ".quote($filtro['id_provincia']);
		}
		if (isset($filtro['id_pais'])) {
			$where[] = "per.id_pais = ".quote($filtro['id_pais']);
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
			per.id_pais,
			per.id_provincia,
			per.id_localidad,
			loc.localidad,
			pro.provincia,
			pai.pais,
			per.id_nivel_academico,
			niv.nivel_academico
		FROM
			personas as per	
		LEFT JOIN niveles_academicos as niv ON per.id_nivel_academico = niv.id_nivel_academico
		LEFT JOIN tipo_documento AS tip ON tip.id_tipo_doc = per.id_tipo_doc
		LEFT JOIN paises AS pai ON pai.id_pais = per.id_pais
		LEFT JOIN provincias AS pro ON (pro.id_pais = per.id_pais AND pro.id_provincia = per.id_provincia)
		LEFT JOIN localidades AS loc ON (loc.id_localidad = per.id_localidad AND pro.id_pais = per.id_pais AND pro.id_provincia = per.id_provincia)
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
	 * Retorna el apellido y nombres de una persona específica según tipo y nro de documento
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

}
?>