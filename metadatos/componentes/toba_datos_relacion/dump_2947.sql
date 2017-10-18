------------------------------------------------------------
--[2947]--  Inscripción - DR 
------------------------------------------------------------

------------------------------------------------------------
-- apex_objeto
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto (proyecto, objeto, anterior, identificador, reflexivo, clase_proyecto, clase, punto_montaje, subclase, subclase_archivo, objeto_categoria_proyecto, objeto_categoria, nombre, titulo, colapsable, descripcion, fuente_datos_proyecto, fuente_datos, solicitud_registrar, solicitud_obj_obs_tipo, solicitud_obj_observacion, parametro_a, parametro_b, parametro_c, parametro_d, parametro_e, parametro_f, usuario, creacion, posicion_botonera) VALUES (
	'becas', --proyecto
	'2947', --objeto
	NULL, --anterior
	NULL, --identificador
	NULL, --reflexivo
	'toba', --clase_proyecto
	'toba_datos_relacion', --clase
	'22', --punto_montaje
	NULL, --subclase
	NULL, --subclase_archivo
	NULL, --objeto_categoria_proyecto
	NULL, --objeto_categoria
	'Inscripción - DR', --nombre
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
	'2017-10-13 09:19:47', --creacion
	NULL  --posicion_botonera
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_datos_rel
------------------------------------------------------------
INSERT INTO apex_objeto_datos_rel (proyecto, objeto, debug, clave, ap, punto_montaje, ap_clase, ap_archivo, sinc_susp_constraints, sinc_orden_automatico, sinc_lock_optimista) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'0', --debug
	NULL, --clave
	'2', --ap
	'22', --punto_montaje
	NULL, --ap_clase
	NULL, --ap_archivo
	'0', --sinc_susp_constraints
	'1', --sinc_orden_automatico
	'1'  --sinc_lock_optimista
);

