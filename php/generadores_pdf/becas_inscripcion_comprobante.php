<?php 
class Becas_inscripcion_comprobante extends FPDF
{
	protected $x;
	protected $y;

	function __construct($datos)
	{
		parent::__construct();
		//Formato A4 y Apaisado
		$this->SetTopMargin(35);
		$this->SetAutoPageBreak(true,20);
		$this->AddPage('Portrait','A4');
		$this->SetFillColor(200,200,200);

		
		/* ---------- PARÁMETROS DEL FORMULARIO ---------------*/
		$params = array('ancho_total'       => 190,
						'ancho_titulo'      => 30,
						'alto_fila'         => 5,
						'alin_rotulo'       => 'R',
						'bordes'            => 'T', //bordes superior e inferior
						'distancia_cuadros' => 3);
		$params['ancho_info'] = $params['ancho_total'] - $params['ancho_titulo'];
		/* ----------------------------------------------------*/

		//Cuadro Postulante
		$this->postulante($datos['postulante'],$params);

		//Cuadro Beca
		$this->Ln();
		$this->beca($datos['beca'],$params);

		
		//Cuadros Dirección
		//Director
		$this->Ln();
		$this->direccion($datos['director'],$params,'director');
				
		//Codirector
		if(isset($datos['codirector'])){
			$this->Ln();
			$this->direccion($datos['codirector'],$params,'codirector');
		}
		//Subdirector
		if(isset($datos['subdirector'])){
			$this->Ln();
			$this->direccion($datos['subdirector'],$params,'subdirector');
		}

		//Proyecto
		$this->Ln();
		$this->proyecto($datos['proyecto'],$params);

		//Firma postulante
		$this->Ln();
		$this->firma_postulante();

		//Aval Directores
		$this->Ln();
		$this->aval_directores();

		//Aval Autoridades UA
		$this->Ln();
		$this->aval_autoridades_ua();




	}

