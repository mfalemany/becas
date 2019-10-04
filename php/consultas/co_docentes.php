<?php
class co_docentes
{

	function get_docentes($filtro=array())
	{
		$where = array();
		if (isset($filtro['id_tipo_doc'])) {
			$where[] = "per.id_tipo_doc = ".quote("{$filtro['id_tipo_doc']}");
		}
		if (isset($filtro['nro_documento'])) {
			$where[] = "doc.nro_documento ILIKE ".quote("%{$filtro['nro_documento']}%");
		}
		if (isset($filtro['legajo'])) {
			$where[] = "doc.legajo ILIKE ".quote("%{$filtro['legajo']}%");
		}
		if (isset($filtro['id_cat_incentivos'])) {
			$where[] = "cat_inc.id_cat_incentivos = ".quote($filtro['id_cat_incentivos']);
		}
		if (isset($filtro['apellido'])) {
			$where[] = "per.apellido ILIKE ".quote("%{$filtro['apellido']}%");
		}
		if (isset($filtro['nombres'])) {
			$where[] = "per.nombres ILIKE ".quote("%{$filtro['nombres']}%");
		}

		$sql = "SELECT
			doc.nro_documento,
			per.id_tipo_doc,
			per.apellido||', '||per.nombres as docente,
			doc.legajo,
			cat_inc.descripcion,
			cat_inc.cat_incentivos,
			niv.nivel_academico
		FROM be_docentes as doc
		LEFT JOIN sap_personas as per ON per.nro_documento = doc.nro_documento
		LEFT JOIN be_niveles_academicos as niv on niv.id_nivel_academico = per.id_nivel_academico
		ORDER BY nro_documento";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}

	function buscar_docente_combo_editable($patron)
	{
		$sql = "SELECT pe.nro_documento, pe.apellido||', '||pe.nombres as ayn
				FROM sap_cargos_persona AS cp
				LEFT JOIN sap_personas AS pe ON pe.nro_documento = cp.nro_documento
				WHERE quitar_acentos(pe.apellido) ILIKE quitar_acentos('%".$patron."%')
				OR quitar_acentos(pe.nombres) ILIKE quitar_acentos('%".$patron."%')";
		return toba::db()->consultar($sql);
	}

	static function get_ayn($params)
	{
		$sql = "SELECT
			per.apellido||', '||per.nombres as docente
		FROM docentes as doc 
		LEFT JOIN personas as per ON per.nro_documento = doc.nro_documento
		WHERE per.nro_documento = ".quote($params);
		$resultado = toba::db()->consultar_fila($sql);
		if(count($resultado)){
			return $resultado['docente'];
		}
	}

	function get_resumen_docente($nro_documento)
	{
			$sql = "SELECT per.id_tipo_doc,
						   td.tipo_doc,
						   doc.nro_documento,
						   per.apellido,
						   per.nombres,
						   per.cuil,
						   niv.nivel_academico,
						   per.id_nivel_academico,
						   cat_inc.cat_incentivos as cat_incentivos,
						   cat_con.categoria as cat_conicet
			FROM be_docentes AS doc
			LEFT JOIN be_categorias_conicet AS cat_con ON cat_con.id_cat_conicet = doc.id_cat_conicet
			LEFT JOIN sap_personas AS per ON per.nro_documento = doc.nro_documento
			LEFT JOIN sap_cat_incentivos AS cat_inc_per 
				ON cat_inc_per.nro_documento = per.nro_documento
				AND cat_inc_per.convocatoria = (select max(convocatoria) 
									  from cat_incentivos_personas 
									  where nro_documento = per.nro_documento)
			LEFT JOIN be_niveles_academicos AS niv ON niv.id_nivel_academico = per.id_nivel_academico
			LEFT JOIN be_tipo_documento AS td ON td.id_tipo_doc = per.id_tipo_doc
			WHERE per.nro_documento = ".quote($nro_documento);
			return toba::db()->consultar_fila($sql);

	}



}
?>