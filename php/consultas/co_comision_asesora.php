<?php
class co_comision_asesora
{

	function get_comisiones_asesoras($filtro = array())
	{
		$where = array();
		if (isset($filtro['id_convocatoria'])) {
			$where[] = "ca.id_convocatoria = ".quote($filtro['id_convocatoria']);
		}
		if (isset($filtro['id_categoria'])) {
			$where[] = "ca.id_categoria = ".quote($filtro['id_categoria']);
		}
		$sql = "SELECT
			ca.id_area_conocimiento,
			ca.id_convocatoria,
			ac.area_conocimiento,
			cb.convocatoria
		FROM comision_asesora as ca
		LEFT JOIN convocatoria_beca as cb on ca.id_convocatoria = cb.id_convocatoria
		LEFT JOIN area_conocimiento as ac on ac.id_area_conocimiento = ca.id_area_conocimiento";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

}
?>