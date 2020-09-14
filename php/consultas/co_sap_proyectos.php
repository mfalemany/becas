<?php 
class co_sap_proyectos
{
	function get_proyectos($patron)
	{
		$sql = "SELECT id, descripcion 
				FROM sap_proyectos 
				WHERE quitar_acentos(descripcion) ILIKE '%'||quitar_acentos(".quote($patron).")||'%'";
		return toba::db()->consultar($sql);
	}

	function get_consulta_vigentes($alias_tabla_proyectos){
		return "current_date between $alias_tabla_proyectos.fecha_desde and $alias_tabla_proyectos.fecha_hasta
				and (
				    select sum(eval_positivas) from (
				    select count(*) as eval_positivas from sap_proy_pi_eval where estado = 'C' and result_final_evaluacion <> 'N' and id_proyecto = $alias_tabla_proyectos.id
				    union 
				    select count(*) as eval_positivas from sap_proy_pdts_eval where estado = 'C' and result_final_evaluacion <> 'N' and id_proyecto = $alias_tabla_proyectos.id
				    ) as tmp
				) >= 2";
	}

	function get_proyectos_inscripcion_becas($patron)
	{
		$consulta_vigentes = $this->get_consulta_vigentes('proy');
		$sql = "SELECT id, descripcion FROM sap_proyectos AS proy WHERE ".$consulta_vigentes;
	}

	function get_descripcion($id)
	{
		$sql = "SELECT descripcion FROM sap_proyectos WHERE id = ".quote($id);
		$resultado = toba::db()->consultar_fila($sql);
		return $resultado['descripcion'];
	}
}
?>