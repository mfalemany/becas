------------------------------------------------------------
--[2969]--  antec_estudios_afines 
------------------------------------------------------------

------------------------------------------------------------
-- apex_objeto
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto (proyecto, objeto, anterior, identificador, reflexivo, clase_proyecto, clase, punto_montaje, subclase, subclase_archivo, objeto_categoria_proyecto, objeto_categoria, nombre, titulo, colapsable, descripcion, fuente_datos_proyecto, fuente_datos, solicitud_registrar, solicitud_obj_obs_tipo, solicitud_obj_observacion, parametro_a, parametro_b, parametro_c, parametro_d, parametro_e, parametro_f, usuario, creacion, posicion_botonera) VALUES (
	'becas', --proyecto
	'2969', --objeto
	NULL, --anterior
	NULL, --identificador
	NULL, --reflexivo
	'toba', --clase_proyecto
	'toba_datos_tabla', --clase
	'22', --punto_montaje
	NULL, --subclase
	NULL, --subclase_archivo
	NULL, --objeto_categoria_proyecto
	NULL, --objeto_categoria
	'antec_estudios_afines', --nombre
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
	'2017-11-21 08:39:30', --creacion
	NULL  --posicion_botonera
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_db_registros
------------------------------------------------------------
INSERT INTO apex_objeto_db_registros (objeto_proyecto, objeto, max_registros, min_registros, punto_montaje, ap, ap_clase, ap_archivo, tabla, tabla_ext, alias, modificar_claves, fuente_datos_proyecto, fuente_datos, permite_actualizacion_automatica, esquema, esquema_ext) VALUES (
	'becas', --objeto_proyecto
	'2969', --objeto
	NULL, --max_registros
	NULL, --min_registros
	'22', --punto_montaje
	'1', --ap
	NULL, --ap_clase
	NULL, --ap_archivo
	'antec_estudios_afines', --tabla
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
	'2969', --objeto
	'1516', --col_id
	'id_estudio_afin', --columna
	'E', --tipo
	'1', --pk
	'antec_estudios_afines_id_estudio_afin_seq', --secuencia
	NULL, --largo
	NULL, --no_nulo
	'1', --no_nulo_db
	'0', --externa
	'antec_estudios_afines'  --tabla
);
INSERT INTO apex_objeto_db_registros_col (objeto_proyecto, objeto, col_id, columna, tipo, pk, secuencia, largo, no_nulo, no_nulo_db, externa, tabla) VALUES (
	'becas', --objeto_proyecto
	'2969', --objeto
	'1518', --col_id
	'institucion', --columna
	'C', --tipo
	'0', --pk
	'', --secuencia
	'100', --largo
	NULL, --no_nulo
	'0', --no_nulo_db
	'0', --externa
	'antec_estudios_afines'  --tabla
);
INSERT INTO apex_objeto_db_registros_col (objeto_proyecto, objeto, col_id, columna, tipo, pk, secuencia, largo, no_nulo, no_nulo_db, externa, tabla) VALUES (
	'becas', --objeto_proyecto
	'2969', --objeto
	'1521', --col_id
	'titulo', --columna
	'C', --tipo
	'0', --pk
	'', --secuencia
	'200', --largo
	NULL, --no_nulo
	'1', --no_nulo_db
	'0', --externa
	'antec_estudios_afines'  --tabla
);
INSERT INTO apex_objeto_db_registros_col (objeto_proyecto, objeto, col_id, columna, tipo, pk, secuencia, largo, no_nulo, no_nulo_db, externa, tabla) VALUES (
	'becas', --objeto_proyecto
	'2969', --objeto
	'1523', --col_id
	'nro_documento', --columna
	'C', --tipo
	'0', --pk
	'', --secuencia
	'15', --largo
	NULL, --no_nulo
	'0', --no_nulo_db
	'0', --externa
	'antec_estudios_afines'  --tabla
);
INSERT INTO apex_objeto_db_registros_col (objeto_proyecto, objeto, col_id, columna, tipo, pk, secuencia, largo, no_nulo, no_nulo_db, externa, tabla) VALUES (
	'becas', --objeto_proyecto
	'2969', --objeto
	'1550', --col_id
	'anio_desde', --columna
	'N', --tipo
	'0', --pk
	'', --secuencia
	NULL, --largo
	NULL, --no_nulo
	'1', --no_nulo_db
	'0', --externa
	'antec_estudios_afines'  --tabla
);
INSERT INTO apex_objeto_db_registros_col (objeto_proyecto, objeto, col_id, columna, tipo, pk, secuencia, largo, no_nulo, no_nulo_db, externa, tabla) VALUES (
	'becas', --objeto_proyecto
	'2969', --objeto
	'1551', --col_id
	'anio_hasta', --columna
	'N', --tipo
	'0', --pk
	'', --secuencia
	NULL, --largo
	NULL, --no_nulo
	'0', --no_nulo_db
	'0', --externa
	'antec_estudios_afines'  --tabla
);
INSERT INTO apex_objeto_db_registros_col (objeto_proyecto, objeto, col_id, columna, tipo, pk, secuencia, largo, no_nulo, no_nulo_db, externa, tabla) VALUES (
	'becas', --objeto_proyecto
	'2969', --objeto
	'1567', --col_id
	'doc_probatoria', --columna
	'C', --tipo
	'0', --pk
	'', --secuencia
	'200', --largo
	NULL, --no_nulo
	'0', --no_nulo_db
	'0', --externa
	'antec_estudios_afines'  --tabla
);
--- FIN Grupo de desarrollo 0
