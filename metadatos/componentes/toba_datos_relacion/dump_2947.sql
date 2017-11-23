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
	'1', --sinc_susp_constraints
	'0', --sinc_orden_automatico
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
	NULL, --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'1'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1860', --dep_id
	'2947', --objeto_consumidor
	'2965', --objeto_proveedor
	'antec_activ_docentes', --identificador
	NULL, --parametros_a
	NULL, --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'2'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1861', --dep_id
	'2947', --objeto_consumidor
	'2966', --objeto_proveedor
	'antec_becas_obtenidas', --identificador
	NULL, --parametros_a
	NULL, --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'3'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1862', --dep_id
	'2947', --objeto_consumidor
	'2967', --objeto_proveedor
	'antec_conoc_idiomas', --identificador
	NULL, --parametros_a
	NULL, --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'4'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1863', --dep_id
	'2947', --objeto_consumidor
	'2968', --objeto_proveedor
	'antec_cursos_perfec_aprob', --identificador
	NULL, --parametros_a
	NULL, --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'5'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1864', --dep_id
	'2947', --objeto_consumidor
	'2969', --objeto_proveedor
	'antec_estudios_afines', --identificador
	NULL, --parametros_a
	NULL, --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'6'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1865', --dep_id
	'2947', --objeto_consumidor
	'2970', --objeto_proveedor
	'antec_otras_actividades', --identificador
	NULL, --parametros_a
	NULL, --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'7'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1866', --dep_id
	'2947', --objeto_consumidor
	'2971', --objeto_proveedor
	'antec_particip_dict_cursos', --identificador
	NULL, --parametros_a
	NULL, --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'8'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1867', --dep_id
	'2947', --objeto_consumidor
	'2972', --objeto_proveedor
	'antec_present_reuniones', --identificador
	NULL, --parametros_a
	NULL, --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'9'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'becas', --proyecto
	'1868', --dep_id
	'2947', --objeto_consumidor
	'2973', --objeto_proveedor
	'antec_trabajos_publicados', --identificador
	NULL, --parametros_a
	NULL, --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'10'  --orden
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_datos_rel_asoc
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'98', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'alumno', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2965', --hijo_objeto
	'antec_activ_docentes', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'1'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'99', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'alumno', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2966', --hijo_objeto
	'antec_becas_obtenidas', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'2'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'100', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'alumno', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2967', --hijo_objeto
	'antec_conoc_idiomas', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'3'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'101', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'alumno', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2968', --hijo_objeto
	'antec_cursos_perfec_aprob', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'4'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'102', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'alumno', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2969', --hijo_objeto
	'antec_estudios_afines', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'5'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'103', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'alumno', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2970', --hijo_objeto
	'antec_otras_actividades', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'6'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'104', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'alumno', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2971', --hijo_objeto
	'antec_particip_dict_cursos', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'7'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'105', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'alumno', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2972', --hijo_objeto
	'antec_present_reuniones', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'8'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'106', --asoc_id
	NULL, --identificador
	'becas', --padre_proyecto
	'2952', --padre_objeto
	'alumno', --padre_id
	NULL, --padre_clave
	'becas', --hijo_proyecto
	'2973', --hijo_objeto
	'antec_trabajos_publicados', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'9'  --orden
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_rel_columnas_asoc
------------------------------------------------------------
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'98', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2965', --hijo_objeto
	'1494'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'98', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2965', --hijo_objeto
	'1495'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'99', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2966', --hijo_objeto
	'1500'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'99', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2966', --hijo_objeto
	'1499'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'100', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2967', --hijo_objeto
	'1508'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'100', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2967', --hijo_objeto
	'1507'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'101', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2968', --hijo_objeto
	'1515'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'101', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2968', --hijo_objeto
	'1514'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'102', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2969', --hijo_objeto
	'1523'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'102', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2969', --hijo_objeto
	'1522'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'103', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2970', --hijo_objeto
	'1529'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'103', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2970', --hijo_objeto
	'1528'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'104', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2971', --hijo_objeto
	'1535'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'104', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2971', --hijo_objeto
	'1534'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'105', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2972', --hijo_objeto
	'1541'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'105', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2972', --hijo_objeto
	'1540'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'106', --asoc_id
	'2952', --padre_objeto
	'1405', --padre_clave
	'2973', --hijo_objeto
	'1547'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'becas', --proyecto
	'2947', --objeto
	'106', --asoc_id
	'2952', --padre_objeto
	'1406', --padre_clave
	'2973', --hijo_objeto
	'1546'  --hijo_clave
);
