<?php
class co_tipos_beca
{

	function get_tipos_beca()
	{
		$sql = "SELECT
			tip.id_tipo_beca,
			tip_con.tipo_convocatoria,
			tip.tipo_beca,
			tip.cupo_maximo,
			tip.id_color,
			tip.factor,
			col.color
		FROM tipos_beca as tip	
		LEFT JOIN tipos_convocatoria as tip_con ON tip.id_tipo_convocatoria = tip_con.id_tipo_convocatoria
		LEFT JOIN color_carpeta as col on col.id_color = tip.id_color
		ORDER BY tipo_beca";
		return toba::db('becas')->consultar($sql);
	}

	function get_tipos_beca_por_tipo_convocatoria($id_tipo_convocatoria)
	{
		$sql = "SELECT tb.id_tipo_beca, tb.tipo_beca
				FROM convocatoria_beca as cb
				LEFT JOIN tipos_convocatoria as tc on tc.id_tipo_convocatoria = cb.id_tipo_convocatoria
				LEFT JOIN tipos_beca as tb on tb.id_tipo_convocatoria = cb.id_tipo_convocatoria
				WHERE cb.id_tipo_convocatoria = ".quote($id_tipo_convocatoria)."
				AND tb.estado = 'A'";
		return toba::db()->consultar($sql);
	}
	function get_tipos_beca_por_convocatoria($id_convocatoria)
	{
		$sql = "SELECT tb.id_tipo_beca, tb.tipo_beca
				FROM convocatoria_beca as cb
				LEFT JOIN tipos_convocatoria as tc on tc.id_tipo_convocatoria = cb.id_tipo_convocatoria
				LEFT JOIN tipos_beca as tb on tb.id_tipo_convocatoria = cb.id_tipo_convocatoria
				WHERE cb.id_convocatoria = ".quote($id_convocatoria)."
				AND tb.estado = 'A'";
		return toba::db()->consultar($sql);
	}

	function get_campo($campo, $id_tipo_beca)
	{
		$sql = "SELECT $campo FROM tipos_beca WHERE id_tipo_beca = ".quote($id_tipo_beca)." LIMIT 1";
		$resultado = toba::db()->consultar_fila($sql);
		if( array_key_exists($campo,$resultado)){
			if($resultado[$campo]){
				return $resultado[$campo];
			}
		}
		return FALSE;
	}

	


}
?>