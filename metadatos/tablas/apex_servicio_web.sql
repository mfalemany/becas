
------------------------------------------------------------
-- apex_servicio_web
------------------------------------------------------------
INSERT INTO apex_servicio_web (proyecto, servicio_web, descripcion, tipo, param_to, param_wsa) VALUES (
	'becas', --proyecto
	'ws_unne', --servicio_web
	'Servicio web que ofrece datos de:
- Docentes
- Nodocentes
- Alumnos', --descripcion
	'rest', --tipo
	NULL, --param_to
	'0'  --param_wsa
);
