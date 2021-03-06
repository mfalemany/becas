<?php
class becas_ci extends toba_ci
{
	protected $meses = array(1=>'Enero',2=>'Febrero',3=>'Marzo',4=>'Abril',5=>'Mayo',6=>'Junio',7=>'Julio',8=>'Agosto',9=>'Septiembre',10=>'Octubre',11=>'Noviembre',12=>'Diciembre');

	function get_mes_desc($mes)
	{
		return $this->meses[intval($mes)];
	}
	function armar_template($archivo,$datos)
	{	
		ob_start();
		include $archivo;
		return ob_get_clean();
	}
	protected function soy_admin()
	{
		return in_array('admin', toba::usuario()->get_perfiles_funcionales());
	}
	protected function get_datos($tabla = NULL)
	{
		return $tabla ? $this->dep('datos')->tabla($tabla) : $this->dep('datos');
	}
	protected function fecha_dmy($fecha_ymd)
	{
		$fecha = new Datetime($fecha_ymd);
		return $fecha->format('d-m-Y');
	}
}
?>