	function postulante($datos,$params)
	{
		extract($params);

		$this->setFont('','B');
		$this->Cell(190,7,'POSTULANTE',1,1,'C',true);	
		/* APELLIDO Y NOMBRES */
		$this->Cell($ancho_titulo,$alto_fila,'Apellido y Nombre:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell($ancho_info,$alto_fila,$datos['apellido'].", ".$datos['nombres'],$bordes,1,'L',false);	
		/* NRO DE DOCUMENTO - CUIL -FECHA NACIMIENTO */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Nro. Documento:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*3)) / 3,$alto_fila,$datos['nro_documento'],$bordes,0,'L',false);
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'CUIL:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*3)) / 3,$alto_fila,$datos['cuil'],$bordes,0,'L',false);
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Fecha Nacimiento:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*3)) / 3,$alto_fila,$datos['fecha_nac'],$bordes,1,'L',false);
		/* FACULTAD/INSTITUTO */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Facultad/Instituto:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell($ancho_info,$alto_fila,$datos['nombre_dependencia'],$bordes,1,'L',false);
		/* CELULAR Y TELEFONO */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Celular:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['celular'],$bordes,0,'L',false);
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Teléfono fijo:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['telefono'],$bordes,1,'L',false);
		/* LUGAR DE TRABAJO Y AREA */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Lugar trabajo becario:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['lugar_trabajo_becario'],$bordes,0,'L',false);
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Área:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['area_trabajo'],$bordes,1,'L',false);
		/* Promedio Histórico Egresados */
		$this->setFont('','B');
		$this->Cell(60,$alto_fila,'Promedio Histórico de Egresados:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(35,$alto_fila,$datos['prom_hist_egresados'],$bordes,0,'L',false);
		/* Promedio Historico Postulante */
		$this->setFont('','B');
		$this->Cell(60,$alto_fila,'Promedio Histórico del Postulante:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(35,$alto_fila,$datos['prom_hist'],$bordes,1,'L',false);
	}

	function beca($datos,$params)
	{
		extract($params);

		$this->setFont('','B');
		$this->Cell(190,7,'DATOS DE LA BECA',1,1,'C',true);	
		/* Convocatoria y Tipo de beca */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Convocatoria:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['convocatoria'],$bordes,0,'L',false);
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Tipo de Beca:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['tipo_beca'],$bordes,1,'L',false);
		/* Area de conocimiento */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Área de Conocimiento:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell($ancho_info,$alto_fila,$datos['area_conocimiento'],$bordes,1,'L',false);
		/* Título plan beca */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Título del Plan de Beca:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->MultiCell($ancho_info,$alto_fila-1,$datos['titulo_plan_beca'],$bordes,'J',false);
	}

	function direccion($datos,$params,$tipo)
	{
		extract($params);

		$this->setFont('','B');
		$this->Cell(190,7,strtoupper($tipo),1,1,'C',true);	
		/* APELLIDO Y NOMBRES */
		$this->Cell($ancho_titulo,$alto_fila,'Apellido y Nombre:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell($ancho_info,$alto_fila,$datos['apellido'].", ".$datos['nombres'],$bordes,1,'L',false);	
		/* NRO DE DOCUMENTO - CUIL */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Nro. Documento:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['nro_documento'],$bordes,0,'L',false);
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'CUIL:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['cuil'],$bordes,1,'L',false);
		/* CELULAR Y TELEFONO Y MAIL*/
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Celular:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*3)) / 3,$alto_fila,$datos['celular'],$bordes,0,'L',false);
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Mail:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*3)) / 3,$alto_fila,$datos['mail'],$bordes,0,'L',false);
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Teléfono fijo:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*3)) / 3,$alto_fila,$datos['telefono'],$bordes,1,'L',false);
		/* NIVEL ACADÉMICO Y CAT. INCENTIVOS*/
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Máx. Grado Académico:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['nivel_academico'],$bordes,0,'L',false);
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Cat. Incentivos:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		if($datos['catinc']){
			$cat_inc = array('1'=>'I','2'=>'II','3'=>'III','4'=>'IV','5'=>'V');
			$datos['catinc'] = 'Categoría '.$cat_inc[$datos['catinc']].' (Convocatoria '.$datos['catinc_conv'].')';
		}else{
			$datos['catinc'] = 'No categorizado';
		}
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['catinc'],$bordes,1,'L',false);
		/* CATEGORIA CONICET Y LUGAR TRABAJO CONICET */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Cat. CONICET:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['catconicet'],$bordes,0,'L',false);
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Lugar Trabajo (CONICET):',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['lugar_trabajo_conicet'],$bordes,1,'L',false);
	}

	function proyecto($datos,$params)
	{
		extract($params);

		$this->setFont('','B');
		$this->Cell(190,7,'PROYECTO ACREDITADO',1,1,'C',true);	
		
		/* Convocatoria y Tipo de beca */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Código:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['codigo'],$bordes,0,'L',false);
		/* Convocatoria y Tipo de beca */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Fecha finaliz.:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['fecha_hasta'],$bordes,1,'L',false);
		/* APELLIDO Y NOMBRES */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Apellido y Nombre:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell($ancho_info,$alto_fila,$datos['apellido'].", ".$datos['nombres'].' (DNI: '.$datos['nro_documento'].')',$bordes,1,'L',false);
		/* Título plan beca */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Proyecto:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->MultiCell($ancho_info,$alto_fila-1,$datos['proyecto'],$bordes,'J',false);	
	}

	function firma_postulante()
	{
		$this->setFont('','B');
		$this->Cell(190,5,'FIRMA DEL POSTULANTE',1,1,'C',true);	
		$this->setFont('','');
		$this->MultiCell(190,4,'Declaro conocer el Reglamento de Becas de Investigación de la Universidad Nacional del Nordeste y Aceptar cada una de las obligaciones que de él derivan, comprometiéndome a su cumplimiento en caso de que me fuera otorgada la Beca solicitada',1,1,'',false);
		$this->Cell(50 ,19,'',1,0,'',false);
		$this->Cell(140,19,'',1,1,'',false);
		$this->Cell(50,6,'Firma del postulante',1,0,'C',false);
		$this->Cell(140,6,'Lugar y fecha',1,1,'C',false);

	}

	function aval_directores()
	{
		$this->setFont('','B');
		$this->Cell(190,5,'AVAL DE DIRECTORES',1,1,'C',true);
		$this->setFont('','');	
		$this->MultiCell(190,4,'Declaro conocer el Reglamento de Becas de Investigación de la Universidad Nacional del Nordeste, las obligaciones que de él derivan y dejo constancia que avalo el Plan de Trabajo del Postulante',1,1,'',false);
		
		$ancho = 190/4;
		$this->Cell($ancho ,19,'',1,0,'',false);
		$this->Cell($ancho ,19,'',1,0,'',false);
		$this->Cell($ancho ,19,'',1,0,'',false);
		$this->Cell($ancho ,19,'',1,1,'',false);
		$this->Cell($ancho,6,'Firma del Director',1,0,'C',false);
		$this->Cell($ancho,6,'Firma del Co-Director',1,0,'C',false);
		$this->Cell($ancho,6,'Firma del Sub-Director',1,0,'C',false);
		$this->Cell($ancho,6,'Firma del Director del Proyecto',1,1,'C',false);
		

	}

	function aval_autoridades_ua()
	{
		$this->setFont('','B');
		$this->Cell(190,5,'AVAL DE AUTORIDADES DE LA FACULTAD/INSTITUTO',1,1,'C',true);	
		$this->setFont('','');
		$this->MultiCell(190,4,'Por la presente presto mi conformidad para que, en caso de ser otorgada la beca solicitada, el postulante pueda realizar el trabajo de investigación propuesto, en el lugar indicado precedentemente',1,1,'',false);
		
		$ancho = 190/2;
		$this->Cell($ancho ,19,'',1,0,'',false);
		$this->Cell($ancho ,19,'',1,1,'',false);
		$this->Cell($ancho,6,'Firma del Secretario de Investigación',1,0,'C',false);
		$this->Cell($ancho,6,'Firma del Decano',1,1,'C',false);
		

	}

	function Header()
	{
		$path = toba::proyecto()->get_www();
        $path = $path['path']."img/logo_membrete.png";
		$this->Image($path,19,5,160,40);
		$this->SetFont('arial','BU',16);
		$this->Cell(190,10,'INSCRIPCIÓN A CONVOCATORIA DE BECAS CyT - UNNE',0,1,'C',false);	
		$this->SetFont('arial','',7);
	}	

	function Footer()
	{
		$this->SetXY(84,-10);
		$this->Cell(40,5,'Página '.$this->PageNo(),0,0,'C',false);
	}
	function mostrar()
	{
		$this->Output('I','pepe.pdf');
	}
}
?>