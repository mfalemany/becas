<?php
class co_cumplim_obligaciones
{
	public $meses = array('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre');
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
	}

}
?>