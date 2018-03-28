<?php
class co_carreras
{

	function get_carreras($filtro=array())
	{
		$where = array();
		if (isset($filtro['carrera'])) {
			$where[] = "car.carrera ILIKE ".quote("%{$filtro['carrera']}%");
		}
		if (isset($filtro['id_dependencia'])) {
			$where[] = "dep.id_dependencia = ".$filtro['id_dependencia'];
		}

		$sql = "SELECT DISTINCT
			car.id_carrera,
			car.carrera,
			car.cod_araucano
		FROM be_carreras as car
		ORDER BY car.carrera";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}

	function get_carreras_por_dependencia($id_dep = NULL) 
	{
		if( ! $id_dep){
			return; 
		}
		
		$sql = "SELECT
			car.id_carrera,
			car.carrera,
			car.cod_araucano
		FROM be_carrera_dependencia as cd 
		LEFT JOIN be_carreras as car on cd.id_carrera = car.id_carrera
		LEFT JOIN sap_dependencia as dep on dep.id = cd.id_dependencia
		WHERE dep.id = $id_dep
		ORDER BY dep.nombre, car.carrera";
		return toba::db()->consultar($sql);
	}
	

}
?>