------------------------------------------------------------
-- apex_objeto_dependencias
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1821', --dep_id
	'2947', --objeto_consumidor
	'2952', --objeto_proveedor
	'alumno', --identificador
	'1', --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'2'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1830', --dep_id
	'2947', --objeto_consumidor
	'2952', --objeto_proveedor
	'codirector', --identificador
	NULL, --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'7'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1829', --dep_id
	'2947', --objeto_consumidor
	'2954', --objeto_proveedor
	'codirector_beca', --identificador
	NULL, --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'6'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1831', --dep_id
	'2947', --objeto_consumidor
	'2834', --objeto_proveedor
	'codirector_docente', --identificador
	NULL, --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'8'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1827', --dep_id
	'2947', --objeto_consumidor
	'2952', --objeto_proveedor
	'director', --identificador
	'1', --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'4'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1826', --dep_id
	'2947', --objeto_consumidor
	'2954', --objeto_proveedor
	'director_beca', --identificador
	'1', --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'3'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1828', --dep_id
	'2947', --objeto_consumidor
	'2834', --objeto_proveedor
	'director_docente', --identificador
	'1', --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'5'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1811', --dep_id
	'2947', --objeto_consumidor
	'2946', --objeto_proveedor
	'inscripcion_conv_beca', --identificador
	'1', --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'1'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1835', --dep_id
	'2947', --objeto_consumidor
	'2952', --objeto_proveedor
	'subdirector', --identificador
	NULL, --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'10'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1834', --dep_id
	'2947', --objeto_consumidor
	'2954', --objeto_proveedor
	'subdirector_beca', --identificador
	NULL, --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'9'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1836', --dep_id
	'2947', --objeto_consumidor
	'2834', --objeto_proveedor
	'subdirector_docente', --identificador
	NULL, --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'11'  --orden
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_datos_rel_asoc
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'82', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'alumno', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2946', --hijo_objeto
	'inscripcion_conv_beca', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'1'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'83', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2946', --padre_objeto
	'inscripcion_conv_beca', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2954', --hijo_objeto
	'director_beca', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'2'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'84', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2834', --padre_objeto
	'director_docente', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2954', --hijo_objeto
	'director_beca', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'3'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'85', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'director', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2834', --hijo_objeto
	'director_docente', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'4'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'86', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2946', --padre_objeto
	'inscripcion_conv_beca', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2954', --hijo_objeto
	'codirector_beca', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'5'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'87', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2834', --padre_objeto
	'codirector_docente', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2954', --hijo_objeto
	'codirector_beca', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'6'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'88', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'codirector', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2834', --hijo_objeto
	'codirector_docente', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'7'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'89', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2946', --padre_objeto
	'inscripcion_conv_beca', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2954', --hijo_objeto
	'subdirector_beca', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'8'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'90', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2834', --padre_objeto
	'subdirector_docente', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2954', --hijo_objeto
	'subdirector_beca', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'9'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'91', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'subdirector', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2834', --hijo_objeto
	'subdirector_docente', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'10'  --orden
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_rel_columnas_asoc
------------------------------------------------------------
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'82', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2946', --hijo_objeto
	'1382'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'82', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2946', --hijo_objeto
	'1383'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'83', --asoc_id
	'2946', --padre_objeto
	'1379', --padre_clave
	'2954', --hijo_objeto
	'1434'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'83', --asoc_id
	'2946', --padre_objeto
	'1380', --padre_clave
	'2954', --hijo_objeto
	'1438'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'83', --asoc_id
	'2946', --padre_objeto
	'1382', --padre_clave
	'2954', --hijo_objeto
	'1432'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'83', --asoc_id
	'2946', --padre_objeto
	'1383', --padre_clave
	'2954', --hijo_objeto
	'1433'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'84', --asoc_id
	'2834', --padre_objeto
	'1260', --padre_clave
	'2954', --hijo_objeto
	'1432'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'84', --asoc_id
	'2834', --padre_objeto
	'1261', --padre_clave
	'2954', --hijo_objeto
	'1433'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'85', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2834', --hijo_objeto
	'1260'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'85', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2834', --hijo_objeto
	'1261'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'86', --asoc_id
	'2946', --padre_objeto
	'1379', --padre_clave
	'2954', --hijo_objeto
	'1434'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'86', --asoc_id
	'2946', --padre_objeto
	'1380', --padre_clave
	'2954', --hijo_objeto
	'1438'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'86', --asoc_id
	'2946', --padre_objeto
	'1382', --padre_clave
	'2954', --hijo_objeto
	'1432'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'86', --asoc_id
	'2946', --padre_objeto
	'1383', --padre_clave
	'2954', --hijo_objeto
	'1433'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'87', --asoc_id
	'2834', --padre_objeto
	'1260', --padre_clave
	'2954', --hijo_objeto
	'1432'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'87', --asoc_id
	'2834', --padre_objeto
	'1261', --padre_clave
	'2954', --hijo_objeto
	'1433'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'88', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2834', --hijo_objeto
	'1260'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'88', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2834', --hijo_objeto
	'1261'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'89', --asoc_id
	'2946', --padre_objeto
	'1379', --padre_clave
	'2954', --hijo_objeto
	'1434'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'89', --asoc_id
	'2946', --padre_objeto
	'1380', --padre_clave
	'2954', --hijo_objeto
	'1438'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'89', --asoc_id
	'2946', --padre_objeto
	'1382', --padre_clave
	'2954', --hijo_objeto
	'1432'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'89', --asoc_id
	'2946', --padre_objeto
	'1383', --padre_clave
	'2954', --hijo_objeto
	'1433'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'90', --asoc_id
	'2834', --padre_objeto
	'1260', --padre_clave
	'2954', --hijo_objeto
	'1432'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'90', --asoc_id
	'2834', --padre_objeto
	'1261', --padre_clave
	'2954', --hijo_objeto
	'1433'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'91', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2834', --hijo_objeto
	'1260'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'91', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2834', --hijo_objeto
	'1261'  --hijo_clave
);
