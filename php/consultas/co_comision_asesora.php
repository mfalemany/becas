<?php
class co_comision_asesora
{

	function get_comisiones_asesoras()
	{
		$sql = "SELECT
			ca.id_area_conocimiento,
			ca.id_convocatoria,
			ac.area_conocimiento,
			cb.convocatoria
		FROM comision_asesora as ca
		LEFT JOIN convocatoria_beca as cb on ca.id_convocatoria = cb.id_convocatoria
		LEFT JOIN area_conocimiento as ac on ac.id_area_conocimiento = ca.id_area_conocimiento";
		return toba::db('becas')->consultar($sql);
	}

}
?>