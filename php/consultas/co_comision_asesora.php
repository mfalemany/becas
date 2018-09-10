<?php
class co_comision_asesora
{

	function get_comisiones_asesoras($filtro = array())
	{
		$where = array();
		if (isset($filtro['id_convocatoria'])) {
			$where[] = "ca.id_convocatoria = ".quote($filtro['id_convocatoria']);
		}
		$sql = "SELECT
			ca.id_area_conocimiento,
			ca.id_convocatoria,
			ac.nombre AS area_conocimiento,
			cb.convocatoria
		FROM be_comision_asesora as ca
		LEFT JOIN be_convocatoria_beca as cb on ca.id_convocatoria = cb.id_convocatoria
		LEFT JOIN sap_area_conocimiento as ac on ac.id = ca.id_area_conocimiento
		ORDER BY ca.id_convocatoria";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}

	function get_criterios_evaluacion($inscripcion)
	{
		$where = array();
		if(isset($inscripcion['id_convocatoria'])){
			$where[] = 'cri.id_convocatoria = '.$inscripcion['id_convocatoria'];
		}
		if(isset($inscripcion['id_tipo_beca'])){
			$where[] = 'cri.id_tipo_beca = '.$inscripcion['id_tipo_beca'];
		}
		$sql = "SELECT * FROM be_tipo_beca_criterio_eval AS cri";
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

}
?>