<?php
class co_resoluciones{
	
	function obtener($filtro=array())
	{
		$where = array();
		if (isset($filtro['nro_resol'])) {
			$where[] = "t_br.nro_resol = ".quote($filtro['nro_resol']);
		}
		if (isset($filtro['anio'])) {
			$where[] = "t_br.anio = ".quote($filtro['anio']);
		}
		if (isset($filtro['fecha_desde'])) {
			$where[] = "t_br.fecha >= ".quote($filtro['fecha_desde']);
		}
		if (isset($filtro['fecha_hasta'])) {
			$where[] = "t_br.fecha <= ".quote($filtro['fecha_hasta']);
		}
		if (isset($filtro['id_tipo_resol'])) {
			$where[] = "t_br.id_tipo_resol = ".quote($filtro['id_tipo_resol']);
		}
		$sql = "SELECT
			t_br.nro_resol,
			t_br.anio,
			t_br.fecha,
			t_br.archivo_pdf,
			t_br.id_tipo_resol,
			t_btr.tipo_resol as id_tipo_resol_nombre,
			t_btr.tipo_resol_corto as id_tipo_resol_nombre_corto

		FROM
			be_resoluciones as t_br	LEFT OUTER JOIN be_tipos_resolucion as t_btr ON (t_br.id_tipo_resol = t_btr.id_tipo_resol)
		ORDER BY fecha DESC";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}

	function get_archivo_pdf($anio,$nro_resol,$id_tipo_resol)
	{
		$sql = "SELECT archivo_pdf 
				FROM be_resoluciones 
				WHERE anio = $anio 
				AND nro_resol = $nro_resol
				AND id_tipo_resol = $id_tipo_resol";
		$resultado = toba::db()->consultar_fila($sql);
		return $resultado['archivo_pdf'];
	}

}
?>