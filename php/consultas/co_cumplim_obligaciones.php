<?php
class co_cumplim_obligaciones
{
	public $meses = array('','Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre');
	function get_cumplimientos($filtro=array())
	{
		$where = array();
		if (isset($filtro['nro_documento'])) {
			$where[] = "nro_documento = ".quote($filtro['nro_documento']);
		}
		if (isset($filtro['mes'])) {
			$where[] = "mes = ".quote($filtro['mes']);
		}
		if (isset($filtro['anio'])) {
			$where[] = "anio = ".quote($filtro['anio']);
		}
		if (isset($filtro['id_tipo_cumpl_oblig'])) {
			$where[] = "id_tipo_cumpl_oblig = ".quote($filtro['id_tipo_cumpl_oblig']);
		}
		$sql = "SELECT
			cum.id_tipo_doc,
			cum.nro_documento,
			cum.mes,
			$this->meses['mes'] as descripcion,
			cum.anio,
			tip.tipo_cumpl_oblig as id_tipo_cumpl_oblig_nombre,
			cum.fecha_cumplimiento
		FROM
			cumplimiento_obligacion as cum	LEFT OUTER JOIN tipo_cumpl_obligacion as tip ON (cum.id_tipo_cumpl_oblig = tip.id_tipo_cumpl_oblig)";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('becas')->consultar($sql);
	}

	function get_meses()
	{
		$meses = array();
		foreach($this->meses as $i => $mes){
			if($i!=0){
				$meses[] = array('mes'=>$i,'descripcion'=>$mes);
			}
		}
		return $meses;
	}

}
?>