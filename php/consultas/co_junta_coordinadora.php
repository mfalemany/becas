<?php

class co_junta_coordinadora
{
	function get_orden_merito($filtro = array())
	{
		$where = array();
		if(isset($filtro['id_convocatoria'])){
			$where[] = 'id_convocatoria = '.quote($filtro['id_convocatoria']);
		}
		if(isset($filtro['id_tipo_beca'])){
			$where[] = 'id_tipo_beca = '.quote($filtro['id_tipo_beca']);
		}
		if(isset($filtro['postulante'])){
			$where[] = 'apellido||nombres ilike '.quote('%'.$filtro['postulante'].'%');
		}
		if(isset($filtro['id_area_conocimiento'])){
			$where[] = 'id_area_conocimiento = '.quote($filtro['id_area_conocimiento']);
		}
		if(isset($filtro['id_dependencia'])){
			$where[] = 'id_dependencia = '.quote($filtro['id_dependencia']);
		}
		if(isset($filtro['lugar_trabajo_becario'])){
			$where[] = 'lugar_trabajo_becario = '.quote($filtro['lugar_trabajo_becario']);
		}
		if(isset($filtro['beca_otorgada'])){
			$where[] = 'not exists (select * from be_becas_otorgadas where nro_documento = tmp.nro_documento and id_convocatoria = tmp.id_convocatoria and id_tipo_beca = tmp.id_tipo_beca)';
		}


	
		$sql = "select *, 
				    (case when (puntaje_junta <> 'No asignado') then puntaje_junta else puntaje_comision::varchar end)::decimal as puntaje_final
				from (
				    select  insc.id_convocatoria,
				    		insc.id_tipo_beca,
				    		insc.id_area_conocimiento,
				    		insc.beca_otorgada,
				    		bo.fecha_desde,
				    		bo.fecha_hasta,
				    		bo.fecha_toma_posesion,
				    		bo.nro_resol,
				    		bo.estado as estado_beca_otorgada,
				    		case bo.estado 
				    			when 'A' then 'Otorgada' 
				    			when 'B' then 'Baja' 
				    			else 'No otorgada' end as estado_beca_otorgada_desc,
				    		ac.nombre as area_conocimiento,
				    		per.nro_documento,
				    		per.cuil,
				            upper(per.apellido)||', '||initcap(per.nombres) as postulante,
				            tipbec.tipo_beca,
				            dep.nombre as facultad,
				            dep.id as id_dependencia,
				            lugtrab.nombre as lugar_trabajo,
				            case when insc.id_tipo_beca in (2,3) then lugtrab.nombre else dep.nombre end as lugar,
				            insc.lugar_trabajo_becario,
				            dir.apellido||', '||dir.nombres as director,
				            case when (insc.puntaje < 0) then 'No corresponde' when (insc.puntaje >= 0) then insc.puntaje::varchar end as puntaje,
				           insc.puntaje+(select sum(puntaje) 
				           from be_dictamen_detalle 
				           where tipo_dictamen = 'C' 
				           and nro_documento = insc.nro_documento 
				           and id_convocatoria = insc.id_convocatoria 
				           and id_tipo_beca = insc.id_tipo_beca) as puntaje_comision,
				           case when (insc.puntaje > 0) then
				                    coalesce(
				                    (insc.puntaje+(select sum(puntaje) 
				                   from be_dictamen_detalle 
				                   where tipo_dictamen = 'J' 
				                   and nro_documento = insc.nro_documento 
				                   and id_convocatoria = insc.id_convocatoria 
				                   and id_tipo_beca = insc.id_tipo_beca))::varchar ,'No asignado')
				           when (insc.puntaje < 0) then 
				                    coalesce(
				                    (select sum(puntaje) 
				                   from be_dictamen_detalle 
				                   where tipo_dictamen = 'J' 
				                   and nro_documento = insc.nro_documento 
				                   and id_convocatoria = insc.id_convocatoria 
				                   and id_tipo_beca = insc.id_tipo_beca)::varchar ,'No asignado') end
				     as puntaje_junta
				    from be_inscripcion_conv_beca as insc
				    left join sap_personas as per on per.nro_documento = insc.nro_documento
				    left join sap_personas as dir on dir.nro_documento = insc.nro_documento_dir
				    left join be_tipos_beca as tipbec on tipbec.id_tipo_beca = insc.id_tipo_beca
				    left join sap_dependencia as dep on dep.id = insc.id_dependencia
				    left join sap_dependencia as lugtrab on lugtrab.id = insc.lugar_trabajo_becario
				    left join sap_area_conocimiento as ac on ac.id = insc.id_area_conocimiento
				    left join be_becas_otorgadas AS bo ON 
				    	bo.id_convocatoria = insc.id_convocatoria AND
				    	bo.id_tipo_beca = insc.id_tipo_beca AND
				    	bo.nro_documento = insc.nro_documento
				    where insc.estado = 'C'
				    and insc.admisible = 'S'
				    and exists(
				        select * 
				        from be_dictamen 
				        where tipo_dictamen = 'C' 
				        and nro_documento = insc.nro_documento 
				        and id_convocatoria = insc.id_convocatoria 
				        and id_tipo_beca = insc.id_tipo_beca
				    )
				) as tmp";
			if(isset($filtro['campos_ordenacion'])){
				foreach ($filtro['campos_ordenacion'] as $campo => $orden) {
					$criterios_orden[] = $campo." ".$orden;
				}
				$sql .= " order by ".implode(', ',$criterios_orden);
			}else{
				$sql .= " order by puntaje_final DESC";
			}

			
		if(isset($filtro['cantidad_becas']) && is_numeric($filtro['cantidad_becas']) ){
			$sql .= " LIMIT ".$filtro['cantidad_becas'];	
		}
			
		if(count($where)){
			$sql = sql_concatenar_where($sql,$where);
		}
		return toba::db()->consultar($sql);
		
	}

}

?>