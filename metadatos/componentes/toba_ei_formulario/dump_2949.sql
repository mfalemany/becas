------------------------------------------------------------
--[2949]--  Inscripci�n - Form 
------------------------------------------------------------

------------------------------------------------------------
-- apex_objeto
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto (proyecto, objeto, anterior, identificador, reflexivo, clase_proyecto, clase, punto_montaje, subclase, subclase_archivo, objeto_categoria_proyecto, objeto_categoria, nombre, titulo, colapsable, descripcion, fuente_datos_proyecto, fuente_datos, solicitud_registrar, solicitud_obj_obs_tipo, solicitud_obj_observacion, parametro_a, parametro_b, parametro_c, parametro_d, parametro_e, parametro_f, usuario, creacion, posicion_botonera) VALUES (
	'becas', --proyecto
	'2949', --objeto
	NULL, --anterior
	NULL, --identificador
	NULL, --reflexivo
	'toba', --clase_proyecto
	'toba_ei_formulario', --clase
	'22', --punto_montaje
	'form_inscripcion', --subclase
	'becas/inscripcion/formularios/form_inscripcion.php', --subclase_archivo
	NULL, --objeto_categoria_proyecto
	NULL, --objeto_categoria
	'Inscripci�n - Form', --nombre
	'Formulario de Inscripci�n', --titulo
	'0', --colapsable
	NULL, --descripcion
	'becas', --fuente_datos_proyecto
	'sap', --fuente_datos
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
	'2017-10-13 09:19:47', --creacion
	'abajo'  --posicion_botonera
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_eventos
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_eventos (proyecto, evento_id, objeto, identificador, etiqueta, maneja_datos, sobre_fila, confirmacion, estilo, imagen_recurso_origen, imagen, en_botonera, ayuda, orden, ci_predep, implicito, defecto, display_datos_cargados, grupo, accion, accion_imphtml_debug, accion_vinculo_carpeta, accion_vinculo_item, accion_vinculo_objeto, accion_vinculo_popup, accion_vinculo_popup_param, accion_vinculo_target, accion_vinculo_celda, accion_vinculo_servicio, es_seleccion_multiple, es_autovinculo) VALUES (
	'becas', --proyecto
	'1928', --evento_id
	'2949', --objeto
	'modificacion', --identificador
	NULL, --etiqueta
	'1', --maneja_datos
	'0', --sobre_fila
	NULL, --confirmacion
	NULL, --estilo
	'apex', --imagen_recurso_origen
	NULL, --imagen
	'0', --en_botonera
	NULL, --ayuda
	'1', --orden
	NULL, --ci_predep
	'1', --implicito
	'0', --defecto
	NULL, --display_datos_cargados
	NULL, --grupo
	NULL, --accion
	NULL, --accion_imphtml_debug
	NULL, --accion_vinculo_carpeta
	NULL, --accion_vinculo_item
	NULL, --accion_vinculo_objeto
	NULL, --accion_vinculo_popup
	NULL, --accion_vinculo_popup_param
	NULL, --accion_vinculo_target
	NULL, --accion_vinculo_celda
	NULL, --accion_vinculo_servicio
	'0', --es_seleccion_multiple
	'0'  --es_autovinculo
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_ut_formulario
------------------------------------------------------------
INSERT INTO apex_objeto_ut_formulario (objeto_ut_formulario_proyecto, objeto_ut_formulario, tabla, titulo, ev_agregar, ev_agregar_etiq, ev_mod_modificar, ev_mod_modificar_etiq, ev_mod_eliminar, ev_mod_eliminar_etiq, ev_mod_limpiar, ev_mod_limpiar_etiq, ev_mod_clave, clase_proyecto, clase, auto_reset, ancho, ancho_etiqueta, expandir_descripcion, campo_bl, scroll, filas, filas_agregar, filas_agregar_online, filas_agregar_abajo, filas_agregar_texto, filas_borrar_en_linea, filas_undo, filas_ordenar, filas_ordenar_en_linea, columna_orden, filas_numerar, ev_seleccion, alto, analisis_cambios, no_imprimir_efs_sin_estado, resaltar_efs_con_estado, template, template_impresion) VALUES (
	'becas', --objeto_ut_formulario_proyecto
	'2949', --objeto_ut_formulario
	NULL, --tabla
	NULL, --titulo
	NULL, --ev_agregar
	NULL, --ev_agregar_etiq
	NULL, --ev_mod_modificar
	NULL, --ev_mod_modificar_etiq
	NULL, --ev_mod_eliminar
	NULL, --ev_mod_eliminar_etiq
	NULL, --ev_mod_limpiar
	NULL, --ev_mod_limpiar_etiq
	NULL, --ev_mod_clave
	NULL, --clase_proyecto
	NULL, --clase
	NULL, --auto_reset
	'100%', --ancho
	'150px', --ancho_etiqueta
	'1', --expandir_descripcion
	NULL, --campo_bl
	NULL, --scroll
	NULL, --filas
	NULL, --filas_agregar
	'1', --filas_agregar_online
	'0', --filas_agregar_abajo
	NULL, --filas_agregar_texto
	'0', --filas_borrar_en_linea
	NULL, --filas_undo
	NULL, --filas_ordenar
	'0', --filas_ordenar_en_linea
	NULL, --columna_orden
	NULL, --filas_numerar
	NULL, --ev_seleccion
	NULL, --alto
	NULL, --analisis_cambios
	'0', --no_imprimir_efs_sin_estado
	'0', --resaltar_efs_con_estado
	'<fieldset>
	<legend>Datos de la Beca</legend>
	<table>
		<tbody>
			<tr>
				<td colspan="2">
					[ef id=id_convocatoria]</td>
			</tr>
			<tr>
				<td colspan="2">
					[ef id=id_tipo_beca]</td>
			</tr>
			<tr>
				<td colspan="2">
					[ef id=id_area_conocimiento]</td>
			</tr>
			<tr>
				<td colspan="2">
					<p id="disciplinas_incluidas">&nbsp;</p></td>
			</tr>
			<tr>
				<td colspan="2">
					[ef id=titulo_plan_beca]</td>
			</tr>
			<tr>
				<td colspan="2">
					<b>El Plan de Beca propuesto estar&aacute; incluido en el siguiente Proyecto de Investigaci&oacute;n Acreditado</b></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					[ef id=id_proyecto]</td>
			</tr>
			<tr>
				<td colspan="2">
					[ef id=lugar_trabajo_becario]</td>
			</tr>
			<tr>
				<td>
					[ef id=id_grupo]</td>
			</tr>
		</tbody>
	</table>
</fieldset>
<p>&nbsp;</p>
<fieldset>
	<legend>Datos del Alumno</legend>
	<table>
		<tbody>
			<tr>
				<td>
					[ef id=nro_documento]</td>
				<td>
					&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
					[ef id=id_dependencia]</td>
			</tr>
			<tr>
				<td>
					[ef id=id_carrera]</td>
				<td>
					&nbsp;</td>
			</tr>
			<tr>
				<td>
					[ef id=anio_ingreso]</td>
				<td>
					&nbsp;</td>
			</tr>
			<tr>
				<td>
					[ef id=materias_plan]</td>
				<td>
					[ef id=materias_aprobadas]</td>
			</tr>
			<tr>
				<td>
					[ef id=prom_hist_egresados]</td>
				<td>
					[ef id=prom_hist]</td>
			</tr>
			<tr>
				<td>
					[ef id=archivo_analitico]</td>
				<td style="vertical-align: middle;">
					(Cert. Anal&iacute;tico firmado por la Dir. Gesti&oacute;n Estudios)</td>
			</tr>
		</tbody>
	</table>
</fieldset>
<p>&nbsp;</p>
<fieldset>
	<legend>Inscripci&oacute;n/Compromiso a carrera de posgrado (Aplicable solo a algunos tipos de becas)</legend>
	<table>
		<tbody>
			<tr>
				<td>
					[ef id=carrera_posgrado]</td>
				<td>
					[ef id=nombre_inst_posgrado]</td>
			</tr>
			<tr>
				<td>
					[ef id=titulo_carrera_posgrado]</td>
				<td>
					[ef id=fecha_insc_posgrado]</td>
			</tr>
			<tr>
				<td>
					[ef id=archivo_insc_posgrado]</td>
				<td>
					Debe cargar el comprobante de inscripci&oacute;n a una carrera de posgrado, o bien el compromiso de inscripci&oacute;n firmado. Puede descargar el modelo de compromiso haciendo click <a href="http://becas.cyt.unne.edu.ar/documentos/becas/estaticos/compromiso_posgrado.pdf" target="_BLANK">aqu&iacute;</a></td>
			</tr>
		</tbody>
	</table>
</fieldset>
<p>&nbsp;</p>
<fieldset>
	<legend>Datos del Director</legend>
	<table>
		<tbody>
			<tr>
				<td>
					[ef id=nro_documento_dir]</td>
				<td>
					&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
					[ef id=director]</td>
			</tr>
		</tbody>
	</table>
</fieldset>
<p>&nbsp;</p>
<fieldset>
	<legend>Datos del Co-Director</legend>
	<table>
		<tbody>
			<tr>
				<td>
					[ef id=nro_documento_codir]</td>
				<td>
					&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
					[ef id=codirector]</td>
			</tr>
		</tbody>
	</table>
</fieldset>
<p>&nbsp;</p>
<fieldset>
	<legend>Datos del Sub-Director</legend>
	<table>
		<tbody>
			<tr>
				<td>
					[ef id=nro_documento_subdir]</td>
				<td>
					&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
					[ef id=subdirector]</td>
			</tr>
		</tbody>
	</table>
</fieldset>
<p>&nbsp;</p>', --template
	NULL  --template_impresion
);

------------------------------------------------------------
-- apex_objeto_ei_formulario_ef
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6245', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'id_convocatoria', --identificador
	'ef_combo', --elemento_formulario
	'id_convocatoria', --columnas
	'1', --obligatorio
	'1', --oculto_relaja_obligatorio
	'1', --orden
	'Convocatoria', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	'31', --carga_consulta_php
	NULL, --carga_sql
	'sap', --carga_fuente
	NULL, --carga_lista
	'id_convocatoria', --carga_col_clave
	'convocatoria', --carga_col_desc
	NULL, --carga_maestros
	'0', --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'1', --carga_permite_no_seteado
	'--Seleccione--', --carga_no_seteado
	'0', --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	'22', --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6246', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'id_tipo_beca', --identificador
	'ef_combo', --elemento_formulario
	'id_tipo_beca', --columnas
	'1', --obligatorio
	'1', --oculto_relaja_obligatorio
	'2', --orden
	'Tipo Beca', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	'get_tipos_beca_por_convocatoria', --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	'38', --carga_consulta_php
	NULL, --carga_sql
	'sap', --carga_fuente
	NULL, --carga_lista
	'id_tipo_beca', --carga_col_clave
	'tipo_beca', --carga_col_desc
	'id_convocatoria', --carga_maestros
	'0', --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'1', --carga_permite_no_seteado
	'-- Seleccione --', --carga_no_seteado
	'0', --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	'22', --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6247', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'id_dependencia', --identificador
	'ef_combo', --elemento_formulario
	'id_dependencia', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'3', --orden
	'Facultad/Instituto', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	'get_univ_dependencias', --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	'20', --carga_consulta_php
	NULL, --carga_sql
	'sap', --carga_fuente
	NULL, --carga_lista
	'id', --carga_col_clave
	'nombre', --carga_col_desc
	NULL, --carga_maestros
	'0', --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'1', --carga_permite_no_seteado
	'-- Seleccione --', --carga_no_seteado
	'0', --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	'22', --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6248', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'nro_documento', --identificador
	'ef_editable', --elemento_formulario
	'nro_documento', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'6', --orden
	'Nro Documento', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	'15', --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6254', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'id_area_conocimiento', --identificador
	'ef_combo', --elemento_formulario
	'id_area_conocimiento', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'7', --orden
	'Area Conocimiento', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	'get_areas_conocimiento_becas', --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	'35', --carga_consulta_php
	NULL, --carga_sql
	'sap', --carga_fuente
	NULL, --carga_lista
	'id', --carga_col_clave
	'nombre', --carga_col_desc
	NULL, --carga_maestros
	'0', --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'1', --carga_permite_no_seteado
	'-- Seleccione --', --carga_no_seteado
	'0', --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	'22', --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6255', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'titulo_plan_beca', --identificador
	'ef_editable_textarea', --elemento_formulario
	'titulo_plan_beca', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'9', --orden
	'Titulo Plan Beca', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	'300', --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	'6', --edit_filas
	'80', --edit_columnas
	NULL, --edit_wrap
	'0', --edit_resaltar
	'0', --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6257', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'id_carrera', --identificador
	'ef_combo', --elemento_formulario
	'id_carrera', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'8', --orden
	'Carrera', --etiqueta
	NULL, --etiqueta_estilo
	'La lista de carreras disponible depende de la facultad que haya elegido.', --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	'get_carreras_por_dependencia', --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	'18', --carga_consulta_php
	NULL, --carga_sql
	'sap', --carga_fuente
	NULL, --carga_lista
	'id_carrera', --carga_col_clave
	'carrera', --carga_col_desc
	'id_dependencia', --carga_maestros
	'0', --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'1', --carga_permite_no_seteado
	'-- Seleccione --', --carga_no_seteado
	'0', --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	'22', --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6258', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'materias_plan', --identificador
	'ef_editable_numero', --elemento_formulario
	'materias_plan', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'10', --orden
	'Cant.Mat. del Plan de Estudios', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	'3', --edit_tamano
	'3', --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6259', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'materias_aprobadas', --identificador
	'ef_editable_numero', --elemento_formulario
	'materias_aprobadas', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'11', --orden
	'Cant. Materias Aprobadas', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	'3', --edit_tamano
	'3', --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6260', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'prom_hist_egresados', --identificador
	'ef_editable_numero', --elemento_formulario
	'prom_hist_egresados', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'12', --orden
	'Prom Hist. Egresados', --etiqueta
	NULL, --etiqueta_estilo
	'Promedio hist�rico de los egresados de los �ltimos 5 (cinco) a�os (incluye materias reprobadas).', --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	'[1..10]', --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6261', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'prom_hist', --identificador
	'ef_editable_numero', --elemento_formulario
	'prom_hist', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'13', --orden
	'Prom Hist. Becario', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	'[1..10]', --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6262', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'carrera_posgrado', --identificador
	'ef_editable', --elemento_formulario
	'carrera_posgrado', --columnas
	'1', --obligatorio
	'1', --oculto_relaja_obligatorio
	'14', --orden
	'Carrera Posgrado', --etiqueta
	NULL, --etiqueta_estilo
	'Carrera de posgrado a la que se encuentra inscripto o se compromete a inscribirse (aplicable solo a becas de Iniciaci�n)', --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	'30', --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6263', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'nombre_inst_posgrado', --identificador
	'ef_editable', --elemento_formulario
	'nombre_inst_posgrado', --columnas
	'1', --obligatorio
	'1', --oculto_relaja_obligatorio
	'16', --orden
	'Universidad (Posgrado)', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	'30', --edit_tamano
	'200', --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6264', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'titulo_carrera_posgrado', --identificador
	'ef_editable', --elemento_formulario
	'titulo_carrera_posgrado', --columnas
	'1', --obligatorio
	'1', --oculto_relaja_obligatorio
	'17', --orden
	'Titulo Carrera Posgrado', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	'30', --edit_tamano
	'200', --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6271', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'nro_documento_dir', --identificador
	'ef_editable', --elemento_formulario
	'nro_documento_dir', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'18', --orden
	'Nro. Documento', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	'15', --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6273', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'nro_documento_codir', --identificador
	'ef_editable', --elemento_formulario
	'nro_documento_codir', --columnas
	'0', --obligatorio
	'0', --oculto_relaja_obligatorio
	'20', --orden
	'Nro. Documento', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	'15', --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6275', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'nro_documento_subdir', --identificador
	'ef_editable', --elemento_formulario
	'nro_documento_subdir', --columnas
	'0', --obligatorio
	'0', --oculto_relaja_obligatorio
	'22', --orden
	'Nro. Documento', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	'15', --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6285', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'id_proyecto', --identificador
	'ef_combo_editable', --elemento_formulario
	'id_proyecto', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'24', --orden
	'T�tulo del Proyecto', --etiqueta
	NULL, --etiqueta_estilo
	'Ingrese cualquier palabra que se encuentre incluida en el t�tulo del proyecto', --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	'get_proyectos', --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	'45', --carga_consulta_php
	NULL, --carga_sql
	'becas', --carga_fuente
	NULL, --carga_lista
	'id', --carga_col_clave
	'descripcion', --carga_col_desc
	NULL, --carga_maestros
	'0', --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	'0', --carga_no_seteado_ocultar
	'600', --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	'get_descripcion', --popup_carga_desc_metodo
	'co_sap_proyectos', --popup_carga_desc_clase
	'consultas/co_sap_proyectos.php', --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	'22', --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6290', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'anio_ingreso', --identificador
	'ef_editable_numero', --elemento_formulario
	'anio_ingreso', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'25', --orden
	'A�o de Ingreso', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	NULL, --colapsado
	NULL, --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	NULL, --permitir_html
	NULL, --deshabilitar_rest_func
	NULL, --estado_defecto
	NULL, --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6292', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'fecha_insc_posgrado', --identificador
	'ef_editable_fecha', --elemento_formulario
	'fecha_insc_posgrado', --columnas
	'0', --obligatorio
	'1', --oculto_relaja_obligatorio
	'15', --orden
	'Fecha Insc. Posgrado', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	NULL, --colapsado
	NULL, --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	NULL, --permitir_html
	NULL, --deshabilitar_rest_func
	NULL, --estado_defecto
	NULL, --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6294', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'lugar_trabajo_becario', --identificador
	'ef_combo', --elemento_formulario
	'lugar_trabajo_becario', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'4', --orden
	'Lugar de Trabajo', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	'get_univ_dependencias', --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	'20', --carga_consulta_php
	NULL, --carga_sql
	'sap', --carga_fuente
	NULL, --carga_lista
	'id', --carga_col_clave
	'nombre', --carga_col_desc
	NULL, --carga_maestros
	'0', --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'1', --carga_permite_no_seteado
	'-- Seleccione --', --carga_no_seteado
	'0', --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	'22', --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6295', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'id_grupo', --identificador
	'ef_combo_editable', --elemento_formulario
	'id_grupo', --columnas
	'0', --obligatorio
	'0', --oculto_relaja_obligatorio
	'5', --orden
	'Grupo de Investigaci�n', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	'get_grupos_combo_editable', --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	'71', --carga_consulta_php
	NULL, --carga_sql
	'sap', --carga_fuente
	NULL, --carga_lista
	'id_grupo', --carga_col_clave
	'denominacion', --carga_col_desc
	NULL, --carga_maestros
	'0', --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	'0', --carga_no_seteado_ocultar
	'600', --edit_tamano
	'300', --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	'get_denominacion_grupo', --popup_carga_desc_metodo
	'co_grupos', --popup_carga_desc_clase
	'consultas/co_grupos.php', --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	'22', --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'6296', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'director', --identificador
	'ef_fijo', --elemento_formulario
	'director', --columnas
	'0', --obligatorio
	'0', --oculto_relaja_obligatorio
	'19', --orden
	'Director', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	'etiqueta_info', --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	'60', --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	'1', --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'8588', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'archivo_analitico', --identificador
	'ef_upload', --elemento_formulario
	'archivo_analitico', --columnas
	'1', --obligatorio
	'0', --oculto_relaja_obligatorio
	'26', --orden
	'Cert. Anal�tico', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	'pdf', --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'8683', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'codirector', --identificador
	'ef_fijo', --elemento_formulario
	'codirector', --columnas
	'0', --obligatorio
	'0', --oculto_relaja_obligatorio
	'21', --orden
	'Co-Director', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	'1', --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'8684', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'subdirector', --identificador
	'ef_fijo', --elemento_formulario
	'subdirector', --columnas
	'0', --obligatorio
	'0', --oculto_relaja_obligatorio
	'23', --orden
	'Sub-Director', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	'1', --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	NULL, --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
INSERT INTO apex_objeto_ei_formulario_ef (objeto_ei_formulario_fila, objeto_ei_formulario, objeto_ei_formulario_proyecto, identificador, elemento_formulario, columnas, obligatorio, oculto_relaja_obligatorio, orden, etiqueta, etiqueta_estilo, descripcion, colapsado, desactivado, estilo, total, inicializacion, permitir_html, deshabilitar_rest_func, estado_defecto, solo_lectura, solo_lectura_modificacion, carga_metodo, carga_clase, carga_include, carga_dt, carga_consulta_php, carga_sql, carga_fuente, carga_lista, carga_col_clave, carga_col_desc, carga_maestros, carga_cascada_relaj, cascada_mantiene_estado, carga_permite_no_seteado, carga_no_seteado, carga_no_seteado_ocultar, edit_tamano, edit_maximo, edit_mascara, edit_unidad, edit_rango, edit_filas, edit_columnas, edit_wrap, edit_resaltar, edit_ajustable, edit_confirmar_clave, edit_expreg, popup_item, popup_proyecto, popup_editable, popup_ventana, popup_carga_desc_metodo, popup_carga_desc_clase, popup_carga_desc_include, popup_puede_borrar_estado, fieldset_fin, check_valor_si, check_valor_no, check_desc_si, check_desc_no, check_ml_toggle, fijo_sin_estado, editor_ancho, editor_alto, editor_botonera, selec_cant_minima, selec_cant_maxima, selec_utilidades, selec_tamano, selec_ancho, selec_serializar, selec_cant_columnas, upload_extensiones, punto_montaje, placeholder) VALUES (
	'8737', --objeto_ei_formulario_fila
	'2949', --objeto_ei_formulario
	'becas', --objeto_ei_formulario_proyecto
	'archivo_insc_posgrado', --identificador
	'ef_upload', --elemento_formulario
	'archivo_insc_posgrado', --columnas
	'1', --obligatorio
	'1', --oculto_relaja_obligatorio
	'27', --orden
	'Constancia de Insc. a Posgrado', --etiqueta
	NULL, --etiqueta_estilo
	NULL, --descripcion
	'0', --colapsado
	'0', --desactivado
	NULL, --estilo
	NULL, --total
	NULL, --inicializacion
	'0', --permitir_html
	'0', --deshabilitar_rest_func
	NULL, --estado_defecto
	'0', --solo_lectura
	'0', --solo_lectura_modificacion
	NULL, --carga_metodo
	NULL, --carga_clase
	NULL, --carga_include
	NULL, --carga_dt
	NULL, --carga_consulta_php
	NULL, --carga_sql
	NULL, --carga_fuente
	NULL, --carga_lista
	NULL, --carga_col_clave
	NULL, --carga_col_desc
	NULL, --carga_maestros
	NULL, --carga_cascada_relaj
	'0', --cascada_mantiene_estado
	'0', --carga_permite_no_seteado
	NULL, --carga_no_seteado
	NULL, --carga_no_seteado_ocultar
	NULL, --edit_tamano
	NULL, --edit_maximo
	NULL, --edit_mascara
	NULL, --edit_unidad
	NULL, --edit_rango
	NULL, --edit_filas
	NULL, --edit_columnas
	NULL, --edit_wrap
	NULL, --edit_resaltar
	NULL, --edit_ajustable
	NULL, --edit_confirmar_clave
	NULL, --edit_expreg
	NULL, --popup_item
	NULL, --popup_proyecto
	NULL, --popup_editable
	NULL, --popup_ventana
	NULL, --popup_carga_desc_metodo
	NULL, --popup_carga_desc_clase
	NULL, --popup_carga_desc_include
	NULL, --popup_puede_borrar_estado
	NULL, --fieldset_fin
	NULL, --check_valor_si
	NULL, --check_valor_no
	NULL, --check_desc_si
	NULL, --check_desc_no
	NULL, --check_ml_toggle
	NULL, --fijo_sin_estado
	NULL, --editor_ancho
	NULL, --editor_alto
	NULL, --editor_botonera
	NULL, --selec_cant_minima
	NULL, --selec_cant_maxima
	NULL, --selec_utilidades
	NULL, --selec_tamano
	NULL, --selec_ancho
	NULL, --selec_serializar
	NULL, --selec_cant_columnas
	'pdf', --upload_extensiones
	NULL, --punto_montaje
	NULL  --placeholder
);
--- FIN Grupo de desarrollo 0
