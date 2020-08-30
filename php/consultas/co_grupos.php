<?php

class co_grupos
{
	function get_denominacion_grupo($id_grupo)
	{
		$sql = "SELECT denominacion FROM sap_grupo WHERE id_grupo = ".quote($id_grupo)." LIMIT 1";
		$resultado = toba::db()->consultar_fila($sql);
		return $resultado['denominacion'];

	}

	function get_grupos($filtro = array(),$limite = false)
	{
		if( ! array_key_exists('solo_acreditados', $filtro)){
			$filtro['solo_acreditados'] = TRUE;
		}
		$where = array();
		//Los grupos acreditados son aquellos que tuvieron la última evaluación positiva (y al menos una). No se incluyen entonces a: grupos que no tienen ninguna evaluación, o que teniendo evaluaciones, la última no es aprobada
		if(isset($filtro['solo_acreditados']) && $filtro['solo_acreditados']){
			$where[] = "exists (
						select * 
						from sap_grupo_informe_evaluacion 
						where id_grupo = gr.id_grupo 
						and id_convocatoria = (select max(id_convocatoria) from sap_grupo_informe_evaluacion where id_grupo = gr.id_grupo)
						and resultado = 'A'
					)";
		}
		if(isset($filtro['patron'])){
			$where[] = 'quitar_acentos(gr.denominacion) ilike quitar_acentos('.quote('%'.$filtro['patron'].'%').')';
		}


		$sql = "SELECT * FROM sap_grupo AS gr";
		$sql .= (isset($limite) && $limite && is_numeric($limite)) ? " LIMIT $limite" : "";

		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	function get_grupos_combo_editable($patron){
		return $this->get_grupos(array('patron'=>$patron));
	}

}

?>