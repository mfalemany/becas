<?php
class ci_subir_recibos extends becas_ci
{
	//-----------------------------------------------------------------------------------
	//---- form_subir_recibos -----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__form_subir_recibos__subir()
	{
		$procesador = new ProcesadorRecibos();
		$errores = $procesador->procesar($_FILES['archivos']);
		if(count($errores) == 0){
			toba::notificacion()->agregar('Todos los archivos se subieron con éxito','info');
		}else{
			$lista = "<ul>";
			foreach ($errores as $error) {
				$lista .= "<li>{$error['archivo']}: {$error['motivo']}";
			}
			$lista .= "</ul>";
			toba::notificacion()->agregar("Se subieron los archivos seleccionados, pero ocurrieron los siguientes errores:<br>$lista",'warning');
		}
	}

	function extender_objeto_js(){
		echo "
		const boton = document.getElementById('form_4570_form_subir_recibos_subir');
		boton.addEventListener('click', (e) => {
			toba.inicio_aguardar();
			boton.disabled = true;
		})";
	}

}

?>