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

	function get_integrantes_comision($filtro = array())
	{
		//obtengo los integrantes de la comisión a la que pertenece el usuario actualmente logueado
		$sql = "SELECT id_convocatoria,id_area_conocimiento 
				FROM be_comision_asesora_integrante AS inte
				WHERE nro_documento = ".quote(toba::usuario()->get_id())."
				--WHERE nro_documento = ".quote(toba::usuario()->get_id())."
				AND id_convocatoria = (SELECT MAX(id_convocatoria) FROM be_convocatoria_beca)";

		$datos = toba::db()->consultar_fila($sql);
		if(!$datos){
			return array();
		}
		$sql = "SELECT inte.nro_documento, per.apellido||', '||per.nombres AS evaluador
				FROM be_comision_asesora_integrante AS inte
				LEFT JOIN sap_personas AS per ON per.nro_documento = inte.nro_documento
				WHERE id_convocatoria = ".quote($datos['id_convocatoria'])."
				AND id_area_conocimiento = ".quote($datos['id_area_conocimiento'])."
				ORDER BY 2";
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

	function get_criterio_descripcion($id_criterio_evaluacion)
	{
		return toba::db()->consultar_fila("SELECT criterio_evaluacion FROM be_tipo_beca_criterio_eval WHERE id_criterio_evaluacion = ".quote($id_criterio_evaluacion));
	}

	function get_puntaje_maximo($id_criterio_evaluacion)
	{
		return toba::db()->consultar_fila("SELECT puntaje_maximo FROM be_tipo_beca_criterio_eval WHERE id_criterio_evaluacion = ".quote($id_criterio_evaluacion));
	}

	function get_ayn_evaluador($nro_documento)
	{
		return toba::db()->consultar_fila("SELECT apellido||', '||nombres FROM sap_personas WHERE nro_documento = ".quote($nro_documento));
	}

	function get_detalles_dictamen($inscripcion)
	{
		$sql = "select det.id_criterio_evaluacion, cri.criterio_evaluacion, det.puntaje as asignado, cri.puntaje_maximo, dic.justificacion_puntajes, dic.evaluadores
			from be_dictamen as dic
			left join be_dictamen_detalle as det 
			    on det.tipo_dictamen = dic.tipo_dictamen
			    and det.nro_documento = dic.nro_documento
			    and det.id_tipo_beca = dic.id_tipo_beca
			    and det.id_convocatoria = dic.id_convocatoria
			left join be_tipo_beca_criterio_eval as cri on cri.id_criterio_evaluacion = det.id_criterio_evaluacion
			WHERE dic.nro_documento = ".quote($inscripcion['nro_documento'])."
			AND dic.id_convocatoria = ".quote($inscripcion['id_convocatoria'])."
			AND dic.id_tipo_beca = ".quote($inscripcion['id_tipo_beca'])."
			AND dic.tipo_dictamen = 'C'";
		return toba::db()->consultar($sql);
	}

	//retorna el id de area de conocimiento del usuario recibido como parámetro
	function get_area_conocimiento_evaluador($nro_documento)
	{
		$sql = "SELECT id_area_conocimiento FROM be_comision_asesora_integrante WHERE nro_documento = ".quote($nro_documento);
		$resultado = toba::db()->consultar_fila($sql);
		return (count($resultado)) ? $resultado['id_area_conocimiento'] : '';
	}

}
?>