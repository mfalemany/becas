------------------------------------------------------------
--[2753]--  DT - tipos_resolucion 
------------------------------------------------------------

------------------------------------------------------------
-- apex_objeto
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto (proyecto, objeto, anterior, identificador, reflexivo, clase_proyecto, clase, punto_montaje, subclase, subclase_archivo, objeto_categoria_proyecto, objeto_categoria, nombre, titulo, colapsable, descripcion, fuente_datos_proyecto, fuente_datos, solicitud_registrar, solicitud_obj_obs_tipo, solicitud_obj_observacion, parametro_a, parametro_b, parametro_c, parametro_d, parametro_e, parametro_f, usuario, creacion, posicion_botonera) VALUES (
	'becas', --proyecto
	'2753', --objeto
	NULL, --anterior
	NULL, --identificador
	NULL, --reflexivo
	'toba', --clase_proyecto
	'toba_datos_tabla', --clase
	'22', --punto_montaje
	'dt_tipos_resolucion', --subclase
	'datos/dt_tipos_resolucion.php', --subclase_archivo
	NULL, --objeto_categoria_proyecto
	NULL, --objeto_categoria
	'DT - tipos_resolucion', --nombre
	NULL, --titulo
	NULL, --colapsable
	NULL, --descripcion
	'becas', --fuente_datos_proyecto
	'becas', --fuente_datos
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
	'2017-09-18 09:08:59', --creacion
	NULL  --posicion_botonera
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_db_registros
------------------------------------------------------------
INSERT INTO apex_objeto_db_registros (objeto_proyecto, objeto, max_registros, min_registros, punto_montaje, ap, ap_clase, ap_archivo, tabla, tabla_ext, alias, modificar_claves, fuente_datos_proyecto, fuente_datos, permite_actualizacion_automatica, esquema, esquema_ext) VALUES (
	'becas', --objeto_proyecto
	'2753', --objeto
	NULL, --max_registros
	NULL, --min_registros
	'22', --punto_montaje
	'1', --ap
	NULL, --ap_clase
	NULL, --ap_archivo
	'tipos_resolucion', --tabla
	NULL, --tabla_ext
	NULL, --alias
	'0', --modificar_claves
	'becas', --fuente_datos_proyecto
	'becas', --fuente_datos
	'1', --permite_actualizacion_automatica
	NULL, --esquema
	'public'  --esquema_ext
);

------------------------------------------------------------
-- apex_objeto_db_registros_col
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_db_registros_col (objeto_proyecto, objeto, col_id, columna, tipo, pk, secuencia, largo, no_nulo, no_nulo_db, externa, tabla) VALUES (
	'becas', --objeto_proyecto
	'2753', --objeto
	'1211', --col_id
	'id_tipo_resol', --columna
	'E', --tipo
	'1', --pk
	'be_tipos_resolucion_id_tipo_resol_seq', --secuencia
	NULL, --largo
	NULL, --no_nulo
	'1', --no_nulo_db
	NULL, --externa
	'tipos_resolucion'  --tabla
);
INSERT INTO apex_objeto_db_registros_col (objeto_proyecto, objeto, col_id, columna, tipo, pk, secuencia, largo, no_nulo, no_nulo_db, externa, tabla) VALUES (
	'becas', --objeto_proyecto
	'2753', --objeto
	'1212', --col_id
	'tipo_resol', --columna
	'C', --tipo
	'0', --pk
	'', --secuencia
	'50', --largo
	NULL, --no_nulo
	'1', --no_nulo_db
	NULL, --externa
	'tipos_resolucion'  --tabla
);
INSERT INTO apex_objeto_db_registros_col (objeto_proyecto, objeto, col_id, columna, tipo, pk, secuencia, largo, no_nulo, no_nulo_db, externa, tabla) VALUES (
	'becas', --objeto_proyecto
	'2753', --objeto
	'1213', --col_id
	'tipo_resol_corto', --columna
	'C', --tipo
	'0', --pk
	'', --secuencia
	'15', --largo
	NULL, --no_nulo
	'1', --no_nulo_db
	NULL, --externa
	'tipos_resolucion'  --tabla
);
--- FIN Grupo de desarrollo 0
