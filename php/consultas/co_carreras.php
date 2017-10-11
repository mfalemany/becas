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

		$sql = "SELECT
			car.id_carrera,
			dep.id_dependencia,
			dep.nombre,
			car.carrera,
			car.cod_araucano
		FROM carrera_dependencia as cd 
		LEFT JOIN carreras as car on cd.id_carrera = car.id_carrera
		LEFT JOIN dependencias as dep on dep.id_dependencia = cd.id_dependencia

		ORDER BY car.carrera";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

	function get_carrera_cascadas($id_dep = NULL) 
	{
		if( ! $id_dep){
			return; 
		}
		
		$sql = "SELECT
			car.id_carrera,
			dep.id_dependencia,
			dep.nombre,
			car.carrera,
			car.cod_araucano
		FROM carrera_dependencia as cd 
		LEFT JOIN carreras as car on cd.id_carrera = car.id_carrera
		LEFT JOIN dependencias as dep on dep.id_dependencia = cd.id_dependencia
		WHERE dep.id_dependencia = $id_dep
		ORDER BY dep.nombre, car.carrera";
		return toba::db('becas')->consultar($sql);
	}
	

}
?>