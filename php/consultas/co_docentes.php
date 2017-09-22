<?php
class co_docentes
{

	function get_docentes($filtro=array())
	{
		$where = array();
		if (isset($filtro['nro_documento'])) {
			$where[] = "doc.nro_documento ILIKE ".quote("%{$filtro['nro_documento']}%");
		}
		if (isset($filtro['legajo'])) {
			$where[] = "doc.legajo ILIKE ".quote("%{$filtro['legajo']}%");
		}
		if (isset($filtro['id_cat_incentivos'])) {
			$where[] = "doc.id_cat_incentivos = ".quote($filtro['id_cat_incentivos']);
		}
		$sql = "SELECT
			doc.nro_documento,
			doc.id_tipo_doc,
			doc.legajo,
			cat.categoria as id_cat_incentivos_nombre
		FROM
			docentes as doc	LEFT JOIN categorias_incentivos as cat ON (doc.id_cat_incentivos = cat.id_cat_incentivos)
		ORDER BY nro_documento";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

}
?>