<?php
class form_admisibilidad extends becas_ei_formulario
{
	function generar_layout()
	{
		
		$this->generar_html_ef('prom_hist');
		$this->generar_html_ef('puntaje');
		$this->generar_html_ef('es_egresado');
		$insc = $this->controlador()->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$conv = toba::consulta_php('co_convocatoria_beca')->get_campo('convocatoria',$insc['id_convocatoria']);
		$tipo_beca = toba::consulta_php('co_tipos_beca')->get_campo('tipo_beca',$insc['id_tipo_beca']);

		if($insc['archivo_analitico']){
			$base = "/documentos/";
			$ruta = $base.'becas/doc_por_convocatoria/'.$conv."/".$tipo_beca."/".$insc['nro_documento']."/";
			echo "<a id='enlace_analitico' class='enlace_boton' href='".$ruta.'Cert. Analitico.pdf'."' target='_BLANK'>Ver analítico</a>";
		}

		$this->generar_html_ef('porcentaje_aprobacion');
		$this->generar_html_ef('mat_para_egresar');
		$this->generar_html_ef('archivo_insc_posgrado');
		$this->generar_html_ef('cant_fojas');
		$this->generar_html_ef('observaciones');
		$this->generar_html_ef('admisible');
		$this->generar_html_ef('beca_otorgada');
		if($insc['archivo_insc_posgrado']){
			echo "<div style='margin:10px auto 10px auto; text-align:center;'><a href='".$ruta."Insc. o Compromiso Posgrado.pdf"."' class='enlace_boton' target='_BLANK'>Ver inscripción/compromiso a posgrado</a></div>";
		}
	}

}
?>