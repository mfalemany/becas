<?php
class becas_ci extends toba_ci
{
	function armar_template($archivo,$datos)
	{	
		ob_start();
		include $archivo;
		return ob_get_clean();
	}
}
?>