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
		

		
		/* ---------- PAR�METROS DEL FORMULARIO ---------------*/
		$params = array('ancho_total'       => 190,
						'ancho_titulo'      => 30,
						'alto_fila'         => 5,
						'alin_rotulo'       => 'R',
						'bordes'            => 'T', //bordes superior e inferior
						'distancia_cuadros' => 3);
		$params['ancho_info'] = $params['ancho_total'] - $params['ancho_titulo'];
		/* ----------------------------------------------------*/

		//Car�tula
		$caratula = array('tipo_beca'         => $datos['beca']['tipo_beca'],
						  'postulante'        => $datos['postulante']['apellido'].', '.$datos['postulante']['nombres'],
						  'cuil'              => $datos['postulante']['cuil'],
						  'director'          => $datos['director']['apellido'].', '.$datos['director']['nombres'],
						  'area_conocimiento' => $datos['beca']['area_conocimiento'],
						  'nro_carpeta'       => $datos['beca']['nro_carpeta'],
						  'convocatoria'      => $datos['beca']['convocatoria']);
		$this->caratula($caratula,$params);

		//agrego otra hoja
		$this->AddPage('Portrait','A4');

		
		$this->SetFillColor(200,200,200);

		//Encabezado nota
		$this->encabezado_nota();

		//Cuadro Postulante
		$this->SetFont('','',7);
		$this->Ln();
		$this->postulante($datos['postulante'],$params);

		//Cuadro Beca
		$this->Ln();
		$this->beca($datos['beca'],$params);

		
		//Cuadros Direcci�n
		//Director
		$this->Ln();
		$this->direccion($datos['director'],$params,'director');
				
		//Codirector
		if(isset($datos['codirector'])){
			$this->Ln();
			$this->justificacion_codireccion($datos['postulante']['justif_codirector'],$params);
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

	function caratula($datos,$params)
	{
		extract($params);
		//manejan la posici�n del cuadro
		$x = 29;
		$y = 47;
		$ancho = 190;
		$alto = 130;

		//alto de la linea
		$alto_linea = 8;

		/* N�MERO CARPETA */
		$this->Ln();
		$this->setFont('','B',15);
		$this->Cell($ancho,$alto_linea,'Carpeta N�: '.$datos['nro_carpeta'],1,1,'C',false);
		
		//Cuandro
		/*$y += $alto_linea;
		$this->Rect($x,$y,$ancho,$alto,'DF');*/
		
		$ancho_etiq = 40;
		
		//Convocatoria
		$this->setFont('','B',10);
		$this->Cell($ancho_etiq,$alto_linea,'Convocatoria ',1,0,'C',false);
		$this->setFont('','',10);
		$this->Cell($ancho-$ancho_etiq,$alto_linea,$datos['convocatoria'],1,1,'L',false);
		//Tipo de Beca
		$this->setFont('','B',10);
		$this->Cell($ancho_etiq,$alto_linea,'Tipo de Beca ',1,0,'C',false);
		$this->setFont('','',10);
		$this->Cell($ancho-$ancho_etiq,$alto_linea,$datos['tipo_beca'],1,1,'L',false);
		//Area Conocimiento
		$this->setFont('','B',10);
		$this->Cell($ancho_etiq,$alto_linea,'�rea Conocimiento ',1,0,'C',false);
		$this->setFont('','',10);
		$this->Cell($ancho-$ancho_etiq,$alto_linea,$datos['area_conocimiento'],1,1,'L',false);
		//Postulante
		$this->setFont('','B',10);
		$this->Cell($ancho_etiq,$alto_linea,'Postulante ',1,0,'C',false);
		$this->setFont('','',10);
		$this->Cell($ancho-$ancho_etiq,$alto_linea,$datos['postulante'],1,1,'L',false);
		//CUIL
		$this->setFont('','B',10);
		$this->Cell($ancho_etiq,$alto_linea,'CUIL ',1,0,'C',false);
		$this->setFont('','',10);
		$this->Cell($ancho-$ancho_etiq,$alto_linea,$datos['cuil'],1,1,'L',false);
		//Director
		$this->setFont('','B',10);
		$this->Cell($ancho_etiq,$alto_linea,'Director ',1,0,'C',false);
		$this->setFont('','',10);
		$this->Cell($ancho-$ancho_etiq,$alto_linea,$datos['director'],1,1,'L',false);
		
		$this->Ln();
		$this->Ln();
		$this->SetFont('','',7);
		//Lugar y Fecha
		$this->Cell(75,$alto_linea,'','B',0,'C',false);
		$this->SetX($this->GetX()+40);
		$this->Cell(75,$alto_linea,'','B',1,'C',false);
		
		$this->Cell(75,$alto_linea,'Lugar y Fecha',0,0,'C',false);
		$this->SetX($this->GetX()+40);
		$this->Cell(75,$alto_linea,'Firma del Postulante',0,1,'C',false);

		//Linea para corte
		$this->Ln();
		$this->Cell($ancho,$alto_linea,'','T',1,'C',false);
	}

	function encabezado_nota()
	{
		//Convocatoria
		$this->setFont('','B',8);
		$this->MultiCell(190,4,"Se�ora\nSecretaria General de Ciencia y T�cnica\nde la Universidad Nacional del Nordeste\nSU DESPACHO",0,'L',false);
		$this->setFont('','',8);
		$this->MultiCell(190,5,"\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tTengo el agrado de dirigirme a Ud. con el objeto de solicitar mi inscripci�n al Concurso de Becas de Investigaci�n del corriente a�o.\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tA tal efecto adjunto los datos y documentaci�n requeridos en el formulario que acompa�a la presente solicitud:",0,'L',false);
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
		$this->Cell($ancho_titulo,$alto_fila,'Tel�fono fijo:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['telefono'],$bordes,1,'L',false);
		/* Cantidad de materias aprobadas por el postulante */
		$this->setFont('','B');
		$this->Cell(60,$alto_fila,'Cantidad de Materias Aprobadas:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(35,$alto_fila,$datos['materias_aprobadas'],$bordes,0,'L',false);
		/* Promedio Hist�rico del Postulante */
		$this->setFont('','B');
		$this->Cell(60,$alto_fila,'Promedio Hist�rico del Postulante (incluye aplazos):',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(35,$alto_fila,$datos['prom_hist'],$bordes,1,'L',false);
		/* Cantidad de Materias que tiene el plan de estudios */
		$this->setFont('','B');
		$this->Cell(60,$alto_fila,'Cantidad de materias del Plan de Estudios:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(35,$alto_fila,$datos['materias_plan'],$bordes,0,'L',false);
		/* Promedio Hist�rico Egresados */
		$this->setFont('','B');
		$this->Cell(60,$alto_fila,'Promedio Hist�rico de Egresados:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(35,$alto_fila,$datos['prom_hist_egresados'],$bordes,1,'L',false);
		/* Aval de la Direcci�n Gesti�n Estudios */
		
		$this->Cell(190,4,'Firma del responsable de la Direcci�n Gesti�n Estudios',1,1,'C',true);
		$this->Cell(50 ,10,'',1,0,'',false);
		$this->Cell(90,10,'',1,0,'',false);
		$this->Cell(50,10,'',1,1,'',false);
		$this->Cell(50,6,'Firma',1,0,'C',false);
		$this->Cell(90,6,'Aclaraci�n',1,0,'C',false);
		$this->Cell(50,6,'Cargo',1,1,'C',false);
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
		$this->Cell($ancho_titulo,$alto_fila,'�rea de Conocimiento:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell($ancho_info,$alto_fila,$datos['area_conocimiento'],$bordes,1,'L',false);
		/* T�tulo plan beca */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'T�tulo del Plan de Beca:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->MultiCell($ancho_info,$alto_fila-1,$datos['titulo_plan_beca'],$bordes,'J',false);
		/* LUGAR DE TRABAJO Y AREA */
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Lugar trabajo becario:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['lugar_trabajo_becario'],$bordes,0,'L',false);
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'�rea:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['area_trabajo'],$bordes,1,'L',false);
	}

	function justificacion_codireccion($justificacion,$params)
	{
		extract($params);
		$this->setFont('','B',6);
		$this->Cell(190,4,'JUSTIFICACI�N CODIRECTOR/SUBDIRECTOR',1,1,'C',true);	
		$this->setFont('','',6);
		$this->Cell($ancho_total,$alto_fila,'El Director de Beca deber� justificar la inclusi�n de un Co-Director y/o Sub-Director de Beca, expresando claramente los motivos que hacen necesaria tal inclusi�n.',$bordes,1,'C',false);
		$this->setFont('','B',7);
		$this->Cell($ancho_titulo,$alto_fila,'Justificaci�n:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->MultiCell($ancho_info,$alto_fila-1,$justificacion,$bordes,'J',false);
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
		$this->Cell($ancho_titulo,$alto_fila,'Tel�fono fijo:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*3)) / 3,$alto_fila,$datos['telefono'],$bordes,1,'L',false);
		/* NIVEL ACAD�MICO Y CAT. INCENTIVOS*/
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'M�x. Grado Acad�mico:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		$this->Cell(($ancho_total-($ancho_titulo*2)) / 2,$alto_fila,$datos['nivel_academico'],$bordes,0,'L',false);
		$this->setFont('','B');
		$this->Cell($ancho_titulo,$alto_fila,'Cat. Incentivos:',$bordes,0,$alin_rotulo,false);
		$this->setFont('','');
		if($datos['catinc']){
			$cat_inc = array('1'=>'I','2'=>'II','3'=>'III','4'=>'IV','5'=>'V');
			$datos['catinc'] = 'Categor�a '.$cat_inc[$datos['catinc']].' (Convocatoria '.$datos['catinc_conv'].')';
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
		$this->Cell($ancho_titulo,$alto_fila,'C�digo:',$bordes,0,$alin_rotulo,false);
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
		/* T�tulo plan beca */
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
		$this->MultiCell(190,4,'Declaro conocer el Reglamento de Becas de Investigaci�n de la Universidad Nacional del Nordeste y Aceptar cada una de las obligaciones que de �l derivan, comprometi�ndome a su cumplimiento en caso de que me fuera otorgada la Beca solicitada',1,1,'',false);
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
		$this->MultiCell(190,4,'Declaro conocer el Reglamento de Becas de Investigaci�n de la Universidad Nacional del Nordeste, las obligaciones que de �l derivan y dejo constancia que avalo el Plan de Trabajo del Postulante',1,1,'',false);
		
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
		$this->MultiCell(190,4,'Por la presente presto mi conformidad para que, en caso de ser otorgada la beca solicitada, el postulante pueda realizar el trabajo de investigaci�n propuesto, en el lugar indicado precedentemente',1,1,'',false);
		
		$ancho = 190/2;
		$this->Cell($ancho ,19,'',1,0,'',false);
		$this->Cell($ancho ,19,'',1,1,'',false);
		$this->Cell($ancho,6,'Firma del Secretario de Investigaci�n',1,0,'C',false);
		$this->Cell($ancho,6,'Firma del Decano',1,1,'C',false);
		

	}

	function Header()
	{
		$path = toba::proyecto()->get_www();
        $path = $path['path']."img/logo_membrete.png";
		$this->Image($path,19,5,160,40);
		$this->SetFont('arial','BU',13);
		$this->Cell(190,10,'SOLICITUD DE INSCRIPCI�N - CONCURSO DE BECAS DE INVESTIGACI�N',0,1,'C',false);	
		$this->SetFont('arial','',7);
	}	

	function Footer()
	{
		$this->SetXY(84,-10);
		//Se usa el menos uno porque la car�tula no debe tener el numero 1
		$this->Cell(40,5,'P�gina '.($this->PageNo() - 1),0,0,'C',false);
	}
	function mostrar()
	{
		$this->Output('I','pepe.pdf');
	}
}
?>