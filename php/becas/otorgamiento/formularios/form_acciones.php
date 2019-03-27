<?php
class form_acciones extends becas_ei_formulario
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Eventos ---------------------------------------------
		
		{$this->objeto_js}.evt__aplicar = function()
		{
			var ml = this.controlador.dep('ml_postulantes');
			var filas = ml.filas();
			for (id_fila in filas) {
				//Si solo se aplica a los vac�os, valido primero que no tenga un valor asignado
				if(this.ef('grupo').get_estado() == 'V'){
					//FECHA DESDE
					if(this.ef('fecha_desde').get_estado()){
						if( ! ml.ef('fecha_desde').ir_a_fila(filas[id_fila]).get_estado()){
							ml.ef('fecha_desde').ir_a_fila(filas[id_fila]).set_estado(this.ef('fecha_desde').get_estado());
						}	
					}
					//FECHA HASTA
					if(this.ef('fecha_hasta').get_estado()){
						if( ! ml.ef('fecha_hasta').ir_a_fila(filas[id_fila]).get_estado()){
							ml.ef('fecha_hasta').ir_a_fila(filas[id_fila]).set_estado(this.ef('fecha_hasta').get_estado());
						}	
					}
					//FECHA TOMA POSESI�N
					if(this.ef('fecha_toma_posesion').get_estado()){
						if( ! ml.ef('fecha_toma_posesion').ir_a_fila(filas[id_fila]).get_estado()){
							ml.ef('fecha_toma_posesion').ir_a_fila(filas[id_fila]).set_estado(this.ef('fecha_toma_posesion').get_estado());
						}	
					}
					//N�MERO DE RESOLUCI�N
					if(this.ef('nro_resol').get_estado()){
						if( ! ml.ef('nro_resol').ir_a_fila(filas[id_fila]).get_estado()){
							ml.ef('nro_resol').ir_a_fila(filas[id_fila]).set_estado(this.ef('nro_resol').get_estado());
						}	
					}
					
				}else{
					//Si no, lo asigno indiscriminadamente a todos
					if(this.ef('fecha_desde').get_estado()){
						ml.ef('fecha_desde').ir_a_fila(filas[id_fila]).set_estado(this.ef('fecha_desde').get_estado());
					}
					if(this.ef('fecha_hasta').get_estado()){
						ml.ef('fecha_hasta').ir_a_fila(filas[id_fila]).set_estado(this.ef('fecha_hasta').get_estado());
					}
					if(this.ef('fecha_toma_posesion').get_estado()){
						ml.ef('fecha_toma_posesion').ir_a_fila(filas[id_fila]).set_estado(this.ef('fecha_toma_posesion').get_estado());
					}
					if(this.ef('nro_resol').get_estado()){
						ml.ef('nro_resol').ir_a_fila(filas[id_fila]).set_estado(this.ef('nro_resol').get_estado());
					}
					
					
				}
			}

			return false;
		}
		";
	}

}

?>