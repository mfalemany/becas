<?php
class form_admisibilidad extends becas_ei_formulario
{
	function generar_layout()
	{
		echo "<table id='tabla_documentacion'><tr>";
		$insc = $this->controlador()->get_datos('inscripcion','inscripcion_conv_beca')->get();
		$conv = toba::consulta_php('co_convocatoria_beca')->get_campo('convocatoria',$insc['id_convocatoria']);
		$tipo_beca = toba::consulta_php('co_tipos_beca')->get_campo('tipo_beca',$insc['id_tipo_beca']);
		
		$base = "/documentos/";
		$ruta_base = toba::consulta_php('helper_archivos')->ruta_base();

		//ANALITICO
		if($insc['archivo_analitico']){
			$ruta = $base.'becas/doc_por_convocatoria/'.$conv."/".$tipo_beca."/".$insc['nro_documento']."/";
			echo "<td><a class='enlace_boton' href='".$ruta.'Cert. Analitico.pdf'."' target='_BLANK'>Ver analítico</a></td>";
		}

		//COPIA DNI
		$archivo = 'docum_personal/'.$insc['nro_documento'].'/dni.pdf';

		if(file_exists($ruta_base.$archivo)){
			echo "<td><a class='enlace_boton' href='".$base.$archivo."' target='_BLANK'>Ver DNI</a></td>";
		}

		//INSCRIPCION A POSGRADO
		if($insc['archivo_insc_posgrado']){
			echo "<td><a href='".$ruta."Insc. o Compromiso Posgrado.pdf"."' class='enlace_boton' target='_BLANK'>Insc./Compromiso Posgrado</a></td>";
		}

		//Constancia de CUIL
		$archivo = 'docum_personal/'.$insc['nro_documento'].'/CUIL.pdf';
		if(file_exists($ruta_base.$archivo)){
			echo "<td><a class='enlace_boton' href='".$base.$archivo."' target='_BLANK'>Ver CUIL</a></td>";
		}

		echo "</tr><tr>";
		//================= SECCION CVAR DIRECTORES ===================================
		$ruta = toba::consulta_php('helper_archivos')->ruta_base();
		$archivo = 'docum_personal/'.$insc['nro_documento_dir'].'/cvar.pdf';
		if(file_exists($ruta.$archivo)){
			echo "<td><a class='enlace_boton' href='/documentos/".$archivo."' target='_BLANK'>CVAr Director</a></td>";
		}

		if(isset($insc['nro_documento_codir'])){
			$archivo = 'docum_personal/'.$insc['nro_documento_codir'].'/cvar.pdf';
			if(file_exists($ruta.$archivo)){
				echo "<td><a class='enlace_boton' href='/documentos/".$archivo."' target='_BLANK'>CVAr Co-Director</a></td>";
			}
		}

		if(isset($insc['nro_documento_subdir'])){
			$archivo = 'docum_personal/'.$insc['nro_documento_subdir'].'/cvar.pdf';
			if(file_exists($ruta.$archivo)){
				echo "<td><a class='enlace_boton' href='/documentos/".$archivo."' target='_BLANK'>CVAr Sub-Director</a></td>";
			}
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