<?php if($datos['publicar_adm'] == 'S') : ?>
<div>
	<fieldset>
		<legend>Admisibilidad</legend>
		<div id="info_admisibilidad">
			<p class="caja_info_warning">
				<u>ADMISIBILIDAD</u>: La admisibilidad es el proceso donde se verifica que el postulante cumpla con todas las condiciones y requisitos necesarios (establecidos en el <a href="http://www.unne.edu.ar/component/joomdoc/trabajando/becas-de-investigacion/nuevo-reglamento-de-becas-investigacion/download?Itemid=491" target="_BLANK">Reglamento</a>).&nbsp;Plazo para la presentaci&oacute;n de pedidos de reconsideraci&oacute;n: martes 9 de octubre 2018 por Mesa de Entrada y Salida de Rectorado con nota dirigida a la Dra. Leoni, Mar&iacute;a Silvia.
			</p>
		</div>

		<div style='font-size: 1.2em;'>
			<?php switch ($datos['admisibilidad']['admisible']) {
				case 'S':
					$admisible = 'Solicitud admitida';
					break;
				case 'N':
					$admisible = 'Solicitud no admitida';
					break;
				case NULL: 
					$admisible = 'La solicitud todavía no pasó por el proceso de admisibilidad';
			}
			?>
			<p style='font-size:1.4em;'><b><u>Estado de la solicitud:</u></b> <?php echo $admisible; ?></p>
			<?php if($datos['admisibilidad']['admisible'] == 'N') : ?>
			<p><b><u>Motivo por el cual no fue admitido:</u></b> 
				<span style='color:#922323;'><?php echo $datos['admisibilidad']['observaciones']; ?></span>
			</p> 
			<?php endif; ?>
		</div>
	</fieldset>
</div>
<?php else: ?>
<h1 style="text-align: center;">No hay movimientos de la solicitud para mostrar</h1>
<?php endif; ?>


<?php if($datos['publicar_res'] == 'S') : ?>
<br><br>
<?php if($datos['dictamen']) : ?>
	<fieldset>
		<legend>Comisión Asesora</legend>
		<div style='font-size: 1.5em; padding-left: 20px; color:#39397d;'>
		<?php $puntaje_inicial = ($datos['dictamen']['puntaje_inicial'] > 0) ? $datos['dictamen']['puntaje_inicial'] : 0; ?>
			<p><u><b>Puntaje por antecedentes académicos:</b></u> <?php echo $puntaje_inicial; ?></p>
			<p><u><b>Puntaje asignado por Comisión Asesora:</b></u> <?php echo ($datos['dictamen']['puntaje_comision']) ? $datos['dictamen']['puntaje_comision'] : 'No evaluado'; ?></p>
			<p><u><b>Justificación de los puntajes asignados:</b></u> <?php echo $datos['dictamen']['justificacion_comision']; ?></p>
			<p>
				<u><b>Participaron de la evaluación:</b></u>
				<ul>
					<?php foreach(explode('/',$datos['dictamen']['evaluadores']) as $evaluador): ?>
					<li><?php echo $evaluador; ?></li>
					<?php endforeach; ?>
				</ul>
			</p>
		</div>
		</fieldset>
		<br><br>
		<fieldset>
			<legend>Junta Coordinadora</legend>
			<div style='font-size: 1.5em; padding-left: 20px; color:#39397d;'>
				<p><u><b>Puntaje asignado por Junta Coordinadora:</b></u> <?php echo ($datos['dictamen']['puntaje_junta']) ? $datos['dictamen']['puntaje_junta'] : 'La Junta Coordinadora ratificó el puntaje asignado por la Comisión asesora ('.$datos['dictamen']['puntaje_comision'].')'; ?></p>
				<?php if($datos['dictamen']['justificacion_junta']) : ?>
					<p>
						<u><b>Justificación de los puntajes asignados:</b></u> <?php echo $datos['dictamen']['justificacion_junta']; ?>
					</p>
				<?php endif; ?>
			</div>
		</fieldset>
		


		<?php $puntos = ($datos['dictamen']['puntaje_junta']) ? 
			$datos['dictamen']['puntaje_junta'] + $puntaje_inicial :
			$datos['dictamen']['puntaje_comision'] + $puntaje_inicial ;

		 ?>
		<h2 style="text-align: center; color:#F11; text-shadow: 0px 0px 2px #848484; background-color:#FFF; font-size: 2.5em;">Puntaje Total Alcanzado: <?php echo $puntos; ?> puntos.
		</h2>

	

<?php endif; ?>
<?php endif; ?>