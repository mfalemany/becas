<?php
	$usuario = toba::usuario()->get_id();
	//$archivos = toba::consulta_php('helper_archivos')->get_recibos_sueldo($usuario);
	$archivos = toba::consulta_php('helper_archivos')->get_recibos_sueldo($usuario);
	if(count($archivos)){

		echo "<table border=1 width='400px' style='position:absolute; top: 100px; left: 40px; font-size:1.4rem; border-collapse: collapse;'>
		<caption style='font-size:1.5em; font-weight:bold; color:#4344B9;'> Recibos de sueldo disponibles</caption>
		<th>Nro. Recibo</th><th>Fecha</th><th>Descargar</th>";
		foreach($archivos as $archivo){
			$partes = explode('_',$archivo);
			$fecha = str_replace('.pdf','',$partes[2]);
			
			echo "<tr><td class='centrado'>{$partes[1]}</td><td  class='centrado'>$fecha</td>";
			echo "<td  class='centrado'><a style='text-decoration:none;' href='/documentos/recibos_sueldo/$archivo' target='_BLANK' rel='noopener noreferrer'>Click Aquí</a></td>";
		}
		echo "</table>";
	}
	echo '<h1 style="color:#3c84ce; text-shadow: 0px 0px 1px #77A;">Bienvenido</h1>';		
	echo '<h3 style="color:#222; text-shadow: 0px 0px 1px #777;">Sistema de Gesti&oacute;n de Becas - SGCyT - UNNE</h3>';
	echo '<div class="logo" style="margin-top:60px">';
	echo toba_recurso::imagen_proyecto('logo_grande.gif', true);
	echo '</div>';

	if( ! in_array('becario',toba::usuario()->get_perfiles_funcionales())){
		
		try {
			toba::instancia()->vincular_usuario('becas', toba::usuario()->get_id(), array('becario'));
		} catch (toba_error_db $e) {
			if($e->get_sqlstate() != 'db_23505'){
				toba::notificacion()->agregar('Ocurrio un error al intentar asignar los perfiles correspondientes. Por favor, comuniquese con las Secretaría General de Ciencia y Técnica.');	
			}
		}
	}
	
?>