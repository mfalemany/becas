------------------------------------------------------------
--[4584]--  Carga Masiva 
------------------------------------------------------------

------------------------------------------------------------
-- apex_objeto
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto (proyecto, objeto, anterior, identificador, reflexivo, clase_proyecto, clase, punto_montaje, subclase, subclase_archivo, objeto_categoria_proyecto, objeto_categoria, nombre, titulo, colapsable, descripcion, fuente_datos_proyecto, fuente_datos, solicitud_registrar, solicitud_obj_obs_tipo, solicitud_obj_observacion, parametro_a, parametro_b, parametro_c, parametro_d, parametro_e, parametro_f, usuario, creacion, posicion_botonera) VALUES (
	'becas', --proyecto
	'4584', --objeto
	NULL, --anterior
	NULL, --identificador
	NULL, --reflexivo
	'toba', --clase_proyecto
	'toba_ci', --clase
	'22', --punto_montaje
	'ci_carga_masiva', --subclase
	'becas/becas_otorgadas/externas/ci_carga_masiva.php', --subclase_archivo
	NULL, --objeto_categoria_proyecto
	NULL, --objeto_categoria
	'Carga Masiva', --nombre
	NULL, --titulo
	'0', --colapsable
	NULL, --descripcion
	NULL, --fuente_datos_proyecto
	NULL, --fuente_datos
	NULL, --solicitud_registrar
	NULL, --solicitud_obj_obs_tipo
	NULL, --solicitud_obj_observacion
	NULL, --parametro_a
	NULL, --parametro_b
	NULL, --parametro_c
	NULL, --parametro_d
	NULL, --parametro_e
	NULL, --parametro_f
	NULL, --usuario
	'2020-09-08 20:03:23', --creacion
	'abajo'  --posicion_botonera
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_mt_me
------------------------------------------------------------
INSERT INTO apex_objeto_mt_me (objeto_mt_me_proyecto, objeto_mt_me, ev_procesar_etiq, ev_cancelar_etiq, ancho, alto, posicion_botonera, tipo_navegacion, botonera_barra_item, con_toc, incremental, debug_eventos, activacion_procesar, activacion_cancelar, ev_procesar, ev_cancelar, objetos, post_procesar, metodo_despachador, metodo_opciones) VALUES (
	'becas', --objeto_mt_me_proyecto
	'4584', --objeto_mt_me
	NULL, --ev_procesar_etiq
	NULL, --ev_cancelar_etiq
	NULL, --ancho
	NULL, --alto
	NULL, --posicion_botonera
	NULL, --tipo_navegacion
	'0', --botonera_barra_item
	'0', --con_toc
	NULL, --incremental
	NULL, --debug_eventos
	NULL, --activacion_procesar
	NULL, --activacion_cancelar
	NULL, --ev_procesar
	NULL, --ev_cancelar
	NULL, --objetos
	NULL, --post_procesar
	NULL, --metodo_despachador
	NULL  --metodo_opciones
);

------------------------------------------------------------
-- apex_objeto_dependencias
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'3328', --dep_id
	'4584', --objeto_consumidor
	'4586', --objeto_proveedor
	'datos', --identificador
	NULL, --parametros_a
	NULL, --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	NULL  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'3325', --dep_id
	'4584', --objeto_consumidor
	'4585', --objeto_proveedor
	'form_carga_masiva', --identificador
	NULL, --parametros_a
	NULL, --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	NULL  --orden
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_ci_pantalla
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_ci_pantalla (objeto_ci_proyecto, objeto_ci, pantalla, identificador, orden, etiqueta, descripcion, tip, imagen_recurso_origen, imagen, objetos, eventos, subclase, subclase_archivo, template, template_impresion, punto_montaje) VALUES (
	'becas', --objeto_ci_proyecto
	'4584', --objeto_ci
	'2001', --pantalla
	'pant_inicial', --identificador
	'1', --orden
	'Pantalla Inicial', --etiqueta
	NULL, --descripcion
	NULL, --tip
	'apex', --imagen_recurso_origen
	NULL, --imagen
	NULL, --objetos
	NULL, --eventos
	NULL, --subclase
	NULL, --subclase_archivo
	'<table align="center" border="1" cellpadding="1" cellspacing="1" style="width: 50%">
	<caption>
		<span style="font-size:16px;"><strong>Formato del archivo que debe cargar</strong></span></caption>
	<tbody>
		<tr>
			<td style="text-align: center; background-color: rgb(255, 255, 102);">
				<strong><span style="font-size:16px;">nro_documento</span></strong></td>
			<td style="text-align: center; background-color: rgb(255, 255, 102);">
				<strong><span style="font-size:16px;">nro_documento_dir</span></strong></td>
			<td style="text-align: center;">
				<strong><span style="font-size:16px;">nro_documento_codir</span></strong></td>
			<td style="text-align: center;">
				<strong><span style="font-size:16px;">condicion</span></strong></td>
		</tr>
		<tr>
			<td style="text-align: center;">
				<span style="font-size:16px;">32405039</span></td>
			<td style="text-align: center;">
				<span style="font-size:16px;">17248342</span></td>
			<td style="text-align: center;">
				<span style="font-size:16px;">12125859</span></td>
			<td style="text-align: center;">
				<span style="font-size:16px;">titular</span></td>
		</tr>
		<tr>
			<td style="text-align: center;">
				<span style="font-size:16px;">368686042</span></td>
			<td style="text-align: center;">
				<span style="font-size:16px;">16320605</span></td>
			<td style="text-align: center;">
				&nbsp;</td>
			<td style="text-align: center;">
				<span style="font-size:16px;">suplente</span></td>
		</tr>
	</tbody>
</table>
<div style="font-size:17px; background-color:white;">
	<p>* Los campos resaltados en color amarillo son obligatorios (el archivo debe contener esa columna, y sus valores no pueden estar vac&iacute;os).</p><p>Deben respetarse los nombres de las columnas, tal como se indica en el cuadro de arriba. El orden de las columnas puede variar, pero no sus nombres (el sistema utiliza las cabeceras de columnas para identificar cada campo). La primera fila del archivo es considerada como cabeceras.</p><p>El formato del archivo cargado debe ser .CSV (puede abrir cualquier Excel, y luego hacer click en &quot;Guardar Como&quot;&nbsp; y elegir el formato CSV).</p><p>Los n&uacute;meros de documento no deben contener puntos (aunque si los contiene, el sistema los eliminar&aacute;).</p><p>&nbsp;</p><p>&nbsp;</p></div>
<p>[dep id=form_carga_masiva]</p>', --template
	NULL, --template_impresion
	NULL  --punto_montaje
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objetos_pantalla
------------------------------------------------------------
INSERT INTO apex_objetos_pantalla (proyecto, pantalla, objeto_ci, orden, dep_id) VALUES (
	'becas', --proyecto
	'2001', --pantalla
	'4584', --objeto_ci
	'0', --orden
	'3325'  --dep_id
);
