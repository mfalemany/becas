<?php
class co_comision_asesora
{
	function es_integrante_comision_asesora($nro_documento)
	{
		$sql = "select * from be_comision_asesora_integrante where id_convocatoria = (
					select max(id_convocatoria) from be_convocatoria_beca where id_tipo_convocatoria = 3
				) and nro_documento = " . quote($nro_documento);

		$resultado = toba::db()->consultar($sql);
		return (count($resultado) > 0);
	}

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
				AND id_convocatoria = (SELECT MAX(id_convocatoria) FROM be_convocatoria_beca WHERE id_tipo_convocatoria = 3)";

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

	function get_dictamen($inscripcion)
	{
		$sql = "select dic.nro_documento, dic.id_convocatoria, dic.id_tipo_beca, dic.justificacion_puntajes, dic.usuario_id,  
			        array_to_string( 
			            (select array_agg(upper(apellido)||', '||nombres) as evaluador 
			            from sap_personas 
			            --where nro_documento = any (string_to_array(dic.evaluadores,'/'))
			            where nro_documento = any (string_to_array(dic.evaluadores,'/'))) 
			        ,'/') as evaluadores,
			        per.apellido||', '||per.nombres as usuario,
			    	originalidad, 
					claridad_formulacion_obj,
					adecuacion_disenio,
					factibilidad,
					calidad_de_propuesta
			    from be_dictamen as dic
			    left join sap_personas as per on per.nro_documento = dic.usuario_id
			    where dic.id_convocatoria = ".quote($inscripcion['id_convocatoria'])."
			    and dic.id_tipo_beca = ".quote($inscripcion['id_tipo_beca'])."
			    and dic.nro_documento = ".quote($inscripcion['nro_documento'])."
			    and dic.tipo_dictamen = 'C'";
		return toba::db()->consultar_fila($sql);
	}

	//retorna el id de area de conocimiento del usuario recibido como parámetro
	function get_area_conocimiento_evaluador($nro_documento)
	{
		$sql = "SELECT id_area_conocimiento FROM be_comision_asesora_integrante WHERE nro_documento = ".quote($nro_documento);
		$resultado = toba::db()->consultar_fila($sql);
		return (count($resultado)) ? $resultado['id_area_conocimiento'] : '';
	}

	/**
	 * Obtiene todos los detalles que se le muestran al postulante en la opción de seguimiento. Esto incluye el resultado de la admisibilidad, la evaluación de comision y junta
	 */
	function get_detalles_seguimiento($inscripcion)
	{
		$cumplimientos = toba::consulta_php('co_cumplim_obligaciones')->get_cumplimientos(
			$inscripcion['nro_documento'],$inscripcion['id_convocatoria'],$inscripcion['id_tipo_beca']
		);
		
		$where  = "WHERE padre.nro_documento = ".quote($inscripcion['nro_documento'])."
					AND padre.id_tipo_beca    = ".quote($inscripcion['id_tipo_beca'])."
					AND padre.id_convocatoria = ".quote($inscripcion['id_convocatoria']);

		$sql = "SELECT admisible, beca_otorgada, observaciones FROM be_inscripcion_conv_beca AS padre $where"; 
		$adm = toba::db()->consultar_fila($sql);

		$sql = "SELECT puntaje FROM be_inscripcion_conv_beca as padre $where";
		$inscripcion = toba::db()->consultar_fila($sql);

		/* DICTAMEN DE COMISION */
		$sql = "SELECT justificacion_puntajes as justificacion,
				array_to_string( 
					    (SELECT array_agg(upper(apellido)||', '||nombres) AS evaluador 
					    FROM sap_personas 
					    WHERE nro_documento = ANY (string_to_array(padre.evaluadores,'/'))) 
					,'/') AS evaluadores
			  FROM be_dictamen AS padre $where AND padre.tipo_dictamen = 'C'";
		$datos['comision'] = toba::db()->consultar_fila($sql);

			
		$sql = "SELECT  cri.criterio_evaluacion, cri.puntaje_maximo, padre.puntaje
				FROM be_dictamen_detalle as padre
				LEFT JOIN be_tipo_beca_criterio_eval as cri USING (id_convocatoria, id_tipo_beca, id_criterio_evaluacion)
				$where 
				AND padre.tipo_dictamen = 'C'";
		$datos['comision']['detalles'] = toba::db()->consultar($sql);

		/* DICTAMEN DE JUNTA */
		$sql = "SELECT justificacion_puntajes as justificacion FROM be_dictamen as padre $where AND padre.tipo_dictamen = 'J'";
		$datos['junta'] = toba::db()->consultar_fila($sql);

		$sql = "SELECT  cri.criterio_evaluacion, cri.puntaje_maximo, padre.puntaje
				FROM be_dictamen_detalle as padre
				LEFT JOIN be_tipo_beca_criterio_eval as cri USING (id_convocatoria, id_tipo_beca, id_criterio_evaluacion)
				$where 
				AND padre.tipo_dictamen = 'J'";
		$datos['junta']['detalles'] = toba::db()->consultar($sql);

		
		return array(
			'admisibilidad' => $adm, 
			'dictamen'      => $datos, 
			'inscripcion'   => $inscripcion, 
			'cumplimientos' => $cumplimientos
		);
	}

	/*$sql = "SELECT 
					(SELECT puntaje FROM be_inscripcion_conv_beca WHERE nro_documento = dic.nro_documento AND id_tipo_beca = dic.id_tipo_beca AND id_convocatoria = dic.id_convocatoria) AS puntaje_inicial,
					(SELECT sum(puntaje) FROM be_dictamen_detalle WHERE nro_documento = dic.nro_documento AND id_tipo_beca = dic.id_tipo_beca AND id_convocatoria = dic.id_convocatoria AND tipo_dictamen = 'C') AS puntaje_comision,
					(SELECT justificacion_puntajes FROM be_dictamen WHERE nro_documento = dic.nro_documento AND id_tipo_beca = dic.id_tipo_beca AND id_convocatoria = dic.id_convocatoria AND tipo_dictamen = 'C') AS justificacion_comision,
					(SELECT sum(puntaje) FROM be_dictamen_detalle WHERE nro_documento = dic.nro_documento AND id_tipo_beca = dic.id_tipo_beca AND id_convocatoria = dic.id_convocatoria AND tipo_dictamen = 'J') AS puntaje_junta,
					(SELECT justificacion_puntajes FROM be_dictamen WHERE nro_documento = dic.nro_documento AND id_tipo_beca = dic.id_tipo_beca AND id_convocatoria = dic.id_convocatoria AND tipo_dictamen = 'J') AS justificacion_junta,
					array_to_string( 
					    (SELECT array_agg(upper(apellido)||', '||nombres) AS evaluador 
					    FROM sap_personas 
					    WHERE nro_documento = ANY (string_to_array(dic.evaluadores,'/'))) 
					,'/') AS evaluadores
				FROM be_dictamen AS dic
				WHERE dic.nro_documento = ".quote($inscripcion['nro_documento'])."
				AND dic.id_tipo_beca    = ".quote($inscripcion['id_tipo_beca'])."
				AND dic.id_convocatoria = ".quote($inscripcion['id_convocatoria'])."
				AND tipo_dictamen = 'C'";*/

	

}
?>