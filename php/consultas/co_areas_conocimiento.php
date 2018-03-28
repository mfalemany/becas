<?php
class co_areas_conocimiento
{

	function get_areas_conocimiento()
	{
		$sql = "SELECT
			t_sac.id,
			t_sac.descripcion,
			t_sac.nombre,
			t_sac.aplicable,
			t_sac.prefijo_orden_poster
		FROM
			sap_area_conocimiento as t_sac
		ORDER BY nombre";
		return toba::db('sap')->consultar($sql);
	}


	 function get_disciplinas_incluidas($id_area_conocimiento)
    {
    	$sql = "SELECT disciplinas_incluidas FROM be_area_conocimiento WHERE id_area_conocimiento = ".quote($id_area_conocimiento);
    	$resultado = toba::db()->consultar_fila($sql);
    	return count($resultado) ? $resultado['disciplinas_incluidas'] : '';
    }

}
?>