<table id='tabla_dictamen_comision'>
	<?php foreach($dictamen_comision as $criterio): ?>
		<tr>
			<td style='text-align:right;'><b><?php echo $criterio['criterio_evaluacion']; ?></b>:</td>
			<td><?php echo $criterio['asignado']; ?> (Máximo: <?php echo $criterio['puntaje_maximo']; ?>)</td>
		</tr>
		<?php $asignado += $criterio['asignado']; ?>
	<?php endforeach; ?>

	<tr>
		<td style='text-align:right;'><b>Justificación de Puntajes asignados</b>:</td>
		<td><?php echo $dictamen_comision[0]['justificacion_puntajes']; ?></td>
	</tr>
	<?php $asignado += $puntaje; ?>
	<tr style='background-color: #7eff88; padding: 2px 0px 2px 0px'>
		<td style='text-align:right;'><b>Puntaje final de comisión:</b></td>
		<td style='font-weight: 1.1em; font-weight: bold; padding-left: 6px;'><?php echo $asignado; ?></td>
	</tr>
</table>