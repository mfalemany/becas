<?php
class co_cumplim_obligaciones
{
/*	public $meses = array('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre');

	function get_cumplimientos($filtro=array())
	{
		$where = array();
		if (isset($filtro['nro_documento'])) {
			$where[] = "cum.nro_documento = ".quote($filtro['nro_documento']);
		}
		if (isset($filtro['mes'])) {
			$where[] = "cum.mes = ".quote($filtro['mes']);
		}
		if (isset($filtro['anio'])) {
			$where[] = "cum.anio = ".quote($filtro['anio']);
		}
		if (isset($filtro['id_tipo_cumpl_oblig'])) {
			$where[] = "cum.id_tipo_cumpl_oblig = ".quote($filtro['id_tipo_cumpl_oblig']);
		}
		$sql = "SELECT
			cum.id_tipo_doc,
			per.apellido||', '||per.nombres as becario,
			cum.nro_documento,
			cum.mes,
			CASE mes 
				WHEN 1 THEN 'Enero'
				WHEN 2 THEN 'Febrero'
				WHEN 3 THEN 'Marzo'
				WHEN 4 THEN 'Abril'
				WHEN 5 THEN 'Mayo'
				WHEN 6 THEN 'Junio'
				WHEN 7 THEN 'Julio'
				WHEN 8 THEN 'Agosto'
				WHEN 9 THEN 'Septiembre'
				WHEN 10 THEN 'Octubre'
				WHEN 11 THEN 'Noviembre'
				WHEN 12 THEN 'Diciembre'
				END as mes_desc,
			cum.anio,
			tip.tipo_cumpl_oblig as id_tipo_cumpl_oblig_nombre,
			cum.fecha_cumplimiento
		FROM
			be_cumplimiento_obligacion as cum	
			LEFT JOIN be_tipo_cumpl_obligacion as tip ON (cum.id_tipo_cumpl_oblig = tip.id_tipo_cumpl_oblig)
			LEFT JOIN sap_personas as per on per.nro_documento = cum.nro_documento";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}

	function get_meses()
	{
		$meses = array();
		for($i=1 ; $i<=12 ; $i++){
			$meses[] = array('mes'=>$i,'descripcion'=>$this->meses[$i-1]);
		}
		return $meses;
	}*/


	function get_becarios_vigentes($dir = NULL)
	{
		$sql = "SELECT per.nro_documento, 
					per.apellido||', '||per.nombres AS becario, 
					ins.id_dependencia, 
					ins.id_convocatoria,
					dep.nombre AS dependencia,
					ins.id_tipo_beca,
					tb.tipo_beca,
					ot.fecha_desde,
					ot.fecha_hasta
				FROM be_becas_otorgadas AS ot
				LEFT JOIN be_inscripcion_conv_beca AS ins 
					ON ins.nro_documento = ot.nro_documento
					AND ins.id_convocatoria = ot.id_convocatoria
					AND ins.id_tipo_beca = ot.id_tipo_beca
				LEFT JOIN sap_personas AS per ON per.nro_documento = ins.nro_documento
				LEFT JOIN sap_dependencia AS dep ON dep.id = ins.id_dependencia
				LEFT JOIN be_tipos_beca AS tb ON tb.id_tipo_beca = ins.id_tipo_beca ";
				if($dir){
					$sql .= "WHERE (ins.nro_documento_dir = ".quote($dir)." OR ins.nro_documento_codir = ".quote($dir)." OR ins.nro_documento_subdir = ".quote($dir).")";
				}
		return toba::db()->consultar($sql);
	}

	function get_cumplimientos($nro_documento,$id_convocatoria,$id_tipo_beca){
		$sql = "SELECT * 
				FROM be_cumplimiento_obligacion
				WHERE nro_documento = ".quote($nro_documento)."
				AND id_convocatoria = ".quote($id_convocatoria)."
				AND id_tipo_beca = ".quote($id_tipo_beca)."
				ORDER BY anio DESC, mes DESC";
		return toba::db()->consultar($sql);
	}

	function get_duracion_meses_beca($inscripcion)
	{
		$sql = "SELECT 
					--Extraigo la cantidad de años de la beca, y lo multiplico por 12 (para pasarlo a meses)
					(EXTRACT(YEAR FROM AGE(fecha_hasta,fecha_desde))*12) +
					--y le sumo los meses restantes
					(EXTRACT(MONTH FROM AGE(fecha_hasta,fecha_desde))) AS duracion
				FROM be_becas_otorgadas AS bo
				WHERE bo.id_convocatoria = ".quote($inscripcion['id_convocatoria'])."
				AND bo.id_tipo_beca = ".quote($inscripcion['id_tipo_beca'])."
				AND bo.nro_documento = ".quote($inscripcion['nro_documento']);
		$res = toba::db()->consultar_fila($sql);
		return $res['duracion'];

	}

	function mes_cumplido($beca,$mes,$anio)
	{
		$sql = "SELECT * 
				FROM be_cumplimiento_obligacion
				WHERE nro_documento = ".quote($beca['nro_documento'])."
				AND id_tipo_beca = ".quote($beca['id_tipo_beca'])."
				AND id_convocatoria = ".quote($beca['id_convocatoria'])."
				AND mes = $mes
				AND anio = $anio";
		return count(toba::db()->consultar($sql));
	}

	function marcar_cumplido($cumplido)
	{
		$sql = "INSERT INTO be_cumplimiento_obligacion (nro_documento,id_convocatoria,id_tipo_beca,mes,anio,fecha_cumplimiento) 
			VALUES (".
				quote($cumplido['nro_documento']).",".
				quote($cumplido['id_convocatoria']).",".
				quote($cumplido['id_tipo_beca']).",".
				quote($cumplido['mes']).",".
				quote($cumplido['anio']).",".
				quote(date('Y-m-d')).")";
		return toba::db()->ejecutar($sql);

	}



}
?>