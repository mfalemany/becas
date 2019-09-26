<?php
class form_admisibilidad extends becas_ei_formulario
{
	function generar_layout()
	{
		echo "<table id='tabla_documentacion'><tr>";
		$insc = $this->controlador()->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$conv = toba::consulta_php('co_convocatoria_beca')->get_campo('convocatoria',$insc['id_convocatoria']);
		$tipo_beca = toba::consulta_php('co_tipos_beca')->get_campo('tipo_beca',$insc['id_tipo_beca']);
		if($insc['archivo_analitico']){
			$base = "/documentos/";
			$ruta = $base.'becas/doc_por_convocatoria/'.$conv."/".$tipo_beca."/".$insc['nro_documento']."/";
			echo "<td><a class='enlace_boton' href='".$ruta.'Cert. Analitico.pdf'."' target='_BLANK'>Ver analítico</a></td>";
		}

		$base = toba::consulta_php('helper_archivos')->ruta_base();
		$archivo = 'docum_personal/'.$insc['nro_documento'].'/dni.pdf';

		if(file_exists($base.$archivo)){
			echo "<td><a class='enlace_boton' href='/documentos/".$archivo."' target='_BLANK'>Ver DNI</a></td>";
		}

		if($insc['archivo_insc_posgrado']){
			echo "<td><a href='".$ruta."Insc. o Compromiso Posgrado.pdf"."' class='enlace_boton' target='_BLANK'>Insc./Compromiso Posgrado</a></td>";
		}	
		echo "</tr></table>";
		
		$this->generar_html_ef('prom_hist');
		$this->generar_html_ef('puntaje');
		$this->generar_html_ef('es_egresado');
		$this->generar_html_ef('porcentaje_aprobacion');
		$this->generar_html_ef('mat_para_egresar');
		$this->generar_html_ef('archivo_insc_posgrado');
		$this->generar_html_ef('cant_fojas');
		$this->generar_html_ef('observaciones');
		$this->generar_html_ef('admisible');
		$this->generar_html_ef('beca_otorgada');
		
		
	}

}
?>