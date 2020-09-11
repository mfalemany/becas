<div>
	<fieldset>
		<legend>Avales de la Postulaci�n</legend>
		<div style='font-size: 1.2em;'>
			<p>Aval de el/la director/a de la beca:	
				<span class="etiqueta_info"><?php echo $this->get_estado_aval_desc($datos['estado_aval'], 'aval_director'); ?></span>
			</p>
			<p>Aval de la Secretar�a de Investigaci�n:	
				<span class="etiqueta_info"><?php echo $this->get_estado_aval_desc($datos['estado_aval'], 'aval_secretaria'); ?></span>
			</p>
			<p>Aval del Decanato:	
				<span class="etiqueta_info"><?php echo $this->get_estado_aval_desc($datos['estado_aval'], 'aval_decanato'); ?></span>
			</p>
		</div>
		
	</fieldset>
</div>
<?php if($datos['publicar_adm'] == 'S') : ?>
<?php setlocale(LC_TIME,'es_AR.UTF-8');?>
<div>
	<fieldset>
		<legend>Admisibilidad</legend>
		<div id="info_admisibilidad">
			<p class="caja_info_warning">
				<u>ADMISIBILIDAD</u>: La admisibilidad es el proceso donde se verifica que el postulante cumpla con todas las condiciones y requisitos necesarios (establecidos en el <a href="http://www.unne.edu.ar/component/joomdoc/trabajando/becas-de-investigacion/nuevo-reglamento-de-becas-investigacion/download?Itemid=491" target="_BLANK">Reglamento</a>).&nbsp;Plazo para la presentaci&oacute;n de pedidos de reconsideraci&oacute;n: <?php echo strftime('%A %d de %B de %Y',strtotime($datos['fecha_limite_reconsideracion'])); ?> por Mesa de Entrada y Salida de Rectorado con nota dirigida a <?php echo ($datos['genero_secretario'] == 'M') ? 'el' : 'la'; ?> <?php echo $datos['nombre_secretario']; ?>
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
					$admisible = 'La solicitud todav�a no pas� por el proceso de admisibilidad';
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
<!-- <h1 style="text-align: center;">No hay movimientos de la solicitud para mostrar</h1> -->
<?php endif; ?>

<?php if($datos['publicar_res'] == 'S') : ?>
	<?php if(count($datos['dictamen']['comision']['detalles'])) : ?>
		<br><br>
		<fieldset>
			<legend>Comisi�n Asesora</legend>
			<div style='font-size: 1.5em; padding-left: 20px; color:#39397d;'>

			<?php $puntaje_inicial = ($datos['inscripcion']['puntaje'] > 0) ? $datos['inscripcion']['puntaje'] : 0; ?>

			<p><u><b>Puntaje por antecedentes acad�micos:</b></u> <?php echo $puntaje_inicial; ?></p>
			<p>
				<u><b>Puntaje asignado por Comisi�n Asesora:</b></u> 
				<ul>
					<?php $puntaje_comision = 0; ?>
					<?php foreach($datos['dictamen']['comision']['detalles'] as $detalle): ?>
					<li><b><?php echo $detalle['criterio_evaluacion']; ?></b>: 
						<?php echo $detalle['puntaje']; ?> puntos (de un m�ximo de 
						<?php echo $detalle['puntaje_maximo']; ?>)
						<?php $puntaje_comision += $detalle['puntaje']; ?>
					</li>
					<?php endforeach; ?>
				</ul>
			</p>
			<p>
				<u><b>Justificaci�n de los puntajes asignados:</b></u> 
				<?php echo $datos['dictamen']['comision']['justificacion']; ?>
			</p>
			<?php if(count($datos['dictamen']['comision']['evaluadores'])) : ?>
			<p>
				<u><b>Participaron de la evaluaci�n:</b></u>
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
						<?php echo $detalle['puntaje']; ?> puntos (de un m�ximo de 
						<?php echo $detalle['puntaje_maximo']; ?>)
						<?php $puntaje_junta += $detalle['puntaje']; ?>
					</li>
					<?php endforeach; ?>
				</ul>
				<p>
					<u><b>Justificaci�n de los puntajes asignados:</b></u> 
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

	<?php $color = ($datos['admisibilidad']['beca_otorgada'] == 'S') ? '#17a50e' : '#F11'; ?>
	<h2 style="text-align: center; color:<?php echo $color; ?>; text-shadow: 0px 0px 2px #848484; background-color:#FFF; font-size: 2.5em;">
		<?php echo ($datos['admisibilidad']['beca_otorgada'] == 'S') ? 'Beca Otorgada! ' : 'Beca NO otorgada. '; ?>
		Puntaje Total Alcanzado: <?php echo $puntos; ?> puntos.
	</h2>
	<?php endif; ?>
	<br><br>
	<?php if(count($datos['cumplimientos'])): ?>
		<fieldset>
			<legend>Cumplimiento de Obligaciones</legend>
			<div style='font-size: 1.5em; padding-left: 20px; color:#39397d;'>
				<p>Las obligaciones de los meses que se detallan a continuaci�n fueron marcados por su director como cumplidas.</p>
			</div>
			<ul>
				<?php foreach($datos['cumplimientos'] as $cumplimiento): ?>
					<li style="font-size: 1.1em; font-weight: bold; padding: 4px 0px;">
						<?php echo $this->get_mes_desc($cumplimiento['mes']); ?> de <?php echo $cumplimiento['anio'] ?>
					</li>
				<?php endforeach; ?>		
			</ul>
			
		</fieldset>
	<?php endif; ?>

<?php endif; ?>	

