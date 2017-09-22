------------------------------------------------------------
--[46]--  Areas 
------------------------------------------------------------

------------------------------------------------------------
-- apex_molde_operacion
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_molde_operacion (proyecto, molde, operacion_tipo, nombre, item, carpeta_archivos, prefijo_clases, fuente, punto_montaje) VALUES (
	'becas', --proyecto
	'46', --molde
	'10', --operacion_tipo
	'Areas', --nombre
	'3609', --item
	'opciones/lugares/areas', --carpeta_archivos
	'_areas', --prefijo_clases
	'becas', --fuente
	'22'  --punto_montaje
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_molde_operacion_abms
------------------------------------------------------------
INSERT INTO apex_molde_operacion_abms (proyecto, molde, tabla, gen_usa_filtro, gen_separar_pantallas, filtro_comprobar_parametros, cuadro_eof, cuadro_eliminar_filas, cuadro_id, cuadro_forzar_filtro, cuadro_carga_origen, cuadro_carga_sql, cuadro_carga_php_include, cuadro_carga_php_clase, cuadro_carga_php_metodo, datos_tabla_validacion, apdb_pre, punto_montaje) VALUES (
	'becas', --proyecto
	'46', --molde
	'areas_dependencia', --tabla
	'1', --gen_usa_filtro
	'0', --gen_separar_pantallas
	'0', --filtro_comprobar_parametros
	'No se han cargado áreas.', --cuadro_eof
	'1', --cuadro_eliminar_filas
	'id_area', --cuadro_id
	'0', --cuadro_forzar_filtro
	'consulta_php', --cuadro_carga_origen
	'SELECT
	t_ad.id_area,
	t_ad.area,
	t_d.nombre as id_dependencia_nombre
FROM
	areas_dependencia as t_ad	LEFT OUTER JOIN dependencias as t_d ON (t_ad.id_dependencia = t_d.id_dependencia)
ORDER BY area', --cuadro_carga_sql
	'consultas/co_areas_dependencia.php', --cuadro_carga_php_include
	'co_areas_dependencia', --cuadro_carga_php_clase
	'get_areas_dependencia', --cuadro_carga_php_metodo
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
	'46', --molde
	'172', --fila
	'1', --orden
	'id_area', --columna
	'1000003', --asistente_tipo_dato
	'Id Area', --etiqueta
	'0', --en_cuadro
	'0', --en_form
	'0', --en_filtro
	'=', --filtro_operador
	'0', --cuadro_estilo
	'7', --cuadro_formato
	'E', --dt_tipo_dato
	NULL, --dt_largo
	'be_areas_dependencia_id_area_seq', --dt_secuencia
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
	'46', --molde
	'173', --fila
	'2', --orden
	'area', --columna
	'1000001', --asistente_tipo_dato
	'Area', --etiqueta
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
	'46', --molde
	'174', --fila
	'3', --orden
	'id_dependencia', --columna
	'1000008', --asistente_tipo_dato
	'Id Dependencia', --etiqueta
	'1', --en_cuadro
	'1', --en_form
	'1', --en_filtro
	'=', --filtro_operador
	'4', --cuadro_estilo
	'1', --cuadro_formato
	'C', --dt_tipo_dato
	NULL, --dt_largo
	'', --dt_secuencia
	'0', --dt_pk
	'ef_combo', --elemento_formulario
	'1', --ef_obligatorio
	NULL, --ef_desactivar_modificacion
	NULL, --ef_procesar_javascript
	'datos_tabla', --ef_carga_origen
	'SELECT id_dependencia, nombre FROM dependencias ORDER BY nombre', --ef_carga_sql
	NULL, --ef_carga_php_include
	NULL, --ef_carga_php_clase
	NULL, --ef_carga_php_metodo
	'dependencias', --ef_carga_tabla
	'id_dependencia', --ef_carga_col_clave
	'nombre', --ef_carga_col_desc
	NULL  --punto_montaje
);
--- FIN Grupo de desarrollo 0
