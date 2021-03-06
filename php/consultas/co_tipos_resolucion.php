<?php
class co_tipos_resolucion{
	function obtener()
	{
		$sql = "SELECT
			t_btr.id_tipo_resol,
			t_btr.tipo_resol,
			t_btr.tipo_resol_corto
		FROM
			be_tipos_resolucion as t_btr
		ORDER BY tipo_resol";
		return toba::db()->consultar($sql);
	}

	function get_nombre_corto($id_tipo_resol)
	{
		$sql = "SELECT
			t_btr.tipo_resol_corto
		FROM
			be_tipos_resolucion as t_btr
		WHERE id_tipo_resol = $id_tipo_resol";
		$resultado = toba::db()->consultar_fila($sql);
		return $resultado['tipo_resol_corto'];
	}

	function get_descripciones()
	{
		$sql = "SELECT id_tipo_resol, tipo_resol FROM be_tipos_resolucion ORDER BY tipo_resol";
		return toba::db()->consultar($sql);
	}

}
?>