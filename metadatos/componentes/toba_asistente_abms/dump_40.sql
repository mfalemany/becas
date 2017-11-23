------------------------------------------------------------
--[40]--  Localidades 
------------------------------------------------------------

------------------------------------------------------------
-- apex_molde_operacion
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_molde_operacion (proyecto, molde, operacion_tipo, nombre, item, carpeta_archivos, prefijo_clases, fuente, punto_montaje) VALUES (
	'becas', --proyecto
	'40', --molde
	'10', --operacion_tipo
	'Localidades', --nombre
	'3599', --item
	'localidades', --carpeta_archivos
	'_localidades', --prefijo_clases
	'becas', --fuente
	'22'  --punto_montaje
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_molde_operacion_abms
------------------------------------------------------------
INSERT INTO apex_molde_operacion_abms (proyecto, molde, tabla, gen_usa_filtro, gen_separar_pantallas, filtro_comprobar_parametros, cuadro_eof, cuadro_eliminar_filas, cuadro_id, cuadro_forzar_filtro, cuadro_carga_origen, cuadro_carga_sql, cuadro_carga_php_include, cuadro_carga_php_clase, cuadro_carga_php_metodo, datos_tabla_validacion, apdb_pre, punto_montaje) VALUES (
	'becas', --proyecto
	'40', --molde
	'localidades', --tabla
	'1', --gen_usa_filtro
	'1', --gen_separar_pantallas
	'0', --filtro_comprobar_parametros
	'No se han cargado localidades', --cuadro_eof
	'1', --cuadro_eliminar_filas
	'id_provincia,id_pais,id_localidad', --cuadro_id
	'0', --cuadro_forzar_filtro
	'consulta_php', --cuadro_carga_origen
	'SELECT
	t_l.id_provincia,
	t_l.id_pais,
	t_l.id_localidad,
	t_l.localidad
FROM
	localidades as t_l
ORDER BY localidad', --cuadro_carga_sql
	'consultas/co_localidades.php', --cuadro_carga_php_include
	'co_localidades', --cuadro_carga_php_clase
	'get_localidades', --cuadro_carga_php_metodo
	NULL, --datos_tabla_validacion
	NULL, --apdb_pre
	NULL  --punto_montaje
);

------------------------------------------------------------
-- apex_molde_operacion_abms_fila
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_molde_operacion_abms_fila (proyecto, molde, fila, orden, columna, asistente_tipo_dato, etiqueta, en_cuadro, en_form, en_filtro, filtro_operador, cuadro_estilo, cuadro_formato, dt_tipo_dato, dt_largo, dt_secuencia, dt_pk, elemento_formulario, ef_obligatorio, ef_desactivar_modificacion, ef_procesar_javascript, ef_carga_origen, ef_carga_sql, ef_carga_php_include, ef_carga_php_clase, ef_carga_php_metodo, ef_carga_tabla, ef_carga_col_clave, ef_carga_col_desc, punto_montaje) VALUES (
	'becas', --proyecto
	'40', --molde
	'143', --fila
	'1', --orden
	'id_provincia', --columna
	'1000003', --asistente_tipo_dato
	'Id Provincia', --etiqueta
	'1', --en_cuadro
	'1', --en_form
	'0', --en_filtro
	'=', --filtro_operador
	'0', --cuadro_estilo
	'7', --cuadro_formato
	'E', --dt_tipo_dato
	NULL, --dt_largo
	'', --dt_secuencia
	'1', --dt_pk
	'ef_editable_numero', --elemento_formulario
	'1', --ef_obligatorio
	NULL, --ef_desactivar_modificacion
	NULL, --ef_procesar_javascript
	NULL, --ef_carga_origen
	NULL, --ef_carga_sql
	NULL, --ef_carga_php_include
	NULL, --ef_carga_php_clase
	NULL, --ef_carga_php_metodo
	NULL, --ef_carga_tabla
	NULL, --ef_carga_col_clave
	NULL, --ef_carga_col_desc
	NULL  --punto_montaje
);
INSERT INTO apex_molde_operacion_abms_fila (proyecto, molde, fila, orden, columna, asistente_tipo_dato, etiqueta, en_cuadro, en_form, en_filtro, filtro_operador, cuadro_estilo, cuadro_formato, dt_tipo_dato, dt_largo, dt_secuencia, dt_pk, elemento_formulario, ef_obligatorio, ef_desactivar_modificacion, ef_procesar_javascript, ef_carga_origen, ef_carga_sql, ef_carga_php_include, ef_carga_php_clase, ef_carga_php_metodo, ef_carga_tabla, ef_carga_col_clave, ef_carga_col_desc, punto_montaje) VALUES (
	'becas', --proyecto
	'40', --molde
	'144', --fila
	'2', --orden
	'id_pais', --columna
	'1000003', --asistente_tipo_dato
	'Id Pais', --etiqueta
	'1', --en_cuadro
	'1', --en_form
	'0', --en_filtro
	'=', --filtro_operador
	'0', --cuadro_estilo
	'7', --cuadro_formato
	'E', --dt_tipo_dato
	NULL, --dt_largo
	'', --dt_secuencia
	'1', --dt_pk
	'ef_editable_numero', --elemento_formulario
	'1', --ef_obligatorio
	NULL, --ef_desactivar_modificacion
	NULL, --ef_procesar_javascript
	NULL, --ef_carga_origen
	NULL, --ef_carga_sql
	NULL, --ef_carga_php_include
	NULL, --ef_carga_php_clase
	NULL, --ef_carga_php_metodo
	NULL, --ef_carga_tabla
	NULL, --ef_carga_col_clave
	NULL, --ef_carga_col_desc
	NULL  --punto_montaje
);
INSERT INTO apex_molde_operacion_abms_fila (proyecto, molde, fila, orden, columna, asistente_tipo_dato, etiqueta, en_cuadro, en_form, en_filtro, filtro_operador, cuadro_estilo, cuadro_formato, dt_tipo_dato, dt_largo, dt_secuencia, dt_pk, elemento_formulario, ef_obligatorio, ef_desactivar_modificacion, ef_procesar_javascript, ef_carga_origen, ef_carga_sql, ef_carga_php_include, ef_carga_php_clase, ef_carga_php_metodo, ef_carga_tabla, ef_carga_col_clave, ef_carga_col_desc, punto_montaje) VALUES (
	'becas', --proyecto
	'40', --molde
	'145', --fila
	'3', --orden
	'id_localidad', --columna
	'1000003', --asistente_tipo_dato
	'Id Localidad', --etiqueta
	'0', --en_cuadro
	'0', --en_form
	'0', --en_filtro
	'=', --filtro_operador
	'0', --cuadro_estilo
	'7', --cuadro_formato
	'E', --dt_tipo_dato
	NULL, --dt_largo
	'be_localidades_id_localidad_seq', --dt_secuencia
	'1', --dt_pk
	'ef_editable_numero', --elemento_formulario
	'0', --ef_obligatorio
	NULL, --ef_desactivar_modificacion
	NULL, --ef_procesar_javascript
	NULL, --ef_carga_origen
	NULL, --ef_carga_sql
	NULL, --ef_carga_php_include
	NULL, --ef_carga_php_clase
	NULL, --ef_carga_php_metodo
	NULL, --ef_carga_tabla
	NULL, --ef_carga_col_clave
	NULL, --ef_carga_col_desc
	NULL  --punto_montaje
);
INSERT INTO apex_molde_operacion_abms_fila (proyecto, molde, fila, orden, columna, asistente_tipo_dato, etiqueta, en_cuadro, en_form, en_filtro, filtro_operador, cuadro_estilo, cuadro_formato, dt_tipo_dato, dt_largo, dt_secuencia, dt_pk, elemento_formulario, ef_obligatorio, ef_desactivar_modificacion, ef_procesar_javascript, ef_carga_origen, ef_carga_sql, ef_carga_php_include, ef_carga_php_clase, ef_carga_php_metodo, ef_carga_tabla, ef_carga_col_clave, ef_carga_col_desc, punto_montaje) VALUES (
	'becas', --proyecto
	'40', --molde
	'146', --fila
	'4', --orden
	'localidad', --columna
	'1000001', --asistente_tipo_dato
	'Localidad', --etiqueta
	'1', --en_cuadro
	'1', --en_form
	'1', --en_filtro
	'ILIKE', --filtro_operador
	'4', --cuadro_estilo
	'1', --cuadro_formato
	'C', --dt_tipo_dato
	NULL, --dt_largo
	'', --dt_secuencia
	'0', --dt_pk
	'ef_editable', --elemento_formulario
	'0', --ef_obligatorio
	NULL, --ef_desactivar_modificacion
	NULL, --ef_procesar_javascript
	NULL, --ef_carga_origen
	NULL, --ef_carga_sql
	NULL, --ef_carga_php_include
	NULL, --ef_carga_php_clase
	NULL, --ef_carga_php_metodo
	NULL, --ef_carga_tabla
	NULL, --ef_carga_col_clave
	NULL, --ef_carga_col_desc
	NULL  --punto_montaje
);
--- FIN Grupo de desarrollo 0
