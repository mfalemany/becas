<?php
class co_tipos_beca
{

	function get_tipos_beca($filtro = array())
	{
		$where = array();
		if(isset($filtro['id_tipo_beca'])){
			$where[] = 'tip.id_tipo_beca = '.quote($filtro['id_tipo_beca']);
		}
		$sql = "SELECT
			tip.id_tipo_beca,
			tip_con.tipo_convocatoria,
			tip.tipo_beca,
			'('||tip_con.tipo_convocatoria||') '||tip.tipo_beca as tipo_conv_tipo_beca,
			tip.duracion_meses,
			tip.meses_present_avance,
			tip.cupo_maximo,
			tip.id_color,
			tip.factor,
			tip.edad_limite,
			tip.prefijo_carpeta,
			col.color,
			tip.requiere_insc_posgrado,
			tip.debe_adeudar_hasta,
			tip.suma_puntaje_academico,
			tip.puntaje_academico_maximo	
		FROM be_tipos_beca as tip	
		LEFT JOIN be_tipos_convocatoria as tip_con ON tip.id_tipo_convocatoria = tip_con.id_tipo_convocatoria
		LEFT JOIN be_color_carpeta as col on col.id_color = tip.id_color
		ORDER BY tipo_beca";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db()->consultar($sql);
	}

	function get_tipos_beca_por_tipo_convocatoria($id_tipo_convocatoria)
	{
		$sql = "SELECT tb.id_tipo_beca, tb.tipo_beca
				FROM be_convocatoria_beca as cb
				LEFT JOIN be_tipos_convocatoria as tc on tc.id_tipo_convocatoria = cb.id_tipo_convocatoria
				LEFT JOIN be_tipos_beca as tb on tb.id_tipo_convocatoria = cb.id_tipo_convocatoria
				WHERE cb.id_tipo_convocatoria = ".quote($id_tipo_convocatoria)."
				AND tb.estado = 'A'";
		return toba::db()->consultar($sql);
	}
	function get_tipos_beca_por_convocatoria($id_convocatoria)
	{
		$sql = "SELECT tb.id_tipo_beca, tb.tipo_beca
				FROM be_convocatoria_beca as cb
				LEFT JOIN be_tipos_convocatoria as tc on tc.id_tipo_convocatoria = cb.id_tipo_convocatoria
				LEFT JOIN be_tipos_beca as tb on tb.id_tipo_convocatoria = cb.id_tipo_convocatoria
				WHERE cb.id_convocatoria = ".quote($id_convocatoria)."
				AND estado = 'A'";
		return toba::db()->consultar($sql);
	}

	function get_campo($campo, $id_tipo_beca)
	{
		$sql = "SELECT $campo FROM be_tipos_beca WHERE id_tipo_beca = ".quote($id_tipo_beca)." LIMIT 1";
		$resultado = toba::db()->consultar_fila($sql);
		if( array_key_exists($campo,$resultado)){
			if($resultado[$campo]){
				return $resultado[$campo];
			}
		}
		return FALSE;
	}

	function requiere_posgrado($id_tipo_beca)
	{
		//si no se recibi ningun tipo de beca, se asume la respuesta "SI"
		if(!$id_tipo_beca){
			return TRUE;
		}
		$resultado = toba::db()->consultar_fila("SELECT requiere_insc_posgrado FROM be_tipos_beca WHERE id_tipo_beca = ".quote($id_tipo_beca));
		if(count($resultado) > 0){
			return ($resultado['requiere_insc_posgrado'] == 'S') ? TRUE : FALSE;
		}else{
			return TRUE;
		}
	}

	function get_criterios_evaluacion()
	{
		$sql = "SELECT cri.id_convocatoria, 
						cri.id_tipo_beca, 
						cri.id_criterio_evaluacion, 
						cri.puntaje_maximo, 
						cri.criterio_evaluacion,
						conv.convocatoria,
						tip.tipo_beca
				FROM be_tipo_beca_criterio_eval AS cri
				LEFT JOIN be_tipos_beca AS tip ON tip.id_tipo_beca = cri.id_tipo_beca
				LEFT JOIN be_convocatoria_beca AS conv ON conv.id_convocatoria = cri.id_convocatoria";
		return toba::db()->consultar($sql);
	}

	function suma_puntaje_academico($id_tipo_beca)
	{
		$sql = "SELECT suma_puntaje_academico FROM be_tipos_beca WHERE id_tipo_beca = ".quote($id_tipo_beca);
		$resultado = toba::db()->consultar_fila($sql);
		return ($resultado['suma_puntaje_academico'] == 'S');
	}

	


}
?>