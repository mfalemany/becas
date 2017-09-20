<?php
	// Si existe notificación pendiente, se muestra en pantallaensa
	$mensaje = toba::memoria()->get_dato("mensaje");
	if (isset($mensaje)) {
		toba::notificacion()->agregar($mensaje,'info');
		toba::memoria()->eliminar_dato("mensaje");
	}
	echo '<h1 style="color:#3c84ce; text-shadow: 0px 0px 1px #77A;">Bienvenido</h1>';		
	echo '<h3 style="color:#222; text-shadow: 0px 0px 1px #777;">Sistema de Gesti&oacute;n de Becas - SGCyT - UNNE</h3>';
	echo '<div class="logo" style="margin-top:60px">';
	echo toba_recurso::imagen_proyecto('logo_grande.gif', true);
	echo '</div>';
?>