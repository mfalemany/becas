
------------------------------------------------------------
-- apex_pagina_tipo
------------------------------------------------------------
INSERT INTO apex_pagina_tipo (proyecto, pagina_tipo, descripcion, clase_nombre, clase_archivo, include_arriba, include_abajo, exclusivo_toba, contexto, punto_montaje) VALUES (
	'becas', --proyecto
	'login_becas', --pagina_tipo
	'Página de Inicio de Sesión con posibilidad de recuperar clave y crear nuevo usuarios', --descripcion
	'tp_becas_logon', --clase_nombre
	'extension_toba/tipos_pagina/tp_becas_logon.php', --clase_archivo
	NULL, --include_arriba
	NULL, --include_abajo
	NULL, --exclusivo_toba
	NULL, --contexto
	'22'  --punto_montaje
);
