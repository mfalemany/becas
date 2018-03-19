<?php
class form_admisibilidad extends becas_ei_formulario
{
	function generar_layout()
	{
		$this->generar_html_ef('prom_hist');
		$insc = $this->controlador()->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$conv = toba::consulta_php('co_convocatoria_beca')->get_campo('convocatoria',$insc['id_convocatoria']);
		$tipo_beca = toba::consulta_php('co_tipos_beca')->get_campo('tipo_beca',$insc['id_tipo_beca']);

		if($insc['archivo_analitico']){
			$base = toba::proyecto()->get_www();

			$ruta = $base['url'].'/doc_por_convocatoria/'.$conv."/".$tipo_beca."/".$insc['nro_documento']."/Cert. Analitico.pdf";
			echo "<a id='enlace_analitico' href='".$ruta."' target='_BLANK'>Ver analítico</a>";
		}
		$this->generar_html_ef('porcentaje_aprobacion');
		$this->generar_html_ef('mat_para_egresar');
		$this->generar_html_ef('cant_fojas');
		$this->generar_html_ef('observaciones');
		$this->generar_html_ef('admisible');
		$this->generar_html_ef('beca_otorgada');
	}

}
?>