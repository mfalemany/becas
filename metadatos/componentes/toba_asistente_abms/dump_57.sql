------------------------------------------------------------
--[57]--  Comisión Asesora 
------------------------------------------------------------

------------------------------------------------------------
-- apex_molde_operacion
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_molde_operacion (proyecto, molde, operacion_tipo, nombre, item, carpeta_archivos, prefijo_clases, fuente, punto_montaje) VALUES (
	'becas', --proyecto
	'57', --molde
	'10', --operacion_tipo
	'Comisión Asesora', --nombre
	'3627', --item
	'becas/comision_asesora', --carpeta_archivos
	'_comision_asesora', --prefijo_clases
	'becas', --fuente
	'22'  --punto_montaje
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_molde_operacion_abms
------------------------------------------------------------
INSERT INTO apex_molde_operacion_abms (proyecto, molde, tabla, gen_usa_filtro, gen_separar_pantallas, filtro_comprobar_parametros, cuadro_eof, cuadro_eliminar_filas, cuadro_id, cuadro_forzar_filtro, cuadro_carga_origen, cuadro_carga_sql, cuadro_carga_php_include, cuadro_carga_php_clase, cuadro_carga_php_metodo, datos_tabla_validacion, apdb_pre, punto_montaje) VALUES (
	'becas', --proyecto
	'57', --molde
	'comision_asesora', --tabla
	'0', --gen_usa_filtro
	'1', --gen_separar_pantallas
	NULL, --filtro_comprobar_parametros
	'No se han definido comisiones asesoras.', --cuadro_eof
	'1', --cuadro_eliminar_filas
	'id_area_conocimiento,id_convocatoria', --cuadro_id
	NULL, --cuadro_forzar_filtro
	'consulta_php', --cuadro_carga_origen
	'SELECT
	t_ca.id_area_conocimiento,
	t_ca.id_convocatoria
FROM
	comision_asesora as t_ca', --cuadro_carga_sql
	'consultas/co_comision_asesora.php', --cuadro_carga_php_include
	'co_comision_asesora', --cuadro_carga_php_clase
	'get_comisiones_asesoras', --cuadro_carga_php_metodo
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
	'57', --molde
	'212', --fila
	'1', --orden
	'id_area_conocimiento', --columna
	'1000008', --asistente_tipo_dato
	'Id Area Conocimiento', --etiqueta
	'1', --en_cuadro
	'1', --en_form
	'0', --en_filtro
	'=', --filtro_operador
	'4', --cuadro_estilo
	'1', --cuadro_formato
	'C', --dt_tipo_dato
	NULL, --dt_largo
	'', --dt_secuencia
	'1', --dt_pk
	'ef_combo', --elemento_formulario
	'1', --ef_obligatorio
	NULL, --ef_desactivar_modificacion
	NULL, --ef_procesar_javascript
	'datos_tabla', --ef_carga_origen
	'SELECT id_area_conocimiento, area_conocimiento FROM area_conocimiento ORDER BY area_conocimiento', --ef_carga_sql
	NULL, --ef_carga_php_include
	NULL, --ef_carga_php_clase
	NULL, --ef_carga_php_metodo
	'area_conocimiento', --ef_carga_tabla
	'id_area_conocimiento', --ef_carga_col_clave
	'area_conocimiento', --ef_carga_col_desc
	NULL  --punto_montaje
);
INSERT INTO apex_molde_operacion_abms_fila (proyecto, molde, fila, orden, columna, asistente_tipo_dato, etiqueta, en_cuadro, en_form, en_filtro, filtro_operador, cuadro_estilo, cuadro_formato, dt_tipo_dato, dt_largo, dt_secuencia, dt_pk, elemento_formulario, ef_obligatorio, ef_desactivar_modificacion, ef_procesar_javascript, ef_carga_origen, ef_carga_sql, ef_carga_php_include, ef_carga_php_clase, ef_carga_php_metodo, ef_carga_tabla, ef_carga_col_clave, ef_carga_col_desc, punto_montaje) VALUES (
	'becas', --proyecto
	'57', --molde
	'213', --fila
	'2', --orden
	'id_convocatoria', --columna
	'1000008', --asistente_tipo_dato
	'Id Convocatoria', --etiqueta
	'1', --en_cuadro
	'1', --en_form
	'0', --en_filtro
	'=', --filtro_operador
	'4', --cuadro_estilo
	'1', --cuadro_formato
	'C', --dt_tipo_dato
	NULL, --dt_largo
	'', --dt_secuencia
	'1', --dt_pk
	'ef_combo', --elemento_formulario
	'1', --ef_obligatorio
	NULL, --ef_desactivar_modificacion
	NULL, --ef_procesar_javascript
	'datos_tabla', --ef_carga_origen
	'SELECT id_convocatoria, color_carpeta FROM convocatoria_beca ORDER BY color_carpeta', --ef_carga_sql
	NULL, --ef_carga_php_include
	NULL, --ef_carga_php_clase
	NULL, --ef_carga_php_metodo
	'convocatoria_beca', --ef_carga_tabla
	'id_convocatoria', --ef_carga_col_clave
	'color_carpeta', --ef_carga_col_desc
	NULL  --punto_montaje
);
--- FIN Grupo de desarrollo 0
