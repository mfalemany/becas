<?php
class co_convocatoria_beca
{

	function get_convocatorias($filtro=array())
	{
		$where = array();
		if (isset($filtro['id_tipo_convocatoria'])) {
			$where[] = "conv.id_tipo_convocatoria = ".quote($filtro['id_tipo_convocatoria']);
		}
		if (isset($filtro['convocatoria'])) {
			$where[] = "conv.convocatoria ILIKE ".quote('%'.$filtro['convocatoria'].'%');
		}
		if (isset($filtro['anio'])) {
			$where[] = quote($filtro['anio'])." between extract(year from conv.fecha_desde) and extract(year from conv.fecha_hasta)";
		}
		
		$sql = "SELECT
			conv.id_convocatoria,
			tip.id_tipo_convocatoria,
			tip.tipo_convocatoria,
			conv.convocatoria,
			conv.fecha_desde,
			conv.fecha_hasta,
			conv.limite_movimientos
		FROM convocatoria_beca as conv
		LEFT JOIN tipos_convocatoria as tip on tip.id_tipo_convocatoria = conv.id_tipo_convocatoria
		WHERE 1=1";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

	function get_anios_convocatorias()
	{
		$sql = "select distinct extract(year from fecha_desde) as anio 
				FROM convocatoria_beca
				ORDER BY anio DESC";
		
		return toba::db('becas')->consultar($sql);
	}

	function existen_inscripciones($id_convocatoria,$id_tipo_beca)
	{
		$sql = "SELECT count(*) AS cantidad 
		FROM inscripcion_conv_beca 
		WHERE id_convocatoria = ".quote($id_convocatoria);
		$resultado = toba::db()->consultar_fila($sql);
		return ($resultado['cantidad'] > 0);
	}


}
?>