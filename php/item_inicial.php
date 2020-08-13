<?php
	$usuario = toba::usuario()->get_id();
	//$archivos = toba::consulta_php('helper_archivos')->get_recibos_sueldo('28666208');
	$archivos = toba::consulta_php('helper_archivos')->get_recibos_sueldo($usuario);
	if(count($archivos)){

		echo "<table id='tabla_recibos'>
		<caption> Recibos de sueldo disponibles</caption>
		<th>Nro. Recibo</th><th>Fecha</th><th>Descargar</th>";
		foreach($archivos as $archivo){
			$partes = explode('_',$archivo);
			$fecha = str_replace('.pdf','',$partes[2]);
			
			echo "<tr><td>{$partes[1]}</td><td>$fecha</td>";
			echo "<td><a href='/documentos/recibos_sueldo/$archivo' target='_BLANK' rel='noopener noreferrer'>Click Aquí</a></td>";
		}
		echo "</table>";
	}
	echo "<div id='logo_inicio'>";
	echo '<h1 style="color:#3c84ce; text-shadow: 0px 0px 1px #77A;">Bienvenido</h1>';		
	echo '<h3 style="color:#222; text-shadow: 0px 0px 1px #777;">Sistema de Gesti&oacute;n de Becas - SGCyT - UNNE</h3>';
	echo '<div class="logo" style="margin-top:60px">';
	echo toba_recurso::imagen_proyecto('logo_grande.gif', true);
	echo '</div>';
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