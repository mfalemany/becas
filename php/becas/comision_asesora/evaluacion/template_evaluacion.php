<div id="evaluacion_beca">
	<div id="datos_beca">
		<div>
			<div id='titulo_plan_beca'>{{titulo_plan_beca}}</div>
		</div>
		<div id="proyecto_acreditado">
			<p>El Plan de Beca propuesto estará incluido en el siguiente Proyecto de Investigación Acreditado:</p>
			<p id='proyecto_nombre'>{{proyecto_nombre}}
			</p>
		</div>
		<table class='tabla' id='tabla_resumen_beca'>
			<caption>Detalles de la solicitud</caption>
			<tr>
				<td>Nombre del Postulante:</td><td colspan="3">{{nombre_postulante}} ({{cuil}})</td>
			</tr>
			<tr>
				<td>Estudiante/Egresado de:</td><td colspan="3">{{carrera}}</td>
			</tr>
			<tr>
				<td>Tipo de Beca:</td><td>{{tipo_beca}}</td>
				<td>Carpeta Nro:</td><td>{{nro_carpeta}}</td>
			</tr>
			<tr>	
				<td>Área de Conocimiento</td><td colspan="3">{{area_conocimiento}}</td>
			</tr>
		</table>
	</div>
	<div id="plan_trabajo">
		<a href="{{enlace_plan_trab}}" target="_BLANK">Descargar el Plan de Trabajo</a>	
	</div>
	<div id="direccion">
		{{direccion}}
	</div>
	
	<div id="antecedentes">
		[dep id=cu_actividades_docentes]
		<br>
		[dep id=cu_estudios_afines]
		<br>
		[dep id=cu_becas_obtenidas]
		<br>
		[dep id=cu_trabajos_publicados]
		<br>
		[dep id=cu_present_reuniones]
		<br>
		[dep id=cu_idiomas]
		<br>
		[dep id=cu_otras_actividades]
		<br>
		[dep id=cu_part_dict_cursos]
		<br>
		[dep id=cu_cursos_perfeccionamiento]
	</div>
</div>