<?php
/**
 * Esta clase fue y será generada automáticamente. NO EDITAR A MANO.
 * @ignore
 */
class becas_autoload 
{
	static function existe_clase($nombre)
	{
		return isset(self::$clases[$nombre]);
	}

	static function cargar($nombre)
	{
		if (self::existe_clase($nombre)) { 
			 require_once(dirname(__FILE__) .'/'. self::$clases[$nombre]); 
		}
	}

	static protected $clases = array(
		'becas_comando' => 'extension_toba/becas_comando.php',
		'becas_modelo' => 'extension_toba/becas_modelo.php',
		'becas_ci' => 'extension_toba/componentes/becas_ci.php',
		'becas_cn' => 'extension_toba/componentes/becas_cn.php',
		'becas_datos_relacion' => 'extension_toba/componentes/becas_datos_relacion.php',
		'becas_datos_tabla' => 'extension_toba/componentes/becas_datos_tabla.php',
		'becas_ei_arbol' => 'extension_toba/componentes/becas_ei_arbol.php',
		'becas_ei_archivos' => 'extension_toba/componentes/becas_ei_archivos.php',
		'becas_ei_calendario' => 'extension_toba/componentes/becas_ei_calendario.php',
		'becas_ei_codigo' => 'extension_toba/componentes/becas_ei_codigo.php',
		'becas_ei_cuadro' => 'extension_toba/componentes/becas_ei_cuadro.php',
		'becas_ei_esquema' => 'extension_toba/componentes/becas_ei_esquema.php',
		'becas_ei_filtro' => 'extension_toba/componentes/becas_ei_filtro.php',
		'becas_ei_firma' => 'extension_toba/componentes/becas_ei_firma.php',
		'becas_ei_formulario' => 'extension_toba/componentes/becas_ei_formulario.php',
		'becas_ei_formulario_ml' => 'extension_toba/componentes/becas_ei_formulario_ml.php',
		'becas_ei_grafico' => 'extension_toba/componentes/becas_ei_grafico.php',
		'becas_ei_mapa' => 'extension_toba/componentes/becas_ei_mapa.php',
		'becas_servicio_web' => 'extension_toba/componentes/becas_servicio_web.php',
	);
}
?>