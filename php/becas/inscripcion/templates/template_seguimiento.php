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




<?php if(count($datos['dictamen']['comision']['detalles'])) : ?>
	<br><br>
	<fieldset>
		<legend>Comisión Asesora</legend>
		<div style='font-size: 1.5em; padding-left: 20px; color:#39397d;'>

		<?php $puntaje_inicial = ($datos['inscripcion']['puntaje'] > 0) ? $datos['inscripcion']['puntaje'] : 0; ?>

		<p><u><b>Puntaje por antecedentes académicos:</b></u> <?php echo $puntaje_inicial; ?></p>
		<p>
			<u><b>Puntaje asignado por Comisión Asesora:</b></u> 
			<ul>
				<?php $puntaje_comision = 0; ?>
				<?php foreach($datos['dictamen']['comision']['detalles'] as $detalle): ?>
				<li><b><?php echo $detalle['criterio_evaluacion']; ?></b>: 
					<?php echo $detalle['puntaje']; ?> puntos (de un máximo de 
					<?php echo $detalle['puntaje_maximo']; ?>)
					<?php $puntaje_comision += $detalle['puntaje']; ?>
				</li>
				<?php endforeach; ?>
			</ul>
		</p>
		<p>
			<u><b>Justificación de los puntajes asignados:</b></u> 
			<?php echo $datos['dictamen']['comision']['justificacion']; ?>
		</p>
		<?php if(count($datos['dictamen']['comision']['evaluadores'])) : ?>
		<p>
			<u><b>Participaron de la evaluación:</b></u>
			<ul>
				<?php foreach(explode('/',$datos['dictamen']['comision']['evaluadores']) as $evaluador): ?>
				<li><?php echo $evaluador; ?></li>
				<?php endforeach; ?>
			</ul>
		</p>
		<?php endif; ?>
	</div>
	</fieldset>
<?php endif; ?>
<?php if(count($datos['dictamen']['junta']['detalles'])) : ?>
	<br><br>
	<fieldset>
		<legend>Junta Coordinadora</legend>
		<div style='font-size: 1.5em; padding-left: 20px; color:#39397d;'>
			<p>
			<u><b>Puntaje asignado por Junta Coordinadora:</b></u> 
			<ul>
				<?php $puntaje_junta = 0; ?>
				<?php foreach($datos['dictamen']['junta']['detalles'] as $detalle): ?>
				<li><b><?php echo $detalle['criterio_evaluacion']; ?></b>: 
					<?php echo $detalle['puntaje']; ?> puntos (de un máximo de 
					<?php echo $detalle['puntaje_maximo']; ?>)
					<?php $puntaje_junta += $detalle['puntaje']; ?>
				</li>
				<?php endforeach; ?>
			</ul>
			<p>
				<u><b>Justificación de los puntajes asignados:</b></u> 
				<?php echo $datos['dictamen']['junta']['justificacion']; ?>
			</p>
		</p>
		</div>
	</fieldset>
<?php endif; ?>		



<?php 
	if(count($datos['dictamen']['comision']['detalles'])) :
		$puntos = (isset($puntaje_junta)) ? ($puntaje_junta+$puntaje_inicial) : ($puntaje_comision+$puntaje_inicial);
 ?>
<h2 style="text-align: center; color:#F11; text-shadow: 0px 0px 2px #848484; background-color:#FFF; font-size: 2.5em;">Puntaje Total Alcanzado: <?php echo $puntos; ?> puntos.
		</h2>

<?php endif; ?>