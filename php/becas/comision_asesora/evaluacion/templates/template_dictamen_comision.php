<table id='tabla_dictamen_comision'>
	<?php foreach($dictamen_detalles as $criterio): ?>
		<tr>
			<td style='text-align:right;'><b><?php echo $criterio['criterio_evaluacion']; ?></b>:</td>
			<td><?php echo $criterio['asignado']; ?> (M�ximo: <?php echo $criterio['puntaje_maximo']; ?>)</td>
		</tr>
		<?php $asignado += $criterio['asignado']; ?>
	<?php endforeach; ?>

	<tr>
		<td style='text-align:right;'><b>Justificaci�n de Puntajes asignados</b>:</td>
		<td><?php echo $dictamen['justificacion_puntajes']; ?></td>
	</tr>
	<?php $asignado += $puntaje; ?>
	<tr style='background-color: #7eff88; padding: 2px 0px 2px 0px'>
		<td style='text-align:right;'><b>Puntaje final de comisi�n:</b></td>
		<td style='font-weight: 1.1em; font-weight: bold; padding-left: 6px;'><?php echo $asignado; ?></td>
	</tr>
</table>
<?php if(isset($dictamen['evaluadores'])): ?>
Participaron de la evaluaci�n:
<ul>
<?php foreach(explode('/',$dictamen['evaluadores']) as $evaluador): ?>
	<li ><?php echo $evaluador; ?></li>
<?php endforeach; ?>
</ul>
(La evaluaci�n se realiz� con el usuario <?php echo $dictamen['usuario_id']; ?> (<?php echo $dictamen['usuario']; ?>))
<?php endif; ?>