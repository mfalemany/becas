<?php
class co_convocatoria_categoria
{

	function get_convocatorias_categoria($filtro=array())
	{
		$where = array();
		if (isset($filtro['id_convocatoria'])) {
			$where[] = "id_convocatoria = ".quote($filtro['id_convocatoria']);
		}
		if (isset($filtro['id_categoria'])) {
			$where[] = "id_categoria = ".quote($filtro['id_categoria']);
		}
		$sql = "SELECT
			t_cc.id_convocatoria,
			t_cc.id_categoria,
			t_cc.fecha_desde,
			t_cc.fecha_hasta,
			t_cc.cupo_maximo,
			t_cc.color_carpeta,
			t_cc.limite_movimientos
		FROM
			convocatoria_categoria as t_cc
		ORDER BY color_carpeta";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

}
?>