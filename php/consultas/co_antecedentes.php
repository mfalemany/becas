<?php
class co_antecedentes
{
	function get_antec_activ_docentes($filtro = array())
	{
		$where = array();
		if(isset($filtro['nro_documento'])){
			$where[] = "ant.nro_documento = ".quote($filtro['nro_documento']);
		}
		$sql = "SELECT * FROM be_antec_activ_docentes AS ant";
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	function get_antec_estudios_afines($filtro = array())
	{
		$where = array();
		if(isset($filtro['nro_documento'])){
			$where[] = "ant.nro_documento = ".quote($filtro['nro_documento']);
		}
		$sql = "SELECT * FROM be_antec_estudios_afines AS ant";
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	function get_antec_becas_obtenidas($filtro = array())
	{
		$where = array();
		if(isset($filtro['nro_documento'])){
			$where[] = "ant.nro_documento = ".quote($filtro['nro_documento']);
		}
		$sql = "SELECT * FROM be_antec_becas_obtenidas AS ant";
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	function get_antec_trabajos_publicados($filtro = array())
	{
		$where = array();
		if(isset($filtro['nro_documento'])){
			$where[] = "ant.nro_documento = ".quote($filtro['nro_documento']);
		}
		$sql = "SELECT * FROM be_antec_trabajos_publicados AS ant";
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}


	function get_antec_present_reuniones($filtro = array())
	{
		$where = array();
		if(isset($filtro['nro_documento'])){
			$where[] = "ant.nro_documento = ".quote($filtro['nro_documento']);
		}
		$sql = "SELECT * FROM be_antec_present_reuniones AS ant";
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	function get_antec_conocimiento_idiomas($filtro = array())
	{
		$where = array();
		if(isset($filtro['nro_documento'])){
			$where[] = "ant.nro_documento = ".quote($filtro['nro_documento']);
		}
		$sql = "SELECT id_conocimiento_idioma,idioma, nro_documento,doc_probatoria,
		case lectura when 1 then 'Muy bueno' when 2 then 'Bueno' when 3 then 'Aceptable' end as lectura,     
		case escritura when 1 then 'Muy bueno' when 2 then 'Bueno' when 3 then 'Aceptable' end as escritura,
		case conversacion when 1 then 'Muy bueno' when 2 then 'Bueno' when 3 then 'Aceptable' end as conversacion,
		case traduccion when 1 then 'Muy bueno' when 2 then 'Bueno' when 3 then 'Aceptable' end as traduccion 
		FROM be_antec_conoc_idiomas AS ant";
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	function get_antec_otras_actividades($filtro = array())
	{
		$where = array();
		if(isset($filtro['nro_documento'])){
			$where[] = "ant.nro_documento = ".quote($filtro['nro_documento']);
		}
		$sql = "SELECT * FROM be_antec_otras_actividades AS ant";
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}
	function get_antec_particip_dict_cursos($filtro = array())
	{
		$where = array();
		if(isset($filtro['nro_documento'])){
			$where[] = "ant.nro_documento = ".quote($filtro['nro_documento']);
		}
		$sql = "SELECT * FROM be_antec_particip_dict_cursos AS ant";
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	function get_antec_cursos_perfeccionamiento($filtro = array())
	{
		$where = array();
		if(isset($filtro['nro_documento'])){
			$where[] = "ant.nro_documento = ".quote($filtro['nro_documento']);
		}
		$sql = "SELECT * FROM be_antec_cursos_perfec_aprob AS ant";
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
	}

	function get_campos($campos,$tabla,$condicion,$fila_unica=TRUE)
	{
		if(!is_array($campos) || count($campos) == 0 || strlen($tabla) == 0){
			return array();
		}
		$campos = implode(',',$campos);
		$sql = "SELECT $campos FROM $tabla WHERE $condicion";
		return ($fila_unica) ? toba::db()->consultar_fila($sql) : toba::db()->consultar($sql);
		
	}

}

?>