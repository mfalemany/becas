<?php
class co_convocatoria_beca
{

	function get_convocatorias($filtro=array())
	{
		$where = array();
		if (isset($filtro['id_categoria'])) {
			$where[] = "conv.id_categoria = ".quote($filtro['id_categoria']);
		}
		if (isset($filtro['convocatoria'])) {
			$where[] = "conv.convocatoria ILIKE ".quote('%'.$filtro['convocatoria'].'%');
		}
		if (isset($filtro['fecha_desde'])) {
			$where[] = "conv.fecha_desde = ".quote($filtro['fecha_desde']);
		}
		if (isset($filtro['fecha_hasta'])) {
			$where[] = "conv.fecha_hasta = ".quote($filtro['fecha_hasta']);
		}
		$sql = "SELECT
			cat.categoria as id_categoria_nombre,
			conv.id_convocatoria,
			conv.convocatoria,
			conv.fecha_desde,
			conv.fecha_hasta,
			conv_cat.cupo_maximo,
			conv_cat.id_color,
			col.color,
			conv.limite_movimientos
		FROM convocatoria_beca as conv
		LEFT JOIN convocatoria_categoria as conv_cat on conv_cat.id_convocatoria = conv.id_convocatoria
		LEFT JOIN categoria_beca as cat on cat.id_categoria = conv_cat.id_categoria
		LEFT JOIN color_carpeta as col on col.id_color = conv_cat.id_color
		WHERE 1=1
		ORDER BY color";
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


}
?>