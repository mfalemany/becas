--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.9
-- Dumped by pg_dump version 9.5.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: recuperar_schema_temp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION recuperar_schema_temp() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
			DECLARE
			   schemas varchar;
			   pos_inicial int4;
			   pos_final int4;
			   schema_temp varchar;
			BEGIN
			   schema_temp := '';
			   SELECT INTO schemas current_schemas(true);
			   SELECT INTO pos_inicial strpos(schemas, 'pg_temp');
			   IF (pos_inicial > 0) THEN
			      SELECT INTO pos_final strpos(schemas, ',');
			      SELECT INTO schema_temp substr(schemas, pos_inicial, pos_final - pos_inicial);
			   END IF;
			   RETURN schema_temp;
			END;
			$$;


ALTER FUNCTION public.recuperar_schema_temp() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: area_conocimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE area_conocimiento (
    id_area_conocimiento smallint NOT NULL,
    area_conocimiento character varying(75)
);


ALTER TABLE area_conocimiento OWNER TO postgres;

--
-- Name: areas_dependencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE areas_dependencia (
    id_area smallint NOT NULL,
    area character varying(100),
    id_dependencia smallint
);


ALTER TABLE areas_dependencia OWNER TO postgres;

--
-- Name: avance_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE avance_beca (
    id_avance integer NOT NULL,
    fecha date,
    tipo_avance character(1),
    nro_documento character varying(15),
    id_tipo_doc smallint,
    id_convocatoria smallint,
    id_resultado smallint,
    observaciones character varying(500)
);


ALTER TABLE avance_beca OWNER TO postgres;

--
-- Name: baja_becas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE baja_becas (
    nro_documento character varying(15) NOT NULL,
    id_tipo_doc smallint NOT NULL,
    id_convocatoria smallint NOT NULL,
    fecha_baja date,
    id_motivo_baja smallint,
    observaciones character varying(300),
    id_tipo_beca smallint NOT NULL
);


ALTER TABLE baja_becas OWNER TO postgres;

--
-- Name: be_area_conocimiento_id_area_conocimiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_area_conocimiento_id_area_conocimiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_area_conocimiento_id_area_conocimiento_seq OWNER TO postgres;

--
-- Name: be_area_conocimiento_id_area_conocimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_area_conocimiento_id_area_conocimiento_seq OWNED BY area_conocimiento.id_area_conocimiento;


--
-- Name: be_areas_dependencia_id_area_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_areas_dependencia_id_area_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_areas_dependencia_id_area_seq OWNER TO postgres;

--
-- Name: be_areas_dependencia_id_area_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_areas_dependencia_id_area_seq OWNED BY areas_dependencia.id_area;


--
-- Name: be_avance_beca_id_avance_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_avance_beca_id_avance_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_avance_beca_id_avance_seq OWNER TO postgres;

--
-- Name: be_avance_beca_id_avance_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_avance_beca_id_avance_seq OWNED BY avance_beca.id_avance;


--
-- Name: cargos_docente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cargos_docente (
    id_dependencia smallint,
    id_dedicacion smallint,
    id_cargo_unne smallint,
    id_cargo smallint NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date,
    estado character(1) NOT NULL,
    id_tipo_doc smallint,
    nro_documento character varying(15)
);


ALTER TABLE cargos_docente OWNER TO postgres;

--
-- Name: be_cargos_docente_id_cargo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_cargos_docente_id_cargo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_cargos_docente_id_cargo_seq OWNER TO postgres;

--
-- Name: be_cargos_docente_id_cargo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_cargos_docente_id_cargo_seq OWNED BY cargos_docente.id_cargo;


--
-- Name: cargos_unne; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cargos_unne (
    cargo character varying(50),
    id_cargo_unne smallint NOT NULL
);


ALTER TABLE cargos_unne OWNER TO postgres;

--
-- Name: be_cargos_unne_id_cargo_unne_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_cargos_unne_id_cargo_unne_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_cargos_unne_id_cargo_unne_seq OWNER TO postgres;

--
-- Name: be_cargos_unne_id_cargo_unne_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_cargos_unne_id_cargo_unne_seq OWNED BY cargos_unne.id_cargo_unne;


--
-- Name: carreras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE carreras (
    id_carrera smallint NOT NULL,
    carrera character varying(200),
    cod_araucano smallint
);


ALTER TABLE carreras OWNER TO postgres;

--
-- Name: be_carreras_id_carrera_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_carreras_id_carrera_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_carreras_id_carrera_seq OWNER TO postgres;

--
-- Name: be_carreras_id_carrera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_carreras_id_carrera_seq OWNED BY carreras.id_carrera;


--
-- Name: categorias_incentivos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categorias_incentivos (
    id_cat_incentivos smallint NOT NULL,
    nro_categoria smallint,
    categoria character varying(50)
);


ALTER TABLE categorias_incentivos OWNER TO postgres;

--
-- Name: be_categorias_incentivos_id_cat_incentivos_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_categorias_incentivos_id_cat_incentivos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_categorias_incentivos_id_cat_incentivos_seq OWNER TO postgres;

--
-- Name: be_categorias_incentivos_id_cat_incentivos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_categorias_incentivos_id_cat_incentivos_seq OWNED BY categorias_incentivos.id_cat_incentivos;


--
-- Name: dedicacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dedicacion (
    dedicacion character varying(50),
    id_dedicacion smallint NOT NULL
);


ALTER TABLE dedicacion OWNER TO postgres;

--
-- Name: be_dedicacion_id_dedicacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_dedicacion_id_dedicacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_dedicacion_id_dedicacion_seq OWNER TO postgres;

--
-- Name: be_dedicacion_id_dedicacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_dedicacion_id_dedicacion_seq OWNED BY dedicacion.id_dedicacion;


--
-- Name: dependencias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dependencias (
    id_dependencia smallint NOT NULL,
    nombre character varying(150),
    descripcion_corta character varying(30),
    id_universidad smallint,
    id_pais smallint,
    id_provincia smallint,
    id_localidad smallint,
    domicilio character varying(350),
    telefono character varying(75)
);


ALTER TABLE dependencias OWNER TO postgres;

--
-- Name: be_dependencias_id_dependencia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_dependencias_id_dependencia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_dependencias_id_dependencia_seq OWNER TO postgres;

--
-- Name: be_dependencias_id_dependencia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_dependencias_id_dependencia_seq OWNED BY dependencias.id_dependencia;


--
-- Name: localidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE localidades (
    id_provincia smallint NOT NULL,
    id_pais smallint NOT NULL,
    id_localidad smallint NOT NULL,
    localidad character varying(100),
    codigo_postal character varying(10)
);


ALTER TABLE localidades OWNER TO postgres;

--
-- Name: be_localidades_id_localidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_localidades_id_localidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_localidades_id_localidad_seq OWNER TO postgres;

--
-- Name: be_localidades_id_localidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_localidades_id_localidad_seq OWNED BY localidades.id_localidad;


--
-- Name: paises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE paises (
    id_pais smallint NOT NULL,
    pais character varying(100)
);


ALTER TABLE paises OWNER TO postgres;

--
-- Name: be_paises_id_pais_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_paises_id_pais_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_paises_id_pais_seq OWNER TO postgres;

--
-- Name: be_paises_id_pais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_paises_id_pais_seq OWNED BY paises.id_pais;


--
-- Name: provincias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE provincias (
    id_pais smallint NOT NULL,
    id_provincia smallint NOT NULL,
    provincia character varying(100)
);


ALTER TABLE provincias OWNER TO postgres;

--
-- Name: be_provincias_id_provincia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_provincias_id_provincia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_provincias_id_provincia_seq OWNER TO postgres;

--
-- Name: be_provincias_id_provincia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_provincias_id_provincia_seq OWNED BY provincias.id_provincia;


--
-- Name: resultado_avance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE resultado_avance (
    id_resultado smallint NOT NULL,
    resultado character(50),
    activo boolean
);


ALTER TABLE resultado_avance OWNER TO postgres;

--
-- Name: be_resultado_avance_id_resultado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_resultado_avance_id_resultado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_resultado_avance_id_resultado_seq OWNER TO postgres;

--
-- Name: be_resultado_avance_id_resultado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_resultado_avance_id_resultado_seq OWNED BY resultado_avance.id_resultado;


--
-- Name: tipo_documento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_documento (
    id_tipo_doc smallint NOT NULL,
    tipo_doc character varying(50)
);


ALTER TABLE tipo_documento OWNER TO postgres;

--
-- Name: be_tipo_documento_id_tipo_doc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_tipo_documento_id_tipo_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_tipo_documento_id_tipo_doc_seq OWNER TO postgres;

--
-- Name: be_tipo_documento_id_tipo_doc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_tipo_documento_id_tipo_doc_seq OWNED BY tipo_documento.id_tipo_doc;


--
-- Name: tipos_resolucion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipos_resolucion (
    id_tipo_resol smallint NOT NULL,
    tipo_resol character varying(100) NOT NULL,
    tipo_resol_corto character varying(25) NOT NULL
);


ALTER TABLE tipos_resolucion OWNER TO postgres;

--
-- Name: be_tipos_resolucion_id_tipo_resol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_tipos_resolucion_id_tipo_resol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_tipos_resolucion_id_tipo_resol_seq OWNER TO postgres;

--
-- Name: be_tipos_resolucion_id_tipo_resol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_tipos_resolucion_id_tipo_resol_seq OWNED BY tipos_resolucion.id_tipo_resol;


--
-- Name: universidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE universidades (
    id_universidad smallint NOT NULL,
    universidad character varying(200),
    id_pais smallint,
    sigla character varying(50)
);


ALTER TABLE universidades OWNER TO postgres;

--
-- Name: be_universidades_id_universidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE be_universidades_id_universidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE be_universidades_id_universidad_seq OWNER TO postgres;

--
-- Name: be_universidades_id_universidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE be_universidades_id_universidad_seq OWNED BY universidades.id_universidad;


--
-- Name: becas_otorgadas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE becas_otorgadas (
    nro_resol smallint,
    anio smallint,
    nro_documento character varying(15) NOT NULL,
    id_tipo_doc smallint NOT NULL,
    id_convocatoria smallint NOT NULL,
    fecha_desde date,
    fecha_hasta date,
    fecha_toma_posesion date,
    id_tipo_resol smallint,
    id_tipo_beca smallint NOT NULL
);


ALTER TABLE becas_otorgadas OWNER TO postgres;

--
-- Name: carrera_dependencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE carrera_dependencia (
    id_dependencia smallint NOT NULL,
    id_carrera smallint NOT NULL
);


ALTER TABLE carrera_dependencia OWNER TO postgres;

--
-- Name: categorias_conicet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categorias_conicet (
    id_cat_conicet smallint NOT NULL,
    nro_categoria smallint,
    categoria character varying(50)
);


ALTER TABLE categorias_conicet OWNER TO postgres;

--
-- Name: categorias_conicet_id_cat_conicet_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categorias_conicet_id_cat_conicet_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categorias_conicet_id_cat_conicet_seq OWNER TO postgres;

--
-- Name: categorias_conicet_id_cat_conicet_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categorias_conicet_id_cat_conicet_seq OWNED BY categorias_conicet.id_cat_conicet;


--
-- Name: color_carpeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE color_carpeta (
    id_color smallint NOT NULL,
    color character varying(75) NOT NULL
);


ALTER TABLE color_carpeta OWNER TO postgres;

--
-- Name: color_carpeta_id_color_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE color_carpeta_id_color_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE color_carpeta_id_color_seq OWNER TO postgres;

--
-- Name: color_carpeta_id_color_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE color_carpeta_id_color_seq OWNED BY color_carpeta.id_color;


--
-- Name: comision_asesora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE comision_asesora (
    id_area_conocimiento smallint NOT NULL,
    id_convocatoria smallint NOT NULL
);


ALTER TABLE comision_asesora OWNER TO postgres;

--
-- Name: convocatoria_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE convocatoria_beca (
    fecha_desde date,
    fecha_hasta date,
    limite_movimientos date NOT NULL,
    id_convocatoria smallint NOT NULL,
    convocatoria character varying(300),
    id_tipo_convocatoria smallint,
    CONSTRAINT ck_convocatoria_beca_fechas CHECK ((fecha_desde <= fecha_hasta))
);


ALTER TABLE convocatoria_beca OWNER TO postgres;

--
-- Name: convocatoria_beca_id_convocatoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE convocatoria_beca_id_convocatoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE convocatoria_beca_id_convocatoria_seq OWNER TO postgres;

--
-- Name: convocatoria_beca_id_convocatoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE convocatoria_beca_id_convocatoria_seq OWNED BY convocatoria_beca.id_convocatoria;


--
-- Name: cumplimiento_obligacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cumplimiento_obligacion (
    id_tipo_doc smallint NOT NULL,
    nro_documento character varying(15) NOT NULL,
    mes numeric(2,0) NOT NULL,
    anio numeric(4,0) NOT NULL,
    fecha_cumplimiento date,
    id_convocatoria smallint NOT NULL,
    id_tipo_beca smallint NOT NULL
);


ALTER TABLE cumplimiento_obligacion OWNER TO postgres;

--
-- Name: docentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE docentes (
    nro_documento character varying(15) NOT NULL,
    id_tipo_doc smallint NOT NULL,
    legajo character varying(20) NOT NULL,
    id_cat_incentivos smallint,
    id_cat_conicet smallint,
    id_dependencia_conicet smallint
);


ALTER TABLE docentes OWNER TO postgres;

--
-- Name: inscripcion_conv_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE inscripcion_conv_beca (
    id_dependencia smallint,
    nro_documento character varying(15) NOT NULL,
    id_tipo_doc smallint NOT NULL,
    id_convocatoria smallint NOT NULL,
    fecha_hora timestamp without time zone,
    admisible character(1),
    puntaje numeric(6,3),
    beca_otorgada boolean,
    id_area_conocimiento smallint,
    titulo_plan_beca character varying(300),
    justif_codirector character varying(400),
    id_carrera smallint,
    materias_plan numeric(3,0),
    materias_aprobadas numeric(3,0),
    prom_hist_egresados numeric(4,2),
    prom_hist numeric(4,2),
    carrera_posgrado character varying(200),
    nombre_inst_posgrado character varying(200),
    titulo_carrera_posgrado character varying(200),
    nro_carpeta character varying(8),
    observaciones character varying(200),
    estado character(1) NOT NULL,
    cant_fojas numeric(3,0),
    es_titular character(1) NOT NULL,
    id_tipo_beca smallint NOT NULL,
    id_proyecto smallint,
    es_egresado character(1),
    anio_ingreso numeric(4,0),
    anio_egreso numeric(4,0),
    fecha_insc_posgrado date,
    lugar_trabajo_becario smallint,
    area_trabajo character varying(300),
    id_tipo_doc_dir smallint,
    nro_documento_dir character varying(15),
    id_tipo_doc_codir smallint,
    nro_documento_codir character varying(15),
    id_tipo_doc_subdir smallint,
    nro_documento_subdir character varying(15)
);


ALTER TABLE inscripcion_conv_beca OWNER TO postgres;

--
-- Name: COLUMN inscripcion_conv_beca.estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN inscripcion_conv_beca.estado IS 'Este campo trabaja en combinación con el campo "limite_movimientos" de la tabla "convocatoria_categoria". Cuando el estado de la inscripcion es Pendiente ("P"), y suponiendo que la fecha fin de inscripción ya pasó, el becario podrá seguir modificando su inscripción hasta dicha fecha. 
Está pensado para casos en los que el becario tiene problemas en su inscripción y necesita mas tiempo que el establecido en el periodo predefinido.';


--
-- Name: integrante_comision_asesora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE integrante_comision_asesora (
    nro_documento character varying(15) NOT NULL,
    id_tipo_doc smallint NOT NULL,
    id_convocatoria smallint NOT NULL,
    id_area_conocimiento smallint NOT NULL
);


ALTER TABLE integrante_comision_asesora OWNER TO postgres;

--
-- Name: motivos_baja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE motivos_baja (
    id_motivo_baja smallint NOT NULL,
    motivo_baja character varying(75)
);


ALTER TABLE motivos_baja OWNER TO postgres;

--
-- Name: motivos_baja_id_motivo_baja_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE motivos_baja_id_motivo_baja_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE motivos_baja_id_motivo_baja_seq OWNER TO postgres;

--
-- Name: motivos_baja_id_motivo_baja_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE motivos_baja_id_motivo_baja_seq OWNED BY motivos_baja.id_motivo_baja;


--
-- Name: niveles_academicos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE niveles_academicos (
    nivel_academico character varying(50) NOT NULL,
    orden numeric(2,0) NOT NULL,
    id_nivel_academico smallint NOT NULL
);


ALTER TABLE niveles_academicos OWNER TO postgres;

--
-- Name: niveles_academicos_id_nivel_academico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE niveles_academicos_id_nivel_academico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE niveles_academicos_id_nivel_academico_seq OWNER TO postgres;

--
-- Name: niveles_academicos_id_nivel_academico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE niveles_academicos_id_nivel_academico_seq OWNED BY niveles_academicos.id_nivel_academico;


--
-- Name: personas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE personas (
    nro_documento character varying(15) NOT NULL,
    id_tipo_doc smallint NOT NULL,
    apellido character varying(100),
    nombres character varying(100),
    cuil character varying(15),
    fecha_nac date,
    celular character varying(25),
    email character varying(100),
    telefono character varying(40),
    id_localidad smallint,
    id_provincia smallint,
    id_pais smallint,
    id_nivel_academico smallint,
    sexo character(1)
);


ALTER TABLE personas OWNER TO postgres;

--
-- Name: proyectos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE proyectos (
    proyecto character varying(300),
    codigo character varying(30),
    id_proyecto smallint NOT NULL
);


ALTER TABLE proyectos OWNER TO postgres;

--
-- Name: requisitos_convocatoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE requisitos_convocatoria (
    id_convocatoria smallint NOT NULL,
    requisito character varying(100),
    obligatorio character(1),
    id_requisito smallint NOT NULL
);


ALTER TABLE requisitos_convocatoria OWNER TO postgres;

--
-- Name: requisitos_convocatoria_id_requisito_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE requisitos_convocatoria_id_requisito_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE requisitos_convocatoria_id_requisito_seq OWNER TO postgres;

--
-- Name: requisitos_convocatoria_id_requisito_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE requisitos_convocatoria_id_requisito_seq OWNED BY requisitos_convocatoria.id_requisito;


--
-- Name: requisitos_insc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE requisitos_insc (
    id_tipo_doc smallint NOT NULL,
    nro_documento character varying(15) NOT NULL,
    id_convocatoria smallint NOT NULL,
    id_tipo_beca smallint NOT NULL,
    id_requisito smallint NOT NULL,
    cumplido character(1) DEFAULT 'N'::bpchar NOT NULL,
    fecha date
);


ALTER TABLE requisitos_insc OWNER TO postgres;

--
-- Name: resoluciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE resoluciones (
    nro_resol smallint NOT NULL,
    anio smallint NOT NULL,
    fecha date,
    archivo_pdf character varying(100),
    id_tipo_resol smallint NOT NULL
);


ALTER TABLE resoluciones OWNER TO postgres;

--
-- Name: tipos_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipos_beca (
    id_tipo_beca smallint NOT NULL,
    id_tipo_convocatoria smallint,
    tipo_beca character varying(150),
    duracion_meses numeric(3,0),
    meses_present_avance numeric(3,0),
    cupo_maximo numeric(5,0),
    id_color smallint,
    estado character(1) DEFAULT 'A'::bpchar
);


ALTER TABLE tipos_beca OWNER TO postgres;

--
-- Name: tipos_beca_id_tipo_beca_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipos_beca_id_tipo_beca_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipos_beca_id_tipo_beca_seq OWNER TO postgres;

--
-- Name: tipos_beca_id_tipo_beca_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipos_beca_id_tipo_beca_seq OWNED BY tipos_beca.id_tipo_beca;


--
-- Name: tipos_convocatoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipos_convocatoria (
    id_tipo_convocatoria smallint NOT NULL,
    tipo_convocatoria character varying(150)
);


ALTER TABLE tipos_convocatoria OWNER TO postgres;

--
-- Name: tipos_convocatoria_id_tipo_convocatoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipos_convocatoria_id_tipo_convocatoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipos_convocatoria_id_tipo_convocatoria_seq OWNER TO postgres;

--
-- Name: tipos_convocatoria_id_tipo_convocatoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipos_convocatoria_id_tipo_convocatoria_seq OWNED BY tipos_convocatoria.id_tipo_convocatoria;


--
-- Name: id_area_conocimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY area_conocimiento ALTER COLUMN id_area_conocimiento SET DEFAULT nextval('be_area_conocimiento_id_area_conocimiento_seq'::regclass);


--
-- Name: id_area; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY areas_dependencia ALTER COLUMN id_area SET DEFAULT nextval('be_areas_dependencia_id_area_seq'::regclass);


--
-- Name: id_avance; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avance_beca ALTER COLUMN id_avance SET DEFAULT nextval('be_avance_beca_id_avance_seq'::regclass);


--
-- Name: id_cargo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_docente ALTER COLUMN id_cargo SET DEFAULT nextval('be_cargos_docente_id_cargo_seq'::regclass);


--
-- Name: id_cargo_unne; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_unne ALTER COLUMN id_cargo_unne SET DEFAULT nextval('be_cargos_unne_id_cargo_unne_seq'::regclass);


--
-- Name: id_carrera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carreras ALTER COLUMN id_carrera SET DEFAULT nextval('be_carreras_id_carrera_seq'::regclass);


--
-- Name: id_cat_conicet; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias_conicet ALTER COLUMN id_cat_conicet SET DEFAULT nextval('categorias_conicet_id_cat_conicet_seq'::regclass);


--
-- Name: id_cat_incentivos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias_incentivos ALTER COLUMN id_cat_incentivos SET DEFAULT nextval('be_categorias_incentivos_id_cat_incentivos_seq'::regclass);


--
-- Name: id_color; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY color_carpeta ALTER COLUMN id_color SET DEFAULT nextval('color_carpeta_id_color_seq'::regclass);


--
-- Name: id_convocatoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY convocatoria_beca ALTER COLUMN id_convocatoria SET DEFAULT nextval('convocatoria_beca_id_convocatoria_seq'::regclass);


--
-- Name: id_dedicacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dedicacion ALTER COLUMN id_dedicacion SET DEFAULT nextval('be_dedicacion_id_dedicacion_seq'::regclass);


--
-- Name: id_dependencia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencias ALTER COLUMN id_dependencia SET DEFAULT nextval('be_dependencias_id_dependencia_seq'::regclass);


--
-- Name: id_localidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidades ALTER COLUMN id_localidad SET DEFAULT nextval('be_localidades_id_localidad_seq'::regclass);


--
-- Name: id_nivel_academico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY niveles_academicos ALTER COLUMN id_nivel_academico SET DEFAULT nextval('niveles_academicos_id_nivel_academico_seq'::regclass);


--
-- Name: id_provincia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincias ALTER COLUMN id_provincia SET DEFAULT nextval('be_provincias_id_provincia_seq'::regclass);


--
-- Name: id_requisito; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requisitos_convocatoria ALTER COLUMN id_requisito SET DEFAULT nextval('requisitos_convocatoria_id_requisito_seq'::regclass);


--
-- Name: id_resultado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resultado_avance ALTER COLUMN id_resultado SET DEFAULT nextval('be_resultado_avance_id_resultado_seq'::regclass);


--
-- Name: id_tipo_doc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_documento ALTER COLUMN id_tipo_doc SET DEFAULT nextval('be_tipo_documento_id_tipo_doc_seq'::regclass);


--
-- Name: id_tipo_beca; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_beca ALTER COLUMN id_tipo_beca SET DEFAULT nextval('tipos_beca_id_tipo_beca_seq'::regclass);


--
-- Name: id_tipo_convocatoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_convocatoria ALTER COLUMN id_tipo_convocatoria SET DEFAULT nextval('tipos_convocatoria_id_tipo_convocatoria_seq'::regclass);


--
-- Name: id_tipo_resol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_resolucion ALTER COLUMN id_tipo_resol SET DEFAULT nextval('be_tipos_resolucion_id_tipo_resol_seq'::regclass);


--
-- Name: id_universidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY universidades ALTER COLUMN id_universidad SET DEFAULT nextval('be_universidades_id_universidad_seq'::regclass);


--
-- Data for Name: area_conocimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY area_conocimiento (id_area_conocimiento, area_conocimiento) FROM stdin;
\.


--
-- Data for Name: areas_dependencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY areas_dependencia (id_area, area, id_dependencia) FROM stdin;
\.


--
-- Data for Name: avance_beca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY avance_beca (id_avance, fecha, tipo_avance, nro_documento, id_tipo_doc, id_convocatoria, id_resultado, observaciones) FROM stdin;
\.


--
-- Data for Name: baja_becas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY baja_becas (nro_documento, id_tipo_doc, id_convocatoria, fecha_baja, id_motivo_baja, observaciones, id_tipo_beca) FROM stdin;
\.


--
-- Name: be_area_conocimiento_id_area_conocimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_area_conocimiento_id_area_conocimiento_seq', 1, true);


--
-- Name: be_areas_dependencia_id_area_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_areas_dependencia_id_area_seq', 1, false);


--
-- Name: be_avance_beca_id_avance_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_avance_beca_id_avance_seq', 1, false);


--
-- Name: be_cargos_docente_id_cargo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_cargos_docente_id_cargo_seq', 1, true);


--
-- Name: be_cargos_unne_id_cargo_unne_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_cargos_unne_id_cargo_unne_seq', 4, true);


--
-- Name: be_carreras_id_carrera_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_carreras_id_carrera_seq', 64, true);


--
-- Name: be_categorias_incentivos_id_cat_incentivos_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_categorias_incentivos_id_cat_incentivos_seq', 5, true);


--
-- Name: be_dedicacion_id_dedicacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_dedicacion_id_dedicacion_seq', 3, true);


--
-- Name: be_dependencias_id_dependencia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_dependencias_id_dependencia_seq', 128, true);


--
-- Name: be_localidades_id_localidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_localidades_id_localidad_seq', 14236, true);


--
-- Name: be_paises_id_pais_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_paises_id_pais_seq', 1, false);


--
-- Name: be_provincias_id_provincia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_provincias_id_provincia_seq', 404, true);


--
-- Name: be_resultado_avance_id_resultado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_resultado_avance_id_resultado_seq', 1, false);


--
-- Name: be_tipo_documento_id_tipo_doc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_tipo_documento_id_tipo_doc_seq', 2, true);


--
-- Name: be_tipos_resolucion_id_tipo_resol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_tipos_resolucion_id_tipo_resol_seq', 1, false);


--
-- Name: be_universidades_id_universidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_universidades_id_universidad_seq', 1, true);


--
-- Data for Name: becas_otorgadas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY becas_otorgadas (nro_resol, anio, nro_documento, id_tipo_doc, id_convocatoria, fecha_desde, fecha_hasta, fecha_toma_posesion, id_tipo_resol, id_tipo_beca) FROM stdin;
\.


--
-- Data for Name: cargos_docente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cargos_docente (id_dependencia, id_dedicacion, id_cargo_unne, id_cargo, fecha_desde, fecha_hasta, estado, id_tipo_doc, nro_documento) FROM stdin;
\.


--
-- Data for Name: cargos_unne; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cargos_unne (cargo, id_cargo_unne) FROM stdin;
Jefe de Trabajos Prácticos	3
Adjunto	2
Titular	1
Auxiliar de Docencia	4
\.


--
-- Data for Name: carrera_dependencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY carrera_dependencia (id_dependencia, id_carrera) FROM stdin;
69	5
69	17
65	1
\.


--
-- Data for Name: carreras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY carreras (id_carrera, carrera, cod_araucano) FROM stdin;
1	Ingeniería Agronómica	\N
2	Tecnicatura En DiseÑo De Imagen, Sonido Y Multimedia	\N
3	Licenciatura En Artes Combinadas	\N
4	Licenciatura En GestiÓn Y Desarrollo Cultural	\N
5	Abogacía	\N
13	Martillero Público Y Corredor De Comercio	\N
17	Abogacía Ciclo De Complementación	\N
18	Notariado Ciclo De Complementación	\N
19	OdontologÍa	\N
20	Tecnicatura En GestiÓn De Instituciones Universitarias Del Área De La Salud	\N
21	Tecnicatura Superior Universitaria En Laboratorio Dental	\N
22	Licenciatura En Ciencias FÍsicas	\N
23	Licenciatura En Ciencias QuÍmicas	\N
24	BioquÍmica	\N
25	Profesorado En BiologÍa	\N
26	Licenciatura En Sistemas De InformaciÓn	\N
27	Licenciatura En Ciencias BiolÓgicas	\N
28	Profesorado En MatemÁtica	\N
29	Licenciatura En MatemÁtica	\N
30	Profesorado En Ciencias QuÍmicas Y Del Ambiente	\N
31	Profesorado En FÍsica	\N
35	Licenciatura En Criminalistica	\N
36	Contador Publico	\N
39	Licenciatura En Economia	\N
40	Licenciatura En Administracion	\N
41	Profesorado En Letras	\N
42	Licenciatura En Letras	\N
43	Profesorado En Geografía	\N
44	Licenciatura En Geografía	\N
45	Profesorado En Historia	\N
46	Licenciatura En Historia	\N
47	Profesorado En Ciencias De La Educación	\N
48	Licenciatura En Ciencias De La Educación	\N
49	Profesorado En Filosofía	\N
50	Licenciatura En Filosofía	\N
51	Lic.en Ciencias De La Información C/orientación Archivología	\N
52	Lic.en Ciencias De La Información C/orientación Bibliotecol.	\N
53	Profesorado En Educación Inicial	\N
54	Licenciatura En Educación Inicial	\N
55	Licenciatura En Comunicación Social	\N
57	Profesorado De Educación Superior - Ciclo De Profesorado	\N
59	Licenciatura En Historia-ciclo De Licenciatura	\N
60	Medicina	\N
61	Licenciatura En Enfermería	\N
62	Licenciatura En Kinesiología Y Fisiatría	\N
63	Ciencias Veterinarias	\N
64	Licenciatura En Relaciones Laborales	\N
32	Ingeniería Eléctrica	\N
34	Ingeniería En Agrimensura	\N
33	Ingeniería En Electrónica	\N
\.


--
-- Data for Name: categorias_conicet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categorias_conicet (id_cat_conicet, nro_categoria, categoria) FROM stdin;
1	1	Categoría I
2	2	Categoría II
3	3	Categoría III
4	4	Categoría IV
5	5	Categoría V
\.


--
-- Name: categorias_conicet_id_cat_conicet_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categorias_conicet_id_cat_conicet_seq', 5, true);


--
-- Data for Name: categorias_incentivos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categorias_incentivos (id_cat_incentivos, nro_categoria, categoria) FROM stdin;
1	1	Categoría I
2	2	Categoría II
3	3	Categoría III
4	4	Categoría IV
5	5	Categoría V
\.


--
-- Data for Name: color_carpeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY color_carpeta (id_color, color) FROM stdin;
1	Azul
2	Amarillo
3	Verde
\.


--
-- Name: color_carpeta_id_color_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('color_carpeta_id_color_seq', 3, true);


--
-- Data for Name: comision_asesora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comision_asesora (id_area_conocimiento, id_convocatoria) FROM stdin;
\.


--
-- Data for Name: convocatoria_beca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY convocatoria_beca (fecha_desde, fecha_hasta, limite_movimientos, id_convocatoria, convocatoria, id_tipo_convocatoria) FROM stdin;
\.


--
-- Name: convocatoria_beca_id_convocatoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('convocatoria_beca_id_convocatoria_seq', 1, true);


--
-- Data for Name: cumplimiento_obligacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cumplimiento_obligacion (id_tipo_doc, nro_documento, mes, anio, fecha_cumplimiento, id_convocatoria, id_tipo_beca) FROM stdin;
\.


--
-- Data for Name: dedicacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dedicacion (dedicacion, id_dedicacion) FROM stdin;
Simple	1
Semi-Exclusiva	2
Exclusiva	3
\.


--
-- Data for Name: dependencias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dependencias (id_dependencia, nombre, descripcion_corta, id_universidad, id_pais, id_provincia, id_localidad, domicilio, telefono) FROM stdin;
66	Facultad De Artes, Diseño Y Ciencias De La Cultura	ART	1	\N	\N	\N	\N	\N
69	Facultad De Derecho Y Ciencias Sociales Y Politicas	DCH	1	\N	\N	\N	\N	\N
83	Facultad De Odontología	ODN	1	\N	\N	\N	\N	\N
86	Facultad De Ciencias Exactas Y Naturales Y Agrimensura	EXA	1	\N	\N	\N	\N	\N
99	Instituto De Ciencias Criminalísticas Y Criminología	CRI	1	\N	\N	\N	\N	\N
100	Facultad De Ciencias Económicas	ECON	1	\N	\N	\N	\N	\N
105	Facultad De Humanidades	HUM	1	\N	\N	\N	\N	\N
121	Facultad Humanidades-carreras De Articulación	SIU	1	\N	\N	\N	\N	\N
124	Facultad De Medicina	MED	1	\N	\N	\N	\N	\N
127	Facultad De Ciencias Veterinarias	VET	1	\N	\N	\N	\N	\N
128	Facultad De Ciencias Economicas	LAB	1	\N	\N	\N	\N	\N
65	Facultad De Ciencias Agrarias	AGR	1	54	130	4669	Sargento Cabral 2131	4427589
\.


--
-- Data for Name: docentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY docentes (nro_documento, id_tipo_doc, legajo, id_cat_incentivos, id_cat_conicet, id_dependencia_conicet) FROM stdin;
\.


--
-- Data for Name: inscripcion_conv_beca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY inscripcion_conv_beca (id_dependencia, nro_documento, id_tipo_doc, id_convocatoria, fecha_hora, admisible, puntaje, beca_otorgada, id_area_conocimiento, titulo_plan_beca, justif_codirector, id_carrera, materias_plan, materias_aprobadas, prom_hist_egresados, prom_hist, carrera_posgrado, nombre_inst_posgrado, titulo_carrera_posgrado, nro_carpeta, observaciones, estado, cant_fojas, es_titular, id_tipo_beca, id_proyecto, es_egresado, anio_ingreso, anio_egreso, fecha_insc_posgrado, lugar_trabajo_becario, area_trabajo, id_tipo_doc_dir, nro_documento_dir, id_tipo_doc_codir, nro_documento_codir, id_tipo_doc_subdir, nro_documento_subdir) FROM stdin;
\.


--
-- Data for Name: integrante_comision_asesora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY integrante_comision_asesora (nro_documento, id_tipo_doc, id_convocatoria, id_area_conocimiento) FROM stdin;
\.


--
-- Data for Name: localidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY localidades (id_provincia, id_pais, id_localidad, localidad, codigo_postal) FROM stdin;
126	54	2	Ciudad Autónoma de Buenos Aires	\N
127	54	3	LEUBUCO	\N
127	54	4	CHOPI TALO	\N
127	54	5	COLONIA MURATURE	\N
127	54	6	COLONIA NAVEIRA	\N
127	54	7	EL PARQUE	\N
127	54	8	FRANCISCO MURATURE	\N
127	54	9	LA PALA	\N
127	54	10	LOS GAUCHOS (APEADERO FCDFS)	\N
127	54	11	MAZA	\N
127	54	12	THAMES	\N
127	54	13	VILLA MAZA	\N
127	54	14	ADOLFO ALSINA	\N
127	54	15	CARHUE	\N
127	54	16	FATRALO	\N
127	54	17	JUAN V. CILLEY	\N
127	54	18	POCITO	\N
127	54	19	ESTACION LAGO EPECUEN	\N
127	54	20	LAGO EPECUEN	\N
127	54	21	ARTURO VATTEONE	\N
127	54	22	COLONIA BARON HIRSCH	\N
127	54	23	RIVERA	\N
127	54	24	ARANO	\N
127	54	25	TRES LAGUNAS	\N
127	54	26	YUTUYACO	\N
127	54	27	AVESTRUZ	\N
127	54	28	CAÑADA MARIANO (EMBARCADERO FCDFS)	\N
127	54	29	CAMPO DEL NORTE AMERICANO	\N
127	54	30	CAMPO LA ZULEMA	\N
127	54	31	CAMPO LOS AROMOS	\N
127	54	32	CAMPO SAN JUAN	\N
127	54	33	CANONIGO GORRITI	\N
127	54	34	COLONIA LAPIN	\N
127	54	35	COLONIA SANTA MARIANA	\N
127	54	36	DELFIN HUERGO	\N
127	54	37	ESTEBAN A. GASCON	\N
127	54	38	LA FLORIDA	\N
127	54	39	LA ZULEMA	\N
127	54	40	SAN ANTONIO	\N
127	54	41	SAN MIGUEL ARCANGEL	\N
127	54	42	VILLA MARGARITA	\N
127	54	43	ADOLFO GONZALES CHAVES	\N
127	54	44	ALZAGA	\N
127	54	45	EL LUCERO	\N
127	54	46	DE LA GARMA	\N
127	54	47	PEDRO P. LASSALLE	\N
127	54	48	JUAN E. BARRA	\N
127	54	49	VAZQUEZ	\N
127	54	50	PRESIDENTE QUINTANA	\N
127	54	51	GRISOLIA	\N
127	54	52	COLONIA ZAMBUNGO	\N
127	54	53	CORONEL MOM	\N
127	54	54	CORONEL SEGUI	\N
127	54	55	VILLA MARIA	\N
127	54	56	VILLA ORTIZ	\N
127	54	57	ALBERTI	\N
127	54	58	ANDRES VACCAREZZA	\N
127	54	59	EMITA	\N
127	54	60	LARREA	\N
127	54	61	PLA	\N
127	54	62	PALANTELEN	\N
127	54	63	BAUDRIX	\N
127	54	64	COLONIA PALANTELEN	\N
127	54	65	SAN JOSE	\N
127	54	66	MECHITA	\N
127	54	67	ADROGUE	\N
127	54	68	ALMIRANTE BROWN	\N
127	54	69	MALVINAS ARGENTINAS	\N
127	54	70	JOSE MARMOL	\N
127	54	71	RAFAEL CALZADA	\N
127	54	72	VILLA LAURA (RAFAEL CALZADA)	\N
127	54	73	CLAYPOLE	\N
127	54	74	BURZACO	\N
127	54	75	MINISTRO RIVADAVIA	\N
127	54	76	LONGCHAMPS	\N
127	54	77	GLEW	\N
127	54	78	SAN JOSE	\N
127	54	79	SAN FRANCISCO SOLANO	\N
127	54	80	AVELLANEDA	\N
127	54	81	BULLRICH	\N
127	54	82	CRUCECITA	\N
127	54	83	GERLI (AVELLANEDA)	\N
127	54	84	LA MOSCA	\N
127	54	85	PIÑEYRO	\N
127	54	86	VILLA CASTELLINO	\N
127	54	87	VILLA MERCADO	\N
127	54	88	DOCK SUD	\N
127	54	89	ISLA MACIEL	\N
127	54	90	SARANDI	\N
127	54	91	COSTA DE VILLA DOMINICO	\N
127	54	92	VILLA BARILARI	\N
127	54	93	VILLA CORINA	\N
127	54	94	VILLA DOMINICO	\N
127	54	95	VILLA HUE	\N
127	54	96	VILLA ITE	\N
127	54	97	VILLA NUÑEZ	\N
127	54	98	WILDE	\N
127	54	99	WILDE ESTE	\N
127	54	100	BARRIO PASCO	\N
127	54	101	AYACUCHO	\N
127	54	102	SAN IGNACIO	\N
127	54	103	SAN LAUREANO	\N
127	54	104	LANGUEYU	\N
127	54	105	LAS SULTANAS	\N
127	54	106	SOLANET	\N
127	54	107	UDAQUIOLA	\N
127	54	108	CANGALLO	\N
127	54	109	FAIR	\N
127	54	110	LA CONSTANCIA	\N
127	54	111	CACHARI	\N
127	54	112	LAGUNA MEDINA	\N
127	54	113	MIRAMONTE	\N
127	54	114	AZUL	\N
127	54	115	CAMINERA AZUL	\N
127	54	116	ESTACION LAZZARINO	\N
127	54	117	LA COLORADA	\N
127	54	118	LA MANTEQUERIA	\N
127	54	119	LAS CORTADERAS	\N
127	54	120	SHAW	\N
127	54	121	ARIEL	\N
127	54	122	ARROYO DE LOS HUESOS	\N
127	54	123	FRANCISCO J. MEEKS	\N
127	54	124	PABLO ACOSTA	\N
127	54	125	CAMPODONICO	\N
127	54	126	COVELLO	\N
127	54	127	SAN GERVASIO	\N
127	54	128	CHILLAR	\N
127	54	129	LA PROTEGIDA	\N
127	54	130	MARTIN FIERRO	\N
127	54	131	SAN RAMON DE ANCHORENA	\N
127	54	132	BERNARDO VERA Y PINTADO	\N
127	54	133	DIECISEIS DE JULIO	\N
127	54	134	KM 433	\N
127	54	135	LA CHUMBEADA	\N
127	54	136	LAS NIEVES	\N
127	54	137	NIEVES	\N
127	54	138	PARISH	\N
127	54	139	CERRO AGUILA	\N
127	54	140	ADELA CORTI	\N
127	54	141	BAHIA BLANCA	\N
127	54	142	BARRIO ALMAFUERTE (BAHIA BLANCA)	\N
127	54	143	BARRIO AVELLANEDA (BAHIA BLANCA)	\N
127	54	144	BARRIO LA FALDA	\N
127	54	145	BARRIO LOMA PARAGUAYA	\N
127	54	146	BARRIO NOROESTE	\N
127	54	147	BARRIO PARQUE PATAGONIA	\N
127	54	148	BARRIO ROSARIO SUD	\N
127	54	149	BARRIO SAN BLAS	\N
127	54	150	BARRIO SAN MARTIN (BAHIA BLANCA)	\N
127	54	151	BARRIO SAN ROQUE (BAHIA BLANCA)	\N
127	54	152	BARRIO TIRO FEDERAL (BAHIA BLANCA)	\N
127	54	153	BARRIO VILLA MUÑIZ	\N
127	54	154	BARRIO VISTA ALEGRE (BAHIA BLANCA)	\N
127	54	155	BELLA VISTA (BAHIA BLANCA)	\N
127	54	156	BORDEU	\N
127	54	157	CHOIQUE	\N
127	54	158	CORONEL MALDONADO	\N
127	54	159	PUERTO GALVAN	\N
127	54	160	VILLA BUENOS AIRES	\N
127	54	161	VILLA CERRITO	\N
127	54	162	VILLA DELFINA	\N
127	54	163	VILLA DOMINGO PRONSATO	\N
127	54	164	VILLA FLORESTA	\N
127	54	165	VILLA ITALIA (BAHIA BLANCA)	\N
127	54	166	VILLA LIBRES	\N
127	54	167	VILLA LORETO	\N
127	54	168	VILLA NOCITO	\N
127	54	169	VILLA OBRERA	\N
127	54	170	VILLA OLGA	\N
127	54	171	VILLA SANCHEZ ELIA	\N
127	54	172	VILLA SOLDATI	\N
127	54	173	ALDEA ROMANA	\N
127	54	174	GALVAN	\N
127	54	175	GRUNBEIN	\N
127	54	176	VILLA HARDING GREEN	\N
127	54	177	VILLA HERMINIA	\N
127	54	178	GARRO	\N
127	54	179	INGENIERO WHITE	\N
127	54	180	PUERTO BAHIA BLANCA	\N
127	54	181	SPURR	\N
127	54	182	VILLA ROSAS	\N
127	54	183	VILLA SERRA	\N
127	54	184	AGUARA	\N
127	54	185	CUATREROS	\N
127	54	186	GENERAL DANIEL CERRI	\N
127	54	187	SAUCE CHICO	\N
127	54	188	VILLA ESPORA	\N
127	54	189	ALFEREZ SAN MARTIN	\N
127	54	190	VENANCIO	\N
127	54	191	CABILDO	\N
127	54	192	COCHRANE	\N
127	54	193	CORTI	\N
127	54	194	LA VITICOLA	\N
127	54	195	NAPOSTA	\N
127	54	196	CAMINERA NAPALEOFU	\N
127	54	197	EL HERVIDERO	\N
127	54	198	LA ESPERANZA (NAPALEOFU- BALCARCE)	\N
127	54	199	LAS SUIZAS	\N
127	54	200	NAPALEOFU	\N
127	54	201	BALCARCE	\N
127	54	202	BOSCH	\N
127	54	203	EL JUNCO	\N
127	54	204	EL VERANO	\N
127	54	205	HARAS OJO DE AGUA	\N
127	54	206	LA BRAVA	\N
127	54	207	LAGUNA BRAVA	\N
127	54	208	LOS CARDOS	\N
127	54	209	LA SARA (RAMOS OTERO)	\N
127	54	210	RAMOS OTERO	\N
127	54	211	RINCON DE BAUDRIX	\N
127	54	212	SAN SIMON	\N
127	54	213	CAMPO LA PLATA	\N
127	54	214	CAMPO LEITE	\N
127	54	215	LOS PINOS	\N
127	54	216	SAN AGUSTIN	\N
127	54	217	EL SILENCIO	\N
127	54	218	SANTA COLOMA	\N
127	54	219	ISLA LOS LAURELES	\N
127	54	220	OLIVEIRA CEZAR	\N
127	54	221	PANAME	\N
127	54	222	ALSINA	\N
127	54	223	BARADERO	\N
127	54	224	ESTACION BARADERO	\N
127	54	225	IRINEO PORTELA	\N
127	54	226	ALMACEN LA COLONIA	\N
127	54	227	ARRECIFES	\N
127	54	228	CAÑADA MARTA	\N
127	54	229	EL NACIONAL	\N
127	54	230	LA DELIA	\N
127	54	231	LA NELIDA	\N
127	54	232	PUENTE CAÑETE	\N
127	54	233	VILLA SANGUINETTI	\N
127	54	234	CAMPO CRISOL	\N
127	54	235	TODD	\N
127	54	236	VIÑA	\N
127	54	237	BARKER	\N
127	54	238	KM 404	\N
127	54	239	VILLA CACIQUE	\N
127	54	240	BENITO JUAREZ	\N
127	54	241	CAMINERA JUAREZ	\N
127	54	242	CHAPAR	\N
127	54	243	CORONEL RODOLFO BUNGE	\N
127	54	244	ESTANCIA CHAPAR	\N
127	54	245	HARAS EL CISNE	\N
127	54	246	LOPEZ	\N
127	54	247	TEDIN URIBURU	\N
127	54	248	EL LUCHADOR	\N
127	54	249	LA NUTRIA	\N
127	54	250	RICARDO GAVIÑA	\N
127	54	251	MARIANO ROLDAN	\N
127	54	252	BERAZATEGUI	\N
127	54	253	VILLA ESPAÑA	\N
127	54	254	VILLA MITRE	\N
127	54	255	VILLA SOL	\N
127	54	256	GUILLERMO E. HUDSON	\N
127	54	257	PLATANOS	\N
127	54	258	CARLOS T. SOURIGUES	\N
127	54	259	JOHN F. KENNEDY	\N
127	54	260	RANELAGH	\N
127	54	261	RIO ENCANTADO	\N
127	54	262	VILLA CLARA	\N
127	54	263	VILLA GIAMBRUNO	\N
127	54	264	JUAN MARIA GUTIERREZ	\N
127	54	265	CENTRO AGRICOLA EL PATO	\N
127	54	266	PEREYRA	\N
127	54	267	EL PESCADO	\N
127	54	268	ARROYO DEL PESCADO	\N
127	54	269	ARROYO LA MAZA	\N
127	54	270	BERISSO	\N
127	54	271	LOS TALAS	\N
127	54	272	ISLA PAULINO	\N
127	54	273	VILLA ARGÜELLO	\N
127	54	274	VILLA SAN CARLOS	\N
127	54	275	HALE	\N
127	54	276	VILLA SANZ	\N
127	54	277	BOLIVAR	\N
127	54	278	EL PORVENIR	\N
127	54	279	LA PERLA	\N
127	54	280	MIRAMAR	\N
127	54	281	JUAN F. IBARRA	\N
127	54	282	PIROVANO	\N
127	54	283	UNZUE	\N
127	54	284	LA TORRECITA	\N
127	54	285	NUEVA ESPAÑA	\N
127	54	286	URDAMPILLETA	\N
127	54	287	VILLA LYNCH (URDAMPILLETA)	\N
127	54	288	PAULA	\N
127	54	289	VALLIMANCA	\N
127	54	290	IRALA	\N
127	54	291	ASAMBLEA	\N
127	54	292	BRAGADO	\N
127	54	293	LA MARIA	\N
127	54	294	COMODORO PY	\N
127	54	295	LA LIMPIA	\N
127	54	296	MAXIMO FERNANDEZ	\N
127	54	297	COLONIA SAN EDUARDO	\N
127	54	298	GENERAL O BRIEN	\N
127	54	299	WARNES	\N
127	54	300	MECHA	\N
127	54	301	OLASCOAGA	\N
127	54	302	BARRIO LA DOLLY	\N
127	54	303	BARRIO LAS MANDARINAS	\N
127	54	304	CORONEL BRANDSEN	\N
127	54	305	KM 82 (APEADERO FCGR) (CNEL. BRANDSEN-PDO. BRANDSEN)	\N
127	54	306	SAMBOROMBON (LA POSADA)	\N
127	54	307	GOBERNADOR OBLIGADO	\N
127	54	308	OLIDEN	\N
127	54	309	GOMEZ	\N
127	54	310	GOMEZ DE LA VEGA	\N
127	54	311	ALTAMIRANO	\N
127	54	312	JEPPENER	\N
127	54	313	CAMINERA SAMBOROMBON	\N
127	54	314	OTAMENDI	\N
127	54	315	RIO LUJAN	\N
127	54	316	CAMPANA	\N
127	54	317	EL FENIX	\N
127	54	318	KM 88(CAMPANA)	\N
127	54	319	RUTA 9 KILOMETRO 72	\N
127	54	320	ARROYO ÑACURUTU CHICO	\N
127	54	321	ARROYO ALELI	\N
127	54	322	ARROYO CARABELITAS	\N
127	54	323	ARROYO EL AHOGADO	\N
127	54	324	ARROYO LAS ROSAS (CAMPANA)	\N
127	54	325	ARROYO LOS TIGRES	\N
127	54	326	ARROYO PESQUERIA	\N
127	54	327	ARROYO TAJIBER	\N
127	54	328	ARROYO ZANJON	\N
127	54	329	BLONDEAU	\N
127	54	330	LA HORQUETA (PDO. CAMPANA)	\N
127	54	331	ALEJANDRO PETION	\N
127	54	332	FRANCISCO CASAL	\N
127	54	333	VICENTE CASARES	\N
127	54	334	MAXIMO PAZ	\N
127	54	335	BARRIO PRIMERO DE MAYO	\N
127	54	336	CAÑUELAS	\N
127	54	337	KM 59 (APEADERO FCGR)	\N
127	54	338	LA GARITA	\N
127	54	339	LA NORIA	\N
127	54	340	ESCUELA AGRICOLA DON BOSCO	\N
127	54	341	URIBELARREA	\N
127	54	342	COLONIA SANTA ROSA	\N
127	54	343	LOS AROMOS	\N
127	54	344	RUTA 205 KILOMETRO 57	\N
127	54	345	VILLA ADRIANA	\N
127	54	346	GOBERNADOR UDAONDO	\N
127	54	347	KM 88 (GDOR. UDAONDO)	\N
127	54	348	PALMITAS	\N
127	54	349	SANTA ROSA	\N
127	54	350	ALMACEN DEL DESCANSO	\N
127	54	351	ARROYO DE LUNA	\N
127	54	352	CAMPO LA ELISA	\N
127	54	353	CAPITAN SARMIENTO	\N
127	54	354	COLEGIO SAN PABLO	\N
127	54	355	LA LUISA	\N
127	54	356	CARLOS CASARES	\N
127	54	357	SAN JUAN DE NELSON	\N
127	54	358	SANTO TOMAS	\N
127	54	359	ALGARROBO	\N
127	54	360	COLONIA LA ESPERANZA	\N
127	54	361	COLONIA MAURICIO	\N
127	54	362	GOBERNADOR ARIAS	\N
127	54	363	MAURICIO HIRSCH	\N
127	54	364	MOCTEZUMA	\N
127	54	365	SMITH	\N
127	54	366	BELLOCQ	\N
127	54	367	CADRET	\N
127	54	368	CENTENARIO	\N
127	54	369	COLONIA SANTA MARIA	\N
127	54	370	LA SOFIA	\N
127	54	371	SANTA MARIA DE BELLOCQ	\N
127	54	372	EL CAMOATI	\N
127	54	373	EL CARPINCHO	\N
127	54	374	ESTANCIA SAN CLAUDIO	\N
127	54	375	HORTENSIA	\N
127	54	376	ORDOQUI	\N
127	54	377	LA DORITA	\N
127	54	378	SANTO TOMAS CHICO	\N
127	54	379	ENCINA	\N
127	54	380	NECOL (ESTACION FCGM)	\N
127	54	381	CUENCA	\N
127	54	382	TRES ALGARROBOS	\N
127	54	383	HEREFORD	\N
127	54	384	CURARU	\N
127	54	385	LOS INDIOS	\N
127	54	386	MARUCHA	\N
127	54	387	SAN CARLOS	\N
127	54	388	CARLOS TEJEDOR	\N
127	54	389	DRYSDALE	\N
127	54	390	HUSARES	\N
127	54	391	INGENIERO BEAUGEY	\N
127	54	392	TIMOTE	\N
127	54	393	COLONIA SERE	\N
127	54	394	SANTA INES	\N
127	54	395	ESTEBAN DE LUCA	\N
127	54	396	LA HIGUERA	\N
127	54	397	LOS CHAÑARES	\N
127	54	398	KENNY	\N
127	54	399	HARAS LOS CARDALES	\N
127	54	400	RETIRO SAN PABLO	\N
127	54	401	CARMEN DE ARECO	\N
127	54	402	ESTRELLA NACIENTE	\N
127	54	403	LA CENTRAL	\N
127	54	404	PARADA TATAY	\N
127	54	405	SAN ERNESTO	\N
127	54	406	TATAY	\N
127	54	407	GOUIN	\N
127	54	408	TRES SARGENTOS	\N
127	54	409	CANAL 15	\N
127	54	410	CERRO DE LA GLORIA	\N
127	54	411	CASTELLI	\N
127	54	412	CENTRAL GUERRERO	\N
127	54	413	LA CORINCO	\N
127	54	414	LA COSTA (CASTELLI)	\N
127	54	415	PARQUE TAILLADE	\N
127	54	416	SAN JOSE DE GALI	\N
127	54	417	TAILLADE	\N
127	54	418	GUERRERO	\N
127	54	419	PEARSON	\N
127	54	420	COLON	\N
127	54	421	EL PELADO	\N
127	54	422	EL ARBOLITO	\N
127	54	423	SARASA	\N
127	54	424	ESTANCIA LAS GAMAS	\N
127	54	425	CALDERON	\N
127	54	426	VILLA GRAL. ARIAS	\N
127	54	427	ALMIRANTE SOLIER	\N
127	54	428	BALNEARIO (PARADA)	\N
127	54	429	DESVIO SANDRINI	\N
127	54	430	LA MARTINA	\N
127	54	431	PEHUEN CO	\N
127	54	432	PUNTA ALTA	\N
127	54	433	VILLA DEL MAR	\N
127	54	434	VILLA LAURA (PUNTA ALTA)	\N
127	54	435	VILLA MAIO	\N
127	54	436	ARROYO PAREJA	\N
127	54	437	ISLA CATARELLI	\N
127	54	438	PUERTO BELGRANO	\N
127	54	439	PUERTO ROSALES	\N
127	54	440	BATERIAS	\N
127	54	441	BAJO HONDO	\N
127	54	442	LA VIRGINIA	\N
127	54	443	PASO MAYOR	\N
127	54	444	IRENE	\N
127	54	445	ORIENTE	\N
127	54	446	LAS OSCURAS	\N
127	54	447	CAMPO LA LIMA	\N
127	54	448	CORONEL DORREGO	\N
127	54	449	EL ZORRO	\N
127	54	450	FARO	\N
127	54	451	LA LUNA	\N
127	54	452	LA SIRENA	\N
127	54	453	GIL	\N
127	54	454	KM 563	\N
127	54	455	LA AURORA	\N
127	54	456	NICOLAS DESCALZI	\N
127	54	457	CALVO	\N
127	54	458	LA SOBERANA	\N
127	54	459	SAN ROMAN	\N
127	54	460	EL PERDIDO (EST. JOSE A. GUISASOLA)	\N
127	54	461	APARICIO	\N
127	54	462	PARAJE LA AURORA	\N
127	54	463	MARISOL (BALNEARIO ORIENTE)	\N
127	54	464	INDIO RICO	\N
127	54	465	CORONEL PRINGLES	\N
127	54	466	KRABBE	\N
127	54	467	LAS MOSTAZAS	\N
127	54	468	PILLAHUINCO	\N
127	54	469	TEJO (GALERA)	\N
127	54	470	DESPEÑADEROS	\N
127	54	471	EL DIVISORIO	\N
127	54	472	EL PENSAMIENTO	\N
127	54	473	LARTIGAU	\N
127	54	474	LA RESERVA	\N
127	54	475	RESERVA	\N
127	54	476	STEGMAN	\N
127	54	477	CORONEL FALCON	\N
127	54	478	PERALTA	\N
127	54	479	ZOILO PERALTA	\N
127	54	480	QUIÑIHUAL	\N
127	54	481	BATHURST	\N
127	54	482	CORONEL SUAREZ	\N
127	54	483	PIÑEYRO	\N
127	54	484	SAUCE CORTO	\N
127	54	485	VILLA BELGRANO	\N
127	54	486	COLONIA NRo. 1	\N
127	54	487	COLONIA NRo. 3 	\N
127	54	488	D ORBIGNY	\N
127	54	489	PUEBLO SAN JOSE	\N
127	54	490	PUEBLO SANTA MARIA	\N
127	54	491	PUEBLO SANTA TRINIDAD	\N
127	54	492	LA PRIMAVERA	\N
127	54	493	HUANGUELEN	\N
127	54	494	OMBU	\N
127	54	495	OTOÑO	\N
127	54	496	ZENTENA	\N
127	54	497	CASCADA	\N
127	54	498	PASMAN	\N
127	54	499	CURA MALAL	\N
127	54	500	CURUMALAN	\N
127	54	501	LOS ANGELES	\N
127	54	502	CORONEL ISLEÑO	\N
127	54	503	CASTILLA	\N
127	54	504	LA CALIFORNIA ARGENTINA	\N
127	54	505	PALEMON HUERGO	\N
127	54	506	RAWSON	\N
127	54	507	SAN PATRICIO	\N
127	54	508	CHACABUCO	\N
127	54	509	VILLAFAÑE	\N
127	54	510	COLIQUEO	\N
127	54	511	INGENIERO SILVEYRA	\N
127	54	512	CUCHA CUCHA	\N
127	54	513	MEMBRILLAR	\N
127	54	514	O HIGGINS	\N
127	54	515	BARRIO EL HUECO	\N
127	54	516	CHASCOMUS	\N
127	54	517	EL EUCALIPTUS	\N
127	54	518	EL RINCON	\N
127	54	519	ESTANCIA SAN RAFAEL	\N
127	54	520	LA ALAMEDA	\N
127	54	521	LA AMALIA	\N
127	54	522	LA AMISTAD	\N
127	54	523	LA AZOTEA GRANDE	\N
127	54	524	LA HORQUETA	\N
127	54	525	LA LIMPIA	\N
127	54	526	LA REFORMA CHASCOMUS	\N
127	54	527	LAS BRUSCAS	\N
127	54	528	LAS MULAS	\N
127	54	529	LEGARISTI	\N
127	54	530	VISTA ALEGRE	\N
127	54	531	VITEL	\N
127	54	532	COMANDANTE GIRIBONE	\N
127	54	533	CUARTEL 8	\N
127	54	534	DON CIPRIANO	\N
127	54	535	EL CARBON	\N
127	54	536	LIBRES DEL SUD	\N
127	54	537	PEDRO NICOLAS ESCRIBANO	\N
127	54	538	ADELA	\N
127	54	539	COLONIA ESCUELA ARGENTINA	\N
127	54	540	CUARTEL 6	\N
127	54	541	GANDARA	\N
127	54	542	HARAS SAN IGNACIO	\N
127	54	543	CHIVILCOY	\N
127	54	544	HENRY BELL	\N
127	54	545	PUENTE BATALLA	\N
127	54	546	INDACOCHEA	\N
127	54	547	LA RICA	\N
127	54	548	SAN SEBASTIAN	\N
127	54	549	CAÑADA LA RICA	\N
127	54	550	VILLA MOQUEHUA	\N
127	54	551	HARAS EL CARMEN	\N
127	54	552	RAMON BIAUS	\N
127	54	553	EMILIO AYARZA	\N
127	54	554	LA CARLOTA	\N
127	54	555	LA DORMILONA	\N
127	54	556	BENITEZ	\N
127	54	557	GOROSTIAGA	\N
127	54	558	LA MANUELA	\N
127	54	559	LURO	\N
127	54	560	MASUREL	\N
127	54	561	ENRIQUE LAVALLE	\N
127	54	562	ATAHUALPA	\N
127	54	563	MOURAS	\N
127	54	564	SALAZAR	\N
127	54	565	VILLA ALDEANITA	\N
127	54	566	ALFALAD	\N
127	54	567	ANDANT	\N
127	54	568	CORONEL MARCELINO FREYRE	\N
127	54	569	DAIREAUX	\N
127	54	570	LA ARMONIA	\N
127	54	571	LA LARGA	\N
127	54	572	LOS COLONIALES	\N
127	54	573	VILLA CAROLA	\N
127	54	574	ARBOLEDAS	\N
127	54	575	LA COPETA	\N
127	54	576	LOUGE	\N
127	54	577	DOLORES	\N
127	54	578	LA ESTRELLA (DOLORES)	\N
127	54	579	LOMA DE SALOMON	\N
127	54	580	PARRAVICINI	\N
127	54	581	SEVIGNE	\N
127	54	582	LA POSTA	\N
127	54	583	LA PROTECCION	\N
127	54	584	DESTILERIA FISCAL	\N
127	54	585	DOCK CENTRAL	\N
127	54	586	ENSENADA	\N
127	54	587	GRAND DOCK	\N
127	54	588	PUERTO LA PLATA	\N
127	54	589	ESCUELA NAVAL MILITAR RIO SANTIAGO	\N
127	54	590	BASE NAVAL RIO SANTIAGO	\N
127	54	591	ISLA SANTIAGO	\N
127	54	592	PUNTA LARA	\N
127	54	593	GARIN	\N
127	54	594	RUTA 26 KILOMETRO 48	\N
127	54	595	RUTA 26 MAQUINISTA FRANCISCO SAVIO	\N
127	54	596	MAQUINISTA FRANCISCO SAVIO	\N
127	54	597	BARRIO GARIN NORTE	\N
127	54	598	BARRIO PARQUE LAMBARE	\N
127	54	599	INGENIERO MASCHWITZ	\N
127	54	600	LA GRACIELITA	\N
127	54	601	ARROYO CANELON	\N
127	54	602	ARROYO LAS ROSAS (ESCOBAR)	\N
127	54	603	BELEN DE ESCOBAR	\N
127	54	604	CAMPOMAR (VIÑEDO)	\N
127	54	605	LOMA VERDE	\N
127	54	606	PUERTO DE ESCOBAR	\N
127	54	607	EL CAZADOR	\N
127	54	608	VILLA LA CHECHELA	\N
127	54	609	VILLA VALLIER	\N
127	54	610	MATHEU	\N
127	54	611	9 DE ABRIL	\N
127	54	612	VILLA TRANSRADIO	\N
127	54	613	CANNING	\N
127	54	614	LUIS GUILLON	\N
127	54	615	MONTE GRANDE	\N
127	54	616	EL JAGUEL	\N
127	54	617	KM 102	\N
127	54	618	CAMPO LA NENA	\N
127	54	619	CHENAUT	\N
127	54	620	GOBERNADOR ANDONAEGUI	\N
127	54	621	ARROYO DE LA CRUZ	\N
127	54	622	CAPILLA DEL SEÑOR	\N
127	54	623	CARLOS LEMEE	\N
127	54	624	DIEGO GAYNOR	\N
127	54	625	EXALTACION DE LA CRUZ	\N
127	54	626	LA LATA	\N
127	54	627	LA ROSADA	\N
127	54	628	ORLANDO	\N
127	54	629	PAVON	\N
127	54	630	LOS CARDALES	\N
127	54	631	ETCHEGOYEN	\N
127	54	632	PARADA ROBLES	\N
127	54	633	VILLA PRECEPTOR MANUEL CRUZ	\N
127	54	634	LA CAPILLA	\N
127	54	635	EL OMBU	\N
127	54	636	EL TROPEZON	\N
127	54	637	FLORENCIO VARELA	\N
127	54	638	GOBERNADOR MONTEVERDE	\N
127	54	639	LA FABRICA	\N
127	54	640	VILLA ARGENTINA	\N
127	54	641	VILLA AURORA	\N
127	54	642	VILLA BROWN	\N
127	54	643	VILLA DEL PLATA	\N
127	54	644	ESTANISLAO S. ZEBALLOS	\N
127	54	645	VILLA GRAL. SAN MARTIN	\N
127	54	646	VILLA LA DELICIA	\N
127	54	647	VILLA LOPEZ ROMERO	\N
127	54	648	VILLA MARTIN FIERRO	\N
127	54	649	VILLA SAN CARLOS	\N
127	54	650	VILLA SAN LUIS	\N
127	54	651	VILLA SAN ROQUE	\N
127	54	652	VILLA SANTA ROSA	\N
127	54	653	VILLA SUSANA	\N
127	54	654	VILLA VATTEONE	\N
127	54	655	BOSQUES	\N
127	54	656	EL ROCIO	\N
127	54	657	INGENIERO ALLAN	\N
127	54	658	GOBERNADOR JULIO A. COSTA	\N
127	54	659	SAN JUAN BAUTISTA	\N
127	54	660	AMEGHINO	\N
127	54	661	EDUARDO COSTA	\N
127	54	662	BLAQUIER	\N
127	54	663	PORVENIR	\N
127	54	664	ANCALO	\N
127	54	665	SAN JOSE DE OTAMENDI	\N
127	54	666	COMANDANTE NICANOR OTAMENDI	\N
127	54	667	DIONISIA	\N
127	54	668	LA BALLENERA	\N
127	54	669	LA COLMENA	\N
127	54	670	LA ELMA	\N
127	54	671	LA LUCIA	\N
127	54	672	LA MADRECITA	\N
127	54	673	LA REFORMA (NICANOR OTAMENDI)	\N
127	54	674	LAS LOMAS	\N
127	54	675	LOS PATOS	\N
127	54	676	SAN CORNELIO	\N
127	54	677	SAN FELIPE	\N
127	54	678	LAS PIEDRITAS (MECHONGUE)	\N
127	54	679	MECHONGUE	\N
127	54	680	YRAIZOZ	\N
127	54	681	BARRIO OESTE	\N
127	54	682	BARRIO PARQUE BRISTOL	\N
127	54	683	EL CENTINELA	\N
127	54	684	EL PITO (MIRAMAR)	\N
127	54	685	GENERAL ALVARADO	\N
127	54	686	MAR DEL SUD	\N
127	54	687	MIRAMAR	\N
127	54	688	PLA Y ROGNONI	\N
127	54	689	SAN EDUARDO DEL MAR	\N
127	54	690	SANTA IRENE	\N
127	54	691	VILLA COPACABANA	\N
127	54	692	SANTA ISABEL	\N
127	54	693	EL CHUMBIAO	\N
127	54	694	EL PARCHE	\N
127	54	695	EMMA	\N
127	54	696	GENERAL ALVEAR	\N
127	54	697	HARAS R. DE LA PARVA	\N
127	54	698	JOSE MARIA MICHEO	\N
127	54	699	LA PAMPA	\N
127	54	700	LOS CUATRO CAMINOS	\N
127	54	701	ASCENSION	\N
127	54	702	ESTACION ASCENSION	\N
127	54	703	FERRE	\N
127	54	704	LA ANGELITA	\N
127	54	705	LA TRINIDAD	\N
127	54	706	ESTACION GENERAL ARENALES	\N
127	54	707	GENERAL ARENALES	\N
127	54	708	HAM	\N
127	54	709	LA HUAYQUERIA	\N
127	54	710	ARRIBEÑOS	\N
127	54	711	COLONIA LOS HORNOS	\N
127	54	712	DELGADO	\N
127	54	713	LA PINTA	\N
127	54	714	DESVIO EL CHINGOLO	\N
127	54	715	KM 95 (DESVIO EL CHINGOLO-PDO. GRAL. ARENALES)	\N
127	54	716	BONNEMENT	\N
127	54	717	CHAS	\N
127	54	718	EL SIASGO	\N
127	54	719	GENERAL BELGRANO	\N
127	54	720	HARAS CHACABUCO	\N
127	54	721	IBAÑEZ	\N
127	54	722	LA CHUMBEADA	\N
127	54	723	LA ESPERANZA	\N
127	54	724	LA VERDE	\N
127	54	725	NEWTON	\N
127	54	726	GORCHS	\N
127	54	727	KM 146 (APEADERO FCGR)	\N
127	54	728	GENERAL GUIDO	\N
127	54	729	LABARDEN	\N
127	54	730	CLAVERIE	\N
127	54	731	EL CHAJA	\N
127	54	732	ESPADAÑA	\N
127	54	733	GENERAL MADARIAGA	\N
127	54	734	GOÑI	\N
127	54	735	GOBOS	\N
127	54	736	GOROSO	\N
127	54	737	HINOJALES	\N
127	54	738	INVERNADAS	\N
127	54	739	ISONDU	\N
127	54	740	LA ESPERANZA	\N
127	54	741	MACEDO	\N
127	54	742	MEDALAND	\N
127	54	743	PASOS	\N
127	54	744	SPERONI	\N
127	54	745	TIO DOMINGO	\N
127	54	746	JUANCHO	\N
127	54	747	ALDECON	\N
127	54	748	CHALA QUILCA	\N
127	54	749	GENERAL LAMADRID	\N
127	54	750	LAS MARTINETAS	\N
127	54	751	SANTA CLEMENTINA	\N
127	54	752	LIBANO	\N
127	54	753	LA COLINA	\N
127	54	754	RAULET	\N
127	54	755	PONTAUT	\N
127	54	756	VILLARS	\N
127	54	757	EL DURAZNO	\N
127	54	758	KM 77 (LA CHOZA)	\N
127	54	759	LA CHOZA	\N
127	54	760	HORNOS	\N
127	54	761	PARADA KILOMETRO 76	\N
127	54	762	ENRIQUE FYNN	\N
127	54	763	GENERAL HORNOS	\N
127	54	764	GENERAL LAS HERAS	\N
127	54	765	KM 79 (APEADERO FCGB)	\N
127	54	766	LOZANO	\N
127	54	767	PLOMER	\N
127	54	768	SPERATTI	\N
127	54	769	FARO SAN ANTONIO	\N
127	54	770	GENERAL LAVALLE	\N
127	54	771	BARRIO PEDRO J. ROCCO	\N
127	54	772	SAN JOSE DE LOS QUINTEROS	\N
127	54	773	LA MASCOTA	\N
127	54	774	SALADA CHICA	\N
127	54	775	SALADA GRANDE	\N
127	54	776	LOS MERINOS	\N
127	54	777	KM 70 (APEADERO FCGB)	\N
127	54	778	KM 77 (APEADERO FCGB) (LOMA VERDE-PDO. GRAL. PAZ)	\N
127	54	779	LOMA VERDE	\N
127	54	780	LOS MARINO	\N
127	54	781	ALEGRE	\N
127	54	782	CANCHA DEL POLLO	\N
127	54	783	ESPARTILLAR (GRAL. PAZ)	\N
127	54	784	GENERAL PAZ	\N
127	54	785	RANCHOS	\N
127	54	786	ESTANCIA VIEJA	\N
127	54	787	RINCON DE VIVOT	\N
127	54	788	VILLANUEVA	\N
127	54	789	DOS HERMANOS	\N
127	54	790	IRIARTE	\N
127	54	791	DUSSAUD	\N
127	54	792	GENERAL PINTO	\N
127	54	793	HARAS EL 14	\N
127	54	794	INGENIERO BALBIN	\N
127	54	795	EL PEREGRINO	\N
127	54	796	GERMANIA	\N
127	54	797	GUNTHER	\N
127	54	798	PAZOS KANKI	\N
127	54	799	CORONEL GRANADA	\N
127	54	800	LOS CALLEJONES (ESTACION FCGM)	\N
127	54	801	HALCEY	\N
127	54	802	SALALE	\N
127	54	803	VOLTA	\N
127	54	804	BARRIO EMIR RAMON JUAREZ	\N
127	54	805	BARRIO GASTRONOMICO	\N
127	54	806	BARRIO GENERAL ROCA	\N
127	54	807	BARRIO JOSE MANUEL ESTRADA	\N
127	54	808	BARRIO JURAMENTO	\N
127	54	809	BARRIO LOS ANDES	\N
127	54	810	BARRIO PINARES	\N
127	54	811	BARRIO PRIMERA JUNTA	\N
127	54	812	BARRIO SAN CAYETANO	\N
127	54	813	BARRIO SAN JOSE	\N
127	54	814	BARRIO TIERRA DE ORO	\N
127	54	815	BARRIO TIRO FEDERAL	\N
127	54	816	EL MARTILLO	\N
127	54	817	EL SOLDADO	\N
127	54	818	LAGUNA DEL SOLDADO	\N
127	54	819	MAR DEL PLATA	\N
127	54	820	BARRIO BATAN	\N
127	54	821	EL BOQUERON	\N
127	54	822	LA PEREGRINA	\N
127	54	823	LAGUNA DE LOS PADRES	\N
127	54	824	LOS ORTIZ	\N
127	54	825	SIERRA DE LOS PADRES	\N
127	54	826	CHAPADMALAL	\N
127	54	827	HARAS CHAPADMALAL	\N
127	54	828	COLONIA DE VACACIONES CHAPADMALAL	\N
127	54	829	LOS ACANTILADOS	\N
127	54	830	PLAYA CHAPADMALAL	\N
127	54	831	PLAYA SERENA	\N
127	54	832	CAMET	\N
127	54	833	GENERAL RODRIGUEZ	\N
127	54	834	LA FRATERNIDAD	\N
127	54	835	LAS MALVINAS (PARADA FCDFS)	\N
127	54	836	YAPEYU	\N
127	54	837	MIGUELETE	\N
127	54	838	SAN MARTIN	\N
127	54	839	BILLINGHURST	\N
127	54	840	VILLA MAIPU	\N
127	54	841	SAN ANDRES	\N
127	54	842	VILLA BALLESTER	\N
127	54	843	JOSE LEON SUAREZ	\N
127	54	844	REMEDIOS DE ESCALADA DE SAN MARTIN	\N
127	54	845	CIUDAD JARDIN EL LIBERTADOR	\N
127	54	846	LOMA HERMOSA	\N
127	54	847	VILLA LYNCH	\N
127	54	848	MALAVER	\N
127	54	849	VILLA BONICH	\N
127	54	850	VILLA LIBERTAD	\N
127	54	851	BAIGORRITA	\N
127	54	852	CAMPO COLIQUEO	\N
127	54	853	CAMPO LA TRIBU	\N
127	54	854	GENERAL VIAMONTE	\N
127	54	855	LOS HUESOS	\N
127	54	856	LOS TOLDOS	\N
127	54	857	CHANCAY	\N
127	54	858	EL RETIRO (SAN EMILIO-PDO. GRAL. VIAMONTE)	\N
127	54	859	KM 282 (APEADERO FCDFS)	\N
127	54	860	LA DELFINA	\N
127	54	861	SAN EMILIO (PDO. GRAL. VIAMONTE)	\N
127	54	862	SAN ROQUE	\N
127	54	863	COLONIA LOS BOSQUES	\N
127	54	864	COLONIA LOS HUESOS	\N
127	54	865	LOS BOSQUES	\N
127	54	866	QUIRNO COSTA	\N
127	54	867	ZAVALIA	\N
127	54	868	PICHINCHA	\N
127	54	869	VILLA SABOYA	\N
127	54	870	CAÑADA SECA	\N
127	54	871	SANTA REGINA	\N
127	54	872	CORONEL CHARLONE	\N
127	54	873	FERNANDO MARTI	\N
127	54	874	DRABBLE	\N
127	54	875	GENERAL VILLEGAS	\N
127	54	876	LOS LAURELES	\N
127	54	877	MOORE	\N
127	54	878	PRADERE	\N
127	54	879	VILLA SAUZE	\N
127	54	880	EMILIO V. BUNGE	\N
127	54	881	GONDRA	\N
127	54	882	PIEDRITAS	\N
127	54	883	SANTA ELEODORA	\N
127	54	884	ELORDI	\N
127	54	885	LOS CALDENES	\N
127	54	886	BANDERALO	\N
127	54	887	BRAVO DEL DOS	\N
127	54	888	GARRE	\N
127	54	889	PAPIN	\N
127	54	890	VICTORINO DE LA PLAZA	\N
127	54	891	CASBAS	\N
127	54	892	CASEY	\N
127	54	893	FORTIN PAUNERO	\N
127	54	894	SAN FERMIN	\N
127	54	895	SATURNO	\N
127	54	896	ROLITO	\N
127	54	897	ALAMOS	\N
127	54	898	EL NILO	\N
127	54	899	GUAMINI	\N
127	54	900	LAGUNA DEL MONTE	\N
127	54	901	VUELTA DE ZAPATA	\N
127	54	902	ARROYO EL CHINGOLO	\N
127	54	903	ARROYO VENADO	\N
127	54	904	COLONIA SAN RAMON	\N
127	54	905	EL TREBAÑON	\N
127	54	906	LA GREGORIA	\N
127	54	907	LA HERMINIA	\N
127	54	908	LAS CUATRO HERMANAS	\N
127	54	909	LAS TRES FLORES	\N
127	54	910	SANTA RITA	\N
127	54	911	BONIFACIO	\N
127	54	912	LAGUNA ALSINA	\N
127	54	913	LA NEVADA	\N
127	54	914	CORACEROS	\N
127	54	915	HENDERSON	\N
127	54	916	MARIA LUCILA	\N
127	54	917	HERRERA VEGAS	\N
127	54	918	BARRIO 9 DE JULIO	\N
127	54	919	BARRIO ALTOS DE JOSE C. PAZ	\N
127	54	920	BARRIO FRINO	\N
127	54	921	BARRIO LAS ACACIAS	\N
127	54	922	BARRIO SAN ROQUE	\N
127	54	923	BARRIO VILLA ALTUBE	\N
127	54	924	EL CRUCE	\N
127	54	925	JOSE C. PAZ	\N
127	54	926	JUAN VUCETICH	\N
127	54	927	PIÑERO	\N
127	54	928	ROOSEVELT	\N
127	54	929	BARRIO YEI-PORA	\N
127	54	930	LA LOMA (DEL VISO)	\N
127	54	931	VILLA DEL CARMEN (DEL VISO)	\N
127	54	932	BARRIO CAROSIO	\N
127	54	933	BARRIO GENERAL SAN MARTIN	\N
127	54	934	BARRIO VILLA ORTEGA	\N
127	54	935	JUNIN	\N
127	54	936	VILLA MAYOR	\N
127	54	937	VILLA PENOTTI	\N
127	54	938	VILLA TALLERES	\N
127	54	939	VILLA TRIANGULO	\N
127	54	940	VILLA YORK	\N
127	54	941	AGUSTIN ROCA	\N
127	54	942	AGUSTINA	\N
127	54	943	FORTIN TIBURCIO	\N
127	54	944	LAGUNA DE GOMEZ	\N
127	54	945	LAPLACETTE	\N
127	54	946	MORSE	\N
127	54	947	LA ORIENTAL	\N
127	54	948	LAS PARVAS	\N
127	54	949	SAFORCADA	\N
127	54	950	BLANDENGUES	\N
127	54	951	SAN CLEMENTE DEL TUYU	\N
127	54	952	LAS TONINAS	\N
127	54	953	SANTA TERESITA	\N
127	54	954	MAR DEL TUYU	\N
127	54	955	MAR DE AJO	\N
127	54	956	PLAYA LAS MARGARITAS	\N
127	54	957	PUNTA MEDANOS	\N
127	54	958	SAN BERNARDO	\N
127	54	959	AGUAS VERDES	\N
127	54	960	COSTA AZUL	\N
127	54	961	LA LUCILA DEL MAR	\N
127	54	962	COSTA DEL ESTE	\N
127	54	963	RAMOS MEJIA	\N
127	54	964	LOMAS DEL MIRADOR	\N
127	54	965	VILLA INSUPERABLE	\N
127	54	966	SAN JUSTO	\N
127	54	967	VILLA LUZURIAGA	\N
127	54	968	RAFAEL CASTILLO	\N
127	54	969	GREGORIO DE LAFERRERE	\N
127	54	970	GONZALEZ CATAN	\N
127	54	971	20 DE JUNIO	\N
127	54	972	VIRREY DEL PINO	\N
127	54	973	ISIDRO CASANOVA	\N
127	54	974	LA TABLADA	\N
127	54	975	VILLA MADERO	\N
127	54	976	ALDO BONZI	\N
127	54	977	TAPIALES	\N
127	54	978	MERCADO CENTRAL	\N
127	54	979	VILLA CELINA	\N
127	54	980	VILLA MADRID	\N
127	54	981	VILLA RIACHUELO	\N
127	54	982	VILLA URBANA	\N
127	54	983	LA SALADA	\N
127	54	984	BARRIO SAN SEBASTIAN	\N
127	54	985	CIUDAD EVITA	\N
127	54	986	QUERANDI	\N
127	54	987	EL MIRADOR	\N
127	54	988	VALENTIN ALSINA	\N
127	54	989	VILLA CARAZA	\N
127	54	990	VILLA ILASA	\N
127	54	991	VILLA JARDIN	\N
127	54	992	GERLI (PARTIDO LANUS)	\N
127	54	993	LANUS	\N
127	54	994	VILLA INDUSTRIALES	\N
127	54	995	MONTE CHINGOLO	\N
127	54	996	REMEDIOS DE ESCALADA	\N
127	54	997	VILLA DIAMANTE	\N
127	54	998	ISLA MARTIN GARCIA	\N
127	54	999	MONTARAZ	\N
127	54	1000	BARRIO LA PERLA	\N
127	54	1001	DOCTOR RICARDO LEVENE	\N
127	54	1002	EL PELIGRO	\N
127	54	1003	VILLA ELISA	\N
127	54	1004	ARTURO SEGUI	\N
127	54	1005	LOS EUCALIPTOS	\N
127	54	1006	CITY BELL	\N
127	54	1007	ENRIQUE BELL	\N
127	54	1008	JOAQUIN GORINA	\N
127	54	1009	MANUEL B. GONNET	\N
127	54	1010	LA PLATA	\N
127	54	1011	SARRAT (PARADA)	\N
127	54	1012	ADOLFO F. ORMA	\N
127	54	1013	ANGEL ETCHEVERRY	\N
127	54	1014	DALMIRO SAENZ	\N
127	54	1015	EL RETIRO	\N
127	54	1016	ESQUINA NEGRA	\N
127	54	1017	LAS QUINTAS	\N
127	54	1018	LISANDRO OLMOS	\N
127	54	1019	RINGUELET	\N
127	54	1020	ABASTO	\N
127	54	1021	BUCHANAN	\N
127	54	1022	AGUSTIN R. GAMBIER	\N
127	54	1023	JOSE HERNANDEZ	\N
127	54	1024	LAS CHACRAS (MELCHOR ROMERO)	\N
127	54	1025	MELCHOR ROMERO	\N
127	54	1026	PARAJE 19 DE NOVIEMBRE	\N
127	54	1027	POBLET	\N
127	54	1028	EL CARMEN	\N
127	54	1029	NUEVA HERMOSURA	\N
127	54	1030	ARANA	\N
127	54	1031	IGNACIO CORREAS	\N
127	54	1032	TOLOSA	\N
127	54	1033	VILLA CASTELLS	\N
127	54	1034	LOS HORNOS	\N
127	54	1035	VILLA ELVIRA	\N
127	54	1036	ALTOS DE SAN LORENZO	\N
127	54	1037	LA CUMBRE	\N
127	54	1038	LOMAS DE COPELLO	\N
127	54	1039	SAN CARLOS	\N
127	54	1040	VILLA MONTORO	\N
127	54	1041	SAN JORGE	\N
127	54	1042	VOLUNTAD	\N
127	54	1043	LAPRIDA	\N
127	54	1044	LAS HERMANAS	\N
127	54	1045	CORONEL BOERR	\N
127	54	1046	EL GUALICHO	\N
127	54	1047	LAS FLORES	\N
127	54	1048	PLAZA MONTERO	\N
127	54	1049	LA ESPERANZA 	\N
127	54	1050	ROSAS	\N
127	54	1051	EL TRIGO	\N
127	54	1052	ESTRUGAMOU	\N
127	54	1053	LA PORTEÑA (EL TRIGO)	\N
127	54	1054	VILELA	\N
127	54	1055	DOCTOR DOMINGO HAROSTEGUY	\N
127	54	1056	PARDO	\N
127	54	1057	SANTA ROSA DE MINELLONO	\N
127	54	1058	EDMUNDO B. PERKINS	\N
127	54	1059	SAUZALES	\N
127	54	1060	VEDIA	\N
127	54	1061	DE BRUYN	\N
127	54	1062	EL DORADO	\N
127	54	1063	FORTIN ACHA	\N
127	54	1064	LEANDRO N. ALEM	\N
127	54	1065	ALBERDI	\N
127	54	1066	TRIGALES	\N
127	54	1067	BALSA	\N
127	54	1068	ESTACION LINCOLN	\N
127	54	1069	LINCOLN	\N
127	54	1070	BERMUDEZ	\N
127	54	1071	SANTA MARIA	\N
127	54	1072	TRIUNVIRATO	\N
127	54	1073	EL TRIUNFO	\N
127	54	1074	FORTIN VIGILANCIA	\N
127	54	1075	ARENAZA	\N
127	54	1076	LOS ALTOS	\N
127	54	1077	ROBERTS	\N
127	54	1078	LA ZARATEÑA	\N
127	54	1079	NUEVA SUIZA	\N
127	54	1080	PASTEUR	\N
127	54	1081	BAYAUCA	\N
127	54	1082	CARLOS SALAS	\N
127	54	1083	LA PRADERA	\N
127	54	1084	LAS TOSCAS	\N
127	54	1085	MARTINEZ DE HOZ	\N
127	54	1086	DOS NACIONES	\N
127	54	1087	EL CHEIQUE	\N
127	54	1088	LA PALMA	\N
127	54	1089	LICENCIADO MATIENZO	\N
127	54	1090	SAN MANUEL	\N
127	54	1091	CAMPO PELAEZ	\N
127	54	1092	LAS NUTRIAS	\N
127	54	1093	MAORI	\N
127	54	1094	PIERES	\N
127	54	1095	TAMANGUEYU	\N
127	54	1096	EL LENGUARAZ	\N
127	54	1097	EL MORO	\N
127	54	1098	LOBERIA	\N
127	54	1099	LOS CERROS	\N
127	54	1100	LAGUNA DE LOBOS	\N
127	54	1101	LOBOS	\N
127	54	1102	LA PORTEÑA	\N
127	54	1103	LAS CHACRAS	\N
127	54	1104	SALVADOR MARIA	\N
127	54	1105	ANTONIO CARBONI	\N
127	54	1106	ELVIRA	\N
127	54	1107	JOSE SANTOS AREVALO	\N
127	54	1108	LA ADELAIDA	\N
127	54	1109	SANTA ALICIA	\N
127	54	1110	SANTA FELISA	\N
127	54	1111	EMPALME LOBOS	\N
127	54	1112	ZAPIOLA	\N
127	54	1113	BANFIELD	\N
127	54	1114	VILLA ALBERTINA	\N
127	54	1115	VILLA FIORITO	\N
127	54	1116	LOMAS DE ZAMORA	\N
127	54	1117	TEMPERLEY	\N
127	54	1118	TURDERA	\N
127	54	1119	BARRIO SAN JOSE	\N
127	54	1120	LLAVALLOL	\N
127	54	1121	INGENIERO BUDGE	\N
127	54	1122	VILLA CENTENARIO	\N
127	54	1123	SAN ELADIO	\N
127	54	1124	OLIVERA	\N
127	54	1125	CAÑADA DE ARIAS	\N
127	54	1126	CAMINERA LUJAN	\N
127	54	1127	CUARTEL IV	\N
127	54	1128	LA LOMA	\N
127	54	1129	LEZICA Y TORREZURI	\N
127	54	1130	LUJAN	\N
127	54	1131	SANTA ELENA	\N
127	54	1132	CARLOS KEEN	\N
127	54	1133	ALASTUEY	\N
127	54	1134	RUTA 8 KILOMETRO 77	\N
127	54	1135	TORRES	\N
127	54	1136	JAUREGUI	\N
127	54	1137	VILLA FLANDRIA	\N
127	54	1138	VILLA FRANCIA (VILLA FLANDRIA-PDO. LUJAN)	\N
127	54	1139	DOCTOR DOMINGO CABRED	\N
127	54	1140	MARISCAL SUCRE	\N
127	54	1141	OPEN DOOR	\N
127	54	1142	SUCRE	\N
127	54	1143	CORTINES	\N
127	54	1144	LAS CASUARINAS	\N
127	54	1145	EL PINO	\N
127	54	1146	RUTA 11 KILOMETRO 23	\N
127	54	1147	VILLA GARIBALDI	\N
127	54	1148	BARTOLOME BAVIO	\N
127	54	1149	GENERAL MANSILLA	\N
127	54	1150	JOSE FERRARI	\N
127	54	1151	ATALAYA	\N
127	54	1152	CRISTINO BENAVIDEZ	\N
127	54	1153	EMPALME MAGDALENA	\N
127	54	1154	JULIO ARDITI	\N
127	54	1155	MAGDALENA	\N
127	54	1156	ROBERTO PAYRO	\N
127	54	1157	ARBUCO	\N
127	54	1158	PARAJE STARACHE	\N
127	54	1159	VIEYTES	\N
127	54	1160	EL ROSARIO	\N
127	54	1161	LOS SANTOS VIEJOS	\N
127	54	1162	PIÑEIRO	\N
127	54	1163	RINCON DE NOARIO	\N
127	54	1164	VERGARA	\N
127	54	1165	CARI LARQUEA	\N
127	54	1166	LA AMORILLA	\N
127	54	1167	LA COLORADA	\N
127	54	1168	MONSALVO	\N
127	54	1169	SANTO DOMINGO	\N
127	54	1170	SEGUROLA	\N
127	54	1171	MAIPU	\N
127	54	1172	COLONIA FERRARI	\N
127	54	1173	HOGAR MARIANO ORTIZ BASUALDO	\N
127	54	1174	LAS ARMAS	\N
127	54	1175	ADOLFO SOURDEAUX	\N
127	54	1176	BARRIO EL OMBU (LOS POLVORINES)	\N
127	54	1177	EL SOL	\N
127	54	1178	GUADALUPE	\N
127	54	1179	ING. PABLO NOGUES	\N
127	54	1180	LOS POLVORINES	\N
127	54	1181	VILLA DE MAYO	\N
127	54	1182	GRAND BOURG	\N
127	54	1183	TORTUGUITAS	\N
127	54	1184	GENERAL PIRAN	\N
127	54	1185	ARROYO GRANDE	\N
127	54	1186	CORONEL VIDAL	\N
127	54	1187	EL VIGILANTE	\N
127	54	1188	ESCUELA AGRICOLA RURAL N. EZEIZA	\N
127	54	1189	LA TOBIANA	\N
127	54	1190	LAS CHILCAS	\N
127	54	1191	BALNEARIO MAR CHIQUITA	\N
127	54	1192	SANTA CLARA DEL MAR	\N
127	54	1193	SIEMPRE VERDE	\N
127	54	1194	CALFUCURA	\N
127	54	1195	COBO	\N
127	54	1196	EL REFUGIO	\N
127	54	1197	VIVORATA	\N
127	54	1198	CAMPAMENTO	\N
127	54	1199	NAHUEL RUCA	\N
127	54	1200	SAN VALENTIN	\N
127	54	1201	COLONIA NACIONAL DE MENORES	\N
127	54	1202	ELIAS ROMERO	\N
127	54	1203	MARCOS PAZ	\N
127	54	1204	ZAMUDIO (APEADERO FCDFS)	\N
127	54	1205	LA PAZ	\N
127	54	1206	AGOTE	\N
127	54	1207	MERCEDES	\N
127	54	1208	SAN JACINTO	\N
127	54	1209	ALTAMIRA	\N
127	54	1210	COMAHUE OESTE	\N
127	54	1211	ESPORA	\N
127	54	1212	LA VALEROSA	\N
127	54	1213	LA VERDE	\N
127	54	1214	TOMAS JOFRE	\N
127	54	1215	GOWLAND	\N
127	54	1216	MANUEL JOSE GARCIA	\N
127	54	1217	GOLDNEY	\N
127	54	1218	SAN ANTONIO DE PADUA	\N
127	54	1219	MERLO	\N
127	54	1220	MARIANO ACOSTA	\N
127	54	1221	PONTEVEDRA	\N
127	54	1222	FRANCISCO A. BERRA	\N
127	54	1223	FUNCKE 	\N
127	54	1224	GOYENECHE	\N
127	54	1225	GUARDIA DEL MONTE	\N
127	54	1226	LOS EUCALIPTUS	\N
127	54	1227	SAN MIGUEL DEL MONTE	\N
127	54	1228	LOS CERRILLOS	\N
127	54	1229	ZENON VIDELA DORNA	\N
127	54	1230	ABBOTT	\N
127	54	1231	ZUBIAURRE	\N
127	54	1232	BALNEARIO SAUCE GRANDE	\N
127	54	1233	MONTE HERMOSO	\N
127	54	1234	SAUCE GRANDE	\N
127	54	1235	LOMAS DE MARILO	\N
127	54	1236	BARRIO LOS PARAISOS (TRUJUI)	\N
127	54	1237	TRUJUI	\N
127	54	1238	PASO DEL REY	\N
127	54	1239	VILLA GRAL. ZAPIOLA	\N
127	54	1240	JOSE A. CORTEJARENA	\N
127	54	1241	LA PORTEÑA	\N
127	54	1242	LA REJA	\N
127	54	1243	MORENO	\N
127	54	1244	AGUA DE ORO	\N
127	54	1245	FRANCISCO ALVAREZ	\N
127	54	1246	VILLA ESCOBAR	\N
127	54	1247	CUARTEL V	\N
127	54	1248	EL PALOMAR	\N
127	54	1249	DOMINGO FAUSTINO SARMIENTO	\N
127	54	1250	HAEDO	\N
127	54	1251	MORON	\N
127	54	1252	CASTELAR	\N
127	54	1253	VILLA SARMIENTO	\N
127	54	1254	GONZALEZ RISOS	\N
127	54	1255	INGENIERO WILLIAMS	\N
127	54	1256	NAVARRO	\N
127	54	1257	ANASAGASTI	\N
127	54	1258	ESTEBAN DIAZ	\N
127	54	1259	LAS MARIANAS	\N
127	54	1260	JUAN JOSE ALMEYRA	\N
127	54	1261	ACHUPALLAS	\N
127	54	1262	LA VICTORIA (DESVIO)	\N
127	54	1263	MOLL	\N
127	54	1264	LA BLANQUEADA	\N
127	54	1265	SOL DE MAYO	\N
127	54	1266	LA REFORMA	\N
127	54	1267	CLARAZ	\N
127	54	1268	LA NEGRA	\N
127	54	1269	JUAN N. FERNANDEZ	\N
127	54	1270	SAN CALA	\N
127	54	1271	HOSPITAL NECOCHEA	\N
127	54	1272	LA PRIMITIVA	\N
127	54	1273	MEDANO BLANCO	\N
127	54	1274	NECOCHEA	\N
127	54	1275	PUERTO NECOCHEA	\N
127	54	1276	COSTA BONITA	\N
127	54	1277	VILLA DIAZ VELEZ	\N
127	54	1278	PUERTO QUEQUEN	\N
127	54	1279	QUEQUEN	\N
127	54	1280	SAN JOSE	\N
127	54	1281	LA DULCE	\N
127	54	1282	LUMB	\N
127	54	1283	EL PITO (ENERGIA)	\N
127	54	1284	ENERGIA	\N
127	54	1285	RAMON SANTAMARINA	\N
127	54	1286	NICANOR OLIVERA (LA DULCE)	\N
127	54	1287	9 DE JULIO	\N
127	54	1288	BARRIO JULIO DE VEDIA	\N
127	54	1289	FAUZON	\N
127	54	1290	SAN JUAN	\N
127	54	1291	VILLA DIAMANTINA	\N
127	54	1292	DOCE DE OCTUBRE	\N
127	54	1293	ESTACION PROVINCIAL 9 DE JULIO	\N
127	54	1294	LAGUNA DEL CURA	\N
127	54	1295	MULCAHY	\N
127	54	1296	NORUMBEGA	\N
127	54	1297	TROPEZON	\N
127	54	1298	DESVIO KILOMETRO 234	\N
127	54	1299	PATRICIOS	\N
127	54	1300	DUDIGNAC	\N
127	54	1301	CORBETT	\N
127	54	1302	GERENTE CILLEY	\N
127	54	1303	LAS NEGRAS	\N
127	54	1304	MOREA	\N
127	54	1305	SANTOS UNZUE	\N
127	54	1306	COLONIA LAS YESCAS	\N
127	54	1307	GALO LLORENTE	\N
127	54	1308	LA AURORA	\N
127	54	1309	LA NIÑA	\N
127	54	1310	LA YESCA	\N
127	54	1311	CARLOS MARIA NAON	\N
127	54	1312	EL TEJAR	\N
127	54	1313	AMALIA	\N
127	54	1314	BACACAY	\N
127	54	1315	CAMBACERES	\N
127	54	1316	DENNEHY	\N
127	54	1317	FRENCH	\N
127	54	1318	EL JABALI	\N
127	54	1319	ALFREDO DEMARCHI	\N
127	54	1320	FACUNDO QUIROGA	\N
127	54	1321	RAMON J. NEILD	\N
127	54	1322	REGINALDO J. NEILD	\N
127	54	1323	ITURREGUI	\N
127	54	1324	MAPIS	\N
127	54	1325	RECALDE	\N
127	54	1326	BLANCAGRANDE	\N
127	54	1327	ESPIGAS	\N
127	54	1328	LA PROTEGIDA (ESPIGAS)	\N
127	54	1329	COLONIA HINOJO	\N
127	54	1330	COLONIA NIEVES	\N
127	54	1331	COLONIA RUSA	\N
127	54	1332	HINOJO	\N
127	54	1333	VILLA MONICA	\N
127	54	1334	BARRIO LA LUISA	\N
127	54	1335	OLAVARRIA	\N
127	54	1336	POURTALE	\N
127	54	1337	SAN JACINTO	\N
127	54	1338	CANTERAS DE GREGORINI	\N
127	54	1339	DURAÑONA	\N
127	54	1340	EMPALME QUERANDIES	\N
127	54	1341	SAN JUAN (SANTA LUISA)	\N
127	54	1342	SANTA LUISA	\N
127	54	1343	SIERRA CHICA	\N
127	54	1344	TENIENTE CORONEL MIÑANA	\N
127	54	1345	ALVARO BARROS	\N
127	54	1346	CERRO NEGRO	\N
127	54	1347	CERRO SOTUYO	\N
127	54	1348	COLONIA SAN MIGUEL	\N
127	54	1349	FORTABAT	\N
127	54	1350	LA ESTRELLA (SIERRAS BAYAS)	\N
127	54	1351	LA NARCISA	\N
127	54	1352	LA PALMIRA	\N
127	54	1353	LA PROVIDENCIA	\N
127	54	1354	LA TOMASA	\N
127	54	1355	LOMA NEGRA	\N
127	54	1356	SIERRAS BAYAS	\N
127	54	1357	FORTIN LAVALLE	\N
127	54	1358	MUÑOZ	\N
127	54	1359	ROCHA	\N
127	54	1360	LA CELINA	\N
127	54	1361	COLONIA BARGA	\N
127	54	1362	COLONIA EL GUANACO	\N
127	54	1363	COLONIA LA GRACIELA	\N
127	54	1364	COLONIA LOS ALAMOS	\N
127	54	1365	COLONIA SAN FRANCISCO (JUAN A. PRADERE)	\N
127	54	1366	COLONIA TAPATTA	\N
127	54	1367	JUAN A. PRADERE	\N
127	54	1368	PASO ALSINA	\N
127	54	1369	FORTIN VIEJO	\N
127	54	1370	CARMEN DE PATAGONES	\N
127	54	1371	FARO SEGUNDA BARRANCA	\N
127	54	1372	LAS CORTADERAS	\N
127	54	1373	BAHIA SAN BLAS	\N
127	54	1374	CARDENAL CAGLIERO	\N
127	54	1375	PUERTO WASSERMANN	\N
127	54	1376	SALINA DE PIEDRA	\N
127	54	1377	AMBROSIO P. LEZICA	\N
127	54	1378	COLONIA LA CELINA	\N
127	54	1379	COLONIA MIGUEL ESTEVERENA	\N
127	54	1380	EMILIO LAMARCA	\N
127	54	1381	JARILLA	\N
127	54	1382	JOSE B. CASAS	\N
127	54	1383	PUERTO TRES BONETES	\N
127	54	1384	STROEDER	\N
127	54	1385	IGARZABAL	\N
127	54	1386	LOS POZOS	\N
127	54	1387	VILLALONGA	\N
127	54	1388	ALBARIÑO	\N
127	54	1389	ABEL	\N
127	54	1390	PEHUAJO	\N
127	54	1391	ROVIRA	\N
127	54	1392	SANTA CECILIA SUD	\N
127	54	1393	ANCON	\N
127	54	1394	GIRONDO	\N
127	54	1395	GNECCO	\N
127	54	1396	INOCENCIO SOSA	\N
127	54	1397	LARRAMENDY	\N
127	54	1398	MAGDALA	\N
127	54	1399	NUEVA PLATA	\N
127	54	1400	PEDRO GAMEN	\N
127	54	1401	CAPITAN CASTRO	\N
127	54	1402	LA COTORRA	\N
127	54	1403	ALAGON	\N
127	54	1404	ASTURIAS	\N
127	54	1405	MONES CAZON	\N
127	54	1406	FRANCISCO MADERO	\N
127	54	1407	SANTA CECILIA NORTE	\N
127	54	1408	CAMPO ARISTIMUÑO	\N
127	54	1409	EL RECADO	\N
127	54	1410	JUAN JOSE PASO	\N
127	54	1411	CHICLANA	\N
127	54	1412	GUANACO	\N
127	54	1413	LAS JUANITAS	\N
127	54	1414	MARIA P. MORENO	\N
127	54	1415	PELLEGRINI	\N
127	54	1416	BOCAYUVA	\N
127	54	1417	DE BARY	\N
127	54	1418	JOSE MARIA BLANCO	\N
127	54	1419	BARRIO TROCHA	\N
127	54	1420	CAMPO BUENA VISTA	\N
127	54	1421	CHACRA EXPERIMENTAL	\N
127	54	1422	FRANCISCO AYERZA	\N
127	54	1423	LA CORA	\N
127	54	1424	PERGAMINO	\N
127	54	1425	PUEBLO OTERO	\N
127	54	1426	SANTA RITA	\N
127	54	1427	TAMBO NUEVO	\N
127	54	1428	VILLA PROGRESO	\N
127	54	1429	DOCE DE AGOSTO	\N
127	54	1430	HARAS EL CENTINELA	\N
127	54	1431	MARIANO BENITEZ	\N
127	54	1432	RANCAGUA	\N
127	54	1433	SANTA TERESITA PERGAMINO	\N
127	54	1434	ORTIZ BASUALDO	\N
127	54	1435	PINZON	\N
127	54	1436	ALMACEN PIATTI	\N
127	54	1437	COLONIA LA VANGUARDIA	\N
127	54	1438	PARAJE SANTA ROSA	\N
127	54	1439	SAN FEDERICO	\N
127	54	1440	MANUEL OCAMPO	\N
127	54	1441	EL SOCORRO	\N
127	54	1442	LA MARGARITA (EL SOCORRO)	\N
127	54	1443	LA VANGUARDIA	\N
127	54	1444	ACEVEDO	\N
127	54	1445	GORNATTI	\N
127	54	1446	GUERRICO	\N
127	54	1447	JUAN A. DE LA PEÑA	\N
127	54	1448	MANANTIALES	\N
127	54	1449	MANANTIALES GRANDES	\N
127	54	1450	FONTEZUELA	\N
127	54	1451	LIERRA ADJEMIRO	\N
127	54	1452	LOPEZ MOLINARI	\N
127	54	1453	MAGUIRE	\N
127	54	1454	MANZO Y NIÑO	\N
127	54	1455	MARIANO H. ALFONZO	\N
127	54	1456	URQUIZA	\N
127	54	1457	VILLA DAFONTE	\N
127	54	1458	ALMACEN CASTRO	\N
127	54	1459	COLONIA LA NENA	\N
127	54	1460	COLONIA LOS TOLDOS	\N
127	54	1461	EL QUEMADO	\N
127	54	1462	LA VIOLETA	\N
127	54	1463	ESTANCIAS	\N
127	54	1464	JUAN G. PUJOL	\N
127	54	1465	MUTTI	\N
127	54	1466	CAMARON CHICO	\N
127	54	1467	DON VICENTE	\N
127	54	1468	EL VENCE	\N
127	54	1469	LA ALCIRA	\N
127	54	1470	LA DESPIERTA	\N
127	54	1471	LA LARGA NUEVA	\N
127	54	1472	LA PIEDRA	\N
127	54	1473	LAS CHILCAS	\N
127	54	1474	LAS TORTUGAS	\N
127	54	1475	PILA	\N
127	54	1476	SAN DANIEL	\N
127	54	1477	CASALINS	\N
127	54	1478	LA VICTORIA	\N
127	54	1479	PUENTE EL OCHENTA	\N
127	54	1480	REAL AUDIENCIA	\N
127	54	1481	ZELAYA	\N
127	54	1482	ALMIRANTE IRIZAR	\N
127	54	1483	BARRIO SAN ALEJO	\N
127	54	1484	ESTABLECIMIENTO SAN MIGUEL	\N
127	54	1485	MANZANARES	\N
127	54	1486	PILAR	\N
127	54	1487	VILLA AGUEDA	\N
127	54	1488	VILLA BUIDE	\N
127	54	1489	VILLA SANTA MARIA	\N
127	54	1490	VILLA VERDE	\N
127	54	1491	VILLA ROSA	\N
127	54	1492	FATIMA	\N
127	54	1493	MANZONE	\N
127	54	1494	VILLA ASTOLFI	\N
127	54	1495	KM 45 (PTE. DERQUI)	\N
127	54	1496	PRESIDENTE DERQUI	\N
127	54	1497	TORO	\N
127	54	1498	MANUEL ALBERTI	\N
127	54	1499	DEL VISO	\N
127	54	1500	LA LONJA	\N
127	54	1501	MAQUINISTA FRANCISCO SAVIO (PILAR)	\N
127	54	1502	CARILO	\N
127	54	1503	OSTENDE	\N
127	54	1504	PARQUE CARILO	\N
127	54	1505	PINAMAR	\N
127	54	1506	VALERIA DEL MAR	\N
127	54	1507	EMPALME PIEDRA ECHADA	\N
127	54	1508	LOPEZ LECUBE	\N
127	54	1509	PIEDRA ANCHA	\N
127	54	1510	LA POCHOLA	\N
127	54	1511	SAN GERMAN	\N
127	54	1512	ALDEA SAN ANDRES	\N
127	54	1513	GENERAL RONDEAU	\N
127	54	1514	LA COLORADA CHICA	\N
127	54	1515	VILLA IRIS	\N
127	54	1516	ESTELA	\N
127	54	1517	RIVADEO	\N
127	54	1518	DIECISIETE DE AGOSTO	\N
127	54	1519	FELIPE SOLA	\N
127	54	1520	COLONIA LA CATALINA	\N
127	54	1521	LA CATALINA	\N
127	54	1522	LA EVA	\N
127	54	1523	LA SOMBRA	\N
127	54	1524	SAN JOSE (ALGARROBO)	\N
127	54	1525	COLONIA GOBERNADOR UDAONDO	\N
127	54	1526	PUAN	\N
127	54	1527	VIBORAS	\N
127	54	1528	AZOPARDO	\N
127	54	1529	COLONIA EL PINCEN	\N
127	54	1530	COLONIA HIPOLITO YRIGOYEN	\N
127	54	1531	ERIZE	\N
127	54	1532	LAS VASCONGADAS	\N
127	54	1533	COLONIA LA VASCONGADA	\N
127	54	1534	DARREGUEIRA	\N
127	54	1535	TRES CUERVOS	\N
127	54	1536	BORDENAVE	\N
127	54	1537	LA ROSALIA	\N
127	54	1538	BERNAL	\N
127	54	1539	DON BOSCO	\N
127	54	1540	QUILMES	\N
127	54	1541	VILLA ARGENTINA (QUILMES)	\N
127	54	1542	VILLA ELENA (QUILMES)	\N
127	54	1543	VILLA MARIA (QUILMES)	\N
127	54	1544	QUILMES OESTE	\N
127	54	1545	SAN FRANCISCO SOLANO	\N
127	54	1546	SANTA ISABEL (SAN FRANCISCO SOLANO)	\N
127	54	1547	VILLA LA FLORIDA	\N
127	54	1548	EZPELETA	\N
127	54	1549	ALMACEN EL CRUCE	\N
127	54	1550	COLONIA LA INVERNADA	\N
127	54	1551	COLONIA LA NORIA	\N
127	54	1552	COLONIA LA REINA	\N
127	54	1553	COLONIA STEGMAN	\N
127	54	1554	LA QUERENCIA	\N
127	54	1555	SANCHEZ	\N
127	54	1556	SANTA TERESA (SANCHEZ)	\N
127	54	1557	COSTA BRAVA	\N
127	54	1558	VILLA ESTACION RAMALLO	\N
127	54	1559	VILLA RAMALLO	\N
127	54	1560	AGUIRREZABALA	\N
127	54	1561	CAMPO AGUIRREZABALA	\N
127	54	1562	RAMALLO	\N
127	54	1563	EL JUPITER	\N
127	54	1564	EL PARAISO	\N
127	54	1565	HARAS EL OMBU	\N
127	54	1566	LAS BAHAMAS	\N
127	54	1567	COLONIA VELAZ	\N
127	54	1568	PEREZ MILLAN	\N
127	54	1569	EGAÑA	\N
127	54	1570	MAGALLANES	\N
127	54	1571	MARTIN COLMAN	\N
127	54	1572	MIRANDA	\N
127	54	1573	CHAPALEUFU	\N
127	54	1574	EL CARMEN DE LANGUEYU	\N
127	54	1575	GALERA DE TORRES	\N
127	54	1576	LOMA PARTIDA	\N
127	54	1577	RAUCH	\N
127	54	1578	VILLA SAN PEDRO	\N
127	54	1579	CONDARCO	\N
127	54	1580	SANSINENA	\N
127	54	1581	AMERICA	\N
127	54	1582	CERRITO	\N
127	54	1583	RIVADAVIA	\N
127	54	1584	GONZALEZ MORENO	\N
127	54	1585	MERIDIANO V	\N
127	54	1586	SAN MAURICIO	\N
127	54	1587	ELDIA	\N
127	54	1588	SUNDBLAD	\N
127	54	1589	VALENTIN GOMEZ	\N
127	54	1590	BADANO	\N
127	54	1591	COLONIA EL BALDE	\N
127	54	1592	FORTIN OLAVARRIA	\N
127	54	1593	LA CAUTIVA	\N
127	54	1594	MIRA PAMPA	\N
127	54	1595	ROOSEVELT (EST.MERIDIANO V)	\N
127	54	1596	VILLA SENA	\N
127	54	1597	CARABELAS	\N
127	54	1598	PLUMACHO	\N
127	54	1599	ROBERTO CANO	\N
127	54	1600	CUATRO DE NOVIEMBRE	\N
127	54	1601	HARAS SAN JACINTO	\N
127	54	1602	PIRUCO	\N
127	54	1603	ROJAS	\N
127	54	1604	VILLA PROGRESO (ROJAS)	\N
127	54	1605	EL JAGUEL	\N
127	54	1606	GUIDO SPANO	\N
127	54	1607	HUNTER	\N
127	54	1608	LA NACION	\N
127	54	1609	LAS SALADAS	\N
127	54	1610	LOS INDIOS	\N
127	54	1611	SOL DE MAYO	\N
127	54	1612	RAFAEL OBLIGADO	\N
127	54	1613	LA BEBA	\N
127	54	1614	HARAS EL SALASO	\N
127	54	1615	JUAN ATUCHA	\N
127	54	1616	LA RINCONADA	\N
127	54	1617	ROQUE PEREZ	\N
127	54	1618	SANTIAGO LARRE	\N
127	54	1619	BARRIENTOS	\N
127	54	1620	CARLOS BEGUERIE	\N
127	54	1621	JUAN TRONCONI	\N
127	54	1622	LA PAZ CHICA	\N
127	54	1623	PARAJE EL ARBOLITO	\N
127	54	1624	COLONIA SAN MARTIN	\N
127	54	1625	COLONIA SAN PEDRO	\N
127	54	1626	DUFAUR	\N
127	54	1627	ABRA DE HINOJO	\N
127	54	1628	DUCOS	\N
127	54	1629	PIGUE	\N
127	54	1630	ESPARTILLAR (SAAVEDRA)	\N
127	54	1631	ARROYO CORTO	\N
127	54	1632	ARROYO AGUAS BLANCAS	\N
127	54	1633	LA SAUDADE	\N
127	54	1634	SAAVEDRA	\N
127	54	1635	SAN MARTIN DE TOURS	\N
127	54	1636	GOYENA	\N
127	54	1637	ALTA VISTA	\N
127	54	1638	BARRIO VILLA SALADILLO	\N
127	54	1639	EL MANGRULLO	\N
127	54	1640	EMILIANO REYNOSO	\N
127	54	1641	ESTHER	\N
127	54	1642	JOSE R. SOJO	\N
127	54	1643	JUAN BLAQUIER	\N
127	54	1644	LA BARRANCOSA	\N
127	54	1645	LA CAMPANA	\N
127	54	1646	LA MARGARITA	\N
127	54	1647	LA RAZON	\N
127	54	1648	SALADILLO	\N
127	54	1649	SALADILLO NORTE	\N
127	54	1650	SAN BENITO	\N
127	54	1651	CAZON	\N
127	54	1652	DEL CARRIL	\N
127	54	1653	ALVAREZ DE TOLEDO	\N
127	54	1654	POLVAREDAS	\N
127	54	1655	EL RETIRO	\N
127	54	1656	LAS CUATRO PUERTAS	\N
127	54	1657	MARCELINO UGARTE	\N
127	54	1658	SALTO	\N
127	54	1659	ARROYO DULCE	\N
127	54	1660	BERDIER	\N
127	54	1661	MONROE	\N
127	54	1662	TACUARI	\N
127	54	1663	VILLA SAN JOSE	\N
127	54	1664	GAHAN	\N
127	54	1665	LA INVENCIBLE	\N
127	54	1666	INES INDART	\N
127	54	1667	GRACIARENA	\N
127	54	1668	QUENUMA	\N
127	54	1669	CAILOMUTA	\N
127	54	1670	SALLIQUELO	\N
127	54	1671	FRANKLIN	\N
127	54	1672	VILLA RUIZ	\N
127	54	1673	VILLA ESPIL	\N
127	54	1674	SAN ANDRES DE GILES	\N
127	54	1675	VILLA SAN ALBERTO	\N
127	54	1676	AZCUENAGA	\N
127	54	1677	TUYUTI	\N
127	54	1678	CUCULLU	\N
127	54	1679	HEAVY	\N
127	54	1680	PUENTE CASTEX	\N
127	54	1681	SAN ANTONIO DE ARECO	\N
127	54	1682	VILLA LIA	\N
127	54	1683	FLAMENCO	\N
127	54	1684	PUESTO DEL MEDIO	\N
127	54	1685	DUGGAN	\N
127	54	1686	SOLIS	\N
127	54	1687	VAGUES	\N
127	54	1688	CRISTIANO MUERTO	\N
127	54	1689	LA FELICIANA	\N
127	54	1690	LOS MOLLES	\N
127	54	1691	SANTA CATALINA (CRISTIANO MUERTO)	\N
127	54	1692	DEFERRARI	\N
127	54	1693	OCHANDIO	\N
127	54	1694	SAN CAYETANO	\N
127	54	1695	COOPER	\N
127	54	1696	BALNEARIO SAN CAYETANO	\N
127	54	1697	DOCTOR ALBERT SCHWEITZER	\N
127	54	1698	VICTORIA	\N
127	54	1699	BARRIO SAN JORGE (SAN FERNANDO)	\N
127	54	1700	VILLA DEL CARMEN (SAN FERNANDO)	\N
127	54	1701	VIRREYES	\N
127	54	1702	ARROYO DURAZNO	\N
127	54	1703	RIO CARABELAS	\N
127	54	1704	JOSE MARTI	\N
127	54	1705	VILLA ADELINA	\N
127	54	1706	BOULOGNE SUR MER	\N
127	54	1707	ACASSUSO	\N
127	54	1708	MARTINEZ	\N
127	54	1709	SAN ISIDRO	\N
127	54	1710	BECCAR	\N
127	54	1711	BARRIO SARGENTO CABRAL CAMPO DE MAYO	\N
127	54	1712	CAMPO DE MAYO	\N
127	54	1713	BELLA VISTA	\N
127	54	1714	CAPITAN LOZANO	\N
127	54	1715	SARGENTO BARRUFFALDI	\N
127	54	1716	TENIENTE AGNETA	\N
127	54	1717	TENIENTE GRAL. RICCHIERI	\N
127	54	1718	GENERAL SARMIENTO	\N
127	54	1719	LA ESTRELLA (TRUJUI)	\N
127	54	1720	MUÑIZ	\N
127	54	1721	SAN MIGUEL	\N
127	54	1722	SANTA MARIA	\N
127	54	1723	CAMINERA SAN NICOLAS	\N
127	54	1724	PUERTO SAN NICOLAS	\N
127	54	1725	SAN NICOLAS	\N
127	54	1726	GENERAL MANUEL SAVIO	\N
127	54	1727	LA EMILIA	\N
127	54	1728	VILLA HERMOSA	\N
127	54	1729	CAMPOS SALLES	\N
127	54	1730	EREZCANO	\N
127	54	1731	LOPEZ ARIAS	\N
127	54	1732	LOS DOS AMIGOS	\N
127	54	1733	COLONIA LA ALICIA	\N
127	54	1734	GENERAL ROJO	\N
127	54	1735	CONESA	\N
127	54	1736	INGENIERO URCELAY	\N
127	54	1737	LA BUENA MOZA	\N
127	54	1738	SAN PEDRO	\N
127	54	1739	VILLA DEPIETRI	\N
127	54	1740	VILLA SARITA	\N
127	54	1741	VILLAIGRILLO	\N
127	54	1742	LA MATILDE	\N
127	54	1743	VUELTA DE OBLIGADO	\N
127	54	1744	LA BOLSA	\N
127	54	1745	ALGARROBO (ING. MONETA)	\N
127	54	1746	ARROYO BURGOS	\N
127	54	1747	DOYLE	\N
127	54	1748	EL DESCANSO	\N
127	54	1749	INGENIERO MONETA	\N
127	54	1750	PARADA KILOMETRO 158	\N
127	54	1751	SANTA LUCIA	\N
127	54	1752	RIO TALA	\N
127	54	1753	VILLA TERESA	\N
127	54	1754	EL ESPINILLO	\N
127	54	1755	GOBERNADOR CASTRO	\N
127	54	1756	VILLA LEANDRA	\N
127	54	1757	LA TOSQUERA	\N
127	54	1758	BARRIO SAN PABLO	\N
127	54	1759	BARRIO SANTA MAGDALENA	\N
127	54	1760	ALEJANDRO KORN	\N
127	54	1761	EMPALME SAN VICENTE	\N
127	54	1762	EL PAMPERO	\N
127	54	1763	LA ARGENTINA	\N
127	54	1764	SAN VICENTE	\N
127	54	1765	DOMSELAAR	\N
127	54	1766	CAPDEPONT	\N
127	54	1767	HARAS LA ELVIRA	\N
127	54	1768	LA SARA	\N
127	54	1769	ROMAN BAEZ	\N
127	54	1770	SUIPACHA	\N
127	54	1771	RIVAS	\N
127	54	1772	CANTERA ALBION	\N
127	54	1773	CANTERA LA FEDERACION	\N
127	54	1774	CANTERA SAN LUIS	\N
127	54	1775	EL GALLO	\N
127	54	1776	LA NUMANCIA	\N
127	54	1777	TANDIL	\N
127	54	1778	VILLA GALICIA	\N
127	54	1779	CERRO LEONES	\N
127	54	1780	LA PASTORA	\N
127	54	1781	ACELAIN	\N
127	54	1782	GARDEY	\N
127	54	1783	MARIA IGNACIA	\N
127	54	1784	VELA (MARIA IGNACIA)	\N
127	54	1785	AZUCENA	\N
127	54	1786	FULTON	\N
127	54	1787	LA AZOTEA	\N
127	54	1788	SAN PASCUAL	\N
127	54	1789	IRAOLA	\N
127	54	1790	LA AURORA	\N
127	54	1791	DE LA CANAL	\N
127	54	1792	SAN BERNARDO	\N
127	54	1793	LA ISABEL	\N
127	54	1794	EUFEMIO UBALLES	\N
127	54	1795	ALTONA	\N
127	54	1796	CAMPO ROJAS	\N
127	54	1797	EL SAUCE	\N
127	54	1798	TAPALQUE	\N
127	54	1799	YERBAS	\N
127	54	1800	VELLOSO	\N
127	54	1801	CROTTO	\N
127	54	1802	REQUENA	\N
127	54	1803	DON TORCUATO	\N
127	54	1804	VICEALMIRANTE E. MONTES	\N
127	54	1805	ALTO DEL TALAR	\N
127	54	1806	BARRIO EL ZORZAL	\N
127	54	1807	LOS TRONCOS DEL TALAR	\N
127	54	1808	BARRIO RICARDO ROJAS (GENERAL PACHECO-PDO. TIGRE)	\N
127	54	1809	RICARDO ROJAS	\N
127	54	1810	GENERAL PACHECO	\N
127	54	1811	LOPEZ CAMELO	\N
127	54	1812	EL TALAR	\N
127	54	1813	BENAVIDEZ	\N
127	54	1814	DIQUE LUJAN	\N
127	54	1815	NUEVO PUERTO TIGRE	\N
127	54	1816	TIGRE	\N
127	54	1817	VILLA LA ÑATA	\N
127	54	1818	RIO SAN ANTONIO	\N
127	54	1819	RINCON DE MILBERG	\N
127	54	1820	NORDELTA	\N
127	54	1821	ESQUINA CROTTO	\N
127	54	1822	GENERAL CONESA	\N
127	54	1823	TORDILLO	\N
127	54	1824	CHASICO	\N
127	54	1825	EL CORTA PIE	\N
127	54	1826	NUEVA ROMA	\N
127	54	1827	PELICURA	\N
127	54	1828	ESTOMBA	\N
127	54	1829	BERRAONDO	\N
127	54	1830	GLORIALDO	\N
127	54	1831	FORTIN CHACO	\N
127	54	1832	FUERTE ARGENTINO	\N
127	54	1833	TORNQUIST	\N
127	54	1834	GARCIA DEL RIO	\N
127	54	1835	TRES PICOS	\N
127	54	1836	SALDUNGARAY	\N
127	54	1837	SIERRA DE LA VENTANA	\N
127	54	1838	VILLA VENTANA	\N
127	54	1839	BARRIO INDIO TROMPA	\N
127	54	1840	LA ZANJA	\N
127	54	1841	LAGUNA REDONDA	\N
127	54	1842	LAS GUASQUITAS	\N
127	54	1843	LERTORA	\N
127	54	1844	MARI LAUQUEN	\N
127	54	1845	MARTIN FIERRO	\N
127	54	1846	TRENQUE LAUQUEN	\N
127	54	1847	FRANCISCO DE VITORIA	\N
127	54	1848	30 DE AGOSTO	\N
127	54	1849	CORAZZI	\N
127	54	1850	DUHAU	\N
127	54	1851	GIRODIAS	\N
127	54	1852	LA PORTEÑA	\N
127	54	1853	TRONGE	\N
127	54	1854	PRIMERA JUNTA	\N
127	54	1855	BERUTTI	\N
127	54	1856	SAN RAMON	\N
127	54	1857	LA CARRETA	\N
127	54	1858	VILLA BRANDA	\N
127	54	1859	FRANCISCO MAGNANO	\N
127	54	1860	CLAUDIO C. MOLINA	\N
127	54	1861	EL CARRETERO	\N
127	54	1862	EL TRIANGULO	\N
127	54	1863	HUESO CLAVADO	\N
127	54	1864	LA TIGRA	\N
127	54	1865	LAS VAQUERIAS	\N
127	54	1866	TRES ARROYOS	\N
127	54	1867	GENARO VALDES	\N
127	54	1868	ORENSE	\N
127	54	1869	CLAROMECO	\N
127	54	1870	SAN FRANCISCO DE BELLOCQ	\N
127	54	1871	LIN-CALEL	\N
127	54	1872	EL BOMBERO	\N
127	54	1873	MICAELA CASCALLARES	\N
127	54	1874	BALNEARIO OCEANO	\N
127	54	1875	COPETONAS	\N
127	54	1876	PASO DEL MEDANO	\N
127	54	1877	RETA	\N
127	54	1878	PIERINI	\N
127	54	1879	BARROW	\N
127	54	1880	SAN MAYOL	\N
127	54	1881	BALNEARIO ORENSE	\N
127	54	1882	CHURRUCA	\N
127	54	1883	LOMA HERMOSA	\N
127	54	1884	PABLO PODESTA	\N
127	54	1885	11 DE SEPTIEMBRE	\N
127	54	1886	REMEDIOS DE ESCALADA DE SAN MARTIN	\N
127	54	1887	SAENZ PEÑA	\N
127	54	1888	VILLA RAFFO	\N
127	54	1889	CUADRILLA 1011 (FGCSM.)	\N
127	54	1890	SANTOS LUGARES	\N
127	54	1891	VILLA TALLERES ALIANZA	\N
127	54	1892	CASEROS	\N
127	54	1893	VILLA MATHEU	\N
127	54	1894	VILLA PARQUE	\N
127	54	1895	MARTIN CORONADO	\N
127	54	1896	VILLA BOSCH	\N
127	54	1897	CIUDAD JARDIN LOMAS DEL PALOMAR	\N
127	54	1898	CIUDADELA	\N
127	54	1899	JOSE INGENIEROS	\N
127	54	1900	EL LIBERTADOR	\N
127	54	1901	INGENIERO THOMPSON	\N
127	54	1902	PEHUELCHES	\N
127	54	1903	TRES LOMAS	\N
127	54	1904	ESCUELA AGRICOLA SALESIANA (C. G. UNZUE)	\N
127	54	1905	DEL VALLE	\N
127	54	1906	HUETEL	\N
127	54	1907	ANDERSON	\N
127	54	1908	GOBERNADOR UGARTE	\N
127	54	1909	ARAUJO	\N
127	54	1910	25 DE MAYO	\N
127	54	1911	LAGUNA LAS MULITAS	\N
127	54	1912	ORTIZ DE ROSAS	\N
127	54	1913	SANTIAGO GARBARINI	\N
127	54	1914	BLAS DURAÑONA	\N
127	54	1915	LUCAS MONTEVERDE	\N
127	54	1916	MAMAGUITA	\N
127	54	1917	PUEBLITOS	\N
127	54	1918	SAN ENRIQUE	\N
127	54	1919	JUAN VELA	\N
127	54	1920	NORBERTO DE LA RIESTRA	\N
127	54	1921	ERNESTINA	\N
127	54	1922	LA GLORIA	\N
127	54	1923	PEDERNALES	\N
127	54	1924	SAN JOSE 	\N
127	54	1925	AGUSTIN MOSCONI	\N
127	54	1926	COLONIA INCHAUSTI	\N
127	54	1927	ISLAS	\N
127	54	1928	LA RABIA	\N
127	54	1929	MARTIN BERRAONDO	\N
127	54	1930	VALDES	\N
127	54	1931	ARISTOBULO DEL VALLE	\N
127	54	1932	DOCTOR ANTONIO CETRANGOLO	\N
127	54	1933	FLORIDA	\N
127	54	1934	JUAN B. JUSTO (FLORIDA)	\N
127	54	1935	VILLA MARTELLI	\N
127	54	1936	MUNRO	\N
127	54	1937	CARAPACHAY	\N
127	54	1938	BARTOLOME MITRE	\N
127	54	1939	BORGES	\N
127	54	1940	LA LUCILA	\N
127	54	1941	OLIVOS	\N
127	54	1942	VICENTE LOPEZ	\N
127	54	1943	VILLA ADELINA	\N
127	54	1944	FARO QUERANDI	\N
127	54	1945	MAR AZUL	\N
127	54	1946	VILLA GESELL	\N
127	54	1947	COLONIA LA MERCED	\N
127	54	1948	LA MERCED	\N
127	54	1949	CABEZA DE BUEY	\N
127	54	1950	MEDANOS	\N
127	54	1951	ARGERICH	\N
127	54	1952	COLONIA OCAMPO	\N
127	54	1953	LA GLEVA	\N
127	54	1954	LAGUNA CHASICO	\N
127	54	1955	LAS ESCOBAS	\N
127	54	1956	MASCOTA	\N
127	54	1957	NICOLAS LEVALLE	\N
127	54	1958	PASO CRAMER	\N
127	54	1959	ALGARROBO	\N
127	54	1960	COLONIA CUARENTA Y TRES	\N
127	54	1961	JUAN COUSTE	\N
127	54	1962	LA BLANCA	\N
127	54	1963	MONTES DE OCA	\N
127	54	1964	SAN EMILIO (ALGARROBO)	\N
127	54	1965	HILARIO ASCASUBI	\N
127	54	1966	OMBUCTA	\N
127	54	1967	PUERTO COLOMA	\N
127	54	1968	SAN ADOLFO	\N
127	54	1969	TENIENTE ORIGONE	\N
127	54	1970	EL RINCON (MAYOR BURATOVICH)	\N
127	54	1971	ISLA VERDE	\N
127	54	1972	MAYOR BURATOVICH	\N
127	54	1973	VILLA RIO CHICO	\N
127	54	1974	FORTIN MERCEDES	\N
127	54	1975	LAS ISLETAS	\N
127	54	1976	PEDRO LURO	\N
127	54	1977	VILLA SAN ANTONIO	\N
127	54	1978	ARROYO BOTIJA FALSA	\N
127	54	1979	ARROYO NEGRO (ZARATE)	\N
127	54	1980	BARRIO SAN JACINTO	\N
127	54	1981	CANAL MARTIN IRIGOYEN	\N
127	54	1982	VILLA ANGUS	\N
127	54	1983	VILLA FOX	\N
127	54	1984	VILLA MASSONI	\N
127	54	1985	ZARATE	\N
127	54	1986	ALTO VERDE	\N
127	54	1987	EL TATU	\N
127	54	1988	ESCALADA	\N
127	54	1989	FRIGORIFICO LAS PALMAS	\N
127	54	1990	LIMA	\N
127	54	1991	ATUCHA	\N
127	54	1992	AEROPUERTO EZEIZA	\N
127	54	1993	AEROPUERTO EZEIZA ESTAFETA N 1	\N
127	54	1994	EZEIZA	\N
127	54	1995	UNION FERROVIARIA	\N
127	54	1996	TRISTAN SUAREZ	\N
127	54	1997	CARLOS SPEGAZZINI	\N
127	54	1998	LAS TAHONAS	\N
127	54	1999	LUIS CHICO	\N
127	54	2000	MONTE VELOZ	\N
127	54	2001	PUNTA INDIO	\N
127	54	2002	VERONICA	\N
127	54	2003	BASE AERONAVAL PUNTA INDIO	\N
127	54	2004	ALVAREZ JONTE	\N
127	54	2005	LA PRIMAVERA(ALVAREZ JONTE)	\N
127	54	2006	PIPINAS	\N
127	54	2007	PANCHO DIAZ	\N
127	54	2008	HURLINGHAM	\N
127	54	2009	PEREYRA	\N
127	54	2010	WILLIAMS MORRIS	\N
127	54	2011	SANTOS TESEI	\N
127	54	2012	VILLA TESEI	\N
127	54	2013	IPARRAGUIRRE	\N
127	54	2014	PARQUE LELOIR	\N
127	54	2015	GOBERNADOR UDAONDO	\N
127	54	2016	BARRIO AERONAUTICO	\N
127	54	2017	BARRIO SAN JUAN	\N
127	54	2018	VILLA ALBERDI	\N
127	54	2019	ITUZAINGO	\N
127	54	2020	LAS NACIONES	\N
127	54	2021	VILLA GRAND BOURG	\N
127	54	2022	VILLA IRUPE	\N
127	54	2023	VILLA LEON	\N
127	54	2024	VILLA NUMANCIA	\N
127	54	2025	GUERNICA	\N
127	54	2026	ATILIO PESSAGNO	\N
127	54	2027	EL DESTINO	\N
127	54	2028	LEZAMA	\N
127	54	2029	MANUEL J. COBO (LEZAMA)	\N
127	54	2030	MONASTERIO	\N
128	54	2031	AMBATO	\N
128	54	2032	CASAS VIEJAS	\N
128	54	2033	CHUCHUCARUANA	\N
128	54	2034	COLPES-AMBATO	\N
128	54	2035	EL ARBOL SOLO	\N
128	54	2036	EL BOLSON (LOS VARELA)	\N
128	54	2037	EL CHORRO (SINGUIL)	\N
128	54	2038	EL NOGAL	\N
128	54	2039	EL PARQUE	\N
128	54	2040	EL PIE DE LA CUESTA	\N
128	54	2041	EL POLEAR (LOS CASTILLOS)	\N
128	54	2042	EL POTRERILLO	\N
128	54	2043	EL RODEO GRANDE	\N
128	54	2044	EL TABIQUE	\N
128	54	2045	HUAYCAMA (LA PUERTA)	\N
128	54	2046	HUMAYA	\N
128	54	2047	ISLA LARGA	\N
128	54	2048	LA AGUADA (LOS CASTILLOS)	\N
128	54	2049	LA PUERTA	\N
128	54	2050	LAS CHACRITAS	\N
128	54	2051	LAS PAMPITAS (HUMAYA)	\N
128	54	2052	LOS CASTILLOS	\N
128	54	2053	LOS GUINDOS	\N
128	54	2054	LOS NARVAEZ	\N
128	54	2055	LOS NAVARROS	\N
128	54	2056	LOS TALAS	\N
128	54	2057	LOS VARELA	\N
128	54	2058	SINGUIL	\N
128	54	2059	AGUA VERDE	\N
128	54	2060	BELLA VISTA (EL RODEO)	\N
128	54	2061	CHAMORRO	\N
128	54	2062	CHAVARRIA	\N
128	54	2063	EL ATOYAL	\N
128	54	2064	EL BISCOTE	\N
128	54	2065	EL RODEO	\N
128	54	2066	EL TALA (EL RODEO)	\N
128	54	2067	LA CAÑADA (RODEO)	\N
128	54	2068	LA PIEDRA	\N
128	54	2069	LA QUEBRADA (EL RODEO)	\N
128	54	2070	LAS AGUITAS	\N
128	54	2071	LAS BURRAS	\N
128	54	2072	LAS CUCHILLAS (LAS PIEDRAS BLANCAS)	\N
128	54	2073	LAS JUNTAS	\N
128	54	2074	LAS LAJAS (LAS JUNTAS)	\N
128	54	2075	LAS PIEDRAS BLANCAS	\N
128	54	2076	LOS LOROS	\N
128	54	2077	LOS MOLLES (EL RODEO)	\N
128	54	2078	MOLLE QUEMADO	\N
128	54	2079	VILLA QUINTIN AHUMADA	\N
128	54	2080	RODEO GRANDE	\N
128	54	2081	LA CUESTA	\N
128	54	2082	COLPES	\N
128	54	2083	LOS PUESTOS (COLPES)	\N
128	54	2084	SAN MARTIN (TAPSO)	\N
128	54	2085	ACOSTILLA	\N
128	54	2086	AMANA	\N
128	54	2087	ANCASTI	\N
128	54	2088	ANQUINCILA	\N
128	54	2089	CABRERA	\N
128	54	2090	CALACIO	\N
128	54	2091	CANDELARIA	\N
128	54	2092	CASA ARMADA	\N
128	54	2093	CASAS VIEJAS	\N
128	54	2094	CONCEPCION (CANDELARIA)	\N
128	54	2095	CORRAL DE PIEDRA (IPIZCA)	\N
128	54	2096	EL ARBOLITO (TACO)	\N
128	54	2097	EL BARREAL (ANCASTI)	\N
128	54	2098	EL CEVILAR	\N
128	54	2099	EL CHAÑARAL (CASA ARMADA)	\N
128	54	2100	EL CHORRO	\N
128	54	2101	EL LINDERO (TACANA)	\N
128	54	2102	EL MOJON	\N
128	54	2103	EL MOLLAR	\N
128	54	2104	EL SAUCE (ANCASTI)	\N
128	54	2105	EL SAUCE (IPIZCA)	\N
128	54	2106	EL TOTORAL (ANQUINCILA)	\N
128	54	2107	EL VALLECITO (TACO)	\N
128	54	2108	EL ZAPALLAR (TACO)	\N
128	54	2109	ESTANCIA VIEJA (IPIZCA)	\N
128	54	2110	GUANACO	\N
128	54	2111	HIGUERA DEL ALUMBRE	\N
128	54	2112	IPIZCA	\N
128	54	2113	LA AGUADITA (TACANA)	\N
128	54	2114	LA BARROSA (CANDELARIAI)	\N
128	54	2115	LA BEBIDA	\N
128	54	2116	LA CALERA (AMANA)	\N
128	54	2117	LA ESTANCIA (CASA ARMADA)	\N
128	54	2118	LA ESTANCITA	\N
128	54	2119	LA FALDA (ANCASTI)	\N
128	54	2120	LA MESADA (TACANA)	\N
128	54	2121	LAS BARRANCAS (ANCASTI)	\N
128	54	2122	LAS BARRANCAS (CASA ARMADA)	\N
128	54	2123	LAS CHACRAS (CASA ARMADA)	\N
128	54	2124	LAS TUNAS (ANCASTI)	\N
128	54	2125	LOMA SOLA	\N
128	54	2126	LOS BULACIOS	\N
128	54	2127	LOS HUAYCOS	\N
128	54	2128	LOS MORTEROS (TACANA)	\N
128	54	2129	LOS ORTICES (TACANA)	\N
128	54	2130	LOS PIQUILLINES	\N
128	54	2131	POTRERO DE LOS CORDOBA	\N
128	54	2132	RIO LOS MOLINOS	\N
128	54	2133	SAN ANTONIO	\N
128	54	2134	SAN JOSE (CAÑADA DE PAEZ)	\N
128	54	2135	SANTA GERTRUDIS	\N
128	54	2136	SAUCE HUACHO (ANQUINCILA)	\N
128	54	2137	TACANA	\N
128	54	2138	TACO DE ABAJO	\N
128	54	2139	TOTORAL	\N
128	54	2140	EL CEVIL	\N
128	54	2141	AGUA DEL SIMBOL	\N
128	54	2142	ALTO DEL ROSARIO	\N
128	54	2143	CASA DE LA CUMBRE	\N
128	54	2144	CORRAL VIEJO	\N
128	54	2145	EL ARENAL	\N
128	54	2146	EL QUEBRACHAL	\N
128	54	2147	EL SALTITO	\N
128	54	2148	EL TOTORAL (LA DORADA-DPTO. ANCASTI)	\N
128	54	2149	LA HUERTA (RAMBLONES-DPTO. ANCASTI)	\N
128	54	2150	LA PEÑA (LA QUINTA-DPTO. ANCASTI)	\N
128	54	2151	LA TIGRA	\N
128	54	2152	LAS CUCHILLAS (RAMBLONES-DPTO. ANCASTI)	\N
128	54	2153	LOS MOGOTES	\N
128	54	2154	LOS MOLLES (RAMBLONES-DPTO. ANCASTI)	\N
128	54	2155	NAVAGUIN	\N
128	54	2156	AGUA LOS MATOS	\N
128	54	2157	CORRALITO (MAJADA-DPTO. ANCASTI)	\N
128	54	2158	LAS CUCHILLAS DEL AYBAL	\N
128	54	2159	SAUCE DE LOS CEJAS	\N
128	54	2160	YERBA BUENA	\N
128	54	2161	LOS RASTROJOS	\N
128	54	2162	CONDOR HUASI (DPTO. ANDALGALA)	\N
128	54	2163	ANDALGALA	\N
128	54	2164	ASERRADERO EL PILCIO	\N
128	54	2165	BANDA (ANDALGALA-DPTO. ANDALGALA)	\N
128	54	2166	DISTRITO ESPINILLO	\N
128	54	2167	EL COLEGIO	\N
128	54	2168	EL MOLLE	\N
128	54	2169	HUASCHASCHI	\N
128	54	2170	HUAZAN	\N
128	54	2171	LA AGUADA (ANDALGALA-DPTO. ANDALGALA)	\N
128	54	2172	MALLIN 2	\N
128	54	2173	PILCIAO	\N
128	54	2174	AGUA DE LAS PALOMAS	\N
128	54	2175	AMANAO	\N
128	54	2176	CARAPUNCO	\N
128	54	2177	CASA DE PIEDRA (VILLA VIL-DPTO. ANDALGALA)	\N
128	54	2178	CHAQUIAGO	\N
128	54	2179	CHOYA	\N
128	54	2180	EL CARRIZAL (VILLA VIL-DPTO. ANDALGALA)	\N
128	54	2181	EL POTRERO (DPTO. ANDALGALA)	\N
128	54	2182	EL ZAPALLAR (VILLA VIL-DPTO. ANDALGALA)	\N
128	54	2183	HUACO (DPTO. ANDALGALA)	\N
128	54	2184	LA LAGUNA	\N
128	54	2185	SANTA LUCIA (EL POTRERO-DPTO. ANDALGALA)	\N
128	54	2186	ACONQUIJA	\N
128	54	2187	ALTO DE LA JUNTA	\N
128	54	2188	ALUMBRERA	\N
128	54	2189	BUENA VISTA (EL ALAMITO-DPTO. ANDALGALA)	\N
128	54	2190	EL ALAMITO	\N
128	54	2191	EL ARBOLITO (EL ALAMITO-DPTO. ANDALGALA)	\N
128	54	2192	EL ESPINILLO	\N
128	54	2193	EL PUCARA	\N
128	54	2194	EL SUNCHO (ALTO DE LA JUNTA-DPTO. ANDALGALA)	\N
128	54	2195	LAS ESTANCIAS	\N
128	54	2196	LAS PAMPITAS (EL ALAMITO-DPTO. ANDALGALA)	\N
128	54	2197	RIO POTRERO	\N
128	54	2198	POTRERO	\N
128	54	2199	MOLLECITO	\N
128	54	2200	ANTOFAGASTA DE LA SIERRA	\N
128	54	2201	EL PEÑON	\N
128	54	2202	LOS MORTERITOS	\N
128	54	2203	VILLA VIL	\N
128	54	2204	AGUA COLORADA (BELEN-DPTO. BELEN)	\N
128	54	2205	AMPUJACO	\N
128	54	2206	BELEN	\N
128	54	2207	EL MOLINO	\N
128	54	2208	EL PORTEZUELO (BELEN-DPTO. BELEN)	\N
128	54	2209	HUACO (BELEN-DPTO. BELEN)	\N
128	54	2210	LA BANDA (BELEN-DPTO. BELEN)	\N
128	54	2211	LA PUNTILLA (BELEN-DPTO. BELEN)	\N
128	54	2212	TALAMAYO	\N
128	54	2213	AGUA DE DIONISIO	\N
128	54	2214	AGUAS CALIENTES	\N
128	54	2215	ASAMPAY	\N
128	54	2216	CACHIJAN	\N
128	54	2217	CARRIZAL (LA CIENAGA-DPTO. BELEN)	\N
128	54	2218	CARRIZAL DE ABAJO	\N
128	54	2219	CARRIZAL DE LA COSTA	\N
128	54	2220	CONDOR HUASI DE BELEN	\N
128	54	2221	CORRAL QUEMADO	\N
128	54	2222	COTAGUA	\N
128	54	2223	CULAMPAJA	\N
128	54	2224	EL BOLSON	\N
128	54	2225	EL CAJON	\N
128	54	2226	EL CAMPILLO	\N
128	54	2227	EL CARRIZAL	\N
128	54	2228	EL DURAZNO	\N
128	54	2229	EL EJE	\N
128	54	2230	EL TIO	\N
128	54	2231	EL TOLAR	\N
128	54	2232	FARALLON NEGRO	\N
128	54	2233	HUALFIN	\N
128	54	2234	HUASAYACO	\N
128	54	2235	JACIPUNCO	\N
128	54	2236	LA AGUADA (LA TOMA-DPTO. BELEN)	\N
128	54	2237	LA CAÑADA (LA CIENAGA-DPTO. BELEN)	\N
128	54	2238	LA CAPELLANIA (DPTO. BELEN)	\N
128	54	2239	LA CIENAGA (DPTO. BELEN)	\N
128	54	2240	LA ESTANCIA (LA PUERTA DE SAN JOSE-DPTO. BELEN)	\N
128	54	2241	LA PUERTA DE SAN JOSE	\N
128	54	2242	LA QUEBRADA (HUALFIN-DPTO. BELEN)	\N
128	54	2243	LA TOMA	\N
128	54	2244	LA VIÑA (LA CIENAGA-DPTO. BELEN)	\N
128	54	2245	LAGUNA BLANCA	\N
128	54	2246	LAGUNA COLORADA	\N
128	54	2247	LAS BARRANCAS (DPTO. BELEN)	\N
128	54	2248	LAS CUEVAS	\N
128	54	2249	LAS JUNTAS (LAS BARRANCAS-DPTO. BELEN)	\N
128	54	2250	LAS MANZAS	\N
128	54	2251	LOCONTE	\N
128	54	2252	LOS NACIMIENTOS	\N
128	54	2253	LOS POZUELOS (LOS NACIMIENTOS-DPTO. BELEN)	\N
128	54	2254	MINAS AGUA TAPADA	\N
128	54	2255	NACIMIENTOS DE ARRIBA	\N
128	54	2256	NACIMIENTOS DE SAN ANTONIO	\N
128	54	2257	NACIMIENTOS DEL BOLSON	\N
128	54	2258	PAPA CHACRA	\N
128	54	2259	POZO DE PIEDRA	\N
128	54	2260	PUERTA DEL CORRAL QUEMADO	\N
128	54	2261	RODEO GERVAN	\N
128	54	2262	SAN FERNANDO	\N
128	54	2263	TERMAS VILLA VIL	\N
128	54	2264	CORRALITO (LONDRES-DPTO. BELEN)	\N
128	54	2265	LA AGUADA (LONDRES-DPTO. BELEN)	\N
128	54	2266	LA RAMADA	\N
128	54	2267	LAS BAYAS	\N
128	54	2268	LONDRES	\N
128	54	2269	LONDRES ESTE	\N
128	54	2270	LONDRES OESTE	\N
128	54	2271	LOS COLORADOS	\N
128	54	2272	PIEDRA LARGA	\N
128	54	2273	SAN GERONIMO	\N
128	54	2274	CONETA	\N
128	54	2275	EL BAÑADO (MIRAFLORES-DPTO. CAPAYAN)	\N
128	54	2276	LA PARAGUAYA	\N
128	54	2277	LOS ANGELES	\N
128	54	2278	LOS BAZAN	\N
128	54	2279	LOS PINOS	\N
128	54	2280	LOS PUESTOS (MIRAFLORES-DPTO. CAPAYAN)	\N
128	54	2281	MIRAFLORES	\N
128	54	2282	NUEVA CONETA	\N
128	54	2283	SAN LORENZO (MIRAFLORES-DPTO. CAPAYAN)	\N
128	54	2284	SISIGUASI	\N
128	54	2285	CAPAYAN	\N
128	54	2286	CHAÑARITOS (HUILLAPIMA-DPTO. CAPAYAN)	\N
128	54	2287	CONCEPCION (DPTO. CAPAYAN)	\N
128	54	2288	EL CARRIZAL (SAN PEDRO. CAPAYAN-DPTO. CAPAYAN)	\N
128	54	2289	EL MILAGRO (HUILLAPIMA-DPTO. CAPAYAN)	\N
128	54	2290	HUILLAPIMA	\N
128	54	2291	LA CAÑADA (HUILLAPIMA-DPTO. CAPAYAN)	\N
128	54	2292	LAMPASILLO	\N
128	54	2293	LAS PALMAS	\N
128	54	2294	SAN PABLO	\N
128	54	2295	SAN PEDRO-CAPAYAN	\N
128	54	2296	CHUMBICHA	\N
128	54	2297	TRAMPASACHA	\N
128	54	2298	ADOLFO E. CARRANZA	\N
128	54	2299	BALDE LA PUNTA	\N
128	54	2300	BALDE NUEVO	\N
128	54	2301	BUENA VISTA (ADOLFO E. CARRANZA-DPTO. CAPAYAN)	\N
128	54	2302	LA HORQUETA	\N
128	54	2303	SAN MARTIN (DPTO. CAPAYAN)	\N
128	54	2304	TELARITOS	\N
128	54	2305	BANDA VARELA	\N
128	54	2306	EL TALA	\N
128	54	2307	LA AGUADA	\N
128	54	2308	LA BREA	\N
128	54	2309	LA CALERA	\N
128	54	2310	LA CHACARITA DE LOS PADRES	\N
128	54	2311	LAS VARITAS	\N
128	54	2312	LAZARETO	\N
128	54	2313	LOMA CORTADA	\N
128	54	2314	RIO DEL TALA	\N
128	54	2315	SAN FERNANDO DEL VALLE DE CATAMARCA	\N
128	54	2316	VILLA CUBAS	\N
128	54	2317	VILLA PARQUE CHACABUCO	\N
128	54	2318	BREA CHIMPANA	\N
128	54	2319	ACHALCO	\N
128	54	2320	AYAPASO	\N
128	54	2321	ICHIPUCA	\N
128	54	2322	LA CALERA (TAPSO-DPTO. EL ALTO)	\N
128	54	2323	LA QUEBRADA (TAPSO-DPTO. EL ALTO)	\N
128	54	2324	LAS LOMITAS (TAPSO-DPTO. EL ALTO)	\N
128	54	2325	LOS MORTEROS (TAPSO-DPTO. EL ALTO)	\N
128	54	2326	POZO GRANDE	\N
128	54	2327	TAPSO	\N
128	54	2328	BARRANQUITAS	\N
128	54	2329	BELLA VISTA (DPTO. EL ALTO)	\N
128	54	2330	EL ALTO (DPTO. EL ALTO)	\N
128	54	2331	EL ROSARIO (INFANZON-DPTO. EL ALTO)	\N
128	54	2332	EL VALLECITO (VILISMAN-DPTO. EL ALTO)	\N
128	54	2333	ESTANZUELA	\N
128	54	2334	GUAYAMBA	\N
128	54	2335	ILOGA	\N
128	54	2336	INACILLO	\N
128	54	2337	INFANZON	\N
128	54	2338	LA CALERA DEL SAUCE	\N
128	54	2339	LA ESTANCIA (BELLA VISTA-DPTO. EL ALTO)	\N
128	54	2340	LA ESTANZUELA	\N
128	54	2341	LAS JUSTAS	\N
128	54	2342	LAS TRANCAS	\N
128	54	2343	LOS PEDRAZAS	\N
128	54	2344	MINA DAL	\N
128	54	2345	NOGALITO	\N
128	54	2346	ORELLANO	\N
128	54	2347	OYOLA	\N
128	54	2348	PUESTO LOS GOMEZ	\N
128	54	2349	RIO DE AVILA	\N
128	54	2350	RIO DE LA PLATA	\N
128	54	2351	SAN VICENTE	\N
128	54	2352	SAUCE HUACHO (EL ALTO-DPTO. EL ALTO)	\N
128	54	2353	SUCUMA	\N
128	54	2354	SURUIPIANA	\N
128	54	2355	TALEGA	\N
128	54	2356	TINTIGASTA	\N
128	54	2357	VILISMAN	\N
128	54	2358	LOS CISTERNAS	\N
128	54	2359	SOLEDAD	\N
128	54	2360	SAN JERONIMO	\N
128	54	2361	LAS MINAS	\N
128	54	2362	EL HUECO	\N
128	54	2363	LA FALDA(SAN ANTONIO DE FRAY MAMERTO ESQUIU-DPTO.FRAY MAMERT	\N
128	54	2364	SAN ANTONIO	\N
128	54	2365	SAN ANTONIO DE PIEDRA BLANCA	\N
128	54	2366	LA CARRERA	\N
128	54	2367	PIEDRA BLANCA	\N
128	54	2368	SAN JOSE (PIEDRA BLANCA-DPTO. FRAY MAMERTO ESQUIU)	\N
128	54	2369	COLLAGASTA	\N
128	54	2370	POMANCILLO	\N
128	54	2371	SIERRA BRAVA	\N
128	54	2372	LAS PIRQUITAS	\N
128	54	2373	OCHO VADOS	\N
128	54	2374	CORRALITOS	\N
128	54	2375	EL VALLECITO (FRIAS-DPTO. LA PAZ)	\N
128	54	2376	ANCASTILLO	\N
128	54	2377	ANJULI	\N
128	54	2378	CANDELARIA (ANJULI-DPTO. LA PAZ)	\N
128	54	2379	EL BARRIALITO (LAS PALMITAS-DPTO. LA PAZ)	\N
128	54	2380	EL CENTENARIO	\N
128	54	2381	GARZON	\N
128	54	2382	LA RENOVACION	\N
128	54	2383	LAS IGUANAS	\N
128	54	2384	LAS PALMITAS	\N
128	54	2385	LAS TEJAS (DPTO. LA PAZ)	\N
128	54	2386	LOS CORDOBESES	\N
128	54	2387	PALO PARADO	\N
128	54	2388	POZANCONES	\N
128	54	2389	PUESTO DE LOS MORALES	\N
128	54	2390	LOS ALAMOS	\N
128	54	2391	LOS CORRALES	\N
128	54	2392	LOS NOGALES	\N
128	54	2393	EL BARREAL (RECREO-DPTO. LA PAZ)	\N
128	54	2394	EL BELLO	\N
128	54	2395	EL LINDERO (RECREO-DPTO. LA PAZ)	\N
128	54	2396	LA BREA (RECREO-DPTO. LA PAZ)	\N
128	54	2397	LA BUENA ESTRELLA	\N
128	54	2398	PUESTO DE FADEL O DE LOBO	\N
128	54	2399	RECREO	\N
128	54	2400	SAN RAFAEL	\N
128	54	2401	SANTA LUCIA (RECREO-DPTO. LA PAZ)	\N
128	54	2402	SANTO DOMINGO	\N
128	54	2403	ALTO BELLO	\N
128	54	2404	CABALLA	\N
128	54	2405	CORTADERAS (DIVISADERO-DPTO. LA PAZ)	\N
128	54	2406	EL ABRA	\N
128	54	2407	EL BAÑADO (DIVISADERO-DPTO. LA PAZ)	\N
128	54	2408	EL BARRIALITO (RAMBLONES-DPTO. LA PAZ)	\N
128	54	2409	EL CACHO	\N
128	54	2410	EL CERRITO (ESQUIU-DPTO. LA PAZ)	\N
128	54	2411	EL CHAÑARAL (RIO DE LA DORADA-DPTO. LA PAZ)	\N
128	54	2412	EL CIENEGO	\N
128	54	2413	EL GACHO	\N
128	54	2414	EL MILAGRO (ESQUIU-DPTO. LA PAZ)	\N
128	54	2415	EL MISTOLITO	\N
128	54	2416	EL MORENO	\N
128	54	2417	EL POLEAR (DIVISADERO-DPTO. LA PAZ)	\N
128	54	2418	EL PORTEZUELO (DIVISADERO-DPTO. LA PAZ)	\N
128	54	2419	EL POTRERO (RAMBLONES-DPTO. LA PAZ)	\N
128	54	2420	EL PUESTITO	\N
128	54	2421	EL PUESTO (LA QUINTA-DPTO. LA PAZ)	\N
128	54	2422	EL SALADILLO	\N
128	54	2423	EL SUNCHO (ESQUIU-DPTO. LA PAZ)	\N
128	54	2424	ESQUIU	\N
128	54	2425	GARAY	\N
128	54	2426	LA AGUADA (RIO DE LA DORADA-DPTO. LA PAZ)	\N
128	54	2427	LA ANTIGUA	\N
128	54	2428	LA CAÑADA (RIO DE LA DORADA-DPTO. LA PAZ)	\N
128	54	2429	LA COLONIA	\N
128	54	2430	LA MONTOSA	\N
128	54	2431	LA PEÑA (RAMBLONES-DPTO. LA PAZ)	\N
128	54	2432	LA QUINTA	\N
128	54	2433	LA VALENTINA	\N
128	54	2434	LA ZANJA	\N
128	54	2435	LAS CORTADERAS	\N
128	54	2436	LAS FLORES	\N
128	54	2437	LAS LOMITAS (RIO DE LA DORADA-DPTO. LA PAZ)	\N
128	54	2438	LOS CADILLOS	\N
128	54	2439	MARIA ELENA	\N
128	54	2440	MOTEGASTA	\N
128	54	2441	OJO DE AGUA	\N
128	54	2442	OLTA	\N
128	54	2443	PALO CRUZ	\N
128	54	2444	PICHINGA	\N
128	54	2445	PORTILLO CHICO	\N
128	54	2446	PUESTO SABATTE	\N
128	54	2447	RAMBLONES	\N
128	54	2448	RIO DE BAZANES	\N
128	54	2449	RIO DE DON DIEGO	\N
128	54	2450	RIO DE LA DORADA	\N
128	54	2451	SAN LORENZO (ESQUIU-DPTO. LA PAZ)	\N
128	54	2452	SAN MIGUEL (ESQUIU-DPTO. LA PAZ)	\N
128	54	2453	SAN NICOLAS	\N
128	54	2454	TACOPAMPA	\N
128	54	2455	EL QUIMILO	\N
128	54	2456	LA GUARDIA	\N
128	54	2457	PARADA KILOMETRO 62	\N
128	54	2458	ANGELINA	\N
128	54	2459	CERRILLADA	\N
128	54	2460	CHAÑARITOS (SAN ANTONIO DE LA PAZ-DPTO. LA PAZ)	\N
128	54	2461	EL RETIRO (SAN ANTONIO DE LA PAZ-DPTO. LA PAZ)	\N
128	54	2462	EL ROSARIO (SAN ANTONIO DE LA PAZ-DPTO. LA PAZ)	\N
128	54	2463	EL TALA (SAN ANTONIO DE LA PAZ-DPTO. LA PAZ)	\N
128	54	2464	JESUS MARIA	\N
128	54	2465	LA GRANJA	\N
128	54	2466	LA ISLA (SAN ANTONIO DE LA PAZ-DPTO. LA PAZ)	\N
128	54	2467	MARIA DORA	\N
128	54	2468	SAN ANTONIO (SAN ANTONIO DE LA PAZ-DPTO. LA PAZ)	\N
128	54	2469	SAN ANTONIO DE LA PAZ	\N
128	54	2470	SAN ANTONIO VIEJO	\N
128	54	2471	SAN MANUEL	\N
128	54	2472	TULA	\N
128	54	2473	BAVIANO	\N
128	54	2474	ICAÑO	\N
128	54	2475	LA BARROSA (BAVIANO-DPTO. LA PAZ)	\N
128	54	2476	LA FALDA (BAVIANO-DPTO. LA PAZ)	\N
128	54	2477	LA PARADA	\N
128	54	2478	LAS TOSCAS	\N
128	54	2479	PUESTO DE VERA	\N
128	54	2480	RIO CHICO	\N
128	54	2481	SICHA	\N
128	54	2482	CHICHAGASTA	\N
128	54	2483	ENSENADA	\N
128	54	2484	POZOS CAVADOS	\N
128	54	2485	QUIROS	\N
128	54	2486	AMADORES	\N
128	54	2487	EL GARABATO	\N
128	54	2488	EL RETIRO (AMADORES-DPTO. PACLIN)	\N
128	54	2489	LA BAJADA (DPTO. PACLIN)	\N
128	54	2490	LA BANDA (AMADORES-DPTO. PACLIN)	\N
128	54	2491	MONTE POTRERO	\N
128	54	2492	PALO LABRADO	\N
128	54	2493	RAFAEL CASTILLO	\N
128	54	2494	SALCEDO	\N
128	54	2495	YOCAN	\N
128	54	2496	EL BASTIDOR	\N
128	54	2497	EL TOTORAL (LA MERCED-DPTO. PACLIN)	\N
128	54	2498	LA ESQUINA	\N
128	54	2499	LA FALDA (LA MERCED-DPTO. PACLIN)	\N
128	54	2500	LA MERCED	\N
128	54	2501	LOS GALPONES	\N
128	54	2502	SANTA ANA	\N
128	54	2503	SANTA BARBARA	\N
128	54	2504	TALAGUADA	\N
128	54	2505	BALCOSNA	\N
128	54	2506	BALCOSNA DE AFUERA	\N
128	54	2507	EL CHAMICO	\N
128	54	2508	EL CIFLON	\N
128	54	2509	EL CONTADOR	\N
128	54	2510	EL ROSARIO (LA HIGUERA-DPTO. PACLIN)	\N
128	54	2511	LA HIGUERA	\N
128	54	2512	LAS LAJAS (DPTO. PACLIN)	\N
128	54	2513	SAN ANTONIO DE PACLIN	\N
128	54	2514	TIERRA VERDE	\N
128	54	2515	VILLA COLLANTES	\N
128	54	2516	EL DURAZNILLO	\N
128	54	2517	EL DURAZNO (LA VIÑA-DPTO. PACLIN)	\N
128	54	2518	HUACRA	\N
128	54	2519	LA VIÑA (DPTO. PACLIN)	\N
128	54	2520	LAS HUERTAS	\N
128	54	2521	LAS TRANQUITAS	\N
128	54	2522	LOS OVEJEROS	\N
128	54	2523	LOS PINTADOS	\N
128	54	2524	SAUCE MAYO	\N
128	54	2525	SUMAMPA	\N
128	54	2526	POZO DEL ALGARROBO	\N
128	54	2527	POZO DEL CAMPO	\N
128	54	2528	CALERA LA NORMA	\N
128	54	2529	EL PAJONAL	\N
128	54	2530	ESTACION POMAN	\N
128	54	2531	LAS CIENAGAS	\N
128	54	2532	LOS BALDES	\N
128	54	2533	POMAN	\N
128	54	2534	LOS CAJONES	\N
128	54	2535	MUTQUIN	\N
128	54	2536	RETIRO DE COLANA	\N
128	54	2537	ROSARIO DE COLANA	\N
128	54	2538	SIJAN	\N
128	54	2539	SAN JOSE (COLPES-DPTO. POMAN)	\N
128	54	2540	EL POTRERO (SAUJIL-DPTO. POMAN)	\N
128	54	2541	JOYANGO	\N
128	54	2542	LA YEGUA MUERTA	\N
128	54	2543	LAS BREAS	\N
128	54	2544	LAS CASITAS	\N
128	54	2545	MALCASCO	\N
128	54	2546	SAN MIGUEL (DPTO. POMAN)	\N
128	54	2547	EL PUESTO (FUERTE QUEMADO-DPTO. SANTA MARIA)	\N
128	54	2548	AGUA AMARILLA (LA HOYADA-DPTO. SANTA MARIA)	\N
128	54	2549	AGUA AMARILLA (PUNTA DE BALASTO-DPTO. SANTA MARIA)	\N
128	54	2550	AMPAJANGO	\N
128	54	2551	ANDALHUALA	\N
128	54	2552	BANDA (SANTA MARIA-DPTO. SANTA MARIA)	\N
128	54	2553	CAMPITOS	\N
128	54	2554	CASA DE PIEDRA (DPTO. SANTA MARIA)	\N
128	54	2555	EL BALDE	\N
128	54	2556	EL CAJON (DPTO. SANTA MARIA)	\N
128	54	2557	EL CALCHAQUI	\N
128	54	2558	EL CERRITO (SANTA MARIA-DPTO. SANTA MARIA)	\N
128	54	2559	EL DESMONTE (DPTO. SANTA MARIA)	\N
128	54	2560	EL MEDANITO	\N
128	54	2561	EL TESORO	\N
128	54	2562	EL TRAPICHE	\N
128	54	2563	EL ZARZO	\N
128	54	2564	ENTRE RIOS	\N
128	54	2565	ESTANCIA VIEJA (PUNTA DE BALASTO-DPTO. SANTA MARIA)	\N
128	54	2566	FAMABALASTRO	\N
128	54	2567	FAMATANCA	\N
128	54	2568	IAPES	\N
128	54	2569	LA OLLADA	\N
128	54	2570	LA PUNTILLA (CASA DE PIEDRA-DPTO. SANTA MARIA)	\N
128	54	2571	LA QUEBRADA (SANTA MARIA-DPTO. SANTA MARIA)	\N
128	54	2572	LA SOLEDAD	\N
128	54	2573	LAS MOJARRAS	\N
128	54	2574	LOS POZUELOS (PUNTA DE BALASTO-DPTO. SANTA MARIA)	\N
128	54	2575	LOS SALTOS	\N
128	54	2576	PAJANGUILLO	\N
128	54	2577	PALOMA YACO	\N
128	54	2578	PIE DEL MEDANO	\N
128	54	2579	PUNTA DE BALASTO	\N
128	54	2580	SAN ANTONIO DEL CAJON	\N
128	54	2581	SAN JOSE (DPTO. SANTA MARIA)	\N
128	54	2582	SAN JOSE NORTE	\N
128	54	2583	SANTA MARIA	\N
128	54	2584	TOROYACO	\N
128	54	2585	TOTORILLA	\N
128	54	2586	FUERTE QUEMADO	\N
128	54	2587	LA OVEJERIA	\N
128	54	2588	ANDALUCA	\N
128	54	2589	EL QUEBRACHITO	\N
128	54	2590	LA HUERTA (LAS CAÑAS-DPTO. SANTA ROSA)	\N
128	54	2591	LAS LOMITAS (LAS CAÑAS-DPTO. SANTA ROSA)	\N
128	54	2592	LAS PAMPAS (LAS CAÑAS-DPTO. SANTA ROSA)	\N
128	54	2593	CORTADERAS (DPTO. SANTA ROSA)	\N
128	54	2594	PUESTO DEL MEDIO	\N
128	54	2595	ALIJILAN	\N
128	54	2596	ALMIGAUCHO	\N
128	54	2597	ALTA GRACIA	\N
128	54	2598	AMANCALA	\N
128	54	2599	AMPOLLA	\N
128	54	2600	BAÑADO DE OVANTA	\N
128	54	2601	DOS POCITOS	\N
128	54	2602	DOS TRONCOS	\N
128	54	2603	EL DESMONTE (LOS ALTOS-DPTO. SANTA ROSA)	\N
128	54	2604	EL POTRERO (BAÑADO DE OVANTA-DPTO. SANTA ROSA)	\N
128	54	2605	EL TALA (PUERTA GRANDE-DPTO. SANTA ROSA)	\N
128	54	2606	LA AGUADA (ALIJILAN-DPTO. SANTA ROSA)	\N
128	54	2607	LA BAJADA (PUERTA GRANDE-DPTO. SANTA ROSA)	\N
128	54	2608	LA CALERA (LAS TUNAS-DPTO. SANTA ROSA)	\N
128	54	2609	LAS TUNAS (DPTO. SANTA ROSA)	\N
128	54	2610	LOS ALTOS	\N
128	54	2611	LOS BASTIDORES	\N
128	54	2612	LOS ESTANTES	\N
128	54	2613	LOS MOLLES (PUERTA GRANDE-DPTO. SANTA ROSA)	\N
128	54	2614	LOS ORTICES (PUERTA GRANDE-DPTO. SANTA ROSA)	\N
128	54	2615	LOS POCITOS (BAÑADO DE OVANTA-DPTO. SANTA ROSA)	\N
128	54	2616	LOS TRONCOS	\N
128	54	2617	LOS ZANJONES	\N
128	54	2618	MANANTIALES	\N
128	54	2619	MISTOL ANCHO	\N
128	54	2620	MONTE REDONDO	\N
128	54	2621	PAMPA CHACRA	\N
128	54	2622	PUERTA GRANDE	\N
128	54	2623	PUESTO DE LA VIUDA	\N
128	54	2624	QUEBRACHOS BLANCOS	\N
128	54	2625	QUIMILPA	\N
128	54	2626	SALAUCA	\N
128	54	2627	SAN LUIS	\N
128	54	2628	YAQUICHO	\N
128	54	2629	LA MARAVILLA	\N
128	54	2630	LORO HUASI	\N
128	54	2631	MEDANITO	\N
128	54	2632	CHILCA	\N
128	54	2633	EL TAMBILLO	\N
128	54	2634	TALAR	\N
128	54	2635	RINCON	\N
128	54	2636	SAUJIL	\N
128	54	2637	CERRO NEGRO	\N
128	54	2638	CORDOBITA	\N
128	54	2639	EL PUEBLITO	\N
128	54	2640	LA ISLA (RIO COLORADO-DPTO. TINOGASTA)	\N
128	54	2641	LA PUNTILLA (DPTO. TINOGASTA)	\N
128	54	2642	LAS CHACRAS (CERRO NEGRO-DPTO. TINOGASTA)	\N
128	54	2643	LOS BALVERDIS	\N
128	54	2644	LOS GONZALES	\N
128	54	2645	LOS QUINTEROS	\N
128	54	2646	LOS RINCONES	\N
128	54	2647	RIO COLORADO	\N
128	54	2648	SALADO	\N
128	54	2649	SANTA CRUZ (CORDOBITA-DPTO. TINOGASTA)	\N
128	54	2650	VILLA SELEME	\N
128	54	2651	BANDA DE LUCERO	\N
128	54	2652	CARRIZAL (COPACABANA-DPTO. TINOGASTA)	\N
128	54	2653	CIENAGUITA	\N
128	54	2654	COPACABANA	\N
128	54	2655	EL ALTO (COPACABANA-DPTO. TINOGASTA)	\N
128	54	2656	LA CANDELARIA	\N
128	54	2657	LA CAPELLANIA (COPACABANA-DPTO. TINOGASTA)	\N
128	54	2658	LAS HIGUERITAS	\N
128	54	2659	LOS GUAYTIMAS	\N
128	54	2660	LOS PALACIOS	\N
128	54	2661	LOS ROBLEDOS	\N
128	54	2662	LOS VALDEZ	\N
128	54	2663	TINOGASTA	\N
128	54	2664	ANILLACO	\N
128	54	2665	CORRAL DE PIEDRA (MEDANITOS-DPTO. TINOGASTA)	\N
128	54	2666	COSTA DE REYES	\N
128	54	2667	EL CACHIYUYO	\N
128	54	2668	EL PUESTO (DPTO. TINOGASTA)	\N
128	54	2669	LA CIENAGA DE LOS ZONDONES	\N
128	54	2670	LA FALDA (EL PUESTO-DPTO. TINOGASTA)	\N
128	54	2671	LA MAJADA	\N
128	54	2672	LA MESADA (PALO BLANCO-DPTO. TINOGASTA)	\N
128	54	2673	LA PALCA	\N
128	54	2674	LA PUNTILLA DE SAN JOSE	\N
128	54	2675	LA RAMADITA	\N
128	54	2676	LAS PAMPAS (ANTINACO-DPTO. TINOGASTA)	\N
128	54	2677	LAS PAPAS	\N
128	54	2678	LOS POTRERILLOS	\N
128	54	2679	MEDANITOS	\N
128	54	2680	MESADA DE LOS ZARATE	\N
128	54	2681	MESADA GRANDE	\N
128	54	2682	PALO BLANCO	\N
128	54	2683	PAMPA BLANCA	\N
128	54	2684	PASO SAN FRANCISCO	\N
128	54	2685	PLAZA DE SAN PEDRO	\N
128	54	2686	RIO GRANDE	\N
128	54	2687	SAN JOSE DE TINOGASTA	\N
128	54	2688	SANTO TOMAS	\N
128	54	2689	SAUJIL DE TINOGASTA	\N
128	54	2690	TATON	\N
128	54	2691	SANTA ROSA (DPTO. TINOGASTA)	\N
128	54	2692	VILLA SAN ROQUE	\N
128	54	2693	EL BARRIALITO (FIAMBALA-DPTO. TINOGASTA)	\N
128	54	2694	EL RETIRO (FIAMBALA-DPTO. TINOGASTA)	\N
128	54	2695	FIAMBALA	\N
128	54	2696	LA AGUADITA (FIAMBALA-DPTO. TINOGASTA)	\N
128	54	2697	LAS RETAMAS	\N
128	54	2698	LOS MORTEROS (FIAMBALA-DPTO. TINOGASTA)	\N
128	54	2699	LAS TEJAS	\N
128	54	2700	ANTAPOCA	\N
128	54	2701	HUAYCAMA	\N
128	54	2702	POZO DEL MISTOL	\N
128	54	2703	ROSARIO DEL SUMALAO	\N
128	54	2704	SANTA CRUZ (HUAYCAMA)	\N
128	54	2705	SUMALAO	\N
128	54	2706	EL BAÑADO (VALLE VIEJO)	\N
128	54	2707	LAS ESQUINAS	\N
128	54	2708	POLCOS	\N
128	54	2709	SAN ISIDRO	\N
128	54	2710	SANTA ROSA	\N
128	54	2711	TRES PUENTES	\N
128	54	2712	VALLE VIEJO	\N
128	54	2713	VILLA DOLORES	\N
128	54	2714	VILLA MACEDO	\N
128	54	2715	AGUA COLORADA 	\N
128	54	2716	LA ESTRELLA	\N
129	54	2717	LOS CERROS	\N
129	54	2718	BAJO DEL CARMEN	\N
129	54	2719	DOS ARROYOS	\N
129	54	2720	FALDA DE LOS REARTES	\N
129	54	2721	LOS MOLINOS	\N
129	54	2722	PUESTO MUELITA	\N
129	54	2723	SIERRAS MORENAS	\N
129	54	2724	SOLAR LOS MOLINOS	\N
129	54	2725	TECERA	\N
129	54	2726	VILLA CIUDAD PARQUE LOS REARTES	\N
129	54	2727	CALMAYO	\N
129	54	2728	CERRO BLANCO	\N
129	54	2729	POTRERO DE LUJAN	\N
129	54	2730	SAN AGUSTIN	\N
129	54	2731	SOCONCHO	\N
129	54	2732	ATOS PAMPA	\N
129	54	2733	LA CUMBRECITA	\N
129	54	2734	LOS REARTES	\N
129	54	2735	VILLA ALPINA	\N
129	54	2736	VILLA BERNA	\N
129	54	2737	VILLA CALAMUCHITA	\N
129	54	2738	VILLA GRAL. BELGRANO	\N
129	54	2739	ARROYO SECO	\N
129	54	2740	ATUMI PAMPA	\N
129	54	2741	CAÑADA DEL DURAZNO	\N
129	54	2742	CARAHUASI	\N
129	54	2743	COLONIA ALEMANA	\N
129	54	2744	COLONIA LA CALLE	\N
129	54	2745	EL PARADOR DE LA MONTAÑA	\N
129	54	2746	EL PORTEZUELO	\N
129	54	2747	EL SAUCE (SANTA ROSA DE CALAMUCHITA-DPTO. CALAMUCHITA)	\N
129	54	2748	LA CHOZA	\N
129	54	2749	SANTA ROSA DE CALAMUCHITA	\N
129	54	2750	SARLACO	\N
129	54	2751	EL CARMEN (YACANTO-DEPTO. CALAMUCHITA)	\N
129	54	2752	RINCON DE LUNA	\N
129	54	2753	RIO DEL DURAZNO	\N
129	54	2754	SANTA MONICA	\N
129	54	2755	VISTA ALEGRE	\N
129	54	2756	YACANTO-CALAMUCHITA	\N
129	54	2757	AMBOY	\N
129	54	2758	CAÑADA DE LAS CHACRAS	\N
129	54	2759	LAS HIGUERITAS	\N
129	54	2760	LAS SIERRITAS	\N
129	54	2761	MAR AZUL	\N
129	54	2762	RIO GRANDE (AMBOY)	\N
129	54	2763	SAN IGNACIO	\N
129	54	2764	SAN ROQUE (AMBOY)	\N
129	54	2765	VILLA AMANCAY	\N
129	54	2766	VILLA EL CORCOVADO	\N
129	54	2767	VILLA EL TORREON	\N
129	54	2768	VILLA LAGO AZUL	\N
129	54	2769	VILLA SAN JAVIER	\N
129	54	2770	ALTO DEL TALA	\N
129	54	2771	LOMA REDONDA	\N
129	54	2772	CAÑADA DEL SAUCE	\N
129	54	2773	ARROYO SANTANA	\N
129	54	2774	ARROYO TOLEDO	\N
129	54	2775	CAÑADA DE ALVAREZ	\N
129	54	2776	EL MANANTIAL (CAÑADA DE ALVAREZ-DPTO. CALAMUCHITA)	\N
129	54	2777	LA CALERA CALAMUCHITA	\N
129	54	2778	LAS CALERAS	\N
129	54	2779	PASO SANDIALITO	\N
129	54	2780	SIERRA BLANCA	\N
129	54	2781	VILLA LA COBA	\N
129	54	2782	CAMPO SAN ANTONIO	\N
129	54	2783	CERRO SAN LORENZO	\N
129	54	2784	LOS CERROS NEGROS	\N
129	54	2785	LOS COCOS (RIO DE LOS SAUCES-DPTO. CALAMUCHITA)	\N
129	54	2786	PERMANENTES (CANO-DPTO. CALAMUCHITA)	\N
129	54	2787	RIO DE LOS SAUCES	\N
129	54	2788	RODEO DE LAS YEGUAS	\N
129	54	2789	RODEO DE LOS CABALLOS	\N
129	54	2790	LAS PEÑAS NORTE	\N
129	54	2791	LOS CONDORES	\N
129	54	2792	MODESTO ACUÑA	\N
129	54	2793	LAS BAJADAS	\N
129	54	2794	MONSALVO	\N
129	54	2795	EL QUEBRACHO (ALMAFUERTE-DPTO. CALAMUCHITA)	\N
129	54	2796	LA CASCADA	\N
129	54	2797	EMBALSE	\N
129	54	2798	COLONIA VACACIONES DE EMPLEADOS	\N
129	54	2799	SEGUNDA USINA	\N
129	54	2800	UNIDAD TURISTICA EMBALSE	\N
129	54	2801	VILLA AGUADA DE REYES	\N
129	54	2802	VILLA SANTA ISABEL	\N
129	54	2803	VILLA SIERRAS DEL LAGO	\N
129	54	2804	ARROYO SAN ANTONIO	\N
129	54	2805	CAÑADA DEL TALA (LA CRUZ-DPTO. CALAMUCHITA)	\N
129	54	2806	CERROS ASPEROS	\N
129	54	2807	LA CRUZ	\N
129	54	2808	LUTTI	\N
129	54	2809	TALA CRUZ	\N
129	54	2810	TIGRE MUERTO	\N
129	54	2811	USINA NUCLEAR EMBALSE	\N
129	54	2812	VILLA DEL TALA	\N
129	54	2813	VILLA QUILLINZO	\N
129	54	2814	VILLA DEL DIQUE	\N
129	54	2815	EL TORREON	\N
129	54	2816	VALLE DORADO	\N
129	54	2817	VILLA DEL PARQUE (VILLA RUMIPAL-DPTO. CALAMUCHITA)	\N
129	54	2818	VILLA NATURALEZA	\N
129	54	2819	VILLA RUMIPAL	\N
129	54	2820	FABRICA MILITAR	\N
129	54	2821	CORDOBA	\N
129	54	2822	SAN MARTIN	\N
129	54	2823	SAN VICENTE	\N
129	54	2824	CERRO DE LAS ROSAS	\N
129	54	2825	BAJO CHICO (BAJO GRANDE-DPTO. CAPITAL)	\N
129	54	2826	EL QUEBRACHAL	\N
129	54	2827	RIO CHICO (EL QUEBRACHAL-DPTO. CAPITAL)	\N
129	54	2828	VILLA CORAZON DE MARIA	\N
129	54	2829	VILLA ESQUIU	\N
129	54	2830	BARRIO AMEGHINO	\N
129	54	2831	BARRIO FLORES (GUARNICION AEREA CORDOBA-DPTO. CAPITAL)	\N
129	54	2832	BARRIO TENIENTE BENJAMIN MATIENZO	\N
129	54	2833	BARRIO VILLA UNION	\N
129	54	2834	CADETE CHAVEZ (APEADERO FCGM)	\N
129	54	2835	EMPALME BARRIO FLORES (EMBARCADERO FCGM)	\N
129	54	2836	COLONIA HOGAR VELEZ SARSFIELD	\N
129	54	2837	CORONEL OLMEDO	\N
129	54	2838	LA CARBONADA	\N
129	54	2839	LA PORFIA	\N
129	54	2840	LAS SESENTA CUADRAS	\N
129	54	2841	LOS CARDOS	\N
129	54	2842	BARRIO SAN LORENZO SUR	\N
129	54	2843	CASEROS ESTE	\N
129	54	2844	EL OCHENTA	\N
129	54	2845	FERREYRA	\N
129	54	2846	HARAS SANTA MARTHA	\N
129	54	2847	KM 25 LA CARBONADA	\N
129	54	2848	KM 679 (FCGM)	\N
129	54	2849	KM 692 (FCGM)	\N
129	54	2850	LA ARABIA	\N
129	54	2851	VILLA MIREA	\N
129	54	2852	VILLA POSSE	\N
129	54	2853	EL CARMEN (GUIÑAZU-DPTO. CAPITAL)	\N
129	54	2854	EL CHINGOLO	\N
129	54	2855	GUIÑAZU	\N
129	54	2856	KM 730 (APEADERO FCGB)	\N
129	54	2857	MARIA LASTENIA	\N
129	54	2858	RECREO VICTORIA	\N
129	54	2859	TRISTAN NARVAJA (APEADERO FCGB)	\N
129	54	2860	COLONIA TIROLESA	\N
129	54	2861	EL GATEADO (APEADERO FCGB)	\N
129	54	2862	LA PUERTA-COLON	\N
129	54	2863	LAS CAÑAS (COLONIA TIROLESA-DPTO. COLON)	\N
129	54	2864	LAS CHACRAS (RUTA 111 KM. 14-DPTO. COLON)	\N
129	54	2865	RUTA 111 KILOMETRO 14	\N
129	54	2866	LA REDENCION	\N
129	54	2867	LA REDUCCION (VILLA ALLENDE)	\N
129	54	2868	VILLA ALLENDE	\N
129	54	2869	AGUA DE ORO (DPTO. COLON)	\N
129	54	2870	ANI-MI	\N
129	54	2871	CANTERAS EL MANZANO	\N
129	54	2872	CANTERAS EL SAUCE	\N
129	54	2873	EL ALGODONAL (VILLA CERRO AZUL-DPTO. COLON)	\N
129	54	2874	EL MANZANO	\N
129	54	2875	EL PUEBLITO (DPTO. COLON)	\N
129	54	2876	EL TALAR	\N
129	54	2877	KM 25	\N
129	54	2878	LA QUEBRADA (DPTO. COLON)	\N
129	54	2879	LAS VERTIENTES DE LA GRANJA	\N
129	54	2880	LOS CIGARRALES	\N
129	54	2881	MENDIOLAZA	\N
129	54	2882	SAN CRISTOBAL	\N
129	54	2883	VALLE DEL SOL	\N
129	54	2884	VILLA CERRO AZUL	\N
129	54	2885	VILLA LAS MERCEDES	\N
129	54	2886	CABANA	\N
129	54	2887	EL QUEBRACHITO	\N
129	54	2888	LAS CUSENADAS	\N
129	54	2889	LAS ENCADENADAS	\N
129	54	2890	UNQUILLO	\N
129	54	2891	VILLA DIAZ	\N
129	54	2892	VILLA LEONOR	\N
129	54	2893	VILLA TORTOSA	\N
129	54	2894	ÑU PORA	\N
129	54	2895	BARRIO LOZA	\N
129	54	2896	CANDONGA	\N
129	54	2897	LA ESTANCITA	\N
129	54	2898	PAJAS BLANCAS	\N
129	54	2899	RIO CEBALLOS	\N
129	54	2900	VILLA LOS ALTOS	\N
129	54	2901	VILLA SAN MIGUEL	\N
129	54	2902	SALSIPUEDES	\N
129	54	2903	LA GRANJA	\N
129	54	2904	VALLE VERDE	\N
129	54	2905	ASCOCHINGA	\N
129	54	2906	BLAS DE ROSALES	\N
129	54	2907	KM 711 (EMBARCADERO FCGB)	\N
129	54	2908	LOS VAZQUEZ	\N
129	54	2909	MALVINAS ARGENTINAS	\N
129	54	2910	MEDIA LUNA	\N
129	54	2911	MI GRANJA	\N
129	54	2912	RUTA 19 KILOMETRO 317	\N
129	54	2913	TEJEDA	\N
129	54	2914	CAÑADA DE SAN ANTONIO	\N
129	54	2915	COLONIA HOLANDESA	\N
129	54	2916	DOLORES (NUÑEZ DEL PRADO-DPTO. COLON)	\N
129	54	2917	EL ESPINILLO (TINOCO-DPTO. COLON)	\N
129	54	2918	ESPINILLO (NUÑEZ DEL PRADO-DPTO. COLON)	\N
129	54	2919	ESTACION COLONIA TIROLESA	\N
129	54	2920	ESTANCIA EL CARMEN	\N
129	54	2921	ESTANCIA LAS CAÑAS	\N
129	54	2922	HIGUERIAS	\N
129	54	2923	LA TUNA (TINOCO-DPTO. COLON)	\N
129	54	2924	NUÑEZ DEL PRADO	\N
129	54	2925	PUESTO DE LA OVEJA	\N
129	54	2926	SANTA ELENA (NUÑEZ DEL PRADO-DPTO. COLON)	\N
129	54	2927	TINOCO	\N
129	54	2928	ALTO DE CASTILLO	\N
129	54	2929	AUGUSTO VANDERSANDE	\N
129	54	2930	ESTACION GENERAL PAZ	\N
129	54	2931	JUAREZ CELMAN	\N
129	54	2932	LOS POCITOS (ESTACION GRAL. PAZ-DPTO. COLON)	\N
129	54	2933	PASO CASTELLANOS	\N
129	54	2934	LOS BOULEVARES	\N
129	54	2935	CAMPAMENTO MINETTI	\N
129	54	2936	CAMPO BOURDICHON	\N
129	54	2937	DUMESNIL	\N
129	54	2938	EL TOMILLO	\N
129	54	2939	EL ZAINO (APEADERO FCGB)	\N
129	54	2940	SALDAN	\N
129	54	2941	CALERA CENTRAL	\N
129	54	2942	CANTERAS LA CALERA (EMBARCADERO FCGM)	\N
129	54	2943	CASA BAMBA	\N
129	54	2944	EL DIQUECITO (APEADERO FCGB)	\N
129	54	2945	EL PASTOR	\N
129	54	2946	EL PAYADOR (APEADERO FCGB)	\N
129	54	2947	GENERAL ORTIZ DE OCAMPO (APEADERO FCGB)	\N
129	54	2948	LA CALERA (DPTO. COLON)	\N
129	54	2949	VILLA DEL LAGO	\N
129	54	2950	ABBURRA	\N
129	54	2951	BELEN	\N
129	54	2952	COLUMBO	\N
129	54	2953	EL MOLINO (JESUS MARIA-DPTO. COLON)	\N
129	54	2954	EL REYMUNDO	\N
129	54	2955	ESTACION CAROYA	\N
129	54	2956	JESUS MARIA	\N
129	54	2957	KM 745 (APEADERO FCGB)	\N
129	54	2958	LA COTITA	\N
129	54	2959	LA VIRGINIA (JESUS MARIA-DPTO. COLON)	\N
129	54	2960	LAS ASTILLAS	\N
129	54	2961	LOS CALLEJONES (JESUS MARIA-DPTO. COLON)	\N
129	54	2962	LOS CHAÑARES (JESUS MARIA-DPTO. COLON)	\N
129	54	2963	LOS DOS RIOS	\N
129	54	2964	LOS DURAZNOS	\N
129	54	2965	NINTES	\N
129	54	2966	OJO DE AGUA (JESUS MARIA-DPTO. COLON)	\N
129	54	2967	SAN ISIDRO (JESUS MARIA-DPTO. COLON)	\N
129	54	2968	SAN PABLO (JESUS MARIA-DPTO. COLON)	\N
129	54	2969	SANTO TOMAS	\N
129	54	2970	VILLA MARIA (DPTO. COLON)	\N
129	54	2971	AGUA SACHA	\N
129	54	2972	COLONIA VICENTE AGUERO	\N
129	54	2973	LOS QUEBRACHITOS	\N
129	54	2974	MULA MUERTA	\N
129	54	2975	RIO CHICO (SANTA TERESA-DPTO. COLON)	\N
129	54	2976	SANTA TERESA	\N
129	54	2977	COLONIA CAROYA	\N
129	54	2978	TRONCO POZO	\N
129	54	2979	CASA BLANCA	\N
129	54	2980	PIQUILLIN	\N
129	54	2981	QUEBRACHOS	\N
129	54	2982	EL CALLEJON	\N
129	54	2983	EL VALLECITO (DPTO. CRUZ DEL EJE)	\N
129	54	2984	LA PRIMAVERA (DPTO. CRUZ DEL EJE)	\N
129	54	2985	LOS QUEBRACHOS	\N
129	54	2986	EL SIMBOL	\N
129	54	2987	BAJO LINDO	\N
129	54	2988	EL QUICHO	\N
129	54	2989	IGLESIA VIEJA	\N
129	54	2990	LA BATEA	\N
129	54	2991	LAS ABRAS	\N
129	54	2992	LAS ALERAS	\N
129	54	2993	LOS ESLABONES	\N
129	54	2994	LOS VALDES	\N
129	54	2995	QUILMES	\N
129	54	2996	SERREZUELA	\N
129	54	2997	CAÑADA HONDA (CRUZ DEL EJE-DPTO. CRUZ DEL EJE)	\N
129	54	2998	CRUZ DEL EJE	\N
129	54	2999	HUASCHA	\N
129	54	3000	KM 505 (APEADERO FCGB)	\N
129	54	3001	LA CARBONERA	\N
129	54	3002	LA TOMA (CRUZ DEL EJE-DPTO. CRUZ DEL EJE)	\N
129	54	3003	NEGRO HUASI	\N
129	54	3004	NUEVA ESPERANZA	\N
129	54	3005	OLIVARES SAN NICOLAS	\N
129	54	3006	PALO CORTADO	\N
129	54	3007	RIO DE LA POBLACION	\N
129	54	3008	TABAQUILLO	\N
129	54	3009	ALTO DE LOS QUEBRACHOS	\N
129	54	3010	BARRIAL	\N
129	54	3011	CANTERAS DE QUILPO	\N
129	54	3012	EL BRETE	\N
129	54	3013	EL SIMBOLAR	\N
129	54	3014	ESQUINA DEL ALAMBRE	\N
129	54	3015	GUANACO MUERTO	\N
129	54	3016	LA ABRA	\N
129	54	3017	LA FLORIDA (MEDIA NARANJA-DPTO. CRUZ DEL EJE)	\N
129	54	3018	LA LILIA	\N
129	54	3019	LA PUERTA (MEDIA NARANJA-DPTO. CRUZ DEL EJE)	\N
129	54	3020	LA VIRGINIA (MEDIA NARANJA-DPTO. CRUZ DEL EJE)	\N
129	54	3021	LAS PIEDRITAS	\N
129	54	3022	LAS TAPIAS (MEDIA NARANJA-DPTO. CRUZ DEL EJE)	\N
129	54	3023	LOS CHAÑARITOS	\N
129	54	3024	LOS HORMIGUEROS	\N
129	54	3025	LOS MISTOLES (MEDIA NARANJA-DPTO. CRUZ DEL EJE)	\N
129	54	3026	MEDIA NARANJA	\N
129	54	3027	PALO LABRADO	\N
129	54	3028	PALO PARADO	\N
129	54	3029	POZO DEL SIMBOL (MEDIA NARANJA-DPTO. CRUZ DEL EJE)	\N
129	54	3030	PUESTO DEL GALLO	\N
129	54	3031	SAN ANTONIO (GUANACO MUERTO-DPTO. CRUZ DEL EJE)	\N
129	54	3032	SAN ISIDRO (MEDIA NARANJA-DPTO. CRUZ DEL EJE)	\N
129	54	3033	SAN JOSE (MEDIA NARANJA-DPTO. CRUZ DEL EJE)	\N
129	54	3034	SIMBOLAR (MEDIA NARANJA-DPTO. CRUZ DEL EJE)	\N
129	54	3035	VILLA LOS LEONES	\N
129	54	3036	EL FRANCES	\N
129	54	3037	EL RINCON (DPTO. CRUZ DEL EJE)	\N
129	54	3038	LA FRONDA	\N
129	54	3039	LA GRAMILLA	\N
129	54	3040	LOS SAUCES (DPTO. CRUZ DEL EJE)	\N
129	54	3041	SAN MARCOS SIERRAS	\N
129	54	3042	BARRIALITOS	\N
129	54	3043	BELLA VISTA (VILLA DE SOTO-DPTO. CRUZ DEL EJE)	\N
129	54	3044	CACHIYULIO	\N
129	54	3045	CHACRAS	\N
129	54	3046	CHACRAS DEL POTRERO	\N
129	54	3047	DESAGUADERO	\N
129	54	3048	EL CARACOL	\N
129	54	3049	EL PUESTO (VILLA DE SOTO-DPTO. CRUZ DEL EJE)	\N
129	54	3050	ESTACION SOTO	\N
129	54	3051	KM 541 (APEADERO FCGB)	\N
129	54	3052	LA LAGUNA (VILLA DE SOTO-DPTO. CRUZ DEL EJE)	\N
129	54	3053	LA PUERTA (VILLA DE SOTO-DPTO. CRUZ DEL EJE)	\N
129	54	3054	LAS CAÑADAS (VILLA DE SOTO-DPTO. CRUZ DEL EJE)	\N
129	54	3055	LAS LOMAS	\N
129	54	3056	LAS TINAJERAS	\N
129	54	3057	LOS PATALLES	\N
129	54	3058	MANDALA	\N
129	54	3059	PALO QUEMADO	\N
129	54	3060	PALOMA POZO	\N
129	54	3061	PASO DE MONTOYA	\N
129	54	3062	PASO VIEJO	\N
129	54	3063	PICHANAS	\N
129	54	3064	PIEDRAS AMONTONADAS	\N
129	54	3065	PIEDRAS ANCHAS (TUCLAME-DPTO. CRUZ DEL EJE)	\N
129	54	3066	RAMBLON	\N
129	54	3067	RIO SECO (PICHANAS-DPTO. CRUZ DEL EJE)	\N
129	54	3068	SANTA ANA (PASO VIEJO-DPTO. CRUZ DEL EJE)	\N
129	54	3069	SENDAS GRANDES	\N
129	54	3070	TALA DEL RIO SECO	\N
129	54	3071	TUCLAME	\N
129	54	3072	VILLA DE SOTO	\N
129	54	3073	AGUA DE CRESPIN	\N
129	54	3074	BAÑADO DE SOTO	\N
129	54	3075	CANTERAS IGUAZU	\N
129	54	3076	CARRIZAL (LA HIGUERA-DPTO. CRUZ DEL EJE)	\N
129	54	3077	CASAS VIEJAS (LA HIGUERA-DPTO. CRUZ DEL EJE)	\N
129	54	3078	EL BARRIAL	\N
129	54	3079	EL GUAICO	\N
129	54	3080	GUAICO	\N
129	54	3081	LA AGUADA (LA HIGUERA-DPTO. CRUZ DEL EJE)	\N
129	54	3082	LA HIGUERA (DPTO. CRUZ DEL EJE)	\N
129	54	3083	LA MESILLA	\N
129	54	3084	LAS PLAYAS (LA HIGUERA-DPTO. CRUZ DEL EJE)	\N
129	54	3085	LAS TOTORITAS	\N
129	54	3086	MESA DE MARIANO	\N
129	54	3382	CORTADERAS	\N
129	54	3087	PIEDRA BLANCA (LA HIGUERA-DPTO. CRUZ DEL EJE)	\N
129	54	3088	REPRESA DE MORALES	\N
129	54	3089	TRES ARBOLES	\N
129	54	3090	CAPILLA LA CANDELARIA	\N
129	54	3091	CHARACATO	\N
129	54	3092	MAJADA DE SANTIAGO	\N
129	54	3093	ORO GRUESO	\N
129	54	3094	EL ARBOL	\N
129	54	3095	EL NOY	\N
129	54	3096	JOVITA	\N
129	54	3097	LOS GAUCHOS DE GUEMES	\N
129	54	3098	SANTA MAGDALENA	\N
129	54	3099	BURMEISTER (APEADERO FCGSM)	\N
129	54	3100	HIPOLITO BOUCHARD	\N
129	54	3101	ONAGOITY	\N
129	54	3102	COLONIA BOERO	\N
129	54	3103	COLONIA DOROTEA	\N
129	54	3104	HUINCA RENANCO	\N
129	54	3105	MELIDEO (EMBARCADERO FCDFS)	\N
129	54	3106	NAZCA (APEADERO FCGSM)	\N
129	54	3107	WATT	\N
129	54	3108	ANTONIO CATALANO	\N
129	54	3109	CAMPO SAN JUAN	\N
129	54	3110	COSTA DEL RIO QUINTO	\N
129	54	3111	DE LA SERNA	\N
129	54	3112	DEL CAMPILLO	\N
129	54	3113	ITALO	\N
129	54	3114	LA LUZ	\N
129	54	3115	LA PERLITA	\N
129	54	3116	MATTALDI	\N
129	54	3117	NICOLAS BRUZONE	\N
129	54	3118	PINCEN	\N
129	54	3119	RANQUELES	\N
129	54	3120	TOMAS ECHENIQUE	\N
129	54	3121	EL PAMPERO (EMBARCADERO FCGSM)	\N
129	54	3122	LECUEDER	\N
129	54	3123	MODESTINO PIZARRO	\N
129	54	3124	VILLA SARMIENTO	\N
129	54	3125	VILLA VALERIA	\N
129	54	3126	CAÑADA VERDE	\N
129	54	3127	LA NACIONAL	\N
129	54	3128	LARSEN (APEADERO FCGSM)	\N
129	54	3129	LOS ALFALFARES (APEADERO FCGSM)	\N
129	54	3130	VILLA HUIDOBRO	\N
129	54	3131	VILLA MODERNA	\N
129	54	3132	LA PENCA (DPTO. GRAL. ROCA)	\N
129	54	3133	CHAZON	\N
129	54	3134	SANTA VICTORIA	\N
129	54	3135	ETRURIA	\N
129	54	3136	PAUNERO	\N
129	54	3137	LA HERRADURA	\N
129	54	3138	LAS CUATRO ESQUINAS	\N
129	54	3139	LAS PICHANAS	\N
129	54	3140	MONTE DE LOS LAZOS	\N
129	54	3141	RAMON J. CARCANO	\N
129	54	3142	VILLA AURORA	\N
129	54	3143	VILLA EMILIA	\N
129	54	3144	VILLA MARIA	\N
129	54	3145	ARROYO DEL PINO	\N
129	54	3146	AUSONIA	\N
129	54	3147	CAYUQUEO	\N
129	54	3148	KM 267 (APEADERO FCGM)	\N
129	54	3149	LA LAGUNA	\N
129	54	3150	SANABRIA	\N
129	54	3151	SANTA RITA	\N
129	54	3152	VILLA DEL PARQUE (VILLA NUEVA-DPTO. GRAL. SAN MARTIN)	\N
129	54	3153	VILLA NUEVA	\N
129	54	3154	COLONIA SILVIO PELLICO	\N
129	54	3155	ARROYO ALGODON	\N
129	54	3156	LAS MOJARRAS	\N
129	54	3157	SANTA ROSA (ARROYO ALGODON-DPTO. GRAL. SAN MARTIN)	\N
129	54	3158	LA PLAYOSA	\N
129	54	3159	ARROYO CABRAL	\N
129	54	3160	COLONIA YUCAT SUD	\N
129	54	3161	LUCA	\N
129	54	3162	CARLOMAGNO (EMBARCADERO FCGM)	\N
129	54	3163	FERREYRA (PASCO-DPTO. SAN MARTIN)	\N
129	54	3164	LA PALESTINA	\N
129	54	3165	LA REINA	\N
129	54	3166	LOS REYUNOS	\N
129	54	3167	MARIA	\N
129	54	3168	PASCO	\N
129	54	3169	SARMICA	\N
129	54	3170	TICINO	\N
129	54	3171	CAPILLA SAN ANTONIO DE YUCAT	\N
129	54	3172	SAN ANTONIO DE YUCAT	\N
129	54	3173	TIO PUJIO	\N
129	54	3174	LAS MANZANAS (COSQUIN-DPTO. PUNILLA)	\N
129	54	3175	CORIMAYO	\N
129	54	3176	ONGAMIRA	\N
129	54	3177	QUEBRADA DE NONA	\N
129	54	3178	CAÑADA DEL SIMBOL	\N
129	54	3179	CANTERAS KILOMETRO 428 (APEADERO FCGB)	\N
129	54	3180	CERRO DE LA CRUZ	\N
129	54	3181	CORITO	\N
129	54	3182	DEAN FUNES	\N
129	54	3183	EL PORTILLO	\N
129	54	3184	INGENIERO BERTINI	\N
129	54	3185	KM 430 (APEADERO FCGB)	\N
129	54	3186	KM 832 (APEADERO FCGB)	\N
129	54	3187	LA ISABELA	\N
129	54	3188	LA MESADA (DEAN FUNES-DPTO. ISCHILIN)	\N
129	54	3189	LAS PENCAS	\N
129	54	3190	LOS PUESTITOS	\N
129	54	3191	PUESTO DE LOS RODRIGUEZ	\N
129	54	3192	PUESTO DEL CERRO	\N
129	54	3193	PUESTO DEL MEDIO	\N
129	54	3194	SAJON	\N
129	54	3195	SAN PEDRO DE TOYOS	\N
129	54	3196	SANTA RITA (DEAN FUNES-DPTO. ISCHILIN)	\N
129	54	3197	SAUCE CHIQUITO	\N
129	54	3198	SAUCE PUNCO	\N
129	54	3199	TORO MUERTO- (DEAN FUNES-DPTO. ISCHILIN)	\N
129	54	3200	YERBA BUENA	\N
129	54	3201	COPACABANA	\N
129	54	3202	CRUCECITAS	\N
129	54	3203	EL TALA (ISCHILIN-DPTO. ISCHILIN)	\N
129	54	3204	ISCHILIN	\N
129	54	3205	LA BATALLA	\N
129	54	3206	LA COLONIA	\N
129	54	3207	LA HIGUERITA (ISCHILIN-DPTO. ISCHILIN)	\N
129	54	3208	LAS CAÑAS (ISCHILIN-DPTO. ISCHILIN)	\N
129	54	3209	LAS CRUCESITAS	\N
129	54	3210	LAS PALMAS (ISCHILIN-DPTO. ISCHILIN)	\N
129	54	3211	LAS PALOMITAS	\N
129	54	3212	LOBERA	\N
129	54	3213	LOS BRINZES	\N
129	54	3214	LOS CEJAS	\N
129	54	3215	LOS COQUITOS	\N
129	54	3216	LOS RUICES	\N
129	54	3217	TODOS LOS SANTOS	\N
129	54	3218	VILLA COLIMBA	\N
129	54	3219	AGUA PINTADA	\N
129	54	3220	AVELLANEDA	\N
129	54	3221	BARRANCA YACO	\N
129	54	3222	CANTERA LOS VIERAS	\N
129	54	3223	CRUZ MOJADA	\N
129	54	3224	EL CORO (AVELLANEDA-DPTO. ISCHILIN)	\N
129	54	3225	EL DIVISADERO (AVELLANEDA-DPTO. ISCHILIN)	\N
129	54	3226	EL ESTANQUE	\N
129	54	3227	EL IALITA	\N
129	54	3228	EL TALITA (VILLA GUTIERREZ-DPTO. ISCHILIN)	\N
129	54	3229	EL TAMBERO	\N
129	54	3230	ESTANCIA GOROSITO	\N
129	54	3231	JUAN GARCIA	\N
129	54	3232	KM 784 (EMBARCADERO FCGB)	\N
129	54	3233	KM 807 (EMBARCADERO FCGB)	\N
129	54	3234	KM 827 (APEADERO FCGB)	\N
129	54	3235	LA AGUADA (VILLA GUTIERREZ-DPTO. ISCHILIN)	\N
129	54	3236	LA CHACRA	\N
129	54	3237	LA ESTACADA	\N
129	54	3238	LA MAJADA (LOS POZOS-DPTO. ISCHILIN)	\N
129	54	3239	LA SELVA	\N
129	54	3240	LA TUNA (LOS POZOS-DPTO. ISCHILIN)	\N
129	54	3241	LAS DELICIAS (AVELLANEDA-DPTO. ISCHILIN)	\N
129	54	3242	LAS LOMITAS (SARMIENTO-DPTO. ISCHILIN)	\N
129	54	3243	LAS MANZANAS	\N
129	54	3244	LAS PIEDRAS ANCHAS	\N
129	54	3245	LAS SIERRAS	\N
129	54	3246	LOS CHAÑARES (AVELLANEDA-DPTO. ISCHILIN)	\N
129	54	3247	LOS PEDERNALES	\N
129	54	3248	LOS POZOS (DPTO. ISCHILIN)	\N
129	54	3249	LOS VIERAS	\N
129	54	3250	MOLINOS (AVELLANEDA-DPTO. ISCHILIN)	\N
129	54	3251	PEDERNALES	\N
129	54	3252	RIO DE LAS MANZANAS	\N
129	54	3253	SAN CARLOS (AVELLANEDA-DPTO. ISCHILIN)	\N
129	54	3254	SAN MIGUEL (AVELLANEDA-DPTO. ISCHILIN)	\N
129	54	3255	VILLA GUTIERREZ	\N
129	54	3256	EL BAÑADO (QUILINO-DPTO. ISCHILIN)	\N
129	54	3257	EL MOLINO (QUILINO-DPTO. ISCHILIN)	\N
129	54	3258	EL VEINTICINCO	\N
129	54	3259	KM 859 (APEADERO FCGB)	\N
129	54	3260	KM 865 (APEADERO FCGB)	\N
129	54	3261	KM 881 (EMBARCADERO FCGB)	\N
129	54	3262	LA BARRANCA (QUILINO-DPTO. ISCHILIN)	\N
129	54	3263	LA BOTIJA	\N
129	54	3264	LA FLORIDA (QUILINO-DPTO. ISCHILIN)	\N
129	54	3265	LA RUDA	\N
129	54	3266	LAS CHACRAS (VILLA QUILINO-DPTO. ISCHILIN)	\N
129	54	3267	LAS TOSCAS (QUILINO-DPTO. ISCHILIN)	\N
129	54	3268	LOS CADILLOS	\N
129	54	3269	LOS MORTEROS	\N
129	54	3270	LOS SOCABONES	\N
129	54	3271	ORCOSUNI	\N
129	54	3272	PUESTO DE ARRIBA	\N
129	54	3273	QUILINO	\N
129	54	3274	VILLA QUILINO	\N
129	54	3275	CAÑADA DE MOYO	\N
129	54	3276	CHUÑA	\N
129	54	3277	EL CHANCHITO	\N
129	54	3278	EL JUME	\N
129	54	3279	EL MOJONCITO	\N
129	54	3280	EL PARAISO (CHUÑA-DPTO. ISCHILIN)	\N
129	54	3281	EL PUESTO LOS CABRERAS	\N
129	54	3282	EL QUEBRACHO (CHUÑA-DPTO. ISCHILIN)	\N
129	54	3283	EL RANCHITO	\N
129	54	3284	JAIME PETER	\N
129	54	3285	KM 450 (PARADA FCGB)	\N
129	54	3286	LA AURA	\N
129	54	3287	LA CAÑADA ANGOSTA	\N
129	54	3288	LA CALERA (JAIME PETER-DPTO. ISCHILIN)	\N
129	54	3289	LAS CANTERAS	\N
129	54	3290	LAS TUSCAS	\N
129	54	3291	LOS TARTAGOS	\N
129	54	3292	PUESTO DE BATALLA	\N
129	54	3293	ALGARROBO	\N
129	54	3294	BAJO DE OLMOS	\N
129	54	3295	CAÑADA DE MATEO	\N
129	54	3296	CAÑADA DE RIO PINTO	\N
129	54	3297	CAÑADAS HONDAS	\N
129	54	3298	CERRO NEGRO (DPTO. ISCHILIN)	\N
129	54	3299	EL ALGARROBO	\N
129	54	3300	LOS MIQUILES	\N
129	54	3301	MIQUILOS	\N
129	54	3302	RIO DE LOS TALAS	\N
129	54	3303	RIO PINTO	\N
129	54	3304	VILLA ALBERTINA	\N
129	54	3305	VILLA CERRO NEGRO	\N
129	54	3306	SAN NICOLAS (DPTO. ISCHILIN)	\N
129	54	3307	LA CARLOTA	\N
129	54	3308	ASSUNTA	\N
129	54	3309	BARRETO (DPTO. JUAREZ CELMAN)	\N
129	54	3310	ESTANCIA LAS MARGARITAS	\N
129	54	3311	MANANTIALES (DPTO. JUAREZ CELMAN)	\N
129	54	3312	PEDRO E. FUNES	\N
129	54	3313	SANTA EUFEMIA	\N
129	54	3314	UCACHA	\N
129	54	3315	COLONIA MAIPU	\N
129	54	3316	DEMARCHI	\N
129	54	3317	LOS CISNES	\N
129	54	3318	OLMOS	\N
129	54	3319	ALEJANDRO ROCA	\N
129	54	3320	LA CAÑADA GRANDE	\N
129	54	3321	PASO DEL DURAZNO	\N
129	54	3322	REDUCCION	\N
129	54	3323	CARNERILLO	\N
129	54	3324	COLONIA SANTA PAULA	\N
129	54	3325	BENGOLEA	\N
129	54	3326	CHARRAS	\N
129	54	3327	LAGUNILLAS	\N
129	54	3328	OLAETA	\N
129	54	3329	PASTOS ALTOS	\N
129	54	3330	COLONIA DOLORES	\N
129	54	3331	GENERAL CABRERA	\N
129	54	3332	GENERAL DEHEZA	\N
129	54	3333	COLONIA VALLE GRANDE	\N
129	54	3334	EL RASTREADOR	\N
129	54	3335	HUANCHILLA	\N
129	54	3336	HUANCHILLA SUD	\N
129	54	3337	KM 55	\N
129	54	3338	PACHECO DE MELO	\N
129	54	3339	PAVIN	\N
129	54	3340	12 DE OCTUBRE	\N
129	54	3341	COLONIA LOS VASCOS	\N
129	54	3342	CRUZ ALTA	\N
129	54	3343	FLORA	\N
129	54	3344	SAIRA	\N
129	54	3345	SAN JOSE DEL SALTEÑO	\N
129	54	3346	COLONIA CALCHAQUI	\N
129	54	3347	COLONIA LA MARIUCHA	\N
129	54	3348	EL PANAL	\N
129	54	3349	MARCOS JUAREZ	\N
129	54	3350	PUEBLO ARGENTINO	\N
129	54	3351	COLONIA 25 LOS SURGENTES	\N
129	54	3352	LOS SURGENTES	\N
129	54	3353	PUEBLO CARLOS SAUVERAN	\N
129	54	3354	PUEBLO RIO TERCERO	\N
129	54	3355	GENERAL BALDISSERA	\N
129	54	3356	CAMILO ALDAO	\N
129	54	3357	ENFERMERA KELLY (APEADERO FCGM)	\N
129	54	3358	INRIVILLE	\N
129	54	3359	SALADILLO	\N
129	54	3360	MONTE BUEY	\N
129	54	3361	COLONIA VEINTICINCO	\N
129	54	3362	GENERAL ROCA	\N
129	54	3363	BARRIO LA FORTUNA	\N
129	54	3364	COLONIA EL CHAJA	\N
129	54	3365	LA REDUCCION (LEONES-DPTO. MARCOS JUAREZ)	\N
129	54	3366	LEONES	\N
129	54	3367	KM 57	\N
129	54	3368	ARIAS	\N
129	54	3369	CAVANAGH	\N
129	54	3370	DESVIO KILOMETRO 57	\N
129	54	3371	KILEGRUMAN	\N
129	54	3372	LATAN HALL	\N
129	54	3373	GUATIMOZIN	\N
129	54	3374	PUEBLO GAMBANDE	\N
129	54	3375	CAPITAN GENERAL BERNARDO O HIGGINS	\N
129	54	3376	COLONIA ITALIANA	\N
129	54	3377	COLONIA LA PALESTINA	\N
129	54	3378	COLONIA PROGRESO	\N
129	54	3379	CORRAL DE BUSTOS	\N
129	54	3380	COLONIA BARGE	\N
129	54	3381	ARTAGAVEYTIA	\N
129	54	3383	ISLA VERDE (DPTO. MARCOS JUAREZ)	\N
129	54	3384	ALEJO LEDESMA	\N
129	54	3385	BAJO DEL BURRO	\N
129	54	3386	COLONIA BALLESTEROS	\N
129	54	3387	COLONIA LEDESMA	\N
129	54	3388	EL BARREAL (SERREZUELA-DPTO. MINAS)	\N
129	54	3389	LA PINTADA (PIEDRITA BLANCA-DPTO. MINAS)	\N
129	54	3390	PIEDRITA BLANCA	\N
129	54	3391	PUESTO DE VERA	\N
129	54	3392	9 DE JULIO	\N
129	54	3393	EL CHACHO	\N
129	54	3394	EL MOYANO	\N
129	54	3395	LAS LATAS	\N
129	54	3396	MIRAFLORES (EL CHACHO-DPTO. MINAS)	\N
129	54	3397	POZO DEL BARRIAL	\N
129	54	3398	AGUAS DE RAMON	\N
129	54	3399	LAS CHACRAS (AGUAS DE RAMON-DPTO. MINAS)	\N
129	54	3400	TASACUNA	\N
129	54	3401	TOTORA GUASI	\N
129	54	3402	EL RIO	\N
129	54	3403	GUASAPAMPA	\N
129	54	3404	POZO SECO	\N
129	54	3405	RUMIGUASI	\N
129	54	3406	RARA FORTUNA	\N
129	54	3407	CIENAGA DEL CORO	\N
129	54	3408	EL SAUCE (CIENAGA DEL CORO-DPTO. MINAS)	\N
129	54	3409	LA PLAYA	\N
129	54	3410	RAMIREZ	\N
129	54	3411	RUMIACO	\N
129	54	3412	TOSNO	\N
129	54	3413	CAÑADA DE LAS GATIADAS	\N
129	54	3414	CHAÑARIACO	\N
129	54	3415	EL RODEO (SAN CARLOS MINAS-DPTO. MINAS)	\N
129	54	3416	EL SUNCHAL	\N
129	54	3417	EL VALLECITO (SAN CARLOS MINAS-DPTO. MINAS)	\N
129	54	3418	ESTANCIA DE GUADALUPE	\N
129	54	3419	LA BISMUTINA	\N
129	54	3420	LA ESTANCIA-MINAS	\N
129	54	3421	LOS BARRIALES	\N
129	54	3422	MINA LA BISMUTINA	\N
129	54	3423	MOGOTE VERDE	\N
129	54	3424	NINALQUIN	\N
129	54	3425	PAJONAL	\N
129	54	3426	PASO GRANDE	\N
129	54	3427	PIEDRAS ANCHAS (SAN CARLOS MINAS-DPTO. MINAS)	\N
129	54	3428	SAN CARLOS MINAS	\N
129	54	3429	SAPANSOTO	\N
129	54	3430	SIERRA DE LOS PAREDES	\N
129	54	3431	SIERRAS DE ABREGU	\N
129	54	3432	SUNCHAL	\N
129	54	3433	TALAINI	\N
129	54	3434	TOTORITAS	\N
129	54	3435	TRES ESQUINAS	\N
129	54	3436	TRES LOMAS	\N
129	54	3437	CERRO BOLA	\N
129	54	3438	EL DURAZNO MINAS	\N
129	54	3439	LA ARGENTINA	\N
129	54	3440	LAS CORTADERAS (LA ARGENTINA-DPTO. MINAS)	\N
129	54	3441	LOS OJOS DE AGUA	\N
129	54	3442	OJO DE AGUA (DPTO. MINAS)	\N
129	54	3443	POTRERO DE MARQUES	\N
129	54	3444	PINAS	\N
129	54	3445	DOS POZOS	\N
129	54	3446	BUENA VISTA (SALSACATE-DPTO. POCHO)	\N
129	54	3447	CUCHILLO YACO	\N
129	54	3448	EL POTRERO (SALSACATE-DPTO. POCHO)	\N
129	54	3449	LA ESQUINA (SALSACATE-DPTO. POCHO)	\N
129	54	3450	LAS CORTADERAS (SALSACATE-DPTO. POCHO)	\N
129	54	3451	LAS ROSAS (SALSACATE-DPTO. POCHO)	\N
129	54	3452	PIEDRITAS ROSADAS	\N
129	54	3453	PITOA	\N
129	54	3454	SALSACATE	\N
129	54	3455	TORO MUERTO (SALSACATE-DPTO. POCHO)	\N
129	54	3456	TRES CHAÑARES	\N
129	54	3457	VILLA TANINGA	\N
129	54	3458	VISO	\N
129	54	3459	LA CALERA (LA SIERRITA-DPTO. POCHO)	\N
129	54	3460	LA SIERRITA (DPTO. POCHO)	\N
129	54	3461	LAS CHACRAS (TALA CAÑADA-DPTO. POCHO)	\N
129	54	3462	SAGRADA FAMILIA (TALA CAÑADA-DPTO. POCHO)	\N
129	54	3463	SAN GERONIMO	\N
129	54	3464	SAUCE DE LOS QUEVEDOS	\N
129	54	3465	TALA CAÑADA	\N
129	54	3466	CAÑADA DE POCHO	\N
129	54	3467	CAÑADA DE SALAS	\N
129	54	3468	CHAMICO	\N
129	54	3469	EL CARRIZAL (POCHO-DPTO. POCHO)	\N
129	54	3470	LA AGUADITA (POCHO-DPTO. POCHO)	\N
129	54	3471	LA MUDANA	\N
129	54	3472	LA TABLADA (POCHO-DPTO. POCHO)	\N
129	54	3473	LAS PALMAS (DPTO. POCHO)	\N
129	54	3474	POCHO	\N
129	54	3475	PUSISUNA	\N
129	54	3476	ACOSTILLA	\N
129	54	3477	BALDE DE LA ORILLA	\N
129	54	3478	CHANCANI	\N
129	54	3479	EL RINCON (CHANCANI-DPTO. POCHO)	\N
129	54	3480	LA JARILLA	\N
129	54	3481	LA PATRIA	\N
129	54	3482	LAS OSCURAS	\N
129	54	3483	LOS DOS POZOS	\N
129	54	3484	MEDANITOS	\N
129	54	3485	RIO HONDO (LAS CHACRAS-DPTO. SAN JAVIER)	\N
129	54	3486	MOGIGASTA	\N
129	54	3487	LA PROVIDENCIA	\N
129	54	3488	LA CESIRA	\N
129	54	3489	COLONIA LA PROVIDENCIA	\N
129	54	3490	CURAPALIGUE	\N
129	54	3491	FRAY CAYETANO RODRIGUEZ	\N
129	54	3492	GUARDIA VIEJA	\N
129	54	3493	LABOULAYE	\N
129	54	3494	RUIZ DIAZ DE GUZMAN	\N
129	54	3495	SALGUERO	\N
129	54	3496	COLONIA SANTA ANA	\N
129	54	3497	LA RAMADA	\N
129	54	3498	MELO	\N
129	54	3499	SAN JOAQUIN	\N
129	54	3500	SANTA CLARA	\N
129	54	3501	TACUREL	\N
129	54	3502	SERRANO	\N
129	54	3503	LEGUIZAMON	\N
129	54	3504	MIGUEL SALAS	\N
129	54	3505	ROSALES	\N
129	54	3506	VILLA ROSSI	\N
129	54	3507	VIVERO	\N
129	54	3508	COLONIA LA MAGDALENA DE ORO	\N
129	54	3509	GAVILAN	\N
129	54	3510	GENERAL LEVALLE	\N
129	54	3511	JULIO ARGENTINO ROCA	\N
129	54	3512	RIO BAMBA	\N
129	54	3513	SANTA CRISTINA	\N
129	54	3514	CASSAFFOUSTH (ESTACION FCGB)	\N
129	54	3515	DIQUE SAN ROQUE (APEADERO FCGB)	\N
129	54	3516	KM 608 (APEADERO FCGB)	\N
129	54	3517	SAN ROQUE (SAN ROQUE DE PUNILLA-DPTO. PUNILLA)	\N
129	54	3518	VILLA CARLOS PAZ	\N
129	54	3519	VILLA SANTA CRUZ DEL LAGO	\N
129	54	3520	COPINA	\N
129	54	3521	CUESTA BLANCA	\N
129	54	3522	SAN ANTONIO DE ARREDONDO	\N
129	54	3523	SOLARES DE YCHO CRUZ	\N
129	54	3524	TALA HUASI	\N
129	54	3525	VILLA COSTA AZUL	\N
129	54	3526	VILLA CUESTA BLANCA	\N
129	54	3527	VILLA GARCIA	\N
129	54	3528	VILLA INDEPENDENCIA	\N
129	54	3529	VILLA RIO YCHO CRUZ	\N
129	54	3530	YCHO CRUZ SIERRAS	\N
129	54	3531	AGUA DE TALA	\N
129	54	3532	ANGOSTURA	\N
129	54	3533	BATAN	\N
129	54	3534	BUEN RETIRO	\N
129	54	3535	CASA NUEVA	\N
129	54	3536	CAVALANGO	\N
129	54	3537	COLONIA BANCO PROVINCIA DE BUENOS AIRES	\N
129	54	3538	CUCHILLA NEVADA	\N
129	54	3539	EL PERUEL	\N
129	54	3540	EL PILCADO	\N
129	54	3541	EL POTRERO (LOS GIGANTES-DPTO. PUNILLA)	\N
129	54	3542	ESTANCIA DOS RIOS	\N
129	54	3543	GUASTA	\N
129	54	3544	LA CAÑADA (TANTI-DPTO. PUNILLA)	\N
129	54	3545	LOS GIGANTES	\N
129	54	3546	MALLIN	\N
129	54	3547	TANTI	\N
129	54	3548	TANTI LOMAS	\N
129	54	3549	TANTI NUEVO	\N
129	54	3550	VILLA FLOR SERRANA	\N
129	54	3551	VILLA SUIZA ARGENTINA	\N
129	54	3552	BIALET MASSE	\N
129	54	3553	LAS CASITAS	\N
129	54	3554	LOS PUENTES	\N
129	54	3555	PARQUE SIQUIMAN	\N
129	54	3556	CASA GRANDE	\N
129	54	3557	DOMINGO FUNES	\N
129	54	3558	SAN BUENAVENTURA (APEADERO FCGB)	\N
129	54	3559	SANTA MARIA DE PUNILLA	\N
129	54	3560	VILLA BUSTOS	\N
129	54	3561	VILLA CAEIRO	\N
129	54	3562	HOSPITAL FAMILIA DOMINGO FUNES	\N
129	54	3563	COSQUIN	\N
129	54	3564	KM 592 (APEADERO FCGB)	\N
129	54	3565	MOLINARI	\N
129	54	3566	OLAEN	\N
129	54	3567	PAMPA DE OLAEN	\N
129	54	3568	SAN JOSE (COSQUIN-DPTO. PUNILLA)	\N
129	54	3569	SANTA ROSA (COSQUIN-DPTO. PUNILLA)	\N
129	54	3570	VILLA AHORA	\N
129	54	3571	DIQUE LAS VAQUERIAS	\N
129	54	3572	IRIGOYEN	\N
129	54	3573	KM 579 (APEADERO FCGB)	\N
129	54	3574	LA CANTERA	\N
129	54	3575	LA USINA	\N
129	54	3576	LOS HELECHOS	\N
129	54	3577	PIEDRA GRANDE	\N
129	54	3578	VALLE HERMOSO	\N
129	54	3579	EL CUADRADO	\N
129	54	3580	EL PUENTE	\N
129	54	3581	GRUTA DE SAN ANTONIO	\N
129	54	3582	LA FALDA	\N
129	54	3583	LAS PLAYAS (LA FALDA-DPTO. PUNILLA)	\N
129	54	3584	PIEDRAS GRANDES	\N
129	54	3585	RIO GRANDE (LA FALDA-DPTO. PUNILLA)	\N
129	54	3586	ALTO DE SAN PEDRO	\N
129	54	3587	HUERTA GRANDE	\N
129	54	3588	PIEDRA MOVEDIZA	\N
129	54	3589	PIEDRAS BLANCAS	\N
129	54	3590	CASA SERRANA (HUERTA GRANDE)	\N
129	54	3591	VILLA GIARDINO	\N
129	54	3592	CASCADAS	\N
129	54	3593	CRUZ CHICA	\N
129	54	3594	EL PINGO	\N
129	54	3595	LA CUMBRE (DPTO. PUNILLA)	\N
129	54	3596	ALTO CASTRO	\N
129	54	3597	DOLORES (SAN ESTEBAN-DPTO. PUNILLA)	\N
129	54	3598	EL BALDECITO (SAN ESTEBAN-DPTO. PUNILLA)	\N
129	54	3599	EL VADO (APEADERO FCGB)	\N
129	54	3600	LAS PAMPILLAS	\N
129	54	3601	LOS COCOS (DPTO. PUNILLA)	\N
129	54	3602	LOS MOGOTES	\N
129	54	3603	SAN ESTEBAN	\N
129	54	3604	SAN IGNACIO (SAN ESTEBAN-DPTO. PUNILLA)	\N
129	54	3605	SAUCE ARRIBA	\N
129	54	3606	AGUILA BLANCA	\N
129	54	3607	CAÑADON DE LOS MOGOTES	\N
129	54	3608	CAJON DEL RIO	\N
129	54	3609	CAPILLA DEL MONTE	\N
129	54	3610	EL AGUILA BLANCA	\N
129	54	3611	EL ZAPATO	\N
129	54	3612	LA PIEDRA MOVEDIZA	\N
129	54	3613	LAS GEMELAS	\N
129	54	3614	LAS VAQUERIAS	\N
129	54	3615	LOS TERRONES	\N
129	54	3616	PUNILLA (APEADERO FCGB)	\N
129	54	3617	SUNCHO HUAICO	\N
129	54	3618	URITORCO	\N
129	54	3619	BOSQUE ALEGRE	\N
129	54	3620	EL VERGEL (CAÑADA DE RIO PINTO-DPTO. ISCHILIN)	\N
129	54	3621	EL PERCHEL (DPTO. TULUMBA)	\N
129	54	3622	EL DURAZNO (GUTENBERG-DPTO. RIO SECO)	\N
129	54	3623	CALABALUMBA (APEADERO FCGB)	\N
129	54	3624	CHACHA DEL REY	\N
129	54	3625	CHARBONIER	\N
129	54	3626	EL CARRIZAL (CHARBONIER-DPTO. PUNILLA)	\N
129	54	3627	EL SALTO	\N
129	54	3628	ESCOBAS	\N
129	54	3629	LA COSTA (CHARBONIER-DPTO. PUNILLA)	\N
129	54	3630	LOS GUEVARA	\N
129	54	3631	LOS PAREDONES (APEADERO FCGB)	\N
129	54	3632	QUEBRADA DE LUNA	\N
129	54	3633	SAN SALVADOR (CHARBONIER-DPTO. PUNILLA)	\N
129	54	3634	SANTA ISABEL (CHARBONIER-DPTO. PUNILLA)	\N
129	54	3635	DOS RIOS (CAÑADA DEL PUERTO-DPTO. SAN ALBERTO)	\N
129	54	3636	LA QUEBRADA (CAÑADA DEL PUERTO-DPTO. SAN ALBERTO)	\N
129	54	3637	INDEPENDENCIA	\N
129	54	3638	PUEBLO ALBERDI	\N
129	54	3639	RIO CUARTO	\N
129	54	3640	ALPA CORRAL	\N
129	54	3641	CAMPO DE LA TORRE	\N
129	54	3642	COLONIA EL CARMEN	\N
129	54	3643	COLONIA LA PIEDRA	\N
129	54	3644	COLONIA PASO CARRIL	\N
129	54	3645	COSTA DEL TAMBO	\N
129	54	3646	CUATRO VIENTOS	\N
129	54	3647	EL BAÑADO (RIO CUARTO)	\N
129	54	3648	EL DURAZNITO	\N
129	54	3649	EL POTOSI	\N
129	54	3650	EL TAMBO	\N
129	54	3651	LA AGUADA (DPTO. RIO CUARTO)	\N
129	54	3652	LA CUMBRE (LAS TAPIAS-DPTO. RIO CUARTO)	\N
129	54	3653	LA ESQUINA (DPTO. RIO CUARTO)	\N
129	54	3654	LA INVERNADA	\N
129	54	3655	LA MESADA (ALPA CORRAL-DPTO. RIO CUARTO)	\N
129	54	3656	LA VERONICA	\N
129	54	3657	LAS ALBAHACAS	\N
129	54	3658	LAS CAÑITAS	\N
129	54	3659	LAS COLECITAS	\N
129	54	3660	LAS GUINDAS	\N
129	54	3661	LAS MORAS	\N
129	54	3662	LAS TAPIAS-RIO CUARTO	\N
129	54	3663	MONTE LA INVERNADA	\N
129	54	3664	PERMANENTES	\N
129	54	3665	PIEDRA BLANCA	\N
129	54	3666	RIO SECO	\N
129	54	3667	RODEO VIEJO	\N
129	54	3668	SAN BARTOLOME	\N
129	54	3669	VILLA EL CHACAY	\N
129	54	3670	VILLA SANTA RITA	\N
129	54	3671	CHUCUL	\N
129	54	3672	LAS HIGUERAS (DPTO. RIO CUARTO)	\N
129	54	3673	PUENTE LOS MOLLES	\N
129	54	3674	CORONEL BAIGORRIA	\N
129	54	3675	ESPINILLO	\N
129	54	3676	ALCIRA (GIGENA)	\N
129	54	3677	ALPAPUCA	\N
129	54	3678	BAJADA NUEVA	\N
129	54	3679	CAPILLA DE TEGUA	\N
129	54	3680	DOS LAGUNAS	\N
129	54	3681	EL BARREAL	\N
129	54	3682	EL CHIQUILLAN	\N
129	54	3683	EL ESPINILLAL	\N
129	54	3684	GIGENA	\N
129	54	3685	LA CALERA	\N
129	54	3686	LA RAMONCITA	\N
129	54	3687	LA SIERRITA	\N
129	54	3688	LAGUNA CLARA	\N
129	54	3689	TEGUA	\N
129	54	3690	ELENA	\N
129	54	3691	LOS MEDANOS	\N
129	54	3692	MEDANOS	\N
129	54	3693	BERROTARAN	\N
129	54	3694	LAS GAMAS	\N
129	54	3695	LAS PEÑAS	\N
129	54	3696	PASO CABRAL	\N
129	54	3697	PUERTA COLORADA	\N
129	54	3698	LAS PEÑAS SUD	\N
129	54	3699	EL CANO	\N
129	54	3700	GUINDAS	\N
129	54	3701	ARROYO SANTA CATALINA	\N
129	54	3702	ARSENAL JOSE MARIA ROJAS	\N
129	54	3703	HOLMBERG	\N
129	54	3704	LA LAGUNILLA (HOLMBERG-DPTO. RIO CUARTO)	\N
129	54	3705	LAS ENSENADAS (HOLMBERG-DPTO. RIO CUARTO)	\N
129	54	3706	SANTA CATALINA (HOLMBERG-DPTO. RIO CUARTO)	\N
129	54	3707	LAS VERTIENTES	\N
129	54	3708	CHAÑARITOS	\N
129	54	3709	LAGUNA SECA	\N
129	54	3710	SAMPACHO	\N
129	54	3711	SORIA	\N
129	54	3712	LA COLORADA	\N
129	54	3713	ACHIRAS	\N
129	54	3714	LA BARRANQUITA	\N
129	54	3715	CHAJAN	\N
129	54	3716	GLORIALDO FERNANDEZ	\N
129	54	3717	SAN LUCAS NORTE	\N
129	54	3718	SUCO	\N
129	54	3719	LOS JAGUELES	\N
129	54	3720	MALENA	\N
129	54	3721	MONTE DE LOS GAUCHOS	\N
129	54	3722	PUNTA DEL AGUA (ESTACION PUNTA DEL AGUA-DPTO. RIO CUARTO)	\N
129	54	3723	ZAPOLOCO	\N
129	54	3724	CAROLINA	\N
129	54	3725	COLONIA ORCOVI	\N
129	54	3726	LA MERCANTIL	\N
129	54	3727	LAS CINCO CUADRAS	\N
129	54	3728	SAN BASILIO	\N
129	54	3729	YATAY	\N
129	54	3730	ADELIA MARIA	\N
129	54	3731	ESTACION PUNTA DE AGUA	\N
129	54	3732	BULNES	\N
129	54	3733	COLONIA DEAN FUNES	\N
129	54	3734	COLONIA LA CELESTINA	\N
129	54	3735	CORONEL MOLDES	\N
129	54	3736	FRAGUEYRO	\N
129	54	3737	LA BRIANZA	\N
129	54	3738	LA GILDA	\N
129	54	3739	LAS ACEQUIAS	\N
129	54	3740	SAN AMBROSIO	\N
129	54	3741	SAN BERNARDO (SAN AMBROSIO-DPTO. RIO CUARTO)	\N
129	54	3742	LOS TRES POZOS	\N
129	54	3743	COLONIA ARGENTINA	\N
129	54	3744	GENERAL PUEYRREDON	\N
129	54	3745	PRETOT FREYRE	\N
129	54	3746	PUEYRREDON	\N
129	54	3747	VICUÑA MACKENNA	\N
129	54	3748	COLONIA LA CARMENCITA	\N
129	54	3749	TOSQUITA	\N
129	54	3750	GENERAL SOLER	\N
129	54	3751	KM 545 (FCGSM)	\N
129	54	3752	LA CAUTIVA	\N
129	54	3753	LAGUNA OSCURA	\N
129	54	3754	WASHINGTON	\N
129	54	3755	BAJO DE FERNANDEZ	\N
129	54	3756	CAÑADA DE CUEVAS	\N
129	54	3757	CAPILLA DE REMEDIOS	\N
129	54	3758	EL QUEBRACHO RIO PRIMERO	\N
129	54	3759	ESCUELA DE ARTILLERIA	\N
129	54	3760	GENERAL LAS HERAS	\N
129	54	3761	LA CAÑADA-RIO PRIMERO	\N
129	54	3762	LAS HERAS	\N
129	54	3763	NUEVA ANDALUCIA	\N
129	54	3764	PASO DEL SAUCE	\N
129	54	3765	CAPILLA DE DOLORES	\N
129	54	3766	COLONIA SAGRADA FAMILIA	\N
129	54	3767	CONSTITUCION	\N
129	54	3768	HIGUERILLAS	\N
129	54	3769	KM 658 (EMBARCADERO FCGB)	\N
129	54	3770	KM 691	\N
129	54	3771	LA CELINA	\N
129	54	3772	MONTE CRISTO	\N
129	54	3773	POZO DE LA LOMA	\N
129	54	3774	CHACRAS NORTE	\N
129	54	3775	LAS CABRAS	\N
129	54	3776	LOS GUINDOS	\N
129	54	3777	LOS MANSILLAS	\N
129	54	3778	PEDRO E. VIVAS	\N
129	54	3779	RIO PRIMERO	\N
129	54	3780	TALA SUD	\N
129	54	3781	CAPILLA LA ESPERANZA	\N
129	54	3782	CASTELLANOS	\N
129	54	3783	COMECHINGONES (DPTO. RIO 1)	\N
129	54	3784	EL CRISPIN	\N
129	54	3785	ESPINILLO (MONTE DEL ROSARIO-DPTO. RIO PRIMERO)	\N
129	54	3786	ISLA DEL CERRO	\N
129	54	3787	ISLA LARGA	\N
129	54	3788	LA BUENA PARADA	\N
129	54	3789	LA ESTRELLA	\N
129	54	3790	LAS ACACIAS	\N
129	54	3791	LAS PIGUAS	\N
129	54	3792	MONTE DEL ROSARIO	\N
129	54	3793	PUNTA DEL AGUA (DPTO. RIO PRIMERO)	\N
129	54	3794	EL ALCALDE	\N
129	54	3795	ESPERANZA	\N
129	54	3796	ESQUINA	\N
129	54	3797	LAS HIGUERILLAS	\N
129	54	3798	PUEBLO PIANELLI	\N
129	54	3799	PUESTO DE AFUERA	\N
129	54	3800	RANGEL	\N
129	54	3801	TALA NORTE	\N
129	54	3802	BUEY MUERTO	\N
129	54	3803	COLONIA EL FORTIN	\N
129	54	3804	EL CARRIZAL (DPTO. RIO PRIMERO)	\N
129	54	3805	EL ESPINAL	\N
129	54	3806	ESPINAL	\N
129	54	3807	LA CIENAGA	\N
129	54	3808	LOS ALVAREZ	\N
129	54	3809	LOS CHAÑARES (SANTA ROSA DE RIO PRIMERO-DPTO. RIO PRIMERO)	\N
129	54	3810	POZO DE LA ESQUINA	\N
129	54	3811	SANTA ROSA DE RIO PRIMERO	\N
129	54	3812	VILLA SANTA ROSA	\N
129	54	3813	CAÑADA ANCHA (BUEY MUERTO-DPTO. RIO PRIMERO)	\N
129	54	3814	COLONIA LAS CUATRO ESQUINAS	\N
129	54	3815	CORRAL DE GOMEZ (LAS AVERIAS-DPTO. RIO PRIMERO)	\N
129	54	3816	DIEGO DE ROJAS	\N
129	54	3817	LA QUINTA (DPTO. RIO PRIMERO)	\N
129	54	3818	LAS AVERIAS	\N
129	54	3819	LAS GRAMILLAS (DPTO. RIO PRIMERO)	\N
129	54	3820	MONTE DE TORO PUJIO	\N
129	54	3821	POZO LA PIEDRA	\N
129	54	3822	TORDILLA NORTE	\N
129	54	3823	BALNEARIO GUGLIERI	\N
129	54	3824	COLONIA CAÑADON	\N
129	54	3825	COLONIA LA ARGENTINA	\N
129	54	3826	COLONIA YARELA	\N
129	54	3827	COSTA DEL CASTAÑO	\N
129	54	3828	EL BAGUAL	\N
129	54	3829	EL TOSTADO	\N
129	54	3830	KM 294	\N
129	54	3831	KM 316 (APEADERO FCGB)	\N
129	54	3832	LA MOSTAZA	\N
129	54	3833	LA PARA	\N
129	54	3834	LA PUERTA (DPTO. RIO PRIMERO)	\N
129	54	3835	LAS HILERAS	\N
129	54	3836	LAS SALADAS	\N
129	54	3837	LOMAS DEL TROZO	\N
129	54	3838	LOS AVILES	\N
129	54	3839	LOS CASTAÑOS	\N
129	54	3840	LOS MIGUELITOS	\N
129	54	3841	PLAZA DE MERCEDES	\N
129	54	3842	POZO DE LOS TRONCOS	\N
129	54	3843	SAN RAMON (PLAZA DE MERCEDES-DPTO. RIO PRIMERO)	\N
129	54	3844	SOLEDAD	\N
129	54	3845	VILLA FONTANA	\N
129	54	3846	VILLA MAR CHIQUITA	\N
129	54	3847	KM 271 (APEADERO FCGB)	\N
129	54	3848	COLONIA SAN IGNACIO	\N
129	54	3849	ATAHONA	\N
129	54	3850	CAMPO RAMALLO	\N
129	54	3851	ISLA VERDE (O. TREJO-DPTO. RIO PRIMERO)	\N
129	54	3852	LAS BANDURRIAS NORTE	\N
129	54	3853	LOS ALGARROBITOS (ATAHONA-DPTO. RIO PRIMERO)	\N
129	54	3854	LOS POZOS (PUESTO DE PUCHETA. DTO. RIO PRIMERO)	\N
129	54	3855	MIGUELITO	\N
129	54	3856	OBISPO TREJO	\N
129	54	3857	POZO DEL MORO	\N
129	54	3858	PUESTO DE PUCHETA	\N
129	54	3859	RAMALLO	\N
129	54	3860	CAÑADA HONDA (LA POSTA-DPTO. RIO PRIMERO)	\N
129	54	3861	LA POSTA (DPTO. RIO PRIMERO)	\N
129	54	3862	LAS PALMITAS (MAQUINISTA GALLINI-DPTO. RIO PRIMERO)	\N
129	54	3863	MAQUINISTA GALLINI	\N
129	54	3864	PUESTO DE FIERRO	\N
129	54	3865	CHALACEA	\N
129	54	3866	DESVIO CHALACEA	\N
129	54	3867	TOTORAL (KILOMETRO 351)	\N
129	54	3868	CAÑADA DE MACHADO	\N
129	54	3869	AROMITO	\N
129	54	3870	MAZA	\N
129	54	3871	BAJO HONDO	\N
129	54	3872	CAMOATI	\N
129	54	3873	CAMPO GRANDE	\N
129	54	3874	ENCRUCIJADA	\N
129	54	3875	LA CAÑADA-RIO SECO	\N
129	54	3876	LA MAZA	\N
129	54	3877	LA PALMA	\N
129	54	3878	LA PENCA (SEBASTIAN ELCANO-DPTO. RIO SECO)	\N
129	54	3879	SEBASTIAN ELCANO	\N
129	54	3880	CANDELARIA SUD	\N
129	54	3881	EL POZO	\N
129	54	3882	EL VISMAL	\N
129	54	3883	EL ZAPALLAR	\N
129	54	3884	LA RINCONADA (DPTO. RIO SECO)	\N
129	54	3885	LOS TAJAMARES	\N
129	54	3886	PUESTO DE CASTRO	\N
129	54	3887	PUESTO DE LUNA	\N
129	54	3888	TAJAMARES	\N
129	54	3889	CANDELARIA NORTE	\N
129	54	3890	BARRETO (SANTA ELENA-DPTO. RIO SECO)	\N
129	54	3891	CARNERO YACO	\N
129	54	3892	CASAS VIEJAS (STA. ELENA-DPTO. RIO SECO)	\N
129	54	3893	CHAÑAR VIEJO	\N
129	54	3894	CHILE CORRAL LA AGUADA	\N
129	54	3895	CHILI CORRAL	\N
129	54	3896	CORRAL VIEJO	\N
129	54	3897	EL PANTANILLO (RAYO CORTADO-DPTO. RIO SECO)	\N
129	54	3898	LA PIEDRA BLANCA	\N
129	54	3899	LAS GRAMILLAS (RAYO CORTADO-DPTO. RIO SECO)	\N
129	54	3900	LAS TRANCAS	\N
129	54	3901	LO MACHADO	\N
129	54	3902	LOS CAJONES	\N
129	54	3903	LOS CERRILLOS (RAYO CORTADO-DPTO. RIO SECO)	\N
129	54	3904	LOS COCOS (SANTA ELENA-DPTO. RIO SECO)	\N
129	54	3905	LOS TRONCOS (SANTA ELENA-DPTO. RIO SECO)	\N
129	54	3906	PASO DEL SILVERIO	\N
129	54	3907	POZO DE JUANCHO	\N
129	54	3908	RAYO CORTADO	\N
129	54	3909	RIO PEDRO	\N
129	54	3910	SANTA ELENA (DPTO. RIO SECO)	\N
129	54	3911	VANGUARDIA	\N
129	54	3912	AGUA DE ORO (VILLA DE MARIA DEL RIO SECO-DPTO. RIO SECO)	\N
129	54	3913	BAÑADO DEL FUERTE	\N
129	54	3914	BALBUENA	\N
129	54	3915	CAÑA CRUZ	\N
129	54	3916	CAÑADA DE CORIA	\N
129	54	3917	EL BAÑADO (VILLA DE MARIA DEL RIO SECO-DPTO. RIO SECO)	\N
129	54	3918	EL CORO (EUFRASIO LOZA-DPTO. RIO SECO)	\N
129	54	3919	EL GABINO	\N
129	54	3920	EL GALLEGO	\N
129	54	3921	EL JORDAN	\N
129	54	3922	EL LAUREL	\N
129	54	3923	EL PRADO	\N
129	54	3924	EL PUESTO (LA ESTANCIA RIO SECO-DPTO. RIO SECO)	\N
129	54	3925	EL SILVERIO	\N
129	54	3926	EUFRASIO LOZA	\N
129	54	3927	LA BARRANCA (VILLA DE MARIA DEL RIO SECO-DPTO. RIO SECO)	\N
129	54	3928	LA PINTADA (VILLA DE MARIA DEL RIO SECO-DPTO. RIO SECO)	\N
129	54	3929	LAS CARDAS	\N
129	54	3930	POCITO DEL CAMPO	\N
129	54	3931	SAN IGNACIO (EUFRASIO LOZA-DPTO. RIO SECO)	\N
129	54	3932	SANTA CATALINA (EUFRASIO LOZA-DPTO. RIO SECO)	\N
129	54	3933	SANTANILLA	\N
129	54	3934	VILLA DE MARIA DEL RIO SECO	\N
129	54	3935	YANACATO	\N
129	54	3936	BUENA VISTA (GUTENBERG-DPTO. RIO SECO)	\N
129	54	3937	CANDELARIA (RIO SECO)	\N
129	54	3938	CORRAL DEL REY	\N
129	54	3939	EL ALGARROBAL	\N
129	54	3940	EL GUANACO	\N
129	54	3941	EL MANGRULLO	\N
129	54	3942	EL PROGRESO	\N
129	54	3943	EL QUEBRACHO (LOS HOYOS-DPTO. RIO SECO)	\N
129	54	3944	EL RODEO (LOS HOYOS-DPTO. RIO SECO)	\N
129	54	3945	EL TULE	\N
129	54	3946	ESTANCIA PATIÑO	\N
129	54	3947	GUTENBERG	\N
129	54	3948	LA BANDA	\N
129	54	3949	LA CHICHARRA	\N
129	54	3950	LA COSTA (LOS HOYOS-DPTO. RIO SECO)	\N
129	54	3951	LA CRUZ (LA ESTANCIA-DPTO. RIO SECO)	\N
129	54	3952	LA ESTANCIA (RIO SECO)	\N
129	54	3953	LA QUINTANA	\N
129	54	3954	LA RINCONADA (LOS HOYOS-DPTO. RIO SECO)	\N
129	54	3955	LA SOLEDAD	\N
129	54	3956	LAS CHACRAS (GUTENBERG-DPTO. RIO SECO)	\N
129	54	3957	LAS CORTADERAS (GUTEMBERG-DPTO. RIO SECO)	\N
129	54	3958	LAS FLORES	\N
129	54	3959	LOS HOYOS	\N
129	54	3960	LOS JUSTES	\N
129	54	3961	LOS POCITOS (GUTENBERG-DPTO. RIO SECO)	\N
129	54	3962	LOS POZOS (GUTENBERG-DPTO. RIO SECO)	\N
129	54	3963	POZO DE LAS OLLAS	\N
129	54	3964	POZO DE LOS ARBOLES	\N
129	54	3965	POZO DE MOLINA	\N
129	54	3966	POZO DEL SIMBOL (CANDELARIA. RIO SECO-DPTO. RIO SECO)	\N
129	54	3967	PUESTO DE LOS ALAMOS	\N
129	54	3968	PUNTA DEL MONTE	\N
129	54	3969	RACEDO	\N
129	54	3970	RIO DULCE	\N
129	54	3971	RIO SAN MIGUEL	\N
129	54	3972	RIO VIEJO	\N
129	54	3973	SAN BARTOLO	\N
129	54	3974	SAN JUANCITO	\N
129	54	3975	SAN MARTIN (GUTENBERG-DPTO. RIO SECO)	\N
129	54	3976	SAN PEDRO (GUTENBERG-DPTO. RIO SECO)	\N
129	54	3977	SAN RAMON (CANDELARIA-RIO SECO-DPTO. RIO SECO)	\N
129	54	3978	SANTA ISABEL (GUTENBERG-DPTO. RIO SECO)	\N
129	54	3979	TACO POZO	\N
129	54	3980	LA OSCURIDAD	\N
129	54	3981	CERRO COLORADO	\N
129	54	3982	LA VICTORIA (POZO DEL MOLLE-DPTO. RIO SEGUNDO)	\N
129	54	3983	LOS CHAÑARITOS (DPTO. RIO SEGUNDO)	\N
129	54	3984	LOS PANTANILLOS	\N
129	54	3985	ORATORIO DE PERALTA	\N
129	54	3986	POZO DE LAS YEGUAS	\N
129	54	3987	SANTIAGO TEMPLE	\N
129	54	3988	LA PALMERINA	\N
129	54	3989	LA ZARA	\N
129	54	3990	LA ZARITA	\N
129	54	3991	POZO DEL MOLLE (DPTO. RIO SEGUNDO)	\N
129	54	3992	CAMPO AMBROGGIO	\N
129	54	3993	CARRILOBO	\N
129	54	3994	RIO SEGUNDO	\N
129	54	3995	SAN RAFAEL (RIO SEGUNDO-DPTO. RIO SEGUNDO)	\N
129	54	3996	BAJO DE GOMEZ	\N
129	54	3997	BAJO GALINDEZ	\N
129	54	3998	COSTA SACATE	\N
129	54	3999	PALO NEGRO	\N
129	54	4000	RINCON (DPTO. RIO SEGUNDO)	\N
129	54	4001	SAN JOSE (COSTA SACATE-DPTO. RIO SEGUNDO)	\N
129	54	4002	CAÑADA DE MACHADO SUD	\N
129	54	4003	CAPILLA DEL CARMEN	\N
129	54	4004	COSTA ALEGRE	\N
129	54	4005	EL CARRIZAL (VILLA DEL ROSARIO-DPTO. RIO SEGUNDO)	\N
129	54	4006	EL CORRALITO	\N
129	54	4007	LA ISLETA	\N
129	54	4008	SAN JERONIMO	\N
129	54	4009	VILLA DEL ROSARIO	\N
129	54	4010	CALCHIN OESTE	\N
129	54	4011	COLAZO	\N
129	54	4012	COLONIA VIDELA	\N
129	54	4013	LAS JUNTURAS	\N
129	54	4014	MATORRALES	\N
129	54	4015	GALPON CHICO	\N
129	54	4016	LUQUE	\N
129	54	4017	PLAZA MINETTI	\N
129	54	4018	CALCHIN	\N
129	54	4019	ESTACION CALCHIN	\N
129	54	4020	LAGUNILLA (PILAR-DPTO. RIO SEGUNDO)	\N
129	54	4021	PASO DE VELEZ	\N
129	54	4022	PILAR	\N
129	54	4023	TRES POZOS	\N
129	54	4024	LAGUNA LARGA	\N
129	54	4025	ONCATIVO	\N
129	54	4026	ESTANCIA LOS MATORRALES	\N
129	54	4027	IMPIRA	\N
129	54	4028	PLAZA RODRIGUEZ	\N
129	54	4029	LAGUNA LARGA SUD	\N
129	54	4030	MANFREDI	\N
129	54	4031	LOS PATOS	\N
129	54	4032	COMECHINGONES (PAMPA DE ACHALA-DPTO. SAN ALBERTO)	\N
129	54	4033	LAS ENSENADAS (PAMPA DE ACHALA-DPTO. SAN ALBERTO)	\N
129	54	4034	LOS HUESOS	\N
129	54	4035	MESILLAS	\N
129	54	4036	PAMPA DE ACHALA	\N
129	54	4037	PUESTO GUZMAN	\N
129	54	4038	ARCOYO	\N
129	54	4039	ARROYO	\N
129	54	4040	BUENA VISTA (CAÑADA DEL PUERTO-DPTO. SAN ALBERTO)	\N
129	54	4041	CAÑADA DEL PUERTO	\N
129	54	4042	CERRO NEGRO (CAÑADA DEL PUERTO-DPTO. SAN ALBERTO)	\N
129	54	4043	MINA ARAUJO	\N
129	54	4044	PUERTA DE LA QUEBRADA	\N
129	54	4045	AMBUL	\N
129	54	4046	CARRIZAL (AMBUL-DPTO. SAN ALBERTO)	\N
129	54	4047	MUSSI	\N
129	54	4048	TARUCA PAMPA	\N
129	54	4049	LA CONCEPCION	\N
129	54	4050	ALTAUTINA	\N
129	54	4051	BAÑADO DE PAJA	\N
129	54	4052	BALDE DE LA MORA	\N
129	54	4053	BALDE LINDO	\N
129	54	4054	CHUA	\N
129	54	4055	CONCEPCION	\N
129	54	4056	CONDOR HUASI	\N
129	54	4057	EL BORDO	\N
129	54	4058	EL PASO DE LA PAMPA	\N
129	54	4059	LA COMPASION	\N
129	54	4060	LA CORTADERA (SAN PEDRO-DPTO. SAN ALBERTO)	\N
129	54	4061	LA LINEA	\N
129	54	4062	LA TRAMPA	\N
129	54	4063	LAS TOSCAS (DPTO. SAN ALBERTO)	\N
129	54	4064	LOS CALLEJONES (SAN PEDRO-DPTO. SAN ALBERTO)	\N
129	54	4065	POZO DE LA PAMPA	\N
129	54	4066	PUEBLO SARMIENTO	\N
129	54	4067	QUEBRACHO SOLO	\N
129	54	4068	SAN PEDRO (DPTO. SAN ALBERTO)	\N
129	54	4069	SAN RAFAEL (LAS TOSCAS-DPTO. SAN ALBERTO)	\N
129	54	4070	SAN VICENTE-SAN ALBERTO	\N
129	54	4071	SANTO DOMINGO (SAN VICENTE-SAN ALBERTO-DPTO. SAN ALBERTO)	\N
129	54	4072	CAÑADA GRANDE (SALTO SAN JAVIER-DPTO. SAN JAVIER)	\N
129	54	4073	ALGARROBAL	\N
129	54	4074	EL ALGODONAL (LAS RABONAS-DPTO. SAN ALBERTO)	\N
129	54	4075	EL PANTANILLO (LAS RABONAS-DPTO. SAN ALBERTO)	\N
129	54	4076	EL PERCHEL (LAS RABONAS-DPTO. SAN ALBERTO)	\N
129	54	4077	EL TAJAMAR	\N
129	54	4078	LA COSTA (LAS RABONAS-DPTO. SAN ALBERTO)	\N
129	54	4079	LAS CALLES	\N
129	54	4080	LAS CEBOLLAS	\N
129	54	4081	LAS CONANITAS	\N
129	54	4082	LAS RABONAS	\N
129	54	4083	VILLA ANGELICA	\N
129	54	4084	VILLA CLODOMIRA	\N
129	54	4085	VILLA RAFAEL BENEGAS	\N
129	54	4086	BAJO EL MOLINO	\N
129	54	4087	EL ALTO (NONO-DPTO. SAN ALBERTO)	\N
129	54	4088	EL SAUZAL	\N
129	54	4089	HUCLE	\N
129	54	4090	LA AGUADITA (NONO-DPTO. SAN ALBERTO)	\N
129	54	4091	LA MAJADA (NONO-DPTO. SAN ALBERTO)	\N
129	54	4092	LA QUINTA (NONO-DPTO. SAN ALBERTO)	\N
129	54	4093	LOS ALGARROBOS (NONO-DPTO. SAN ALBERTO)	\N
129	54	4094	LOS MOLLES (NONO-DPTO. SAN ALBERTO)	\N
129	54	4095	NONO	\N
129	54	4096	OJO DE AGUA (NONO-DPTO. SAN ALBERTO)	\N
129	54	4097	PASO LAS TROPAS	\N
129	54	4098	PIEDRA BLANCA (NONO-DPTO. SAN ALBERTO)	\N
129	54	4099	RIO ARRIBA	\N
129	54	4100	ARROYO LA HIGUERA	\N
129	54	4101	ARROYO LOS PATOS	\N
129	54	4102	CAÑADA LARGA	\N
129	54	4103	EL BAJO	\N
129	54	4104	EL CORTE	\N
129	54	4105	MINA CLAVERO	\N
129	54	4106	NIÑA PAULA	\N
129	54	4107	NIDO DEL AGUILA	\N
129	54	4108	QUEBRADA DEL HORNO	\N
129	54	4109	SAN SEBASTIAN	\N
129	54	4110	SANTA MARIA (MINA CLAVERO-DPTO. SAN ALBERTO)	\N
129	54	4111	CASA DE PIEDRA	\N
129	54	4112	CIENAGA DE ALLENDE	\N
129	54	4113	EL MIRADOR	\N
129	54	4114	JUAN BAUTISTA ALBERDI	\N
129	54	4115	LA GUARDIA	\N
129	54	4116	VILLA CURA BROCHERO	\N
129	54	4117	ALTO GRANDE	\N
129	54	4118	ISLA VERDE (TASMA-DPTO. SAN ALBERTO)	\N
129	54	4119	LA COCHA (TASMA-DPTO. SAN ALBERTO)	\N
129	54	4120	PACHANGO	\N
129	54	4121	PANAHOLMA	\N
129	54	4122	SAN LORENZO (DPTO. SAN ALBERTO)	\N
129	54	4123	SANTA RITA (TASMA-DPTO. SAN ALBERTO)	\N
129	54	4124	TASMA	\N
129	54	4125	BARRIO LA FERIA	\N
129	54	4126	CHAQUINCHUNA	\N
129	54	4127	CORRAL DE CABALLOS	\N
129	54	4128	EL BALDECITO (VILLA DOLORES-DPTO. SAN JAVIER)	\N
129	54	4129	LA CAÑADA (DPTO. SAN JAVIER)	\N
129	54	4130	LA VENTANA	\N
129	54	4131	LAS CAÑADAS (VILLA DOLORES-DPTO. SAN JAVIER)	\N
129	54	4132	LAS PALOMAS	\N
129	54	4133	NICHO	\N
129	54	4134	TABANILLO	\N
129	54	4135	VILLA DOLORES	\N
129	54	4136	BAÑADO DE CHUA	\N
129	54	4137	BALDE DE LAS CAÑAS	\N
129	54	4138	CARTABEROL	\N
129	54	4139	LA CONSTANCIA	\N
129	54	4140	LAS ENCRUCIJADAS	\N
129	54	4141	LOS CERRILLOS	\N
129	54	4142	PASO DEL CHAÑAR	\N
129	54	4143	PIEDRA PINTADA	\N
129	54	4144	SAN JOSE	\N
129	54	4145	ARBOLES BLANCOS	\N
129	54	4146	CAPILLA DE ROMERO	\N
129	54	4147	CONLARA	\N
129	54	4148	EL MANANTIAL (SALTO. SAN JAVIER-DPTO. SAN JAVIER)	\N
129	54	4149	LOS MANGUITOS	\N
129	54	4150	MANANTIAL	\N
129	54	4151	MANGUITAS	\N
129	54	4152	POZO DEL CHAÑAR	\N
129	54	4153	POZO DEL MOLLE	\N
129	54	4154	SALTO	\N
129	54	4155	TILQUICHO	\N
129	54	4156	ZAPATA (DESVIO KILOMETRO 204)	\N
129	54	4157	ACHIRAS (SAN JAVIER-DPTO. SAN JAVIER)	\N
129	54	4158	ALTO DE LAS MULAS	\N
129	54	4159	BANDA DE VARELA	\N
129	54	4160	CHUCHIRAS	\N
129	54	4161	COLONIA MONTES NEGROS	\N
129	54	4162	COME TIERRA	\N
129	54	4163	CRUZ DE CAÑA (SAN JAVIER)	\N
129	54	4164	DIEZ RIOS	\N
129	54	4165	EL CERRO	\N
129	54	4166	EL PUEBLITO (SAN JAVIER-DPTO. SAN JAVIER)	\N
129	54	4167	GUANACO BOLEADO	\N
129	54	4168	HUASTA	\N
129	54	4169	LA POBLACION	\N
129	54	4170	LA SIENA	\N
129	54	4171	LA TRAVESIA	\N
129	54	4172	LAS CHACRAS (DPTO. SAN JAVIER)	\N
129	54	4173	LOMITAS	\N
129	54	4174	LUYABA	\N
129	54	4175	PUEBLITO	\N
129	54	4176	QUEBRACHO LADEADO	\N
129	54	4177	RIO DE JAIME	\N
129	54	4178	RODEO DE PIEDRA	\N
129	54	4179	SAGRADA FAMILIA	\N
129	54	4180	SAN ISIDRO	\N
129	54	4181	SAN JAVIER	\N
129	54	4182	TRAVESIA	\N
129	54	4183	YACANTO	\N
129	54	4184	CORRALITO-SAN JAVIER	\N
129	54	4185	LA FUENTE	\N
129	54	4186	LA PAZ (DPTO. SAN JAVIER)	\N
129	54	4187	LAS TRES PIEDRAS	\N
129	54	4188	LOMA BOLA	\N
129	54	4189	ALTO RESBALOSO	\N
129	54	4190	BOCA DEL RIO	\N
129	54	4191	DIQUE LA VIÑA	\N
129	54	4192	EL ALTO (VILLA DE LAS ROSAS-DPTO. SAN JAVIER)	\N
129	54	4193	HORNILLOS	\N
129	54	4194	LA AGUADITA	\N
129	54	4195	LAS TAPIAS-SAN JAVIER	\N
129	54	4196	LOS MOLLES	\N
129	54	4197	QUEBRADA DE LOS POZOS	\N
129	54	4198	VILLA DE LAS ROSAS	\N
129	54	4199	COLONIA MAUNIER	\N
129	54	4200	COLONIA MILESSI	\N
129	54	4201	DOS ROSAS	\N
129	54	4202	LA MILKA	\N
129	54	4203	SAN FRANCISCO	\N
129	54	4204	PLAZA LUXARDO	\N
129	54	4205	COLONIA ANITA	\N
129	54	4206	COLONIA EUGENIA	\N
129	54	4207	COLONIA ITURRASPE	\N
129	54	4208	COLONIA PRODAMONTE	\N
129	54	4209	COLONIA VALTELINA	\N
129	54	4210	FREYRE	\N
129	54	4211	LA UDINE	\N
129	54	4212	CAPILLA SANTA ROSA	\N
129	54	4213	COLONIA CEFERINA	\N
129	54	4214	COLONIA GORCHS	\N
129	54	4215	COLONIA LAVARELLO	\N
129	54	4216	COLONIA NUEVO PIAMONTE	\N
129	54	4217	COLONIA PALO LABRADO	\N
129	54	4218	PORTEÑA	\N
129	54	4219	ALTOS DE CHIPION	\N
129	54	4220	COLONIA LA TRINCHERA	\N
129	54	4221	COLONIA UDINE	\N
129	54	4222	LA PAQUITA	\N
129	54	4223	LA TRINCHERA	\N
129	54	4224	LA VICENTA	\N
129	54	4225	BRINKMANN	\N
129	54	4226	COLONIA BOTTURI	\N
129	54	4227	COLONIA VIGNAUD	\N
129	54	4228	COTAGAITA	\N
129	54	4229	SEEBER	\N
129	54	4230	CAMPO BEIRO	\N
129	54	4231	COLONIA BEIRO	\N
129	54	4232	COLONIA DOS HERMANOS	\N
129	54	4233	COLONIA SAN PEDRO	\N
129	54	4234	COLONIA TACURALES	\N
129	54	4235	LOS DESAGUES	\N
129	54	4236	MAUNIER	\N
129	54	4237	MORTEROS	\N
129	54	4238	CAMPO CALVO	\N
129	54	4239	CAMPO LA LUISA	\N
129	54	4240	COLONIA LA MOROCHA	\N
129	54	4241	COLONIA PROSPERIDAD	\N
129	54	4242	COLONIA SANTA MARIA	\N
129	54	4243	MONTE REDONDO	\N
129	54	4244	QUEBRACHO HERRADO	\N
129	54	4245	AMALIA	\N
129	54	4246	COLONIA AMALIA	\N
129	54	4247	COLONIA CRISTINA	\N
129	54	4248	COLONIA EL MILAGRO	\N
129	54	4249	COLONIA EL TRABAJO	\N
129	54	4250	COLONIA MALBERTINA	\N
129	54	4251	COLONIA MARINA	\N
129	54	4252	CRISTINA	\N
129	54	4253	DEVOTO	\N
129	54	4254	EL MILAGRO	\N
129	54	4255	EL TRABAJO	\N
129	54	4256	JEANMAIRE	\N
129	54	4257	CAMPO BOERO	\N
129	54	4258	COLONIA SAN BARTOLOME	\N
129	54	4259	LA FRANCIA	\N
129	54	4260	VILLA VIEJA	\N
129	54	4261	COLONIA DEL BANCO NACION	\N
129	54	4262	EL FUERTECITO	\N
129	54	4263	ESTANCIA LA CHIQUITA	\N
129	54	4264	ESTANCIA LA MOROCHA	\N
129	54	4265	ARBOL CHATO	\N
129	54	4266	CAPILLA SAN ANTONIO	\N
129	54	4267	EL TIO	\N
129	54	4268	COLONIA SAN RAFAEL	\N
129	54	4269	LA FRONTERA	\N
129	54	4270	PASO DE LOS GALLEGOS	\N
129	54	4271	POZO DEL CHAJA	\N
129	54	4272	VILLA CONCEPCION DEL TIO	\N
129	54	4273	ARROYITO	\N
129	54	4274	ARROYO DE ALVAREZ	\N
129	54	4275	EL DESCANSO	\N
129	54	4276	LA CURVA	\N
129	54	4277	COLONIA COYUNDA	\N
129	54	4278	COLONIA LA TORDILLA	\N
129	54	4279	LA TORDILLA NORTE	\N
129	54	4280	VILLA VAUDAGNA	\N
129	54	4281	COLONIA ARROYO DE ALVAREZ	\N
129	54	4282	COLONIA CORTADERA	\N
129	54	4283	COLONIAS	\N
129	54	4284	PLAZA BRUNO	\N
129	54	4285	QUEBRACHITOS	\N
129	54	4286	TRANSITO	\N
129	54	4287	CAMPO COYUNDA	\N
129	54	4288	MARULL	\N
129	54	4289	PLAYA GRANDE	\N
129	54	4290	PUENTE RIO PLUJUNTA	\N
129	54	4291	TORO PUJIO	\N
129	54	4292	BALNEARIA	\N
129	54	4293	JERONIMO CORTES	\N
129	54	4294	PLUJUNTA	\N
129	54	4295	BARRIO MULLER	\N
129	54	4296	MIRAMAR	\N
129	54	4297	VACAS BLANCAS	\N
129	54	4298	COLONIA TORO PUJIO	\N
129	54	4299	INDIA MUERTA	\N
129	54	4300	LAS VARILLAS	\N
129	54	4301	TRINCHERA	\N
129	54	4302	COLONIA ANGELITA	\N
129	54	4303	LAS VARAS	\N
129	54	4304	CAMPO BANDILLO	\N
129	54	4305	SATURNINO M. LASPIUR	\N
129	54	4306	COLONIA GRAL. DEHEZA	\N
129	54	4307	CORRAL DE MULAS	\N
129	54	4308	LA POBLADORA	\N
129	54	4309	SACANTA	\N
129	54	4310	EL ARAÑADO	\N
129	54	4311	EL JUMIAL	\N
129	54	4312	POZO DEL AVESTRUZ	\N
129	54	4313	VILLA SAN ESTEBAN	\N
129	54	4314	ALICIA	\N
129	54	4315	EL FORTIN	\N
129	54	4316	PLAZA SAN FRANCISCO	\N
129	54	4317	BAJO GRANDE	\N
129	54	4318	CAMINO A PUNTA DEL AGUA	\N
129	54	4319	CAPILLA DE COSME	\N
129	54	4320	COLONIA COSME SUD	\N
129	54	4321	COSME	\N
129	54	4322	COSME SUD	\N
129	54	4323	LOS OLIVARES	\N
129	54	4324	LOZADA	\N
129	54	4325	MALAGUEÑO	\N
129	54	4326	MARIA VIRGINIA	\N
129	54	4327	MI VALLE	\N
129	54	4328	MYRIAM STEFFORD	\N
129	54	4329	YOCSINA	\N
129	54	4330	ALTO DE FIERRO	\N
129	54	4331	ALTO DEL DURAZNO	\N
129	54	4332	BOUWER	\N
129	54	4333	DUARTE QUIROS	\N
129	54	4334	MONTE RALO	\N
129	54	4335	RAFAEL GARCIA	\N
129	54	4336	SAN ANTONIO NORTE	\N
129	54	4337	DESPEÑADEROS	\N
129	54	4338	BARRIO DEAN FUNES	\N
129	54	4339	TOLEDO	\N
129	54	4340	ALTA GRACIA	\N
129	54	4341	ESTANCIA LA PUNTA DEL AGUA	\N
129	54	4342	LA ISLA	\N
129	54	4343	LA ISOLINA	\N
129	54	4344	LA PAISANITA	\N
129	54	4345	POTRERO DE TUTZER	\N
129	54	4346	VILLA CARLOS PELLEGRINI	\N
129	54	4347	VILLA LOS AROMOS	\N
129	54	4348	GOLPE DE AGUA	\N
129	54	4349	LA FALDA DEL CARMEN	\N
129	54	4350	LA GRANADILLA	\N
129	54	4351	LOS PARAISOS	\N
129	54	4352	SAN CLEMENTE	\N
129	54	4353	COLONIA SAN ISIDRO	\N
129	54	4354	JOSE DE LA QUINTANA	\N
129	54	4355	LA BETANIA	\N
129	54	4356	LA SERRANITA	\N
129	54	4357	OBREGON	\N
129	54	4358	POTRERO DE FUNES	\N
129	54	4359	POTRERO DE GARAY	\N
129	54	4360	SANTA RITA (JOSE DE LA QUINTANA)	\N
129	54	4361	VILLA ANIZACATE	\N
129	54	4362	VILLA EL DESCANSO	\N
129	54	4363	VILLA LA BOLSA	\N
129	54	4364	VILLA LA RANCHERITA	\N
129	54	4365	VILLA LOMAS DE ANIZACATE	\N
129	54	4366	VILLA SAN ISIDRO	\N
129	54	4367	VILLA SATITE	\N
129	54	4368	VILLA CIUDAD DE AMERICA	\N
129	54	4369	DIQUE LOS MOLINOS	\N
129	54	4370	COLONIA SANTA CATALINA	\N
129	54	4371	LA ACEQUIECITA	\N
129	54	4372	VILLA PARQUE SANTA ANA	\N
129	54	4373	CABALANGO	\N
129	54	4374	BOWER	\N
129	54	4375	FALDA DEL CAÑETE	\N
129	54	4376	CALASUYA	\N
129	54	4377	CHUÑA HUASI	\N
129	54	4378	EL PERTIGO	\N
129	54	4379	EL RODEITO	\N
129	54	4380	LA ZANJA	\N
129	54	4381	LAS AGUADITAS	\N
129	54	4382	TOTORILLA	\N
129	54	4383	AGUADA DEL MONTE	\N
129	54	4384	AGUADITA	\N
129	54	4385	BORDO DE LOS ESPINOSA	\N
129	54	4386	CACHI YACO	\N
129	54	4387	CAMPO ALEGRE	\N
129	54	4388	CASPICHUMA	\N
129	54	4389	CASPICUCHANA	\N
129	54	4390	GRACIELA	\N
129	54	4391	INVERNADA	\N
129	54	4392	JARILLAS	\N
129	54	4393	JUME	\N
129	54	4394	LA ESPERANZA	\N
129	54	4395	LA QUINTA	\N
129	54	4396	LA TOTORILLA	\N
129	54	4397	LAS JARILLAS	\N
129	54	4398	LOMA BLANCA	\N
129	54	4399	LOMITAS	\N
129	54	4400	LOS BORDOS	\N
129	54	4401	LOS CERRILLOS	\N
129	54	4402	MAJADILLA	\N
129	54	4403	MANANTIALES	\N
129	54	4404	MOVADO	\N
129	54	4405	NAVARRO	\N
129	54	4406	POZO DEL TIGRE	\N
129	54	4407	PUESTO NUEVO	\N
129	54	4408	RODEITO	\N
129	54	4409	SAN FRANCISCO DEL CHAÑAR	\N
129	54	4410	SAN LUIS	\N
129	54	4411	SAN PABLO	\N
129	54	4412	SANTA ANA	\N
129	54	4413	SANTA MARIA DE SOBREMONTE	\N
129	54	4414	SANTO DOMINGO	\N
129	54	4415	SOCORRO	\N
129	54	4416	CAMINIAGA	\N
129	54	4417	CHACRAS DEL SAUCE	\N
129	54	4418	EL PANTANO	\N
129	54	4419	LA PLAZA	\N
129	54	4420	COLONIA LUQUE	\N
129	54	4421	FABRICA MILITAR RIO TERCERO	\N
129	54	4422	LOS POTREROS	\N
129	54	4423	RIO TERCERO	\N
129	54	4424	CORRALITO	\N
129	54	4425	ALMAFUERTE	\N
129	54	4426	EL SALTO NORTE	\N
129	54	4427	SALTO NORTE	\N
129	54	4428	LOS ZORROS	\N
129	54	4429	DALMACIO VELEZ SARSFIELD	\N
129	54	4430	LAS PERDICES	\N
129	54	4431	HERNANDO	\N
129	54	4432	LAS ISLETILLAS	\N
129	54	4433	MONTE DEL FRAYLE	\N
129	54	4434	PAMPAYASTA	\N
129	54	4435	PAMPAYASTA NORTE	\N
129	54	4436	PAMPAYASTA SUD	\N
129	54	4437	PUNTA DEL AGUA (DPTO. TERCERO ARRIBA)	\N
129	54	4438	COLONIA HAMBURGO	\N
129	54	4439	COLONIA LA PRIMAVERA	\N
129	54	4440	COLONIA SANTA MARGARITA	\N
129	54	4441	EL PORTEÑO	\N
129	54	4442	GENERAL FOTHERINGHAM	\N
129	54	4443	TANCACHA	\N
129	54	4444	VILLA ASCASUBI	\N
129	54	4445	OLIVA	\N
129	54	4446	JAMES CRAIK	\N
129	54	4447	CAMPO ROSSIANO	\N
129	54	4448	COLONIA ALMADA	\N
129	54	4449	COLONIA GARZON	\N
129	54	4450	LA PAMPA	\N
129	54	4451	LA PAZ (ASCOCHINGA-DPTO. TOTORAL)	\N
129	54	4452	SAN JORGE	\N
129	54	4453	SAN MIGUEL (SAN JORGE-DPTO. TOTORAL)	\N
129	54	4454	LA AGUADA (MACHA-DPTO. TOTORAL)	\N
129	54	4455	MACHA	\N
129	54	4456	SARMIENTO	\N
129	54	4457	SINSACATE	\N
129	54	4458	AGUA DE LAS PIEDRAS	\N
129	54	4459	CAÑADA DE JUME	\N
129	54	4460	CABINDO	\N
129	54	4461	CAMPO LA PIEDRA	\N
129	54	4462	CANDELARIA (TOTORAL)	\N
129	54	4463	CORRAL DE BARRANCA	\N
129	54	4464	CRUZ DEL QUEMADO	\N
129	54	4465	DOCTOR NICASIO SALAS OROÑO	\N
129	54	4466	ESPINILLO (CAÑADA DE JUME-DPTO. TOTORAL)	\N
129	54	4467	LA PORTEÑA	\N
129	54	4468	LOS COMETIERRA	\N
129	54	4469	POZO CONCA	\N
129	54	4470	POZO CORREA	\N
129	54	4471	QUISCASACATE	\N
129	54	4472	RIO DE LOS SAUCES (CAÑADA DE RIO PINTO-DPTO. ISCHILIN)	\N
129	54	4473	SAN LORENZO (SANTA CATALINA-DPTO. TOTORAL)	\N
129	54	4474	SAN PELLEGRINO	\N
129	54	4475	SANTA CATALINA (DPTO. TOTORAL)	\N
129	54	4476	SANTA SABINA (SANTA CATALINA-DPTO. TOTORAL)	\N
129	54	4477	CAÑADA DE LUQUE	\N
129	54	4478	CABEZA DE BUEY	\N
129	54	4479	CAMPO ALVAREZ	\N
129	54	4480	EL BOSQUE	\N
129	54	4481	ESTANCIA BOTTARO	\N
129	54	4482	ESTANCIA EL TACO	\N
129	54	4483	ESTANCIA LAS MERCEDES	\N
129	54	4484	ESTANCIA LAS ROSAS	\N
129	54	4485	KM 364 TINTIZACO (APEADERO FCGB)	\N
129	54	4486	LA DORA	\N
129	54	4487	LOS MISTOLES (DPTO. TOTORAL)	\N
129	54	4488	SANTA LUCIA	\N
129	54	4489	TINTIZACO (KILOMETRO 364)	\N
129	54	4490	CAPILLA DE SITON	\N
129	54	4491	EL RINCON (CAPILLA DE SITON-DPTO. TOTORAL)	\N
129	54	4492	SITON	\N
129	54	4493	CAMPO DE LAS PIEDRAS	\N
129	54	4494	CASAS VIEJAS (VILLA DEL TOTORAL-DPTO. TOTORAL)	\N
129	54	4495	EL CRESTON DE PIEDRA	\N
129	54	4496	EL PEDACITO	\N
129	54	4497	EL TALITA (VILLA GRAL. MITRE-DPTO. TOTORAL)	\N
129	54	4498	HARAS SAN ANTONIO	\N
129	54	4499	LAS BANDURRIAS	\N
129	54	4500	PUESTO DEL ROSARIO (VILLA DEL TOTORAL-DPTO. TOTORAL)	\N
129	54	4501	SAN ANTONIO DE BELLA VISTA	\N
129	54	4502	SANTA MARIA (VILLA DEL TOTORAL-DPTO. TOTORAL)	\N
129	54	4503	VILLA DEL TOTORAL	\N
129	54	4504	VILLA GRAL. MITRE	\N
129	54	4505	CANTERAS LOS MORALES	\N
129	54	4506	KM 394 (APEADERO FCGB)	\N
129	54	4507	LAS PEÑAS (DPTO. TOTORAL)	\N
129	54	4508	CHACRAS VIEJAS	\N
129	54	4509	PUESTO SAN JOSE	\N
129	54	4510	SAN JOSE (SIMBOLAR-DPTO. TOTORAL)	\N
129	54	4511	SIMBOLAR (DPTO. TOTORAL)	\N
129	54	4512	SANTA CRUZ	\N
129	54	4513	ALTO DE FLORES	\N
129	54	4514	EL OJO DE AGUA	\N
129	54	4515	EL PASO	\N
129	54	4516	ITI HUASI	\N
129	54	4517	LAS JUNTAS	\N
129	54	4518	MAJADILLA (TULUMBA)	\N
129	54	4519	RIO GRANDE	\N
129	54	4520	SANTA GERTRUDIS	\N
129	54	4521	SIERRAS	\N
129	54	4522	TULUMBA	\N
129	54	4523	ALTO VERDE	\N
129	54	4524	CAMARONES	\N
129	54	4525	EL CAMARON	\N
129	54	4526	EL CERRITO	\N
129	54	4527	EL ROSARIO	\N
129	54	4528	LA LAGUNA	\N
129	54	4529	SAN PEDRO NORTE	\N
129	54	4530	SEVILLA	\N
129	54	4531	ISLA DE SAN ANTONIO	\N
129	54	4532	ACOLLARADO	\N
129	54	4533	AGUA HEDIONDA	\N
129	54	4534	ARBOL BLANCO	\N
129	54	4535	EL TUSCAL	\N
129	54	4536	LUCIO V. MANSILLA	\N
129	54	4537	SAN JOSE DE LAS SALINAS	\N
129	54	4538	TOTORALEJOS	\N
129	54	4539	TUSCAL	\N
129	54	4540	EL VENCE	\N
129	54	4541	LAS AROMAS	\N
129	54	4542	LAS ARRIAS	\N
129	54	4543	LAS MASITAS	\N
129	54	4544	PROVIDENCIA	\N
129	54	4545	VILLA ROSARIO DEL SALADILLO	\N
129	54	4546	AGUA DEL TALA	\N
129	54	4547	BEUCE	\N
129	54	4548	CHIPITIN	\N
129	54	4549	DURAZNO	\N
129	54	4550	EL DESMONTE	\N
129	54	4551	EL GUINDO	\N
129	54	4552	EL SEBIL	\N
129	54	4553	ESTANCIA EL NACIONAL	\N
129	54	4554	GUALLASCATE	\N
129	54	4555	LAGUNA BRAVA	\N
129	54	4556	LAGUNA DE GOMEZ	\N
129	54	4557	LAS HORQUETAS	\N
129	54	4558	LAS QUINTAS	\N
129	54	4559	LOMA DE PIEDRA	\N
129	54	4560	LOS ALAMOS	\N
129	54	4561	MIRAFLORES	\N
129	54	4562	PISCO HUASI	\N
129	54	4563	POZO SOLO	\N
129	54	4564	PUESTO VIEJO	\N
129	54	4565	SAN GABRIEL	\N
129	54	4566	SAN JOSE DE LA DORMIDA	\N
129	54	4567	AGUADA ROJAS	\N
129	54	4568	CHURQUI CAÑADA	\N
129	54	4569	LADERA YACUS	\N
129	54	4570	RODEO	\N
129	54	4571	ROJAS	\N
129	54	4572	LA DORMIDA	\N
129	54	4573	BELL VILLE	\N
129	54	4574	CUATRO CAMINOS	\N
129	54	4575	EL CARMEN	\N
129	54	4576	ESTACION BELL VILLE	\N
129	54	4577	SAN VICENTE	\N
129	54	4578	JUSTINIANO POSSE	\N
129	54	4579	CAMPO GRAL. PAZ	\N
129	54	4580	ORDOÑEZ	\N
129	54	4581	PUEBLO VIEJO	\N
129	54	4582	IDIAZABAL	\N
129	54	4583	CAPILLA DE SAN ANTONIO	\N
129	54	4584	CINTRA	\N
129	54	4585	COLONIA LA LEONCITA	\N
129	54	4586	COLONIA MASCHI	\N
129	54	4587	EL PARAISO	\N
129	54	4588	ISLETA NEGRA	\N
129	54	4589	LAS OVERIAS	\N
129	54	4590	LAS PALMERAS	\N
129	54	4591	LOS TASIS	\N
129	54	4592	LOS UCLES	\N
129	54	4593	SAN ANTONIO DE LITIN	\N
129	54	4594	SAN PEDRO	\N
129	54	4595	CHILIBROSTE	\N
129	54	4596	COLONIA SAN EUSEBIO	\N
129	54	4597	LOS MOLLES	\N
129	54	4598	SAN EUSEBIO	\N
129	54	4599	SANTA CECILIA	\N
129	54	4600	EL OVERO	\N
129	54	4601	LA CAJUELA	\N
129	54	4602	MONTE CASTILLO	\N
129	54	4603	NOETINGER	\N
129	54	4604	SAN JOSE	\N
129	54	4605	MONTE LEÑA	\N
129	54	4606	SAN MARCOS	\N
129	54	4607	SAN MARCOS SUD	\N
129	54	4608	LAS LAGUNITAS	\N
129	54	4609	MORRISON	\N
129	54	4610	BALLESTEROS	\N
129	54	4611	BALLESTEROS SUD	\N
129	54	4612	EL TRIANGULO	\N
129	54	4613	LAS MERCEDITAS	\N
129	54	4614	SAN CARLOS	\N
129	54	4615	CANALS	\N
129	54	4616	COLONIA LA LOLA	\N
129	54	4617	ALDEA SANTA MARIA	\N
129	54	4618	COLONIA BISMARCK	\N
129	54	4619	COLONIA BREMEN	\N
129	54	4620	COLONIA EL DORADO	\N
129	54	4621	EL DORADO	\N
129	54	4622	EL PORVENIR	\N
129	54	4623	GENERAL VIAMONTE	\N
129	54	4624	LA ITALIANA	\N
129	54	4625	PUEBLO ITALIANO	\N
129	54	4626	WENCESLAO ESCALANTE	\N
129	54	4627	LABORDE	\N
129	54	4628	MATACOS	\N
129	54	4629	MONTE MAIZ	\N
129	54	4630	BENJAMIN GOULD	\N
129	54	4631	SAN MELITON	\N
129	54	4632	VIAMONTE	\N
129	54	4633	CAMPO SOL DE MAYO	\N
129	54	4634	PASCANAS	\N
129	54	4635	ANA ZUMARAN	\N
129	54	4636	ALTO ALEGRE)	\N
129	54	4637	CORRAL DEL BAJO	\N
129	54	4638	SANTA ROSA	\N
129	54	4639	LA TIGRA	\N
129	54	4640	EL FLORENTINO	\N
129	54	4641	LA ROSARINA	\N
129	54	4642	OVERA NEGRA	\N
130	54	4643	BELLA VISTA	\N
130	54	4644	CARRIZAL	\N
130	54	4645	CEBOLLAS	\N
130	54	4646	EL TORO PI	\N
130	54	4647	ESTACION AGRONOMICA	\N
130	54	4648	LAS GARZAS	\N
130	54	4649	LOMAS	\N
130	54	4650	LOMAS ESTE	\N
130	54	4651	MACEDO	\N
130	54	4652	VILLA ROLLET	\N
130	54	4653	YAGUA RINCON	\N
130	54	4654	CARRIZAL NORTE	\N
130	54	4655	COLONIA PROGRESO	\N
130	54	4656	COLONIA TRES DE ABRIL	\N
130	54	4657	RAICES	\N
130	54	4658	DESMOCHADO	\N
130	54	4659	ISLA ALTA	\N
130	54	4660	JUAN DIAZ	\N
130	54	4661	YAHAPE	\N
130	54	4662	COLONIA NUEVA VALENCIA	\N
130	54	4663	ARERUNGUA	\N
130	54	4664	BERON DE ASTRADA	\N
130	54	4665	EL PALMAR	\N
130	54	4666	MARTINEZ CUE	\N
130	54	4667	PASO POTRERO	\N
130	54	4668	TORO PICHAY	\N
130	54	4669	CORRIENTES	\N
130	54	4670	PARQUE SAN MARTIN	\N
130	54	4671	VILLA JUAN DE VERA	\N
130	54	4672	LAGUNA BRAVA	\N
130	54	4673	LAGUNA PAIVA	\N
130	54	4674	LAGUNA SOTO	\N
130	54	4675	PAMPIN	\N
130	54	4676	PASO LOVERA	\N
130	54	4677	PASO PESOA	\N
130	54	4678	SAN CAYETANO	\N
130	54	4679	VILLA SOLARI	\N
130	54	4680	CARABAJAL ESTE	\N
130	54	4681	COLONIA ARROCERA	\N
130	54	4682	GARRIDO CUE	\N
130	54	4683	MATADERO SANTA CATALINA	\N
130	54	4684	RIACHUELO	\N
130	54	4685	RIACHUELO SUD	\N
130	54	4686	RINCON DEL SOMBRERO	\N
130	54	4687	BAJO GUAZU	\N
130	54	4688	COLONIA DORA ELENA	\N
130	54	4689	COLONIA LUCERO	\N
130	54	4690	COLONIA SANTA ROSA	\N
130	54	4691	SAN NICOLAS	\N
130	54	4692	SANTA ROSA	\N
130	54	4693	TABAY	\N
130	54	4694	TATACUA	\N
130	54	4695	ARAÑITA	\N
130	54	4696	CAPILLA CUE	\N
130	54	4697	CARAMBOLA	\N
130	54	4698	COLONIA LA HABANA	\N
130	54	4699	CONCEPCION	\N
130	54	4700	COSTA DEL BATEL	\N
130	54	4701	EL BUEN RETIRO	\N
130	54	4702	EL PORVENIR	\N
130	54	4703	EL YUQUERI	\N
130	54	4704	LA ANGELITA	\N
130	54	4705	LA AURORA	\N
130	54	4706	LA PEPITA	\N
130	54	4707	LOS ANGELES	\N
130	54	4708	LUJAMBIO	\N
130	54	4709	MONTEVIDEO	\N
130	54	4710	NUEVO PORVENIR	\N
130	54	4711	PALMAR	\N
130	54	4712	PASO IRIBU CUE	\N
130	54	4713	PORVENIR	\N
130	54	4714	SAN NICANOR	\N
130	54	4715	TAJIBO	\N
130	54	4716	TALITA CUE	\N
130	54	4717	TARTAGUITO	\N
130	54	4718	VIRGEN MARIA	\N
130	54	4719	YAGUARU	\N
130	54	4720	LOMA ALTA	\N
130	54	4721	EL CARMEN	\N
130	54	4722	SAN ANTONIO DEL CAIMAN	\N
130	54	4723	COLONIA BASUALDO	\N
130	54	4724	COLONIA PAIRIRI	\N
130	54	4725	COSTA ARROYO GARAY	\N
130	54	4726	PARAJE PORTILLO	\N
130	54	4727	PEDRO DIAZ COLODRERO	\N
130	54	4728	RINCON DE TUNAS	\N
130	54	4729	ARROYO CASTILLO	\N
130	54	4730	CASILLAS	\N
130	54	4731	CURUZU CUATIA	\N
130	54	4732	ESPINILLO	\N
130	54	4733	LOBORY	\N
130	54	4734	PASO ANCHO	\N
130	54	4735	PASO DE LAS PIEDRAS	\N
130	54	4736	TIERRA COLORADA	\N
130	54	4737	TUNITAS	\N
130	54	4738	VACA CUA	\N
130	54	4739	ABO NEZU	\N
130	54	4740	AGUAY	\N
130	54	4741	COLONIA CHIRCAL	\N
130	54	4742	EL CERRO	\N
130	54	4743	LA FLORENTINA	\N
130	54	4744	LA FORTUNA	\N
130	54	4745	LAS LOMAS	\N
130	54	4746	LOS TRES AMIGOS	\N
130	54	4747	NINA	\N
130	54	4748	NUEVA GRANADA	\N
130	54	4749	PERUGORRIA	\N
130	54	4750	PUENTE AVALOS	\N
130	54	4751	TALA PASO	\N
130	54	4752	ARROYO CASCO	\N
130	54	4753	CAZADORES CORRENTINOS	\N
130	54	4754	EMILIO R. CONI	\N
130	54	4755	PAGO LARGO	\N
130	54	4756	ABALO	\N
130	54	4757	ABELI	\N
130	54	4758	BAIBIENE	\N
130	54	4759	EL LOTO	\N
130	54	4760	IBAVIYU	\N
130	54	4761	LA LEONTINA	\N
130	54	4762	LAS VIOLETAS	\N
130	54	4763	SAN CELESTINO	\N
130	54	4764	ARROYO SOLIS	\N
130	54	4765	EL POLLO	\N
130	54	4766	VILLA SAN ISIDRO	\N
130	54	4767	COSTA DE EMPEDRADO	\N
130	54	4768	EL SOMBRERO	\N
130	54	4769	MANUEL DERQUI	\N
130	54	4770	PUEBLITO SAN JUAN	\N
130	54	4771	SECCION PRIMERA SAN JUAN	\N
130	54	4772	BARTOLOME MITRE	\N
130	54	4773	BERNACHEA	\N
130	54	4774	EMPEDRADO	\N
130	54	4775	LOMAS DE EMPEDRADO	\N
130	54	4776	MANSION DE INVIERNO	\N
130	54	4777	OCANTO CUE	\N
130	54	4778	VILLA SAN JUAN	\N
130	54	4779	RAMONES	\N
130	54	4780	ARROYO SARANDI	\N
130	54	4781	ARROYO SORO	\N
130	54	4782	GUAYQUIRARO	\N
130	54	4783	RINCON GUAYQUIRARO	\N
130	54	4784	TRES BOCAS	\N
130	54	4785	ARROYO VEGA	\N
130	54	4786	BUENA VISTA	\N
130	54	4787	CAMPO BORDON	\N
130	54	4788	CAMPO CAFFERATA	\N
130	54	4789	CAMPO DE CARLOS	\N
130	54	4790	CAMPO MORATO	\N
130	54	4791	CAMPO ROMERO	\N
130	54	4792	CAMPO SAN JACINTO	\N
130	54	4793	CHACRAS NORTE	\N
130	54	4794	CHACRAS SUD	\N
130	54	4795	EL PARQUE	\N
130	54	4796	ESQUINA	\N
130	54	4797	JESUS MARIA	\N
130	54	4798	LA AMISTAD	\N
130	54	4799	LA EMILIA	\N
130	54	4800	LA ISABEL	\N
130	54	4801	LA MOROCHA	\N
130	54	4802	LIBERTAD	\N
130	54	4803	LOS FLOTADORES	\N
130	54	4804	MALEZAL	\N
130	54	4805	OMBU SOLO	\N
130	54	4806	SAN GUSTAVO	\N
130	54	4807	SAN JACINTO	\N
130	54	4808	SANTA CECILIA	\N
130	54	4809	SANTA LIBRADA	\N
130	54	4810	VILLA CRISTIA	\N
130	54	4811	ABRA GUAZU	\N
130	54	4812	ARROYO SATURNO	\N
130	54	4813	BORANZA	\N
130	54	4814	COLONIA BERON DE ASTRADA	\N
130	54	4815	CORONEL ABRAHAM SCHWEIZER	\N
130	54	4816	EL COQUITO	\N
130	54	4817	EL YAPU	\N
130	54	4818	ESTERO GRANDE	\N
130	54	4819	ESTERO SAUCE	\N
130	54	4820	ESTERO YATAY	\N
130	54	4821	LA FLORENCIA	\N
130	54	4822	LA NENA	\N
130	54	4823	LA PALMERA	\N
130	54	4824	LIBERTADOR	\N
130	54	4825	LOS ALGARROBOS	\N
130	54	4826	LOS MEDIOS	\N
130	54	4827	LOS PARAISOS	\N
130	54	4828	PARAJE POTON	\N
130	54	4829	PASO ALGARROBO	\N
130	54	4830	PASO CEJAS	\N
130	54	4831	RINCON DE SARANDY	\N
130	54	4832	TORO CHIPAY	\N
130	54	4833	MALVINAS	\N
130	54	4834	MALVINAS CENTRO	\N
130	54	4835	PARAJE EL CARMEN	\N
130	54	4836	LAS CUCHILLAS	\N
130	54	4837	ALTAMIRA	\N
130	54	4838	ALVEAR	\N
130	54	4839	ARROYO MENDEZ	\N
130	54	4840	CAMBARA	\N
130	54	4841	CONCEPCION	\N
130	54	4842	CUAY CHICO	\N
130	54	4843	EL PARAISO	\N
130	54	4844	ESFADAL	\N
130	54	4845	ESPINILLAR	\N
130	54	4846	LA BLANQUEADA	\N
130	54	4847	LA CHIQUITA	\N
130	54	4848	LA ELSA	\N
130	54	4849	LA ELVA	\N
130	54	4850	LA LOMA	\N
130	54	4851	LA MAGNOLIA	\N
130	54	4852	LAS MERCEDES	\N
130	54	4853	LAS PALMAS	\N
130	54	4854	LAS PALMITAS	\N
130	54	4855	LOS ARBOLES	\N
130	54	4856	MALEZAL	\N
130	54	4857	MIRA FLORES	\N
130	54	4858	MORICA	\N
130	54	4859	PANCHO CUE	\N
130	54	4860	PIRACU	\N
130	54	4861	PIRAYU	\N
130	54	4862	TAMBO NUEVO	\N
130	54	4863	TINGUI	\N
130	54	4864	TORRENT	\N
130	54	4865	TRES CAPONES	\N
130	54	4866	CERRITO	\N
130	54	4867	COLONIA JUAN PUJOL	\N
130	54	4868	COSTA SANTA LUCIA	\N
130	54	4869	FRONTERA	\N
130	54	4870	LOMAS DE VALLEJOS	\N
130	54	4871	LOMAS DE VERGARA	\N
130	54	4872	LOMAS RAMIREZ	\N
130	54	4873	LOMAS VAZQUEZ	\N
130	54	4874	LOS VENCES	\N
130	54	4875	MALOYITA	\N
130	54	4876	NARANJATY	\N
130	54	4877	OBRAJE CUE	\N
130	54	4878	OMBU LOMAS	\N
130	54	4879	PALMAR GRANDE	\N
130	54	4880	PUISOYE	\N
130	54	4881	PUNTA GRANDE (PALMAR GRANDE-DPTO. GRAL. PAZ)	\N
130	54	4882	RINCON ZALAZAR	\N
130	54	4883	RODEITO	\N
130	54	4884	SALDAÑA	\N
130	54	4885	TACUARAL	\N
130	54	4886	TALATY	\N
130	54	4887	TOLATU	\N
130	54	4888	VERGARA	\N
130	54	4889	VERGARA LOMAS	\N
130	54	4890	ZAPALLAR	\N
130	54	4891	AGUAY	\N
130	54	4892	ALGARROBALES	\N
130	54	4893	ALTAMORA PARADA	\N
130	54	4894	AYALA CUE	\N
130	54	4895	CAA CATI	\N
130	54	4896	CAPILLITA	\N
130	54	4897	CHIRCAL	\N
130	54	4898	COLONIA AMADEI	\N
130	54	4899	COLONIA DANUZZO	\N
130	54	4900	COLONIA FLORENCIA	\N
130	54	4901	COLONIA SAN MARTIN	\N
130	54	4902	COLONIA TACUARALITO	\N
130	54	4903	COSTAS	\N
130	54	4904	EL SALVADOR	\N
130	54	4905	FLORENCIA	\N
130	54	4906	GENERAL PAZ	\N
130	54	4907	LA JAULA	\N
130	54	4908	LOMAS REDONDAS	\N
130	54	4909	NUESTRA SEÑORA DEL ROSARIO DE CAA CATI	\N
130	54	4910	PASO FLORENTIN	\N
130	54	4911	PASO GALLEGO	\N
130	54	4912	PASO SALDAÑA	\N
130	54	4913	ROMERO	\N
130	54	4914	ROSADITO	\N
130	54	4915	TIMBO CORA	\N
130	54	4916	VILLA SAN RAMON	\N
130	54	4917	ZAPALLOS	\N
130	54	4918	ALGARROBAL	\N
130	54	4919	BLANCO CUE	\N
130	54	4920	COLONIA BRANCHI	\N
130	54	4921	IBAHAY	\N
130	54	4922	ITA-IBATE	\N
130	54	4923	LA LOMA	\N
130	54	4924	PARAJE BARRANQUITAS	\N
130	54	4925	PUESTO LATA	\N
130	54	4926	SANTA ISABEL	\N
130	54	4927	TILITA	\N
130	54	4928	ANGOSTURA	\N
130	54	4929	COLONIA ROMERO	\N
130	54	4930	TACUARACARENDY	\N
130	54	4931	PEHUAHO	\N
130	54	4932	ALAMO	\N
130	54	4933	ARROYO CARANCHO	\N
130	54	4934	CAMPO ARAUJO	\N
130	54	4935	CAMPO ESCALADA	\N
130	54	4936	MERCEDES COSSIO	\N
130	54	4937	COLONIA PUCHETA	\N
130	54	4938	COLONIA ROLON COSSIO	\N
130	54	4939	CORONA	\N
130	54	4940	CURTIEMBRE	\N
130	54	4941	GOYA	\N
130	54	4942	GRANJA AMELIA	\N
130	54	4943	ISLA SOLA	\N
130	54	4944	LAGUNA PUCU	\N
130	54	4945	MARUCHITAS	\N
130	54	4946	RINCON DE GOMEZ	\N
130	54	4947	ROLON JACINTO	\N
130	54	4948	SAN DIONISIO	\N
130	54	4949	SANTILLAN	\N
130	54	4950	TARTARIA	\N
130	54	4951	BATELITO	\N
130	54	4952	COLONIA CAROLINA	\N
130	54	4953	COLONIA LA CARMEN	\N
130	54	4954	COLONIA PORVENIR	\N
130	54	4955	MARUCHAS	\N
130	54	4956	PUERTO GOYA	\N
130	54	4957	VILLA ROLON	\N
130	54	4958	ISABEL VICTORIA	\N
130	54	4959	MANCHITA	\N
130	54	4960	PUNTA IFRAN	\N
130	54	4961	BUENA ESPERANZA	\N
130	54	4962	BUENA VISTA	\N
130	54	4963	EL TATARE	\N
130	54	4964	EL TRANSITO	\N
130	54	4965	FANEGAS	\N
130	54	4966	INVERNADA	\N
130	54	4967	LA CARLINA	\N
130	54	4968	LA DIANA	\N
130	54	4969	LA ELVIRA	\N
130	54	4970	LOS CEIBOS	\N
130	54	4971	PAGO REDONDO	\N
130	54	4972	SAN ISIDRO	\N
130	54	4973	PASO BANDERA	\N
130	54	4974	PASO LOS ANGELES	\N
130	54	4975	PASO SAN JUAN	\N
130	54	4976	PUENTE MACHUCA	\N
130	54	4977	SAN ALEJO	\N
130	54	4978	SAN MANUEL	\N
130	54	4979	SAN MARCOS	\N
130	54	4980	CHILECITO	\N
130	54	4981	GUAYU	\N
130	54	4982	ISLA IBATE	\N
130	54	4983	PARAJE IRIBU CUA	\N
130	54	4984	RAMADA PASO	\N
130	54	4985	TUYUTI	\N
130	54	4986	YACAREY	\N
130	54	4987	ITATI	\N
130	54	4988	MBALGUIAPU	\N
130	54	4989	SAN FRANCISCO CUE	\N
130	54	4990	YAGUA ROCAU	\N
130	54	4991	RINCON ITAEMBE	\N
130	54	4992	SAN BORJITA	\N
130	54	4993	AGUARA CUA	\N
130	54	4994	APIPE GRANDE	\N
130	54	4995	CAMBIRETA	\N
130	54	4996	SAN ANTONIO	\N
130	54	4997	COLONIA URDANIZ	\N
130	54	4998	COSTA GUAZU	\N
130	54	4999	EL PLATA	\N
130	54	5000	GARCITAS	\N
130	54	5001	IBIRITANGAY	\N
130	54	5002	ISLA APIPE CHICO	\N
130	54	5003	ITUZAINGO	\N
130	54	5004	LA CELESTE	\N
130	54	5005	LA HILEORICA	\N
130	54	5006	LAS ANIMAS	\N
130	54	5007	LAS DELICIAS	\N
130	54	5008	LAS TRES HERMANAS	\N
130	54	5009	LOMA NEGRA	\N
130	54	5010	LOMA POY	\N
130	54	5011	LOS GEMELOS	\N
130	54	5012	LOS TRES HERMANOS	\N
130	54	5013	PUERTO UBAJAY	\N
130	54	5014	PUERTO VALLE	\N
130	54	5015	PUNTA MERCEDES	\N
130	54	5016	RINCON CHICO	\N
130	54	5017	RINCON DEL ROSARIO	\N
130	54	5018	SALINAS	\N
130	54	5019	SAN JERONIMO	\N
130	54	5020	SAN JOAQUIN	\N
130	54	5021	SAN JULIAN	\N
130	54	5022	SANGARA	\N
130	54	5023	SANTA TECLA	\N
130	54	5024	TRES ARBOLES	\N
130	54	5025	VIZCAINO	\N
130	54	5026	OJO DE AGUA	\N
130	54	5027	SAN CARLOS	\N
130	54	5028	COLONIA LIEBIG	\N
130	54	5029	DOS HERMANOS	\N
130	54	5030	ESTABLECIMIENTO LA MERCED	\N
130	54	5031	LA PUPII	\N
130	54	5032	PLAYADITO	\N
130	54	5033	VILLA OLIVARI	\N
130	54	5034	BARRIO VILLA CORDOBA	\N
130	54	5035	COLONIA CECILIO ECHEVARRIA	\N
130	54	5036	COLONIA LUJAN	\N
130	54	5037	COLONIA SAN EUGENIO	\N
130	54	5038	COLONIA SAN JOSE	\N
130	54	5039	CRUCECITAS	\N
130	54	5040	FERRO	\N
130	54	5041	LA PASTORIL	\N
130	54	5042	MONTE FLORIDO	\N
130	54	5043	NARANJITO	\N
130	54	5044	QUINTA TERESA	\N
130	54	5045	VILLA AQUINO	\N
130	54	5046	VILLA CORDOBA	\N
130	54	5047	CRUZ DE LOS MILAGROS	\N
130	54	5048	COLONIA MENDEZ BAR	\N
130	54	5049	LA BOLSA	\N
130	54	5050	LAVALLE	\N
130	54	5051	RINCON DE SOTO	\N
130	54	5052	SALADERO SAN ANTONIO	\N
130	54	5053	BATAL	\N
130	54	5054	BONETE	\N
130	54	5055	COLONIA VEDOYA	\N
130	54	5056	COSTA BATEL	\N
130	54	5057	GOBERNADOR MARTINEZ	\N
130	54	5058	LAGUNA SIRENA	\N
130	54	5059	LOS ANGELES DEL BATEL	\N
130	54	5060	PUENTE BATEL	\N
130	54	5061	PUERTA IFRAN	\N
130	54	5062	SANTA LUCIA	\N
130	54	5063	VEDOYA	\N
130	54	5064	YATAITI CALLE	\N
130	54	5065	ABRA	\N
130	54	5066	ARROYITO	\N
130	54	5067	BUENA VISTA	\N
130	54	5068	CAMPO CARDOZO	\N
130	54	5069	CAMPO FERNANDEZ	\N
130	54	5070	CARDOZO PHI	\N
130	54	5071	CHACRAS	\N
130	54	5072	CHAMORRO	\N
130	54	5073	COSTA	\N
130	54	5074	COSTA SAN LORENZO	\N
130	54	5075	EL PAGO	\N
130	54	5076	FRANCISCO GAUNA	\N
130	54	5077	KM 168	\N
130	54	5078	LA HERMINIA	\N
130	54	5079	MANANTIALES	\N
130	54	5080	MBURUCUYA	\N
130	54	5081	ORATORIO	\N
130	54	5082	PASITO	\N
130	54	5083	PASO AGUIRRE	\N
130	54	5084	POTRERO GRANDE	\N
130	54	5085	PUNTA GRANDE	\N
130	54	5086	SAN ANTONIO	\N
130	54	5087	SAN JUAN	\N
130	54	5088	SAN LORENZO	\N
130	54	5089	SANTA ANA	\N
130	54	5090	SANTA TERESA	\N
130	54	5091	ARBOL SOLO	\N
130	54	5092	BAYGORRIA	\N
130	54	5093	LA HAYDEE	\N
130	54	5094	CAPITAN JOAQUIN MADARIAGA	\N
130	54	5095	ARROYO GRANDE	\N
130	54	5096	CALLEJON	\N
130	54	5097	CAPI VARI	\N
130	54	5098	ITATI RINCON	\N
130	54	5099	LA BELERMINA	\N
130	54	5100	MERCEDES	\N
130	54	5101	PAY UBRE CHICO	\N
130	54	5102	YUQUERI	\N
130	54	5103	ALEN CUE	\N
130	54	5104	ALFONSO LOMAS	\N
130	54	5105	BOQUERON	\N
130	54	5106	EL CERRITO	\N
130	54	5107	EL PILAR	\N
130	54	5108	FELIPE YOFRE	\N
130	54	5109	LA CARLOTA	\N
130	54	5110	LAS ELINAS	\N
130	54	5111	LAS ROSAS	\N
130	54	5112	NARANJITO	\N
130	54	5113	PAIMBRE	\N
130	54	5114	PASO PUCHETA	\N
130	54	5115	SAN EDUARDO	\N
130	54	5116	TARANGULLO	\N
130	54	5117	EL REMANSO	\N
130	54	5118	JUSTINO SOLARI	\N
130	54	5119	LA AGRIPINA	\N
130	54	5120	MARIA DEL CARMEN	\N
130	54	5121	MARIA IDALINA	\N
130	54	5122	MARIANO I. LOZA	\N
130	54	5123	ARROYO MANGANGA	\N
130	54	5124	ARROYO TIMBOY	\N
130	54	5125	ARROYO TOTORAS	\N
130	54	5126	EL CHIRCAL	\N
130	54	5127	ESTE ARGENTINO	\N
130	54	5128	LA FLORIDA	\N
130	54	5129	MONTE CASEROS	\N
130	54	5130	TALLERES	\N
130	54	5131	VILLA LA FLORIDA	\N
130	54	5132	BUEN RETIRO	\N
130	54	5133	INDEPENDENCIA	\N
130	54	5134	JUAN PUJOL	\N
130	54	5135	MOTA	\N
130	54	5136	PARADA LABOUGLE	\N
130	54	5137	SAN FERMIN	\N
130	54	5138	SANTA MAGDALENA	\N
130	54	5139	TACUABE	\N
130	54	5140	TIMBOY	\N
130	54	5141	COLONIA LIBERTAD	\N
130	54	5142	ESTACION LIBERTAD	\N
130	54	5143	LA PALMA	\N
130	54	5144	LIBERTAD	\N
130	54	5145	SANTA LEA	\N
130	54	5146	SANTA MARTA	\N
130	54	5147	MOCORETA	\N
130	54	5148	PUERTO JUAN DE DIOS	\N
130	54	5149	SAN ANDRES	\N
130	54	5150	COLONIA ACUÑA	\N
130	54	5151	SIETE ARBOLES	\N
130	54	5152	EL PROGRESO	\N
130	54	5153	LA AMELIA	\N
130	54	5154	LA COLORADA	\N
130	54	5155	LA CONSTANCIA	\N
130	54	5156	LA ELENA	\N
130	54	5157	LA VERDE	\N
130	54	5158	LOS PINOS	\N
130	54	5159	MIRADOR	\N
130	54	5160	NUEVA PALMIRA	\N
130	54	5161	OMBUCITO	\N
130	54	5162	PASO DE LOS LIBRES	\N
130	54	5163	QUINTA SECCION OMBUCITO	\N
130	54	5164	QUIYATI	\N
130	54	5165	RECREO	\N
130	54	5166	REDUCCION	\N
130	54	5167	SAN FELIPE	\N
130	54	5168	SAN JOAQUIN	\N
130	54	5169	SAN PALADIO	\N
130	54	5170	TRES HOJAS	\N
130	54	5171	TRISTAN CHICO	\N
130	54	5172	MIRUNGA	\N
130	54	5173	CABRED	\N
130	54	5174	PARADA PUCHETA	\N
130	54	5175	SAN IGNACIO	\N
130	54	5176	SANTA EMILIA	\N
130	54	5177	TAPEBICUA	\N
130	54	5178	BONPLAND	\N
130	54	5179	PASO LEDESMA	\N
130	54	5180	SAN ANTONIO	\N
130	54	5181	SAN ROQUITO	\N
130	54	5182	SAN SALVADOR	\N
130	54	5183	SOSA	\N
130	54	5184	ARROYO CEIBAL	\N
130	54	5185	COSTA DE ARROYO SAN LORENZO	\N
130	54	5186	DOS OMBUES	\N
130	54	5187	REAL CUE	\N
130	54	5188	RINCON DE AMBROSIO	\N
130	54	5189	RINCON DE SAN LORENZO	\N
130	54	5190	SAN LORENZO	\N
130	54	5191	ANGUA	\N
130	54	5192	CARMAN	\N
130	54	5193	GUAZU CORA	\N
130	54	5194	JARDIN FLORIDO	\N
130	54	5195	LA QUERENCIA	\N
130	54	5196	LAGO ARIAS	\N
130	54	5197	LAURETTI	\N
130	54	5198	LOMAS SALADAS	\N
130	54	5199	LOS LIRIOS	\N
130	54	5200	MUCHAS ISLAS	\N
130	54	5201	PARAJE AUGUA	\N
130	54	5202	PASTORES	\N
130	54	5203	PINDONCITO	\N
130	54	5204	RINCON SAN PEDRO	\N
130	54	5205	SALADAS	\N
130	54	5206	SAN EMILIO	\N
130	54	5207	SOSA CUE	\N
130	54	5208	PINDO	\N
130	54	5209	PAGO ALEGRE	\N
130	54	5210	PAGO DE LOS DESEOS	\N
130	54	5211	ESTACION SALADAS	\N
130	54	5212	ARROYO PELON	\N
130	54	5213	COLONIA MARIA ESTHER	\N
130	54	5214	COLONIA MATILDE	\N
130	54	5215	COSTA RIO PARANA	\N
130	54	5216	EL PELON	\N
130	54	5217	INGENIO PRIMER CORRENTINO	\N
130	54	5218	ISLA IBATAY	\N
130	54	5219	JUAN RAMON VIDAL	\N
130	54	5220	SANTA ANA 	\N
130	54	5221	TALA CORA	\N
130	54	5222	DESAGUADERO	\N
130	54	5223	ARROYO SAN JUAN	\N
130	54	5224	COSTA TOLEDO	\N
130	54	5225	PASO DE LA PATRIA	\N
130	54	5226	PUERTO ARAZA	\N
130	54	5227	BEDOYA	\N
130	54	5228	CUARTA SECCION ENSENADA GRANDE	\N
130	54	5229	ENSENADA GRANDE	\N
130	54	5230	ENSENADITA	\N
130	54	5231	MANDINGA	\N
130	54	5232	SAN COSME	\N
130	54	5233	VILLAGA CUE	\N
130	54	5234	ARROYO PONTON	\N
130	54	5235	RALERA SUD	\N
130	54	5236	AGUIRRE CUE	\N
130	54	5237	AGUIRRE LOMAS	\N
130	54	5238	ALBARDONES	\N
130	54	5239	BARGONE	\N
130	54	5240	BREGAIN CUE	\N
130	54	5241	BRIGANIS	\N
130	54	5242	CAMPO GRANDE	\N
130	54	5243	CAVIA CUE	\N
130	54	5244	CERRUDO CUE	\N
130	54	5245	COLONIA LLANO	\N
130	54	5246	ESQUIVEL CUE	\N
130	54	5247	GARABATA	\N
130	54	5248	HERLITZKA	\N
130	54	5249	LA ELOISA	\N
130	54	5250	LAGUNA ALFONSO	\N
130	54	5251	LOMAS DE GALARZA	\N
130	54	5252	LOMAS DE GONZALEZ	\N
130	54	5253	LOMAS ESQUIVEL	\N
130	54	5254	MALOYA	\N
130	54	5255	MONTE GRANDE	\N
130	54	5256	PUEBLITO ESPINOSA	\N
130	54	5257	RIACHUELO BARDECI	\N
130	54	5258	RINCON DE LAS MERCEDES	\N
130	54	5259	SAN LUIS DEL PALMAR	\N
130	54	5260	SANTOS LUGARES	\N
130	54	5261	TIQUINO	\N
130	54	5262	TRES CRUCES	\N
130	54	5263	TRIPOLI	\N
130	54	5264	VECINDAD	\N
130	54	5265	LOMAS DE AGUIRRE	\N
130	54	5266	LOS MANANTIALES	\N
130	54	5267	SANTA ELISA	\N
130	54	5268	COLONIA AROCENA INA	\N
130	54	5269	YAPEYU	\N
130	54	5270	BACACAY	\N
130	54	5271	COSTA GUAVIRAVI	\N
130	54	5272	ESTINGANA	\N
130	54	5273	LA CRUZ	\N
130	54	5274	LOS TRES CERROS	\N
130	54	5275	YURUCUA	\N
130	54	5276	COLONIA CARLOS PELLEGRINI	\N
130	54	5277	OBRAJE DEL VASCO	\N
130	54	5278	CURUZU	\N
130	54	5279	LA UNION	\N
130	54	5280	CAIMAN	\N
130	54	5281	BARRANQUERAS	\N
130	54	5282	ARROYO BALMACEDA	\N
130	54	5283	BASTIDORES	\N
130	54	5284	CASUALIDAD	\N
130	54	5285	CATALAN CUE	\N
130	54	5286	INFANTE	\N
130	54	5287	LA ANGELA	\N
130	54	5288	LA PACHINA	\N
130	54	5289	LAPACHO	\N
130	54	5290	LOMAS SAN JUAN	\N
130	54	5291	LORETO	\N
130	54	5292	SAN SEBASTIAN	\N
130	54	5293	TIMBO PASO	\N
130	54	5294	YTA PASO	\N
130	54	5295	YUQUERI	\N
130	54	5296	CARANDAITI	\N
130	54	5297	CARRETA PASO	\N
130	54	5298	COLONIA CAIMAN	\N
130	54	5299	COLONIA EL CAIMAN	\N
130	54	5300	COLONIA LA UNION	\N
130	54	5301	COLONIA MADARIAGA	\N
130	54	5302	COLONIA SAN ANTONIO	\N
130	54	5303	CURUPAYTI	\N
130	54	5304	CURUZU LAUREL	\N
130	54	5305	IPACARAPA	\N
130	54	5306	LOS SAUCES	\N
130	54	5307	MBOI CUA	\N
130	54	5308	OMBU	\N
130	54	5309	PALMA SOLA	\N
130	54	5310	SAN MIGUEL	\N
130	54	5311	SAN NICOLAS	\N
130	54	5312	SANTA ISABEL	\N
130	54	5313	SILVERO CUE	\N
130	54	5314	TACUAREMBO	\N
130	54	5315	TAPE RATI	\N
130	54	5316	VERON CUE	\N
130	54	5317	YATAITI SATA	\N
130	54	5318	PASO LUCERO	\N
130	54	5319	9 DE JULIO	\N
130	54	5320	ARROYO GONZALEZ	\N
130	54	5321	ARROYO PAISO	\N
130	54	5322	BAJO GRANDE	\N
130	54	5323	BARRIO ALGARROBO	\N
130	54	5324	LA MATILDE	\N
130	54	5325	LAS MATRERAS	\N
130	54	5326	LEON CUA	\N
130	54	5327	LOMAS FLORIDAS	\N
130	54	5328	LUIS GOMEZ	\N
130	54	5329	PUEBLO DE JULIO	\N
130	54	5330	SALDANA	\N
130	54	5331	LA ARMONIA	\N
130	54	5332	LA LOLITA	\N
130	54	5333	LA LUISA	\N
130	54	5334	MANUEL FLORENCIO MANTILLA	\N
130	54	5335	PEDRO R. FERNANDEZ	\N
130	54	5336	SAN DIEGO	\N
130	54	5337	SANTA SINFOROSA	\N
130	54	5338	SANTIAGO ALCORTA	\N
130	54	5339	YACARE	\N
130	54	5340	CAAYOBAY	\N
130	54	5341	CARAYA	\N
130	54	5342	LAGUNA AVALOS	\N
130	54	5343	MATRERA	\N
130	54	5344	MOJON	\N
130	54	5345	PALMIRA	\N
130	54	5346	PIRRA PUY	\N
130	54	5347	ROLON CUE	\N
130	54	5348	ROSADO GRANDE	\N
130	54	5349	SAN ROQUE	\N
130	54	5350	TATACUA	\N
130	54	5351	TIMBO	\N
130	54	5352	YAZUCA	\N
130	54	5353	BOLICHE LATA	\N
130	54	5354	COLONIA PANDO	\N
130	54	5355	CHAVARRIA	\N
130	54	5356	ESTANCIA DEL MEDIO	\N
130	54	5357	ESTANCIA LAS SALINAS	\N
130	54	5358	LA CELINA	\N
130	54	5359	OSCURO	\N
130	54	5360	SAN GUILLERMO	\N
130	54	5361	SANTA IRENE	\N
130	54	5362	YATAY CORA	\N
130	54	5363	COLONIA LA ELISA	\N
130	54	5364	BOQUERON	\N
130	54	5365	CAMBAI	\N
130	54	5366	CASUALIDAD	\N
130	54	5367	COLONIA GOBERNADOR RUIZ	\N
130	54	5368	JOSE R. GOMEZ	\N
130	54	5369	COLONIA SAN MATEO	\N
130	54	5370	CUAY CHICO	\N
130	54	5371	DON MAXIMO	\N
130	54	5372	GALARZA CUE	\N
130	54	5373	GOBERNADOR RUIZ	\N
130	54	5374	GOMEZ CUE	\N
130	54	5375	ISLA SAN MATEO	\N
130	54	5376	ITA-CUA	\N
130	54	5377	LOS BRETES	\N
130	54	5378	NUEVO PARAISO	\N
130	54	5379	PUERTO HORMIGUERO	\N
130	54	5380	PUERTO LAS LAJAS	\N
130	54	5381	PUERTO PIEDRA	\N
130	54	5382	SAN ANTONIO	\N
130	54	5383	SAN FRANCISCO	\N
130	54	5384	SAN GABRIEL	\N
130	54	5385	SANTO TOME	\N
130	54	5386	TABLADA	\N
130	54	5387	TOPADOR	\N
130	54	5388	TRES TAPERAS	\N
130	54	5389	AGUAPEY	\N
130	54	5390	CAA GARAY	\N
130	54	5391	CAABY POY	\N
130	54	5392	CARABI POY	\N
130	54	5393	CAU GARAY	\N
130	54	5394	CAZA PAVA	\N
130	54	5395	COLONIA GARABI	\N
130	54	5396	CORONEL DESIDERIO SOSA	\N
130	54	5397	EL CARMEN	\N
130	54	5398	GOBERNADOR VALENTIN VIRASORO	\N
130	54	5399	IBERA	\N
130	54	5400	ISLA GRANDE	\N
130	54	5401	LA CRIOLLA	\N
130	54	5402	LAS RATAS	\N
130	54	5403	SAN ALONSO	\N
130	54	5404	SAN JUSTO	\N
130	54	5405	TAREIRI	\N
130	54	5406	VUELTA DEL OMBU	\N
130	54	5407	CUAY GRANDE	\N
130	54	5408	GARRUCHOS	\N
130	54	5409	RINCON DE MERCEDES	\N
130	54	5410	COLONIA UNION	\N
130	54	5411	ARROYO SECO	\N
130	54	5412	BARRANCAS	\N
130	54	5413	CAÑADITAS	\N
130	54	5414	FRANCISCO GOMEZ	\N
130	54	5415	LOS EUCALIPTOS 	\N
130	54	5416	SAN LUIS	\N
130	54	5417	SAUCE	\N
130	54	5418	LINDA VISTA	\N
130	54	5419	EL POÑI	\N
131	54	5420	CONCEPCION DEL BERMEJO	\N
131	54	5421	PAMPA BORRACHO	\N
131	54	5422	PAMPA DEL INFIERNO	\N
131	54	5423	PAMPA JUANITA	\N
131	54	5424	LOS FRENTONES	\N
131	54	5425	RIO MUERTO	\N
131	54	5426	AGUA BUENA	\N
131	54	5427	BOTIJA	\N
131	54	5428	LORENA	\N
131	54	5429	POZO HONDO	\N
131	54	5430	TACO POZO	\N
131	54	5431	ISLA DEL CERRITO	\N
131	54	5432	PUNTA DE RIELES	\N
131	54	5433	CABRAL CUE	\N
131	54	5434	CANCHA LARGA	\N
131	54	5435	COLONIA RIO DE ORO	\N
131	54	5436	EL LAPACHO	\N
131	54	5437	GUAYCURU	\N
131	54	5438	LA LEONESA	\N
131	54	5439	LAGUNA PATOS	\N
131	54	5440	LAPACHO	\N
131	54	5441	LAS PALMAS	\N
131	54	5442	LAS ROSAS	\N
131	54	5443	LOMA ALTA	\N
131	54	5444	PUERTO LAS PALMAS	\N
131	54	5445	QUIA	\N
131	54	5446	RANCHOS VIEJOS	\N
131	54	5447	RINCON DEL ZORRO	\N
131	54	5448	RIO DE ORO	\N
131	54	5449	SAN FERNANDO	\N
131	54	5450	TACUARI	\N
131	54	5451	EL RETIRO	\N
131	54	5452	FLORADORA	\N
131	54	5453	GENERAL VEDIA	\N
131	54	5454	LA MAGDALENA	\N
131	54	5455	SAN CARLOS	\N
131	54	5456	SAN EDUARDO	\N
131	54	5457	EL CAMPAMENTO	\N
131	54	5458	EL MIRASOL	\N
131	54	5459	LA POSTA	\N
131	54	5460	MIERES	\N
131	54	5461	PUERTO BERMEJO	\N
131	54	5462	SOLALINDE	\N
131	54	5463	TIMBO	\N
131	54	5464	GANDOLFI	\N
131	54	5465	PUERTO VELAZ	\N
131	54	5466	EL FISCAL	\N
131	54	5467	BARRIO SARMIENTO	\N
131	54	5468	COLONIA BAJO HONDO	\N
131	54	5469	PAMPA AGUADO	\N
131	54	5470	PAMPA ALEGRIA	\N
131	54	5471	PAMPA DE LOS LOCOS	\N
131	54	5472	PAMPA GALPON	\N
131	54	5473	PAMPA LOCA	\N
131	54	5474	PRESIDENCIA ROQUE SAENZ PEÑA	\N
131	54	5475	COLONIA BERNARDINO RIVADAVIA	\N
131	54	5476	PAMPA FLORIDA	\N
131	54	5477	CERRITO	\N
131	54	5478	CHARATA	\N
131	54	5479	COLONIA JUAN LARREA	\N
131	54	5480	COLONIA SCHMIDT	\N
131	54	5481	EL PUCA	\N
131	54	5482	GENERAL NECOCHEA	\N
131	54	5483	INDIA MUERTA	\N
131	54	5484	LOS GUALCOS	\N
131	54	5485	PAMPA BARRERA	\N
131	54	5486	PAMPA CABRERA	\N
131	54	5487	PAMPA SOMMER	\N
131	54	5488	SANTA ELVIRA	\N
131	54	5489	TRES ESTACAS	\N
131	54	5490	EL ZAPALLAR	\N
131	54	5491	MESON DE FIERRO	\N
131	54	5492	PAMPA LANDRIEL	\N
131	54	5493	COLONIA ABATE	\N
131	54	5494	COLONIA BRAVO	\N
131	54	5495	COLONIA ECONOMICA	\N
131	54	5496	COLONIA EL TRIANGULO	\N
131	54	5497	COLONIA HAMBURGUESA	\N
131	54	5498	COLONIA NECOCHEA SUD	\N
131	54	5499	COLONIA WELHERS	\N
131	54	5500	EL PALMAR	\N
131	54	5501	GENERAL CAPDEVILA	\N
131	54	5502	GENERAL PINEDO	\N
131	54	5503	LA ECONOMIA	\N
131	54	5504	MINISTRO RAMON GOMEZ	\N
131	54	5505	PALMAR NORTE	\N
131	54	5506	PINEDO CENTRAL	\N
131	54	5507	WELHERS	\N
131	54	5508	CAMPO MORENO	\N
131	54	5509	COLONIA DRYSDALE	\N
131	54	5510	COLONIA LA MARIA LUISA	\N
131	54	5511	COLONIA LA TOTA	\N
131	54	5512	EL CUADRADO	\N
131	54	5513	EL ESTERO	\N
131	54	5514	EL PORONGAL	\N
131	54	5515	EL PUMA	\N
131	54	5516	EL SALADILLO	\N
131	54	5517	GANCEDO	\N
131	54	5518	LOS FORTINES	\N
131	54	5519	LOS QUEBRACHITOS	\N
131	54	5520	QUEBRACHALES	\N
131	54	5521	VIBORAS	\N
131	54	5522	CABEZA DEL TIGRE	\N
131	54	5523	SANTA MARIA	\N
131	54	5524	SANTA SYLVINA	\N
131	54	5525	CAMPO EL JACARANDA	\N
131	54	5526	CHOROTIS	\N
131	54	5527	TRES MOJONES	\N
131	54	5528	VENADOS GRANDES	\N
131	54	5529	ZUBERBUHLER	\N
131	54	5530	AMAMBAY	\N
131	54	5531	CORZUELA	\N
131	54	5532	PUESTO CARRIZO	\N
131	54	5533	COLONIA JUAN PENCO	\N
131	54	5534	COLONIA MIXTA	\N
131	54	5535	EL OBRAJE	\N
131	54	5536	LA ELABORADORA	\N
131	54	5537	LA ESCONDIDA	\N
131	54	5538	LA VERDE	\N
131	54	5539	LAGUNA ESCONDIDA	\N
131	54	5540	LAPACHITO	\N
131	54	5541	MAKALLE	\N
131	54	5542	PUENTE PHILIPPON	\N
131	54	5543	PUENTE SVRITZ	\N
131	54	5544	VILLA RIO BERMEJITO	\N
131	54	5545	COLONIA JUAN JOSE CASTELLI	\N
131	54	5546	DIEZ DE MAYO	\N
131	54	5547	EL PINTADO	\N
131	54	5548	EL QUEBRACHAL	\N
131	54	5549	EL SAUZALITO	\N
131	54	5550	FUERTE ESPERANZA	\N
131	54	5551	JUAN JOSE CASTELLI	\N
131	54	5552	MANANTIALES	\N
131	54	5553	MIRAFLORES	\N
131	54	5554	NUEVA POBLACION	\N
131	54	5555	POZO DE LAS GARZAS	\N
131	54	5556	ZAPARINQUI	\N
131	54	5557	MISION NUEVA POMPEYA	\N
131	54	5558	EL COLCHON	\N
131	54	5559	POZO DEL SAPO	\N
131	54	5560	COMANDANCIA FRIAS	\N
131	54	5561	COLONIA JOSE MARMOL	\N
131	54	5562	AVIA TERAI	\N
131	54	5563	COLONIA MARIANO SARRATEA	\N
131	54	5564	EL CATORCE	\N
131	54	5565	LA MASCOTA	\N
131	54	5566	LOTE 34	\N
131	54	5567	NAPENAY	\N
131	54	5568	PAMPA DEL REGIMIENTO	\N
131	54	5569	CAMPO LARGO	\N
131	54	5570	COLONIA MALGRATTI	\N
131	54	5571	LAS CHUÑAS	\N
131	54	5572	LERO BLANCO	\N
131	54	5573	PAMPA OCULTA	\N
131	54	5574	COLONIA POPULAR	\N
131	54	5575	CORONEL AVALOS	\N
131	54	5576	LA EVANGELICA	\N
131	54	5577	LAGUNA BELIGAY	\N
131	54	5578	PUERTO BASTIANI	\N
131	54	5579	PUERTO TIROL	\N
131	54	5580	VILLA JALON	\N
131	54	5581	FORTIN CARDOSO	\N
131	54	5582	GENERAL OBLIGADO	\N
131	54	5583	LA CHOZA	\N
131	54	5584	CAMPO DE LA CHOZA	\N
131	54	5585	COLONIA ECHEGARAY	\N
131	54	5586	GENERAL DONOVAN	\N
131	54	5587	LAGUNA BLANCA	\N
131	54	5588	RIO ARAZA	\N
131	54	5589	LA EDUVIGES	\N
131	54	5590	PAMPA ALMIRON	\N
131	54	5591	GENERAL JOSE DE SAN MARTIN	\N
131	54	5592	PUERTO ZAPALLAR	\N
131	54	5593	VENEZUELA	\N
131	54	5594	COLONIA CNEL. DORREGO	\N
131	54	5595	COLONIA RODRIGUEZ PEÑA	\N
131	54	5596	LOS POZOS	\N
131	54	5597	PRESIDENCIA ROCA	\N
131	54	5598	CIERVO PETISO	\N
131	54	5599	LAGUNA LIMPIA	\N
131	54	5600	PAMPA DEL INDIO	\N
131	54	5601	ALELOY	\N
131	54	5602	COLONIA VELEZ SARSFIELD	\N
131	54	5603	EL BOQUERON	\N
131	54	5604	EL CUARENTA Y SEIS	\N
131	54	5605	EL TREINTA Y SEIS	\N
131	54	5606	LA POBLADORA	\N
131	54	5607	PAMPA AGUARA	\N
131	54	5608	PAMPA VARGA	\N
131	54	5609	TRES ISLETAS	\N
131	54	5610	AVANZADA	\N
131	54	5611	COLONIA JUAN JOSE PASO	\N
131	54	5612	COLONIA LOTE 10	\N
131	54	5613	COLONIA MATHEU	\N
131	54	5614	FORTIN POTRERO	\N
131	54	5615	LOS FORTINES	\N
131	54	5616	LOS GANSOS	\N
131	54	5617	LOTE 10	\N
131	54	5618	PUEBLO CLODOMIRO DIAZ	\N
131	54	5619	TUCURU	\N
131	54	5620	VILLA ANGELA	\N
131	54	5621	CORONEL DU GRATY	\N
131	54	5622	ENRIQUE URIEN	\N
131	54	5623	CAMPO ZAPA	\N
131	54	5624	COLONIA CUERO QUEMADO	\N
131	54	5625	COLONIA GRAL. NECOCHEA	\N
131	54	5626	COLONIA JUAN LAVALLE	\N
131	54	5627	EL CAJON	\N
131	54	5628	EL ORO BLANCO	\N
131	54	5629	EL TRIANGULO	\N
131	54	5630	LAS BREÑAS	\N
131	54	5631	LAS CUCHILLAS	\N
131	54	5632	LOS CERRITOS	\N
131	54	5633	LOS CHINACOS	\N
131	54	5634	ORO BLANCO	\N
131	54	5635	PAMPA DEL HUEVO	\N
131	54	5636	PAMPA DEL TORDILLO	\N
131	54	5637	PAMPA DEL ZORRO	\N
131	54	5638	PAMPA IPORA GUAZU	\N
131	54	5639	PAMPA SAN MARTIN	\N
131	54	5640	POZO DEL INDIO	\N
131	54	5641	PUEBLO PUCA	\N
131	54	5642	LA CLOTILDE	\N
131	54	5643	LA TIGRA	\N
131	54	5644	MALBALAES (LOTE 45 Y 46)	\N
131	54	5645	MALBALAES (LOTE 55 Y 56)	\N
131	54	5646	PAMPA GRANDE	\N
131	54	5647	SAN BERNARDO	\N
131	54	5648	CORONEL BRANDSEN	\N
131	54	5649	EL CURUNDU	\N
131	54	5650	FORTIN AGUILAR	\N
131	54	5651	FORTIN CHAJA	\N
131	54	5652	GUAYAIBI	\N
131	54	5653	LAS BANDERAS	\N
131	54	5654	LOTE 4 (COLONIA PASTORIL)	\N
131	54	5655	MARTINEZ DE HOZ	\N
131	54	5656	PASO DE OSO	\N
131	54	5657	PRESIDENCIA DE LA PLAZA	\N
131	54	5658	COLONIA BENITEZ	\N
131	54	5659	MARGARITA BELEN	\N
131	54	5660	PUERTO ANTEQUERA	\N
131	54	5661	COLONIA PTE. URIBURU	\N
131	54	5662	PICADITAS	\N
131	54	5663	QUITILIPI	\N
131	54	5664	REDUCCION NAPALPI	\N
131	54	5665	EL PALMAR	\N
131	54	5666	LA MATANZA	\N
131	54	5667	PAMPA VERDE	\N
131	54	5668	SANTOS LUGARES	\N
131	54	5669	LA CHIQUITA	\N
131	54	5670	PAMPA ESPERANZA	\N
131	54	5671	LA COLONIA	\N
131	54	5672	RESISTENCIA	\N
131	54	5673	TROPEZON	\N
131	54	5674	VILLA ALTA	\N
131	54	5675	VILLA BARBERAN	\N
131	54	5676	VILLA JUAN DE GARAY	\N
131	54	5677	VILLA LIBERTAD	\N
131	54	5678	CAMPO DE GALNASI	\N
131	54	5679	LA LIGURIA	\N
131	54	5680	BARRANQUERAS	\N
131	54	5681	LA ISLA	\N
131	54	5682	VILLA FORESTACION	\N
131	54	5683	COLONIA BARANDA	\N
131	54	5684	LA GANADERA	\N
131	54	5685	LA PALOMETA	\N
131	54	5686	LOS ALGARROBOS	\N
131	54	5687	MARIA SARA	\N
131	54	5688	PUENTE PALOMETA	\N
131	54	5689	CACUI	\N
131	54	5690	COLONIA PUENTE PHILIPON	\N
131	54	5691	FONTANA	\N
131	54	5692	LIVA	\N
131	54	5693	PUERTO VICENTINI	\N
131	54	5694	VILLA SARMIENTO	\N
131	54	5695	BASAIL	\N
131	54	5696	COLONIA TACUARI	\N
131	54	5697	LOS PALMARES	\N
131	54	5698	PARALELO 28	\N
131	54	5699	LA LIBERTAD	\N
131	54	5700	PUERTO VILELAS	\N
131	54	5701	LOTE 17	\N
131	54	5702	LOTE 24	\N
131	54	5703	LOTE 25	\N
131	54	5704	LOTE 8	\N
131	54	5705	OETLING	\N
131	54	5706	SAMUHU	\N
131	54	5707	VILLA BERTHET	\N
131	54	5708	CAPITAN SOLARI	\N
131	54	5709	COLONIA ELISA	\N
131	54	5710	COLONIAS UNIDAS	\N
131	54	5711	INGENIERO BARBET	\N
131	54	5712	LA DIFICULTAD	\N
131	54	5713	LA PASTORIL	\N
131	54	5714	LAS GARCITAS	\N
131	54	5715	SALTO DE LA VIEJA	\N
131	54	5716	ARBOL SOLO	\N
131	54	5717	CHARADAI	\N
131	54	5718	COTE LAI	\N
131	54	5719	ESTERO REDONDO	\N
131	54	5720	LA SABANA	\N
131	54	5721	LA VICUÑA	\N
131	54	5722	LAS TOSCAS	\N
131	54	5723	MACOMITAS	\N
131	54	5724	RIO TAPENAGA	\N
131	54	5725	HAUMONIA	\N
131	54	5726	HORQUILLA	\N
131	54	5727	INVERNADA	\N
131	54	5728	NAPALPI	\N
131	54	5729	COLONIA ABORIGEN CHACO	\N
131	54	5730	COLONIA BLAS PARERA	\N
131	54	5731	COLONIA EL AGUARA	\N
131	54	5732	COLONIA LA LOLA	\N
131	54	5733	EL TOTORAL	\N
131	54	5734	LA SOLEDAD	\N
131	54	5735	LA TAMBORA	\N
131	54	5736	MACHAGAI	\N
131	54	5737	SANTA MARTA	\N
131	54	5738	TRES PALMAS	\N
131	54	5739	CUATRO ARBOLES	\N
131	54	5740	HERMOSO CAMPO	\N
131	54	5741	ITIN	\N
132	54	5742	ARROYO VERDE	\N
132	54	5743	EMPALME PUERTO LOBOS	\N
132	54	5744	BAHIA CRACHER	\N
132	54	5745	PUERTO MADRYN	\N
132	54	5746	PUNTA QUIROGA	\N
132	54	5747	BAJO BARTOLO	\N
132	54	5748	BAJO DEL GUALICHO	\N
132	54	5749	BAJO LAS DAMAJUANAS	\N
132	54	5750	CALETA VALDEZ	\N
132	54	5751	EL PASTIZAL	\N
132	54	5752	EL PIQUILLIN	\N
132	54	5753	EL QUILIMUAY	\N
132	54	5754	EL RUANO	\N
132	54	5755	EL SALITRAL	\N
132	54	5756	LA CORONA	\N
132	54	5757	LA ROSILLA	\N
132	54	5758	LARRALDE	\N
132	54	5759	LORETO	\N
132	54	5760	MEDANOS	\N
132	54	5761	PUERTO PIRAMIDES	\N
132	54	5762	PUERTO SAN ROMAN	\N
132	54	5763	PUNTA BAJOS	\N
132	54	5764	PUNTA NORTE	\N
132	54	5765	SALINAS CHICAS	\N
132	54	5766	SALINAS GRANDE	\N
132	54	5767	SAN JOSE	\N
132	54	5768	CERRO RADAL	\N
132	54	5769	LAS GOLONDRINAS	\N
132	54	5770	EL HOYO	\N
132	54	5771	LA CANCHA	\N
132	54	5772	COSTA DEL LEPA	\N
132	54	5773	EL MIRADOR	\N
132	54	5774	GUALJAINA	\N
132	54	5775	BUENOS AIRES CHICO	\N
132	54	5776	COSTA CHUBUT	\N
132	54	5777	EL CHACAY	\N
132	54	5778	EL MAITEN	\N
132	54	5779	FITHEN VERIN	\N
132	54	5780	FITIRHUIN	\N
132	54	5781	CUSHAMEN	\N
132	54	5782	EL COIHUE	\N
132	54	5783	EPUYEN	\N
132	54	5784	LAGO PUELO	\N
132	54	5785	COLONIA CUSHAMEN	\N
132	54	5786	FOTOCAHUEL	\N
132	54	5787	LELEQUE	\N
132	54	5788	LEPA	\N
132	54	5789	RANQUIL HUAO	\N
132	54	5790	SIEMPRE VIVA	\N
132	54	5791	CHOLILA	\N
132	54	5792	EL CAJON	\N
132	54	5793	LAGO LEZAMA	\N
132	54	5794	CIUDADELA	\N
132	54	5795	PROSPERO PALAZZO	\N
132	54	5796	COMODORO RIVADAVIA	\N
132	54	5797	HOLDICH	\N
132	54	5798	PAMPA DEL CASTILLO	\N
132	54	5799	PICO SALAMANCA	\N
132	54	5800	ASTRA	\N
132	54	5801	LAPRIDA	\N
132	54	5802	RADA TILLY	\N
132	54	5803	BAHIA SOLANO	\N
132	54	5804	CALETA CORDOVA	\N
132	54	5805	RESTINGA ALI	\N
132	54	5806	LA SALAMANCA	\N
132	54	5807	PAMPA PELADA	\N
132	54	5808	PAMPA SALAMANCA	\N
132	54	5809	RIO CHICO	\N
132	54	5810	SIERRA CUADRADA	\N
132	54	5811	DIADEMA ARGENTINA	\N
132	54	5812	ESCALANTE	\N
132	54	5813	BAHIA BUSTAMANTE	\N
132	54	5814	BUSTAMANTE	\N
132	54	5815	GARAYALDE	\N
132	54	5816	UZCUDUN	\N
132	54	5817	FLORENTINO AMEGHINO	\N
132	54	5818	CABO RASO	\N
132	54	5819	CAMARONES	\N
132	54	5820	EL JAGUEL	\N
132	54	5821	RUTA 3 KILOMETRO 1646	\N
132	54	5822	ARROYO PESCADO	\N
132	54	5823	CHACRA DE AUSTIN	\N
132	54	5824	ESQUEL	\N
132	54	5825	VILLA FUTALAUFQUEN	\N
132	54	5826	LAGUNA TERRAPLEN	\N
132	54	5827	MALLACO	\N
132	54	5828	MATUCANA	\N
132	54	5829	NAHUEL PAN	\N
132	54	5830	SIERRA DE TECKA	\N
132	54	5831	SUNICA	\N
132	54	5832	CORCOVADO	\N
132	54	5833	PARQUE NACIONAL LOS ALERCES	\N
132	54	5834	ALDEA ESCOLAR	\N
132	54	5835	ARROYO PERCY	\N
132	54	5836	CERRO CENTINELA	\N
132	54	5837	LAGO ROSARIO	\N
132	54	5838	LOS CIPRESES	\N
132	54	5839	RIO CORINTO	\N
132	54	5840	TREVELIN	\N
132	54	5841	VALLE FRIO	\N
132	54	5842	EL BOQUETE	\N
132	54	5843	LAGO RIVADAVIA	\N
132	54	5844	LAGO VERDE	\N
132	54	5845	DIQUE FLORENTINO AMEGHINO	\N
132	54	5846	ANGOSTURA	\N
132	54	5847	BETESTA	\N
132	54	5848	BRYN BROWN	\N
132	54	5849	BRYN GWYN	\N
132	54	5850	EL ARGENTINO	\N
132	54	5851	GAIMAN	\N
132	54	5852	GLASFRYN	\N
132	54	5853	LOMA REDONDA	\N
132	54	5854	MAESTEG	\N
132	54	5855	TREORKI	\N
132	54	5856	VALLE LOS MARTIRES	\N
132	54	5857	VILLA INES	\N
132	54	5858	BOCA DE LA ZANJA	\N
132	54	5859	BOCA ZANJA SUD	\N
132	54	5860	CAMPAMENTO VILLEGAS	\N
132	54	5861	DOLAVON	\N
132	54	5862	EBENECER	\N
132	54	5863	LAS CHAPAS	\N
132	54	5864	TIERRA SALADA	\N
132	54	5865	TOMA DE LOS CANALES	\N
132	54	5866	VALLE SUPERIOR	\N
132	54	5867	VEINTIOCHO DE JULIO	\N
132	54	5868	RIO CHUBUT	\N
132	54	5869	SANTA ANA	\N
132	54	5870	QUECHU NIYEO	\N
132	54	5871	AGUADA DEL PITO	\N
132	54	5872	BAJADA MORENO	\N
132	54	5873	CARHUE NIYEO	\N
132	54	5874	COLELACHE	\N
132	54	5875	EL ESCORIAL	\N
132	54	5876	GASTRE	\N
132	54	5877	LAGUNITA SALADA	\N
132	54	5878	PIRRE MAHUIDA	\N
132	54	5879	PLANCUNTRE	\N
132	54	5880	SACANANA	\N
132	54	5881	TAQUETREN	\N
132	54	5882	PAMPA CHICA	\N
132	54	5883	CARRENLEUFU	\N
132	54	5884	COLAN CONHUE	\N
132	54	5885	COLONIA EPULIEF	\N
132	54	5886	EL CUCHE	\N
132	54	5887	EL KAQUEL	\N
132	54	5888	EL POYO	\N
132	54	5889	ESTANCIA LA MIMOSA	\N
132	54	5890	ESTANCIA PAMPA CHICA	\N
132	54	5891	LAS SALINAS	\N
132	54	5892	MALLIN BLANCO	\N
132	54	5893	PAMPA DE AGNIA	\N
132	54	5894	PASO DEL SAPO	\N
132	54	5895	PIEDRA PARADA	\N
132	54	5896	POCITOS DE QUICHAURA	\N
132	54	5897	QUICHAURA	\N
132	54	5898	TECKA	\N
132	54	5899	VALLE DEL TECKA	\N
132	54	5900	VALLE GARIN	\N
132	54	5901	EL MOLLE	\N
132	54	5902	VALLE HONDO	\N
132	54	5903	ALTO DE LAS PLUMAS	\N
132	54	5904	CABEZA DE BUEY	\N
132	54	5905	EL MIRASOL	\N
132	54	5906	LAS PLUMAS	\N
132	54	5907	CAJON DE GINEBRA CHICO	\N
132	54	5908	CAJON DE GINEBRA GRANDE	\N
132	54	5909	EL CALAFATE	\N
132	54	5910	EL PAJARITO	\N
132	54	5911	LA PRIMAVERA	\N
132	54	5912	LONCO TRAPIAL	\N
132	54	5913	ARROYO GUILAIA	\N
132	54	5914	CERRO CONDOR	\N
132	54	5915	EL CANQUEL	\N
132	54	5916	EL SOMBRERO	\N
132	54	5917	LA BOMBILLA	\N
132	54	5918	LAS CORTADERAS	\N
132	54	5919	LOS ALTARES	\N
132	54	5920	LOS MANANTIALES	\N
132	54	5921	PASO DE INDIOS	\N
132	54	5922	TORO HOSCO	\N
132	54	5923	TRELEW	\N
132	54	5924	BASE AERONAVAL ALMIRANTE ZAR	\N
132	54	5925	PUENTE HENDRE	\N
132	54	5926	BAJO DE LOS HUESOS	\N
132	54	5927	CHARQUE CHICO	\N
132	54	5928	PLAYA UNION	\N
132	54	5929	PUERTO RAWSON	\N
132	54	5930	RAWSON	\N
132	54	5931	SOL DE MAYO	\N
132	54	5932	PLAYA MAGAGNA	\N
132	54	5933	PUNTA NINFAS	\N
132	54	5934	EL TRIANA	\N
132	54	5935	RIO MAYO	\N
132	54	5936	BAJO LA CANCHA	\N
132	54	5937	FACUNDO	\N
132	54	5938	LOS TAMARISCOS	\N
132	54	5939	ALDEA APELEG	\N
132	54	5940	ALTO RIO SENGUER	\N
132	54	5941	ARROYO GATO	\N
132	54	5942	LA PEPITA	\N
132	54	5943	LAGO FONTANA	\N
132	54	5944	PASTOS BLANCOS	\N
132	54	5945	ARROYO CHALIA	\N
132	54	5946	DOCTOR RICARDO ROJAS	\N
132	54	5947	ALDEA BELEIRO	\N
132	54	5948	ALTO RIO MAYO	\N
132	54	5949	HITO 45	\N
132	54	5950	HITO 50	\N
132	54	5951	HUEMULES	\N
132	54	5952	LA NICOLASA	\N
132	54	5953	LA SIBERIA	\N
132	54	5954	LAGO BLANCO	\N
132	54	5955	EL PORVENIR	\N
132	54	5956	LA LAURITA	\N
132	54	5957	LAURITA	\N
132	54	5958	PASO MORENO	\N
132	54	5959	RIO FRIAS	\N
132	54	5960	ARROYO QUILLA	\N
132	54	5961	COLONIA GERMANIA	\N
132	54	5962	COSTA RIO CHICO	\N
132	54	5963	ENRIQUE HERMITTE	\N
132	54	5964	LAGUNA DEL MATE	\N
132	54	5965	LAGUNA PALACIO	\N
132	54	5966	LAS PULGAS	\N
132	54	5967	MANANTIAL GRANDE	\N
132	54	5968	PASO DE TORRES	\N
132	54	5969	SARMIENTO	\N
132	54	5970	SIERRA CORRIENTES	\N
132	54	5971	SIERRA VICTORIA	\N
132	54	5972	COLHUE HUAPI	\N
132	54	5973	BUEN PASTO	\N
132	54	5974	LAGO MUSTERS	\N
132	54	5975	JOSE DE SAN MARTIN	\N
132	54	5976	LAGUNA BLANCA	\N
132	54	5977	ALTO RIO PICO	\N
132	54	5978	GOBERNADOR COSTA	\N
132	54	5979	PUTRACHOIQUE	\N
132	54	5980	RIO SHAMAN	\N
132	54	5981	SHAMAN	\N
132	54	5982	ARENOSO	\N
132	54	5983	LAGO VINTTER	\N
132	54	5984	ATILIO VIGLIONE (LAS PAMPAS)	\N
132	54	5985	RIO PICO	\N
132	54	5986	NUEVA LUBECKA	\N
132	54	5987	BAJADA DEL DIABLO	\N
132	54	5988	AGUADA DE LAS TEJAS	\N
132	54	5989	CHACAY ESTE	\N
132	54	5990	CHACAY OESTE	\N
132	54	5991	CHASICO	\N
132	54	5992	EL ALAMO	\N
132	54	5993	GAN GAN	\N
132	54	5994	LAGUNA DE VACAS	\N
132	54	5995	LAGUNA FRIA	\N
132	54	5996	MALLIN GRANDE	\N
132	54	5997	PAINALUF	\N
132	54	5998	SEPRUCAL	\N
132	54	5999	SIERRA CHATA	\N
132	54	6000	SIERRA ROSADA	\N
132	54	6001	TALAGAPA	\N
132	54	6002	TATUEN	\N
132	54	6003	TELSEN	\N
133	54	6004	COLONIA SAN JOSE	\N
133	54	6005	LA CARLOTA	\N
133	54	6006	ARROYO CARABALLO	\N
133	54	6007	COLONIA CARABALLO	\N
133	54	6008	COLONIA HOCKER	\N
133	54	6009	COLONIA SAN MIGUEL	\N
133	54	6010	PUENTE DE GUALEGUAYCHU	\N
133	54	6011	VILLA ELISA	\N
133	54	6012	COLONIA EL CARMEN	\N
133	54	6013	COLONIA LAS PEPAS	\N
133	54	6014	COLONIA NUEVA SAN MIGUEL	\N
133	54	6015	COLONIA SAN IGNACIO	\N
133	54	6016	COLONIA SANTA ROSA	\N
133	54	6017	COLONIA VAZQUEZ	\N
133	54	6018	ARROYO BARU	\N
133	54	6019	COLONIA AMBIS	\N
133	54	6020	COLONIA BAILINA	\N
133	54	6021	COLONIA EMILIO GOUCHON	\N
133	54	6022	COLONIA F. SILLEN	\N
133	54	6023	HAMBIS	\N
133	54	6024	LA CLARITA	\N
133	54	6025	PUEBLO CAZES	\N
133	54	6026	COLON	\N
133	54	6027	COLONIA NUEVA AL SUD	\N
133	54	6028	PUERTO COLORADO	\N
133	54	6029	PUNTAS DEL PALMAR	\N
133	54	6030	COLONIA HUGHES	\N
133	54	6031	COLONIA PEREIRA	\N
133	54	6032	EJIDO COLON	\N
133	54	6033	FABRICA COLON	\N
133	54	6034	PUEBLO LIEBIG	\N
133	54	6035	PUERTO ALMIRON	\N
133	54	6036	SAN ANSELMO	\N
133	54	6037	COLONIA SAN FRANCISCO	\N
133	54	6038	EL BRILLANTE	\N
133	54	6039	PERUCHO VERNA	\N
133	54	6040	PUEBLO COLORADO	\N
133	54	6041	SAN JOSE	\N
133	54	6042	BERDUC	\N
133	54	6043	JUAN JORGE	\N
133	54	6044	MARTINIANO LEGUIZAMON	\N
133	54	6045	POS POS	\N
133	54	6046	ARROYO CONCEPCION	\N
133	54	6047	CANTERA LA CONSTANCIA	\N
133	54	6048	COLONIA LA MATILDE	\N
133	54	6049	COLONIA SAENZ VALIENTE	\N
133	54	6050	COLONIA SAN ANTONIO	\N
133	54	6051	ESTABLECIMIENTO LA CALERA	\N
133	54	6052	ESTABLECIMIENTO LOS MONIGOTES	\N
133	54	6053	ISLA SAN JOSE	\N
133	54	6054	PALMAR YATAY	\N
133	54	6055	UBAJAY	\N
133	54	6056	ARROYO MOREIRA	\N
133	54	6057	COLONIA JORGE FINK	\N
133	54	6058	JORGE FINK	\N
133	54	6059	MOREIRA	\N
133	54	6060	PASO SOCIEDAD	\N
133	54	6061	PUNTAS DE MOREIRA	\N
133	54	6062	CONCORDIA	\N
133	54	6063	LESCA	\N
133	54	6064	SALADERO CONCORDIA	\N
133	54	6065	CAMBA PASO	\N
133	54	6066	COLONIA ADELA	\N
133	54	6067	COLONIA AYUI GRANDE	\N
133	54	6068	COLONIA NAVARRO	\N
133	54	6069	COLONIA YERUA	\N
133	54	6070	CUEVA DEL TIGRE	\N
133	54	6071	EMBARCADERO FERRARI	\N
133	54	6072	HERVIDERO	\N
133	54	6073	NUEVA ESCOCIA	\N
133	54	6074	PUERTO YERUA	\N
133	54	6075	VILLA ZORRAQUIN	\N
133	54	6076	BENITO LEGEREN	\N
133	54	6077	CALABACILLAS	\N
133	54	6078	CLODOMIRO LEDESMA	\N
133	54	6079	FRIGORIFICO YUQUERI	\N
133	54	6080	PEDERMAR	\N
133	54	6081	PEDERNAL	\N
133	54	6082	SANTA ISABEL	\N
133	54	6083	ISTHILART	\N
133	54	6084	ARROYO EL MOCHO	\N
133	54	6085	ARROYO LA VIRGEN	\N
133	54	6086	CAMPO DOMINGUEZ	\N
133	54	6087	COLONIA LOMA NEGRA	\N
133	54	6088	COLONIA SAN BONIFACIO	\N
133	54	6089	EL DURAZNAL	\N
133	54	6090	EL REDOMON	\N
133	54	6091	EL REFUGIO	\N
133	54	6092	LA ALICIA	\N
133	54	6093	LA CRIOLLA	\N
133	54	6094	LA EMILIA	\N
133	54	6095	LA INVERNADA	\N
133	54	6096	LA NOBLEZA	\N
133	54	6097	LA ODILIA	\N
133	54	6098	LA QUERENCIA	\N
133	54	6099	LOMA NEGRA	\N
133	54	6100	LOS BRILLANTES	\N
133	54	6101	LOS CHARRUAS	\N
133	54	6102	OSVALDO MAGNASCO	\N
133	54	6103	PASO DEL GALLO	\N
133	54	6104	SAN BUENAVENTURA	\N
133	54	6105	ESTACION YERUA	\N
133	54	6106	PARADA YUQUERI	\N
133	54	6107	YERUA	\N
133	54	6108	YUQUERI	\N
133	54	6109	COLONIA CAMPOS	\N
133	54	6110	COLONIA LA QUINTA	\N
133	54	6111	LA PERLA	\N
133	54	6112	LA QUINTA	\N
133	54	6113	LAS MOCHAS	\N
133	54	6114	ALDEA BRASILERA	\N
133	54	6115	ALDEA PROTESTANTE	\N
133	54	6116	ALDEA SALTO	\N
133	54	6117	ALDEA SAN FRANCISCO	\N
133	54	6118	ALDEA SPATZENKUTTER	\N
133	54	6119	ALDEA VALLE MARIA	\N
133	54	6120	CAMPO RIQUELME	\N
133	54	6121	CARRIZAL	\N
133	54	6122	COLONIA ENSAYO	\N
133	54	6123	COLONIA PALMAR	\N
133	54	6124	COSTA GRANDE	\N
133	54	6125	COSTA GRANDE DOLL	\N
133	54	6126	DOCTOR GARCIA	\N
133	54	6127	GENERAL ALVEAR	\N
133	54	6128	LAS CUEVAS	\N
133	54	6129	PAJA BRAVA	\N
133	54	6130	PUENTE DEL DOLL	\N
133	54	6131	PUERTO LAS CUEVAS	\N
133	54	6132	SAN FRANCISCO	\N
133	54	6133	STROBEL	\N
133	54	6134	VALLE MARIA	\N
133	54	6135	ALDEA SANTAFECINA	\N
133	54	6136	COLEGIO ADVENTISTA DEL PLATA	\N
133	54	6137	PUIGGARI	\N
133	54	6138	SANATORIO ADVENTISTA DEL PLATA	\N
133	54	6139	VILLA AIDA	\N
133	54	6140	LIBERTADOR GENERAL SAN MARTIN	\N
133	54	6141	DIAMANTE	\N
133	54	6142	EJIDO DIAMANTE	\N
133	54	6143	PUERTO DIAMANTE	\N
133	54	6144	COLONIA GRAPSCHENTHAL	\N
133	54	6145	ESTABLECIMIENTO EL CARMEN	\N
133	54	6146	ESTABLECIMIENTO LA ESPERANZA	\N
133	54	6147	ESTABLECIMIENTO LAS MARGARITAS	\N
133	54	6148	RACEDO	\N
133	54	6149	CAMPS	\N
133	54	6150	COLONIA RIVAS	\N
133	54	6151	GENERAL RAMIREZ	\N
133	54	6152	ISLETAS	\N
133	54	6153	RIVAS	\N
133	54	6154	EL CARMEN (EST. RACEDO)	\N
133	54	6155	PALMAR	\N
133	54	6156	FORTUNA	\N
133	54	6157	LOS CONQUISTADORES	\N
133	54	6158	FRONTERAS	\N
133	54	6159	LA SELVA	\N
133	54	6160	LOMAS BLANCAS	\N
133	54	6161	SAN JAIME DE LA FRONTERA	\N
133	54	6162	CHAVIYU COLONIA FLORES	\N
133	54	6163	COLONIA DON BOSCO	\N
133	54	6164	COLONIA LA GLORIA	\N
133	54	6165	COLONIA BIZCOCHO	\N
133	54	6166	GUALEGUAYCITO	\N
133	54	6167	COLONIA LA ARGENTINA	\N
133	54	6168	COLONIA LA PAZ	\N
133	54	6169	COLONIA LAMARCA	\N
133	54	6170	FEDERACION	\N
133	54	6171	GUAYAQUIL	\N
133	54	6172	SANTA ANA	\N
133	54	6173	CABI MONDA	\N
133	54	6174	CHAJARI	\N
133	54	6175	COLONIA ALEMANA	\N
133	54	6176	COLONIA BELGRANO	\N
133	54	6177	COLONIA ENSANCHE SAUCE	\N
133	54	6178	COLONIA FRAZER	\N
133	54	6179	COLONIA VILLA LIBERTAD	\N
133	54	6180	LAS CATORCE	\N
133	54	6181	MANDISOVI	\N
133	54	6182	MONTE VERDE	\N
133	54	6183	SANTA JUANA	\N
133	54	6184	SARANDI	\N
133	54	6185	SURST	\N
133	54	6186	TOLEDO	\N
133	54	6187	TORRES	\N
133	54	6188	VILLA LIBERTAD	\N
133	54	6189	COLONIA FREITAS	\N
133	54	6190	COLONIA SANTA ELVIRA	\N
133	54	6191	ESTANCIA SALINAS	\N
133	54	6192	FLORIDA	\N
133	54	6193	LA SOLEDAD	\N
133	54	6194	SAN RAMON	\N
133	54	6195	TATUTI	\N
133	54	6196	VILLA DEL ROSARIO	\N
133	54	6197	COLONIA FLEITAS	\N
133	54	6198	ARROYO DEL MEDIO	\N
133	54	6199	EL GRAMILLAL	\N
133	54	6200	LA ENCIERRA	\N
133	54	6201	SAUCE DE LUNA	\N
133	54	6202	DIEGO LOPEZ	\N
133	54	6203	FEDERAL	\N
133	54	6204	PASO DUARTE	\N
133	54	6205	COLONIA FALCO	\N
133	54	6206	CONSCRIPTO BERNARDI	\N
133	54	6207	EL CIMARRON	\N
133	54	6208	VILLA PERPER	\N
133	54	6209	BANDERAS	\N
133	54	6210	NUEVA VIZCAYA	\N
133	54	6211	ACHIRAS	\N
133	54	6212	LAS ACHIRAS	\N
133	54	6213	LA HIERRA	\N
133	54	6214	LA VERBENA	\N
133	54	6215	ATENCIO	\N
133	54	6216	CATALOTTI	\N
133	54	6217	EL CHAÑAR	\N
133	54	6218	CHIRCALITO	\N
133	54	6219	CORREA	\N
133	54	6220	LA ESMERALDA	\N
133	54	6221	LAS LAGUNAS	\N
133	54	6222	MAC KELLER	\N
133	54	6223	MESA	\N
133	54	6224	PAJAS BLANCAS	\N
133	54	6225	SAN JOSE DE FELICIANO	\N
133	54	6226	TASES	\N
133	54	6227	VIBORAS	\N
133	54	6228	LAS MULITAS	\N
133	54	6229	PALO A PIQUE	\N
133	54	6230	SAN VICTOR	\N
133	54	6231	GUALEYAN	\N
133	54	6232	ALBARDON	\N
133	54	6233	BOCA GUALEGUAY	\N
133	54	6234	CHACRAS	\N
133	54	6235	CUCHILLA	\N
133	54	6236	GUALEGUAY	\N
133	54	6237	HOJAS ANCHAS	\N
133	54	6238	LAS BATEAS	\N
133	54	6239	PUENTE PELLEGRINI	\N
133	54	6240	PUERTO BARRILES	\N
133	54	6241	PUERTO RUIZ	\N
133	54	6242	PUNTA DEL MONTE	\N
133	54	6243	SALADERO ALZUA	\N
133	54	6244	SALADERO SAN JOSE	\N
133	54	6245	SANTA MARTA	\N
133	54	6246	ALDEA ASUNCION	\N
133	54	6247	CUATRO MANOS	\N
133	54	6248	GONZALEZ CALDERON	\N
133	54	6249	LAS COLAS	\N
133	54	6250	LAZO	\N
133	54	6251	SAN JULIAN	\N
133	54	6252	GENERAL GALARZA	\N
133	54	6253	QUINTO DISTRITO	\N
133	54	6254	ISLAS LECHIGUANAS	\N
133	54	6255	COSTA DEL NOGOYA	\N
133	54	6256	PUERTA DE CRESPO	\N
133	54	6257	SEXTO DISTRITO	\N
133	54	6258	TRES BOCAS	\N
133	54	6259	DISTRITO JACINTA	\N
133	54	6260	ARROYO BALTAZAR CHICO	\N
133	54	6261	ARROYO BRAZO CHICO	\N
133	54	6262	ARROYO BRAZO DE LA TINTA	\N
133	54	6263	ARROYO CARBONCITO	\N
133	54	6264	ARROYO CUZCO	\N
133	54	6265	ARROYO DE LA ROSA	\N
133	54	6266	ARROYO DESAGUADERO DEL SAUCE	\N
133	54	6267	ARROYO GUTIERREZ CHICO	\N
133	54	6268	ARROYO LA TINTA	\N
133	54	6269	ARROYO MALAMBO	\N
133	54	6270	ARROYO PACIENCIA CHICO	\N
133	54	6271	ARROYO PACIENCIA GRANDE	\N
133	54	6272	ARROYO PELADO	\N
133	54	6273	ARROYO PIEDRAS	\N
133	54	6274	ARROYO SAGASTUME CHICO	\N
133	54	6275	ARROYO SANTOS CHICO	\N
133	54	6276	ARROYO SANTOS GRANDE	\N
133	54	6277	ARROYO TIROLES	\N
133	54	6278	BRAVO GUTIERREZ	\N
133	54	6279	CANAL NUEVO	\N
133	54	6280	CANAL SAN MARTIN	\N
133	54	6281	ARROYO BICHO FEO	\N
133	54	6282	ARROYO CEIBITO	\N
133	54	6283	ARROYO CUCHARAS	\N
133	54	6284	ARROYO GARCETE	\N
133	54	6285	ARROYO LARA	\N
133	54	6286	ARROYO LAS ANIMAS	\N
133	54	6287	ARROYO LLORONES	\N
133	54	6288	ARROYO MANZANO	\N
133	54	6289	ARROYO MERLO	\N
133	54	6290	ARROYO MOSQUITO	\N
133	54	6291	ARROYO PEREYRA	\N
133	54	6292	ARROYO PITO	\N
133	54	6293	ARROYO PLATITOS	\N
133	54	6294	ARROYO BRASILERO	\N
133	54	6295	ARROYO IBICUYCITO	\N
133	54	6296	ARROYO LA PACIENCIA	\N
133	54	6297	ARROYO LOS PLATOS	\N
133	54	6298	COLONIA DELTA	\N
133	54	6299	ISLA EL DORADO	\N
133	54	6300	PARANA BRAVO	\N
133	54	6301	RIO ALFEREZ NELSON PAGE	\N
133	54	6302	RIO CEIBO	\N
133	54	6303	RIO PARANA GUAZU	\N
133	54	6304	RIO SAUCE	\N
133	54	6305	GUALEGUAYCHU	\N
133	54	6306	LA LATA	\N
133	54	6307	PALAVECINO	\N
133	54	6308	VILLA ANTONY	\N
133	54	6309	VILLA LILA	\N
133	54	6310	ÑANDUBAYSAL	\N
133	54	6311	ARROYO DEL CURA	\N
133	54	6312	ARROYO VENERATO	\N
133	54	6313	COSTA URUGUAY	\N
133	54	6314	PEHUAJO NORTE	\N
133	54	6315	RINCON DEL GATO	\N
133	54	6316	SARANDI	\N
133	54	6317	VILLA DEL CERRO	\N
133	54	6318	ARROYO BUEN PASTOR	\N
133	54	6319	ARROYO CABALLO	\N
133	54	6320	ARROYO PRINCIPAL	\N
133	54	6321	ARROYO SALADO	\N
133	54	6322	ARROYO SANCHEZ CHICO	\N
133	54	6323	ARROYO SANCHEZ GRANDE	\N
133	54	6324	ARROYO ZAPALLO	\N
133	54	6325	CANAL PRINCIPAL	\N
133	54	6326	CEIBAL	\N
133	54	6327	COOPERATIVA BRAZO LARGO	\N
133	54	6328	ESTABLECIMIENTO SAN MARTIN	\N
133	54	6329	LA CUADRA	\N
133	54	6330	PERDICES	\N
133	54	6331	PUENTE PARANACITO	\N
133	54	6332	ALMADA	\N
133	54	6333	COLONIA ITALIANA	\N
133	54	6334	DOCTOR EUGENIO MUÑOZ	\N
133	54	6335	FAUSTINO M. PARERA	\N
133	54	6336	GENERAL ALMADA	\N
133	54	6337	LA CHICA	\N
133	54	6338	LA FLORIDA	\N
133	54	6339	VILLA ROMERO	\N
133	54	6340	ALDEA SAN ANTONIO	\N
133	54	6341	ALDEA SAN JUAN	\N
133	54	6342	ALDEA SANTA CELIA	\N
133	54	6343	COSTA SAN ANTONIO	\N
133	54	6344	LA ESCONDIDA	\N
133	54	6345	BRITOS	\N
133	54	6346	RINCON DEL CINTO	\N
133	54	6347	URDINARRAIN	\N
133	54	6348	ESCRIÑA	\N
133	54	6349	GILBERT	\N
133	54	6350	LAS MASITAS	\N
133	54	6351	LOS AMIGOS	\N
133	54	6352	EMPALME HOLT	\N
133	54	6353	MAZARUCA	\N
133	54	6354	PASO DEL CISNERO	\N
133	54	6355	PUERTO PERAZZO	\N
133	54	6356	PUERTO SAN JUAN	\N
133	54	6357	ALARCON	\N
133	54	6358	CUCHILLA REDONDA	\N
133	54	6359	ENRIQUE CARBO	\N
133	54	6360	IRAZUSTA	\N
133	54	6361	LA COSTA	\N
133	54	6362	TALITAS	\N
133	54	6363	DOS HERMANAS	\N
133	54	6364	LARROQUE	\N
133	54	6365	LAS MERCEDES	\N
133	54	6366	PEHUAJO SUD	\N
133	54	6367	EL SARANDI	\N
133	54	6368	LA CAPILLA	\N
133	54	6369	ARROYO SAGASTUME GRANDE	\N
133	54	6370	BRAZO LARGO	\N
133	54	6371	CEIBAS	\N
133	54	6372	SAGASTUME	\N
133	54	6373	VILLA PARANACITO	\N
133	54	6374	HOLT	\N
133	54	6375	IBICUY	\N
133	54	6376	PARANACITO	\N
133	54	6377	PUERTO CONSTANZA	\N
133	54	6378	MEDANOS	\N
133	54	6379	PASO POTRILLO	\N
133	54	6380	PUERTO ALGARROBO	\N
133	54	6381	VIZCACHERA	\N
133	54	6382	PIEDRAS BLANCAS	\N
133	54	6383	ALCARAZ NORTE	\N
133	54	6384	ALCARAZ SUD	\N
133	54	6385	COLONIA LA PROVIDENCIA	\N
133	54	6386	EL SOLAR	\N
133	54	6387	COLONIA OUGRIE	\N
133	54	6388	PUEBLO ARRUA	\N
133	54	6389	ALCARACITO	\N
133	54	6390	BOVRIL	\N
133	54	6391	COLONIA AVIGDOR	\N
133	54	6392	COLONIA VIRARO	\N
133	54	6393	EL CORCOVADO	\N
133	54	6394	LA DILIGENCIA	\N
133	54	6395	PUEBLO ELLISON	\N
133	54	6396	SIR LEONARD	\N
133	54	6397	RAMIREZ	\N
133	54	6398	TACAS	\N
133	54	6399	ALCARAZ	\N
133	54	6400	CENTENARIO	\N
133	54	6401	COLONIA BUENA VISTA	\N
133	54	6402	COLONIA LA DELIA	\N
133	54	6403	COLONIA OFICIAL N 3	\N
133	54	6404	EJIDO SUD	\N
133	54	6405	ISLA CURUZU CHALI	\N
133	54	6406	LA PAZ	\N
133	54	6407	OMBU	\N
133	54	6408	PASO MEDINA	\N
133	54	6409	PILOTO AVILA	\N
133	54	6410	PUERTO MARQUEZ	\N
133	54	6411	SARANDI-CORA	\N
133	54	6412	TACUARAS YACARE	\N
133	54	6413	YESO	\N
133	54	6414	ARROYO CEIBO	\N
133	54	6415	BONALDI	\N
133	54	6416	CALANDRIA	\N
133	54	6417	COLONIA FONTANINI	\N
133	54	6418	COLONIA OF1CIAL N 13	\N
133	54	6419	COLONIA OF1CIAL N 14	\N
133	54	6420	EL GAUCHO	\N
133	54	6421	ESTACAS	\N
133	54	6422	LAS TOSCAS	\N
133	54	6423	MARTINETTI	\N
133	54	6424	MIRA MONTE	\N
133	54	6425	MONTIEL	\N
133	54	6426	SAN GERONIMO	\N
133	54	6427	SAN GUSTAVO	\N
133	54	6428	SAUCESITO	\N
133	54	6429	VILLA BOREILO	\N
133	54	6430	EL COLORADO	\N
133	54	6431	EL QUEBRACHO	\N
133	54	6432	PASO GARIBALDI	\N
133	54	6433	PUERTO CADENAS	\N
133	54	6434	SANTA ELENA	\N
133	54	6435	PASO TELEGRAFO	\N
133	54	6436	COLONIA SAN CARLOS	\N
133	54	6437	CRUCECITAS 7A. SECCION	\N
133	54	6438	SECCION URQUIZA	\N
133	54	6439	ALDEA SAN MIGUEL	\N
133	54	6440	EL TALLER	\N
133	54	6441	DON CRISTOBAL PRIMERA SECCION	\N
133	54	6442	GOBERNADOR FEBRE	\N
133	54	6443	LAURENCENA	\N
133	54	6444	MONTOYA	\N
133	54	6445	NOGOYA	\N
133	54	6446	SAUCE	\N
133	54	6447	CRUCECITAS 3A. SECCION	\N
133	54	6448	EL PUEBLITO	\N
133	54	6449	LA MARUJA	\N
133	54	6450	BETBEDER	\N
133	54	6451	CAMPO ESCALES	\N
133	54	6452	HERNANDEZ	\N
133	54	6453	20 DE SEPTIEMBRE	\N
133	54	6454	CHIQUEROS	\N
133	54	6455	COLONIA LA LLAVE	\N
133	54	6456	LA COLINA	\N
133	54	6457	LA FAVORITA	\N
133	54	6458	LOS PARAISOS	\N
133	54	6459	LUCAS GONZALEZ	\N
133	54	6460	SAN LORENZO	\N
133	54	6461	ARANGUREN	\N
133	54	6462	DON CRISTOBAL SEGUNDA SECCION	\N
133	54	6463	DON CRISTOBAL	\N
133	54	6464	CRUCECITAS 8A. SECCION	\N
133	54	6465	LUCAS NORESTE	\N
133	54	6466	AVENIDA EJERCITO PARANA	\N
133	54	6467	BAJADA GRANDE	\N
133	54	6468	CORRALES NUEVOS	\N
133	54	6469	ORO VERDE	\N
133	54	6470	PARACAO	\N
133	54	6471	PARANA	\N
133	54	6472	QUINTAS AL SUD	\N
133	54	6473	TIRO FEDERAL	\N
133	54	6474	VILLA SARMIENTO	\N
133	54	6475	VILLA URANGA	\N
133	54	6476	ESPINILLO	\N
133	54	6477	PRESIDENTE AVELLANEDA	\N
133	54	6478	SAN BENITO	\N
133	54	6479	SAUCE PINTO	\N
133	54	6480	EL RAMBLON	\N
133	54	6481	QUEBRACHO	\N
133	54	6482	VIALE	\N
133	54	6483	ALMACEN CRISTIAN SCHUBERT	\N
133	54	6484	ARROYO LAS TUNAS	\N
133	54	6485	ARROYO PANCHO	\N
133	54	6486	LAS TUNAS	\N
133	54	6487	TABOSSI	\N
133	54	6488	COLONIA CELINA	\N
133	54	6489	COLONIA SAN MARTIN	\N
133	54	6490	CURTIEMBRE	\N
133	54	6491	LA BALZA	\N
133	54	6492	PASO DE LA BALZA	\N
133	54	6493	PUERTO CURTIEMBRE	\N
133	54	6494	TRES LAGUNAS	\N
133	54	6495	VILLA URQUIZA	\N
133	54	6496	ALDEA MARIA LUISA	\N
133	54	6497	COLONIA MARIA LUISA	\N
133	54	6498	COLONIA REFFINO	\N
133	54	6499	ESTABLECIMIENTO EL CIMARRON	\N
133	54	6500	TEZANOS PINTO	\N
133	54	6501	VILLA FONTANA	\N
133	54	6502	VILLA GOBERNADOR ETCHEVEHERE	\N
133	54	6503	ALDEA CUESTA	\N
133	54	6504	ALDEA SAN RAFAEL	\N
133	54	6505	ALDEA SANTA ROSA	\N
133	54	6506	CRESPO	\N
133	54	6507	SEGUI	\N
133	54	6508	COLONIA CRESPO	\N
133	54	6509	CRESPO NORTE	\N
133	54	6510	DISTRITO TALA	\N
133	54	6511	LA PICADA	\N
133	54	6512	LA PICADA NORTE	\N
133	54	6513	PASO DE LA ARENA	\N
133	54	6514	PASO DE LAS PIEDRAS	\N
133	54	6515	PUENTE CARMONA	\N
133	54	6516	RAMON A. PARERA	\N
133	54	6517	SAUCE MONTRULL	\N
133	54	6518	ANTONIO TOMAS	\N
133	54	6519	CERRITO	\N
133	54	6520	COLONIA ARGENTINA	\N
133	54	6521	COLONIA RIVADAVIA	\N
133	54	6522	COLONIA SAN JUAN	\N
133	54	6523	EL PALENQUE	\N
133	54	6524	PUEBLO MORENO	\N
133	54	6525	ALDEA SANTA MARIA	\N
133	54	6526	PUEBLO GENERAL PAZ	\N
133	54	6527	DESTACAMENTO GENERAL GUEMES	\N
133	54	6528	GENERAL GUEMES	\N
133	54	6529	PUEBLO BRUGO	\N
133	54	6530	ALCETE	\N
133	54	6531	HERNANDARIAS	\N
133	54	6532	PUERTO VIBORAS	\N
133	54	6533	PUERTO VILLARRUEL	\N
133	54	6534	VILLA HERNANDARIAS	\N
133	54	6535	COLONIA HERNANDARIAS	\N
133	54	6536	EL PINGO	\N
133	54	6537	ARROYO BURGOS	\N
133	54	6538	ARROYO MARIA	\N
133	54	6539	BARRANCAS COLORADAS	\N
133	54	6540	COLONIA SANTA LUISA	\N
133	54	6541	MARIA GRANDE	\N
133	54	6542	MARIA GRANDE SEGUNDA	\N
133	54	6543	SANTA LUISA	\N
133	54	6544	SOSA	\N
133	54	6545	ANTONIO TOMAS SUD	\N
133	54	6546	HASENKAMP	\N
133	54	6547	LA COLMENA	\N
133	54	6548	LA JULIANA	\N
133	54	6549	LA VIRGINIA	\N
133	54	6550	LOS NARANJOS	\N
133	54	6551	SANTA SARA	\N
133	54	6552	LAS GARZAS	\N
133	54	6553	PUEBLO BELLOCQ	\N
133	54	6554	COLONIA HIGUERA	\N
133	54	6555	ESTANCIA LA GAMA	\N
133	54	6556	ARROYO CLE	\N
133	54	6557	COLONIA DUPORTAL	\N
133	54	6558	ECHAGUE	\N
133	54	6559	GOBERNADOR ECHAGUE	\N
133	54	6560	GOBERNADOR MANSILLA	\N
133	54	6561	SAUCE SUD	\N
133	54	6562	ALTAMIRANO SUD	\N
133	54	6563	ARROYO OBISPO	\N
133	54	6564	HIPODROMO	\N
133	54	6565	LA OLLITA	\N
133	54	6566	LAS GUACHAS	\N
133	54	6567	MOLINO BOB	\N
133	54	6568	PRIMER CUARTEL	\N
133	54	6569	PUENTE OBISPO	\N
133	54	6570	RINCON DE LAS GUACHAS	\N
133	54	6571	ROSARIO DEL TALA	\N
133	54	6572	SEGUNDO CUARTEL	\N
133	54	6573	SOLA	\N
133	54	6574	ALTAMIRANO NORTE	\N
133	54	6575	DURAZNO	\N
133	54	6576	ESTABLECIMIENTO SAN EDUARDO	\N
133	54	6577	ESTABLECIMIENTO SAN EUSEBIO	\N
133	54	6578	ESTABLECIMIENTO SAN FRANCISCO	\N
133	54	6579	GUARDAMONTE	\N
133	54	6580	MACIA	\N
133	54	6581	RAICES AL NORTE	\N
133	54	6582	LA ZELMIRA	\N
133	54	6583	EL POTRERO	\N
133	54	6584	COLONIA NUEVA MONTEVIDEO	\N
133	54	6585	LAS ROSAS	\N
133	54	6586	ALBERTO GERCHUNOFF	\N
133	54	6587	BASAVILBASO	\N
133	54	6588	COLONIA LUCIENVILLE	\N
133	54	6589	LINEA 24	\N
133	54	6590	LINEA 25	\N
133	54	6591	NOVIBUCO PRIMERO	\N
133	54	6592	TRES ALDEAS	\N
133	54	6593	OLEGARIO V. ANDRADE	\N
133	54	6594	ROCAMORA	\N
133	54	6595	COLONIA BELGA AMERICANA	\N
133	54	6596	COLONIA LEVEN	\N
133	54	6597	GRUPO PARRERO	\N
133	54	6598	LA AMIGUITA	\N
133	54	6599	LAS MOSCAS	\N
133	54	6600	LIBAROS	\N
133	54	6601	LINEA 19	\N
133	54	6602	LINEA 20	\N
133	54	6603	LIONEL	\N
133	54	6604	MAC DOUGALL	\N
133	54	6605	COLONIA CARMEL	\N
133	54	6606	COLONIA SAGASTUME	\N
133	54	6607	GRUPO ACHIRAS	\N
133	54	6608	MIGUEL J. PERLIZA	\N
133	54	6609	CARAGUATA	\N
133	54	6610	COLONIA LUCRECIA	\N
133	54	6611	GERIBEBUY	\N
133	54	6612	GOBERNADOR URQUIZA	\N
133	54	6613	MANGRULLO	\N
133	54	6614	SAN LUIS	\N
133	54	6615	SAN MARCIAL	\N
133	54	6616	SANTA ANITA	\N
133	54	6617	SANTA ROSA	\N
133	54	6618	ARROYO MOLINO	\N
133	54	6619	BALNEARIO PELAY	\N
133	54	6620	COLONIA PERFECCION	\N
133	54	6621	CONCEPCION DEL URUGUAY	\N
133	54	6622	ESTACION URUGUAY	\N
133	54	6623	LA TIGRESA	\N
133	54	6624	PASO DEL MOLINO	\N
133	54	6625	CENTELLA	\N
133	54	6626	COLONIA CUPALEN	\N
133	54	6627	COLONIA ELIA	\N
133	54	6628	COLONIA LUCA	\N
133	54	6629	COLONIA SANTA ANA	\N
133	54	6630	CUPALEN	\N
133	54	6631	LA MARIA LUISA	\N
133	54	6632	TALITA	\N
133	54	6633	TOMAS ROCAMORA	\N
133	54	6634	CASEROS	\N
133	54	6635	PALACIO SAN JOSE	\N
133	54	6636	VILLA SAN JUSTO	\N
133	54	6637	VILLA UDINE	\N
133	54	6638	CENTENARIO	\N
133	54	6639	COLONIA CARMELO	\N
133	54	6640	COLONIA CRUCESITAS	\N
133	54	6641	COLONIA ENSANCHE MAYO	\N
133	54	6642	COLONIA SAN CIPRIANO	\N
133	54	6643	COLONIA SAN JORGE	\N
133	54	6644	COLONIA SANTA TERESITA	\N
133	54	6645	PRIMERO DE MAYO	\N
133	54	6646	PRONUNCIAMIENTO	\N
133	54	6647	SAN CIPRIANO	\N
133	54	6648	COLONIA ELISA	\N
133	54	6649	COLONIA TRES DE FEBRERO	\N
133	54	6650	SAN MIGUEL	\N
133	54	6651	ESTANCIA BELLA VISTA	\N
133	54	6652	ESTANCIA COLONIA EL OMBU	\N
133	54	6653	ESTANCIA COLONIA EL TOROPI	\N
133	54	6654	ESTANCIA COLONIA LA TAPERA	\N
133	54	6655	ESTANCIA COLONIA PERIBEBUY	\N
133	54	6656	ESTANCIA COLONIA SAN PEDRO	\N
133	54	6657	ESTANCIA COLONIA SANTA ELOISA	\N
133	54	6658	ESTANCIA COLONIA SANTA JUANA	\N
133	54	6659	ESTANCIA EL TOROPI	\N
133	54	6660	ESTANCIA LOS VASCOS	\N
133	54	6661	GENACITO	\N
133	54	6662	HERRERA	\N
133	54	6663	LA PRIMAVERA	\N
133	54	6664	LA TAPERA	\N
133	54	6665	NICOLAS HERRERA	\N
133	54	6666	VILLA MANTERO	\N
133	54	6667	ARROYO URQUIZA	\N
133	54	6668	COLONIA ARROYO URQUIZA	\N
133	54	6669	LIEBIG	\N
133	54	6670	VILLA LIBERTADOR GRAL SAN MARTIN	\N
133	54	6671	VILLA ANGELICA	\N
133	54	6672	ARROYO JACINTO	\N
133	54	6673	ISLA EL PILLO	\N
133	54	6674	LOS GANSOS	\N
133	54	6675	MOLINO DOLL	\N
133	54	6676	PAJONAL	\N
133	54	6677	PUERTO LOPEZ	\N
133	54	6678	RINCON DEL DOLL	\N
133	54	6679	ANTELO	\N
133	54	6680	COLONIA ANGELA	\N
133	54	6681	MONTOYA	\N
133	54	6682	PASO DEL ABRA	\N
133	54	6683	PUENTE VICTORIA	\N
133	54	6684	QUINTO CUARTEL VICTORIA	\N
133	54	6685	VICTORIA	\N
133	54	6686	ESTABLECIMIENTO PUNTA ALTA	\N
133	54	6687	LAGUNA DEL PESCADO	\N
133	54	6688	PUEBLITO	\N
133	54	6689	PUERTO ESQUINA	\N
133	54	6690	RINCON DE NOGOYA	\N
133	54	6691	TRES ESQUINAS	\N
133	54	6692	CHILCAS SUD	\N
133	54	6693	HINOJAL	\N
133	54	6694	MORENO	\N
133	54	6695	COLONIA BERRO	\N
133	54	6696	COSTA DEL PAYTICU	\N
133	54	6697	VIRANO	\N
133	54	6698	RAICES	\N
133	54	6699	RAICES ESTE	\N
133	54	6700	SAN GREGORIO	\N
133	54	6701	BENITEZ	\N
133	54	6702	COLONIA HEBREA	\N
133	54	6703	COLONIA LA ESPERANZA	\N
133	54	6704	EL AVESTRUZ	\N
133	54	6705	MAURICIO RIBOLE	\N
133	54	6706	PUENTE DE LUCAS	\N
133	54	6707	COLONIA LOPEZ	\N
133	54	6708	COLONIA NUEVA ALEMANIA	\N
133	54	6709	VILLAGUAYCITO	\N
133	54	6710	COLONIA EGIDO	\N
133	54	6711	EMPALME NEILD	\N
133	54	6712	PARAJE GUAYABO	\N
133	54	6713	SEGUNDA SECCION LUCAS AL SUD	\N
133	54	6714	VILLAGUAY	\N
133	54	6715	CAMPO DE VILLAMIL	\N
133	54	6716	COLONIA VILLAGUAYCITO	\N
133	54	6717	LAGUNA LARGA	\N
133	54	6718	LOS OMBUES	\N
133	54	6719	LUCAS NORTE	\N
133	54	6720	LUCAS SUD	\N
133	54	6721	MOJONES NORTE	\N
133	54	6722	MOJONES SUD	\N
133	54	6723	PASO DE LA LAGUNA	\N
133	54	6724	RAICES OESTE	\N
133	54	6725	RINCON DE MOJONES	\N
133	54	6726	RINCON LUCAS NORTE	\N
133	54	6727	RINCON LUCAS SUD	\N
133	54	6728	LA JOYA	\N
133	54	6729	VILLAGUAY ESTE	\N
133	54	6730	BARON HIRSCH	\N
133	54	6731	COLONIA ACHIRAS	\N
133	54	6732	COLONIA BARON HIRSCH	\N
133	54	6733	COLONIA IDA	\N
133	54	6734	COLONIA MIGUEL	\N
133	54	6735	COLONIA PERLIZA	\N
133	54	6736	COLONIA SAN MANUEL	\N
133	54	6737	COLONIA SONENFELD	\N
133	54	6738	DESPARRAMADOS	\N
133	54	6739	DOMINGUEZ	\N
133	54	6740	EBEN HOROSCHA	\N
133	54	6741	INGENIERO MIGUEL SAJAROFF	\N
133	54	6742	PUEBLO DOMINGUEZ	\N
133	54	6743	RACHEL	\N
133	54	6744	ROSPINA	\N
133	54	6745	ALDEA SAN JORGE	\N
133	54	6746	BELEZ	\N
133	54	6747	CAMPO MORENO	\N
133	54	6748	CLARA	\N
133	54	6749	COLONIA BELEZ	\N
133	54	6750	COLONIA CARLOS CALVO	\N
133	54	6751	COLONIA ESPINDOLA	\N
133	54	6752	COLONIA FEIMBERG	\N
133	54	6753	COLONIA GUIBURG	\N
133	54	6754	COLONIA LA ROSADA	\N
133	54	6755	COLONIA SAN JORGE	\N
133	54	6756	COLONIA SANDOVAL	\N
133	54	6757	COLONIA VELEZ	\N
133	54	6758	SAN VICENTE	\N
133	54	6759	SPINDOLA	\N
133	54	6760	VERGARA	\N
133	54	6761	VILLA CLARA	\N
133	54	6762	COLONIA LA BLANQUITA	\N
133	54	6763	COLONIA LA MORENITA	\N
133	54	6764	COLONIA LA PAMPA	\N
133	54	6765	JUBILEO	\N
133	54	6766	LA ESTRELLA	\N
133	54	6767	LA PAMPA	\N
133	54	6768	ALDEA SAN GREGORIO	\N
133	54	6769	ARROYO GRANDE	\N
133	54	6770	COLONIA CURBELO	\N
133	54	6771	COLONIA LA MORA	\N
133	54	6772	COLONIA OFICIAL N 5 (HERMINIO J. QUIROS)	\N
133	54	6773	GENERAL CAMPOS	\N
133	54	6774	PUEBLO FERRE	\N
133	54	6775	WALTER MOSS	\N
133	54	6776	ARROYO PALMAR	\N
133	54	6777	SAN SALVADOR	\N
133	54	6778	COLONIA SAN ERNESTO	\N
133	54	6779	COLONIA SANTA ELENA (BAYLINA)	\N
133	54	6780	PUNTAS DEL GUALEGUAYCHU	\N
134	54	6781	COLONIA BUENA VISTA	\N
134	54	6782	BAJO HONDO	\N
134	54	6783	CABO PRIMERO CHAVEZ	\N
134	54	6784	COSTA DEL PILCOMAYO	\N
134	54	6785	FORTIN GUEMES	\N
134	54	6786	FORTIN LA SOLEDAD	\N
134	54	6787	FORTIN PILCOMAYO	\N
134	54	6788	PASO DE LOS TOBAS	\N
134	54	6789	POZO LA NEGRA	\N
134	54	6790	SOLDADO MARCELINO TORALES	\N
134	54	6791	CHIRIGUANOS	\N
134	54	6792	DOCTOR EZEQUIEL RAMOS MEJIA	\N
134	54	6793	EL PIMPIN	\N
134	54	6794	EL TASTAS	\N
134	54	6795	MATIAS GULACSI	\N
134	54	6796	POZO DEL MORTERO	\N
134	54	6797	ALFONSINA STORNI	\N
134	54	6798	CAPITAN JUAN SOLA	\N
134	54	6799	JOSE MANUEL ESTRADA	\N
134	54	6800	LAGUNA YEMA	\N
134	54	6801	SUMAYEN	\N
134	54	6802	AGUA VERDE	\N
134	54	6803	BUEN LUGAR	\N
134	54	6804	CABALLO MUERTO	\N
134	54	6805	DOCTOR GUMERSINDO SAYAGO	\N
134	54	6806	EL AZOTADO	\N
134	54	6807	EL QUEMADO	\N
134	54	6808	EL ZORRO	\N
134	54	6809	FLORENCIO SANCHEZ	\N
134	54	6810	GUADALCAZAR	\N
134	54	6811	LA PALMA SOLA	\N
134	54	6812	PUERTO IRIGOYEN	\N
134	54	6813	RICARDO GUIRALDES	\N
134	54	6814	VACA PERDIDA	\N
134	54	6815	EL CAÑON	\N
134	54	6816	SIMBOLAR	\N
134	54	6817	LA LAGUNA	\N
134	54	6818	SAN CAMILO	\N
134	54	6819	SAN ISIDRO	\N
134	54	6820	EL AIBAL - SILENCIO	\N
134	54	6821	LA PALIZADA	\N
134	54	6822	POZO DE MAZA	\N
134	54	6823	DR. LUIS DE GASPERI (Pozo de Maza)	\N
134	54	6824	EL SOLITARIO	\N
134	54	6825	FORTIN LA MADRID	\N
134	54	6826	LA RINCONADA	\N
134	54	6827	LA ZANJA	\N
134	54	6828	LAGUNA YACARE	\N
134	54	6829	RIO MUERTO	\N
134	54	6830	BOCA DEL RIACHO DE PILAGA	\N
134	54	6831	CAPILLA SAN ANTONIO	\N
134	54	6832	COLONIA DALMACIA	\N
134	54	6833	COLONIA ISLA ALVAREZ	\N
134	54	6834	COLONIA ISLA DE ORO	\N
134	54	6835	COLONIA PUENTE PUCU	\N
134	54	6836	COLONIA PUENTE URIBURU	\N
134	54	6837	FORMOSA	\N
134	54	6838	GUAYCOLEC	\N
134	54	6839	HOSPITAL RURAL	\N
134	54	6840	ISLA 9 DE JULIO	\N
134	54	6841	ISLA OCA	\N
134	54	6842	LA COLONIA	\N
134	54	6843	LA FLORIDA	\N
134	54	6844	LOTE 4	\N
134	54	6845	MOJON DE FIERRO	\N
134	54	6846	MONTE AGUDO	\N
134	54	6847	MONTE LINDO	\N
134	54	6848	TIMBO PORA	\N
134	54	6849	VILLA EMILIA	\N
134	54	6850	COLONIA PASTORIL	\N
134	54	6851	ITUZAINGO	\N
134	54	6852	PRESIDENTE YRIGOYEN	\N
134	54	6853	GRAN GUARDIA	\N
134	54	6854	MARIANO BOEDO	\N
134	54	6855	SAN HILARIO	\N
134	54	6856	VILLA DEL CARMEN	\N
134	54	6857	VILLA TRINIDAD	\N
134	54	6858	BOCA DE PILAGAS	\N
134	54	6859	ISLA 25 DE MAYO	\N
134	54	6860	CABO ADRIANO AYALA	\N
134	54	6861	GENERAL LUCIO V. MANSILLA	\N
134	54	6862	VILLA ESCOLAR	\N
134	54	6863	BAHIA NEGRA	\N
134	54	6864	BANCO PAYAGUA	\N
134	54	6865	CAMPO GORETA	\N
134	54	6866	CHURQUI CUE	\N
134	54	6867	COLONIA AQUINO	\N
134	54	6868	COLONIA CANO	\N
134	54	6869	COSTA DEL LINDO	\N
134	54	6870	CURUPAY	\N
134	54	6871	EL ANGELITO	\N
134	54	6872	EL ARBOL SOLO	\N
134	54	6873	EL ARBOLITO	\N
134	54	6874	EL OLVIDO	\N
134	54	6875	EL OMBU	\N
134	54	6876	ESTERITO	\N
134	54	6877	FORTIN GALPON	\N
134	54	6878	FRAY MAMERTO ESQUIU	\N
134	54	6879	HERRADURA	\N
134	54	6880	ISLA PAYAGUA	\N
134	54	6881	LA ESPERANZA	\N
134	54	6882	LA LUCRECIA	\N
134	54	6883	LA PASION	\N
134	54	6884	RIACHO RAMIREZ	\N
134	54	6885	SAN ANTONIO	\N
134	54	6886	SAN CAYETANO	\N
134	54	6887	SAN FRANCISCO DE LAISHI	\N
134	54	6888	SANTA MARIA	\N
134	54	6889	SARGENTO CABRAL	\N
134	54	6890	TATANE	\N
134	54	6891	TRES MOJONES	\N
134	54	6892	TRES POCITOS	\N
134	54	6893	SOLDADO EDMUNDO SOSA	\N
134	54	6894	COLONIA TATANE	\N
134	54	6895	OLEGARIO VICTOR ANDRADE	\N
134	54	6896	COLONIA EL DORADO	\N
134	54	6897	COLONIA EL NARANJITO	\N
134	54	6898	COLONIA LAGUNA GOBERNADOR	\N
134	54	6899	POTRERO DE LOS CABALLOS	\N
134	54	6900	BOLSA DE PALOMO	\N
134	54	6901	CAMPO GRANDE	\N
134	54	6902	DOCTOR LUIS AGOTE	\N
134	54	6903	EL DESMONTE	\N
134	54	6904	FRANCISCO NARCISO DE LAPRIDA	\N
134	54	6905	GOBERNADOR YALUR	\N
134	54	6906	INGENIERO ENRIQUE H. FAURE	\N
134	54	6907	INGENIERO JUAREZ	\N
134	54	6908	LAS TRES MARIAS	\N
134	54	6909	LOS CHAGUANCOS	\N
134	54	6910	MISTOL MARCADO	\N
134	54	6911	POZO DE LA YEGUA	\N
134	54	6912	SANTA TERESA	\N
134	54	6913	EL MILAGRO	\N
134	54	6914	EL MISTOLAR	\N
134	54	6915	EL POTRERITO	\N
134	54	6916	LA JUNTA	\N
134	54	6917	POZO DE LOS PATOS	\N
134	54	6918	POZO EL YACARE	\N
134	54	6919	CAMPO OSWALD	\N
134	54	6920	CATANEO CUE	\N
134	54	6921	GENERAL MANUEL BELGRANO	\N
134	54	6922	COMANDANTE FONTANA	\N
134	54	6923	CORONEL ARGENTINO LARRABURE	\N
134	54	6924	EL COGOIK	\N
134	54	6925	RINCON FLORIDO	\N
134	54	6926	DOMINGO FAUSTINO SARMIENTO	\N
134	54	6927	FORTIN LUGONES	\N
134	54	6928	FORTIN SARGENTO PRIMERO LEYES	\N
134	54	6929	LAS LOLAS	\N
134	54	6930	MAESTRO FERMIN BAEZ	\N
134	54	6931	URBANA VIEJA	\N
134	54	6932	VILLA GRAL. GUEMES	\N
134	54	6933	BARTOLOME DE LAS CASAS	\N
134	54	6934	BRUCHARD	\N
134	54	6935	TENIENTE BROWN	\N
134	54	6936	CAMPO AZCURRA	\N
134	54	6937	CAMPO DEL CIELO	\N
134	54	6938	COLONIA EL CATORCE	\N
134	54	6939	COLONIA EL SILENCIO	\N
134	54	6940	COLONIA GUILLERMINA	\N
134	54	6941	COLONIA ISLA SOLA	\N
134	54	6942	COLONIA PERIN	\N
134	54	6943	COLONIA RECONQUISTA	\N
134	54	6944	CORONEL ENRIQUE ROSTAGNO	\N
134	54	6945	DOCTOR CARLOS MONTAG	\N
134	54	6946	EL OCULTO	\N
134	54	6947	IBARRETA	\N
134	54	6948	LA INMACULADA	\N
134	54	6949	LAZO QUEMADO	\N
134	54	6950	LEGUA A	\N
134	54	6951	MAESTRA BLANCA GOMEZ	\N
134	54	6952	SOLDADO DANTE SALVATIERRA	\N
134	54	6953	SOLDADO ISMAEL SANCHEZ	\N
134	54	6954	SUBTENIENTE PERIN	\N
134	54	6955	VILLA ADELAIDA	\N
134	54	6956	ALOLAGUE	\N
134	54	6957	COLONIA JUAN BAUTISTA ALBERDI	\N
134	54	6958	COLONIA JUANITA	\N
134	54	6959	COLONIA LA BRAVA	\N
134	54	6960	COLONIA SAN JOSE	\N
134	54	6961	COLONIA UNION ESCUELA	\N
134	54	6962	EL RECREO	\N
134	54	6963	ESTANISLAO DEL CAMPO	\N
134	54	6964	GABRIELA MISTRAL	\N
134	54	6965	HERMINDO BONAS	\N
134	54	6966	JUAN JOSE PASO	\N
134	54	6967	LAS CHOYAS	\N
134	54	6968	LAS MOCHAS	\N
134	54	6969	LOMA CLAVEL	\N
134	54	6970	LOS INMIGRANTES	\N
134	54	6971	PATO MARCADO	\N
134	54	6972	RANERO CUE	\N
134	54	6973	SAN LORENZO	\N
134	54	6974	SATURNINO SEGUROLA	\N
134	54	6975	TRANSITO CUE	\N
134	54	6976	EL SAUCE	\N
134	54	6977	LA PALOMA	\N
134	54	6978	LOS ESTEROS	\N
134	54	6979	PASO DE NAITE	\N
134	54	6980	POZO DEL TIGRE	\N
134	54	6981	POZO VERDE	\N
134	54	6982	VILLA GRAL. URQUIZA	\N
134	54	6983	COLONIA FRANCISCO J. MUÑIZ	\N
134	54	6984	EL CEIBAL	\N
134	54	6985	EL DESCANSO	\N
134	54	6986	ISLETA	\N
134	54	6987	JUAN G. BAZAN	\N
134	54	6988	LAS LOMITAS	\N
134	54	6989	LAS SALADAS	\N
134	54	6990	POSTA SARGENTO CABRAL	\N
134	54	6991	POZO DE LAS GARZAS	\N
134	54	6992	QUEBRACHO MARCADO	\N
134	54	6993	SARGENTO AGRAMONTE	\N
134	54	6994	SOLDADO ERMINDO LUNA	\N
134	54	6995	SUIPACHA	\N
134	54	6996	TOMAS GODOY CRUZ	\N
134	54	6997	POSTA CAMBIO A ZALAZAR	\N
134	54	6998	SOLDADO ALBERTO VILLALBA	\N
134	54	6999	LOTE 20 RURAL	\N
134	54	7000	SAN MARTIN II	\N
134	54	7001	B° QOMPI JUAN SOSA	\N
134	54	7002	CACIQUE COQUERO	\N
134	54	7003	CAMPO ALEGRE	\N
134	54	7004	CHICO DOWAGAN	\N
134	54	7005	COL.AB.BME.DE LAS	\N
134	54	7006	COLONIA 20 DE JUNIO	\N
134	54	7007	COLONIA CEFERINO NAMUNCURA	\N
134	54	7008	COLONIA EL ENSANCHE	\N
134	54	7009	COLONIA EL PAVAO	\N
134	54	7010	COLONIA ENSANCHE NORTE	\N
134	54	7011	COLONIA LA PREFERIDA	\N
134	54	7012	COLONIA SAN ROQUE	\N
134	54	7013	COMUNIDAD ABORIGEN LA BOMBA-LAS LOMITAS	\N
134	54	7014	EL DIVISADERO	\N
134	54	7015	EL TIMBO	\N
134	54	7016	KILOMETRO 15	\N
134	54	7017	LA ESTRELLA	\N
134	54	7018	LA MEDIA LUNA	\N
134	54	7019	LA PANTALLA	\N
134	54	7020	LAGO VERDE	\N
134	54	7021	LAQTASATANYIE (KM.14)	\N
134	54	7022	LOMA SAN PABLO	\N
134	54	7023	LOTE 27	\N
134	54	7024	LOTE 47 - LAS LOMITAS	\N
134	54	7025	PARAJE LOS TRES REYES	\N
134	54	7026	PJE.LOS JUBILADOS	\N
134	54	7027	POZO LARGO	\N
134	54	7028	POZO NAVAGAN	\N
134	54	7029	RIACHO DE ORO	\N
134	54	7030	SAN CARLOS	\N
134	54	7031	SAN MARTIN I	\N
134	54	7032	SAN SIMON	\N
134	54	7033	AYUDANTE PAREDES	\N
134	54	7034	EL POMBERO	\N
134	54	7035	FLORENTINO AMEGHINO	\N
134	54	7036	ISLA CARAYA	\N
134	54	7037	LAGUNA GALLO	\N
134	54	7038	MONTE CLARO	\N
134	54	7039	PIGO	\N
134	54	7040	PUNTA PORA	\N
134	54	7041	RODEO TAPITI	\N
134	54	7042	ROZADITO	\N
134	54	7043	SALVACION	\N
134	54	7044	SAN ANTONIO (TRES LAGUNAS)	\N
134	54	7045	CHIROCHILAS	\N
134	54	7046	LA FRONTERA	\N
134	54	7047	LAGUNA INES	\N
134	54	7048	SEGUNDA PUNTA	\N
134	54	7049	APAYEREY	\N
134	54	7050	BELLA VISTA	\N
134	54	7051	CHAGADAY	\N
134	54	7052	ESPINILLO	\N
134	54	7053	GENERAL JULIO DE VEDIA	\N
134	54	7054	JULIO CUE	\N
134	54	7055	LOMA ZAPATU	\N
134	54	7056	LORO CUE	\N
134	54	7057	MISION TACAAGLE	\N
134	54	7058	PORTON NEGRO	\N
134	54	7059	SOLDADO HERIBERTO AVALOS	\N
134	54	7060	TACAAGLE	\N
134	54	7061	VILLA REAL	\N
134	54	7062	COLONIA NUEVA	\N
134	54	7063	ISLA AZUL	\N
134	54	7064	LAGUNA TORO	\N
134	54	7065	PUESTO RAMONA	\N
134	54	7066	VILLA HERMOSA	\N
134	54	7067	VILLA RURAL	\N
134	54	7068	CLORINDA	\N
134	54	7069	ESTANCIA LAS HORQUETAS	\N
134	54	7070	ISLA DE PUEN	\N
134	54	7071	RIACHO NEGRO	\N
134	54	7072	ANGOSTURA	\N
134	54	7073	BOCARIN	\N
134	54	7074	CENTRO FRONTERIZO CLORINDA	\N
134	54	7075	COLONIA BOUVIER	\N
134	54	7076	CURTIEMBRE CUE	\N
134	54	7077	GARCETE CUE	\N
134	54	7078	GOBERNADOR LUNA OLMOS	\N
134	54	7079	ISLA APANGO	\N
134	54	7080	LAGUNA NAICK NECK	\N
134	54	7081	LUCERO CUE	\N
134	54	7082	PALMA SOLA	\N
134	54	7083	PRESIDENTE AVELLANEDA	\N
134	54	7084	PUERTO PILCOMAYO	\N
134	54	7085	RIACHO HE-HE	\N
134	54	7086	SAN JUAN	\N
134	54	7087	SANTA ISABEL	\N
134	54	7088	TORO PASO	\N
134	54	7089	TRES LAGUNAS	\N
134	54	7090	VILLA LUCERO	\N
134	54	7091	COLONIA ALFONSO	\N
134	54	7092	FRONTERA	\N
134	54	7093	LAGUNA BLANCA	\N
134	54	7094	MARCA M	\N
134	54	7095	PRIMERA JUNTA	\N
134	54	7096	SIETE PALMAS	\N
134	54	7097	LA FRONTERA	\N
134	54	7098	EL RECODO	\N
134	54	7099	LOMA HERMOSA	\N
134	54	7100	MARTIN FIERRO	\N
134	54	7101	BUEY MUERTO	\N
134	54	7102	COLONIA LA PRIMAVERA	\N
134	54	7103	COLONIA LOS SANTAFESINOS	\N
134	54	7104	COLONIA SUDAMERICANA	\N
134	54	7105	JOSE MARIA PAZ	\N
134	54	7106	PASO ANGELITO	\N
134	54	7107	SOL DE MAYO	\N
134	54	7108	CAMPO VILLAFAÑE	\N
134	54	7109	EL GATO	\N
134	54	7110	LA PICADITA	\N
134	54	7111	MAYOR VICENTE EDMUNDO VILLAFAÑE	\N
134	54	7112	MERCEDES CUE	\N
134	54	7113	SOLDADO TOMAS SANCHEZ	\N
134	54	7114	COSTA RIO NEGRO	\N
134	54	7115	EL COLORADO	\N
134	54	7116	GENERAL PABLO RICCHIERI	\N
134	54	7117	HIPOLITO VIEYTES	\N
134	54	7118	RACEDO ESCOBAR	\N
134	54	7119	VILLA DOS TRECE	\N
134	54	7120	BARRIO SAN JOSE OBRERO	\N
134	54	7121	CASCO CUE	\N
134	54	7122	COLONIA 5 DE OCTUBRE	\N
134	54	7123	COSTA SALADO	\N
134	54	7124	EL ALGARROBO	\N
134	54	7125	EL GUAJHO	\N
134	54	7126	EL PALMAR	\N
134	54	7127	EL SALADO	\N
134	54	7128	ESTERO GRANDE	\N
134	54	7129	GENDARME VIVIANO GARCETE	\N
134	54	7130	JOSE HERNANDEZ	\N
134	54	7131	LA LOMA	\N
134	54	7132	PALMAR CHICO	\N
134	54	7133	PARA TODO	\N
134	54	7134	PILAGAS III	\N
134	54	7135	PIRANE	\N
134	54	7136	AGENTE ARGENTINO ALEGRE	\N
134	54	7137	DESVIO LOS MATACOS	\N
134	54	7138	LAGUNA MURUA	\N
134	54	7139	PALO SANTO	\N
134	54	7140	POTRERO NORTE	\N
134	54	7141	LA URBANA	\N
134	54	7142	COLONIA LA SOCIEDAD	\N
134	54	7143	POZO DEL MAZA	\N
134	54	7144	COLONIA EL ALBA	\N
134	54	7145	KILOMETRO 142	\N
134	54	7146	KILOMETRO 210	\N
134	54	7147	VILLA KILOMETRO 213	\N
134	54	7148	9 DE JULIO	\N
134	54	7149	BAÑADERO	\N
134	54	7150	CABO PRIMERO NOROÑA	\N
134	54	7151	CAMPO HARDY	\N
134	54	7152	CENTRO FORESTAL PIRANE	\N
134	54	7153	COLONIA EL CHAJA	\N
134	54	7154	COLONIA EL COMIENZO	\N
134	54	7155	COLONIA EL OLVIDO	\N
134	54	7156	COLONIA EL PALMAR	\N
134	54	7157	COLONIA EL PROGRESO	\N
134	54	7158	COLONIA EL RINCON	\N
134	54	7159	COLONIA LA UNION	\N
134	54	7160	COLONIA LAS LOMITAS	\N
134	54	7161	COLONIA LOMA SENES	\N
134	54	7162	COLONIA RIGONATO	\N
134	54	7163	COLONIA RODA	\N
134	54	7164	COLONIA SANTA CRUZ	\N
134	54	7165	COPO BLANCO	\N
134	54	7166	COSTA RIACHO ALAZAN	\N
134	54	7167	EL BOSQUECILLO	\N
134	54	7168	EL COATI	\N
134	54	7169	EL IBAGAY	\N
134	54	7170	EL PIQUETE	\N
134	54	7171	EL POI	\N
134	54	7172	EL RESGUARDO	\N
134	54	7173	EL SALADILLO	\N
134	54	7174	LA FLORESTA	\N
134	54	7175	LA SIRENA	\N
134	54	7176	LOTE 11	\N
134	54	7177	MONTE LINDO	\N
134	54	7178	MONTE QUEMADO	\N
134	54	7179	POTRERO ÑANDU	\N
134	54	7180	CARLOS SAAVEDRA LAMAS	\N
134	54	7181	GENERAL ENRIQUE MOSCONI	\N
134	54	7182	MARIA CRISTINA	\N
134	54	7183	SELVA MARIA	\N
134	54	7184	EL POTRILLO	\N
134	54	7185	BARRIO EL FAVORITO	\N
134	54	7186	EL BREAL	\N
134	54	7187	EL QUEBRACHO	\N
134	54	7188	SAN MARTIN	\N
135	54	7189	SAN JOSE DEL CHAÑI	\N
135	54	7190	ABRALAITE	\N
135	54	7191	ABRA PAMPA	\N
135	54	7192	AGUA CHICA	\N
135	54	7193	ARBOLITO NUEVO	\N
135	54	7194	CATARI	\N
135	54	7195	CHOROJRA	\N
135	54	7196	ESTACION ZOOTECNICA	\N
135	54	7197	MIRAFLORES DE LA CANDELARIA	\N
135	54	7198	RUMI CRUZ	\N
135	54	7199	SANTUARIO	\N
135	54	7200	SAYATE	\N
135	54	7201	TABLADITAS	\N
135	54	7202	ABDON CASTRO TOLAY	\N
135	54	7203	AGUA CALIENTE DE LA PUNA	\N
135	54	7204	BARRANCAS	\N
135	54	7205	CASABINDO	\N
135	54	7206	COCHINOCA	\N
135	54	7207	DONCELLAS	\N
135	54	7208	EL POTRERO DE LA PUNA	\N
135	54	7209	MUÑAYOC	\N
135	54	7210	QUETA	\N
135	54	7211	QUICHAGUA	\N
135	54	7212	RACHAITE	\N
135	54	7213	RINCONADILLAS	\N
135	54	7214	SAN FRANCISCO DE ALFARCITO	\N
135	54	7215	SANTA ANA DE LA PUNA	\N
135	54	7216	TAMBILLOS	\N
135	54	7217	TUSAQUILLAS	\N
135	54	7218	CASA COLORADA	\N
135	54	7219	PUESTO DEL MARQUES	\N
135	54	7220	RONTUYOC	\N
135	54	7221	CASTI	\N
135	54	7222	AGUAS CALIENTES	\N
135	54	7223	SAN RAFAEL	\N
135	54	7224	LAVAYEN	\N
135	54	7225	SAN JUANCITO	\N
135	54	7226	PALO BLANCO	\N
135	54	7227	EL CHUCUPAL	\N
135	54	7228	EL SUNCHAL	\N
135	54	7229	LA CIENAGA	\N
135	54	7230	LAS PIRCAS	\N
135	54	7231	LOS CEDROS	\N
135	54	7232	PERICO	\N
135	54	7233	EL TOBA	\N
135	54	7234	LAS PICHANAS	\N
135	54	7235	LOS LAPACHOS	\N
135	54	7236	LOS MANANTIALES	\N
135	54	7237	MAQUINISTA VERON	\N
135	54	7238	PAMPA BLANCA	\N
135	54	7239	PAMPA VIEJA	\N
135	54	7240	ALTO VERDE	\N
135	54	7241	BORDO LA ISLA	\N
135	54	7242	CAMPO LA TUNA	\N
135	54	7243	CHAMICAL	\N
135	54	7244	CORONEL ARIAS	\N
135	54	7245	EL CADILLAL	\N
135	54	7246	EL PONGO	\N
135	54	7247	ESTACION PERICO	\N
135	54	7248	LA OVEJERIA	\N
135	54	7249	LA UNION	\N
135	54	7250	LAS PAMPITAS	\N
135	54	7251	MONTE RICO	\N
135	54	7252	SAN VICENTE	\N
135	54	7253	SANTO DOMINGO	\N
135	54	7254	PUEBLO VIEJO	\N
135	54	7255	EL CARMEN	\N
135	54	7256	ALTO COMEDERO	\N
135	54	7257	LA CUESTA	\N
135	54	7258	SAN SALVADOR DE JUJUY	\N
135	54	7259	TILQUIZA	\N
135	54	7260	GUERRERO	\N
135	54	7261	REYES	\N
135	54	7262	TERMAS DE REYES	\N
135	54	7263	LAGUNAS DE YALA	\N
135	54	7264	LEON	\N
135	54	7265	LOZANO	\N
135	54	7266	MOLINOS	\N
135	54	7267	TIRAXI	\N
135	54	7268	YALA	\N
135	54	7269	PUCARA	\N
135	54	7270	CHUCALEZNA	\N
135	54	7271	SENADOR PEREZ	\N
135	54	7272	UQUIA	\N
135	54	7273	CHORRILLOS	\N
135	54	7274	CORAYA	\N
135	54	7275	HORNADITAS	\N
135	54	7276	HUMAHUACA	\N
135	54	7277	OCUMAZO	\N
135	54	7278	OVARA	\N
135	54	7279	SAN ROQUE	\N
135	54	7280	APARZO	\N
135	54	7281	BALIAZO	\N
135	54	7282	CHORCAN	\N
135	54	7283	CIANZO	\N
135	54	7284	COCTACA	\N
135	54	7285	DOGLONZO	\N
135	54	7286	PALCA DE APARZO	\N
135	54	7287	RODERO	\N
135	54	7288	RONQUE	\N
135	54	7289	VARAS	\N
135	54	7290	AZUL PAMPA	\N
135	54	7291	CASILLAS	\N
135	54	7292	CHAUPI RODEO	\N
135	54	7293	ITURBE	\N
135	54	7294	LA CUEVA	\N
135	54	7295	MIYUYOC	\N
135	54	7296	EL AGUILAR	\N
135	54	7297	TEJADAS	\N
135	54	7298	TRES CRUCES	\N
135	54	7299	VETA MINA AGUILAR	\N
135	54	7300	CARAYOC	\N
135	54	7301	HIPOLITO YRIGOYEN	\N
135	54	7302	23 DE AGOSTO	\N
135	54	7303	RIO NEGRO	\N
135	54	7304	CHALICAN	\N
135	54	7305	FRAILE PINTADO	\N
135	54	7306	GUAYACAN	\N
135	54	7307	LA BAJADA	\N
135	54	7308	ARENAL BARROSO	\N
135	54	7309	INGENIO LEDESMA	\N
135	54	7310	LEDESMA	\N
135	54	7311	LIBERTADOR GENERAL SAN MARTIN	\N
135	54	7312	NORMENTA	\N
135	54	7313	PUEBLO LEDESMA	\N
135	54	7314	ALTO CALILEGUA	\N
135	54	7315	CALILEGUA	\N
135	54	7316	CAIMANCITO	\N
135	54	7317	YUTO	\N
135	54	7318	EL ALGARROBAL	\N
135	54	7319	EL CUCHO	\N
135	54	7320	LAS CAPILLAS	\N
135	54	7321	LAS ESCALERAS	\N
135	54	7322	LOS BLANCOS	\N
135	54	7323	CARAHUNCO	\N
135	54	7324	CENTRO FORESTAL	\N
135	54	7325	CERROS ZAPLA	\N
135	54	7326	EL BRETE	\N
135	54	7327	EL REMATE	\N
135	54	7328	MINA 9 DE OCTUBRE	\N
135	54	7329	PALPALA	\N
135	54	7330	CARAHUASI	\N
135	54	7331	CIENAGO GRANDE	\N
135	54	7332	COYAGUAIMA	\N
135	54	7333	LOMA BLANCA	\N
135	54	7334	MINA PIRQUITAS	\N
135	54	7335	OROSMAYO	\N
135	54	7336	PAICONE	\N
135	54	7337	PAN DE AZUCAR	\N
135	54	7338	POZUELO	\N
135	54	7339	RINCONADA	\N
135	54	7340	HUALLATAYOC	\N
135	54	7341	LOS ALISOS	\N
135	54	7342	CEIBAL	\N
135	54	7343	CERRO NEGRO	\N
135	54	7344	LA TOMA	\N
135	54	7345	PERICO DE SAN ANTONIO	\N
135	54	7346	RIO BLANCO	\N
135	54	7347	RODEITOS	\N
135	54	7348	SAN JOSE DEL BORDO	\N
135	54	7349	SAN LUCAS (SAN PEDRO-DPTO. SAN PEDRO)	\N
135	54	7350	SAN PEDRO	\N
135	54	7351	ARROYO COLORADO	\N
135	54	7352	SAN JUAN DE DIOS	\N
135	54	7353	INGENIO LA ESPERANZA	\N
135	54	7354	LA ESPERANZA	\N
135	54	7355	LOTE ARRAYANAL	\N
135	54	7356	EL PUESTO	\N
135	54	7357	MIRAFLORES	\N
135	54	7358	LOTE PALMERA	\N
135	54	7359	PARAPETI	\N
135	54	7360	SAN ANTONIO	\N
135	54	7361	EL QUEMADO	\N
135	54	7362	ARRAYANAL	\N
135	54	7363	BARRO NEGRO	\N
135	54	7364	LA MENDIETA	\N
135	54	7365	LOTE DON DAVID	\N
135	54	7366	DON EMILIO	\N
135	54	7367	PIEDRITAS	\N
135	54	7368	SAUZAL	\N
135	54	7369	SANTA RITA	\N
135	54	7370	EL ARENAL	\N
135	54	7371	EL FUERTE	\N
135	54	7372	EL PIQUETE	\N
135	54	7373	ISLA CHICA	\N
135	54	7374	ISLA GRANDE	\N
135	54	7375	PALMA SOLA	\N
135	54	7376	PUESTO NUEVO	\N
135	54	7377	REAL DE LOS TOROS	\N
135	54	7378	SANTA CLARA	\N
135	54	7379	SIETE AGUAS	\N
135	54	7380	LEACHS	\N
135	54	7381	VINALITO	\N
135	54	7382	EL PALMAR DE SAN FRANCISCO	\N
135	54	7383	EL TALAR	\N
135	54	7384	PUESTO VIEJO	\N
135	54	7385	CASIRA	\N
135	54	7386	CERRITO	\N
135	54	7387	CIENEGUILLAS	\N
135	54	7388	HORNILLOS (PUESTO GRANDE-DPTO. SANTA CATALINA)	\N
135	54	7389	PASAJES	\N
135	54	7390	PASTO PAMPA	\N
135	54	7391	PUESTO CHICO	\N
135	54	7392	PUESTO GRANDE	\N
135	54	7393	RODEO	\N
135	54	7394	TOQUERO	\N
135	54	7395	YOSCABA	\N
135	54	7396	CABRERIA	\N
135	54	7397	LA CRUZ	\N
135	54	7398	ORATORIO	\N
135	54	7399	PISCUNO	\N
135	54	7400	SAN FRANCISCO (SANTA CATALINA-DPTO. SANTA CATALINA)	\N
135	54	7401	SAN LEON	\N
135	54	7402	SANTA CATALINA	\N
135	54	7403	TIMON CRUZ	\N
135	54	7404	SEY	\N
135	54	7405	CATUA	\N
135	54	7406	HUANCAR	\N
135	54	7407	OLAROZ CHICO	\N
135	54	7408	SAN JUAN DE QUILLAQUES	\N
135	54	7409	SUSQUES	\N
135	54	7410	CORANZULLI	\N
135	54	7411	EL TORO	\N
135	54	7412	SAN PEDRITO	\N
135	54	7413	HORNILLOS (MAIMARA-DPTO. TILCARA)	\N
135	54	7414	MAIMARA	\N
135	54	7415	ABRA MAYO	\N
135	54	7416	ALFARCITO	\N
135	54	7417	EL DURAZNO	\N
135	54	7418	HUICHAIRA	\N
135	54	7419	JUELLA	\N
135	54	7420	MOLULO	\N
135	54	7421	QUEBRADA HUASAMAYO	\N
135	54	7422	TILCARA	\N
135	54	7423	HUACALERA	\N
135	54	7424	VILLA DEL PERCHEL	\N
135	54	7425	JUJUY	\N
135	54	7426	BARCENA	\N
135	54	7427	BOMBA	\N
135	54	7428	CHILCAYOC	\N
135	54	7429	TESORERO	\N
135	54	7430	VOLCAN	\N
135	54	7431	AGUADITA	\N
135	54	7432	COLORADOS	\N
135	54	7433	EL MORENO	\N
135	54	7434	HUACHICHOCANA	\N
135	54	7435	LA AGUADITA	\N
135	54	7436	LA CIENAGA	\N
135	54	7437	PUERTA DE LIPAN	\N
135	54	7438	PUNA DE JUJUY	\N
135	54	7439	PUNTA CORRAL	\N
135	54	7440	PURMAMARCA	\N
135	54	7441	SAN BERNARDO	\N
135	54	7442	TRES MORROS	\N
135	54	7443	TUMBAYA	\N
135	54	7444	TUMBAYA GRANDE	\N
135	54	7445	TUNALITO	\N
135	54	7446	EL ANGOSTO	\N
135	54	7447	SAN FRANCISCO	\N
135	54	7448	PAMPICHUELA	\N
135	54	7449	SAN LUCAS (DPTO. VALLE GRANDE)	\N
135	54	7450	SANTA BARBARA	\N
135	54	7451	VALLE GRANDE	\N
135	54	7452	OCLOYAS	\N
135	54	7453	YALA DE MONTE CARMELO	\N
135	54	7454	CASPALA	\N
135	54	7455	SANTA ANA	\N
135	54	7456	VALLE COLORADO	\N
135	54	7457	CANGREJILLOS	\N
135	54	7458	CANGREJOS	\N
135	54	7459	CARACARA	\N
135	54	7460	CHOCOITE	\N
135	54	7461	EL CONDOR	\N
135	54	7462	ESCAYA	\N
135	54	7463	MAYINTE	\N
135	54	7464	MINA BELGICA	\N
135	54	7465	MINA SAN FRANCISCO	\N
135	54	7466	PUMAHUASI	\N
135	54	7467	REDONDA	\N
135	54	7468	RIO COLORADO	\N
135	54	7469	BARRIOS	\N
135	54	7470	LA CIENAGA (LA QUIACA-DPTO. YAVI)	\N
135	54	7471	LA QUIACA	\N
135	54	7472	SANSANA	\N
135	54	7473	TAFNA	\N
135	54	7474	INTICANCHA	\N
135	54	7475	SURIPUJIO	\N
135	54	7476	VISCACHANI	\N
135	54	7477	YAVI	\N
135	54	7478	YAVI CHICO	\N
135	54	7479	LA INTERMEDIA	\N
135	54	7480	LLULLUCHAYOC	\N
136	54	7481	CEREALES	\N
136	54	7482	COLONIA AGUIRRE	\N
136	54	7483	COLONIA MARIA LUISA	\N
136	54	7484	COLONIA SAN VICTORIO	\N
136	54	7485	COLONIA SOBADELL	\N
136	54	7486	LA DOLORES	\N
136	54	7487	LOS QUINIENTOS	\N
136	54	7488	MIGUEL RIGLOS	\N
136	54	7489	POTRILLO OSCURO	\N
136	54	7490	TOMAS M. DE ANCHORENA	\N
136	54	7491	ATREUCO	\N
136	54	7492	BELLA VISTA	\N
136	54	7493	DOBLAS	\N
136	54	7494	EL DESLINDE	\N
136	54	7495	EL PALOMAR	\N
136	54	7496	HIPOLITO YRIGOYEN	\N
136	54	7497	LA CATALINITA	\N
136	54	7498	LA MANUELITA	\N
136	54	7499	LA NUEVA PROVINCIA	\N
136	54	7500	LA SARITA	\N
136	54	7501	LAS FELICITAS	\N
136	54	7502	LOS DOS HERMANOS	\N
136	54	7503	OJO DE AGUA	\N
136	54	7504	ROLON	\N
136	54	7505	SANTA STELLA	\N
136	54	7506	COLONIA LA ORACION	\N
136	54	7507	EL CENTENARIO	\N
136	54	7508	HIDALGO	\N
136	54	7509	LA ANTONIA	\N
136	54	7510	LA JOSEFINA	\N
136	54	7511	MACACHIN	\N
136	54	7512	SANTO TOMAS	\N
136	54	7513	LA BILBAINA	\N
136	54	7514	ANZOATEGUI	\N
136	54	7515	CALEU CALEU	\N
136	54	7516	GAVIOTAS	\N
136	54	7517	COLONIA SAN ROSARIO	\N
136	54	7518	LA ADELA	\N
136	54	7519	COLONIA LAGOS	\N
136	54	7520	EL MIRADOR DE JUAREZ	\N
136	54	7521	EL OASIS	\N
136	54	7522	LA FORTUNA	\N
136	54	7523	LA MALVINA	\N
136	54	7524	LAS MALVINAS	\N
136	54	7525	LOS NOGALES	\N
136	54	7526	MEDANO BLANCO	\N
136	54	7527	SANTA ROSA	\N
136	54	7528	COLONIA ECHETA	\N
136	54	7529	INES Y CARLOTA	\N
136	54	7530	ANGUIL	\N
136	54	7531	COLONIA TORELLO	\N
136	54	7532	LA CAROLA	\N
136	54	7533	LA ELVIRA	\N
136	54	7534	SAN CARLOS	\N
136	54	7535	COLONIA LA GAVIOTA	\N
136	54	7536	CATRILO	\N
136	54	7537	CAYUPAN	\N
136	54	7538	IVANOWSKY	\N
136	54	7539	LA BLANCA	\N
136	54	7540	LA PUNA	\N
136	54	7541	LA REBECA	\N
136	54	7542	LA UNIDA	\N
136	54	7543	SAN EDUARDO	\N
136	54	7544	SAN JUSTO	\N
136	54	7545	EL MALACATE	\N
136	54	7546	LA MATILDE	\N
136	54	7547	LA GLORIA	\N
136	54	7548	COLONIA SAN MIGUEL	\N
136	54	7549	EL BRILLANTE	\N
136	54	7550	EL GUAICURU	\N
136	54	7551	EL RUBI	\N
136	54	7552	EL SALITRAL	\N
136	54	7553	EL TRIUNFO	\N
136	54	7554	LA ATALAYA	\N
136	54	7555	LA CELIA	\N
136	54	7556	LA PERLA	\N
136	54	7557	LA PERLITA	\N
136	54	7558	LA SEGUNDA	\N
136	54	7559	LA VIOLETA	\N
136	54	7560	LONQUIMAY	\N
136	54	7561	PUEBLO QUINTANA	\N
136	54	7562	SAN MANUEL	\N
136	54	7563	LA CARMEN	\N
136	54	7564	LA CUMBRE	\N
136	54	7565	LA LUISA	\N
136	54	7566	LA MARIANITA	\N
136	54	7567	LA SUERTE	\N
136	54	7568	LA TRINIDAD	\N
136	54	7569	LAS GAVIOTAS	\N
136	54	7570	SAN ANDRES	\N
136	54	7571	URIBURU	\N
136	54	7572	SAN FELIPE	\N
136	54	7573	COLONIA ESPIGA DE ORO	\N
136	54	7574	COLONIA LA PAZ	\N
136	54	7575	COLONIA SAN FELIPE	\N
136	54	7576	COLONIA SANTA ELENA	\N
136	54	7577	EL FURLONG	\N
136	54	7578	LA DELFINA	\N
136	54	7579	WINIFREDA	\N
136	54	7580	MAURICIO MAYER	\N
136	54	7581	LA PAZ	\N
136	54	7582	SANTA ELENA	\N
136	54	7583	BOEUF	\N
136	54	7584	CHACRA 16	\N
136	54	7585	COLONIA SAN LORENZO	\N
136	54	7586	EDUARDO CASTEX	\N
136	54	7587	NICOLAS VERA	\N
136	54	7588	ZONA URBANA NORTE	\N
136	54	7589	CAMPO CARETTO	\N
136	54	7590	CAMPO PICO	\N
136	54	7591	COLONIA EL DESTINO	\N
136	54	7592	COLONIAS DRYSDALE	\N
136	54	7593	COLONIAS MURRAY	\N
136	54	7594	CONHELO	\N
136	54	7595	EL PELUDO	\N
136	54	7596	LAS CHACRAS	\N
136	54	7597	LOO CO	\N
136	54	7598	RUCANELO	\N
136	54	7599	CAMPO MOISES	\N
136	54	7600	MONTE NIEVAS	\N
136	54	7601	SAN RAMON	\N
136	54	7602	SECCION PRIMERA CONHELO	\N
136	54	7603	CERRO DEL AIGRE	\N
136	54	7604	EL DIEZ Y SIETE	\N
136	54	7605	EL NUEVE	\N
136	54	7606	EL TARTAGAL	\N
136	54	7607	EL TRECE	\N
136	54	7608	EL UNO	\N
136	54	7609	EUSKADI	\N
136	54	7610	LA CLELIA	\N
136	54	7611	LA LIMPIA	\N
136	54	7612	LA REFORMA VIEJA	\N
136	54	7613	LEGASA	\N
136	54	7614	MINERALES DE LA PAMPA	\N
136	54	7615	PUELCHES	\N
136	54	7616	SAN ROBERTO	\N
136	54	7617	GOBERNADOR DUVAL	\N
136	54	7618	LA JAPONESA	\N
136	54	7619	SAN FRANCISCO	\N
136	54	7620	ARBOL DE LA ESPERANZA	\N
136	54	7621	ARBOL SOLO	\N
136	54	7622	CHICALCO	\N
136	54	7623	COLONIA LA PASTORIL	\N
136	54	7624	CURRU MAHUIDA	\N
136	54	7625	LA SOLEDAD	\N
136	54	7626	LOS TAJAMARES	\N
136	54	7627	PASO DE LOS ALGARROBOS	\N
136	54	7628	PASO DE LOS PUNTANOS	\N
136	54	7629	PASO LA RAZON	\N
136	54	7630	SANTA ISABEL	\N
136	54	7631	VISTA ALEGRE	\N
136	54	7632	BERNARDO LARROUDE	\N
136	54	7633	COLONIA TRENQUENDA	\N
136	54	7634	COLONIA TREQUEN	\N
136	54	7635	EL ANTOJO	\N
136	54	7636	EL RECREO	\N
136	54	7637	SANTA FELICITAS	\N
136	54	7638	CEBALLOS	\N
136	54	7639	COLONIA LAS MERCEDES	\N
136	54	7640	INTENDENTE ALVEAR	\N
136	54	7641	LA PAULINA	\N
136	54	7642	AGUAS BUENAS	\N
136	54	7643	COLONIA DENEVI	\N
136	54	7644	CORONEL HILARIO LAGOS	\N
136	54	7645	GALLINAO	\N
136	54	7646	LA ENERGIA	\N
136	54	7647	LA INVERNADA	\N
136	54	7648	LA PRADERA	\N
136	54	7649	MARIANO MIRO	\N
136	54	7650	RAMON SEGUNDO	\N
136	54	7651	SAN URBANO	\N
136	54	7652	SARAH	\N
136	54	7653	TRES LAGUNAS	\N
136	54	7654	SANTA AURELIA	\N
136	54	7655	VERTIZ	\N
136	54	7656	ZONA RURAL DE VERTIZ	\N
136	54	7657	AGUA DE TORRE	\N
136	54	7658	ALGARROBO DEL AGUILA	\N
136	54	7659	ESTABLECIMIENTO EL CENTINELA	\N
136	54	7660	LA HUMADA	\N
136	54	7661	LA IMARRA	\N
136	54	7662	LA VEINTITRES	\N
136	54	7663	ALPACHIRI	\N
136	54	7664	CAMPO URDANIZ	\N
136	54	7665	COLONIA ANASAGASTI	\N
136	54	7666	GENERAL MANUEL CAMPOS	\N
136	54	7667	LA MARIA ROSA	\N
136	54	7668	MONTE RALO	\N
136	54	7669	SALINAS MARI MANUEL	\N
136	54	7670	CAMPO DE LOS TOROS	\N
136	54	7671	CAMPO LA FLORIDA	\N
136	54	7672	COLONIA LA ESPERANZA	\N
136	54	7673	COLONIA LOS TOROS	\N
136	54	7674	COLONIA LUNA	\N
136	54	7675	COLONIA SANTA TERESA	\N
136	54	7676	GUATRACHE	\N
136	54	7677	LA PIEDAD	\N
136	54	7678	LAS QUINTAS	\N
136	54	7679	REMECO	\N
136	54	7680	LA ELVA	\N
136	54	7681	LA MARIA ELENA	\N
136	54	7682	PERU	\N
136	54	7683	PICHE CONA LAUQUEN	\N
136	54	7684	EL PUMA	\N
136	54	7685	LA TORERA	\N
136	54	7686	LA ESTRELLA	\N
136	54	7687	BERNASCONI	\N
136	54	7688	COLONIA HELVECIA	\N
136	54	7689	COLONIA VILLA ALBA	\N
136	54	7690	EL TRIGO	\N
136	54	7691	EL VASQUITO	\N
136	54	7692	GENERAL SAN MARTIN	\N
136	54	7693	LA COLORADA CHICA	\N
136	54	7694	LA COLORADA GRANDE	\N
136	54	7695	LA PRIMERA	\N
136	54	7696	MINAS DE SAL	\N
136	54	7697	TRAICO	\N
136	54	7698	VILLA ALBA	\N
136	54	7699	CAMPO CICARE	\N
136	54	7700	CAMPO DE SALAS	\N
136	54	7701	CAMPO NICHOLSON	\N
136	54	7702	COLONIA BEATRIZ	\N
136	54	7703	COLONIA VASCONGADA	\N
136	54	7704	JACINTO ARAUZ	\N
136	54	7705	TRAICO GRANDE	\N
136	54	7706	ABRAMO	\N
136	54	7707	COTITA	\N
136	54	7708	DOS VIOLETAS	\N
136	54	7709	EL LUCERO	\N
136	54	7710	HUCAL	\N
136	54	7711	LA ADMINISTRACION	\N
136	54	7712	LA CATITA	\N
136	54	7713	LA ESTRELLA DEL SUD	\N
136	54	7714	LA MARIA ELISA	\N
136	54	7715	SAN AQUILINO	\N
136	54	7716	SAN DIEGO	\N
136	54	7717	TRES BOTONES	\N
136	54	7718	TRES NACIONES	\N
136	54	7719	TRIBULUCI	\N
136	54	7720	TRUBULUCO	\N
136	54	7721	EL BOQUERON	\N
136	54	7722	LAS DOS NACIONES	\N
136	54	7723	SIERRAS DE LIHUEL CALEL	\N
136	54	7724	LA ASTURIANA	\N
136	54	7725	LIHUE CALEL	\N
136	54	7726	CUCHILLO CO	\N
136	54	7727	LA REFORMA	\N
136	54	7728	LIMAY MAHUIDA	\N
136	54	7729	LA FLORENCIA	\N
136	54	7730	LOVENTUE	\N
136	54	7731	LUAN TORO	\N
136	54	7732	CARRO QUEMADO	\N
136	54	7733	CHACRAS DE VICTORICA	\N
136	54	7734	EL DURAZNO	\N
136	54	7735	GUADALOZA	\N
136	54	7736	LA MOROCHA	\N
136	54	7737	LABAL	\N
136	54	7738	POITAGUE	\N
136	54	7739	VICTORICA	\N
136	54	7740	CAICHUE	\N
136	54	7741	COLONIA EL PORVENIR	\N
136	54	7742	COSTA DEL SALADO	\N
136	54	7743	EL MATE	\N
136	54	7744	EL ODRE	\N
136	54	7745	EL REFUGIO	\N
136	54	7746	EL RETIRO	\N
136	54	7747	EL SILENCIO	\N
136	54	7748	JAGUEL DEL ESQUINERO	\N
136	54	7749	JAGUEL DEL MONTE	\N
136	54	7750	JUZGADO VIEJO	\N
136	54	7751	LA CIENAGA	\N
136	54	7752	LA ELENITA	\N
136	54	7753	LA ELIA	\N
136	54	7754	LA EULOGIA	\N
136	54	7755	LA FE	\N
136	54	7756	LA GUADALOSA	\N
136	54	7757	LA LAURENTINA	\N
136	54	7758	LA LUZ	\N
136	54	7759	LA MARCELA	\N
136	54	7760	LA PENCOSA	\N
136	54	7761	LA TINAJERA	\N
136	54	7762	LEONA REDONDA	\N
136	54	7763	LOMA REDONDA	\N
136	54	7764	LOMAS DE GATICA	\N
136	54	7765	LOMAS OMBU	\N
136	54	7766	LOS MANANTIALES	\N
136	54	7767	LOS TRES POZOS	\N
136	54	7768	MAYACO	\N
136	54	7769	NAHUEL NAPA	\N
136	54	7770	NANQUEL HUITRE	\N
136	54	7771	SAN EMILIO	\N
136	54	7772	TELEN	\N
136	54	7773	COLONIA LA CARLOTA	\N
136	54	7774	EL BELGICA	\N
136	54	7775	EL PARQUE	\N
136	54	7776	LA ELSA	\N
136	54	7777	LAS TRES HERMANAS	\N
136	54	7778	PAVON	\N
136	54	7779	RUCAHUE	\N
136	54	7780	SAN ALBERTO	\N
136	54	7781	SAN BENITO	\N
136	54	7782	BARRIO EL MOLINO	\N
136	54	7783	CARLOS BERG	\N
136	54	7784	GENERAL PICO	\N
136	54	7785	LA CHAPELLE	\N
136	54	7786	MOCOVI	\N
136	54	7787	SANTA INES	\N
136	54	7788	AGUSTONI	\N
136	54	7789	CAIMI	\N
136	54	7790	LA GAVENITA	\N
136	54	7791	LA TERESITA	\N
136	54	7792	TREBOLARES	\N
136	54	7793	DORILA	\N
136	54	7794	LA BARRANCOSA	\N
136	54	7795	SAN ILDEFONSO	\N
136	54	7796	SANTA CATALINA	\N
136	54	7797	SPELUZZI	\N
136	54	7798	ARGENTINA BELVEDERE	\N
136	54	7799	MARACO	\N
136	54	7800	EL ESCABEL	\N
136	54	7801	PUELEN	\N
136	54	7802	SAN SALVADOR	\N
136	54	7803	25 DE MAYO	\N
136	54	7804	COLONIA GOBERNADOR AYALA	\N
136	54	7805	LA COPELINA	\N
136	54	7806	PASO LA BALSA	\N
136	54	7807	VILLA CASA DE PIEDRA	\N
136	54	7808	COLONIA BARON	\N
136	54	7809	COLONIA SAN JOSE	\N
136	54	7810	LOS PIRINEOS	\N
136	54	7811	VILLA MIRASOL	\N
136	54	7812	VILLA SAN JOSE	\N
136	54	7813	ZONA RURAL DE MIRASOL	\N
136	54	7814	COLONIA BEAUFORT	\N
136	54	7815	COLONIA GIUSTI	\N
136	54	7816	CURILCO	\N
136	54	7817	MIGUEL CANE	\N
136	54	7818	RELMO	\N
136	54	7819	ALFREDO PEÑA	\N
136	54	7820	COLONIA LA ABUNDANCIA	\N
136	54	7821	COLONIA LA SARA	\N
136	54	7822	COLONIA SANTA CECILIA	\N
136	54	7823	HUELEN	\N
136	54	7824	LA CAUTIVA	\N
136	54	7825	LA DELICIA	\N
136	54	7826	LA ENRIQUETA	\N
136	54	7827	LA OLLA	\N
136	54	7828	QUEMU QUEMU	\N
136	54	7829	SOL DE MAYO	\N
136	54	7830	TRILI	\N
136	54	7831	EL TIGRE	\N
136	54	7832	EL TAJAMAR	\N
136	54	7833	QUETREQUEN	\N
136	54	7834	PARERA	\N
136	54	7835	COLONIA LA MARGARITA	\N
136	54	7836	COLONIA SAN BASILIO	\N
136	54	7837	JARDON	\N
136	54	7838	LA MARGARITA	\N
136	54	7839	RANCUL	\N
136	54	7840	SAN BASILIO	\N
136	54	7841	SAN MARCELO	\N
136	54	7842	COLONIA EL TIGRE	\N
136	54	7843	COLONIA LAS PIEDRITAS	\N
136	54	7844	INGENIERO FOSTER	\N
136	54	7845	LA MARUJA	\N
136	54	7846	PICHI HUINCA	\N
136	54	7847	CALEUFU	\N
136	54	7848	CARAMAN	\N
136	54	7849	LAS PIEDRITAS	\N
136	54	7850	REALICO	\N
136	54	7851	CHANILAO	\N
136	54	7852	EL OLIVO	\N
136	54	7853	EMBAJADOR MARTINI	\N
136	54	7854	INGENIERO LUIGGI	\N
136	54	7855	ALTA ITALIA	\N
136	54	7856	OJEDA	\N
136	54	7857	ADOLFO VAN PRAET	\N
136	54	7858	EL TORDILLO	\N
136	54	7859	FALUCHO	\N
136	54	7860	MAISONNAVE	\N
136	54	7861	SANTA GRACIA	\N
136	54	7862	SIMSON	\N
136	54	7863	CACHIRULO	\N
136	54	7864	CALCHAHUE	\N
136	54	7865	CHACU	\N
136	54	7866	CHAPALCO	\N
136	54	7867	COLONIA FERRARO	\N
136	54	7868	COLONIA RAMON QUINTAS	\N
136	54	7869	COLONIA ROCA	\N
136	54	7870	EL VOLANTE	\N
136	54	7871	LA BAYA	\N
136	54	7872	LA BAYA MUERTA	\N
136	54	7873	LA CELMIRA	\N
136	54	7874	LA VANGUARDIA	\N
136	54	7875	LINDO VER	\N
136	54	7876	NERRE CO	\N
136	54	7877	RAMON QUINTAS	\N
136	54	7878	TOAY	\N
136	54	7879	BAJO DE LAS PALOMAS	\N
136	54	7880	EL EUCALIPTO	\N
136	54	7881	LA AVANZADA	\N
136	54	7882	LA ESTHER	\N
136	54	7883	LOS ALAMOS	\N
136	54	7884	NAICO	\N
136	54	7885	PARQUE LURO	\N
136	54	7886	SAN HUMBERTO	\N
136	54	7887	SANTIAGO ORELLANO	\N
136	54	7888	COLONIA MIGLIORI	\N
136	54	7889	METILEO	\N
136	54	7890	MINISTRO ORLANDO	\N
136	54	7891	CAMPO SALUSSO	\N
136	54	7892	TRENEL	\N
136	54	7893	ARATA	\N
136	54	7894	ATALIVA ROCA	\N
136	54	7895	COLONIA DEVOTO	\N
136	54	7896	COLONIA LA AMARGA	\N
136	54	7897	COLONIA MINISTRO LOBOS	\N
136	54	7898	EL CHILLEN	\N
136	54	7899	COLONIA LIA Y ALLENDE	\N
136	54	7900	EL CARANCHO	\N
136	54	7901	EL MADRIGAL	\N
136	54	7902	EL VERANEO	\N
136	54	7903	GENERAL ACHA	\N
136	54	7904	LA AURORA	\N
136	54	7905	LA BANDERITA	\N
136	54	7906	LA ESCONDIDA	\N
136	54	7907	LA LONJA	\N
136	54	7908	LA MODERNA	\N
136	54	7909	LA NILDA	\N
136	54	7910	LA PALOMA	\N
136	54	7911	LA SORPRESA	\N
136	54	7912	LAS ACACIAS	\N
136	54	7913	LOTE 10	\N
136	54	7914	LOTE 3	\N
136	54	7915	MARACO CHICO	\N
136	54	7916	UTRACAN	\N
136	54	7917	VALLE DAZA	\N
136	54	7918	CERRO AZUL	\N
136	54	7919	CERRO BAYO	\N
136	54	7920	CERRO LA BOTA	\N
136	54	7921	CHACHARRAMENDI	\N
136	54	7922	QUEHUE	\N
136	54	7923	COLONIA CAZAUX	\N
136	54	7924	COLONIA LA MUTUA	\N
136	54	7925	COLONIA MEDANO COLORADO	\N
136	54	7926	COLONIA SANTA CLARA	\N
136	54	7927	COLONIA SANTA MARIA	\N
136	54	7928	EL PIMIA	\N
136	54	7929	EPU PEL	\N
136	54	7930	UNANUE	\N
137	54	7931	AIMOGASTA	\N
137	54	7932	BAÑADOS DEL PANTANO	\N
137	54	7933	LOS BALDES	\N
137	54	7934	SAN ANTONIO	\N
137	54	7935	ARAUCO	\N
137	54	7936	MACHIGASTA	\N
137	54	7937	UDPINANGO	\N
137	54	7938	ESTACION MAZAN	\N
137	54	7939	TERMAS SANTA TERESITA	\N
137	54	7940	VILLA MAZAN	\N
137	54	7941	EL MEDANO	\N
137	54	7942	EL ROSARIO	\N
137	54	7943	ESPERANZA DE LOS CERRILLOS	\N
137	54	7944	AMILGANCHO	\N
137	54	7945	BAZAN	\N
137	54	7946	CARRIZAL	\N
137	54	7947	CEBOLLAR	\N
137	54	7948	EL DURAZNILLO	\N
137	54	7949	LA BUENA SUERTE	\N
137	54	7950	LA ESPERANZA	\N
137	54	7951	LA RAMADITA	\N
137	54	7952	LA RIOJA	\N
137	54	7953	POZO DE AVILA	\N
137	54	7954	PUERTA DE LA QUEBRADA	\N
137	54	7955	PUNTA DEL NEGRO	\N
137	54	7956	TRAMPA DEL TIGRE	\N
137	54	7957	ANCHICO	\N
137	54	7958	CAMPO TRES POZOS	\N
137	54	7959	EL BAYITO	\N
137	54	7960	EL ESCONDIDO	\N
137	54	7961	LA ANTIGUA	\N
137	54	7962	LA BUENA ESTRELLA	\N
137	54	7963	LA ROSILLA	\N
137	54	7964	LAS CATAS	\N
137	54	7965	LAS SIERRAS BRAVAS	\N
137	54	7966	MESILLAS BLANCAS	\N
137	54	7967	POZO BLANCO	\N
137	54	7968	POZO DE LA YEGUA	\N
137	54	7969	PUERTO DEL VALLE	\N
137	54	7970	SAN ANTONIO	\N
137	54	7971	SAN IGNACIO	\N
137	54	7972	SAN LORENZO	\N
137	54	7973	SANTA ANA	\N
137	54	7974	SANTA TERESA	\N
137	54	7975	SIERRA BRAVA	\N
137	54	7976	TALAMUYUNA	\N
137	54	7977	PADERCITAS	\N
137	54	7978	AGUA BLANCA	\N
137	54	7979	AMINGA	\N
137	54	7980	ANILLACO	\N
137	54	7981	CHUQUIS	\N
137	54	7982	ISMIANGO	\N
137	54	7983	LOS MOLINOS	\N
137	54	7984	PINCHAS	\N
137	54	7985	SAN PEDRO	\N
137	54	7986	SANTA VERA CRUZ	\N
137	54	7987	ANJULLON	\N
137	54	7988	EL MOLLE	\N
137	54	7989	LA PERLITA	\N
137	54	7990	LOS FRANCES	\N
137	54	7991	VILLA UNION	\N
137	54	7992	BANDA FLORIDA	\N
137	54	7993	EL FUERTE	\N
137	54	7994	LA MARAVILLA	\N
137	54	7995	LOS PALACIOS	\N
137	54	7996	PASO SAN ISIDRO	\N
137	54	7997	SANTA CLARA	\N
137	54	7998	EL ZAPALLAR	\N
137	54	7999	GUANDACOL	\N
137	54	8000	LOS NACIMIENTOS	\N
137	54	8001	LA PAMPA	\N
137	54	8002	AICUÑA	\N
137	54	8003	LOS TAMBILLOS	\N
137	54	8004	PAGANCILLO	\N
137	54	8005	SAN ISIDRO	\N
137	54	8006	VILLA DE SANTA RITA	\N
137	54	8007	CHAMICAL	\N
137	54	8008	CHULO	\N
137	54	8009	EL RETAMO	\N
137	54	8010	ESQUINA DEL NORTE	\N
137	54	8011	LA SERENA	\N
137	54	8012	LOS BORDOS	\N
137	54	8013	PALO LABRADO	\N
137	54	8014	POLCO	\N
137	54	8015	SANTA LUCIA	\N
137	54	8016	BELLA VISTA	\N
137	54	8017	SANTA BARBARA	\N
137	54	8018	CHILECITO	\N
137	54	8019	LA PUNTILLA	\N
137	54	8020	SAMAY HUASI	\N
137	54	8021	SAN NICOLAS	\N
137	54	8022	SANTA FLORENTINA	\N
137	54	8023	LOS SARMIENTOS	\N
137	54	8024	MALLIGASTA	\N
137	54	8025	SAN MIGUEL	\N
137	54	8026	TILIMUQUI	\N
137	54	8027	ANGUINAN	\N
137	54	8028	CACHIYUYAL	\N
137	54	8029	GUACHIN	\N
137	54	8030	MIRANDA	\N
137	54	8031	SAÑOGASTA	\N
137	54	8032	NONOGASTA	\N
137	54	8033	CATINZACO	\N
137	54	8034	VICHIGASTA	\N
137	54	8035	ALTO CARRIZAL	\N
137	54	8036	ANGULOS	\N
137	54	8037	ANTINACO	\N
137	54	8038	BARRIO DE GALLI	\N
137	54	8039	BUENA VISTA	\N
137	54	8040	CAMPANAS	\N
137	54	8041	CARRIZAL FAMATINA	\N
137	54	8042	CARRIZALILLO	\N
137	54	8043	CHAÑARMUYO	\N
137	54	8044	EL CHOCOY	\N
137	54	8045	EL PEDREGAL	\N
137	54	8046	EL POTRERILLO	\N
137	54	8047	LA HIGUERA	\N
137	54	8048	LOS CORRALES	\N
137	54	8049	PITUIL	\N
137	54	8050	PLAZA VIEJA	\N
137	54	8051	PUERTO ALEGRE	\N
137	54	8052	SANTA CRUZ	\N
137	54	8053	SANTO DOMINGO	\N
137	54	8054	EL JUMIAL	\N
137	54	8055	FAMATINA	\N
137	54	8056	LA BANDA	\N
137	54	8057	LAS GREDAS	\N
137	54	8058	PLAZA NUEVA	\N
137	54	8059	PUNTA DE LOS LLANOS	\N
137	54	8060	ALCAZAR	\N
137	54	8061	CHILA	\N
137	54	8062	TAMA	\N
137	54	8063	TUIZON	\N
137	54	8064	BALDES DE PACHECO	\N
137	54	8065	CASTRO BARROS	\N
137	54	8066	CHAÑAR	\N
137	54	8067	EL BORDO	\N
137	54	8068	EL CHUSCO	\N
137	54	8069	LA FLORIDA	\N
137	54	8070	LAS VERTIENTES	\N
137	54	8071	NEPES	\N
137	54	8072	SIMBOLAR	\N
137	54	8073	VERDE OLIVO	\N
137	54	8074	CORTADERAS	\N
137	54	8075	BAJO GRANDE	\N
137	54	8076	ESQUINA DEL SUD	\N
137	54	8077	ILIAR	\N
137	54	8078	LA HUERTA	\N
137	54	8079	LA TRAMPA	\N
137	54	8080	LOMA BLANCA	\N
137	54	8081	OLTA	\N
137	54	8082	TALA VERDE	\N
137	54	8083	TALVA	\N
137	54	8084	CHIMENEA	\N
137	54	8085	LOMA LARGA	\N
137	54	8086	EL PORTEZUELO	\N
137	54	8087	MALANZAN	\N
137	54	8088	NACATE	\N
137	54	8089	RETAMAL	\N
137	54	8090	SAN ANTONIO	\N
137	54	8091	EL CONDADO	\N
137	54	8092	LAS AGUADITAS	\N
137	54	8093	RIVADAVIA	\N
137	54	8094	VILLA CASTELLI	\N
137	54	8095	ALTILLO DEL MEDIO	\N
137	54	8096	COMANDANTE LEAL	\N
137	54	8097	CUATRO ESQUINAS	\N
137	54	8098	EL FRAILE	\N
137	54	8099	LA IGUALDAD	\N
137	54	8100	LOS BARRIALITOS	\N
137	54	8101	MILAGRO	\N
137	54	8102	POZO DEL MEDIO	\N
137	54	8103	SAN CRISTOBAL	\N
137	54	8104	CATUNA	\N
137	54	8105	COLONIA ORTIZ DE OCAMPO	\N
137	54	8106	DIQUE DE ANZULON	\N
137	54	8107	EL CIENAGO	\N
137	54	8108	EL VERDE	\N
137	54	8109	ESQUINA GRANDE	\N
137	54	8110	FRANCISCO ORTIZ DE OCAMPO	\N
137	54	8111	LAS PALOMAS	\N
137	54	8112	LOS AGUIRRES	\N
137	54	8113	LOS ALANICES	\N
137	54	8114	LOS MISTOLES	\N
137	54	8115	OLPAS	\N
137	54	8116	TORRECITAS	\N
137	54	8117	AGUADITA	\N
137	54	8118	AMBIL	\N
137	54	8119	EL CARRIZAL	\N
137	54	8120	EL CERCO	\N
137	54	8121	EL QUEMADO	\N
137	54	8122	LA DORA	\N
137	54	8123	PIEDRA LARGA	\N
137	54	8124	LA ISLA	\N
137	54	8125	CORRAL DE ISAAC	\N
137	54	8126	EL BALDE	\N
137	54	8127	LA REPRESA	\N
137	54	8128	PUESTO DE CARRIZO	\N
137	54	8129	PUESTO DICHOSO	\N
137	54	8130	AGUAYO	\N
137	54	8131	ALGARROBO GRANDE	\N
137	54	8132	BAJO HONDO	\N
137	54	8133	BALDE DEL QUEBRACHO	\N
137	54	8134	EL ABRA	\N
137	54	8135	EL VALDECITO	\N
137	54	8136	LA AMERICA	\N
137	54	8137	LA CHILCA	\N
137	54	8138	LA ENVIDIA	\N
137	54	8139	NUEVA ESPERANZA	\N
137	54	8140	POZO DE LA PIEDRA	\N
137	54	8141	POZO DE PIEDRA	\N
137	54	8142	SAN SOLANO	\N
137	54	8143	SIEMPRE VERDE	\N
137	54	8144	ULAPES	\N
137	54	8145	VILLA NIDIA	\N
137	54	8146	EL CATORCE	\N
137	54	8147	EL CALDEN	\N
137	54	8148	VINCHINA	\N
137	54	8149	ALTO JAGUEL	\N
137	54	8150	BAJO JAGUE	\N
137	54	8151	CASA PINTADA	\N
137	54	8152	DISTRITO PUEBLO	\N
137	54	8153	JAGUE	\N
137	54	8154	EL HORNO	\N
137	54	8155	AMANA	\N
137	54	8156	LA TORRE	\N
137	54	8157	LOS COLORADOS	\N
137	54	8158	PAGANZO	\N
137	54	8159	SALINAS DE BUSTOS	\N
137	54	8160	PATQUIA	\N
137	54	8161	EL VALLECITO	\N
137	54	8162	REAL DEL CADILLO	\N
137	54	8163	ABRA VERDE	\N
137	54	8164	AGUA DE PIEDRA	\N
137	54	8165	ALTO BAYO	\N
137	54	8166	CHEPES	\N
137	54	8167	EL CINCUENTA	\N
137	54	8168	EL DIVISADERO	\N
137	54	8169	LA AGUADA	\N
137	54	8170	LA CONSULTA	\N
137	54	8171	LA PINTADA	\N
137	54	8172	LA PRIMAVERA	\N
137	54	8173	LOS OROS	\N
137	54	8174	PUNTA DEL CERRO	\N
137	54	8175	SANTA CRUZ	\N
137	54	8176	ÑOQUEVES	\N
137	54	8177	AGUA BLANCA	\N
137	54	8178	CASAS VIEJAS	\N
137	54	8179	EL BARRIAL	\N
137	54	8180	EL RODEO	\N
137	54	8181	LA CALERA	\N
137	54	8182	LA CALLANA	\N
137	54	8183	LA JARILLA	\N
137	54	8184	LA LAGUNA	\N
137	54	8185	LA REFORMA	\N
137	54	8186	LAS SALINAS	\N
137	54	8187	LAS TOSCAS	\N
137	54	8188	LOS CORIAS	\N
137	54	8189	MASCASIN	\N
137	54	8190	PORTEZUELO DE LOS ARCE	\N
137	54	8191	QUEBRADA DEL VALLECITO	\N
137	54	8192	TOTORAL	\N
137	54	8193	VALLE HERMOSO	\N
137	54	8194	VILLA CHEPES	\N
137	54	8195	BARRANQUITAS	\N
137	54	8196	DESIDERIO TELLO	\N
137	54	8197	AGUA DE LA PIEDRA	\N
137	54	8198	CHELCOS	\N
137	54	8199	ALPASINCHE	\N
137	54	8200	EL RETIRO	\N
137	54	8201	LA PIRGUA	\N
137	54	8202	LOROHUASI	\N
137	54	8203	CHAUPIHUASI	\N
137	54	8204	LOS OLIVARES	\N
137	54	8205	SALICAS	\N
137	54	8206	AMUSCHINA	\N
137	54	8207	ANDOLUCAS	\N
137	54	8208	CUIPAN	\N
137	54	8209	LA PLAZA	\N
137	54	8210	LAS TALAS	\N
137	54	8211	LOS ROBLES	\N
137	54	8212	SCHAQUI	\N
137	54	8213	SURIYACO	\N
137	54	8214	TUYUBIL	\N
137	54	8215	HUACO	\N
137	54	8216	LAS BOMBAS	\N
137	54	8217	VILLA BUSTOS	\N
137	54	8218	VILLA SANAGASTA	\N
138	54	8219	CERRO DE LA GLORIA	\N
138	54	8220	MENDOZA	\N
138	54	8221	LA FAVORITA	\N
138	54	8222	GASPAR CAMPOS	\N
138	54	8223	GOICO	\N
138	54	8224	COLONIA ALVEAR	\N
138	54	8225	EL JUNCALITO	\N
138	54	8226	GENERAL ALVEAR	\N
138	54	8227	LA POMONA	\N
138	54	8228	VILLA COMPARTO	\N
138	54	8229	CARMENSA	\N
138	54	8230	CERRO NEVADO	\N
138	54	8231	COCHICO	\N
138	54	8232	EL CEIBO	\N
138	54	8233	LOS COMPARTOS	\N
138	54	8234	POSTE DE FIERRO	\N
138	54	8235	SAN PEDRO DEL ATUEL	\N
138	54	8236	TAMBITO	\N
138	54	8237	COLONIA ALVEAR OESTE	\N
138	54	8238	COLONIA BOUQUET	\N
138	54	8239	COMPUERTAS NEGRAS	\N
138	54	8240	EL RETIRO	\N
138	54	8241	LA MARZOLINA	\N
138	54	8242	LAS COMPUERTAS NEGRAS	\N
138	54	8243	PUEBLO LUNA	\N
138	54	8244	BOWEN	\N
138	54	8245	EL BANDERON	\N
138	54	8246	EL REFUGIO	\N
138	54	8247	KM 884	\N
138	54	8248	LA ADELINA	\N
138	54	8249	LA ESCANDINAVA	\N
138	54	8250	LA MONTILLA	\N
138	54	8251	LOS ANGELES	\N
138	54	8252	LOS CAMPAMENTOS	\N
138	54	8253	LOS HUARPES (APEADERO FCDFS)	\N
138	54	8254	SANTA ELENA	\N
138	54	8255	CANALEJAS	\N
138	54	8256	EL ARBOLITO	\N
138	54	8257	LA MORA	\N
138	54	8258	CORRAL DE LORCA	\N
138	54	8259	COSTA DEL DIAMANTE	\N
138	54	8260	OVEJERIA	\N
138	54	8261	PAMPA DEL TIGRE	\N
138	54	8262	MEDIA LUNA	\N
138	54	8263	BAJADA NUEVA	\N
138	54	8264	EL AGUILA	\N
138	54	8265	EL DESVIO	\N
138	54	8266	EL REFUGIO	\N
138	54	8267	JUNCALITO	\N
138	54	8268	LA CALIFORNIA	\N
138	54	8269	LA VARITA	\N
138	54	8270	MOJON 8	\N
138	54	8271	OCHENTAICUATRO	\N
138	54	8272	POZO HONDO	\N
138	54	8273	SANTA ELENA	\N
138	54	8274	GODOY CRUZ	\N
138	54	8275	SAN FRANCISCO DEL MONTE	\N
138	54	8276	GOBERNADOR BENEGAS	\N
138	54	8277	VILLA HIPODROMO	\N
138	54	8278	LAS TORTUGAS	\N
138	54	8279	VILLA MARINI	\N
138	54	8280	PRESIDENTE SARMIENTO	\N
138	54	8281	VILLA DEL PARQUE	\N
138	54	8282	BENEGAS	\N
138	54	8283	BARRIO COMERCIO	\N
138	54	8284	GENERAL BELGRANO	\N
138	54	8285	BARRIO GRAFICO	\N
138	54	8286	CAÑADITA ALEGRE	\N
138	54	8287	CORONEL DORREGO	\N
138	54	8288	NUEVA CIUDAD	\N
138	54	8289	SAN JOSE	\N
138	54	8290	VILLAS UNIDAS - 25 DE MAYO	\N
138	54	8291	LOS CORREDORES	\N
138	54	8292	VILLA NUEVA	\N
138	54	8293	BUENA NUEVA	\N
138	54	8294	CAPILLA DEL ROSARIO	\N
138	54	8295	JESUS NAZARENO	\N
138	54	8296	VILLA SUAVA	\N
138	54	8297	BUENA VISTA	\N
138	54	8298	CANAL PESCARA	\N
138	54	8299	COLONIA SEGOVIA	\N
138	54	8300	PARADERO LA SUPERIORA	\N
138	54	8301	PRIMAVERA	\N
138	54	8302	RODEO DE LA CRUZ	\N
138	54	8303	VILLA PRIMAVERA	\N
138	54	8304	COLONIA SANTA TERESA	\N
138	54	8305	LA PRIMAVERA	\N
138	54	8306	LAGUNITA	\N
138	54	8307	LOS CORRALITOS	\N
138	54	8308	VERGEL	\N
138	54	8309	BERMEJO	\N
138	54	8310	EL SAUCE	\N
138	54	8311	LIMON	\N
138	54	8312	KILOMETRO 11	\N
138	54	8313	LAS CAÑAS	\N
138	54	8314	PUENTE DE HIERRO	\N
138	54	8315	ARREDONDO	\N
138	54	8316	AVENIDA	\N
138	54	8317	ESCORIHUELA	\N
138	54	8318	GENERAL ROCA	\N
138	54	8319	JOSE A VERDAGUER	\N
138	54	8320	KILOMETRO 8	\N
138	54	8321	LAPRIDA	\N
138	54	8322	PEDRO MOLINA	\N
138	54	8323	SAN FRANCISCO DEL MONTE	\N
138	54	8324	SAN MARTIN	\N
138	54	8325	GUAYMALLEN	\N
138	54	8326	LA COLONIA	\N
138	54	8327	LAS COLONIAS	\N
138	54	8328	VILLA MOLINO ORFILA	\N
138	54	8329	COLONIA DELFINO	\N
138	54	8330	EL MOYANO	\N
138	54	8331	ALGARROBO GRANDE	\N
138	54	8332	ALTO VERDE	\N
138	54	8333	INGENIERO GIAGNONI	\N
138	54	8334	PUESTO LA COSTA	\N
138	54	8335	RETAMO	\N
138	54	8336	RICARDO VIDELA	\N
138	54	8337	ROBERTS	\N
138	54	8338	EL CIPRES	\N
138	54	8339	JORGE NEWBERY	\N
138	54	8340	LA ISLA	\N
138	54	8341	LA ISLA CHICA	\N
138	54	8342	LA ISLA GRANDE	\N
138	54	8343	LOS BARRIALES	\N
138	54	8344	RODRIGUEZ PEÑA	\N
138	54	8345	TRES ACEQUIAS	\N
138	54	8346	CARRIL NORTE	\N
138	54	8347	CARRIL NUEVO- JUNIN	\N
138	54	8348	JUNIN	\N
138	54	8349	MEDRANO	\N
138	54	8350	MUNDO NUEVO	\N
138	54	8351	PHILLIPS	\N
138	54	8352	TRES ESQUINAS	\N
138	54	8353	CADETES DE CHILE	\N
138	54	8354	CORRAL DE CUERO	\N
138	54	8355	CORRAL DEL MOLLE	\N
138	54	8356	DELGADILLO	\N
138	54	8357	EL CONSUELO	\N
138	54	8358	LA PAZ	\N
138	54	8359	LA PRIMAVERA	\N
138	54	8360	LAS VIZCACHAS	\N
138	54	8361	LOS ALGARROBOS	\N
138	54	8362	MAQUINISTA LEVET	\N
138	54	8363	PIRQUITA (EMBARCADERO FCGSM)	\N
138	54	8364	PUERTA DE LA ISLA	\N
138	54	8365	RETAMO	\N
138	54	8366	VILLA ANTIGUA	\N
138	54	8367	VILLA VIEJA	\N
138	54	8368	ALPATACAL	\N
138	54	8369	CIRCUNVALACION	\N
138	54	8370	SOPANTA	\N
138	54	8371	VILLA LA PAZ	\N
138	54	8372	DESAGUADERO	\N
138	54	8373	PAMPITA (EMBARCADERO FCGSM)	\N
138	54	8374	TAPON	\N
138	54	8375	LA TOTORA	\N
138	54	8376	CERRILLOS	\N
138	54	8377	BARRIO AERONAUTICO	\N
138	54	8378	BARRIO INFANTA DE SAN MARTIN	\N
138	54	8379	BARRIO JARDIN MUNICIPAL	\N
138	54	8380	EL CHALLAO	\N
138	54	8381	EMPALME RESGUARDO	\N
138	54	8382	ESPEJO	\N
138	54	8383	ESPEJO RESGUARDO	\N
138	54	8384	LAS HERAS	\N
138	54	8385	LOS TAMARINDOS	\N
138	54	8386	PANQUEHUA	\N
138	54	8387	SANCHEZ DE BUSTAMANTE	\N
138	54	8388	TROPERO SOSA	\N
138	54	8389	ALGARROBAL ABAJO	\N
138	54	8390	ALGARROBAL ARRIBA	\N
138	54	8391	EL ALGARROBAL	\N
138	54	8392	EL BORBOLLON	\N
138	54	8393	EL PASTAL	\N
138	54	8394	EL PLUMERILLO	\N
138	54	8395	PASO HONDO	\N
138	54	8396	ALTO GRANDE	\N
138	54	8397	CAPDEVILLE	\N
138	54	8398	COLONIA ALEMANA	\N
138	54	8399	COLONIA TRES DE MAYO	\N
138	54	8400	EL CAÑITO	\N
138	54	8401	EL RESGUARDO	\N
138	54	8402	HORNITO DEL GRINGO	\N
138	54	8403	HORNOS DE MOYANO	\N
138	54	8404	JOCOLI	\N
138	54	8405	MATHIEU NORTE	\N
138	54	8406	ESTACION USPALLATA	\N
138	54	8407	LA CORTADERA	\N
138	54	8408	PORTILLO AGUA DEL TORO	\N
138	54	8409	SAN ALBERTO	\N
138	54	8410	TERMAS VILLAVICENCIO	\N
138	54	8411	USPALLATA	\N
138	54	8412	CASA DE PIEDRA	\N
138	54	8413	GUIDO	\N
138	54	8414	SAN IGNACIO	\N
138	54	8415	POLVAREDAS	\N
138	54	8416	EMPALME FRONTERA	\N
138	54	8417	LA PIRATA	\N
138	54	8418	PUNTA DE VACAS	\N
138	54	8419	RIO BLANCO	\N
138	54	8420	ZANJON AMARILLO	\N
138	54	8421	PUENTE DEL INCA	\N
138	54	8422	CRISTO REDENTOR	\N
138	54	8423	LAS CUEVAS	\N
138	54	8424	CIENAGUITA (LAS HERAS)	\N
138	54	8425	EL ZAPALLAR (LAS HERAS)	\N
138	54	8426	BENJAMIN MATIENZO	\N
138	54	8427	LA CIENEGUITA	\N
138	54	8428	VILLAVICENCIO	\N
138	54	8429	NUEVE DE JULIO	\N
138	54	8430	ALTO DEL OLVIDO	\N
138	54	8431	COLONIA ITALIANA	\N
138	54	8432	EL CHIRCAL	\N
138	54	8433	EL RETIRO	\N
138	54	8434	EL VERGEL	\N
138	54	8435	GENERAL ACHA	\N
138	54	8436	GOBERNADOR LUIS MOLINA	\N
138	54	8437	JOCOLI VIEJO	\N
138	54	8438	LA PALMERA	\N
138	54	8439	LA PEGA	\N
138	54	8440	LAS DELICIAS	\N
138	54	8441	LAVALLE	\N
138	54	8442	PARAMILLO (APEADERO FCGB)	\N
138	54	8443	SANTA MARTA	\N
138	54	8444	TULUMAYA	\N
138	54	8445	ASUNCION	\N
138	54	8446	BAJADA ARAUJO	\N
138	54	8447	COLONIA ANDRE	\N
138	54	8448	COLONIA DEL CARMEN	\N
138	54	8449	COSTA DE ARAUJO	\N
138	54	8450	EL ALPERO	\N
138	54	8451	EL ROSARIO	\N
138	54	8452	INGENIERO GUSTAVO ANDRE	\N
138	54	8453	KM 1013 (DESVIO FCGB)	\N
138	54	8454	KM 1032 (EMBARCADERO FCGB)	\N
138	54	8455	KM 43	\N
138	54	8456	LA BAJADA	\N
138	54	8457	LA CELIA	\N
138	54	8458	LAGUNA DEL ROSARIO	\N
138	54	8459	MOLUCHES	\N
138	54	8460	PROGRESO	\N
138	54	8461	RESURRECCION (EMBARCADERO FCGB)	\N
138	54	8462	SAN JOSE	\N
138	54	8463	ARROYITO	\N
138	54	8464	EL GUANACO	\N
138	54	8465	EL RETAMO	\N
138	54	8466	LOS BALDES	\N
138	54	8467	LOS BLANCOS	\N
138	54	8468	LOS RALOS	\N
138	54	8469	LOS SAUCES (LAVALLE)	\N
138	54	8470	SAN MIGUEL	\N
138	54	8471	ESTACION KM 976	\N
138	54	8472	TRES DE MAYO	\N
138	54	8473	LAS VIOLETAS	\N
138	54	8474	ALGARROBITO	\N
138	54	8475	ALTO AMARILLO	\N
138	54	8476	COLONIA FRANCESA	\N
138	54	8477	CRUZ BLANCA	\N
138	54	8478	EL PASTAL	\N
138	54	8479	EL PLUMERO	\N
138	54	8480	GUSTAVO ANDRE	\N
138	54	8481	JOCOLI	\N
138	54	8482	LA HOLANDA	\N
138	54	8483	LAS CRUCES	\N
138	54	8484	LOS PASTALITOS	\N
138	54	8485	SAN FRANCISCO	\N
138	54	8486	PASO DE LOS ANDES	\N
138	54	8487	CARBOMETAL	\N
138	54	8488	CARRODILLA	\N
138	54	8489	CHACRAS DE CORIA	\N
138	54	8490	LA PUNTILLA	\N
138	54	8491	CALLE TERRADA	\N
138	54	8492	DIQUE RIO MENDOZA	\N
138	54	8493	DISTRITO COMPUERTA	\N
138	54	8494	LOTES DE GAVIOTAS	\N
138	54	8495	LUJAN DE CUYO	\N
138	54	8496	MAYOR DRUMMOND	\N
138	54	8497	VILLA GAVIOLA	\N
138	54	8498	AGRELO	\N
138	54	8499	ANCHORIS	\N
138	54	8500	CARRIZAL ARRIBA	\N
138	54	8501	CARRIZAL DE ABAJO	\N
138	54	8502	CERRILLOS DEL NORTE	\N
138	54	8503	COLONIA BARRAQUERO	\N
138	54	8504	EL CARRIZAL	\N
138	54	8505	MINAS DE PETROLEO	\N
138	54	8506	PERDRIEL	\N
138	54	8507	UGARTECHE	\N
138	54	8508	VISTALBA	\N
138	54	8509	AGUA DE LOS MANANTIALES	\N
138	54	8510	ALTO MANANTIALES	\N
138	54	8511	ALVAREZ CONDARCO (APEADERO FCGB)	\N
138	54	8512	BLANCO ENCALADA	\N
138	54	8513	CACHEUTA	\N
138	54	8514	CAMPAMENTO CACHEUTA Y.P.F.	\N
138	54	8515	CARLOS SUBERCASEUX	\N
138	54	8516	CONCHA SUBERCASEAUX	\N
138	54	8517	EL ALTILLO	\N
138	54	8518	LAS CHACRITAS	\N
138	54	8519	LAS COMPUERTAS	\N
138	54	8520	LOS PAPAGAYOS	\N
138	54	8521	PETROLEO	\N
138	54	8522	POTRERILLOS	\N
138	54	8523	LAS VEGAS	\N
138	54	8524	CERRILLOS	\N
138	54	8525	CERRILLOS DEL SUR	\N
138	54	8526	COLONIA FUNES	\N
138	54	8527	LAS COLONIAS	\N
138	54	8528	SAN IGNACIO	\N
138	54	8529	TRES ESQUINAS	\N
138	54	8530	LAS CARDITAS	\N
138	54	8531	VALLECITOS	\N
138	54	8532	BAÑOS LUNLUNTA	\N
138	54	8533	GENERAL GUTIERREZ	\N
138	54	8534	BARRIO SAN EDUARDO	\N
138	54	8535	COQUIMBITO	\N
138	54	8536	LUZURIAGA	\N
138	54	8537	SARMIENTO	\N
138	54	8538	MAIPU	\N
138	54	8539	BAJO LUNLUNTA	\N
138	54	8540	BARRANCAS	\N
138	54	8541	CESPEDES	\N
138	54	8542	CHACHINGO	\N
138	54	8543	CRUZ DE PIEDRA	\N
138	54	8544	GENERAL ORTEGA	\N
138	54	8545	LA JAULA	\N
138	54	8546	LUNLUNTA	\N
138	54	8547	MARQUEZ (ESCUELA 117)	\N
138	54	8548	MAZA	\N
138	54	8549	RUSSELL	\N
138	54	8550	TRES BANDERAS	\N
138	54	8551	VILLA SECA	\N
138	54	8552	COLONIA BOMBAL	\N
138	54	8553	COLONIA JARA	\N
138	54	8554	PEDREGAL	\N
138	54	8555	RODEO DEL MEDIO	\N
138	54	8556	BARRIO FERRI	\N
138	54	8557	CARTELLONE	\N
138	54	8558	EL ALTILLO	\N
138	54	8559	EL PARAISO	\N
138	54	8560	FINCA EL ARROZ	\N
138	54	8561	FRAY LUIS BELTRAN	\N
138	54	8562	LOS ALAMOS	\N
138	54	8563	SANTA BLANCA	\N
138	54	8564	BARCALA	\N
138	54	8565	ISLA CHICA	\N
138	54	8566	ISLA GRANDE	\N
138	54	8567	SAN ROQUE	\N
138	54	8568	VALLE HERMOSO	\N
138	54	8569	TERESA V. DE TITTARELLI	\N
138	54	8570	GUTIERREZ	\N
138	54	8571	TRES ESQUINAS	\N
138	54	8572	BARDAS BLANCAS	\N
138	54	8573	CAÑADA AMARILLA (EMBARCADERO FCGSM)	\N
138	54	8574	CALMUCO	\N
138	54	8575	COIHUECO	\N
138	54	8576	EL ALAMBRADO	\N
138	54	8577	EL MANZANO	\N
138	54	8578	EL SOSNEADO	\N
138	54	8579	LOS MOLLES	\N
138	54	8580	LOS PARLAMENTOS	\N
138	54	8581	RANQUIL NORTE	\N
138	54	8582	VALLE DE LAS LEÑAS	\N
138	54	8583	BELTRAN	\N
138	54	8584	CAÑADA ANCHA	\N
138	54	8585	CAÑADA COLORADA	\N
138	54	8586	CAJON GRANDE	\N
138	54	8587	EL CHACAY (APEADERO FCGSM)	\N
138	54	8588	EL CHOIQUE	\N
138	54	8589	LA BATRA	\N
138	54	8590	LAS CHACRAS	\N
138	54	8591	LAS JUNTAS	\N
138	54	8592	MALARGUE	\N
138	54	8593	MECHENGUIL	\N
138	54	8594	MINACAR	\N
138	54	8595	PAMPA AMARILLA	\N
138	54	8596	PATIMALAL	\N
138	54	8597	RANCHITOS	\N
138	54	8598	RANQUILCO (POZOS PETROLIFEROS)	\N
138	54	8599	RIO BARRANCAS	\N
138	54	8600	RIO CHICO	\N
138	54	8601	RIO GRANDE	\N
138	54	8602	AGUA DEL TORO	\N
138	54	8603	AGUA ESCONDIDA	\N
138	54	8604	EL AZUFRE	\N
138	54	8605	BALDE EL SOSNEADO	\N
138	54	8606	LAS VEGAS	\N
138	54	8607	LAS LOICAS	\N
138	54	8608	EL CARAPACHO	\N
138	54	8609	ANDRADE	\N
138	54	8610	LOS ARBOLES	\N
138	54	8611	EL ALTO	\N
138	54	8612	LOS CAMPAMENTOS	\N
138	54	8613	RIVADAVIA	\N
138	54	8614	VILLA SAN ISIDRO	\N
138	54	8615	BARRIO LENCINA	\N
138	54	8616	CAMPAMENTOS	\N
138	54	8617	EL MIRADOR	\N
138	54	8618	EL RETIRO	\N
138	54	8619	LA CENTRAL	\N
138	54	8620	LA FLORIDA	\N
138	54	8621	LA LIBERTAD	\N
138	54	8622	LA SIRENA	\N
138	54	8623	LOS OTOYANES	\N
138	54	8624	MINELLI	\N
138	54	8625	MUNDO NUEVO	\N
138	54	8626	PACHANGO	\N
138	54	8627	PHILIPPS	\N
138	54	8628	REDUCCION	\N
138	54	8629	SANTA MARIA DE ORO	\N
138	54	8630	MEDRANO	\N
138	54	8631	LA VERDE	\N
138	54	8632	REDUCCION DEL MEDIO	\N
138	54	8633	REDUCCION DE ABAJO	\N
138	54	8634	REDUCCION DE ARRIBA	\N
138	54	8635	CAPIZ	\N
138	54	8636	LA CAÑADA	\N
138	54	8637	LA CONSULTA	\N
138	54	8638	AGUADA	\N
138	54	8639	CHILECITO	\N
138	54	8640	EL CAPACHO	\N
138	54	8641	EUGENIO BUSTOS	\N
138	54	8642	JAUCHA	\N
138	54	8643	LA FLORIDA	\N
138	54	8644	PAPAGAYO	\N
138	54	8645	PAREDITAS	\N
138	54	8646	PIEDRAS BLANCAS	\N
138	54	8647	SAN CARLOS	\N
138	54	8648	TIERRAS BLANCAS	\N
138	54	8649	TRES ESQUINAS	\N
138	54	8650	YAUCHA	\N
138	54	8651	CASAS VIEJAS	\N
138	54	8652	EL CEPILLO	\N
138	54	8653	LAS VIOLETAS	\N
138	54	8654	PASO DE LAS CARRETAS	\N
138	54	8655	NUEVA CALIFORNIA	\N
138	54	8656	ALTO DEL SALVADOR	\N
138	54	8657	BUEN ORDEN	\N
138	54	8658	LA PASTORAL	\N
138	54	8659	SAN MARTIN	\N
138	54	8660	SANTA RITA	\N
138	54	8661	VILLA CENTENARIO	\N
138	54	8662	VILLA DEL CARMEN	\N
138	54	8663	VILLA VIDELA	\N
138	54	8664	CHIVILCOY	\N
138	54	8665	EL ALTO SALVADOR	\N
138	54	8666	ESPINO	\N
138	54	8667	MONTE CASEROS	\N
138	54	8668	ALTO VERDE	\N
138	54	8669	CARRIL NORTE	\N
138	54	8670	CARRIL NUEVO	\N
138	54	8671	EL RAMBLON	\N
138	54	8672	LOS EUCALIPTOS	\N
138	54	8673	RUTA 7 KILOMETRO 1014	\N
138	54	8674	BARRIO VILLA ADELA	\N
138	54	8675	CHIMBA	\N
138	54	8676	COLONIA REINA	\N
138	54	8677	GURRUCHAGA	\N
138	54	8678	PALMIRA	\N
138	54	8679	CHAPANAY	\N
138	54	8680	EL ÑANGO	\N
138	54	8681	EL CENTRAL	\N
138	54	8682	EL DIVISADERO	\N
138	54	8683	LA CHIMBA	\N
138	54	8684	REYES	\N
138	54	8685	TRES PORTEÑAS	\N
138	54	8686	CARRIL VIEJO	\N
138	54	8687	INGENIERO GIAGNONI	\N
138	54	8688	VILLA 25 DE MAYO - SAN MARTIN	\N
138	54	8689	VILLA MOLINA ORFILA - SAN MARTIN	\N
138	54	8690	EL ESPINO	\N
138	54	8691	LA CHILCA	\N
138	54	8692	LOS EMBARQUES	\N
138	54	8693	EL CERRITO	\N
138	54	8694	LOS TERNEROS	\N
138	54	8695	PUEBLO DIAMANTE	\N
138	54	8696	PUEBLO SOTO	\N
138	54	8697	SAN RAFAEL	\N
138	54	8698	CAPITAN MONTOYA	\N
138	54	8699	EL USILLAL	\N
138	54	8700	IGUAZU	\N
138	54	8701	LAS PAREDES	\N
138	54	8702	RESOLANA	\N
138	54	8703	CAÑADA SECA	\N
138	54	8704	COLONIA COLOMER	\N
138	54	8705	COLONIA ELENA	\N
138	54	8706	COLONIA RUSA	\N
138	54	8707	CUADRO BENEGAS	\N
138	54	8708	EL PORVENIR	\N
138	54	8709	GOUDGE	\N
138	54	8710	INGENIERO BALLOFFET	\N
138	54	8711	LA LLAVE	\N
138	54	8712	LA LLAVE VIEJA	\N
138	54	8713	LA PICHANA	\N
138	54	8714	LOS PEJES	\N
138	54	8715	PEDRO VARGAS	\N
138	54	8716	PUEBLO ECHEVARRIETA	\N
138	54	8717	RAMA CAIDA	\N
138	54	8718	RINCON DEL ATUEL	\N
138	54	8719	RODOLFO ISELIN	\N
138	54	8720	SALTO DE LAS ROSAS	\N
138	54	8721	BALLOFFET	\N
138	54	8722	CALLE LARGA VIEJA	\N
138	54	8723	COLONIA ATUEL NORTE	\N
138	54	8724	EL NIHUIL	\N
138	54	8725	LAS MALVINAS	\N
138	54	8726	MINAS DEL NEVADO	\N
138	54	8727	NIHUIL	\N
138	54	8728	SALINAS EL DIAMANTE	\N
138	54	8729	SANTA TERESA	\N
138	54	8730	COLONIA BOMBAL Y TABANERA	\N
138	54	8731	COLONIA ESPAÑOLA	\N
138	54	8732	CUADRO BOMBAL	\N
138	54	8733	CUADRO NACIONAL	\N
138	54	8734	EL ALGARROBAL	\N
138	54	8735	TABANERA	\N
138	54	8736	ARISTIDES VILLANUEVA	\N
138	54	8737	EL CAMPAMENTO	\N
138	54	8738	GUADALES	\N
138	54	8739	MONTE COMAN	\N
138	54	8740	CERRO ALQUITRAN	\N
138	54	8741	LOS BRITOS	\N
138	54	8742	VEINTICINCO DE MAYO	\N
138	54	8743	COLONIA PASCUAL IACARINI	\N
138	54	8744	LOS REYUNOS	\N
138	54	8745	PIEDRA DE AFILAR	\N
138	54	8746	EL NEVADO	\N
138	54	8747	PUNTA DE AGUA	\N
138	54	8748	COLONIA JAUREGUI	\N
138	54	8749	COLONIA LOPEZ	\N
138	54	8750	FINCA LOPEZ	\N
138	54	8751	LA GUEVARINA	\N
138	54	8752	LA QUEBRADA	\N
138	54	8753	VILLA ATUEL	\N
138	54	8754	ATUEL SUD	\N
138	54	8755	JAIME PRATS	\N
138	54	8756	LA VASCONIA	\N
138	54	8757	SOITUE	\N
138	54	8758	PALERMO CHICO	\N
138	54	8759	REAL DEL PADRE	\N
138	54	8760	ATUEL NORTE	\N
138	54	8761	COLONIA ATUEL	\N
138	54	8762	EL SOSNEADO	\N
138	54	8763	EL TOLEDANO	\N
138	54	8764	EL TROPEZON	\N
138	54	8765	LA TOSCA	\N
138	54	8766	LOS CLAVELES	\N
138	54	8767	LOS CORONELES	\N
138	54	8768	VILLA SUTER	\N
138	54	8769	EL MOLINO	\N
138	54	8770	EL COLORADO	\N
138	54	8771	LA DORMIDA	\N
138	54	8772	CATITAS VIEJAS	\N
138	54	8773	COMANDANTE SALAS	\N
138	54	8774	EL RETIRO	\N
138	54	8775	EL VILLEGUINO	\N
138	54	8776	GOBERNADOR CIVIT	\N
138	54	8777	JOSE NESTOR LENCINAS	\N
138	54	8778	LA COLONIA SUD	\N
138	54	8779	LAS CATITAS	\N
138	54	8780	PICHI CIEGO (ESTACION FCGSM)	\N
138	54	8781	ÑACUÑAN	\N
138	54	8782	BALDE DE PIEDRAS	\N
138	54	8783	DOCE DE OCTUBRE	\N
138	54	8784	LA COSTA	\N
138	54	8785	RECOARO	\N
138	54	8786	SANTA ROSA	\N
138	54	8787	VILLA CATALA	\N
138	54	8788	EL MARCADO	\N
138	54	8789	ARROYO CLARO	\N
138	54	8790	COLONIA TABANERA	\N
138	54	8791	LA ESTACADA	\N
138	54	8792	LAS ROSAS	\N
138	54	8793	LAS TORRECITAS	\N
138	54	8794	RUIZ HUIDOBRO	\N
138	54	8795	TOTORAL	\N
138	54	8796	TUNUYAN	\N
138	54	8797	ARROYO LOS SAUCES	\N
138	54	8798	ESTANCIA LA PAMPA	\N
138	54	8799	LOS ARBOLES DE VILLEGAS	\N
138	54	8800	LOS SAUCES	\N
138	54	8801	SAN PABLO	\N
138	54	8802	VILLA SECA	\N
138	54	8803	CAMPO DE LOS ANDES	\N
138	54	8804	COLONIA LAS ROSAS	\N
138	54	8805	LA PRIMAVERA	\N
138	54	8806	VISTA FLORES	\N
138	54	8807	LA ESCONDIDA	\N
138	54	8808	EL TOPON	\N
138	54	8809	LAS PINTADAS	\N
138	54	8810	MELOCOTON	\N
138	54	8811	ZAPATA	\N
138	54	8812	ANCON	\N
138	54	8813	CORDON DEL PLATA	\N
138	54	8814	EL PERAL	\N
138	54	8815	LA ARBOLEDA	\N
138	54	8816	LA CARRERA	\N
138	54	8817	SAN JOSE	\N
138	54	8818	TUPUNGATO	\N
138	54	8819	VILLA BASTIAS	\N
138	54	8820	AGUA AMARGA	\N
138	54	8821	CAMPOS VIDAL	\N
138	54	8822	EL ALGARROBO	\N
138	54	8823	EL TOTORAL	\N
138	54	8824	EL ZAMPAL	\N
138	54	8825	EL ZAMPALITO	\N
138	54	8826	GUATALLARY	\N
138	54	8827	SANTA CLARA	\N
138	54	8828	OJO DE AGUA	\N
139	54	8829	CENTINELA	\N
139	54	8830	PINDAPOY	\N
139	54	8831	SAN JOSE	\N
139	54	8832	SAN JUAN DE LA SIERRA	\N
139	54	8833	SIERRAS SAN JUAN	\N
139	54	8834	APOSTOLES	\N
139	54	8835	ARROYO TUNITAS	\N
139	54	8836	CAMPO RICHARDSON	\N
139	54	8837	CARRILLO VIEJO	\N
139	54	8838	CHIRIMAY	\N
139	54	8839	COLONIA APOSTOLES	\N
139	54	8840	EL PARAISO	\N
139	54	8841	ENSANCHE ESTE	\N
139	54	8842	ENSANCHE NORTE	\N
139	54	8843	LA CAPILLA	\N
139	54	8844	LAS TUNAS	\N
139	54	8845	NACIENTES DEL TUNAR	\N
139	54	8846	RINCON DE CHIMTRAY	\N
139	54	8847	VILLA ERRECABORDE	\N
139	54	8848	AZARA	\N
139	54	8849	MONTE HERMOSO	\N
139	54	8850	TRES CAPONES	\N
139	54	8851	CHEROGUITA	\N
139	54	8852	EL RANCHO	\N
139	54	8853	ESTACION APOSTOLES	\N
139	54	8854	VILLA ORTIZ PEREIRA	\N
139	54	8855	CAINGUAS	\N
139	54	8856	EL TIGRE	\N
139	54	8857	COLONIA SEGUI	\N
139	54	8858	CAMPO GRANDE	\N
139	54	8859	DESTACAMENTO BOSQUES	\N
139	54	8860	PRIMERO DE MAYO	\N
139	54	8861	ARISTOBULO DEL VALLE	\N
139	54	8862	BERNARDINO RIVADAVIA	\N
139	54	8863	DOS DE MAYO	\N
139	54	8864	FRONTERAS	\N
139	54	8865	PINDAYTI	\N
139	54	8866	VILLA SALTO ENCANTADO	\N
139	54	8867	PUEBLO ILLIA	\N
139	54	8868	CANDELARIA	\N
139	54	8869	COLONIA PROFUNDIDAD	\N
139	54	8870	PROFUNDIDAD	\N
139	54	8871	PUERTO LA MINA	\N
139	54	8872	SOL DE MAYO	\N
139	54	8873	ARROYO TOMAS	\N
139	54	8874	BELLA VISTA	\N
139	54	8875	BRAZO DEL TACUARUZU	\N
139	54	8876	CAPUERON	\N
139	54	8877	CERRO CORA	\N
139	54	8878	COLONIA ALEMANA	\N
139	54	8879	COLONIA GUARANI	\N
139	54	8880	LA INVERNADA	\N
139	54	8881	LAS QUEMADAS	\N
139	54	8882	NACIENTES DEL ISABEL	\N
139	54	8883	TACUARUZU	\N
139	54	8884	VILLA VENECIA	\N
139	54	8885	ARROYO PASTORA	\N
139	54	8886	CAAPORA	\N
139	54	8887	LORETO	\N
139	54	8888	LOTE 12	\N
139	54	8889	RUINAS DE LORETO	\N
139	54	8890	SANTA ANA	\N
139	54	8891	YERBAL MAMBORETA	\N
139	54	8892	ARROYO MAGDALENA	\N
139	54	8893	BONPLAND	\N
139	54	8894	COLONIA ALMAFUERTE	\N
139	54	8895	COLONIA ARISTOBULO DEL VALLE	\N
139	54	8896	COLONIA FINLANDESA	\N
139	54	8897	PICADA FINLANDESA	\N
139	54	8898	PICADA PORTUGUESA	\N
139	54	8899	RINCON DE BONPLAND	\N
139	54	8900	TRATADO DE PAZ	\N
139	54	8901	BONPLAND NORTE	\N
139	54	8902	MARTIRES	\N
139	54	8903	LA ROTONDA	\N
139	54	8904	POSADAS	\N
139	54	8905	PUERTO LUJAN	\N
139	54	8906	VILLA JUSTO JOSE DE URQUIZA	\N
139	54	8907	BARRIO DON SANTIAGO	\N
139	54	8908	DOMINGO BARTHE	\N
139	54	8909	FACHINAL	\N
139	54	8910	GARUPA	\N
139	54	8911	GARUPA NORTE	\N
139	54	8912	MIGUEL LANUS	\N
139	54	8913	SAN ANDRES	\N
139	54	8914	SANTA INES	\N
139	54	8915	VILLA LANUS	\N
139	54	8916	VILLALONGA	\N
139	54	8917	DAMUS	\N
139	54	8918	MANANTIALES	\N
139	54	8919	NUEVA VALENCIA	\N
139	54	8920	PARADA LEIS	\N
139	54	8921	PUENTE NACIONAL	\N
139	54	8922	SIERRA DE SAN JOSE	\N
139	54	8923	TORORO	\N
139	54	8924	NEMESIO PARMA	\N
139	54	8925	ARROYO SANTA MARIA	\N
139	54	8926	COLONIA SANTA MARIA	\N
139	54	8927	ARRECHEA	\N
139	54	8928	BARRA CONCEPCION	\N
139	54	8929	BRETES MARTIRES	\N
139	54	8930	COLONIA CAPON BONITO	\N
139	54	8931	COLONIA MARTIR SANTA MARIA	\N
139	54	8932	COLONIA SAN JAVIER	\N
139	54	8933	CONCEPCION DE LA SIERRA	\N
139	54	8934	EL PERSIGUERO	\N
139	54	8935	ISLA SAN LUCAS	\N
139	54	8936	PASO DEL ARROYO PERSIGUERO	\N
139	54	8937	PUERTO CONCEPCION	\N
139	54	8938	PUERTO SAN LUCAS	\N
139	54	8939	SAN ISIDRO	\N
139	54	8940	SANTA MARIA LA MAYOR	\N
139	54	8941	SANTA MARIA MARTIR	\N
139	54	8942	9 DE JULIO	\N
139	54	8943	ELDORADO	\N
139	54	8944	COLONIA MARIA MAGDALENA	\N
139	54	8945	PUERTO DELICIA	\N
139	54	8946	SANTIAGO DE LINIERS	\N
139	54	8947	COLONIA VICTORIA	\N
139	54	8948	PUERTO PINARES	\N
139	54	8949	PUERTO VICTORIA	\N
139	54	8950	9 DE JULIO KM. 20	\N
139	54	8951	VALLE HERMOSO	\N
139	54	8952	VILLA ROULET	\N
139	54	8953	COLONIA MANUEL BELGRANO	\N
139	54	8954	DOS HERMANAS	\N
139	54	8955	ALMIRANTE BROWN	\N
139	54	8956	BARRACON	\N
139	54	8957	BERNARDO DE IRIGOYEN	\N
139	54	8958	COMANDANTE ANDRESITO	\N
139	54	8959	SAN ANTONIO	\N
139	54	8960	EL PORVENIR	\N
139	54	8961	DESEADO	\N
139	54	8962	SOBERANIA	\N
139	54	8963	INTEGRACION	\N
139	54	8964	CAPITAN ANTONIO MORALES	\N
139	54	8965	EL SOBERBIO	\N
139	54	8966	FRACRAN	\N
139	54	8967	MONTEAGUDO	\N
139	54	8968	SAN VICENTE	\N
139	54	8969	LA PLANTADORA	\N
139	54	8970	IGUAZU	\N
139	54	8971	PUERTO AGUIRRE	\N
139	54	8972	PUERTO CAROLINA	\N
139	54	8973	PUERTO PENINSULA	\N
139	54	8974	PUERTO IGUAZU	\N
139	54	8975	PUERTO LIBERTAD	\N
139	54	8976	PUERTO BEMBERG	\N
139	54	8977	PUERTO BOSSETTI	\N
139	54	8978	PUERTO ERRECABORDE	\N
139	54	8979	SEGUNDA ZONA	\N
139	54	8980	WANDA	\N
139	54	8981	GOBERNADOR JUAN J. LANUSSE	\N
139	54	8982	HELVECIA	\N
139	54	8983	PUERTO ESPERANZA	\N
139	54	8984	PUERTO HELVECIA	\N
139	54	8985	PUERTO IRIGOYEN	\N
139	54	8986	COLONIA ALBERDI	\N
139	54	8987	OLEGARIO V. ANDRADE	\N
139	54	8988	PICADA GALITZIANA	\N
139	54	8989	ARROYO DEL MEDIO	\N
139	54	8990	CERRO AZUL	\N
139	54	8991	DOS ARROYOS	\N
139	54	8992	LEANDRO N. ALEM	\N
139	54	8993	MECKING	\N
139	54	8994	GOBERNADOR LOPEZ	\N
139	54	8995	ALMAFUERTE	\N
139	54	8996	CAA YARI	\N
139	54	8997	CAPIOVÍ	\N
139	54	8998	MBOPICUA	\N
139	54	8999	PUERTO LEONI	\N
139	54	9000	PUERTO MINERAL	\N
139	54	9001	SAN GOTARDO	\N
139	54	9002	GARUHAPE	\N
139	54	9003	LIBERTADOR GENERAL SAN MARTIN	\N
139	54	9004	PUERTO MBOPICUA	\N
139	54	9005	PUERTO RICO	\N
139	54	9006	PUERTO SAN ALBERTO	\N
139	54	9007	RUIZ DE MONTOYA	\N
139	54	9008	SAN ALBERTO	\N
139	54	9009	EL ALCAZAR	\N
139	54	9010	VILLA ACKERMAN	\N
139	54	9011	OJO DE AGUA	\N
139	54	9012	PIRAY	\N
139	54	9013	PUERTO PIRAY	\N
139	54	9014	GUARAYPO	\N
139	54	9015	LARRAQUE	\N
139	54	9016	LINEA DE PERAY	\N
139	54	9017	MONTECARLO	\N
139	54	9018	PUERTO AVELLANEDA	\N
139	54	9019	PUERTO LAHARRAGUE	\N
139	54	9020	COLONIA CARAGUATAY	\N
139	54	9021	PARANAY	\N
139	54	9022	PUERTO ALCAZAR	\N
139	54	9023	PUERTO CARAGUATAY	\N
139	54	9024	TARUMA	\N
139	54	9025	ARROYO FEDOR	\N
139	54	9026	BAYO TRONCHO	\N
139	54	9027	OBERA	\N
139	54	9028	PICADA SAN MARTIN	\N
139	54	9029	EL SALTO	\N
139	54	9030	VILLA BLANQUITA	\N
139	54	9031	YERBAL VIEJO SECCION 1	\N
139	54	9032	YERBAL VIEJO SECCION 3	\N
139	54	9033	CAMPO RAMON	\N
139	54	9034	COLONIA ALBERDI	\N
139	54	9035	COLONIA CHAPA	\N
139	54	9036	GENERAL ALVEAR	\N
139	54	9037	GUARANI	\N
139	54	9038	KM 8 PANAMBI	\N
139	54	9039	LOS HELECHOS	\N
139	54	9040	PANAMBI	\N
139	54	9041	PICADA SUECA	\N
139	54	9042	PICADA YAPEYU	\N
139	54	9043	SAMAMBAYA	\N
139	54	9044	VILLA ARMONIA	\N
139	54	9045	VILLA BONITA	\N
139	54	9046	VILLA SVEA	\N
139	54	9047	YAPEYU CENTRO	\N
139	54	9048	CAMPO VIERA	\N
139	54	9049	COLONIA TAMANDUA	\N
139	54	9050	PUERTO SANCHEZ	\N
139	54	9051	COLONIA YACUTINGA	\N
139	54	9052	LOTE 5	\N
139	54	9053	ARROYO YABEBIRI	\N
139	54	9054	DOMINGO SAVIO	\N
139	54	9055	COLONIA ROCA CHICA	\N
139	54	9056	SAN IGNACIO	\N
139	54	9057	EL TRIUNFO	\N
139	54	9058	INVERNADA SAN IGNACIO	\N
139	54	9059	LA HORQUETA	\N
139	54	9060	MARIA ANTONIA	\N
139	54	9061	PASTOREO	\N
139	54	9062	PUERTO SAN IGNACIO	\N
139	54	9063	PUERTO VIEJO	\N
139	54	9064	GOBERNADOR ROCA	\N
139	54	9065	ROCA CHICA	\N
139	54	9066	COLONIA LEIVA	\N
139	54	9067	COLONIA POLANA	\N
139	54	9068	EL 26	\N
139	54	9069	EL DESTIERRO	\N
139	54	9070	PUERTO ESPAÑA	\N
139	54	9071	PUERTO GISELA	\N
139	54	9072	PUERTO MENOCHIO	\N
139	54	9073	PUERTO NARANJITO	\N
139	54	9074	SANTO PIPO	\N
139	54	9075	COLONIA ROCA	\N
139	54	9076	CORPUS	\N
139	54	9077	HEKENAN	\N
139	54	9078	MANIS	\N
139	54	9079	OBLIGADO	\N
139	54	9080	PUERTO CAZADOR	\N
139	54	9081	PUERTO DOCE	\N
139	54	9082	PUERTO HARDELASTE	\N
139	54	9083	COLONIA JAPONESA	\N
139	54	9084	HIPOLITO YRIGOYEN	\N
139	54	9085	JARDIN AMERICA	\N
139	54	9086	LA OTILIA	\N
139	54	9087	OASIS	\N
139	54	9088	OTILIA	\N
139	54	9089	PUERTO TABAY	\N
139	54	9090	ISLA ARGENTINA	\N
139	54	9091	GENERAL URQUIZA	\N
139	54	9092	MOJON GRANDE	\N
139	54	9093	INVERNADA CHICA	\N
139	54	9094	INVERNADA DE ITACARUARE	\N
139	54	9095	INVERNADA GRANDE	\N
139	54	9096	ITACARUARE	\N
139	54	9097	LOS GALPONES	\N
139	54	9098	RINCON DE LOPEZ	\N
139	54	9099	BUENA VISTA	\N
139	54	9100	COLONIA CUMANDAY	\N
139	54	9101	COSTA PORTERA	\N
139	54	9102	EL GUERRERO	\N
139	54	9103	FRANCES	\N
139	54	9104	PUERTO ROSARIO	\N
139	54	9105	PUERTO RUBEN	\N
139	54	9106	RINCON DEL GUERRERO	\N
139	54	9107	SAN JAVIER	\N
139	54	9108	TRES ESQUINAS	\N
139	54	9109	FLORENTINO AMEGHINO	\N
139	54	9110	CAMPANA	\N
139	54	9111	CRUCE CABALLERO	\N
139	54	9112	PIÑALITO SUR	\N
139	54	9113	SAN PEDRO	\N
139	54	9114	TOBUNAS	\N
139	54	9115	PIRAY MINI	\N
139	54	9116	BARRA BONITA	\N
139	54	9117	ACARAGUA	\N
139	54	9118	9 DE JULIO	\N
139	54	9119	ALBA POSSE	\N
139	54	9120	25 DE MAYO	\N
139	54	9121	COLONIA ALICIA	\N
139	54	9122	COLONIA AURORA	\N
139	54	9123	EL MACACO	\N
139	54	9124	PUERTO LONDERO	\N
139	54	9125	PUERTO SAN MARTIN	\N
139	54	9126	SAN FRANCISCO DE ASIS	\N
139	54	9127	SANTA RITA	\N
139	54	9128	TRES BOCAS	\N
140	54	9129	ARROYO QUILLEN	\N
140	54	9130	EL DORMIDO	\N
140	54	9131	EL GATO	\N
140	54	9132	LA ARBOLEDA	\N
140	54	9133	LA OFELIA	\N
140	54	9134	RAHUE	\N
140	54	9135	ALUMINE	\N
140	54	9136	HARAS PATRIA	\N
140	54	9137	KILCA CASA	\N
140	54	9138	LA ANGOSTURA DE ICALMA	\N
140	54	9139	LAGOTERA	\N
140	54	9140	LITRAN	\N
140	54	9141	LONCO MULA	\N
140	54	9142	MOQUEHUE	\N
140	54	9143	QUILCA	\N
140	54	9144	RUCA CHORROY ARRIBA	\N
140	54	9145	SAINUCO	\N
140	54	9146	VILLA PEHUENIA	\N
140	54	9147	AÑELO	\N
140	54	9148	AUCA MAHUIDA	\N
140	54	9149	LOS CHIHUIDOS	\N
140	54	9150	LOS CHINITOS	\N
140	54	9151	PUNTA DE SIERRA	\N
140	54	9152	SAN PATRICIO DEL CHAÑAR	\N
140	54	9153	TRATAYEN	\N
140	54	9154	EL ZORRO	\N
140	54	9155	AGUADA FLORENCIO	\N
140	54	9156	BAJADA DEL MARUCHO	\N
140	54	9157	CHACAYCO	\N
140	54	9158	EL OVERO	\N
140	54	9159	CATAN LIL	\N
140	54	9160	CHARAHUILLA	\N
140	54	9161	ESPINAZO DEL ZORRO	\N
140	54	9162	LAPACHAL	\N
140	54	9163	LAS COLORADAS	\N
140	54	9164	LOS RODILLOS	\N
140	54	9165	PILO LIL	\N
140	54	9166	CERRO GATO	\N
140	54	9167	LA NEGRA	\N
140	54	9168	MALLIN DE LAS YEGUAS	\N
140	54	9169	ZULEMITA	\N
140	54	9170	BAJADA COLORADA	\N
140	54	9171	CARRAN CARA	\N
140	54	9172	CARRI LAUQUEN	\N
140	54	9173	COSTA LIMAY	\N
140	54	9174	LA PINTADA	\N
140	54	9175	NOGUEIRA	\N
140	54	9176	PIEDRA DEL AGUILA	\N
140	54	9177	PIEDRA PINTADA	\N
140	54	9178	SAÑICO	\N
140	54	9179	SAN BERNARDO	\N
140	54	9180	SANTO TOMAS	\N
140	54	9181	ZAINA YEGUA	\N
140	54	9182	ALIANZA	\N
140	54	9183	CHICHIGUAY	\N
140	54	9184	CHINCHINA	\N
140	54	9185	LAS MERCEDES	\N
140	54	9186	EL SALITRAL	\N
140	54	9187	ALICURA	\N
140	54	9188	LAS PERLAS	\N
140	54	9189	LOMA DE LA LATA	\N
140	54	9190	NEUQUEN	\N
140	54	9191	PORTEZUELO GRANDE	\N
140	54	9192	RINCON DE EMILIO	\N
140	54	9193	COLONIA VALENTINA	\N
140	54	9194	COLONIA VALENTINA SUR	\N
140	54	9195	PLANICIE BANDERITA	\N
140	54	9196	CENTENARIO	\N
140	54	9197	VISTA ALEGRE NORTE	\N
140	54	9198	VISTA ALEGRE SUR	\N
140	54	9199	VILLA EL CHOCON	\N
140	54	9200	ARROYITO	\N
140	54	9201	ARROYITO CHALLACO	\N
140	54	9202	BALSA SENILLOSA	\N
140	54	9203	CHINA MUERTA	\N
140	54	9204	PLOTTIER	\N
140	54	9205	SENILLOSA	\N
140	54	9206	CHALLACO	\N
140	54	9207	PLAZA HUINCUL	\N
140	54	9208	CAMPAMENTO SOL	\N
140	54	9209	SAUZAL BONITO	\N
140	54	9210	BARRIO PELIGROSO	\N
140	54	9211	CUTRAL-CO	\N
140	54	9212	PUEBLO NUEVO	\N
140	54	9213	VISTA ALEGRE	\N
140	54	9214	ANQUINCO	\N
140	54	9215	ARROYO BLANCO	\N
140	54	9216	BATRE LAUQUEN	\N
140	54	9217	CAEPE MALAL	\N
140	54	9218	CAJON DE CURI LEUVU	\N
140	54	9219	CAJON GRANDE	\N
140	54	9220	CANCHA HUIGANCO	\N
140	54	9221	CASA DE PIEDRA	\N
140	54	9222	CHACAY MELEHUE	\N
140	54	9223	CHAPUA	\N
140	54	9224	CHAPUA ABAJO	\N
140	54	9225	CHOS MALAL	\N
140	54	9226	COYUCO	\N
140	54	9227	EL ALAMITO	\N
140	54	9228	EL CURILEO	\N
140	54	9229	LA CIENAGA	\N
140	54	9230	LA CIENEGUITA	\N
140	54	9231	LA SALADA	\N
140	54	9232	LAS ABEJAS	\N
140	54	9233	LAS SALADAS	\N
140	54	9234	LEUTO CABALLO	\N
140	54	9235	LOS ENTIERROS	\N
140	54	9236	LOS MENUCOS	\N
140	54	9237	LOS TRES CHORROS	\N
140	54	9238	LUICOCO	\N
140	54	9239	MAYAN MAHUIDA	\N
140	54	9240	PALAU	\N
140	54	9241	PAMPA FERREIRA	\N
140	54	9242	QUEMPU LEUFU	\N
140	54	9243	TRES CHORROS	\N
140	54	9244	TRICAO MALAL	\N
140	54	9245	EL TROPEZON	\N
140	54	9246	CHIQUILLIHUIN	\N
140	54	9247	HUECHULAFQUEN	\N
140	54	9248	JUNIN DE LOS ANDES	\N
140	54	9249	LA ATALAYA	\N
140	54	9250	LA UNION	\N
140	54	9251	LUBECA	\N
140	54	9252	MAMUL MALAL	\N
140	54	9253	NAHUEL MAPE	\N
140	54	9254	PALITUE	\N
140	54	9255	PIEDRA MALA	\N
140	54	9256	QUILQUIHUE	\N
140	54	9257	SAN JUAN (JUNIN DE LOS ANDES)	\N
140	54	9258	TRES PICOS	\N
140	54	9259	TROMEN	\N
140	54	9260	AUCA PAN	\N
140	54	9261	CERRO DE LOS PINOS	\N
140	54	9262	PAMPA DEL MALLEO	\N
140	54	9263	PASO DE SAN IGNACIO	\N
140	54	9264	SAN IGNACIO	\N
140	54	9265	ATREUCO	\N
140	54	9266	BUENA ESPERANZA	\N
140	54	9267	CHAPELCO	\N
140	54	9268	EL CERRITO	\N
140	54	9269	EL OASIS	\N
140	54	9270	EL PORVENIR	\N
140	54	9271	HUA-HUM	\N
140	54	9272	LA FORTUNA	\N
140	54	9273	LAS BANDURRIAS	\N
140	54	9274	LASCAR	\N
140	54	9275	LOLOG	\N
140	54	9276	MELIQUINA	\N
140	54	9277	QUILA QUINA	\N
140	54	9278	QUITA QUINA	\N
140	54	9279	SAN MARTIN DE LOS ANDES	\N
140	54	9280	TROMPUL	\N
140	54	9281	VEGA MAIPU	\N
140	54	9282	CALEUFU	\N
140	54	9283	CHACABUCO	\N
140	54	9284	CHIMEHUIN	\N
140	54	9285	GENTE GRANDE	\N
140	54	9286	QUENTRENQUEN	\N
140	54	9287	TIPILIUKE	\N
140	54	9288	VILLA ALICURA	\N
140	54	9289	AGUAS DE LAS MULAS	\N
140	54	9290	CAJON DE ALMAZA	\N
140	54	9291	CAJON DE MANZANO	\N
140	54	9292	CERRO DE LA PARVA	\N
140	54	9293	EL PINO ANDINO	\N
140	54	9294	HUALCUPEN	\N
140	54	9295	LA ARGENTINA	\N
140	54	9296	LONCOPUE	\N
140	54	9297	MALLIN DEL TORO	\N
140	54	9298	MULICHINCO	\N
140	54	9299	RANQUILCO	\N
140	54	9300	CHURRIACA	\N
140	54	9301	COIHUECO	\N
140	54	9302	COSTA DEL ARROYO SALADO	\N
140	54	9303	EL PERALITO	\N
140	54	9304	HUNCAL	\N
140	54	9305	PAMPA DEL SALADO	\N
140	54	9306	QUINTUCO	\N
140	54	9307	TRAHUNCURA	\N
140	54	9308	ISLA VICTORIA	\N
140	54	9309	PUERTO ANCHORENA	\N
140	54	9310	COIHUE	\N
140	54	9311	CULLIN MANZANO	\N
140	54	9312	ESTANCIA NEWBERY	\N
140	54	9313	LA ARAUCARIA	\N
140	54	9314	LA ESTACA	\N
140	54	9315	LA LIPELA	\N
140	54	9316	NAHUEL HUAPI	\N
140	54	9317	RINCON CHICO	\N
140	54	9318	RINCON GRANDE	\N
140	54	9319	CAMINERA TRAFUL	\N
140	54	9320	ESTANCIA LA PRIMAVERA	\N
140	54	9321	TRAFUL	\N
140	54	9322	VILLA TRAFUL	\N
140	54	9323	CORRENTOSO	\N
140	54	9324	EL ARBOLITO	\N
140	54	9325	EL MACHETE	\N
140	54	9326	LA ANGOSTURA	\N
140	54	9327	PUERTO MANZANO	\N
140	54	9328	VILLA LA ANGOSTURA	\N
140	54	9329	PICHI TRAFUL	\N
140	54	9330	VILLA LLANQUIN	\N
140	54	9331	PICHI NEUQUEN	\N
140	54	9332	ANDACOLLO	\N
140	54	9333	BELLA VISTA	\N
140	54	9334	CAMALEONES	\N
140	54	9335	CAYANTA	\N
140	54	9336	EL CHINGUE	\N
140	54	9337	EL DURAZNO	\N
140	54	9338	FILMATUE	\N
140	54	9339	FLORES	\N
140	54	9340	GUAÑACOS	\N
140	54	9341	HUINGANCO	\N
140	54	9342	HUMIGAMIO	\N
140	54	9343	INVERNADA VIEJA	\N
140	54	9344	JECANASCO	\N
140	54	9345	JUARANCO	\N
140	54	9346	LAS LAGUNAS	\N
140	54	9347	LAS OVEJAS	\N
140	54	9348	LOS CARRIZOS	\N
140	54	9349	LOS CISNES	\N
140	54	9350	LOS MICHES	\N
140	54	9351	MACHICO	\N
140	54	9352	MILLA	\N
140	54	9353	MINA LILEO	\N
140	54	9354	NAHUEVE	\N
140	54	9355	NERECO NORTE	\N
140	54	9356	NIRECO	\N
140	54	9357	TIERRAS BLANCAS	\N
140	54	9358	VARVARCO	\N
140	54	9359	MANZANO AMARGO	\N
140	54	9360	RANQUILAO	\N
140	54	9361	ÑORQUIN	\N
140	54	9362	CAVIAHUE	\N
140	54	9363	COLIPILI	\N
140	54	9364	COPAHUE	\N
140	54	9365	EL HUECU	\N
140	54	9366	RANQUILON	\N
140	54	9367	VILU MALLIN	\N
140	54	9368	TAQUIMILAN	\N
140	54	9369	EL CHOLAR	\N
140	54	9370	TAQUIMILAN ABAJO	\N
140	54	9371	LOS SAUCES	\N
140	54	9372	RINCON DE LOS SAUCES	\N
140	54	9373	BARRANCAS	\N
140	54	9374	BUTA RANQUIL	\N
140	54	9375	HUITRIN	\N
140	54	9376	MINA CARRASCOSA	\N
140	54	9377	PAMPA DE TRIL	\N
140	54	9378	PASO BARDA	\N
140	54	9379	RIO BARRANCAS	\N
140	54	9380	SAN EDUARDO	\N
140	54	9381	TRILI	\N
140	54	9382	OCTAVIO PICO	\N
140	54	9383	CERRO DEL LEON	\N
140	54	9384	EL SAUCE	\N
140	54	9385	LIMAY CENTRO	\N
140	54	9386	PANTANITOS	\N
140	54	9387	PASO AGUERRE	\N
140	54	9388	PICUN LEUFU	\N
140	54	9389	LAJA	\N
140	54	9390	ARROYO CAHUNCO	\N
140	54	9391	CAJON DEL TORO	\N
140	54	9392	CALIHUE	\N
140	54	9393	CARRERI	\N
140	54	9394	CERRO COLORADO	\N
140	54	9395	CERRO DE LA GRASA	\N
140	54	9396	COCHICO	\N
140	54	9397	CODIHUE	\N
140	54	9398	CORRAL DE PIEDRA	\N
140	54	9399	CUCHILLO CURA	\N
140	54	9400	EL ATRAVESADO	\N
140	54	9401	EL ESCORIAL	\N
140	54	9402	EL PALAO	\N
140	54	9403	HAICHOL	\N
140	54	9404	HUILLILON	\N
140	54	9405	LA BUITRERA	\N
140	54	9406	LA VERDAD	\N
140	54	9407	LAS LAJAS	\N
140	54	9408	LAS LAJITAS	\N
140	54	9409	LAS TOSCAS	\N
140	54	9410	LAS TRES LAGUNAS	\N
140	54	9411	LIU CULLIN	\N
140	54	9412	LLAMUCO	\N
140	54	9413	LOS GALPONES	\N
140	54	9414	MALLIN BLANCO	\N
140	54	9415	MALLIN CHILENO	\N
140	54	9416	MALLIN DE LA CUEVA	\N
140	54	9417	MALLIN DE MENA	\N
140	54	9418	MALLIN DEL RUBIO	\N
140	54	9419	MALLIN QUEMADO	\N
140	54	9420	PASO ANCHO	\N
140	54	9421	PICHE PONON	\N
140	54	9422	PIEDRAS BAYAS	\N
140	54	9423	PINO HACHADO	\N
140	54	9424	PINO SOLO	\N
140	54	9425	POZO HUALICHES	\N
140	54	9426	PRIMEROS PINOS	\N
140	54	9427	QUEBRADA HONDA	\N
140	54	9428	RAMICHAL	\N
140	54	9429	SALQUICO	\N
140	54	9430	SAN DEMETRIO	\N
140	54	9431	HUARINCHENQUE	\N
140	54	9432	AGRIO BALSA	\N
140	54	9433	BAJADA DEL AGRIO	\N
140	54	9434	BALNEARIO DEL RIO AGRIO	\N
140	54	9435	BALSA DEL RIO AGRIO	\N
140	54	9436	COLI MALAL	\N
140	54	9437	CONFLUENCIA DEL AGUIJON	\N
140	54	9438	VILLA DEL AGRIO	\N
140	54	9439	PILMATUE	\N
140	54	9440	QUILI MALAL	\N
140	54	9441	RIO AGRIO	\N
140	54	9442	VACA MUERTA	\N
140	54	9443	PASO DE LOS INDIOS	\N
140	54	9444	BAJADA DE LOS MOLLES	\N
140	54	9445	BARDA ANGUIL	\N
140	54	9446	BARDAS NEGRAS	\N
140	54	9447	COVUNCO	\N
140	54	9448	COVUNCO ARRIBA	\N
140	54	9449	LA FRIA	\N
140	54	9450	LA ISABEL	\N
140	54	9451	LA PATAGONIA	\N
140	54	9452	LA PATRIA	\N
140	54	9453	LA POCHOLA	\N
140	54	9454	LA SUSANA	\N
140	54	9455	LAGUNA BLANCA	\N
140	54	9456	LAGUNA MIRANDA	\N
140	54	9457	LAS BARDITAS	\N
140	54	9458	LOS MUCHACHOS	\N
140	54	9459	PORTADA COVUNCO	\N
140	54	9460	PUENTE PICUN LEUFU	\N
140	54	9461	RAMON M. CASTRO	\N
140	54	9462	SANTO DOMINGO	\N
140	54	9463	TAQUI NILEU	\N
140	54	9464	TRES PIEDRAS	\N
140	54	9465	ZAPALA	\N
140	54	9466	PATRIA	\N
140	54	9467	COVUNCO ABAJO	\N
140	54	9468	COVUNCO CENTRO	\N
140	54	9469	MARIANO MORENO	\N
140	54	9470	HUECHAHUE	\N
140	54	9471	LOS CATUTOS	\N
141	54	9472	PLAYA BONITA	\N
141	54	9473	BALNEARIO EL CONDOR	\N
141	54	9474	BALNEARIO MASSINI	\N
141	54	9475	EL DIQUE	\N
141	54	9476	GENERAL LIBORIO BERNAL	\N
141	54	9477	LA MESETA	\N
141	54	9478	MATA NEGRA	\N
141	54	9479	RUTA 3 KILOMETRO 974	\N
141	54	9480	SAN JAVIER	\N
141	54	9481	VIEDMA	\N
141	54	9482	ZANJON DE OYUELA	\N
141	54	9483	BALNEARIO LA BOCA	\N
141	54	9484	CUBANEA	\N
141	54	9485	MONTE BAGUAL	\N
141	54	9486	CERRO BARAJA	\N
141	54	9487	CERRO FRANCISCO	\N
141	54	9488	GUARDIA MITRE	\N
141	54	9489	JONES	\N
141	54	9490	PRIMERA ANGOSTURA	\N
141	54	9491	PRONUNCIAMIENTO	\N
141	54	9492	SAUCE BLANCO (GUARDIA MITRE-DPTO. ADOLFO ALSINA)	\N
141	54	9493	GENERAL LORENZO VINTTER	\N
141	54	9494	GENERAL NICOLAS H. PALACIOS	\N
141	54	9495	LAGUNA DEL BARRO	\N
141	54	9496	NUEVO LEON	\N
141	54	9497	VICEALMIRANTE EDUARDO OCONNOR (ESTACION FCGR)	\N
141	54	9498	AGUADA DEL LORO	\N
141	54	9499	BARRIO LAGUNA	\N
141	54	9500	LA PRIMAVERA	\N
141	54	9501	EL JUNCAL	\N
141	54	9502	BAHIA CREEK	\N
141	54	9503	BAJO RICO	\N
141	54	9504	BENJAMIN ZORRILLA	\N
141	54	9505	CHOELE CHOEL	\N
141	54	9506	FORTIN UNO	\N
141	54	9507	LA ELVIRA	\N
141	54	9508	LA SARA	\N
141	54	9509	LOS MOLINOS	\N
141	54	9510	NEGRO MUERTO	\N
141	54	9511	PASO PIEDRA	\N
141	54	9512	PUESTO FARIA	\N
141	54	9513	RINCONADA	\N
141	54	9514	SAUCE BLANCO (CHOELE CHOEL-DPTO. AVELLANEDA)	\N
141	54	9515	TRAGUA TRAGUA	\N
141	54	9516	ISLA GRANDE	\N
141	54	9517	LUIS BELTRAN	\N
141	54	9518	PASO LEZCANO	\N
141	54	9519	CAÑADON DE LOS SAUCES	\N
141	54	9520	CERRO GALENSE	\N
141	54	9521	COLONIA JOSEFA	\N
141	54	9522	ESTANCIA LAS JULIAS	\N
141	54	9523	ISLA CHICA	\N
141	54	9524	LA JULIA	\N
141	54	9525	LAMARQUE	\N
141	54	9526	PASO PEÑALVA	\N
141	54	9527	POMONA	\N
141	54	9528	SALITRAL NEGRO	\N
141	54	9529	SANTA GENOVEVA	\N
141	54	9530	CHIMPAY	\N
141	54	9531	CORONEL BELISLE	\N
141	54	9532	DARWIN	\N
141	54	9533	EL HINOJO	\N
141	54	9534	EL MOLINO	\N
141	54	9535	LA ESMERALDA (DARWIN-DPTO. AVELLANEDA)	\N
141	54	9536	LA JUANITA (DARWIN-DPTO. AVELLANEDA)	\N
141	54	9537	SAN PABLO	\N
141	54	9538	SANTA GREGORIA	\N
141	54	9539	SANTA NICOLASA	\N
141	54	9540	CHELFORO	\N
141	54	9541	LA TEODOLINA	\N
141	54	9542	MIRA PAMPA	\N
141	54	9543	LAGUNA DE LA PRUEBA	\N
141	54	9544	ÑIRIHUAO	\N
141	54	9545	BAHIA LOPEZ	\N
141	54	9546	BARILOCHE	\N
141	54	9547	BARRIO LAS QUINTAS	\N
141	54	9548	BARRIO NIRECO	\N
141	54	9549	HOTEL BAHIA LOPEZ	\N
141	54	9550	HOTEL LOS COIHUES	\N
141	54	9551	LAGO GUTIERREZ	\N
141	54	9552	LAGO MORENO	\N
141	54	9553	LOS JUNCOS (SAN CARLOS DE BARILOCHE-DPTO. PILCANIYEU)	\N
141	54	9554	NIRIHUAO (ESTACION FCGR)	\N
141	54	9555	PENINSULA HUEMUL	\N
141	54	9556	PIEDRA BLANCA (SAN CARLOS DE BARILOCHE-DPTO. BARILOCHE)	\N
141	54	9557	PUERTO MORENO	\N
141	54	9558	PUERTO PICHI MAHUIDA	\N
141	54	9559	PUERTO TIGRE	\N
141	54	9560	RIO NIRIHUANO	\N
141	54	9561	SAN CARLOS DE BARILOCHE	\N
141	54	9562	CERRO CATEDRAL	\N
141	54	9563	COLONIA SUIZA	\N
141	54	9564	EL FOYEL	\N
141	54	9565	LAGO MASCARDI	\N
141	54	9566	PENINSULA SAN PEDRO	\N
141	54	9567	PUERTO OJO DE AGUA	\N
141	54	9568	PUERTO SANTA MARIA	\N
141	54	9569	RIO VILLEGAS	\N
141	54	9570	VILLA MASCARDI	\N
141	54	9571	HOTEL EL TREBOL	\N
141	54	9572	HOTEL ENTRE LAGOS	\N
141	54	9573	LLAO LLAO	\N
141	54	9574	OJOS DE AGUA (LLAO LLAO-DPTO. BARILOCHE)	\N
141	54	9575	PUERTO PAÑUELO	\N
141	54	9576	TUNKELEN	\N
141	54	9577	LAGUNA FRIAS	\N
141	54	9578	LOS CANTAROS	\N
141	54	9579	PUERTO BLEST	\N
141	54	9580	CAÑADON DEL CORRAL	\N
141	54	9581	CERRO DAVID	\N
141	54	9582	CHURQUIÑEO	\N
141	54	9583	PICHI LEUFU (APEADERO FCGR)	\N
141	54	9584	SAN PEDRO (PILCANIYEU-DPTO. PILCANIYEU)	\N
141	54	9585	SAN RAMON	\N
141	54	9586	COSTA DEL RIO AZUL	\N
141	54	9587	EL AZUL	\N
141	54	9588	EL BOLSON	\N
141	54	9589	EL MANSO	\N
141	54	9590	LOS REPOLLOS	\N
141	54	9591	MALLIN AHOGADO	\N
141	54	9592	VILLA TURISMO	\N
141	54	9593	COLONIA SAN JUAN	\N
141	54	9594	CHOCORI	\N
141	54	9595	COLONIA LA LUISA	\N
141	54	9596	CORONEL FRANCISCO SOSA (EMBARCADERO FCGR)	\N
141	54	9597	EL PORVENIR (EMBARCADERO FCGR)	\N
141	54	9598	GENERAL CONESA	\N
141	54	9599	INGENIO SAN LORENZO	\N
141	54	9600	LA CAROLINA	\N
141	54	9601	LA FLECHA	\N
141	54	9602	LUIS M. ZAGAGLIA	\N
141	54	9603	NUEVA CAROLINA	\N
141	54	9604	PUESTO GAVIÑA	\N
141	54	9605	RINCON DE GASTRE	\N
141	54	9606	SAN JUAN (GRAL. CONESA-DPTO. CONESA)	\N
141	54	9607	SAN LORENZO	\N
141	54	9608	SAN SIMON	\N
141	54	9609	TENIENTE GRAL. EUSTOQUIO FRIAS	\N
141	54	9610	TRAVESIA CASTRO	\N
141	54	9611	BOCA DE LA TRAVESIA	\N
141	54	9612	CINCO CHAÑARES	\N
141	54	9613	LAGUNA CORTES	\N
141	54	9614	NAUPA HUEN	\N
141	54	9615	QUEMPU NIYEU	\N
141	54	9616	TRICACO	\N
141	54	9617	AGUADA GUZMAN	\N
141	54	9618	BAJADA DE ALAMITO	\N
141	54	9619	BARDA COLORADA	\N
141	54	9620	CERRO DE LA POLICIA	\N
141	54	9621	CERRO DE POLICIA	\N
141	54	9622	COYUE CO	\N
141	54	9623	EL CUY	\N
141	54	9624	PATU CO	\N
141	54	9625	PLANICIE DE JAGUELITO	\N
141	54	9626	SAN ANTONIO DEL CUY	\N
141	54	9627	TRECA-CO	\N
141	54	9628	VALLE AZUL	\N
141	54	9629	CANLLEQUIN	\N
141	54	9630	CURA LAUQUEN	\N
141	54	9631	EL CACIQUE	\N
141	54	9632	EL CAMARURO	\N
141	54	9633	EL GAUCHO POBRE	\N
141	54	9634	EL JARDINERO	\N
141	54	9635	HUA-MICHE	\N
141	54	9636	JITA RUSIA	\N
141	54	9637	KILI MALAL	\N
141	54	9638	LA ANGOSTURA	\N
141	54	9639	LA CHILENA	\N
141	54	9640	LA CRIOLLITA	\N
141	54	9641	LA ESTRELLA	\N
141	54	9642	LA EXCURRA	\N
141	54	9643	LA MIMOSA	\N
141	54	9644	LA PORTEÑA	\N
141	54	9645	LA RUBIA	\N
141	54	9646	LA VENCEDORA	\N
141	54	9647	LAGUNA BLANCA	\N
141	54	9648	LANQUIÑEO	\N
141	54	9649	LAS MELLIZAS	\N
141	54	9650	LONCO VACA	\N
141	54	9651	LOS COSTEROS	\N
141	54	9652	LOS PIRINEOS	\N
141	54	9653	LOS QUEBRACHOS	\N
141	54	9654	MENCUE	\N
141	54	9655	MICHIHUAO	\N
141	54	9656	MULANILLO	\N
141	54	9657	PALENQUE NIYEU	\N
141	54	9658	PILAHUE	\N
141	54	9659	SANTA ELENA	\N
141	54	9660	PASO LAS PERLAS	\N
141	54	9661	PASO CORDOVA	\N
141	54	9662	AGUADA DE LOS PAJARITOS	\N
141	54	9663	CONTRALMIRANTE CORDERO	\N
141	54	9664	CUENCA VIDAL	\N
141	54	9665	FERRI	\N
141	54	9666	CINCO SALTOS	\N
141	54	9667	LA PICASA	\N
141	54	9668	BARDA DEL MEDIO	\N
141	54	9669	COLONIA EL MANZANO	\N
141	54	9670	KM 1218	\N
141	54	9671	LAGO PELLEGRINI	\N
141	54	9672	SARGENTO VIDAL	\N
141	54	9673	VILLA EL MANZANO	\N
141	54	9674	VILLA MANZANO	\N
141	54	9675	AGUARA	\N
141	54	9676	CATRIEL	\N
141	54	9677	COLONIA ALMTE. GUERRICO	\N
141	54	9678	COLONIA CATRIEL	\N
141	54	9679	COS ZAURES	\N
141	54	9680	LOS SAUCES	\N
141	54	9681	PEÑAS BLANCAS	\N
141	54	9682	VALLE DE LOS ALAMOS	\N
141	54	9683	COLONIA LOS CANALES	\N
141	54	9684	BARDA CHICA	\N
141	54	9685	BARRIO TRESCIENTAS VIVIENDAS	\N
141	54	9686	CIPOLLETTI	\N
141	54	9687	CUATRO ESQUINAS	\N
141	54	9688	GARRAS	\N
141	54	9689	GENERAL FERNANDEZ ORO	\N
141	54	9690	IRIS	\N
141	54	9691	LA ALIANZA	\N
141	54	9692	LA EMILIA	\N
141	54	9693	LA ESMERALDA (CIPOLLETTI-DPTO. GRAL. ROCA)	\N
141	54	9694	LA ESTANCIA VIEJA	\N
141	54	9695	LA LUCINDA	\N
141	54	9696	LAS ÑATITAS	\N
141	54	9697	SAN JORGE	\N
141	54	9698	CERVANTES	\N
141	54	9699	MAINQUE	\N
141	54	9700	ALLEN	\N
141	54	9701	BARRIO NORTE	\N
141	54	9702	CHACRAS DE ALLEN	\N
141	54	9703	CONTRALMIRANTE MARTIN GUERRICO	\N
141	54	9704	AGUADA DE CORDOBA	\N
141	54	9705	ALEJANDRO STEFENELLI	\N
141	54	9706	ANTIGUO GENERAL ROCA	\N
141	54	9707	BLANCA LOMA	\N
141	54	9708	CAÑADON TRINCAO	\N
141	54	9709	CAMPAMENTO	\N
141	54	9710	COLINIYEN	\N
141	54	9711	COLONIA RUSA	\N
141	54	9712	FUERTE GENERAL ROCA	\N
141	54	9713	GENERAL ROCA	\N
141	54	9714	LA BALSA	\N
141	54	9715	LA COSTA	\N
141	54	9716	LA GEROMITA	\N
141	54	9717	LUPAY NIYEO	\N
141	54	9718	MEDIA LUNA	\N
141	54	9719	PADRE ALEJANDRO STEFENELLI	\N
141	54	9720	PIEDRA BLANCA (GRAL. ROCA-DPTO. GENERAL ROCA)	\N
141	54	9721	PUEBLO VIEJO	\N
141	54	9722	SAN EDUARDO	\N
141	54	9723	CORONEL JUAN JOSE GOMEZ	\N
141	54	9724	PASO CORDOVA	\N
141	54	9725	INGENIERO HUERGO	\N
141	54	9726	BARRIO DON BOSCO	\N
141	54	9727	BARRIO MATADEROS	\N
141	54	9728	BARRIO VILLA ANTARTIDA	\N
141	54	9729	CHICHINALES	\N
141	54	9730	COLONIA REGINA	\N
141	54	9731	GENERAL ENRIQUE GODOY	\N
141	54	9732	INGENIERO JULIAN ROMERO	\N
141	54	9733	INGENIERO OTTO KRAUSE	\N
141	54	9734	KM 1071	\N
141	54	9735	KM 1099	\N
141	54	9736	TERCERA ZONA	\N
141	54	9737	VILLA ALBERDI	\N
141	54	9738	VILLA REGINA	\N
141	54	9739	CONA NIYEU	\N
141	54	9740	CORRAL CHICO	\N
141	54	9741	CUYEN-LEUFU	\N
141	54	9742	FALCKNER	\N
141	54	9743	JANINUE	\N
141	54	9744	LAS MOCHAS	\N
141	54	9745	MENUCO NEGRO	\N
141	54	9746	MINISTRO RAMOS MEXIA	\N
141	54	9747	SIERRA BLANCA	\N
141	54	9748	SIERRA COLORADA	\N
141	54	9749	TALCAHUALA (APEADERO FCGR)	\N
141	54	9750	TAPILUQUE	\N
141	54	9751	TRENETA	\N
141	54	9752	CHENQUENIYEU	\N
141	54	9753	CORRAL DE LOS PINOS	\N
141	54	9754	EL PANTANOSO	\N
141	54	9755	LAS BAYAS	\N
141	54	9756	ÑORQUINCO	\N
141	54	9757	AGUA DEL CERRO	\N
141	54	9758	AGUADA TRONCOSO (EMBARCADERO FCGR)	\N
141	54	9759	ARROYO LAS MINAS	\N
141	54	9760	ARROYO MARTIN (ÑORQUINCO-DPTO. ÑORQUINCO)	\N
141	54	9761	CERRO MESA	\N
141	54	9762	CHACALHUA RUCA	\N
141	54	9763	CHACAY HUARRUCA	\N
141	54	9764	CHACOY (BRACA)	\N
141	54	9765	FITALANCAO (EMBARCADERO FCGR)	\N
141	54	9766	FITAMICHE	\N
141	54	9767	FITATIMEN	\N
141	54	9768	HURRACA (CHACAY)	\N
141	54	9769	MAMUEL CHOIQUE	\N
141	54	9770	PORTEZUELO	\N
141	54	9771	QUINIÑAU	\N
141	54	9772	REPOLLOS	\N
141	54	9773	RIO CHICO	\N
141	54	9774	FUTA RUIN (EMBARCADERO FCGR)	\N
141	54	9775	LOMA PARTIDA	\N
141	54	9776	NITRALA MACOHUE	\N
141	54	9777	OJO DE AGUA (EMBARC.FCGR) (ING. JACOBACCI-DPTO. 25 DE MAYO)	\N
141	54	9778	RIVADAVIA	\N
141	54	9779	KM 823	\N
141	54	9780	BAJO DE LOS LOROS	\N
141	54	9781	BUENA PARADA	\N
141	54	9782	CERRO DE LOS VIEJOS	\N
141	54	9783	CINCO LAGUNAS	\N
141	54	9784	COLONIA JULIA Y ECHARREN	\N
141	54	9785	CORONEL EUGENIO DEL BUSTO	\N
141	54	9786	EL CALDEN	\N
141	54	9787	EL TREBOL	\N
141	54	9788	JUAN DE GARAY	\N
141	54	9789	LA ADELA	\N
141	54	9790	LA AMISTAD	\N
141	54	9791	LA JUANITA (RIO COLORADO-DPTO. PICHI MAHUIDA)	\N
141	54	9792	LA LUNA	\N
141	54	9793	LA MARIA INES	\N
141	54	9794	LA MONTAÑESA	\N
141	54	9795	LA PAMPA	\N
141	54	9796	LAGUNA DEL CHASICO	\N
141	54	9797	MONTE REDONDO	\N
141	54	9798	PICHI MAHUIDA	\N
141	54	9799	RIO COLORADO	\N
141	54	9800	SAN CAYETANO	\N
141	54	9801	SAN JUAN (RIO COLORADO-DPTO. PICHI MAHUIDA)	\N
141	54	9802	SAN LEON	\N
141	54	9803	SAN PEDRO (RIO COLORADO-DPTO. PICHI MAHUIDA)	\N
141	54	9804	SANTA ANA	\N
141	54	9805	ARROYO CHACAY	\N
141	54	9806	PASO CHACABUCO	\N
141	54	9807	VILLA LLANQUIN	\N
141	54	9808	ARROYO BLANCO	\N
141	54	9809	CERRO ALTO	\N
141	54	9810	CORRALITO	\N
141	54	9811	PASO DEL LIMAY	\N
141	54	9812	PASO FLORES	\N
141	54	9813	PASO MIRANDA	\N
141	54	9814	CARHUE	\N
141	54	9815	CASA QUEMADA	\N
141	54	9816	COSTAS DEL PICHI LEUFU	\N
141	54	9817	LA QUEBRADA	\N
141	54	9818	MENUCO VACA MUERTA	\N
141	54	9819	PANQUEHUAO	\N
141	54	9820	PASO DE LOS MOLLES	\N
141	54	9821	PICHI LEUFU ABAJO	\N
141	54	9822	PICHI LEUFU ARRIBA	\N
141	54	9823	PILCANIYEU	\N
141	54	9824	PILCANIYEU VIEJO	\N
141	54	9825	RAYHUAO	\N
141	54	9826	CAÑADON COMALLO	\N
141	54	9827	COMALLO	\N
141	54	9828	COMALLO ABAJO	\N
141	54	9829	COQUELEN	\N
141	54	9830	INGENIERO ZIMMERMANN RESTA (APEADERO FCGR)	\N
141	54	9831	NENEO RUCA (ESTACION FCGR)	\N
141	54	9832	PERITO MORENO	\N
141	54	9833	QUINTA PANAL	\N
141	54	9834	TRES OJOS DE AGUA	\N
141	54	9835	CAÑADON CHILENO	\N
141	54	9836	DINA HUAPI	\N
141	54	9837	LAGUNA DEL MONTE	\N
141	54	9838	POZO SALADO	\N
141	54	9839	SACO VIEJO	\N
141	54	9840	BAJO DEL GUALICHO	\N
141	54	9841	DOCTOR ROGELIO CORTIZO (EMPALME)	\N
141	54	9842	EMPALME DOCTOR ROGELIO CORTISO	\N
141	54	9843	JAGUEL CAMPO MONTE	\N
141	54	9844	LA BOMBILLA	\N
141	54	9845	LAS GRUTAS	\N
141	54	9846	LAS MAQUINAS	\N
141	54	9847	MANCHA BLANCA	\N
141	54	9848	PERCY H. SCOTT (APEADERO FCGR)	\N
141	54	9849	POZO MORO	\N
141	54	9850	SAN ANTONIO OESTE	\N
141	54	9851	ARROYO VERDE	\N
141	54	9852	BALNEARIO LAS GRUTAS	\N
141	54	9853	ARROYO SALADO	\N
141	54	9854	COLONIA CHILAVERT	\N
141	54	9855	PUERTO LOBOS	\N
141	54	9856	SIERRA GRANDE	\N
141	54	9857	ARROYO DE LA VENTANA	\N
141	54	9858	ARROYO LOS BERROS	\N
141	54	9859	ARROYO TEMBRADO	\N
141	54	9860	SIERRA DE LA VENTANA	\N
141	54	9861	SIERRA PAILEMAN	\N
141	54	9862	CAMPANA MAHUIDA	\N
141	54	9863	AGUADA CECILIO	\N
141	54	9864	TENIENTE MAZA (ESTACION FCGR)	\N
141	54	9865	BAJO PICASO	\N
141	54	9866	CHAUQUEN	\N
141	54	9867	CHIPAUQUIL	\N
141	54	9868	EL SALADO	\N
141	54	9869	LIPETREN	\N
141	54	9870	MACACHIN	\N
141	54	9871	MUSTERS	\N
141	54	9872	NAHUEL NIYEU	\N
141	54	9873	PAJALTA (APEADERO FCGR)	\N
141	54	9874	PIEDRA CLAVADA	\N
141	54	9875	PUNTA DE AGUA	\N
141	54	9876	SAN JOSE DE PAJA ALTA	\N
141	54	9877	VALCHETA	\N
141	54	9878	CAIN	\N
141	54	9879	ANECON GRANDE	\N
141	54	9880	CLEMENTE ONELLI	\N
141	54	9881	AGUADA DE GUANACO	\N
141	54	9882	AGUADA ESCONDIDA	\N
141	54	9883	ANECON CHICO	\N
141	54	9884	ATRAICO	\N
141	54	9885	CALCATAPUL	\N
141	54	9886	CARRILAUQUEN	\N
141	54	9887	CHAIFUL	\N
141	54	9888	COLI TORO	\N
141	54	9889	DON GUILLERMO	\N
141	54	9890	EL CHEIFUL	\N
141	54	9891	EL MIRADOR	\N
141	54	9892	EL MOLIGUE	\N
141	54	9893	EL MONTOSO	\N
141	54	9894	EMPALME KILOMETRO 648 (APEADERO FCGR)	\N
141	54	9895	HUAN LUAN	\N
141	54	9896	INGENIERO JACOBACCI	\N
141	54	9897	QUETREQUILE	\N
141	54	9898	YUQUINCHE	\N
141	54	9899	AGUADA DE PIEDRA	\N
141	54	9900	ARROYO MARTIN (MAQUINCHAO-DPTO. 25 DE MAYO)	\N
141	54	9901	BARRIL NIYEO	\N
141	54	9902	BLANCA CHICA	\N
141	54	9903	CHICHIHUAO	\N
141	54	9904	EL CAIN	\N
141	54	9905	LAGUNA GUANACO	\N
141	54	9906	LOS JUNCOS (APEADERO FCGR MAQUINCHAO-DPTO. 25 DE MAYO)	\N
141	54	9907	LOS MANANTIALES	\N
141	54	9908	MANCULLIQUE	\N
141	54	9909	MAQUINCHAO	\N
141	54	9910	MARI LAUQUEN	\N
141	54	9911	NILUAN	\N
141	54	9912	PUERTO HERMOSO	\N
141	54	9913	QUO VADIS	\N
141	54	9914	RUCU LUAN	\N
141	54	9915	TROMENIYEU	\N
141	54	9916	VACA LAUQUEN	\N
141	54	9917	AGUADA DE GUERRA	\N
141	54	9918	BUENZANIYEU	\N
141	54	9919	CAÑADA GRANDE	\N
141	54	9920	CALTRAUNA	\N
141	54	9921	CERRO ABANICO (APEADERO FCGR)	\N
141	54	9922	COMI-C	\N
141	54	9923	GANZU LAUQUEN (APEADERO FCGR)	\N
141	54	9924	LA RINCONADA	\N
141	54	9925	LAGUNITA	\N
141	54	9926	LENZANIYEN	\N
141	54	9927	LOMA BLANCA	\N
141	54	9928	LOS MENUCOS	\N
141	54	9929	PRAHUANIYEU	\N
141	54	9930	LA ESPERANZA	\N
142	54	9931	SANTA TERESA	\N
142	54	9932	EL DORADO (APOLINARIO SARAVIA)	\N
142	54	9933	ANTA	\N
142	54	9934	CARRERAS	\N
142	54	9935	EBRO	\N
142	54	9936	EL LIBANO	\N
142	54	9937	EL REY	\N
142	54	9938	EL YESO	\N
142	54	9939	ESTANCIA VIEJA	\N
142	54	9940	GONZALEZ	\N
142	54	9941	LAS FLACAS	\N
142	54	9942	LAS VIBORAS	\N
142	54	9943	LOS NOGALES	\N
142	54	9944	PASO DE LA CRUZ	\N
142	54	9945	PIQUETE DE ANTA	\N
142	54	9946	SALADILLO	\N
142	54	9947	SAN SEBASTIAN	\N
142	54	9948	SAUCE BAJADA	\N
142	54	9949	CEIBALITO	\N
142	54	9950	CHAÑAR MUYO	\N
142	54	9951	CHORROARIN	\N
142	54	9952	CORONEL OLLEROS	\N
142	54	9953	DIVISADERO	\N
142	54	9954	EL CARRIZAL	\N
142	54	9955	EL JARAVI	\N
142	54	9956	EL PACARA	\N
142	54	9957	LA MANGA	\N
142	54	9958	LAGUNITA	\N
142	54	9959	LOS CHIFLES	\N
142	54	9960	MOLLE POZO	\N
142	54	9961	PASO DE LAS CARRETAS	\N
142	54	9962	PASO LA CRUZ	\N
142	54	9963	POBLACION	\N
142	54	9964	PORVENIR	\N
142	54	9965	PULI	\N
142	54	9966	SAUZAL	\N
142	54	9967	CORONEL VIDT	\N
142	54	9968	JOAQUIN V. GONZALEZ	\N
142	54	9969	LAGUNA BLANCA	\N
142	54	9970	SANTO DOMINGO	\N
142	54	9971	SAUCE SOLO	\N
142	54	9972	AGUA SUCIA	\N
142	54	9973	ALTO ALEGRE	\N
142	54	9974	APOLINARIO SARAVIA	\N
142	54	9975	BARREALITO	\N
142	54	9976	CAMPO ALEGRE	\N
142	54	9977	COLONIA HURLINGHAM	\N
142	54	9978	CORONEL MOLLINEDO	\N
142	54	9979	EL BORDO (APOLINARIO SARAVIA)	\N
142	54	9980	EL CARMEN	\N
142	54	9981	EL MANANTIAL	\N
142	54	9982	EL PERICOTE	\N
142	54	9983	ESQUINA	\N
142	54	9984	GENERAL PIZARRO	\N
142	54	9985	LAGUNA VERDE	\N
142	54	9986	LAS BATEAS	\N
142	54	9987	LAS FLORES	\N
142	54	9988	LAS LAJITAS	\N
142	54	9989	LAS TORTUGAS	\N
142	54	9990	LAS VATEAS	\N
142	54	9991	LUIS BURELA	\N
142	54	9992	MONASTERIOS	\N
142	54	9993	PALERMO	\N
142	54	9994	PIQUETE CABADO	\N
142	54	9995	POZO GRANDE	\N
142	54	9996	POZO VERDE	\N
142	54	9997	RIO DEL VALLE	\N
142	54	9998	ROSARIO DEL DORADO	\N
142	54	9999	SAN RAMON	\N
142	54	10000	TOTORAL	\N
142	54	10001	EL QUEBRACHAL	\N
142	54	10002	EL VENCIDO	\N
142	54	10003	FLORESTA	\N
142	54	10004	FUERTE EL PITO	\N
142	54	10005	GAONA	\N
142	54	10006	LLUCHA	\N
142	54	10007	MACAPILLO	\N
142	54	10008	MANGA VIEJA	\N
142	54	10009	NUESTRA SEÑORA DE TALAVERA	\N
142	54	10010	PRINGLES	\N
142	54	10011	QUEBRACHAL	\N
142	54	10012	ROCA	\N
142	54	10013	SAN GABRIEL	\N
142	54	10014	SANTA ROSA DE ANTA	\N
142	54	10015	SIMBOLAR (MACAPILLO)	\N
142	54	10016	SUNCHALITO	\N
142	54	10017	TACO PAMPA	\N
142	54	10018	TOLLOCHE	\N
142	54	10019	TORO PAMPA	\N
142	54	10020	VENCIDA	\N
142	54	10021	VINAL POZO	\N
142	54	10022	FINCA MISION ZENTA	\N
142	54	10023	SAN IGNACIO	\N
142	54	10024	PIZARRO	\N
142	54	10025	SALTA FORESTAL	\N
142	54	10026	LOS TAPIRES	\N
142	54	10027	EL MILAGRO	\N
142	54	10028	PALO A PIQUE	\N
142	54	10029	SAUCE BAJADO	\N
142	54	10030	EL VALLE	\N
142	54	10031	MANGRULLO	\N
142	54	10032	LA PROVIDENCIA	\N
142	54	10033	EL ALGARROBAL	\N
142	54	10034	EL POTRERO	\N
142	54	10035	PALERMO OESTE	\N
142	54	10036	PAYOGASTA	\N
142	54	10037	PUNTA DE AGUA	\N
142	54	10038	TONCO	\N
142	54	10039	CACHI	\N
142	54	10040	CACHI ADENTRO	\N
142	54	10041	PUEBLO VIEJO	\N
142	54	10042	PUERTA DE LA PAYA	\N
142	54	10043	PUIL	\N
142	54	10044	RIO BLANCO	\N
142	54	10045	RIO TORO	\N
142	54	10046	LA PAYA	\N
142	54	10047	SAN JOSE DE ESCALCHI	\N
142	54	10048	VALLECITO	\N
142	54	10049	RANCAGUA	\N
142	54	10050	BUENA VISTA	\N
142	54	10051	LAS TRANCAS	\N
142	54	10052	LAS CORTADERAS	\N
142	54	10053	LA CIENEGUITA	\N
142	54	10054	MACHO RASTROJO	\N
142	54	10055	QUISCA GRANDE	\N
142	54	10056	TOLOMBON	\N
142	54	10057	CAFAYATE	\N
142	54	10058	EL RECREO	\N
142	54	10059	LA PUNILLA	\N
142	54	10060	LAS CONCHAS	\N
142	54	10061	LOROHUASI	\N
142	54	10062	SANTA BARBARA	\N
142	54	10063	YACOCHUYA	\N
142	54	10064	YANCHUYA	\N
142	54	10065	BELGRANO (SALTA-DPTO. CAPITAL)	\N
142	54	10066	CAMPO CASEROS	\N
142	54	10067	CHACHAPOYAS	\N
142	54	10068	CHAMICAL	\N
142	54	10069	LA LAGUNILLA	\N
142	54	10070	LA QUESERA	\N
142	54	10071	LA TROJA	\N
142	54	10072	LOS NOQUES	\N
142	54	10073	SALTA	\N
142	54	10074	ATOCHA	\N
142	54	10075	CASTELLANOS	\N
142	54	10076	GENERAL ALVARADO	\N
142	54	10077	LAS COSTAS	\N
142	54	10078	PAREDES	\N
142	54	10079	VILLA SAN LORENZO	\N
142	54	10080	SAN RAFAEL	\N
142	54	10081	COBA	\N
142	54	10082	HUMAITA	\N
142	54	10083	LOS ALAMOS	\N
142	54	10084	CEBADOS	\N
142	54	10085	CERRILLOS	\N
142	54	10086	COLON	\N
142	54	10087	EL COLEGIO	\N
142	54	10088	ISLA DE LA CANDELARIA	\N
142	54	10089	LA CANDELARIA	\N
142	54	10090	LA FALDA	\N
142	54	10091	LA FAMA	\N
142	54	10092	OLMOS	\N
142	54	10093	PIEDEMONTE	\N
142	54	10094	RIO ANCHO	\N
142	54	10095	RODEOS	\N
142	54	10096	SAN CLEMENTE	\N
142	54	10097	SANTA ELENA	\N
142	54	10098	VILLA LOS TARCOS	\N
142	54	10099	ZANJON	\N
142	54	10100	EL LEONCITO	\N
142	54	10101	LA MERCED	\N
142	54	10102	LAS PIRCAS	\N
142	54	10103	LAS TIENDITAS	\N
142	54	10104	SAN AGUSTIN	\N
142	54	10105	SAN GERONIMO	\N
142	54	10106	SUMALAO	\N
142	54	10107	EL HUAICO	\N
142	54	10108	LA BLANCA	\N
142	54	10109	LAS PALMAS	\N
142	54	10110	AGUA NEGRA	\N
142	54	10111	EL CANDADO	\N
142	54	10112	EL MARAY	\N
142	54	10113	LAS ANIMAS	\N
142	54	10114	LAS ZANJAS	\N
142	54	10115	MAL PASO	\N
142	54	10116	QUEBRADA DE ESCOIPE	\N
142	54	10117	SAN MARTIN LA CUESTA	\N
142	54	10118	YACERA	\N
142	54	10119	CUESTA DEL OBISPO	\N
142	54	10120	CACHO MOLINO	\N
142	54	10121	CALVIMONTE	\N
142	54	10122	EL CARRIL	\N
142	54	10123	LA TOMA	\N
142	54	10124	LAS GARZAS	\N
142	54	10125	CHICOANA	\N
142	54	10126	CHIVILME	\N
142	54	10127	EL MOYAR	\N
142	54	10128	EL SIMBOLAR	\N
142	54	10129	EL TIPAL	\N
142	54	10130	LA CALAVERA	\N
142	54	10131	LA GUARDIA	\N
142	54	10132	LA MARGARITA	\N
142	54	10133	LA MAROMA	\N
142	54	10134	LAS MORAS	\N
142	54	10135	LOS LOS	\N
142	54	10136	PALMIRA	\N
142	54	10137	PEÑAFLOR	\N
142	54	10138	PEDREGAL	\N
142	54	10139	POTRERO DE DIAZ	\N
142	54	10140	PULARES	\N
142	54	10141	SAN FERNANDO DE ESCOIPE	\N
142	54	10142	SANTA GERTRUDIS	\N
142	54	10143	TILIAN	\N
142	54	10144	VIÑACO	\N
142	54	10145	VILLA FANNY	\N
142	54	10146	EL NOGALAR	\N
142	54	10147	SAN MARTIN	\N
142	54	10148	LA ZANJA	\N
142	54	10149	ALGARROBAL 	\N
142	54	10150	CHACRA EXPERIMENTAL	\N
142	54	10151	GENERAL GÜEMES	\N
142	54	10152	KM 1094	\N
142	54	10153	SALADILLO	\N
142	54	10154	BETANIA	\N
142	54	10155	CAMPO SANTO	\N
142	54	10156	CANTERA EL SAUCE	\N
142	54	10157	COBOS	\N
142	54	10158	EL BORDO	\N
142	54	10159	RODEO GRANDE	\N
142	54	10160	LOTE SAN MARTIN	\N
142	54	10161	SANTA ROSA	\N
142	54	10162	CABEZA DE BUEY	\N
142	54	10163	CRUZ QUEMADA	\N
142	54	10164	LAS MESITAS	\N
142	54	10165	PALOMITAS	\N
142	54	10166	VIRGILIO TEDIN	\N
142	54	10167	EL PRADO	\N
142	54	10168	YAQUIASME	\N
142	54	10169	EL ZAPALLAR	\N
142	54	10170	BARRIO LA LOMA	\N
142	54	10171	BARRIO SAN CAYETANO	\N
142	54	10172	ANGOSTURA	\N
142	54	10173	ESPINILLO	\N
142	54	10174	BUEN LUGAR	\N
142	54	10175	COLONIA OTOMANA	\N
142	54	10176	EL CUCHILLO	\N
142	54	10177	EL RETIRO	\N
142	54	10178	EMBARCACION	\N
142	54	10179	LA FORTUNA	\N
142	54	10180	LA QUENA	\N
142	54	10181	LOS BALDES	\N
142	54	10182	NUEVO PORVENIR	\N
142	54	10183	PUESTO GRANDE	\N
142	54	10184	SANTA VICTORIA	\N
142	54	10185	ANTONIO QUIJARRO	\N
142	54	10186	CAMPICHUELO	\N
142	54	10187	CORONEL CORNEJO	\N
142	54	10188	CORRALITO	\N
142	54	10189	GENERAL BALLIVIAN	\N
142	54	10190	PASTOR SENILLOSA	\N
142	54	10191	POCOY	\N
142	54	10192	SENDA HACHADA	\N
142	54	10193	TRANQUITAS	\N
142	54	10194	CAMPO LIBRE	\N
142	54	10195	DRAGONES	\N
142	54	10196	EMBOSCADA	\N
142	54	10197	HICKMANN	\N
142	54	10198	LUNA MUERTA	\N
142	54	10199	MISION CHAQUEÑA	\N
142	54	10200	MISTOLAR	\N
142	54	10201	MONTE CARMELO	\N
142	54	10202	PADRE LOZANO	\N
142	54	10203	PEDRO LOZANO	\N
142	54	10204	POZO BRAVO	\N
142	54	10205	TABACO CIMARRON	\N
142	54	10206	MANUELA PEDRAZA	\N
142	54	10207	TARTAGAL	\N
142	54	10208	TONONO	\N
142	54	10209	VILLA SAAVEDRA	\N
142	54	10210	YARIGUARENDA	\N
142	54	10211	GENERAL ENRIQUE MOSCONI	\N
142	54	10212	LAS LOMITAS	\N
142	54	10213	CAMINERA SAN PEDRITO	\N
142	54	10214	CAMPAMENTO TABLILLA	\N
142	54	10215	CAMPAMENTO VESPUCIO	\N
142	54	10216	EL AGUAY	\N
142	54	10217	RECAREDO	\N
142	54	10218	PIQUIRENDA	\N
142	54	10219	TOBANTIRENDA	\N
142	54	10220	YACUY	\N
142	54	10221	AGUARAY	\N
142	54	10222	CAMPO DURAN	\N
142	54	10223	MACUETA	\N
142	54	10224	RIO CARAPAN	\N
142	54	10225	ACAMBUCO	\N
142	54	10226	SALVADOR MAZZA	\N
142	54	10227	ZANJA HONDA	\N
142	54	10228	CAMPO LARGO	\N
142	54	10229	MISION CHERENTA	\N
142	54	10230	EL CHORRO	\N
142	54	10231	LAS YANAS	\N
142	54	10232	EL PESCADITO	\N
142	54	10233	CAPIAZUTI	\N
142	54	10234	CARBONCITO	\N
142	54	10235	TIMBOIRENDA	\N
142	54	10236	MEDIA LUNA	\N
142	54	10237	BOBADAL	\N
142	54	10238	EL SAUZAL	\N
142	54	10239	EL TREMENTINAL	\N
142	54	10240	MADREJONES	\N
142	54	10241	EL ALGARROBAL	\N
142	54	10242	BAULES	\N
142	54	10243	MISION LA MORA	\N
142	54	10244	ACOSTA	\N
142	54	10245	ALEMANIA	\N
142	54	10246	CARAHUASI	\N
142	54	10247	CEVILAR	\N
142	54	10248	COROPAMPA	\N
142	54	10249	GUACHIPAS	\N
142	54	10250	LA FLORIDA	\N
142	54	10251	LA PAMPA	\N
142	54	10252	PAMPA GRANDE	\N
142	54	10253	REDONDO	\N
142	54	10254	RIO ALEMANIA	\N
142	54	10255	SAUCE REDONDO	\N
142	54	10256	TIPA SOLA	\N
142	54	10257	ISLA DE CAÑAS	\N
142	54	10258	ASTILLERO	\N
142	54	10259	CANCILLAR	\N
142	54	10260	CASA GRANDE	\N
142	54	10261	CHIYAYOE	\N
142	54	10262	COLANZULI	\N
142	54	10263	FINCA SANTIAGO	\N
142	54	10264	HIGUERAS	\N
142	54	10265	IRUYA	\N
142	54	10266	LA HUERTA	\N
142	54	10267	MATANSILLAS	\N
142	54	10268	PINAL	\N
142	54	10269	RODEO COLORADO	\N
142	54	10270	SAN ANTONIO DE IRUYA	\N
142	54	10271	SAN ISIDRO DE IRUYA	\N
142	54	10272	SAN JUAN	\N
142	54	10273	SAN PEDRO IRUYA	\N
142	54	10274	TIPAYO	\N
142	54	10275	UCHOGOL	\N
142	54	10276	VILLA ALEM	\N
142	54	10277	VOLCAN HIGUERAS	\N
142	54	10278	TOROYOC	\N
142	54	10279	VIZCARRA	\N
142	54	10280	VALLE DELGADO	\N
142	54	10281	ABRA DE ARAGUYOC	\N
142	54	10282	ABRA DEL SAUCE	\N
142	54	10283	LIMONCITOS	\N
142	54	10284	SALA ESCUYA	\N
142	54	10285	TRES MORROS	\N
142	54	10286	LA MESADA GRANDE	\N
142	54	10287	EL ALFARCITO	\N
142	54	10288	HUAYRA HUASI	\N
142	54	10289	ANTONIO ALICE	\N
142	54	10290	LA CALDERA	\N
142	54	10291	CALDERILLA	\N
142	54	10292	CURUZU	\N
142	54	10293	LESSER	\N
142	54	10294	LOS MERCADOS	\N
142	54	10295	MAYO TORITO	\N
142	54	10296	POTRERO DE CASTILLA	\N
142	54	10297	SAN ALEJO	\N
142	54	10298	SANTA RUFINA	\N
142	54	10299	VAQUEROS	\N
142	54	10300	VELARDES	\N
142	54	10301	YACONES	\N
142	54	10302	COBRES	\N
142	54	10303	GALLINATO	\N
142	54	10304	MOJOTORO	\N
142	54	10305	BARADERO	\N
142	54	10306	LA CANDELARIA	\N
142	54	10307	EL CEIBAL	\N
142	54	10308	EL BRETE	\N
142	54	10309	EL CUIBAL	\N
142	54	10310	EL JARDIN	\N
142	54	10311	LOS MOGOTES	\N
142	54	10312	OVEJERO	\N
142	54	10313	RUIZ DE LOS LLANOS	\N
142	54	10314	SALAZAR	\N
142	54	10315	TALA	\N
142	54	10316	CERRO NEGRO	\N
142	54	10317	QUEBRADA MUÑANO	\N
142	54	10318	MUÑANO	\N
142	54	10319	EL RODEO	\N
142	54	10320	LA POMA	\N
142	54	10321	MINA SAN ESTEBAN	\N
142	54	10322	MINA SAN GUILLERMO	\N
142	54	10323	MINAS VICTORIA	\N
142	54	10324	PUEBLO VIEJO	\N
142	54	10325	SALADILLO	\N
142	54	10326	TRIGAL	\N
142	54	10327	VILLITAS	\N
142	54	10328	ESQUINA DE GUARDIA	\N
142	54	10329	POTRERO	\N
142	54	10330	ABLOME	\N
142	54	10331	AMPASCACHI	\N
142	54	10332	CABRA CORRAL	\N
142	54	10333	CORONEL MOLDES	\N
142	54	10334	EL CARANCHO	\N
142	54	10335	EL CARMEN	\N
142	54	10336	LA ARGENTINA	\N
142	54	10337	LA BODEGA	\N
142	54	10338	LA BODEGUITA	\N
142	54	10339	OSMA	\N
142	54	10340	PASO DEL RIO	\N
142	54	10341	PIEDRAS MORADAS	\N
142	54	10342	PUENTE DE DIAZ	\N
142	54	10343	QUISCA LORO	\N
142	54	10344	RETIRO	\N
142	54	10345	SALADILLO DE OSMA	\N
142	54	10346	SAN NICOLAS	\N
142	54	10347	SAUCE ALEGRE	\N
142	54	10348	SEVILLAR	\N
142	54	10349	TRES ACEQUIAS	\N
142	54	10350	LA VIÑA	\N
142	54	10351	LAS LECHUZAS	\N
142	54	10352	TALAPAMPA	\N
142	54	10353	ENTRE RIOS	\N
142	54	10354	ABRA DEL GALLO	\N
142	54	10355	ACAZOQUE	\N
142	54	10356	JUNCAL	\N
142	54	10357	MORRO COLORADO	\N
142	54	10358	NACIMIENTOS	\N
142	54	10359	PASTOS GRANDES	\N
142	54	10360	PIZCUNO	\N
142	54	10361	SAN ANTONIO DE LOS COBRES	\N
142	54	10362	SANTA ROSA DE LOS PASTOS GRANDES	\N
142	54	10363	UNCURU	\N
142	54	10364	CAIPE	\N
142	54	10365	CHUCULAQUI	\N
142	54	10366	LA CASUALIDAD	\N
142	54	10367	LAGUNA SECA	\N
142	54	10368	OLACAPATO	\N
142	54	10369	QUEBRADA DEL AGUA (ESTACION FCGB)	\N
142	54	10370	SALAR DE POCITOS	\N
142	54	10371	SOCOMPA	\N
142	54	10372	TACA TACA	\N
142	54	10373	TOLAR GRANDE	\N
142	54	10374	UNQUILLAL	\N
142	54	10375	VEGA DE ARIZARO	\N
142	54	10376	PISCUNO	\N
142	54	10377	ACHARAS	\N
142	54	10378	CHILCAS	\N
142	54	10379	JURAMENTO	\N
142	54	10380	LA POSTA	\N
142	54	10381	LAS ACHERAS	\N
142	54	10382	LAS CUESTITAS	\N
142	54	10383	LUMBRERAS	\N
142	54	10384	MIRAFLORES	\N
142	54	10385	QUESERA	\N
142	54	10386	RIO PIEDRAS	\N
142	54	10387	BALDERRAMA	\N
142	54	10388	CAMPO ALEGRE	\N
142	54	10389	CAMPO AZUL	\N
142	54	10390	CONCHAS	\N
142	54	10391	DURAZNO	\N
142	54	10392	EL GUANACO	\N
142	54	10393	ESTECO	\N
142	54	10394	LA AGUADITA	\N
142	54	10395	LAS JUNTAS	\N
142	54	10396	METAN	\N
142	54	10397	NOGALITO	\N
142	54	10398	PASO DEL DURAZNO	\N
142	54	10399	PASTIADERO	\N
142	54	10400	PERU	\N
142	54	10401	PUNTA DEL AGUA	\N
142	54	10402	SANTA ELENA	\N
142	54	10403	SCHNEIDEWIND	\N
142	54	10404	SUCHA PERA	\N
142	54	10405	VERA CRUZ	\N
142	54	10406	YATASTO	\N
142	54	10407	METAN VIEJO	\N
142	54	10408	ARROCERO ITALIANO	\N
142	54	10409	BAJO GRANDE	\N
142	54	10410	EL GALPON	\N
142	54	10411	EL PARQUE	\N
142	54	10412	FINCA ARMONIA	\N
142	54	10413	FINCA ROCCA	\N
142	54	10414	LA ARMONIA	\N
142	54	10415	LA POBLACION	\N
142	54	10416	LAS DELICIAS	\N
142	54	10417	OVEJERIA	\N
142	54	10418	POBLACION DE ORTEGA	\N
142	54	10419	ALTO DEL MISTOL	\N
142	54	10420	EL TUNAL	\N
142	54	10421	LA CARRETERA	\N
142	54	10422	LAGUNITA NUEVA POBLACION	\N
142	54	10423	LOS ROSALES	\N
142	54	10424	POTRERO	\N
142	54	10425	SAN JOSE DE ORQUERAS	\N
142	54	10426	TALAMUYO	\N
142	54	10427	TALAS	\N
142	54	10428	EL VALLECITO	\N
142	54	10429	EL ALTAMISQUI	\N
142	54	10430	CORRAL QUEMADO	\N
142	54	10431	BANDA GRANDE	\N
142	54	10432	BREALITO	\N
142	54	10433	BURRO YACO	\N
142	54	10434	CERRO BRAVO	\N
142	54	10435	CERRO DE LA ZORRA VIEJA	\N
142	54	10436	CERRO DEL AGUA DE LA FALDA	\N
142	54	10437	COLMENAR	\N
142	54	10438	COLOME	\N
142	54	10439	COLTE	\N
142	54	10440	CORRIDA DE CORI	\N
142	54	10441	DIAMANTE	\N
142	54	10442	EL BREALITO	\N
142	54	10443	EL CHURCAL	\N
142	54	10444	ESQUINA	\N
142	54	10445	HOMBRE MUERTO	\N
142	54	10446	HUMANAS	\N
142	54	10447	LURACATAO	\N
142	54	10448	MOLINOS	\N
142	54	10449	PEÑAS BLANCAS	\N
142	54	10450	SAN JOSE DE COLTE	\N
142	54	10451	SECLANTA ADENTRO	\N
142	54	10452	SECLANTAS	\N
142	54	10453	TACUIL	\N
142	54	10454	TOMUCO	\N
142	54	10455	VOLCAN AZUFRE	\N
142	54	10456	AMAICHA	\N
142	54	10457	ALUMBRE	\N
142	54	10458	LA PUERTA	\N
142	54	10459	COCHIYACO	\N
142	54	10460	GUALFIN	\N
142	54	10461	PARANI	\N
142	54	10462	POZO AZUL	\N
142	54	10463	RIO COLORADO	\N
142	54	10464	RIO DE LAS PIEDRAS	\N
142	54	10465	RIO PESCADO	\N
142	54	10466	SAN ANDRES	\N
142	54	10467	SAN RAMON DE LA NUEVA ORAN	\N
142	54	10468	AGUAS BLANCAS	\N
142	54	10469	COLONIA SANTA ROSA	\N
142	54	10470	SANTA CRUZ	\N
142	54	10471	ANGEL PEREDO	\N
142	54	10472	EL TABACAL	\N
142	54	10473	HIPOLITO YRIGOYEN	\N
142	54	10474	MARIA LUISA	\N
142	54	10475	ALGARROBAL	\N
142	54	10476	ARBOL SOLO	\N
142	54	10477	EL QUIMILAR	\N
142	54	10478	LAS VARAS	\N
142	54	10479	PICHANAL	\N
142	54	10480	PUESTO DEL MEDIO	\N
142	54	10481	YACARA	\N
142	54	10482	ARENALES	\N
142	54	10483	CHAGUARAL	\N
142	54	10484	ESTEBAN DE URIZAR	\N
142	54	10485	JERONIMO MATORRAS	\N
142	54	10486	LA ESTRELLA	\N
142	54	10487	MARTINEZ DEL TINEO	\N
142	54	10488	YUCHAN	\N
142	54	10489	SAUCELITO	\N
142	54	10490	SANTA MARINA	\N
142	54	10491	URUNDEL	\N
142	54	10492	MANUEL ELORDI	\N
142	54	10493	ABRA GRANDE	\N
142	54	10494	LOS NARANJOS	\N
142	54	10495	PEÑA COLORADA	\N
142	54	10496	EL TOTORAL	\N
142	54	10497	COLONIA G	\N
142	54	10498	POZO CERCADO	\N
142	54	10499	SAN MIGUEL	\N
142	54	10500	EL SAUCE	\N
142	54	10501	EL ALGARROBO	\N
142	54	10502	AGUAS MUERTAS	\N
142	54	10503	ALTO VERDE	\N
142	54	10504	BELGRANO	\N
142	54	10505	CAMPO ARGENTINO	\N
142	54	10506	EL DESTIERRO	\N
142	54	10507	EL SOLDADITO	\N
142	54	10508	EL TUNALITO	\N
142	54	10509	FORTIN FRIAS	\N
142	54	10510	LA CANCHA	\N
142	54	10511	LA ESQUINITA	\N
142	54	10512	LA TABLADA	\N
142	54	10513	LA UNION	\N
142	54	10514	LAS BOLSAS	\N
142	54	10515	LAS LLAVES	\N
142	54	10516	MARTIN GARCIA	\N
142	54	10517	PALMARCITO	\N
142	54	10518	PARAISO	\N
142	54	10519	PASO EL MILAGRO SAN ANICETO	\N
142	54	10520	PORONGAL	\N
142	54	10521	POZO DEL PATO	\N
142	54	10522	POZO DEL ZORRO	\N
142	54	10523	POZO VERDE	\N
142	54	10524	PUESTO DE LA VIUDA	\N
142	54	10525	RIVADAVIA	\N
142	54	10526	SAN ISIDRO	\N
142	54	10527	VICTORICA	\N
142	54	10528	VILLA PETRONA	\N
142	54	10529	EL CUICO	\N
142	54	10530	CORZUELA	\N
142	54	10531	CAPITAN JUAN PAGE	\N
142	54	10532	LOS BLANCOS	\N
142	54	10533	LOS RANCHILLOS	\N
142	54	10534	MEDIA LUNA	\N
142	54	10535	MISTOL MAREADO	\N
142	54	10536	MORILLO	\N
142	54	10537	PLUMA DEL PATO	\N
142	54	10538	RESISTENCIA	\N
142	54	10539	SAN PATRICIO	\N
142	54	10540	SANTA CLARA	\N
142	54	10541	SURI PINTADO	\N
142	54	10542	TRES POZOS	\N
142	54	10543	SAN PEDRO	\N
142	54	10544	ALTO DE LA SIERRA	\N
142	54	10545	AMBERES	\N
142	54	10546	HITO 1	\N
142	54	10547	LA PAZ	\N
142	54	10548	MISION LA PAZ	\N
142	54	10549	SANTA MARIA	\N
142	54	10550	SANTA VICTORIA ESTE	\N
142	54	10551	CORONEL JUAN SOLA	\N
142	54	10552	LA PUNTANA	\N
142	54	10553	CHAÑARES ALTOS	\N
142	54	10554	EL DESEMBOQUE	\N
142	54	10555	POZO DE ALGARROBO	\N
142	54	10556	EL ESPINILLO	\N
142	54	10557	TRES HORCONES	\N
142	54	10558	EL MIRADOR	\N
142	54	10559	MISION SAN FELIPE	\N
142	54	10560	EL OCULTAR	\N
142	54	10561	TERNERA ATADA	\N
142	54	10562	EL DIVISADERO	\N
142	54	10563	EL BREAL	\N
142	54	10564	POZO LARGO	\N
142	54	10565	POZO EL MULATO	\N
142	54	10566	LA SALVACION	\N
142	54	10567	POZO DEL SAUCE	\N
142	54	10568	FINCA RESISTENCIA	\N
142	54	10569	CIERVO CANSADO	\N
142	54	10570	FINCA LA ARGENTINA	\N
142	54	10571	PELICANO QUEMADO	\N
142	54	10572	EL LECHERON	\N
142	54	10573	EL TRAMPEADERO	\N
142	54	10574	PLUMA DE PATO	\N
142	54	10575	LAS HORQUETAS	\N
142	54	10576	AGUA VERDE	\N
142	54	10577	MAGDALENA	\N
142	54	10578	EL CARPINTERO	\N
142	54	10579	PUESTO EL PANCHO	\N
142	54	10580	EL TOTORAL	\N
142	54	10581	POZO DEL TORO	\N
142	54	10582	EL COLGAO	\N
142	54	10583	LA ENTRADA	\N
142	54	10584	LOS TRES POZOS	\N
142	54	10585	POZO EL TIGRE	\N
142	54	10586	AGUAS CALIENTES	\N
142	54	10587	LOS BAÑOS	\N
142	54	10588	BARBAYASCO	\N
142	54	10589	COSME	\N
142	54	10590	DURAZNITO	\N
142	54	10591	EL PORTEZUELO	\N
142	54	10592	LA MATILDE	\N
142	54	10593	LAS PIEDRITAS	\N
142	54	10594	LOS POCITOS	\N
142	54	10595	OJO DE AGUA	\N
142	54	10596	OVANDO	\N
142	54	10597	PALOMAR	\N
142	54	10598	ROSARIO DE LA FRONTERA	\N
142	54	10599	VILLA AURELIA	\N
142	54	10600	EL NARANJO	\N
142	54	10601	SAN PEDRO DE LOS CORRALES	\N
142	54	10602	VAQUERIA	\N
142	54	10603	ALMIRANTE BROWN	\N
142	54	10604	ANTILLA	\N
142	54	10605	APEADERO COCHABAMBA	\N
142	54	10606	BAJADA BLANCA	\N
142	54	10607	BALBOA	\N
142	54	10608	CERRO COLORADO	\N
142	54	10609	COLGADAS	\N
142	54	10610	CONDOR	\N
142	54	10611	COPO QUILE	\N
142	54	10612	EL BORDO	\N
142	54	10613	EL CONDOR	\N
142	54	10614	EL POTRERO	\N
142	54	10615	LA CIENAGA	\N
142	54	10616	LA FIRMEZA	\N
142	54	10617	LA PAJITA	\N
142	54	10618	LAS CATITAS	\N
142	54	10619	LAS SALADAS	\N
142	54	10620	MORENILLO	\N
142	54	10621	POZO BLANCO	\N
142	54	10622	PUENTE DE PLATA	\N
142	54	10623	RIO URUEÑA	\N
142	54	10624	SAN LORENZO	\N
142	54	10625	SAN LUIS	\N
142	54	10626	SANTA CATALINA	\N
142	54	10627	SURI MICUNA	\N
142	54	10628	TALA YACO	\N
142	54	10629	VILLA CORTA	\N
142	54	10630	ARENAL	\N
142	54	10631	BAJADA DE GAVI	\N
142	54	10632	BAJADA GRANDE	\N
142	54	10633	EL CORRAL VIEJO	\N
142	54	10634	EL OJITO	\N
142	54	10635	EL PUESTITO	\N
142	54	10636	EL TANDIL	\N
142	54	10637	FEDERACION	\N
142	54	10638	HORCONES	\N
142	54	10639	LA HOYADA	\N
142	54	10640	LA PALATA	\N
142	54	10641	LA PLATA	\N
142	54	10642	LAS MOJARRAS	\N
142	54	10643	LAS VENTANAS	\N
142	54	10644	LOS ZANJONES	\N
142	54	10645	PASO VERDE	\N
142	54	10646	POZOS LARGOS	\N
142	54	10647	SAN FELIPE	\N
142	54	10648	TAMAS CORTADAS	\N
142	54	10649	ALMONA	\N
142	54	10650	LOS CORRALES	\N
142	54	10651	ROSALES	\N
142	54	10652	ORAN	\N
142	54	10653	CANTEROS	\N
142	54	10654	BALLENAL	\N
142	54	10655	CAMARA	\N
142	54	10656	EL MANZANO	\N
142	54	10657	EL MOLLAR	\N
142	54	10658	EL PORVENIR	\N
142	54	10659	EL PUCARA	\N
142	54	10660	EL TIMBO	\N
142	54	10661	LAS ROSAS	\N
142	54	10662	ROSARIO DE LERMA	\N
142	54	10663	ALEJO DE ALBERRO	\N
142	54	10664	CAMPO QUIJANO	\N
142	54	10665	EL ENCON	\N
142	54	10666	EL TUNAL	\N
142	54	10667	LA SILLETA	\N
142	54	10668	POTRERO DE LINARES	\N
142	54	10669	POTRERO DE URIBURU	\N
142	54	10670	SILLETA	\N
142	54	10671	CACHIÑAL	\N
142	54	10672	CERRO BAYO	\N
142	54	10673	CHORRILLITOS	\N
142	54	10674	CHORRILLOS	\N
142	54	10675	DAMIAN M. TORINO	\N
142	54	10676	DIEGO DE ALMAGRO	\N
142	54	10677	EL ALFREDITO	\N
142	54	10678	EL ALISAL	\N
142	54	10679	EL GOLGOTA	\N
142	54	10680	EL TORO	\N
142	54	10681	ENCRUCIJADA	\N
142	54	10682	ENCRUCIJADA DE TASTIL	\N
142	54	10683	GOBERNADOR MANUEL SOLA	\N
142	54	10684	GOBERNADOR SARAVIA	\N
142	54	10685	HUAICONDO	\N
142	54	10686	INCAHUASI	\N
142	54	10687	INGENIERO MAURY	\N
142	54	10688	LAS CAPILLAS	\N
142	54	10689	LAS CEBADAS	\N
142	54	10690	LAS CUEVAS	\N
142	54	10691	MESETA	\N
142	54	10692	MINA CAROLINA	\N
142	54	10693	PUERTA DE TASTIL	\N
142	54	10694	QUEBRADA DEL TORO	\N
142	54	10695	SAN BERNARDO DE LAS ZORRAS	\N
142	54	10696	SANTA ROSA DE TASTIL	\N
142	54	10697	TACUARA	\N
142	54	10698	VILLA SOLA	\N
142	54	10699	ANGELICA	\N
142	54	10700	LA MERCED DE ARRIBA	\N
142	54	10701	EL ROSAL	\N
142	54	10702	EL PUCARA	\N
142	54	10703	EL PALOMAR	\N
142	54	10704	PASCHA	\N
142	54	10705	EL ALFARCITO	\N
142	54	10706	CERRO NEGRO DE TIRAO	\N
142	54	10707	AMBLAYO	\N
142	54	10708	ANGASTACO	\N
142	54	10709	ANIMANA	\N
142	54	10710	BARRIAL	\N
142	54	10711	CORRALITO	\N
142	54	10712	LAS VIÑAS	\N
142	54	10713	LOS SAUCES	\N
142	54	10714	MONTE VIEJO	\N
142	54	10715	PAYOGASTILLA	\N
142	54	10716	PUCARA	\N
142	54	10717	SAN ANTONIO	\N
142	54	10718	SAN CARLOS	\N
142	54	10719	SAN FELIPE	\N
142	54	10720	SAN LUCAS	\N
142	54	10721	SANTA ROSA	\N
142	54	10722	SIMBOLAR	\N
142	54	10723	RIO GRANDE	\N
142	54	10724	LA CABAÑA	\N
142	54	10725	LA ANGOSTURA	\N
142	54	10726	ISONZA	\N
142	54	10727	EL ARREMO	\N
142	54	10728	LAS BARRANCAS	\N
142	54	10729	LOS TOLDOS	\N
142	54	10730	BACOYA	\N
142	54	10731	ACOYTE	\N
142	54	10732	BARITU	\N
142	54	10733	CUESTA AZUL	\N
142	54	10734	HORNILLOS	\N
142	54	10735	LA FALDA	\N
142	54	10736	LIZOITE	\N
142	54	10737	MECOYITA	\N
142	54	10738	MESON	\N
142	54	10739	NAZARENO	\N
142	54	10740	PAL TOLCO	\N
142	54	10741	PAPA CHACRA	\N
142	54	10742	PASCALLA	\N
142	54	10743	POSCAYA	\N
142	54	10744	PUCA VISCANA	\N
142	54	10745	PUCARA	\N
142	54	10746	PUNCO VICANA	\N
142	54	10747	RODEO PAMPA	\N
142	54	10748	SAN FELIPE	\N
142	54	10749	SAN FRANCISCO	\N
142	54	10750	SAN JUAN DE ORO	\N
142	54	10751	SAN LEON	\N
142	54	10752	SANTA CRUZ DE AGUILAR	\N
142	54	10753	SANTA VICTORIA OESTE	\N
142	54	10754	SOLEDAD	\N
142	54	10755	TRIGO HUAYCO	\N
142	54	10756	TUCTUCA	\N
142	54	10757	SAN PEDRO DE SAN ALBERTO	\N
142	54	10758	SAN MARCOS	\N
142	54	10759	PUCALLPA	\N
142	54	10760	LA MISION	\N
142	54	10761	ARAZAY	\N
142	54	10762	EL PABELLON	\N
142	54	10763	ABRA DE SANTA CRUZ	\N
142	54	10764	VIZCACHAÑI	\N
142	54	10765	LIPEO	\N
142	54	10766	CAMPO LA PAZ	\N
142	54	10767	EL CONDADO	\N
142	54	10768	SAN JOSE DE AGUILAR	\N
142	54	10769	SAN JUANCITO	\N
142	54	10770	CAMPO LA CRUZ	\N
142	54	10771	PALTOROA	\N
142	54	10772	PAPACHACRA	\N
142	54	10773	CAÑANI	\N
144	54	10774	LA TRANCA	\N
144	54	10775	EL PAYERO	\N
144	54	10776	EL POTRERO DE LEYES	\N
144	54	10777	LA MAJADA	\N
144	54	10778	LEANDRO N. ALEM	\N
144	54	10779	POTRERO DE LEYES	\N
144	54	10780	AGUA HEDIONDA	\N
144	54	10781	BALDE HONDO	\N
144	54	10782	BANDA SUD	\N
144	54	10783	CAMPANARIO	\N
144	54	10784	CONSULTA	\N
144	54	10785	LA PORFIA	\N
144	54	10786	POZO CAVADO	\N
144	54	10787	POZO DE LOS RAYOS	\N
144	54	10788	PUERTO RICO	\N
144	54	10789	PUESTO PAMPA INVERNADA	\N
144	54	10790	PUESTO QUEBRADA CAL	\N
144	54	10791	RAMADITA	\N
144	54	10792	RIO JUAN GOMEZ	\N
144	54	10793	RODEO CADENAS	\N
144	54	10794	SAN FRANCISCO DEL MONTE DE ORO	\N
144	54	10795	SOCOSCORA	\N
144	54	10796	TINTITACO	\N
144	54	10797	BALDE DE ARRIBA	\N
144	54	10798	BALDE DE AZCURRA	\N
144	54	10799	BALDE DE PUERTAS	\N
144	54	10800	BALDECITO LA PAMPA	\N
144	54	10801	BOTIJAS	\N
144	54	10802	CANTANTAL	\N
144	54	10803	CERRO BAYO	\N
144	54	10804	CHIMBORAZO	\N
144	54	10805	EL MOLLARCITO	\N
144	54	10806	LA SALVADORA	\N
144	54	10807	LAS MESIAS	\N
144	54	10808	LAS PAMPITAS	\N
144	54	10809	LOMAS BLANCAS	\N
144	54	10810	LOS ALMACIGOS	\N
144	54	10811	LOS MENDOCINOS	\N
144	54	10812	MONTE CARMELO	\N
144	54	10813	PASTAL	\N
144	54	10814	POZO DEL MOLLE	\N
144	54	10815	SAN RUFINO	\N
144	54	10816	SAN SALVADOR	\N
144	54	10817	TEMERARIA	\N
144	54	10818	VISTA ALEGRE	\N
144	54	10819	CEBOLLAR	\N
144	54	10820	CORRAL DE PIEDRA	\N
144	54	10821	EL MANANTIAL	\N
144	54	10822	EL MOLINO	\N
144	54	10823	LOS PEJES	\N
144	54	10824	LUJAN	\N
144	54	10825	SANTA RUFINA	\N
144	54	10826	SANTA TERESITA	\N
144	54	10827	BALDE RETAMO	\N
144	54	10828	BALDE VIEJO	\N
144	54	10829	EL INJERTO	\N
144	54	10830	EL POTRERILLO	\N
144	54	10831	EL RETAMO	\N
144	54	10832	EL ZAPALLAR	\N
144	54	10833	ENTRE RIOS	\N
144	54	10834	LAS PUERTAS	\N
144	54	10835	PIE DE LA CUESTA	\N
144	54	10836	PUESTO DE TABARES	\N
144	54	10837	PUESTO TALAR	\N
144	54	10838	QUINES	\N
144	54	10839	BALDE AHUMADA	\N
144	54	10840	BALDE DE GUARDIA	\N
144	54	10841	BALDE DE LA LINEA	\N
144	54	10842	BALDE DE QUINES	\N
144	54	10843	BALDE DE TORRES	\N
144	54	10844	BALDE EL CARRIL	\N
144	54	10845	CANDELARIA	\N
144	54	10846	EL CADILLO	\N
144	54	10847	EL HORMIGUERO	\N
144	54	10848	EL PUESTITO	\N
144	54	10849	EL SEMBRADO	\N
144	54	10850	LA MEDULA	\N
144	54	10851	LA MODERNA	\N
144	54	10852	LA PLATA	\N
144	54	10853	LA RESISTENCIA	\N
144	54	10854	LA SIRENA	\N
144	54	10855	LA TUSCA	\N
144	54	10856	LAS BAJADAS	\N
144	54	10857	LAS CHIMBAS	\N
144	54	10858	LAS PLAYAS ARGENTINAS	\N
144	54	10859	LOS ARCES	\N
144	54	10860	MEDANO BALLO	\N
144	54	10861	PATIO LIMPIO	\N
144	54	10862	PUESTO ROBERTO	\N
144	54	10863	QUEBRACHITO	\N
144	54	10864	SAN CELESTINO	\N
144	54	10865	ARBOL VERDE	\N
144	54	10866	BALDE DE ESCUDERO	\N
144	54	10867	BALDE DE GARCIA	\N
144	54	10868	BALDE DE LEDESMA	\N
144	54	10869	BALDE DE MONTE	\N
144	54	10870	LAS PALOMAS	\N
144	54	10871	EL PIMPOLLO	\N
144	54	10872	BARZOLA	\N
144	54	10873	MONTE VERDE	\N
144	54	10874	PUESTITO	\N
144	54	10875	ALTA GRACIA	\N
144	54	10876	ARBOL SOLO	\N
144	54	10877	EL BAGUAL	\N
144	54	10878	EL BALDE	\N
144	54	10879	EL SALTO	\N
144	54	10880	HIPOLITO YRIGOYEN	\N
144	54	10881	LA CORINA	\N
144	54	10882	LA DUDA	\N
144	54	10883	LA EULOGIA	\N
144	54	10884	LA GARZA	\N
144	54	10885	LA JULIA	\N
144	54	10886	LA QUEBRADA	\N
144	54	10887	LA SANDIA	\N
144	54	10888	LA SERRANA	\N
144	54	10889	LAS CARITAS	\N
144	54	10890	LONGARI	\N
144	54	10891	LOS RAMBLONES	\N
144	54	10892	NOGOLI	\N
144	54	10893	PALIGUANTA	\N
144	54	10894	POZO DEL ESPINILLO	\N
144	54	10895	RUMIGUASI	\N
144	54	10896	TAZA BLANCA	\N
144	54	10897	TORO NEGRO	\N
144	54	10898	VILLA GRAL. ROCA	\N
144	54	10899	POZO DEL TALA	\N
144	54	10900	AGUA AMARGA	\N
144	54	10901	ALAZANAS	\N
144	54	10902	ALGARROBOS GRANDES	\N
144	54	10903	ALTILLO	\N
144	54	10904	BAJO DE LA CRUZ	\N
144	54	10905	BELLA ESTANCIA	\N
144	54	10906	EL GIGANTE	\N
144	54	10907	EL JARILLAL	\N
144	54	10908	EL PEDERNAL	\N
144	54	10909	EL RAMBLON	\N
144	54	10910	ESTANCIA SAN ROQUE	\N
144	54	10911	HUALTARAN	\N
144	54	10912	LA CALERA	\N
144	54	10913	LA EMPAJADA	\N
144	54	10914	LA YESERA	\N
144	54	10915	LAS GALERAS	\N
144	54	10916	LOS AGUADOS	\N
144	54	10917	LOS ARADITOS	\N
144	54	10918	LOS CERRITOS	\N
144	54	10919	LOS CHANCAROS	\N
144	54	10920	LOS TELARIOS	\N
144	54	10921	PUNTA DE LA SIERRA	\N
144	54	10922	RECREO	\N
144	54	10923	REPRESA DEL CARMEN	\N
144	54	10924	ROMANCE	\N
144	54	10925	SANTA ROSA DEL GIGANTE	\N
144	54	10926	TRES LOMAS	\N
144	54	10927	TRES PUERTAS	\N
144	54	10928	LA ESTANCIA	\N
144	54	10929	ELEODORO LOBOS	\N
144	54	10930	ANTIHUASI	\N
144	54	10931	ARENILLA	\N
144	54	10932	BALDE DE LA ISLA	\N
144	54	10933	BUENA VENTURA	\N
144	54	10934	BUENA VISTA	\N
144	54	10935	CAROLINA	\N
144	54	10936	CERRO DE PIEDRA	\N
144	54	10937	CERROS LARGOS	\N
144	54	10938	CHIPICAL	\N
144	54	10939	CRUZ DE PIEDRA	\N
144	54	10940	DURAZNO	\N
144	54	10941	EL AMPARO	\N
144	54	10942	EL ARENAL	\N
144	54	10943	EMBALSE LA FLORIDA	\N
144	54	10944	ESTANCIA GRANDE	\N
144	54	10945	HINOJITO	\N
144	54	10946	LA ALIANZA	\N
144	54	10947	LA BAJADA	\N
144	54	10948	LA CALAGUALA	\N
144	54	10949	LA FLORIDA	\N
144	54	10950	LA HIGUERITA	\N
144	54	10951	LAGUNA BRAVA	\N
144	54	10952	LOS ARROYOS	\N
144	54	10953	LOS CARRICITOS	\N
144	54	10954	LOS MONTES	\N
144	54	10955	LOS PASITOS	\N
144	54	10956	LOS TAPIALES	\N
144	54	10957	MARAY	\N
144	54	10958	MARMOL VERDE	\N
144	54	10959	MINA SANTO DOMINGO	\N
144	54	10960	MONTE CHIQUITO	\N
144	54	10961	ONCE DE MAYO	\N
144	54	10962	PAMPA DEL TAMBORERO	\N
144	54	10963	PANCANTA	\N
144	54	10964	PASO DE CUERO	\N
144	54	10965	PASO DEL REY	\N
144	54	10966	PASO JUAN GOMEZ	\N
144	54	10967	QUEBRADA DE LA BURRA	\N
144	54	10968	RIO GRANDE	\N
144	54	10969	SAUCESITO	\N
144	54	10970	SOLOBASTA	\N
144	54	10971	TRAPICHE	\N
144	54	10972	VIRARCO	\N
144	54	10973	CHALANTA	\N
144	54	10974	VISTA HERMOSA	\N
144	54	10975	COMANDANTE GRANVILLE	\N
144	54	10976	FRAGA	\N
144	54	10977	LA CAUTIVA	\N
144	54	10978	PASO DE LAS CARRETAS	\N
144	54	10979	SAN IGNACIO	\N
144	54	10980	CALDENADAS	\N
144	54	10981	CANTERAS SANTA ISABEL	\N
144	54	10982	CASAS VIEJAS	\N
144	54	10983	CERRO DE LA PILA	\N
144	54	10984	CERRO VERDE	\N
144	54	10985	EL BLANCO	\N
144	54	10986	EL POZO	\N
144	54	10987	ESTABLECIMIENTO LAS FLORES	\N
144	54	10988	LA FRAGUA	\N
144	54	10989	LA JUSTA	\N
144	54	10990	LA RINCONADA	\N
144	54	10991	LA TOMA	\N
144	54	10992	LAS DELICIAS	\N
144	54	10993	LAS ROSAS	\N
144	54	10994	QUEBRADA HONDA	\N
144	54	10995	YACORO	\N
144	54	10996	AGUA SALADA	\N
144	54	10997	LA ARBOLEDA	\N
144	54	10998	LA PETRA	\N
144	54	10999	LOS MEDANITOS	\N
144	54	11000	MANANTIAL GRANDE	\N
144	54	11001	SALADILLO	\N
144	54	11002	SAN GREGORIO	\N
144	54	11003	SAN LORENZO	\N
144	54	11004	LAS HIGUERAS	\N
144	54	11005	BARRANQUITAS	\N
144	54	11006	TOTORILLA	\N
144	54	11007	EL VALLECITO	\N
144	54	11008	GUZMAN	\N
144	54	11009	QUEBRACHOS	\N
144	54	11010	LOS SAUCES	\N
144	54	11011	CALERA ARGENTINA	\N
144	54	11012	HUCHISSON	\N
144	54	11013	LA SUIZA	\N
144	54	11014	LAS CANTERAS	\N
144	54	11015	LOS CORRALITOS	\N
144	54	11016	LOS MOLLECITOS	\N
144	54	11017	MANANTIAL DE RENCA	\N
144	54	11018	NASCHEL	\N
144	54	11019	PIEDRAS CHATAS	\N
144	54	11020	RETAZO DEL MONTE	\N
144	54	11021	SAN FELIPE	\N
144	54	11022	CHACRAS VIEJAS	\N
144	54	11023	CONCARAN	\N
144	54	11024	EL ARROYO	\N
144	54	11025	EL CAVADO	\N
144	54	11026	LA GRAMILLA	\N
144	54	11027	LAS NIEVES	\N
144	54	11028	LOS COMEDORES	\N
144	54	11029	LOS PUESTOS	\N
144	54	11030	LOS QUEBRACHOS	\N
144	54	11031	MINA LOS CONDORES	\N
144	54	11032	SANTA MARTINA	\N
144	54	11033	SANTA SIMONA	\N
144	54	11034	VILLA DOLORES	\N
144	54	11035	LA CRISTINA	\N
144	54	11036	LA ESTANZUELA	\N
144	54	11037	LA RIOJITA	\N
144	54	11038	LOS CONDORES	\N
144	54	11039	LOS MANANTIALES	\N
144	54	11040	OTRA BANDA	\N
144	54	11041	PASO DE LOS ALGARROBOS	\N
144	54	11042	PUENTE HIERRO	\N
144	54	11043	PUNTA DE LA LOMA	\N
144	54	11044	PUNTA DEL ALTO	\N
144	54	11045	SAN PABLO	\N
144	54	11046	TILISARAO	\N
144	54	11047	MANANTIAL DE FLORES	\N
144	54	11048	CORRAL DE TORRES	\N
144	54	11049	TOIGUS	\N
144	54	11050	DOMINGUEZ	\N
144	54	11051	LA ARGENTINA	\N
144	54	11052	LOS CUADROS	\N
144	54	11053	PIQUILLINES	\N
144	54	11054	USPARA	\N
144	54	11055	VILLA DEL CARMEN	\N
144	54	11056	VOLCAN ESTANZUELA	\N
144	54	11057	ALTO LINDO	\N
144	54	11058	BALCARCE	\N
144	54	11059	CORTADERAS	\N
144	54	11060	LOS ESPINILLOS	\N
144	54	11061	PAPAGAYOS	\N
144	54	11062	VILLA ELENA	\N
144	54	11063	VILLA LARCA	\N
144	54	11064	EL DIVISADERO	\N
144	54	11065	SAN FRANCISCO	\N
144	54	11066	EL RIO	\N
144	54	11067	LA EMILIA	\N
144	54	11068	TRAVESIA	\N
144	54	11069	CIUDAD JARDIN DE SAN LUIS	\N
144	54	11070	CORONEL ALZOGARAY	\N
144	54	11071	EL DIQUE	\N
144	54	11072	EL FORTIN	\N
144	54	11073	LA NEGRA	\N
144	54	11074	LAS PALMAS	\N
144	54	11075	LAVAISSE	\N
144	54	11076	LIBORIO LUNA	\N
144	54	11077	MARLITO	\N
144	54	11078	VILLA MERCEDES	\N
144	54	11079	NUEVA ESCOCIA	\N
144	54	11080	PEDERNERA	\N
144	54	11081	ALFALAND	\N
144	54	11082	EL MORRO	\N
144	54	11083	EL PASAJERO	\N
144	54	11084	EL PLATEADO	\N
144	54	11085	EL SARCO	\N
144	54	11086	JUAN JORBA	\N
144	54	11087	LA ANGELINA	\N
144	54	11088	LA BERTITA	\N
144	54	11089	LA GAMA	\N
144	54	11090	LA IBERIA	\N
144	54	11091	LA JAVIERA	\N
144	54	11092	LA NEGRITA	\N
144	54	11093	LA PORTADA	\N
144	54	11094	LAS CAROLINAS	\N
144	54	11095	LAS PRADERAS	\N
144	54	11096	LAS VIZCACHERAS	\N
144	54	11097	LOS CISNES	\N
144	54	11098	SAN JUAN DE TASTU	\N
144	54	11099	SOVEN	\N
144	54	11100	TASTO	\N
144	54	11101	CRAMER	\N
144	54	11102	VILLA REYNOLDS	\N
144	54	11103	COLONIA BELLA VISTA	\N
144	54	11104	ISONDU	\N
144	54	11105	JUAN LLERENA	\N
144	54	11106	LA VENECIA	\N
144	54	11107	AVANZADA	\N
144	54	11108	COLONIA LUNA	\N
144	54	11109	EL NASAO	\N
144	54	11110	GENERAL PEDERNERA	\N
144	54	11111	JUSTO DARACT	\N
144	54	11112	LA CARMEN	\N
144	54	11113	LA ELIDA	\N
144	54	11114	LA GARRAPATA	\N
144	54	11115	LA MAGDALENA	\N
144	54	11116	LA TULA	\N
144	54	11117	LAS ENCADENADAS	\N
144	54	11118	LAS MELADAS	\N
144	54	11119	LAS TOTORITAS	\N
144	54	11120	LOS CESARES	\N
144	54	11121	LOS ESQUINEROS	\N
144	54	11122	LOS MEDANOS	\N
144	54	11123	LOS POZOS	\N
144	54	11124	RIO QUINTO	\N
144	54	11125	SANTA CATALINA	\N
144	54	11126	ALTO VERDE	\N
144	54	11127	AVIADOR ORIGONE	\N
144	54	11128	GUANACO	\N
144	54	11129	LA GUARDIA	\N
144	54	11130	9 DE JULIO	\N
144	54	11131	AGUA FRIA	\N
144	54	11132	BOCA DEL RIO	\N
144	54	11133	CHANCARITA	\N
144	54	11134	LA HERMOSURA	\N
144	54	11135	LA ROSADA	\N
144	54	11136	NO ES MIA	\N
144	54	11137	PRIMER AGUA	\N
144	54	11138	PUNILLA	\N
144	54	11139	REAL	\N
144	54	11140	SAN ALBERTO	\N
144	54	11141	SAN ALEJANDRO	\N
144	54	11142	SAN NICOLAS PUNILLA	\N
144	54	11143	SANTA FELISA	\N
144	54	11144	CENTENARIO	\N
144	54	11145	CASIMIRO GOMEZ	\N
144	54	11146	BAGUAL	\N
144	54	11147	BAJADA NUEVA	\N
144	54	11148	BILLIKEN	\N
144	54	11149	COCHEQUINGAN	\N
144	54	11150	COLONIA EL CAMPAMENTO	\N
144	54	11151	COLONIA LA FLORIDA	\N
144	54	11152	COLONIA URDANIZ	\N
144	54	11153	EL CAMPAMENTO	\N
144	54	11154	EL CINCO	\N
144	54	11155	EL MARTILLO	\N
144	54	11156	EL TORO MUERTO	\N
144	54	11157	FORTUNA	\N
144	54	11158	LA CALDERA	\N
144	54	11159	LA CHERINDU	\N
144	54	11160	LA DONOSTIA	\N
144	54	11161	LA ELENITA	\N
144	54	11162	LA EMMA	\N
144	54	11163	LA ERNESTINA	\N
144	54	11164	LA GAVIOTA	\N
144	54	11165	LA GITANA	\N
144	54	11166	LA HOLANDA	\N
144	54	11167	LA LINDA	\N
144	54	11168	LA MARAVILLA	\N
144	54	11169	LA MARGARITA	\N
144	54	11170	LA MARGARITA CARLOTA	\N
144	54	11171	LA MAROMA	\N
144	54	11172	LA MEDIA LEGUA	\N
144	54	11173	LA MELINA	\N
144	54	11174	LA TIGRA	\N
144	54	11175	LA URUGUAYA	\N
144	54	11176	LAS CORTADERAS	\N
144	54	11177	LAS GITANAS	\N
144	54	11178	LAS MARTINETAS	\N
144	54	11179	LOS BARRIALES	\N
144	54	11180	LOS DOS RIOS	\N
144	54	11181	LOS DURAZNOS	\N
144	54	11182	MARTIN DE LOYOLA	\N
144	54	11183	MONTE COCHEQUINGAN	\N
144	54	11184	NUEVA GALIA	\N
144	54	11185	PASO DE LOS GAUCHOS	\N
144	54	11186	POLLEDO	\N
144	54	11187	RANQUELCO	\N
144	54	11188	ROSALES	\N
144	54	11189	TOINGUA	\N
144	54	11190	UNION	\N
144	54	11191	URDANIZ	\N
144	54	11192	LA COLINA	\N
144	54	11193	BUENA ESPERANZA	\N
144	54	11194	COCHENELOS	\N
144	54	11195	EL OASIS	\N
144	54	11196	EL QUINGUAL	\N
144	54	11197	LA ESMERALDA	\N
144	54	11198	LA ETHEL	\N
144	54	11199	LA MARIA LUISA	\N
144	54	11200	LA ROSINA	\N
144	54	11201	LA SEGUNDA	\N
144	54	11202	LAS AROMAS	\N
144	54	11203	LAS MESTIZAS	\N
144	54	11204	LOS OSCUROS	\N
144	54	11205	MACHAO	\N
144	54	11206	NILINAST	\N
144	54	11207	PLACILLA	\N
144	54	11208	BATAVIA	\N
144	54	11209	COLONIA CALZADA	\N
144	54	11210	CORONEL SEGOVIA	\N
144	54	11211	EL AGUILA	\N
144	54	11212	EL PICHE	\N
144	54	11213	ESTANCIA 30 DE OCTUBRE	\N
144	54	11214	ESTANCIA DON ARTURO	\N
144	54	11215	FORTIN EL PATRIA	\N
144	54	11216	GLORIA A DIOS	\N
144	54	11217	LA AMALIA	\N
144	54	11218	LA AROMA	\N
144	54	11219	LA BAVARIA	\N
144	54	11220	LA BOLIVIA	\N
144	54	11221	LA CORA	\N
144	54	11222	LA FELISA	\N
144	54	11223	LA GERMANIA	\N
144	54	11224	LA HORTENSIA	\N
144	54	11225	LA JUANA	\N
144	54	11226	LA LAURA	\N
144	54	11227	LA LUISA	\N
144	54	11228	LA MARIA ESTHER	\N
144	54	11229	LA NUTRIA	\N
144	54	11230	LA REINA	\N
144	54	11231	LA ROSALIA	\N
144	54	11232	LAURA ELISA	\N
144	54	11233	LOS HUAYCOS	\N
144	54	11234	LOS VALLES	\N
144	54	11235	NAHUEL MAPA	\N
144	54	11236	NAVIA	\N
144	54	11237	NUEVA ESPERANZA	\N
144	54	11238	PENICE	\N
144	54	11239	SANTA CECILIA	\N
144	54	11240	TORO BAYO	\N
144	54	11241	UCHAIMA	\N
144	54	11242	VALLE HERMOSO	\N
144	54	11243	VIVA LA PATRIA	\N
144	54	11244	ALEGRIA	\N
144	54	11245	ANCHORENA	\N
144	54	11246	ARIZONA	\N
144	54	11247	LA TRAVESIA	\N
144	54	11248	LA VACA	\N
144	54	11249	SAN CARLOS	\N
144	54	11250	ANGELITA	\N
144	54	11251	BAÑADO DE CAUTANA	\N
144	54	11252	LA UNION	\N
144	54	11253	NARANJO	\N
144	54	11254	PASO DEL MEDIO	\N
144	54	11255	PUNTOS DE LA LINEA	\N
144	54	11256	QUEBRADA DEL TIGRE	\N
144	54	11257	TALITA	\N
144	54	11258	EL BARRIAL	\N
144	54	11259	EL POCITO	\N
144	54	11260	EL TEMBLEQUE	\N
144	54	11261	LAS CABRAS	\N
144	54	11262	LAS ISLITAS	\N
144	54	11263	LAS ROSADAS	\N
144	54	11264	LOS ALGARROBITOS	\N
144	54	11265	POCITOS	\N
144	54	11266	POZO DEL MEDIO	\N
144	54	11267	SANTA LUCINDA	\N
144	54	11268	EL ROSARIO	\N
144	54	11269	ADOLFO RODRIGUEZ SAA	\N
144	54	11270	CERRITO BLANCO	\N
144	54	11271	CHILCAS	\N
144	54	11272	EL PUEBLITO	\N
144	54	11273	LAS TIGRAS	\N
144	54	11274	LOS ARGUELLOS	\N
144	54	11275	LOS PEROS	\N
144	54	11276	LOS ROLDANES	\N
144	54	11277	LOS TIGRES	\N
144	54	11278	OJO DEL RIO	\N
144	54	11279	PASO DE LA CRUZ	\N
144	54	11280	PICOS YACU	\N
144	54	11281	PIZARRAS BAJO VELEZ	\N
144	54	11282	POZO DE LAS RAICES	\N
144	54	11283	SANTA ROSA DEL CONLARA	\N
144	54	11284	LA AGUADA DE LAS ANIMAS	\N
144	54	11285	LA ALEGRIA	\N
144	54	11286	LA FINCA	\N
144	54	11287	LAFINUR	\N
144	54	11288	LOMITAS	\N
144	54	11289	LOS CAJONES	\N
144	54	11290	VILLA LUISA	\N
144	54	11291	LA ANGOSTURA	\N
144	54	11292	PASO DE LAS SIERRAS	\N
144	54	11293	PUNTA DE AGUA	\N
144	54	11294	CERRO DE ORO	\N
144	54	11295	MERLO	\N
144	54	11296	PIEDRA BLANCA	\N
144	54	11297	RINCON DEL ESTE	\N
144	54	11298	CARPINTERIA	\N
144	54	11299	LOS MOLLES	\N
144	54	11300	ALTO BLANCO	\N
144	54	11301	ALTO DEL LEON	\N
144	54	11302	LA CORTADERA	\N
144	54	11303	LA ESPESURA	\N
144	54	11304	PESCADORES	\N
144	54	11305	POZO ESCONDIDO	\N
144	54	11306	SAN GERONIMO	\N
144	54	11307	SAN LUIS	\N
144	54	11308	DANIEL DONOVAN	\N
144	54	11309	EL CHORRILLO	\N
144	54	11310	EL RIECITO	\N
144	54	11311	LAS CHACRAS DE SAN MARTIN	\N
144	54	11312	LOS PUQUIOS	\N
144	54	11313	POTRERO DE LOS FUNES	\N
144	54	11314	SAN ROQUE	\N
144	54	11315	TUKIROS	\N
144	54	11316	VOLCAN	\N
144	54	11317	BARRANCA COLORADA	\N
144	54	11318	EL MILAGRO	\N
144	54	11319	POZO DEL CARRIL	\N
144	54	11320	SAN RAIMUNDO	\N
144	54	11321	CHARLONE	\N
144	54	11322	LAS BARRANCAS	\N
144	54	11323	SANTA ROSA	\N
144	54	11324	AGUA SEBALLE	\N
144	54	11325	ALTO DEL VALLE	\N
144	54	11326	ALTO PELADO	\N
144	54	11327	BEAZLEY	\N
144	54	11328	CAZADOR	\N
144	54	11329	CERRO VARELA	\N
144	54	11330	CERRO VIEJO	\N
144	54	11331	CHISCHAQUITA	\N
144	54	11332	EL CAZADOR	\N
144	54	11333	ESTACION ZANJITAS	\N
144	54	11334	GORGONTA	\N
144	54	11335	HUEJEDA	\N
144	54	11336	LA BONITA	\N
144	54	11337	LA IRENE	\N
144	54	11338	LA PEREGRINA	\N
144	54	11339	LA REPRESA	\N
144	54	11340	LA TOSCA	\N
144	54	11341	LAS COLONIAS	\N
144	54	11342	LAS GAMAS	\N
144	54	11343	MOSMOTA	\N
144	54	11344	PAJE	\N
144	54	11345	PASO ANCHO	\N
144	54	11346	PASO DE LAS SALINAS	\N
144	54	11347	PASO DE LAS TOSCAS	\N
144	54	11348	PASO DE LAS VACAS	\N
144	54	11349	PASO DE LOS BAYOS	\N
144	54	11350	POZO CERCADO	\N
144	54	11351	PUESTO DE LOS JUMES	\N
144	54	11352	PUNTA DEL CERRO	\N
144	54	11353	SALITRAL	\N
144	54	11354	SALTO CHICO	\N
144	54	11355	SAN MARTIN (ESTACION ZANJITAS)	\N
144	54	11356	VARELA	\N
144	54	11357	ZANJITAS	\N
144	54	11358	ALTO PENCOSO	\N
144	54	11359	BALDE	\N
144	54	11360	CHOSMES	\N
144	54	11361	EL CHARCO	\N
144	54	11362	EL LECHUZO	\N
144	54	11363	EL MATACO	\N
144	54	11364	GUASQUITA	\N
144	54	11365	JARILLA	\N
144	54	11366	LA CABRA	\N
144	54	11367	LA SELVA	\N
144	54	11368	LAGUNA SECA	\N
144	54	11369	LOS JAGUELES	\N
144	54	11370	MANTILLA	\N
144	54	11371	NEGRO MUERTO	\N
144	54	11372	PASO LOS ALGARROBOS	\N
144	54	11373	SALINAS DEL BEBEDERO	\N
144	54	11374	SANTA RITA	\N
144	54	11375	CERRO COLORADO	\N
144	54	11376	LAS TOSCAS	\N
144	54	11377	JUANA KOSLAY	\N
144	54	11378	LA PUNTA	\N
144	54	11379	LA CIENAGA	\N
144	54	11380	LA VERTIENTE	\N
144	54	11381	CASA DE PIEDRA	\N
144	54	11382	EL VALLE	\N
144	54	11383	LA HUERTA	\N
144	54	11384	LA RAMADA	\N
144	54	11385	LA TOTORA	\N
144	54	11386	LAS CHACRAS	\N
144	54	11387	LOS COMEDEROS	\N
144	54	11388	POTRERILLO	\N
144	54	11389	SAN RAFAEL	\N
144	54	11390	VILLA DE PRAGA	\N
144	54	11391	MANANTIAL	\N
144	54	11392	PIEDRAS ANCHAS	\N
144	54	11393	QUEBRADA SAN VICENTE	\N
144	54	11394	SAN ANTONIO	\N
144	54	11395	SAN MARTIN	\N
144	54	11396	CABEZA DEL NOVILLO	\N
144	54	11397	LAS AGUADAS	\N
144	54	11398	PUERTA COLORADA	\N
144	54	11399	RINCON DEL CARMEN	\N
144	54	11400	SAN ISIDRO	\N
144	54	11401	TALA VERDE	\N
144	54	11402	LA COCHA	\N
144	54	11403	LAS LAGUNAS	\N
145	54	11404	EL GUADAL	\N
145	54	11405	PUERTO SANTA CRUZ	\N
145	54	11406	CHONQUE	\N
145	54	11407	COMANDANTE LUIS PIEDRABUENA	\N
145	54	11408	EL BAILE	\N
145	54	11409	EL PAN DE AZUCAR	\N
145	54	11410	EL PASO	\N
145	54	11411	GARMINUE	\N
145	54	11412	LA BARRETA	\N
145	54	11413	LA JULIA	\N
145	54	11414	LA PIGMEA	\N
145	54	11415	LAGUNA GRANDE	\N
145	54	11416	LAS MERCEDES	\N
145	54	11417	PASO DE LOS INDIOS	\N
145	54	11418	PASO DEL RIO SANTA CRUZ	\N
145	54	11419	RIO CHICO	\N
145	54	11420	SIERRA DE LA VENTANA	\N
145	54	11421	TAUEL AIKE	\N
145	54	11422	CALETA OLIVIA	\N
145	54	11423	CAÑADON SECO	\N
145	54	11424	ALMA GRANDE	\N
145	54	11425	JELAINA	\N
145	54	11426	LA ANTONIA	\N
145	54	11427	LA GUARDIA	\N
145	54	11428	LA ROSA	\N
145	54	11429	PICO TRUNCADO	\N
145	54	11430	CAMERON	\N
145	54	11431	CERRO LA SETENTA	\N
145	54	11432	CERRO RENZEL	\N
145	54	11433	COLONIA CARLOS PELLEGRINI	\N
145	54	11434	INDIA MUERTA	\N
145	54	11435	LA ARGENTINA	\N
145	54	11436	LAS HERAS	\N
145	54	11437	LAS MASITAS	\N
145	54	11438	MATA MAGALLANES	\N
145	54	11439	PAMPA VERDUM	\N
145	54	11440	PELLEGRINI	\N
145	54	11441	PIRAMIDES	\N
145	54	11442	YEGUA MUERTA	\N
145	54	11443	AGUADA ESCONDIDA	\N
145	54	11444	MONTE VERDE	\N
145	54	11445	GOBERNADOR MOYANO	\N
145	54	11446	PUERTO DESEADO	\N
145	54	11447	TELLIER	\N
145	54	11448	TRES CERROS	\N
145	54	11449	CABO BLANCO	\N
145	54	11450	CABO TRES PUNTAS	\N
145	54	11451	EL HUECO	\N
145	54	11452	EL LORO	\N
145	54	11453	EL POLVORIN	\N
145	54	11454	LA CENTRAL	\N
145	54	11455	LA FECUNDIDAD	\N
145	54	11456	LA MADRUGADA	\N
145	54	11457	LA MARGARITA	\N
145	54	11458	LA PROTEGIDA	\N
145	54	11459	LA ROSADA	\N
145	54	11460	LA VIOLETA	\N
145	54	11461	MAZAREDO	\N
145	54	11462	AGUADA GRANDE	\N
145	54	11463	DESAMPARADOS	\N
145	54	11464	EL BARBUCHO	\N
145	54	11465	FLORADORA	\N
145	54	11466	JARAMILLO	\N
145	54	11467	AGUADA ALEGRE	\N
145	54	11468	BAHIA LAURA	\N
145	54	11469	CARA MALA	\N
145	54	11470	FARO CABO GUARDIAN	\N
145	54	11471	FARO CAMPANA	\N
145	54	11472	PUNTA MERCEDES	\N
145	54	11473	RIO GALLEGOS	\N
145	54	11474	FUENTES DEL COYLE	\N
145	54	11475	LA ESPERANZA	\N
145	54	11476	JULIA DUFOUR (CAMPAMENTO DOROTEA)	\N
145	54	11477	MINA 3	\N
145	54	11478	RIO TURBIO	\N
145	54	11479	28 DE NOVIEMBRE	\N
145	54	11480	ROSPENTEK	\N
145	54	11481	GUARDAPARQUE FITZ ROY	\N
145	54	11482	LA FEDERICA	\N
145	54	11483	LA FLORIDA	\N
145	54	11484	LAGO SAN MARTIN	\N
145	54	11485	LAGO TAR	\N
145	54	11486	PASO RIO LA LEONA	\N
145	54	11487	PENINSULA MAIPU	\N
145	54	11488	PUNTA DEL LAGO VIEDMA	\N
145	54	11489	TRES LAGOS	\N
145	54	11490	LA LEONA	\N
145	54	11491	CONDOR	\N
145	54	11492	FORTALEZA	\N
145	54	11493	BAHIA TRANQUILA	\N
145	54	11494	CALAFATE	\N
145	54	11495	LAGO ARGENTINO	\N
145	54	11496	LAGO ROCA	\N
145	54	11497	PUNTA BANDERA	\N
145	54	11498	RIO BOTE	\N
145	54	11499	VENTISQUERO MORENO	\N
145	54	11500	El Chalten	\N
145	54	11501	LA MARIA	\N
145	54	11502	EL PORTEZUELO	\N
145	54	11503	INGENIERO PALLAVICINI	\N
145	54	11504	LA ASTURIANA	\N
145	54	11505	MONTE CEBALLOS	\N
145	54	11506	NACIMIENTOS DEL PLUMA	\N
145	54	11507	PERITO MORENO	\N
145	54	11508	PORTEZUELO	\N
145	54	11509	RIO FENIX	\N
145	54	11510	LOS ANTIGUOS	\N
145	54	11511	LA MANCHURIA	\N
145	54	11512	BAJO FUEGO	\N
145	54	11513	PUERTO SAN JULIAN	\N
145	54	11514	EL SALADO	\N
145	54	11515	LOS MANANTIALES	\N
145	54	11516	BELLA VISTA	\N
145	54	11517	PASO GREGORES	\N
145	54	11518	LAGO CARDIEL	\N
145	54	11519	LAGO PUEYRREDON	\N
145	54	11520	GOBERNADOR GREGORES	\N
145	54	11521	LA PENINSULA	\N
145	54	11522	LAGO STROBEL	\N
145	54	11523	PASO DEL AGUILA	\N
145	54	11524	TUCU TUCU	\N
145	54	11525	BAJO CARACOLES	\N
145	54	11526	LAGO POSADAS	\N
145	54	11527	PASO ROBALLO	\N
145	54	11528	TAMEL AIKE	\N
146	54	11529	CAMPO LA RIVIERE	\N
146	54	11530	CAMPO SANTA ISABEL	\N
146	54	11531	LAS PAREJAS	\N
146	54	11532	ARMSTRONG	\N
146	54	11533	CAMPO GIMBATTI	\N
146	54	11534	CAMPO LA AMISTAD	\N
146	54	11535	CAMPO CHARO	\N
146	54	11536	CAMPO LA PAZ	\N
146	54	11537	SAN GUILLERMO	\N
146	54	11538	TORTUGAS	\N
146	54	11539	LA CALIFORNIA	\N
146	54	11540	LAS ROSAS	\N
146	54	11541	MONTES DE OCA	\N
146	54	11542	BOUQUET	\N
146	54	11543	CANDELARIA SUD	\N
146	54	11544	CASILDA	\N
146	54	11545	COLONIA CANDELARIA	\N
146	54	11546	COLONIA LA COSTA	\N
146	54	11547	CAMPO PESOA	\N
146	54	11548	CHABAS	\N
146	54	11549	LA MERCED	\N
146	54	11550	SANFORD	\N
146	54	11551	VILLADA	\N
146	54	11552	BIGAND	\N
146	54	11553	LOS MOLINOS	\N
146	54	11554	AREQUITO	\N
146	54	11555	LA VIUDA	\N
146	54	11556	LOS NOGALES	\N
146	54	11557	CAMPO CRENNA	\N
146	54	11558	SAN JOSE DE LA ESQUINA	\N
146	54	11559	ARTEAGA	\N
146	54	11560	COLONIA LAGO DI COMO	\N
146	54	11561	PIAMONTE	\N
146	54	11562	COLONIA HANSEN	\N
146	54	11563	LOS QUIRQUINCHOS	\N
146	54	11564	BERABEVU	\N
146	54	11565	CAMPO NUEVO	\N
146	54	11566	COLONIA FERNANDEZ	\N
146	54	11567	COLONIA GOMEZ	\N
146	54	11568	COLONIA PIAMONTESA	\N
146	54	11569	COLONIA SANTA NATALIA	\N
146	54	11570	COLONIA VALENCIA	\N
146	54	11571	CUATRO ESQUINAS	\N
146	54	11572	GODEKEN	\N
146	54	11573	SANTA NATALIA	\N
146	54	11574	CHAÑAR LADEADO	\N
146	54	11575	COLONIA BELLA ITALIA	\N
146	54	11576	RAFAELA	\N
146	54	11577	CAPILLA SAN JOSE	\N
146	54	11578	COLONIA CASTELLANOS	\N
146	54	11579	COLONIA FIDELA	\N
146	54	11580	COLONIA SAN ANTONIO	\N
146	54	11581	CORONEL FRAGA	\N
146	54	11582	EGUSQUIZA	\N
146	54	11583	PRESIDENTE ROCA	\N
146	54	11584	PUEBLO MARINI	\N
146	54	11585	PUEBLO RAMONA	\N
146	54	11586	PUEBLO SAN ANTONIO	\N
146	54	11587	SAGUIER	\N
146	54	11588	SUSANA	\N
146	54	11589	VILA	\N
146	54	11590	VILLA SAN JOSE	\N
146	54	11591	ANGELICA	\N
146	54	11592	LEHMANN	\N
146	54	11593	ATALIVA	\N
146	54	11594	GALISTEO	\N
146	54	11595	HUMBERTO I	\N
146	54	11596	REINA MARGARITA	\N
146	54	11597	SAN MIGUEL	\N
146	54	11598	COLONIA MAUA	\N
146	54	11599	VIRGINIA	\N
146	54	11600	ESTACION SAGUIER	\N
146	54	11601	CASABLANCA	\N
146	54	11602	COLONIA ALDAO	\N
146	54	11603	COLONIA BICHA	\N
146	54	11604	COLONIA BIGAND	\N
146	54	11605	EUSEBIA	\N
146	54	11606	HUGENTOBLER	\N
146	54	11607	RINCON DE TACURALES	\N
146	54	11608	AURELIA	\N
146	54	11609	AURELIA NORTE	\N
146	54	11610	AURELIA SUD	\N
146	54	11611	RAQUEL	\N
146	54	11612	SUNCHALES	\N
146	54	11613	COLONIA TACURALES	\N
146	54	11614	TACURAL	\N
146	54	11615	VILLANI	\N
146	54	11616	BAUER Y SIGEL	\N
146	54	11617	COLONIA JOSEFINA	\N
146	54	11618	ESTACION JOSEFINA	\N
146	54	11619	JOSE MANUEL ESTRADA	\N
146	54	11620	COLONIA CELLO	\N
146	54	11621	SANTA CLARA DE SAGUIER	\N
146	54	11622	CAMPO CLUCELLAS	\N
146	54	11623	CAMPO ROMERO	\N
146	54	11624	CAMPO ZURBRIGGEN	\N
146	54	11625	CLUCELLAS	\N
146	54	11626	ESTACION CLUCELLAS	\N
146	54	11627	EUSTOLIA	\N
146	54	11628	ESTRADA	\N
146	54	11629	ZENON PEREYRA	\N
146	54	11630	DESVIO BOERO	\N
146	54	11631	FRONTERA	\N
146	54	11632	COLONIA MARGARITA	\N
146	54	11633	GARIBALDI	\N
146	54	11634	CRISTOLIA	\N
146	54	11635	ESTACION MARIA JUANA	\N
146	54	11636	MANGORE	\N
146	54	11637	MARIA JUANA	\N
146	54	11638	LOS SEMBRADOS	\N
146	54	11639	SAN VICENTE	\N
146	54	11640	ESMERALDA	\N
146	54	11641	CAMPO LEHMANN	\N
146	54	11642	JUAN B. MOLINA	\N
146	54	11643	STEPHENSON	\N
146	54	11644	CAÑADA RICA	\N
146	54	11645	CEPEDA	\N
146	54	11646	LA VANGUARDIA	\N
146	54	11647	LOS MUCHACHOS	\N
146	54	11648	SARGENTO CABRAL	\N
146	54	11649	CAMPO RUEDA	\N
146	54	11650	PAVON ARRIBA	\N
146	54	11651	FRANCISCO PAZ	\N
146	54	11652	SANTA TERESA	\N
146	54	11653	PEYRANO	\N
146	54	11654	COLONIA VALDEZ	\N
146	54	11655	LA CELIA	\N
146	54	11656	LA OTHILA	\N
146	54	11657	MAXIMO PAZ	\N
146	54	11658	RODOLFO ALCORTA	\N
146	54	11659	ALCORTA	\N
146	54	11660	LOMA VERDE	\N
146	54	11661	BOMBAL	\N
146	54	11662	GENERAL GELLY	\N
146	54	11663	EL BAGUAL	\N
146	54	11664	JUNCAL	\N
146	54	11665	EMPALME VILLA CONSTITUCION	\N
146	54	11666	PAVON	\N
146	54	11667	THEOBALD	\N
146	54	11668	ESTACION VILLA CONSTITUCION	\N
146	54	11669	VILLA CONSTITUCION	\N
146	54	11670	GODOY	\N
146	54	11671	MORANTE	\N
146	54	11672	ORATORIO MORANTE	\N
146	54	11673	RUEDA	\N
146	54	11674	TRES ESQUINAS	\N
146	54	11675	SANTA ROSA DE CALCHINES	\N
146	54	11676	CAMPO DEL MEDIO	\N
146	54	11677	ITURRASPE	\N
146	54	11678	CAYASTA	\N
146	54	11679	COLONIA MASCIAS	\N
146	54	11680	COLONIA NUEVA NARCISO	\N
146	54	11681	COLONIA SAN JOAQUIN	\N
146	54	11682	EL LAUREL	\N
146	54	11683	EL POZO	\N
146	54	11684	LA NORIA	\N
146	54	11685	LOS CERRILLOS	\N
146	54	11686	LOS ZAPALLOS	\N
146	54	11687	SALADERO M. CABAL	\N
146	54	11688	SAN JOAQUIN	\N
146	54	11689	SANTA ROSA	\N
146	54	11690	HELVECIA	\N
146	54	11691	COLONIA CALIFORNIA	\N
146	54	11692	MASCIAS	\N
146	54	11693	LAS TRES MARIAS	\N
146	54	11694	SAN MARCOS DE VENADO TUERTO	\N
146	54	11695	VENADO TUERTO	\N
146	54	11696	LA CHISPA	\N
146	54	11697	LA INGLESITA	\N
146	54	11698	MURPHY	\N
146	54	11699	SAN FRANCISCO DE SANTA FE	\N
146	54	11700	CHAPUY	\N
146	54	11701	OTTO BEMBERG	\N
146	54	11702	SANTA ISABEL	\N
146	54	11703	CAMPO QUIRNO	\N
146	54	11704	LAS ENCADENADAS	\N
146	54	11705	VILLA CAÑAS	\N
146	54	11706	COLONIA MORGAN	\N
146	54	11707	COLONIA SANTA LUCIA	\N
146	54	11708	MARIA TERESA	\N
146	54	11709	ESTACION CHRISTOPHERSEN	\N
146	54	11710	RUNCIMAN	\N
146	54	11711	LA MOROCHA	\N
146	54	11712	SAN GREGORIO	\N
146	54	11713	LA GAMA	\N
146	54	11714	SAN EDUARDO	\N
146	54	11715	SANCTI SPIRITU	\N
146	54	11716	CARMEN	\N
146	54	11717	MAGGIOLO	\N
146	54	11718	FIRMAT	\N
146	54	11719	VILLA FREDRICKSON	\N
146	54	11720	VILLA REGULES	\N
146	54	11721	CORA	\N
146	54	11722	PUEBLO MIGUEL TORRES	\N
146	54	11723	VILLA DIVISA DE MAYO	\N
146	54	11724	CHOVET	\N
146	54	11725	CAÑADA DEL UCLE	\N
146	54	11726	CARLOS DOSE	\N
146	54	11727	CAFFERATA	\N
146	54	11728	EL CANTOR	\N
146	54	11729	LOS ARCOS	\N
146	54	11730	WHEELWRIGHT	\N
146	54	11731	HUGHES	\N
146	54	11732	MERCEDITAS	\N
146	54	11733	SANTA EMILIA	\N
146	54	11734	LABORDEBOY	\N
146	54	11735	MELINCUE	\N
146	54	11736	SAN URBANO	\N
146	54	11737	CARRERAS	\N
146	54	11738	CUATRO DE FEBRERO	\N
146	54	11739	EL JARDIN	\N
146	54	11740	ELORTONDO	\N
146	54	11741	SAN MARCELO	\N
146	54	11742	TEODELINA	\N
146	54	11743	DIEGO DE ALVEAR	\N
146	54	11744	CHRISTOPHERSEN	\N
146	54	11745	LA INES	\N
146	54	11746	RUFINO	\N
146	54	11747	VILLA ROSELLO	\N
146	54	11748	AMENABAR	\N
146	54	11749	EL REFUGIO	\N
146	54	11750	LA ADELAIDA	\N
146	54	11751	LAZZARINO	\N
146	54	11752	TARRAGONA	\N
146	54	11753	AARON CASTELLANOS	\N
146	54	11754	CORONEL ROSETI	\N
146	54	11755	EL ALBERDON	\N
146	54	11756	LA ASTURIANA	\N
146	54	11757	LA CALMA	\N
146	54	11758	LAS DOS ANGELITAS	\N
146	54	11759	MIRAMAR	\N
146	54	11760	SANTA PAULA	\N
146	54	11761	SANTA TERESA	\N
146	54	11762	CAMPO GOLA	\N
146	54	11763	CAMPO URDANIZ	\N
146	54	11764	CAMPO VERGE	\N
146	54	11765	FLORENCIA	\N
146	54	11766	LAS MERCEDES	\N
146	54	11767	PUERTO PIRACUA	\N
146	54	11768	DESVIO KILOMETRO 392	\N
146	54	11769	LA SELVA	\N
146	54	11770	LA ZULEMA	\N
146	54	11771	LAS DELICIAS	\N
146	54	11772	LOS CLAROS	\N
146	54	11773	LOS LEONES	\N
146	54	11774	LAS PALMAS	\N
146	54	11775	LA ESMERALDA	\N
146	54	11776	RECONQUISTA	\N
146	54	11777	AVELLANEDA	\N
146	54	11778	EL CARMEN DE AVELLANEDA	\N
146	54	11779	EL TIMBO	\N
146	54	11780	EWALD	\N
146	54	11781	LA VANGUARDIA	\N
146	54	11782	MOUSSY	\N
146	54	11783	COLONIA SAN MANUEL	\N
146	54	11784	EL ARAZA	\N
146	54	11785	LA POTASA	\N
146	54	11786	LA SARITA	\N
146	54	11787	NICANOR E. MOLINAS	\N
146	54	11788	VICTOR MANUEL II	\N
146	54	11789	ARROYO DEL REY	\N
146	54	11790	FLORIDA	\N
146	54	11791	LA JOSEFINA	\N
146	54	11792	SAN ALBERTO	\N
146	54	11793	LA LOLA	\N
146	54	11794	LOS LAURELES	\N
146	54	11795	PUERTO RECONQUISTA	\N
146	54	11796	CAMPO EL ARAZA	\N
146	54	11797	CAMPO FURRER	\N
146	54	11798	DOCTOR BARROS PAZOS	\N
146	54	11799	LA CELIA 	\N
146	54	11800	LA DIAMELA	\N
146	54	11801	CAMPO GARABATO	\N
146	54	11802	CAMPO RAMSEYER	\N
146	54	11803	COLONIA ALTHUAUS	\N
146	54	11804	COLONIA ELLA	\N
146	54	11805	COLONIA SANTA CATALINA	\N
146	54	11806	EL RICARDITO	\N
146	54	11807	MALABRIGO	\N
146	54	11808	CAPILLA GUADALUPE NORTE	\N
146	54	11809	GUADALUPE NORTE	\N
146	54	11810	LAS GARZAS	\N
146	54	11811	ARROYO CEIBAL	\N
146	54	11812	CAMPO GRANDE	\N
146	54	11813	CAMPO SIETE PROVINCIAS	\N
146	54	11814	EL CEIBALITO	\N
146	54	11815	EL TAPIALITO	\N
146	54	11816	FLOR DE ORO	\N
146	54	11817	INGENIERO CHANOURDIE	\N
146	54	11818	LANTERI	\N
146	54	11819	LAS SIETE PROVINCIAS	\N
146	54	11820	LOS LAPACHOS	\N
146	54	11821	SANTA ANA	\N
146	54	11822	PUERTO OCAMPO	\N
146	54	11823	SAN VICENTE	\N
146	54	11824	VILLA OCAMPO	\N
146	54	11825	CAMPO REDONDO	\N
146	54	11826	GUASUNCHO	\N
146	54	11827	ISLETA	\N
146	54	11828	LA RESERVA	\N
146	54	11829	MOCOVI	\N
146	54	11830	VILLA ADELA	\N
146	54	11831	VILLA ANA (ESTACION)	\N
146	54	11832	ISLA TIGRE	\N
146	54	11833	KM 41 (DPTO. GRAL. OBLIGADO)	\N
146	54	11834	EL SOMBRERITO	\N
146	54	11835	KM 421 (DESVIO PART.FCGB)(EL SOMBRERITO-DPTO.GRAL.OBLIGADO)	\N
146	54	11836	LA CLARITA	\N
146	54	11837	PAUL GROUSSAC	\N
146	54	11838	CAMPO YAGUARETE	\N
146	54	11839	LAS TOSCAS	\N
146	54	11840	YAGUARETE	\N
146	54	11841	SAN ANTONIO DE OBLIGADO	\N
146	54	11842	TACUARENDI	\N
146	54	11843	OBRAJE INDIO MUERTO	\N
146	54	11844	OBRAJE SAN JUAN	\N
146	54	11845	POTRERO GUASUNCHO	\N
146	54	11846	VILLA GUILLERMINA	\N
146	54	11847	CAMPO HARDY	\N
146	54	11848	EL RABON	\N
146	54	11849	PUERTO PIRACUACITO	\N
146	54	11850	BERNA	\N
146	54	11851	CAMPO MEDINA	\N
146	54	11852	LUCIO V. LOPEZ	\N
146	54	11853	SALTO GRANDE	\N
146	54	11854	SANTA TERESA	\N
146	54	11855	CAMPO HORQUESCO	\N
146	54	11856	COLONIA MEDICI	\N
146	54	11857	LARGUIA	\N
146	54	11858	TOTORAS	\N
146	54	11859	CLASON	\N
146	54	11860	LOS LEONES	\N
146	54	11861	CAMPO PALETTA	\N
146	54	11862	OLIVEROS	\N
146	54	11863	RINCON DE GRONDONA	\N
146	54	11864	ANDINO	\N
146	54	11865	CAMPO RAFFO	\N
146	54	11866	COLONIA TRES MARIAS	\N
146	54	11867	SERODINO	\N
146	54	11868	CARRIZALES	\N
146	54	11869	CLARKE	\N
146	54	11870	CAÑADA DE GOMEZ	\N
146	54	11871	BERRETTA	\N
146	54	11872	BUSTINZA	\N
146	54	11873	GRANJA SAN MANUEL	\N
146	54	11874	MARIA LUISA CORREA	\N
146	54	11875	SAN ESTANISLAO	\N
146	54	11876	SAN RICARDO	\N
146	54	11877	VILLA ELOISA	\N
146	54	11878	CORREA	\N
146	54	11879	VILLA LA RIBERA	\N
146	54	11880	BARRANQUITAS	\N
146	54	11881	PIQUETE	\N
146	54	11882	SANTA FE	\N
146	54	11883	VILLA DON BOSCO	\N
146	54	11884	VILLA MARIA SELVA	\N
146	54	11885	VILLA YAPEYU	\N
146	54	11886	ALTO VERDE	\N
146	54	11887	ARROYO LEYES	\N
146	54	11888	CAMPO CRESPO	\N
146	54	11889	COLASTINE	\N
146	54	11890	COLASTINE NORTE	\N
146	54	11891	RINCON NORTE	\N
146	54	11892	RINCON POTREROS	\N
146	54	11893	SAN JOSE DEL RINCON	\N
146	54	11894	VILLA VIVEROS	\N
146	54	11895	ANGEL GALLARDO	\N
146	54	11896	ARROYO AGUIAR	\N
146	54	11897	ASCOCHINGAS	\N
146	54	11898	CONSTITUYENTES	\N
146	54	11899	MONTE VERA	\N
146	54	11900	NUEVA POMPEYA	\N
146	54	11901	SAN PEDRO SUR	\N
146	54	11902	SANTO TOME	\N
146	54	11903	VILLA LUJAN	\N
146	54	11904	BAJO LAS TUNAS	\N
146	54	11905	SAUCE VIEJO	\N
146	54	11906	GOBERNADOR CANDIOTI	\N
146	54	11907	IRIONDO	\N
146	54	11908	RECREO	\N
146	54	11909	LAGUNA PAIVA	\N
146	54	11910	REYNALDO CULLEN	\N
146	54	11911	SAN GUILLERMO	\N
146	54	11912	CAMPO ANDINO	\N
146	54	11913	EL GALPON	\N
146	54	11914	LOS HORNOS	\N
146	54	11915	SAN PEDRO NORTE	\N
146	54	11916	MANUCHO	\N
146	54	11917	NELSON	\N
146	54	11918	AROMOS	\N
146	54	11919	CABAL	\N
146	54	11920	COLONIA CAMPO BOTTO	\N
146	54	11921	EMILIA	\N
146	54	11922	LASSAGA	\N
146	54	11923	LLAMBI CAMPBELL	\N
146	54	11924	PASO VINAL	\N
146	54	11925	CAMPO RODRIGUEZ	\N
146	54	11926	SANTA CLARA DE BUENA VISTA	\N
146	54	11927	ITUZAINGO	\N
146	54	11928	EMPALME SAN CARLOS	\N
146	54	11929	EL TROPEZON	\N
146	54	11930	FRANCK	\N
146	54	11931	LAS TUNAS	\N
146	54	11932	SAN CARLOS NORTE	\N
146	54	11933	SAN JERONIMO DEL SAUCE	\N
146	54	11934	CAMPO MAGNIN	\N
146	54	11935	MARIANO SAAVEDRA	\N
146	54	11936	SA PEREIRA	\N
146	54	11937	SAN JERONIMO NORTE	\N
146	54	11938	SAN MARIANO	\N
146	54	11939	SANTA MARIA	\N
146	54	11940	BARRIO SUR (SAN CARLOS CENTRO)	\N
146	54	11941	COLONIA MATILDE	\N
146	54	11942	CORONEL RODRIGUEZ	\N
146	54	11943	ESTACION MATILDE	\N
146	54	11944	LAS HIGUERITAS	\N
146	54	11945	MATILDE	\N
146	54	11946	SAN CARLOS CENTRO	\N
146	54	11947	SAN CARLOS SUD	\N
146	54	11948	SAN JOSE	\N
146	54	11949	SAN AGUSTIN	\N
146	54	11950	CULULU	\N
146	54	11951	HIPATIA	\N
146	54	11952	INGENIERO BOASI	\N
146	54	11953	PROGRESO	\N
146	54	11954	SARMIENTO	\N
146	54	11955	PERICOTA	\N
146	54	11956	PROVIDENCIA	\N
146	54	11957	SANTO DOMINGO	\N
146	54	11958	SOUTOMAYOR	\N
146	54	11959	LA PELADA	\N
146	54	11960	MARIA LUISA	\N
146	54	11961	COLONIA ADOLFO ALSINA	\N
146	54	11962	JACINTO ARAUZ	\N
146	54	11963	ELISA	\N
146	54	11964	BARRIO SAN JOSE	\N
146	54	11965	PUJATO NORTE	\N
146	54	11966	COLONIA PUJOL	\N
146	54	11967	ESPERANZA	\N
146	54	11968	LA ORILLA	\N
146	54	11969	LARRECHEA	\N
146	54	11970	PUEBLO ABC	\N
146	54	11971	RINCON DEL PINTADO	\N
146	54	11972	CAVOUR	\N
146	54	11973	COLONIA LA NUEVA	\N
146	54	11974	HUMBOLDT	\N
146	54	11975	HUMBOLDT CHICO	\N
146	54	11976	RIVADAVIA	\N
146	54	11977	GRUTLY	\N
146	54	11978	GRUTLY NORTE	\N
146	54	11979	PILAR	\N
146	54	11980	FELICIA	\N
146	54	11981	NUEVO TORINO	\N
146	54	11982	SAN CARLOS	\N
146	54	11983	PUEBLO NUEVO	\N
146	54	11984	COLONIA MONTEFIORE	\N
146	54	11985	LA ELSA	\N
146	54	11986	LA MARINA	\N
146	54	11987	CAMPO SAN JOSE	\N
146	54	11988	EL AMARGO	\N
146	54	11989	EL MARIANO	\N
146	54	11990	FORTIN ARGENTINA	\N
146	54	11991	FORTIN CACIQUE	\N
146	54	11992	FORTIN TOSTADO	\N
146	54	11993	LA BOMBILLA	\N
146	54	11994	LOS CHARABONES	\N
146	54	11995	TOSTADO	\N
146	54	11996	ANTONIO PINI	\N
146	54	11997	CABEZA DE CHANCHO	\N
146	54	11998	EL NOCHERO	\N
146	54	11999	FORTIN ATAHUALPA	\N
146	54	12000	FORTIN SEIS DE CABALLERIA	\N
146	54	12001	GREGORIA PEREZ DE DENIS	\N
146	54	12002	PADRE PEDRO ITURRALDE	\N
146	54	12003	POZO BORRADO	\N
146	54	12004	SAN BERNARDO	\N
146	54	12005	SANTA MARGARITA	\N
146	54	12006	TRES POZOS	\N
146	54	12007	VILLA MINETTI	\N
146	54	12008	CAMPO GARAY	\N
146	54	12009	COLONIA INDEPENDENCIA	\N
146	54	12010	ESTEBAN RAMS	\N
146	54	12011	FORTIN ALERTA	\N
146	54	12012	LOGROÑO	\N
146	54	12013	PORTALIS	\N
146	54	12014	NUEVA ITALIA	\N
146	54	12015	GATO COLORADO	\N
146	54	12016	LA CERAMICA Y CUYO	\N
146	54	12017	ROSARIO	\N
146	54	12018	ALBARELLOS	\N
146	54	12019	MONTE FLORES	\N
146	54	12020	VILLA AMELIA	\N
146	54	12021	COLONIA ESCRIBANO	\N
146	54	12022	CORONEL BOGADO (EX PUEBLO NAVARRO)	\N
146	54	12023	CORONEL RODOLFO S. DOMINGUEZ	\N
146	54	12024	EL CARAMELO	\N
146	54	12025	ESTANCIA LA MARIA	\N
146	54	12026	LA CAROLINA	\N
146	54	12027	PEREYRA LUCENA	\N
146	54	12028	URANGA	\N
146	54	12029	ZAMPONI	\N
146	54	12030	ALVAREZ	\N
146	54	12031	ESTANCIA SAN ANTONIO	\N
146	54	12032	SOLDINI	\N
146	54	12033	ACEBAL	\N
146	54	12034	CARMEN DEL SAUCE	\N
146	54	12035	ARMINDA	\N
146	54	12036	BENARD	\N
146	54	12037	ERASTO	\N
146	54	12038	PIÑERO	\N
146	54	12039	PUEBLO MUÑOZ	\N
146	54	12040	PEREZ	\N
146	54	12041	SAN SEBASTIAN	\N
146	54	12042	VILLA AMERICA	\N
146	54	12043	CAMPO CALVO	\N
146	54	12044	ZAVALLA	\N
146	54	12045	CORONEL AGUIRRE	\N
146	54	12046	VEINTIDOS DE AGOSTO	\N
146	54	12047	VILLA GOBERNADOR GALVEZ	\N
146	54	12048	VILLA SAN DIEGO	\N
146	54	12049	ALVEAR	\N
146	54	12050	CAMINO MONTE FLORES	\N
146	54	12051	CRESTA	\N
146	54	12052	FIGHIERA	\N
146	54	12053	GENERAL LAGOS	\N
146	54	12054	LA LATA	\N
146	54	12055	PUEBLO ESTHER	\N
146	54	12056	ARROYO SECO	\N
146	54	12057	FUNES	\N
146	54	12058	LICEO AERONAUTICO MILITAR	\N
146	54	12059	IBARLUCEA	\N
146	54	12060	GRANADERO BAIGORRIA	\N
146	54	12061	PAGANINI	\N
146	54	12062	CAPIVARA	\N
146	54	12063	CONSTANZA	\N
146	54	12064	COLONIA BERLIN	\N
146	54	12065	COLONIA ORTIZ	\N
146	54	12066	DOCE CASAS	\N
146	54	12067	MOISES VILLE	\N
146	54	12068	MUTCHNIK	\N
146	54	12069	VEINTICUATRO CASAS	\N
146	54	12070	BEALISTOCK	\N
146	54	12071	COLONIA BOSSI	\N
146	54	12072	LAS PALMERAS	\N
146	54	12073	PALACIOS	\N
146	54	12074	ZADOCKHAN	\N
146	54	12075	CERES	\N
146	54	12076	CAMPO EL MATACO	\N
146	54	12077	CURUPAITY	\N
146	54	12078	LA RUBIA	\N
146	54	12079	MONIGOTES	\N
146	54	12080	ARRUFO	\N
146	54	12081	COLONIA ANA	\N
146	54	12082	VILLA TRINIDAD	\N
146	54	12083	COLONIA MACKINLAY	\N
146	54	12084	COLONIA MALHMAN SUD	\N
146	54	12085	COLONIA ROSA	\N
146	54	12086	SAN GUILLERMO	\N
146	54	12087	COLONIA RIPAMONTI	\N
146	54	12088	MONTE OBSCURIDAD	\N
146	54	12089	RIPAMONTI	\N
146	54	12090	SUARDI	\N
146	54	12091	AMBROSETTI	\N
146	54	12092	HERSILIA	\N
146	54	12093	COLONIA CLARA	\N
146	54	12094	LA CLARA	\N
146	54	12095	SOLEDAD	\N
146	54	12096	PETRONILA	\N
146	54	12097	RINCON DE SAN ANTONIO	\N
146	54	12098	VILLA SARALEGUI	\N
146	54	12099	DHO	\N
146	54	12100	EL AGUARA	\N
146	54	12101	LOS MOLLES	\N
146	54	12102	SAN CRISTOBAL	\N
146	54	12103	AGUARA GRANDE	\N
146	54	12104	PORTUGALETE	\N
146	54	12105	ÑANDUCITA	\N
146	54	12106	LA LUCILA	\N
146	54	12107	LUCILA	\N
146	54	12108	MARIA EUGENIA	\N
146	54	12109	AGUARA	\N
146	54	12110	COLONIA EL SIMBOL	\N
146	54	12111	LA CABRAL	\N
146	54	12112	LA POLVAREDA	\N
146	54	12113	LAS AVISPAS	\N
146	54	12114	SANTURCE	\N
146	54	12115	HUANQUEROS	\N
146	54	12116	LA VERDE	\N
146	54	12117	LAGUNA VERDE	\N
146	54	12118	ÑANDU	\N
146	54	12119	COLONIA FRANCESA	\N
146	54	12120	COLONIA TERESA	\N
146	54	12121	SAN JAVIER	\N
146	54	12122	CACIQUE ARIACAIQUIN	\N
146	54	12123	CAMPO ZAVALLA	\N
146	54	12124	COLONIA LA MORA	\N
146	54	12125	LA BRAVA	\N
146	54	12126	ALEJANDRA	\N
146	54	12127	EL PAJARO BLANCO	\N
146	54	12128	LOS CORRALITOS	\N
146	54	12129	LOS OSOS	\N
146	54	12130	CAMPO COUBERT	\N
146	54	12131	COLONIA LA NICOLASA	\N
146	54	12132	CAMPO DURAND	\N
146	54	12133	COLONIA DURAN	\N
146	54	12134	COLONIA EL TOBA	\N
146	54	12135	COLONIA SAGER	\N
146	54	12136	CAMPO HUBER	\N
146	54	12137	LA LOMA	\N
146	54	12138	LOS CUERVOS	\N
146	54	12139	NUEVA ROMANG	\N
146	54	12140	ROMANG	\N
146	54	12141	LA CATALINA	\N
146	54	12142	SAN GENARO	\N
146	54	12143	SAN GENARO NORTE	\N
146	54	12144	VILLA BIOTA	\N
146	54	12145	CENTENO	\N
146	54	12146	VILLA GUASTALLA	\N
146	54	12147	GABOTO	\N
146	54	12148	MACIEL	\N
146	54	12149	PUERTO GABOTO	\N
146	54	12150	CAMPO GALLOSO	\N
146	54	12151	MONJE	\N
146	54	12152	DIAZ	\N
146	54	12153	CAMPO GARCIA	\N
146	54	12154	CAMPO MOURE	\N
146	54	12155	CARCEL MODELO CORONDA	\N
146	54	12156	COLONIA CORONDINA	\N
146	54	12157	CORONDA	\N
146	54	12158	LARRECHEA	\N
146	54	12159	AROCENA	\N
146	54	12160	BARRIO CAIMA	\N
146	54	12161	DESVIO ARIJON	\N
146	54	12162	PUENTE COLASTINE	\N
146	54	12163	SAN FABIAN	\N
146	54	12164	BARRANCAS	\N
146	54	12165	PUERTO ARAGON	\N
146	54	12166	BERNARDO DE IRIGOYEN	\N
146	54	12167	CAMPO BRARDA	\N
146	54	12168	CAMPO CARIGNANO	\N
146	54	12169	CAMPO GENERO	\N
146	54	12170	CASALEGNO	\N
146	54	12171	IRIGOYEN	\N
146	54	12172	COLONIA PIAGGIO	\N
146	54	12173	GALVEZ	\N
146	54	12174	CAMPO GIMENEZ	\N
146	54	12175	GESSLER	\N
146	54	12176	LOMA ALTA	\N
146	54	12177	SAN EUGENIO	\N
146	54	12178	LOPEZ	\N
146	54	12179	RIGBY	\N
146	54	12180	SAN MARTIN DE TOURS	\N
146	54	12181	LA CLORINDA	\N
146	54	12182	ESTER	\N
146	54	12183	CAYASTACITO	\N
146	54	12184	ESQUINA GRANDE	\N
146	54	12185	FORTIN ALMAGRO	\N
146	54	12186	SAN JUSTO	\N
146	54	12187	VERA MUJICA	\N
146	54	12188	LOS SALADILLOS	\N
146	54	12189	ABIPONES	\N
146	54	12190	COLONIA EL OCHENTA	\N
146	54	12191	COLONIA SILVA	\N
146	54	12192	LA ROSA	\N
146	54	12193	MARCELINO ESCALADA	\N
146	54	12194	RAMAYON	\N
146	54	12195	VILLA LASTENIA	\N
146	54	12196	GOBERNADOR CRESPO	\N
146	54	12197	COLONIA DOLORES	\N
146	54	12198	LA PENCA Y CARAGUATA	\N
146	54	12199	SAN MARTIN NORTE	\N
146	54	12200	ARRASCAETA	\N
146	54	12201	CAMPO BERRAZ	\N
146	54	12202	COLONIA MANUEL MENCHACA	\N
146	54	12203	EL SOMBRERERO	\N
146	54	12204	LA JULIA	\N
146	54	12205	LOS OLIVOS	\N
146	54	12206	MIGUEL ESCALADA	\N
146	54	12207	NARE	\N
146	54	12208	NUEVA UKRANIA	\N
146	54	12209	PAIKIN	\N
146	54	12210	COLONIA SOL DE MAYO	\N
146	54	12211	COLONIA TRES REYES	\N
146	54	12212	LUCIANO LEIVA	\N
146	54	12213	PUEBLO SAN BERNARDO	\N
146	54	12214	VIDELA	\N
146	54	12215	COLONIA LA BLANCA	\N
146	54	12216	LA CRIOLLA	\N
146	54	12217	FIVES LILLE	\N
146	54	12218	GUARANIES	\N
146	54	12219	LA CAMILA	\N
146	54	12220	PEDRO GOMEZ CELLO	\N
146	54	12221	VERA Y PINTADO	\N
146	54	12222	JOSE M. MACIAS	\N
146	54	12223	MAIZALES	\N
146	54	12224	COLONIA CLODOMIRA	\N
146	54	12225	CORONEL ARNOLD	\N
146	54	12226	FUENTES	\N
146	54	12227	PUJATO	\N
146	54	12228	VILLA PORUCCI	\N
146	54	12229	ROLDAN	\N
146	54	12230	SAN GERONIMO	\N
146	54	12231	SAN JERONIMO SUD	\N
146	54	12232	CARCARAÑA	\N
146	54	12233	COLONIA EL CARMEN	\N
146	54	12234	LA SALADA	\N
146	54	12235	LUIS PALACIOS	\N
146	54	12236	CAPITAN BERMUDEZ	\N
146	54	12237	JUAN ORTIZ	\N
146	54	12238	VILLA CASSINI	\N
146	54	12239	ARSENAL DE GUERRA SAN LORENZO	\N
146	54	12240	BORGHI	\N
146	54	12241	FABRICA MILITAR SAN LORENZO	\N
146	54	12242	FRAY LUIS BELTRAN	\N
146	54	12243	VILLA GARIBALDI	\N
146	54	12244	VILLA MARGARITA	\N
146	54	12245	BARLETT	\N
146	54	12246	VILLA MUGUETA	\N
146	54	12247	LAS QUINTAS	\N
146	54	12248	PINO DE SAN LORENZO	\N
146	54	12249	PUERTO SAN LORENZO	\N
146	54	12250	SAN LORENZO	\N
146	54	12251	RICARDONE	\N
146	54	12252	CERANA	\N
146	54	12253	PUEBLO KIRSTON	\N
146	54	12254	PUERTO GENERAL SAN MARTIN	\N
146	54	12255	JESUS MARIA	\N
146	54	12256	TIMBUES	\N
146	54	12257	ALDAO	\N
146	54	12258	CAMPO CASTRO	\N
146	54	12259	CASAS	\N
146	54	12260	LAS BANDURRIAS	\N
146	54	12261	COLONIA BELGRANO	\N
146	54	12262	WILDERMUTH	\N
146	54	12263	CASTELAR	\N
146	54	12264	ESMERALDITA	\N
146	54	12265	SAN JOSE FRONTERA	\N
146	54	12266	CAMPO FAGGIANO	\N
146	54	12267	SASTRE	\N
146	54	12268	CRISPI	\N
146	54	12269	AVENA	\N
146	54	12270	SAN MARTIN DE LAS ESCOBAS	\N
146	54	12271	COLONIA LA YERBA	\N
146	54	12272	COLONIA SANTA ANITA	\N
146	54	12273	LAS PETACAS	\N
146	54	12274	SAN JORGE	\N
146	54	12275	CARLOS PELLEGRINI	\N
146	54	12276	CAÑADA ROSQUIN	\N
146	54	12277	TRAILL	\N
146	54	12278	COLONIA SAN FRANCISCO	\N
146	54	12279	MARIA SUSANA	\N
146	54	12280	LANDETA	\N
146	54	12281	LOS CARDOS	\N
146	54	12282	EL TREBOL	\N
146	54	12283	TAIS	\N
146	54	12284	BARRIO BELGRANO	\N
146	54	12285	CALCHAQUI	\N
146	54	12286	LA HOSCA	\N
146	54	12287	LOS GALPONES	\N
146	54	12288	COLONIA LA NEGRA	\N
146	54	12289	LA ORIENTAL	\N
146	54	12290	COLONIA LA MARIA	\N
146	54	12291	ESPIN	\N
146	54	12292	LA GUAMPITA	\N
146	54	12293	MARGARITA	\N
146	54	12294	ESTANCIA LAS GAMAS	\N
146	54	12295	ESTANCIA LOS PALMARES	\N
146	54	12296	ESTANCIA PAVENHAN	\N
146	54	12297	LA GALLARETA	\N
146	54	12298	LA SARNOSA	\N
146	54	12299	LOS PALMARES	\N
146	54	12300	FORTIN CHARRUA	\N
146	54	12301	VELAZQUEZ	\N
146	54	12302	VERA	\N
146	54	12303	CAÑADA OMBU	\N
146	54	12304	CAMPO MONTE LA VIRUELA	\N
146	54	12305	COLMENA	\N
146	54	12306	DESVIO KILOMETRO 282	\N
146	54	12307	ESTANCIA LA GOLONDRINA	\N
146	54	12308	GARABATO	\N
146	54	12309	GOLONDRINA	\N
146	54	12310	GUAYCURU	\N
146	54	12311	INTIYACO	\N
146	54	12312	LOS AMORES	\N
146	54	12313	LOS TABANOS	\N
146	54	12314	OGILVIE	\N
146	54	12315	POZO DE LOS INDIOS	\N
146	54	12316	SANTA FELICIA	\N
146	54	12317	TOBA	\N
146	54	12318	COSTA DEL TOBA	\N
146	54	12319	FORTIN CHILCAS	\N
146	54	12320	FORTIN OLMOS	\N
146	54	12321	SANTA LUCIA	\N
146	54	12322	CARAGUATAY	\N
146	54	12323	EL TAJAMAR	\N
146	54	12324	TARTAGAL	\N
146	54	12325	KM 49 (VILLA GUILLERMINA-DPTO. VERA)	\N
147	54	12326	ARGENTINA	\N
147	54	12327	CASARES	\N
147	54	12328	EL AIBAL	\N
147	54	12329	EL ASPIRANTE	\N
147	54	12330	LA BLANCA	\N
147	54	12331	MALBRAN	\N
147	54	12332	MARAVILLA	\N
147	54	12333	NUEVA TRINIDAD	\N
147	54	12334	SAN SEBASTIAN	\N
147	54	12335	SANTA ANA	\N
147	54	12336	TRES LAGUNAS	\N
147	54	12337	CAMPO RAMON LAPLACE	\N
147	54	12338	COLONIA ERMELINDA	\N
147	54	12339	COLONIA PAULA	\N
147	54	12340	DOÑA LORENZA	\N
147	54	12341	EL DESTINO	\N
147	54	12342	EL GALPON	\N
147	54	12343	GUARDIA VIEJA	\N
147	54	12344	LAS ABRAS DE SAN ANTONIO	\N
147	54	12345	LAS ALMAS	\N
147	54	12346	MARTIN PASO	\N
147	54	12347	MONTE CRECIDO	\N
147	54	12348	PINTO	\N
147	54	12349	PUNTA DEL GARABATO	\N
147	54	12350	PUNTA DEL MONTE	\N
147	54	12351	QUEBRACHITOS	\N
147	54	12352	SAN JOSE	\N
147	54	12353	SAN RUFINO	\N
147	54	12354	TOME Y TRAIGA	\N
147	54	12355	COLONIA SANTA ROSA AGUIRRE	\N
147	54	12356	TRES LAGUNAS	\N
147	54	12357	EL SETENTA	\N
147	54	12358	CORONEL MANUEL LEONCIO RICO	\N
147	54	12359	EL SIMBOL	\N
147	54	12360	PUNTA RIELES	\N
147	54	12361	SACHAYOJ	\N
147	54	12362	AGUSTINA LIBARONA	\N
147	54	12363	DOBLE TERO	\N
147	54	12364	DONADEU	\N
147	54	12365	DOS EULALIAS	\N
147	54	12366	CENTRAL DOLORES	\N
147	54	12367	CAMPO GALLO	\N
147	54	12368	POZO MUERTO	\N
147	54	12369	YUNTA POZO	\N
147	54	12370	CUQUERO	\N
147	54	12371	EL OSCURO	\N
147	54	12372	LA UNION	\N
147	54	12373	MONTE RICO	\N
147	54	12374	CHURQUI	\N
147	54	12375	CUQUENOS	\N
147	54	12376	EL OLIVAR	\N
147	54	12377	ESTEROS	\N
147	54	12378	FORTUNA	\N
147	54	12379	HUACHANA	\N
147	54	12380	LA MANGA	\N
147	54	12381	LAS PALMITAS	\N
147	54	12382	MAJANCITO	\N
147	54	12383	MONTEVIDEO	\N
147	54	12384	MORADITO	\N
147	54	12385	NORQUEOJ	\N
147	54	12386	SANTOS LUGARES	\N
147	54	12387	TARPUNA	\N
147	54	12388	VILLA PALMAR	\N
147	54	12389	SAN ENRIQUE	\N
147	54	12390	PUERTA GRANDE	\N
147	54	12391	ABRITA CHICA	\N
147	54	12392	ABRITA GRANDE	\N
147	54	12393	ANCHANGA	\N
147	54	12394	ANCOCHA	\N
147	54	12395	ARAGONES	\N
147	54	12396	CANCINOS	\N
147	54	12397	CHILCAS LA LOMA	\N
147	54	12398	HOYON	\N
147	54	12399	ISLA DE ARAGONES	\N
147	54	12400	LEZCANOS	\N
147	54	12401	LOMITAS	\N
147	54	12402	MIRANDAS	\N
147	54	12403	PUENTE DEL SALADO	\N
147	54	12404	PUESTO DE DIAZ	\N
147	54	12405	RODEO DE SORIA	\N
147	54	12406	RODEO DE VALDEZ	\N
147	54	12407	SAN ANTONIO DE LOS CACERES	\N
147	54	12408	SAN DIONISIO	\N
147	54	12409	SAN MARTIN	\N
147	54	12410	SIMBOL POZO	\N
147	54	12411	ABRITA	\N
147	54	12412	AYUNCHA	\N
147	54	12413	EL REMANSO	\N
147	54	12414	GUANACO SOMBRIANA	\N
147	54	12415	BOQUERON	\N
147	54	12416	EL DORADO	\N
147	54	12417	MEDELLIN	\N
147	54	12418	PUESTO DEL ROSARIO	\N
147	54	12419	ATAMISQUI	\N
147	54	12420	BAJADITA	\N
147	54	12421	CODO VIEJO	\N
147	54	12422	ESTACION ATAMISQUI	\N
147	54	12423	SAN LUIS (EST. ATAMISQUI)	\N
147	54	12424	SANTA ISABEL	\N
147	54	12425	BURRO POZO	\N
147	54	12426	COLLERA HUIRI	\N
147	54	12427	EL PERU	\N
147	54	12428	ESCALERA	\N
147	54	12429	JUANILLO	\N
147	54	12430	LOS SAUCES	\N
147	54	12431	PAMPALLAJTA	\N
147	54	12432	SAUCEN	\N
147	54	12433	SOCONCHO	\N
147	54	12434	VENTURA PAMPA	\N
147	54	12435	VILLA ATAMISQUI	\N
147	54	12436	PERCAS	\N
147	54	12437	SAN JOSE DE FLORES	\N
147	54	12438	AVE MARIA	\N
147	54	12439	CALOJ	\N
147	54	12440	CODO POZO	\N
147	54	12441	CONCHAYOS	\N
147	54	12442	LUGONES	\N
147	54	12443	NOVILLO	\N
147	54	12444	PAAJ RODEO	\N
147	54	12445	PASO GRANDE	\N
147	54	12446	POZO MARCADO	\N
147	54	12447	PUNTA CORRAL	\N
147	54	12448	PUNTA POZO	\N
147	54	12449	SAN PEDRO	\N
147	54	12450	SAN ROQUE	\N
147	54	12451	SANTO DOMINGO	\N
147	54	12452	SAUCE BAJADA	\N
147	54	12453	ZAPI POZO	\N
147	54	12454	BREALOJ	\N
147	54	12455	CHAÑAR POZO	\N
147	54	12456	COLONIA ISLA	\N
147	54	12457	EL TRECE	\N
147	54	12458	GUAÑAGASTA	\N
147	54	12459	HERRERA	\N
147	54	12460	LUJAN	\N
147	54	12461	MAILIN	\N
147	54	12462	MALLIN VIEJO	\N
147	54	12463	MOCONZA	\N
147	54	12464	REPRESA	\N
147	54	12465	RINCON DE LA ESPERANZA	\N
147	54	12466	SALVIAIOJ GAITAN	\N
147	54	12467	SAN ANTONIO DE COPO	\N
147	54	12468	SAN JOSE	\N
147	54	12469	TACO ATUN	\N
147	54	12470	BLANCA POZO	\N
147	54	12471	BRACHO	\N
147	54	12472	COLONIA DORA	\N
147	54	12473	LIBANESA	\N
147	54	12474	PUENTE NEGRO	\N
147	54	12475	SUNCHITUYOJ	\N
147	54	12476	TACON ESQUINA	\N
147	54	12477	ICAÑO	\N
147	54	12478	LA COSTA	\N
147	54	12479	LAGO MUYOJ	\N
147	54	12480	MAL PASO	\N
147	54	12481	ORO PAMPA	\N
147	54	12482	REAL SAYANA	\N
147	54	12483	TIESTITUYOS	\N
147	54	12484	TRONCO BLANCO	\N
147	54	12485	YACASNIOJ	\N
147	54	12486	CHANCHILLOS	\N
147	54	12487	CHILQUITA I	\N
147	54	12488	LA DARSENA	\N
147	54	12489	LOS QUIROGA	\N
147	54	12490	BEJAN	\N
147	54	12491	BARRIO ESTE	\N
147	54	12492	COLONIA MARIA LUISA	\N
147	54	12493	EL BOSQUE	\N
147	54	12494	LA BANDA	\N
147	54	12495	LAS HERMANAS	\N
147	54	12496	NUEVA ANTAJE	\N
147	54	12497	RUBIA MORENO	\N
147	54	12498	SANTOS LUGARES	\N
147	54	12499	VILLA INES	\N
147	54	12500	VILLA UNION	\N
147	54	12501	CAÑADA ESCOBAR	\N
147	54	12502	TRAMO 16	\N
147	54	12503	ANTAJE	\N
147	54	12504	ARDILES	\N
147	54	12505	CHAUPI POZO	\N
147	54	12506	CORBALANES	\N
147	54	12507	EL AIBE	\N
147	54	12508	EL PUENTE	\N
147	54	12509	KISKA HURMANA	\N
147	54	12510	LA CAÑADA	\N
147	54	12511	LOS ALDERETES	\N
147	54	12512	SAN RAMON	\N
147	54	12513	SINQUEN PUNCO	\N
147	54	12514	ABRA GRANDE	\N
147	54	12515	CORO ABRA	\N
147	54	12516	HUYAMAMPA	\N
147	54	12517	LA AURORA	\N
147	54	12518	LOS HERRERAS	\N
147	54	12519	LOS MARCOS	\N
147	54	12520	PALOS QUEMADOS	\N
147	54	12521	PAMPA MAYO	\N
147	54	12522	PUESTO LOS MARCOS	\N
147	54	12523	SIMBOL CAÑADA	\N
147	54	12524	BAYO MUERTO	\N
147	54	12525	CLODOMIRA	\N
147	54	12526	CONDOR HUASI	\N
147	54	12527	EL FAVORITO	\N
147	54	12528	FAVORITA	\N
147	54	12529	LAGUNA LARGA	\N
147	54	12530	PALMARES	\N
147	54	12531	RUMIOS	\N
147	54	12532	SAN FRANCISCO LAVALLE	\N
147	54	12533	SANTA ROSA DE VITERBO	\N
147	54	12534	SIMBOLAR	\N
147	54	12535	CAMPO BELGRANO	\N
147	54	12536	DESVIO POZO DULCE	\N
147	54	12537	EL CRUCERO	\N
147	54	12538	EL JARDIN	\N
147	54	12539	EL ONCE	\N
147	54	12540	EL SIMBOL	\N
147	54	12541	FORTIN INCA	\N
147	54	12542	GUARDIA ESCOLTA	\N
147	54	12543	LA AIDA	\N
147	54	12544	LA DELIA	\N
147	54	12545	LA DORA	\N
147	54	12546	LA FELICIANA	\N
147	54	12547	LA LIBIA	\N
147	54	12548	LA MAGDALENA	\N
147	54	12549	LA SANTAFECINA	\N
147	54	12550	LAS CHILCAS	\N
147	54	12551	LAS ISLETAS	\N
147	54	12552	LAS MOCHAS	\N
147	54	12553	LAS TERESAS	\N
147	54	12554	POZO DULCE	\N
147	54	12555	SAN GERMAN	\N
147	54	12556	BANDERA	\N
147	54	12557	COLONIA ALSINA	\N
147	54	12558	DON PIETRO	\N
147	54	12559	EL AGRICULTOR	\N
147	54	12560	EL CANDELERO	\N
147	54	12561	ISLA BAJA	\N
147	54	12562	LA ALEMANA	\N
147	54	12563	LA DOLORES	\N
147	54	12564	LA EULALIA	\N
147	54	12565	LA FRANCISCA	\N
147	54	12566	LA HIEDRA	\N
147	54	12567	LA HUERTA	\N
147	54	12568	LA PANCHITA	\N
147	54	12569	LA ROSILLA	\N
147	54	12570	LA SUSANA	\N
147	54	12571	LA TERESA	\N
147	54	12572	LAS AGUADAS	\N
147	54	12573	LAS GAMAS	\N
147	54	12574	LOS PARAISOS	\N
147	54	12575	NUEVA AURORA	\N
147	54	12576	SELVA BLANCA	\N
147	54	12577	CONTRERAS	\N
147	54	12578	EL PUESTITO	\N
147	54	12579	EL VINALAR	\N
147	54	12580	HUAICO HONDO	\N
147	54	12581	LAS CEJAS	\N
147	54	12582	MERCEDES	\N
147	54	12583	POZO NUEVO	\N
147	54	12584	SANTIAGO DEL ESTERO	\N
147	54	12585	TALA POZO	\N
147	54	12586	VILLA CONSTANTINA	\N
147	54	12587	COSTA RICA	\N
147	54	12588	EL DEAN	\N
147	54	12589	SAUZAL	\N
147	54	12590	TIPIRO	\N
147	54	12591	REMES	\N
147	54	12592	TRONCO JURAS	\N
147	54	12593	TUNAS PUNCO	\N
147	54	12594	CARDOZOS	\N
147	54	12595	INGENIERO EZCURRA	\N
147	54	12596	MACO YANDA	\N
147	54	12597	MAGUITO	\N
147	54	12598	MAQUITA	\N
147	54	12599	MAQUITIS	\N
147	54	12600	NANDA	\N
147	54	12601	NAQUITO	\N
147	54	12602	SAN PEDRO	\N
147	54	12603	SANTA MARIA	\N
147	54	12604	SANTA ROSA	\N
147	54	12605	UPIANITA	\N
147	54	12606	VILLA ZANJON	\N
147	54	12607	YANDA	\N
147	54	12608	ESTACION ZANJON	\N
147	54	12609	ANTILO	\N
147	54	12610	ROSARIO	\N
147	54	12611	MACO	\N
147	54	12612	BELGICA	\N
147	54	12613	CAMPO LA ANGELITA	\N
147	54	12614	COLONIA EL PELIGRO	\N
147	54	12615	EL CABURE	\N
147	54	12616	EL PERSEGUIDO	\N
147	54	12617	LA ANGELITA	\N
147	54	12618	LA GRANJA	\N
147	54	12619	LAVALLE	\N
147	54	12620	LOS PIRPINTOS	\N
147	54	12621	LOS TIGRES	\N
147	54	12622	PAMPA DE LOS GUANACOS	\N
147	54	12623	POZO VIL	\N
147	54	12624	PUESTO CORDOBA	\N
147	54	12625	ATAHUALPA	\N
147	54	12626	COLOMBIA	\N
147	54	12627	EL CERRITO	\N
147	54	12628	EL PALMAR	\N
147	54	12629	EL PALOMAR	\N
147	54	12630	FIERRO	\N
147	54	12631	LA FIRMEZA	\N
147	54	12632	LA VIRTUD	\N
147	54	12633	MONTE QUEMADO	\N
147	54	12634	NUEVA ESPERANZA	\N
147	54	12635	OBRAJE LOS TIGRES	\N
147	54	12636	PAAJ POZO	\N
147	54	12637	SAN VICENTE	\N
147	54	12638	SANTA ROSA	\N
147	54	12639	URUTAU	\N
147	54	12640	CAMPO DEL AGUILA	\N
147	54	12641	CHAINIMA	\N
147	54	12642	DOS VARONES	\N
147	54	12643	EL CORRIDO	\N
147	54	12644	EL VALLE	\N
147	54	12645	EL VALLE DE ORIENTE	\N
147	54	12646	LA DEFENSA	\N
147	54	12647	LA ESPERANZA	\N
147	54	12648	VINAL POZO	\N
147	54	12649	MANGA BAJADA	\N
147	54	12650	RIO MUERTO	\N
147	54	12651	SAN JOSE DEL BOQUERON	\N
147	54	12652	VINAL VIEJO	\N
147	54	12653	BOTIJA	\N
147	54	12654	CRUZ BAJADA	\N
147	54	12655	DOS ARBOLES	\N
147	54	12656	GUAYACAN	\N
147	54	12657	LOS COLORADOS	\N
147	54	12658	MISTOLITO	\N
147	54	12659	PICOS DE AMOR	\N
147	54	12660	PICOS DE ARROZ	\N
147	54	12661	PLATERO	\N
147	54	12662	TACIOJ	\N
147	54	12663	TACO ESQUINA	\N
147	54	12664	VILLA MATOQUE	\N
147	54	12665	VINAL MACHO	\N
147	54	12666	VINALITO	\N
147	54	12667	BAJO HONDO	\N
147	54	12668	SUNCHO PUJIO	\N
147	54	12669	VILLA MERCEDES	\N
147	54	12670	ALTO BELLO	\N
147	54	12671	TAPSO	\N
147	54	12672	CHAÑAR POZO	\N
147	54	12673	EL TALA	\N
147	54	12674	FAROL	\N
147	54	12675	FAVORINA	\N
147	54	12676	GUARDIA DEL NORTE	\N
147	54	12677	ICHAGON	\N
147	54	12678	LA PUNTA	\N
147	54	12679	MAQUIJATA	\N
147	54	12680	MATE PAMPA	\N
147	54	12681	PUERTA DEL CIELO	\N
147	54	12682	RODEO	\N
147	54	12683	SAN JUSTO	\N
147	54	12684	SAYACO	\N
147	54	12685	SINCHI CAÑA	\N
147	54	12686	SOL DE MAYO	\N
147	54	12687	YESO ALTO	\N
147	54	12688	ARBOL SOLO	\N
147	54	12689	CHAVES	\N
147	54	12690	EL NERIO	\N
147	54	12691	LA CORTADERA	\N
147	54	12692	LA POLVAREDA	\N
147	54	12693	LA PROVIDENCIA	\N
147	54	12694	LAPRIDA	\N
147	54	12695	LOS RALOS	\N
147	54	12696	SAN MANUEL	\N
147	54	12697	SAN PASTOR	\N
147	54	12698	SHISHI POZO	\N
147	54	12699	VILLA ELVIRA	\N
147	54	12700	BARRIO JARDIN	\N
147	54	12701	FRIAS	\N
147	54	12702	GUATANA	\N
147	54	12703	LA LAGUNA	\N
147	54	12704	POZO DE LA PUERTA	\N
147	54	12705	PUERTA DE LAS PIEDRAS	\N
147	54	12706	VILLA COINOR	\N
147	54	12707	CERRO RICO	\N
147	54	12708	EL SALVADOR	\N
147	54	12709	ANCAJAN	\N
147	54	12710	CHOYA	\N
147	54	12711	LA REPRESA	\N
147	54	12712	MOJONCITO	\N
147	54	12713	SAN JUAN	\N
147	54	12714	SAN JUANCITO	\N
147	54	12715	SAN PEDRO DE CHOYA	\N
147	54	12716	RUMI ESQUINA	\N
147	54	12717	BALDE POZO	\N
147	54	12718	CHILLIMO	\N
147	54	12719	LAS PEÑAS	\N
147	54	12720	MENDOZA	\N
147	54	12721	ZORRO HUARCUNA	\N
147	54	12722	POZANCON	\N
147	54	12723	PROVIDENCIA	\N
147	54	12724	LA GUARDIA	\N
147	54	12725	EL CHAÑAR (RECREO)	\N
147	54	12726	VEINTICINCO DE MAYO DE BARNEGAS	\N
147	54	12727	PARANA (QUIROS)	\N
147	54	12728	LA VICTORIA	\N
147	54	12729	LA ESPERANZA	\N
147	54	12730	LA PAMPA	\N
147	54	12731	LA SIMONA	\N
147	54	12732	BANDERA BAJADA	\N
147	54	12733	CASPI CORRAL	\N
147	54	12734	DIQUE FIGUEROA	\N
147	54	12735	EL QUEMADO	\N
147	54	12736	MONTE REDONDO	\N
147	54	12737	POZO DEL CASTAÑO	\N
147	54	12738	SAN PABLO	\N
147	54	12739	VACA HUAÑUNA	\N
147	54	12740	AIBAL	\N
147	54	12741	BELLA VISTA	\N
147	54	12742	CAÑADA LIMPIA	\N
147	54	12743	COLONIA SAN JUAN	\N
147	54	12744	DOLORES	\N
147	54	12745	EL CRUCERO	\N
147	54	12746	EL NEGRITO	\N
147	54	12747	JUMIAL GRANDE	\N
147	54	12748	LA INVERNADA	\N
147	54	12749	QUIMILIOJ	\N
147	54	12750	TRINIDAD	\N
147	54	12751	TUSCA POZO	\N
147	54	12752	VILLA FIGUEROA	\N
147	54	12753	YACU HICHACUNA	\N
147	54	12754	ARBOLITOS (LA TAPA)	\N
147	54	12755	LA CAÑADA	\N
147	54	12756	CUATRO BOCAS	\N
147	54	12757	SANAVIRONES	\N
147	54	12758	AÑATUYA	\N
147	54	12759	BARRIO VILLA FERNANDEZ	\N
147	54	12760	BINAL ESQUINA	\N
147	54	12761	CORONEL BARROS	\N
147	54	12762	EL MATACO	\N
147	54	12763	LA ENCALADA	\N
147	54	12764	LA ESTANCIA	\N
147	54	12765	PUNI TAJO	\N
147	54	12766	VEINTIOCHO DE MARZO	\N
147	54	12767	VILLA ABREGU	\N
147	54	12768	EL MALACARA	\N
147	54	12769	LOS LINARES	\N
147	54	12770	LA SIMONA	\N
147	54	12771	LOS JURIES	\N
147	54	12772	OBRAJE MAILIN	\N
147	54	12773	TRES POZOS	\N
147	54	12774	LA BALANZA	\N
147	54	12775	LA NENA	\N
147	54	12776	LOTE 15	\N
147	54	12777	TOMAS YOUNG	\N
147	54	12778	AVERIAS	\N
147	54	12779	LOS POCITOS	\N
147	54	12780	TACAÑITAS	\N
147	54	12781	POCITOS	\N
147	54	12782	ARROYO TALA	\N
147	54	12783	CABRA	\N
147	54	12784	CERRILLOS	\N
147	54	12785	CONZO	\N
147	54	12786	FAMATINA	\N
147	54	12787	GUAMPACHA	\N
147	54	12788	LA ENSENADA	\N
147	54	12789	PUERTA CHIQUITA	\N
147	54	12790	SANTA CATALINA	\N
147	54	12791	SANTOS LUGARES	\N
147	54	12792	VILLA LA PUNTA	\N
147	54	12793	DOÑA LUISA	\N
147	54	12794	MISTOL MUYOJ	\N
147	54	12795	POZO HUASCHO	\N
147	54	12796	QUEBRACHOS	\N
147	54	12797	EL QUILLIN	\N
147	54	12798	LAS FLORES	\N
147	54	12799	LAVALLE	\N
147	54	12800	MANGRULLO	\N
147	54	12801	SAN ANTONIO	\N
147	54	12802	TONZU	\N
147	54	12803	TRES CERROS	\N
147	54	12804	ABRA DE QUIMIL	\N
147	54	12805	AGUJEREADO	\N
147	54	12806	AHI VEREMOS	\N
147	54	12807	CODILLO	\N
147	54	12808	EL CADILLO	\N
147	54	12809	EL SIMBOLAR	\N
147	54	12810	GUASAYAN	\N
147	54	12811	ILIAGES	\N
147	54	12812	LAS JUNTAS	\N
147	54	12813	LAS MARAVILLAS	\N
147	54	12814	LAS TALITAS	\N
147	54	12815	LOMA DE YESO	\N
147	54	12816	LOS COBRES	\N
147	54	12817	LOS CORREAS	\N
147	54	12818	MEDIO MUNDO	\N
147	54	12819	MORON	\N
147	54	12820	SAN PEDRO	\N
147	54	12821	TABLEADO	\N
147	54	12822	TIBILAR	\N
147	54	12823	VILLA GUASAYAN	\N
147	54	12824	VILLARES	\N
147	54	12825	EL FISCO	\N
147	54	12826	ANIMAS	\N
147	54	12827	DON BARTOLO	\N
147	54	12828	EL MOLAR	\N
147	54	12829	EL PARANA	\N
147	54	12830	GASPAR SUAREZ	\N
147	54	12831	HUMAITA	\N
147	54	12832	ISCA YACU	\N
147	54	12833	POZO HONDO	\N
147	54	12834	POZO LERDO	\N
147	54	12835	POZO LINDO	\N
147	54	12836	TENENE	\N
147	54	12837	TRES FLORES	\N
147	54	12838	TUSCA POZO	\N
147	54	12839	UCLAR	\N
147	54	12840	UTRUNJOS	\N
147	54	12841	VITEACA	\N
147	54	12842	EL PALOMAR	\N
147	54	12843	ARENALES	\N
147	54	12844	BOBADAL	\N
147	54	12845	EL CHURQUI	\N
147	54	12846	GRAMILLA	\N
147	54	12847	LA FORTUNA	\N
147	54	12848	CACHICO	\N
147	54	12849	EL CHARCO	\N
147	54	12850	EL GUAYACAN	\N
147	54	12851	TRES CRUCES	\N
147	54	12852	LEDESMA	\N
147	54	12853	CAMPO DEL CIELO	\N
147	54	12854	EL COLORADO	\N
147	54	12855	NASALO	\N
147	54	12856	TOBAS	\N
147	54	12857	VILELAS	\N
147	54	12858	EL CUADRADO	\N
147	54	12859	EL SALADILLO	\N
147	54	12860	DOLORES	\N
147	54	12861	DOS HERMANOS	\N
147	54	12862	EL QUEMADO	\N
147	54	12863	EL SAUCE	\N
147	54	12864	GUAYPE	\N
147	54	12865	IUCHAN	\N
147	54	12866	JUMI POZO	\N
147	54	12867	KM 546 (APEADERO FCGB)	\N
147	54	12868	LA REDUCCION	\N
147	54	12869	LASPA	\N
147	54	12870	LAURELES	\N
147	54	12871	NUEVA GRANADA	\N
147	54	12872	PADUA	\N
147	54	12873	PALERMO	\N
147	54	12874	PAMPA POZO	\N
147	54	12875	POZO GRANDE	\N
147	54	12876	PUNCO	\N
147	54	12877	SAN CARLOS	\N
147	54	12878	SUNCHO CORRAL	\N
147	54	12879	HURITU HUASI	\N
147	54	12880	LLAJTA MAUCA	\N
147	54	12881	MATARA	\N
147	54	12882	MELERO	\N
147	54	12883	TIUN PUNCO	\N
147	54	12884	VILLA MATARA	\N
147	54	12885	BELTRAN	\N
147	54	12886	CHUÑA ALBARDON	\N
147	54	12887	DIENTE DEL ARADO	\N
147	54	12888	DORMIDA	\N
147	54	12889	EL MULATO	\N
147	54	12890	EL PINTO	\N
147	54	12891	JUMI POZO	\N
147	54	12892	LA NORIA	\N
147	54	12893	LA REVANCHA	\N
147	54	12894	LOMITAS	\N
147	54	12895	LORETO	\N
147	54	12896	MORAMPA	\N
147	54	12897	POZO CIEGO	\N
147	54	12898	PUESTO DE JUANES	\N
147	54	12899	RAMADITA	\N
147	54	12900	SAN JERONIMO	\N
147	54	12901	SANDIA HUAJCHU	\N
147	54	12902	SANTA BARBARA	\N
147	54	12903	SANTA BARBARA FERREIRA	\N
147	54	12904	SAUCE SOLO	\N
147	54	12905	TACANITAS	\N
147	54	12906	TALA ATUN	\N
147	54	12907	TAQUETUYOJ	\N
147	54	12908	TONTOLA	\N
147	54	12909	TORO CHARQUINA	\N
147	54	12910	TOTORA PAMPA	\N
147	54	12911	TOTORAS	\N
147	54	12912	TUSCA POZO	\N
147	54	12913	TUSCAJOJ	\N
147	54	12914	VILLA SAN MARTIN	\N
147	54	12915	YALAN	\N
147	54	12916	YOLOHUASI	\N
147	54	12917	YULU HUASI	\N
147	54	12918	MONTE REDONDO	\N
147	54	12919	SAN VICENTE	\N
147	54	12920	CHARQUINA	\N
147	54	12921	COLLERA HURCUNA	\N
147	54	12922	PIRUITAS	\N
147	54	12923	TIO POZO	\N
147	54	12924	LA RECOMPENSA	\N
147	54	12925	LAS VIBORITAS	\N
147	54	12926	ARBOL DEL NEGRO	\N
147	54	12927	PUEBLO GENERAL MITRE	\N
147	54	12928	SANTA PAULA	\N
147	54	12929	VILLA GRAL. MITRE	\N
147	54	12930	EL HUAICO	\N
147	54	12931	LAS ABRAS	\N
147	54	12932	MARTINEZ	\N
147	54	12933	RETIRO	\N
147	54	12934	UNION	\N
147	54	12935	VILLA UNION	\N
147	54	12936	ALBARDON	\N
147	54	12937	LIMACHE	\N
147	54	12938	LA CAROLINA	\N
147	54	12939	ARBOL BLANCO	\N
147	54	12940	EL ARBOLITO	\N
147	54	12941	AGUA SALADA	\N
147	54	12942	CALDERON	\N
147	54	12943	CAMPO DEL INFIERNO	\N
147	54	12944	CAMPO EL ROSARIO	\N
147	54	12945	DOS REPRESAS	\N
147	54	12946	EL URUNDAY	\N
147	54	12947	EL VEINTE	\N
147	54	12948	ESTANCIA NUEVA ESPERANZA	\N
147	54	12949	GIRARDET	\N
147	54	12950	LA PALOMA	\N
147	54	12951	ROVERSI	\N
147	54	12952	TACO FURA	\N
147	54	12953	BARRIO OBRERO	\N
147	54	12954	CEJOLAO	\N
147	54	12955	JARDIN DE LAS DELICIAS	\N
147	54	12956	LOS PENSAMIENTOS	\N
147	54	12957	QUIMILI	\N
147	54	12958	AEROLITO	\N
147	54	12959	ALHUAMPA	\N
147	54	12960	EL TANQUE	\N
147	54	12961	GENOVEVA	\N
147	54	12962	GRANADERO GATICA	\N
147	54	12963	HAASE	\N
147	54	12964	HERNAN MEJIA MIRAVAL	\N
147	54	12965	LA CURVA	\N
147	54	12966	LA MARTA	\N
147	54	12967	LOS GATOS	\N
147	54	12968	LOS MILAGROS	\N
147	54	12969	MAGDALENA	\N
147	54	12970	MORAYOS	\N
147	54	12971	OCTAVIA	\N
147	54	12972	OTUMPA (PABLO TORELO)	\N
147	54	12973	PAMPA POZO	\N
147	54	12974	POZO DEL TOBA	\N
147	54	12975	SAN ALBERTO	\N
147	54	12976	SAN MIGUEL	\N
147	54	12977	SANTA ELENA	\N
147	54	12978	EL PRADO	\N
147	54	12979	EL VEINTISIETE	\N
147	54	12980	LA PAMPA	\N
147	54	12981	MILAGRO	\N
147	54	12982	TINTINA	\N
147	54	12983	EL HOYO	\N
147	54	12984	LIBERTAD	\N
147	54	12985	LILO VIEJO	\N
147	54	12986	PATAY	\N
147	54	12987	POZO CASTAÑO	\N
147	54	12988	QUILUMPA	\N
147	54	12989	LINCHO	\N
147	54	12990	EL PERTIGO	\N
147	54	12991	FLORESTA	\N
147	54	12992	HUACANITAS	\N
147	54	12993	KISKA LORO	\N
147	54	12994	LA POTOCHA	\N
147	54	12995	LAS TINAJAS	\N
147	54	12996	LOTE S	\N
147	54	12997	PUNTA DE RIELES	\N
147	54	12998	SEGUNDO POZO	\N
147	54	12999	STAYLE	\N
147	54	13000	TABEANITA	\N
147	54	13001	VILLA BRANA	\N
147	54	13002	VILLA FANNY	\N
147	54	13003	WEISBURD	\N
147	54	13004	ALZA NUEVA	\N
147	54	13005	AMAMA	\N
147	54	13006	ARMONIA	\N
147	54	13007	CARTAVIO	\N
147	54	13008	CELESTINA	\N
147	54	13009	COLONIA MEDIA	\N
147	54	13010	DOLORES CENTRAL	\N
147	54	13011	DOS HERMANAS	\N
147	54	13012	EL AIBALITO	\N
147	54	13013	EL BRAGADO	\N
147	54	13014	EL DESCANSO	\N
147	54	13015	JUNCAL GRANDE	\N
147	54	13016	LOS PUENTES	\N
147	54	13017	MINERVA	\N
147	54	13018	NOGALES	\N
147	54	13019	NUEVA ALZA	\N
147	54	13020	PACIENCIA	\N
147	54	13021	PUESTO DE MENA	\N
147	54	13022	UTURUNCO	\N
147	54	13023	LA ESMERALDA	\N
147	54	13024	EL BARRIAL	\N
147	54	13025	PUERTA DE LOS RIOS	\N
147	54	13026	AMIMAN	\N
147	54	13027	ANTUCO	\N
147	54	13028	BALBUENA	\N
147	54	13029	CALERAS	\N
147	54	13030	CANTAMAMPA	\N
147	54	13031	CARANCHI YACO	\N
147	54	13032	CARRERA VIEJA	\N
147	54	13033	CORTADERAS	\N
147	54	13034	EL CACHI	\N
147	54	13035	EL DIVISADERO	\N
147	54	13036	EL JUME	\N
147	54	13037	EL SEGUNDO	\N
147	54	13038	ESPINILLO	\N
147	54	13039	FIVIALTOS	\N
147	54	13040	JUME	\N
147	54	13041	LA PRIMAVERA	\N
147	54	13042	LA RINCONADA	\N
147	54	13043	LA TOTORILLA	\N
147	54	13044	LAS HORQUETAS	\N
147	54	13045	LESCANO	\N
147	54	13046	LLAMA PAMPA	\N
147	54	13047	LOMA COLORADA	\N
147	54	13048	LOS ALGARROBOS	\N
147	54	13049	LOS CHAÑARES	\N
147	54	13050	LOS POZOS	\N
147	54	13051	LOS SUNCHOS	\N
147	54	13052	MANFLOA	\N
147	54	13053	MOLLE POZO	\N
147	54	13054	VILLA OJO DE AGUA	\N
147	54	13055	PASO REDUCIDO	\N
147	54	13056	POZO DEL MACHO	\N
147	54	13057	POZO ESCONDIDO	\N
147	54	13058	POZO REDONDO	\N
147	54	13059	TACO MISQUI	\N
147	54	13060	TALA YACU	\N
147	54	13061	TIGRE MUERTO	\N
147	54	13062	AGUA CALIENTE	\N
147	54	13063	AGUADITA	\N
147	54	13064	ALGARROBO	\N
147	54	13065	AMBARGASTA	\N
147	54	13066	ANCOCHE	\N
147	54	13067	CAJON	\N
147	54	13068	CHUCHI	\N
147	54	13069	CORRALITO	\N
147	54	13070	EL CERRO	\N
147	54	13071	GIBIALTO	\N
147	54	13072	GRAMILLAL	\N
147	54	13073	HILUMAMPA	\N
147	54	13074	HUASCAN	\N
147	54	13075	LA AGUADITA	\N
147	54	13076	LA CUESTA	\N
147	54	13077	LA PINTADA	\N
147	54	13078	LAS CIENAGAS	\N
147	54	13079	LAS PARVAS	\N
147	54	13080	LAS ROSAS	\N
147	54	13081	LOMITAS BLANCAS	\N
147	54	13082	NARANJITOS	\N
147	54	13083	ONCAN	\N
147	54	13084	PAMPA GRANDE	\N
147	54	13085	PORTEZUELO	\N
147	54	13086	POZO GRANDE	\N
147	54	13087	ROSADA	\N
147	54	13088	RUMI HUASI	\N
147	54	13089	SANTO DOMINGO CHICO	\N
147	54	13090	SANTO DOMINGO	\N
147	54	13091	YUMAMPA	\N
147	54	13092	AMOLADERAS	\N
147	54	13093	BAEZ	\N
147	54	13094	BUENA ESPERANZA	\N
147	54	13095	COLONIA MERCEDES	\N
147	54	13096	EL ALGARROBO	\N
147	54	13097	EL BORDITO	\N
147	54	13098	LA GRANA	\N
147	54	13099	LA GRANADA	\N
147	54	13100	LA SELVA	\N
147	54	13101	LAGUNITAS	\N
147	54	13102	LAS CRUCES	\N
147	54	13103	LOS CRUCES	\N
147	54	13104	POZO DEL ALGARROBO	\N
147	54	13105	POZO DEL GARABATO	\N
147	54	13106	PUESTO DE ARRIBA	\N
147	54	13107	PUNTA DEL AGUA	\N
147	54	13108	QUENTI TACO	\N
147	54	13109	SOL DE JULIO	\N
147	54	13110	NEGRA MUERTA	\N
147	54	13111	PIEDRA BLANCA	\N
147	54	13112	SAN JUAN	\N
147	54	13113	LA ARMONIA	\N
147	54	13114	EL DURAZNO	\N
147	54	13115	LA COSTOSA	\N
147	54	13116	MONTESINO	\N
147	54	13117	SESTEADERO	\N
147	54	13118	AGUA AZUL	\N
147	54	13119	COPO VIEJO	\N
147	54	13120	GUANACUYOJ	\N
147	54	13121	LA JULIANA	\N
147	54	13122	LA TALA	\N
147	54	13123	LAS LAJAS	\N
147	54	13124	LOS CERROS	\N
147	54	13125	LOS MOYAS	\N
147	54	13126	POZO BETBEDER	\N
147	54	13127	RAPELLI	\N
147	54	13128	SANTA MARIA DE LAS CHACRAS	\N
147	54	13129	TACO PUNCO	\N
147	54	13130	TRES VARONES	\N
147	54	13131	YUCHANCITO	\N
147	54	13132	EL REMATE	\N
147	54	13133	QUEBRACHO COTO	\N
147	54	13134	QUEMADITO	\N
147	54	13135	REMATE	\N
147	54	13136	AGUA AMARGA	\N
147	54	13137	AHI VEREMOS	\N
147	54	13138	ALGARROBAL VIEJO	\N
147	54	13139	BAGUAL MUERTO	\N
147	54	13140	BELGRANO	\N
147	54	13141	CORRAL QUEMADO	\N
147	54	13142	EL BALDECITO	\N
147	54	13143	EL DIABLO	\N
147	54	13144	EL MOJON	\N
147	54	13145	JUNALITO	\N
147	54	13146	LA FLORIDA	\N
147	54	13147	LA FRAGUA	\N
147	54	13148	LOMA GRANDE	\N
147	54	13149	LOMAS BLANCAS	\N
147	54	13150	MARAVILLA	\N
147	54	13151	MEDIA LUNA	\N
147	54	13152	NUEVA ESPERANZA	\N
147	54	13153	PUESTO DEL MEDIO	\N
147	54	13154	PUESTO DEL SIMBOL	\N
147	54	13155	QUEBRADA ESQUINA	\N
147	54	13156	SANSIOJ	\N
147	54	13157	SANTA FELISA	\N
147	54	13158	SIETE ARBOLES	\N
147	54	13159	SIMBOL HUASI	\N
147	54	13160	TACO BAJADA	\N
147	54	13161	TRES BAJOS	\N
147	54	13162	BABILONIA	\N
147	54	13163	CASA VERDE	\N
147	54	13164	ESTECO	\N
147	54	13165	HOYO CERCO	\N
147	54	13166	LA LOMADA	\N
147	54	13167	NUEVO SIMBOLAR	\N
147	54	13168	POTRERO BAJADA	\N
147	54	13169	POZO DEL SIMBOL	\N
147	54	13170	SANTO DOMINGO	\N
147	54	13171	SORIA BAJADA	\N
147	54	13172	LAS DELICIAS	\N
147	54	13173	SAN RAMON	\N
147	54	13174	YUCHAN	\N
147	54	13175	EL MISTOL	\N
147	54	13176	AMICHA	\N
147	54	13177	LOS QUEBRACHOS	\N
147	54	13178	EL NARANJO	\N
147	54	13179	HORCOS TUCUCUNA	\N
147	54	13180	VILLA QUEBRACHOS	\N
147	54	13181	ARBOL SOLO	\N
147	54	13182	BELGRANO	\N
147	54	13183	SUMAMPA	\N
147	54	13184	CASA DE DIOS	\N
147	54	13185	COSTA VIEJA	\N
147	54	13186	EL MOLLE	\N
147	54	13187	KENTI TACKO	\N
147	54	13188	LA BELLA CRIOLLA	\N
147	54	13189	LA COLINA	\N
147	54	13190	LA PORFIA	\N
147	54	13191	MEDANOS	\N
147	54	13192	PAJARO BLANCO	\N
147	54	13193	RIO VIEJO	\N
147	54	13194	SAN MATEO	\N
147	54	13195	SIEMPRE VERDE	\N
147	54	13196	TACO PALTA	\N
147	54	13197	TENTI TACO	\N
147	54	13198	TRONCO QUEMADO	\N
147	54	13199	CORONEL FERNANDEZ	\N
147	54	13200	CUCHI CORRAL	\N
147	54	13201	LAS ISLAS	\N
147	54	13202	TACO POZO	\N
147	54	13203	EL PUEBLITO	\N
147	54	13204	INGENIERO CARLOS CHRISTIERNSON	\N
147	54	13205	RAMIREZ DE VELAZCO	\N
147	54	13206	LA RECONQUISTA	\N
147	54	13207	PALMA LARGA	\N
147	54	13208	POZO DEL ARBOLITO	\N
147	54	13209	EL BAGUAL	\N
147	54	13210	EL PACARA	\N
147	54	13211	CHAUCHILLAS	\N
147	54	13212	EL PERAL	\N
147	54	13213	HOYO CON AGUA	\N
147	54	13214	LA GRAMA	\N
147	54	13215	VILLA JIMENEZ	\N
147	54	13216	ANJULI	\N
147	54	13217	BAHOMA	\N
147	54	13218	EL MANANTIAL	\N
147	54	13219	ESPINAL	\N
147	54	13220	ESTANCIA VIEJA	\N
147	54	13221	GALEANO	\N
147	54	13222	ISLA DE LOS CASTILLOS	\N
147	54	13223	LA AGUADA	\N
147	54	13224	LORO HUASI	\N
147	54	13225	LOS FIERROS	\N
147	54	13226	MANANTIALES	\N
147	54	13227	MANSUPA	\N
147	54	13228	TACAMAMPA	\N
147	54	13229	TERMAS DE RIO HONDO	\N
147	54	13230	VILLA BALNEARIA	\N
147	54	13231	LA DONOSA	\N
147	54	13232	LAS CEJAS	\N
147	54	13233	LOS DECIMAS	\N
147	54	13234	PEREZ DE ZURITA	\N
147	54	13235	TINCO	\N
147	54	13236	YUTO YACA	\N
147	54	13237	YUTU YACO	\N
147	54	13238	AMAPOLA	\N
147	54	13239	BAJO VERDE	\N
147	54	13240	CAÑADA TALA POZO	\N
147	54	13241	LOMA DEL MEDIO	\N
147	54	13242	PALMA REDONDA	\N
147	54	13243	PUESTO DEL RETIRO	\N
147	54	13244	TAQUELLO	\N
147	54	13245	VINARA	\N
147	54	13246	ABRA DE LA CRUZ	\N
147	54	13247	ABRAS DEL MARTIRIZADO	\N
147	54	13248	ALPA PUCA	\N
147	54	13249	BARRIALITO	\N
147	54	13250	BAUMAN	\N
147	54	13251	BEBIDAS	\N
147	54	13252	CHAÑAR POCITO	\N
147	54	13253	CHAÑAR POZO	\N
147	54	13254	PATILLO	\N
147	54	13255	PUESTO DE VIEYRA	\N
147	54	13256	QUERA	\N
147	54	13257	SAN COSME	\N
147	54	13258	VILLA RIO HONDO	\N
147	54	13259	ALGARROBALES	\N
147	54	13260	CHAÑAR POZO	\N
147	54	13261	ISLA DE LOS SOTELOS	\N
147	54	13262	SOTELILLOS	\N
147	54	13263	CASHICO	\N
147	54	13264	CHARCO VIEJO	\N
147	54	13265	POZUELOS	\N
147	54	13266	NUEVA CERES	\N
147	54	13267	CLAVEL BLANCO	\N
147	54	13268	COLONIA ALPINA	\N
147	54	13269	COLONIA GERALDINA	\N
147	54	13270	LA GERALDINA	\N
147	54	13271	LOS PORONGOS	\N
147	54	13272	COLONIA LA VICTORIA	\N
147	54	13273	EL CHARABON	\N
147	54	13274	LA ROMELIA	\N
147	54	13275	LA UNION	\N
147	54	13276	LOS ENCANTOS	\N
147	54	13277	PALO NEGRO	\N
147	54	13278	SAN JOSE	\N
147	54	13279	SELVA	\N
147	54	13280	LA ISLETA	\N
147	54	13281	VIZCACHERAL	\N
147	54	13282	AGUAS COLORADAS	\N
147	54	13283	AREAS	\N
147	54	13284	DIQUE CHICO	\N
147	54	13285	LA RIVERA	\N
147	54	13286	LOS ARIAS	\N
147	54	13287	LOS PEREYRA	\N
147	54	13288	POZO LIMPIO	\N
147	54	13289	QUEBRACHO YACU	\N
147	54	13290	SANTO DOMINGO ROBLES	\N
147	54	13291	TABLADA DEL BOQUERON	\N
147	54	13292	TUSCA BAJADA	\N
147	54	13293	VILLA HIPOLITA	\N
147	54	13294	VILLA ROBLES	\N
147	54	13295	ACOSTA	\N
147	54	13296	BANEGAS	\N
147	54	13297	EL CEBOLLIN	\N
147	54	13298	EL CERCADO	\N
147	54	13299	GUAYCURU	\N
147	54	13300	ROMANOS	\N
147	54	13301	SARMIENTO	\N
147	54	13302	TURENA	\N
147	54	13303	VILMER	\N
147	54	13304	CASILLA DEL MEDIO	\N
147	54	13305	BELTRAN	\N
147	54	13306	BUEY MUERTO	\N
147	54	13307	HIGUERA CHAQUI	\N
147	54	13308	JANTA	\N
147	54	13309	MIRCA	\N
147	54	13310	MORCILLO	\N
147	54	13311	SAN GUILLERMO	\N
147	54	13312	SAN PASCUAL	\N
147	54	13313	SANTA INES	\N
147	54	13314	TACO PUJIO	\N
147	54	13315	TRAMO VEINTISEIS	\N
147	54	13316	TUSCA POZO	\N
147	54	13317	YANTA	\N
147	54	13318	ING. FORRES	\N
147	54	13319	MORELLO	\N
147	54	13320	ROBLES	\N
147	54	13321	ASPA SINCHI	\N
147	54	13322	CHAGUAR PUNCU	\N
147	54	13323	FERNANDEZ	\N
147	54	13324	INDUSTRIA NUEVA	\N
147	54	13325	JIMENEZ	\N
147	54	13326	LOMITAS	\N
147	54	13327	MARIA DELICIA	\N
147	54	13328	NUEVA INDUSTRIA	\N
147	54	13329	YASO	\N
147	54	13330	CAVADITO	\N
147	54	13331	CAVADO	\N
147	54	13332	COLONIA EL SIMBOLAR	\N
147	54	13333	EL VIZCACHERAL	\N
147	54	13334	JUME ESQUINA	\N
147	54	13335	LA BOTA	\N
147	54	13336	LA BREA	\N
147	54	13337	LA PRIMITIVA	\N
147	54	13338	LA RAMADA	\N
147	54	13339	MADERAS	\N
147	54	13340	SAN SALVADOR	\N
147	54	13341	SEPULTURAS	\N
147	54	13342	TRANCAS	\N
147	54	13343	CHAÑAR SUNICHAJ	\N
147	54	13344	CAPILLA	\N
147	54	13345	CHILE	\N
147	54	13346	BARRANCAS	\N
147	54	13347	CHILCA JULIANA	\N
147	54	13348	CHILENO	\N
147	54	13349	GUERRA	\N
147	54	13350	LECHUZAS	\N
147	54	13351	MISTOL POZO	\N
147	54	13352	PERALTA	\N
147	54	13353	PUENTE DEL SALADILLO	\N
147	54	13354	SABAGASTA	\N
147	54	13355	SALADILLO	\N
147	54	13356	SALAVINA	\N
147	54	13357	TAGAN	\N
147	54	13358	TIO ALTO	\N
147	54	13359	TOLOZAS	\N
147	54	13360	TOROPAN	\N
147	54	13361	VACA HUMAN	\N
147	54	13362	VARAS CUCHUNA	\N
147	54	13363	VERON	\N
147	54	13364	ANGA	\N
147	54	13365	BORDO PAMPA	\N
147	54	13366	CERRILLOS	\N
147	54	13367	CHIRA	\N
147	54	13368	EL CINCUENTA	\N
147	54	13369	HUTCU CHACRA	\N
147	54	13370	LOS TELARES	\N
147	54	13371	MALOTA	\N
147	54	13372	PASO DEL SALADILLO	\N
147	54	13373	SAN FERNANDO	\N
147	54	13374	TACO ISLA	\N
147	54	13375	TRONCAL	\N
147	54	13376	RUBIA PASO	\N
147	54	13377	YACU HURMANA	\N
147	54	13378	LA GRITERIA	\N
147	54	13379	NAVARRO	\N
147	54	13380	ORATORIO	\N
147	54	13381	PALO A PIQUE	\N
147	54	13382	PASO DE OSCARES	\N
147	54	13383	RAMA PASO	\N
147	54	13384	LA HIGUERA	\N
147	54	13385	ASPA SINCHI	\N
147	54	13386	ESTACION ROBLES	\N
147	54	13387	ATOJ POZO	\N
147	54	13388	BARRANCA COLORADA	\N
147	54	13389	BREA POZO	\N
147	54	13390	BREA POZO VIEJO	\N
147	54	13391	CHIMPA MACHO	\N
147	54	13392	COLONIA PINTO	\N
147	54	13393	EL PUENTE	\N
147	54	13394	LOS GALLEGOS	\N
147	54	13395	LA BLANCA	\N
147	54	13396	LAGUNA BLANCA	\N
147	54	13397	LINTON	\N
147	54	13398	MAJADAS	\N
147	54	13399	PAMPA ATUN	\N
147	54	13400	TALA POZO	\N
147	54	13401	TRES JAZMINES	\N
147	54	13402	TULUN	\N
147	54	13403	VILLA ELENA	\N
147	54	13404	VILLA NUEVA	\N
147	54	13405	DIASPA	\N
147	54	13406	ESTACION TABOADA	\N
147	54	13407	SUNCHO POZO	\N
147	54	13408	LA VERDE	\N
147	54	13409	CAZADORES	\N
147	54	13410	CONCEPCION	\N
147	54	13411	CORASPINO	\N
147	54	13412	EL EMPACHADO	\N
147	54	13413	EL JUNCAL	\N
147	54	13414	GARZA	\N
147	54	13415	GUAIPI	\N
147	54	13416	LA OVERA	\N
147	54	13417	LAPA	\N
147	54	13418	NUEVE MISTOLES	\N
147	54	13419	POZO MORO	\N
147	54	13420	POZO MOSOJ	\N
147	54	13421	QUIMILLOJ	\N
147	54	13422	ROSIYULLOJ	\N
147	54	13423	SAN MARCOS	\N
147	54	13424	TACO HUACO	\N
147	54	13425	TACO SUYO	\N
147	54	13426	YACANO	\N
147	54	13427	VILLA ISLA	\N
147	54	13428	PUESTO DEL MEDIO	\N
147	54	13429	MANOGASTA	\N
147	54	13430	MORALES	\N
147	54	13431	OVEJEROS	\N
147	54	13432	SUMAMAO	\N
147	54	13433	TORO HUMAN	\N
147	54	13434	ARRAGA	\N
147	54	13435	BUEY RODEO	\N
147	54	13436	CAMPO ALEGRE	\N
147	54	13437	CAMPO NUEVO	\N
147	54	13438	CHAÑAR PUJIO	\N
147	54	13439	EL MARNE	\N
147	54	13440	LA ABRITA	\N
147	54	13441	LA HIGUERA	\N
147	54	13442	LA SARITA	\N
147	54	13443	MONTE RICO	\N
147	54	13444	NUEVA FRANCIA	\N
147	54	13445	PUESTITO DE SAN ANTONIO	\N
147	54	13446	SAN AGUSTIN	\N
147	54	13447	SAN ANDRES	\N
147	54	13448	SAN SEBASTIAN	\N
147	54	13449	SAN VICENTE	\N
147	54	13450	SILIPICA	\N
147	54	13451	TROZO POZO	\N
148	54	13452	AGUA NEGRA	\N
148	54	13453	ALTA GRACIA BURRUYACU	\N
148	54	13454	CAÑADA HONDA	\N
148	54	13455	COLONIA LOS HILLS	\N
148	54	13456	COLONIA SAN RAMON	\N
148	54	13457	COLONIA SARMIENTO	\N
148	54	13458	CUCHILLAS	\N
148	54	13459	EL MUTUL	\N
148	54	13460	EL TIMBO	\N
148	54	13461	LOS HILOS	\N
148	54	13462	MATUL	\N
148	54	13463	MEDINA	\N
148	54	13464	NIO	\N
148	54	13465	NOGALITO	\N
148	54	13466	NUEVA ROSA	\N
148	54	13467	OVEJERIA	\N
148	54	13468	PUERTA VIEJA	\N
148	54	13469	SUNCHAL	\N
148	54	13470	TIMBO NUEVO	\N
148	54	13471	TIMBO VIEJO	\N
148	54	13472	TRANQUITAS	\N
148	54	13473	TRES SARGENTOS	\N
148	54	13474	VACAHUASI	\N
148	54	13475	VILLA DE LOS BRITOS	\N
148	54	13476	VILLA PADRE MONTI	\N
148	54	13477	VILLA ROSA	\N
148	54	13478	VILLA COLMENA	\N
148	54	13479	EL CHAÑAR	\N
148	54	13480	EL ESPINILLO	\N
148	54	13481	EL NARANJO	\N
148	54	13482	MACOMITA	\N
148	54	13483	MARIÑO	\N
148	54	13484	PALTA	\N
148	54	13485	SAN JOSE DE MACOMITA	\N
148	54	13486	SANTA TERESA	\N
148	54	13487	TAQUELLO	\N
148	54	13488	ANTILLAS	\N
148	54	13489	BENJAMIN ARAOZ	\N
148	54	13490	BURRUYACU	\N
148	54	13491	CHILCAS	\N
148	54	13492	CHURQUI	\N
148	54	13493	COSSIO	\N
148	54	13494	EL BARCO	\N
148	54	13495	EL CAJON	\N
148	54	13496	EL PUESTITO	\N
148	54	13497	EL TAJAMAR	\N
148	54	13498	EL ZAPALLAR	\N
148	54	13499	JAGUEL	\N
148	54	13500	LA ARGENTINA	\N
148	54	13501	LA CAÑADA	\N
148	54	13502	LA RAMADA	\N
148	54	13503	LA RAMADA DE ABAJO	\N
148	54	13504	LAGUNA DE ROBLES	\N
148	54	13505	LAS PECHOSAS	\N
148	54	13506	LOS CHORRILLOS	\N
148	54	13507	LOS GONZALES	\N
148	54	13508	PACARA MARCADO	\N
148	54	13509	POZO DEL ALGARROBO	\N
148	54	13510	PUESTO DE UNCOS	\N
148	54	13511	REQUELME	\N
148	54	13512	RIO DEL NIO	\N
148	54	13513	RODEO TORO	\N
148	54	13514	SAN EUSEBIO	\N
148	54	13515	SAN PATRICIO	\N
148	54	13516	TALA POZO	\N
148	54	13517	TARUCA PAMPA	\N
148	54	13518	OBRAJE	\N
148	54	13519	PUESTO DE LOS VALDES	\N
148	54	13520	LA TRINIDAD	\N
148	54	13521	EL JARDIN	\N
148	54	13522	SAN IGNACIO	\N
148	54	13523	SAN CARLOS	\N
148	54	13524	TUSCAL REDONDO	\N
148	54	13525	VIRGINIA	\N
148	54	13526	ANTA CHICA	\N
148	54	13527	CEJA POZO	\N
148	54	13528	EL BACHI	\N
148	54	13529	EL PUESTO DEL MEDIO	\N
148	54	13530	GOBERNADOR GARMENDIA	\N
148	54	13531	GOBERNADOR PIEDRABUENA	\N
148	54	13532	LUJAN	\N
148	54	13533	MONTE CRISTO	\N
148	54	13534	PAJA COLORADA	\N
148	54	13535	PASO DE LA PATRIA	\N
148	54	13536	PUERTA ALEGRE	\N
148	54	13537	ROSARIO	\N
148	54	13538	SAN ARTURO	\N
148	54	13539	SAN FEDERICO	\N
148	54	13540	SAN PEDRO (GDOR. PIEDRABUENA)	\N
148	54	13541	TINAJEROS	\N
148	54	13542	URIZAR	\N
148	54	13543	UTURUNO	\N
148	54	13544	VILLA EL BACHE	\N
148	54	13545	VILLA EL RETIRO	\N
148	54	13546	VILLA LA SOLEDAD	\N
148	54	13547	VILLA LA TUNA	\N
148	54	13548	VILLA MARIA	\N
148	54	13549	VILLA MERCEDES	\N
148	54	13550	MONTECRISTO	\N
148	54	13551	VILLA SAN ANTONIO	\N
148	54	13552	LA FLORIDA	\N
148	54	13553	LAS COLAS	\N
148	54	13554	POZO GRANDE	\N
148	54	13555	POZO LARGO	\N
148	54	13556	SIETE DE ABRIL	\N
148	54	13557	TALA BAJADA	\N
148	54	13558	PAMPA POZO	\N
148	54	13559	BANDA DEL RIO SALI	\N
148	54	13560	INGENIO CONCEPCION	\N
148	54	13561	INGENIO SAN JUAN	\N
148	54	13562	LOS VALLISTOS	\N
148	54	13563	PUENTE RIO SALI	\N
148	54	13564	CARBON POZO	\N
148	54	13565	COLOMBRES	\N
148	54	13566	EL BRACHO	\N
148	54	13567	EL CEVILAR	\N
148	54	13568	FINCA ELISA	\N
148	54	13569	INGENIO CRUZ ALTA	\N
148	54	13570	LASTENIA	\N
148	54	13571	LOS BULACIOS	\N
148	54	13572	LOS PORCELES	\N
148	54	13573	LOS VILLAGRA	\N
148	54	13574	PACARA	\N
148	54	13575	PACARA PINTADO	\N
148	54	13576	EL NARANJITO	\N
148	54	13577	FAVORINA	\N
148	54	13578	ALABAMA	\N
148	54	13579	CAROLINAS BAJAS	\N
148	54	13580	DELFIN GALLO	\N
148	54	13581	EL COCHUCHAL	\N
148	54	13582	INGENIO LA FLORIDA	\N
148	54	13583	LA FLORIDA	\N
148	54	13584	LOS GODOS	\N
148	54	13585	LUJAN	\N
148	54	13586	MONTE LARGO	\N
148	54	13587	NUEVO PUEBLO LA FLORIDA	\N
148	54	13588	PALOMITAS	\N
148	54	13589	EL CRUCE	\N
148	54	13590	ALDERETES	\N
148	54	13591	ARBOL SOLO	\N
148	54	13592	BLANCO POZO	\N
148	54	13593	BOCA DEL TIGRE	\N
148	54	13594	CASA ROSADA	\N
148	54	13595	CEVIL POZO	\N
148	54	13596	COHIGAC	\N
148	54	13597	EL PUERTO	\N
148	54	13598	FAVORITA	\N
148	54	13599	GUANACO MUERTO	\N
148	54	13600	LA FAVORITA	\N
148	54	13601	LA TALA	\N
148	54	13602	LAS PALOMITAS	\N
148	54	13603	LAS PIEDRITAS	\N
148	54	13604	LOS GUTIERREZ	\N
148	54	13605	LOS PEREYRA	\N
148	54	13606	PALMAS REDONDAS	\N
148	54	13607	RANCHILLOS	\N
148	54	13608	RANCHILLOS VIEJOS	\N
148	54	13609	SAN MIGUEL	\N
148	54	13610	SAN MIGUELITO	\N
148	54	13611	SAN VICENTE	\N
148	54	13612	COLMENA LOLITA	\N
148	54	13613	COLONIA LOLITA NORTE	\N
148	54	13614	FINCA MAYO	\N
148	54	13615	LOLITA	\N
148	54	13616	LOS RALOS	\N
148	54	13617	MAYO	\N
148	54	13618	SAN PEREYRA	\N
148	54	13619	VILLA TERCERA	\N
148	54	13620	LA LIBERTAD	\N
148	54	13621	LAPACHITOS	\N
148	54	13622	LAS CEJAS	\N
148	54	13623	LOS GODOY	\N
148	54	13624	LOS HARDOY	\N
148	54	13625	POZO LAPACHO	\N
148	54	13626	SAN AGUSTIN	\N
148	54	13627	SANTA LUISA	\N
148	54	13628	SANTILLAN	\N
148	54	13629	ESPERANZA - INCLUYE DELFIN GALLO	\N
148	54	13630	LA BANDERITA	\N
148	54	13631	CARRETA QUEMADA	\N
148	54	13632	CONCEPCION	\N
148	54	13633	ILTICO	\N
148	54	13634	INGENIO LA CORONA	\N
148	54	13635	MEMBRILLO	\N
148	54	13636	VILLA ALVEAR	\N
148	54	13637	ARCADIA	\N
148	54	13638	COLONIA FARA	\N
148	54	13639	COLONIA JUAN JOSE IRAMAIN	\N
148	54	13640	COLONIA PEDRO LEON CORNET	\N
148	54	13641	GASTONILLA	\N
148	54	13642	LAS FALDAS	\N
148	54	13643	LOS TIMBRES	\N
148	54	13644	VILLA CAROLINA	\N
148	54	13645	ALPACHIRI	\N
148	54	13646	BELICHA HUAICO	\N
148	54	13647	COCHUNA	\N
148	54	13648	EL MOLINO	\N
148	54	13649	EL POTRERILLO	\N
148	54	13650	GASTONA	\N
148	54	13651	JAYA	\N
148	54	13652	LAS LEGUAS	\N
148	54	13653	SAN RAMON CHICLIGASTA	\N
148	54	13654	BAJO DE LOS SUELDOS	\N
148	54	13655	COLONIA HUMAITA PRIMERA	\N
148	54	13656	FINCA ENTRE RIOS	\N
148	54	13657	INGENIO LA TRINIDAD	\N
148	54	13658	LOS GUCHEA	\N
148	54	13659	MEDINAS	\N
148	54	13660	MOLINOS	\N
148	54	13661	VILLA LA TRINIDAD	\N
148	54	13662	YUCUMANITA	\N
148	54	13663	MONTE RICO	\N
148	54	13664	ALTO VERDE	\N
148	54	13665	LA CALERA	\N
148	54	13666	EL MISTOLAR	\N
148	54	13667	LA FLORIDA	\N
148	54	13668	LAGARTE	\N
148	54	13669	LOS AGUEROS	\N
148	54	13670	LOS AGUIRRE	\N
148	54	13671	LOS LESCANOS	\N
148	54	13672	LOS PEREZ	\N
148	54	13673	MARIA LUISA	\N
148	54	13674	RESCATE	\N
148	54	13675	RIEGASTA	\N
148	54	13676	RIO SECO	\N
148	54	13677	RODEO GRANDE	\N
148	54	13678	SUD DE SANDOVALES	\N
148	54	13679	SURIYACO	\N
148	54	13680	CAMPO HERRERA	\N
148	54	13681	LAS TALAS	\N
148	54	13682	MERCEDES	\N
148	54	13683	SAN PABLO	\N
148	54	13684	FAMAILLA	\N
148	54	13685	LA FRONTERITA	\N
148	54	13686	LAURELES	\N
148	54	13687	SAN GABRIEL DEL MONTE	\N
148	54	13688	PADILLA	\N
148	54	13689	LA CRUZ	\N
148	54	13690	LARA	\N
148	54	13691	EL SAUZAL	\N
148	54	13692	TRINIDAD	\N
148	54	13693	CAMPO GRANDE	\N
148	54	13694	ESCOBAS	\N
148	54	13695	GRANEROS	\N
148	54	13696	LA CAÑADA	\N
148	54	13697	LOS GRAMAJOS	\N
148	54	13698	PAMPA LARGA	\N
148	54	13699	YMPAS	\N
148	54	13700	ZAPALLAR	\N
148	54	13701	ALONGO	\N
148	54	13702	CAMPO LA CRUZ	\N
148	54	13703	PALO BLANCO	\N
148	54	13704	CASA VIEJA	\N
148	54	13705	SAUCE SECO	\N
148	54	13706	LA LAGUNILLA	\N
148	54	13707	ROMERELLO	\N
148	54	13708	PAMPA MAYO	\N
148	54	13709	LA GRAMA	\N
148	54	13710	PALOMAS	\N
148	54	13711	AMUMPA	\N
148	54	13712	ARBOLES GRANDES	\N
148	54	13713	BARRANCAS	\N
148	54	13714	LA ESPERANZA	\N
148	54	13715	LAMADRID	\N
148	54	13716	LAS ANIMAS	\N
148	54	13717	LAS LOMITAS	\N
148	54	13718	LOS CERCOS	\N
148	54	13719	LOS PARAISOS	\N
148	54	13720	LOS SAUCES	\N
148	54	13721	SAN ANTONIO DE QUISCA	\N
148	54	13722	SOL DE MAYO	\N
148	54	13723	TALA CAIDA	\N
148	54	13724	TRES POZOS	\N
148	54	13725	25 DE MAYO	\N
148	54	13726	9 DE JULIO	\N
148	54	13727	BELTRAN	\N
148	54	13728	CHAÑARITOS	\N
148	54	13729	CHALCHACITO	\N
148	54	13730	CHILCA	\N
148	54	13731	COCO	\N
148	54	13732	EL QUEBRACHITO	\N
148	54	13733	EL SESTEADERO	\N
148	54	13734	EL TOSTADO	\N
148	54	13735	ENCRUCIJADA	\N
148	54	13736	IGUANA	\N
148	54	13737	LA CHILCA	\N
148	54	13738	LA IGUANA	\N
148	54	13739	LA ZANJA	\N
148	54	13740	LACHICO	\N
148	54	13741	LAS BRISAS	\N
148	54	13742	MOLLES	\N
148	54	13743	MONTUOSO	\N
148	54	13744	MORON	\N
148	54	13745	PAEZ	\N
148	54	13746	POZO HONDO (TACO RALO)	\N
148	54	13747	PUESTO 9 DE JULIO	\N
148	54	13748	PUESTO LOS AVILAS	\N
148	54	13749	PUESTO LOS PEREZ	\N
148	54	13750	QUEBRACHITO	\N
148	54	13751	RAMADITAS	\N
148	54	13752	RAMOS	\N
148	54	13753	RUMI YURA	\N
148	54	13754	SALA VIEJA	\N
148	54	13755	SAN GERMAN	\N
148	54	13756	SAN JUANCITO	\N
148	54	13757	SAUCE GAUCHO	\N
148	54	13758	SESTEADERO	\N
148	54	13759	SIMBOL	\N
148	54	13760	TACO RALO	\N
148	54	13761	TORO MUERTO	\N
148	54	13762	TOSTADO	\N
148	54	13763	VILTRAN	\N
148	54	13764	YAPACHIN	\N
148	54	13765	EL MOLINO	\N
148	54	13766	ESCABA	\N
148	54	13767	NARANJO ESQUINA	\N
148	54	13768	VILLA ALBERDI	\N
148	54	13769	VILLA BELGRANO	\N
148	54	13770	CAMPO BELLO	\N
148	54	13771	DONATO ALVAREZ	\N
148	54	13772	EL DURAZNITO	\N
148	54	13773	SOLEDAD	\N
148	54	13774	LA QUEBRADA	\N
148	54	13775	INVERNADA	\N
148	54	13776	EL HUAICO	\N
148	54	13777	MAL PASO	\N
148	54	13778	BATIRUANO	\N
148	54	13779	EL CORRALITO	\N
148	54	13780	LA INVERNADA	\N
148	54	13781	ALTO EL PUESTO	\N
148	54	13782	SAN LUIS DE LAS CASAS VIEJAS	\N
148	54	13783	DOMINGO MILLAN	\N
148	54	13784	LOS BAJOS	\N
148	54	13785	SACRIFICIO	\N
148	54	13786	LA COCHA	\N
148	54	13787	LA POSTA	\N
148	54	13788	LAS CEJAS	\N
148	54	13789	LOS PIZARRO	\N
148	54	13790	MISTOL	\N
148	54	13791	MONTE GRANDE	\N
148	54	13792	MONTE REDONDO	\N
148	54	13793	POZO CAVADO	\N
148	54	13794	SAUCE YACU	\N
148	54	13795	PUESTO NUEVO	\N
148	54	13796	BAJASTINE	\N
148	54	13797	EL BAJO	\N
148	54	13798	EL SUNCHO	\N
148	54	13799	PUEBLO VIEJO	\N
148	54	13800	RUMI PUNCO	\N
148	54	13801	LAS ABRAS	\N
148	54	13802	LOS MOLLES	\N
148	54	13803	LOS POCITOS	\N
148	54	13804	CUATRO SAUCES	\N
148	54	13805	CHILCAL	\N
148	54	13806	COLONIA AGRICOLA	\N
148	54	13807	COLONIA ARGENTINA	\N
148	54	13808	CORTADERAL	\N
148	54	13809	COSTA ARROYO ESQUINA	\N
148	54	13810	EL CORTADERAL	\N
148	54	13811	ESQUINA	\N
148	54	13812	ESQUINA DEL LLANO	\N
148	54	13813	INGENIO LEALES	\N
148	54	13814	JUAN POSSE	\N
148	54	13815	LA EMPATADA	\N
148	54	13816	LA ENCANTADA	\N
148	54	13817	LAGUNA BLANCA	\N
148	54	13818	LOMA VERDE	\N
148	54	13819	LOS CAMPEROS	\N
148	54	13820	LOS SUELDOS	\N
148	54	13821	PALA PALA	\N
148	54	13822	PUESTO CHICO	\N
148	54	13823	PUMA POZO	\N
148	54	13824	QUILMES	\N
148	54	13825	ROMA	\N
148	54	13826	SAN NICOLAS	\N
148	54	13827	SANTA FELISA	\N
148	54	13828	SANTA ROSA DE LEALES	\N
148	54	13829	VILCA POZO	\N
148	54	13830	VILLA FIAD	\N
148	54	13831	ACOSTILLA	\N
148	54	13832	AVESTILLA	\N
148	54	13833	CACHI HUASI	\N
148	54	13834	CACHI YACO	\N
148	54	13835	EL GUARDAMONTE	\N
148	54	13836	EL ROSARIO	\N
148	54	13837	GOMEZ CHICO	\N
148	54	13838	LAS ACOSTILLAS	\N
148	54	13839	LAS CAÑADAS	\N
148	54	13840	LEALES	\N
148	54	13841	LOS BRITOS	\N
148	54	13842	LOS GOMEZ	\N
148	54	13843	LOS HERRERAS	\N
148	54	13844	LOS JUAREZ	\N
148	54	13845	LOS ROMANOS	\N
148	54	13846	LUNAREJOS	\N
148	54	13847	MIGUEL LILLO	\N
148	54	13848	NOARIO	\N
148	54	13849	NUEVA ESPAÑA	\N
148	54	13850	SAN JOSE DE LEALES	\N
148	54	13851	TUSCA POZO	\N
148	54	13852	TUSQUITAS	\N
148	54	13853	YATAPAYANA	\N
148	54	13854	AGUA AZUL	\N
148	54	13855	AHI VEREMOS	\N
148	54	13856	BARREALITO	\N
148	54	13857	CONDOR HUASI	\N
148	54	13858	EL PAVON	\N
148	54	13859	ENCRUCIJADAS	\N
148	54	13860	JUSCO POZO	\N
148	54	13861	LAS CELAYAS	\N
148	54	13862	LAS COLONIAS	\N
148	54	13863	LAS ENCRUCIJADAS	\N
148	54	13864	LAS PALMITAS	\N
148	54	13865	LAS ZORRAS	\N
148	54	13866	LOS PUESTOS	\N
148	54	13867	LOS VILLEGAS	\N
148	54	13868	LOS ZELAYAS	\N
148	54	13869	MANCOPA	\N
148	54	13870	MIXTA	\N
148	54	13871	MOJON	\N
148	54	13872	MOYAR	\N
148	54	13873	ORAN	\N
148	54	13874	PALMITAS	\N
148	54	13875	PIRHUAS	\N
148	54	13876	ROMERA POZO	\N
148	54	13877	SANDIS	\N
148	54	13878	VIELOS	\N
148	54	13879	EL BARRIALITO	\N
148	54	13880	TACANAS	\N
148	54	13881	AGUA BLANCA	\N
148	54	13882	AMAICHA	\N
148	54	13883	MANCHALA	\N
148	54	13884	MANUEL GARCIA FERNANDEZ	\N
148	54	13885	PUENTE EL MANANTIAL	\N
148	54	13886	RIO COLORADO	\N
148	54	13887	AMAICHA DEL LLANO	\N
148	54	13888	BELLA VISTA	\N
148	54	13889	INGENIO BELLA VISTA	\N
148	54	13890	MARIA ELENA	\N
148	54	13891	YALAPA	\N
148	54	13892	ARAOZ	\N
148	54	13893	EL MELON	\N
148	54	13894	EL QUIMIL	\N
148	54	13895	MUJER MUERTA	\N
148	54	13896	SUPERINTENDENTE LEDESMA	\N
148	54	13897	VILLA DESIERTO DEL LUZ	\N
148	54	13898	EL NOGALITO	\N
148	54	13899	LAS TIPAS	\N
148	54	13900	LOS ALCARACES	\N
148	54	13901	EL MANANTIAL	\N
148	54	13902	SAN FELIPE	\N
148	54	13903	SANTA BARBARA	\N
148	54	13904	VILLA NOUGUES	\N
148	54	13905	LULES	\N
148	54	13906	POTRERO DE LAS TABLAS	\N
148	54	13907	SAN JOSE DE LULES	\N
148	54	13908	LA REDUCCION	\N
148	54	13909	LAS TABLAS	\N
148	54	13910	MALVINAS	\N
148	54	13911	SAN PABLO	\N
148	54	13912	SAN RAFAEL	\N
148	54	13913	PUERTA GRANDE	\N
148	54	13914	HIGUERITAS	\N
148	54	13915	LAS MESADAS	\N
148	54	13916	TENIENTE BERDINA	\N
148	54	13917	ACHERAL	\N
148	54	13918	ARENILLA	\N
148	54	13919	SAN GABRIEL	\N
148	54	13920	SAN JOSE DE FLORES	\N
148	54	13921	CASPINCHANGO	\N
148	54	13922	DURAZNOS BLANCOS	\N
148	54	13923	EL NOGALAR	\N
148	54	13924	SANTA LUCIA	\N
148	54	13925	LA RAMADITA	\N
148	54	13926	LAS CIENAGAS	\N
148	54	13927	LOS RODRIGUEZ	\N
148	54	13928	NEGRO POTRERO	\N
148	54	13929	SANTA ELENA	\N
148	54	13930	SANTA MONICA	\N
148	54	13931	ARAGONES	\N
148	54	13932	CAPITAN CACERES	\N
148	54	13933	COLONIA SANTA CATALINA	\N
148	54	13934	COSTILLA	\N
148	54	13935	EL CERCADO	\N
148	54	13936	EL CHURQUIS	\N
148	54	13937	ISLA SAN JOSE	\N
148	54	13938	LOS ROBLES	\N
148	54	13939	LOS SOSA	\N
148	54	13940	MONTEROS	\N
148	54	13941	ORAN	\N
148	54	13942	PILCO	\N
148	54	13943	SANTA CATALINA	\N
148	54	13944	SOLDADO MALDONADO	\N
148	54	13945	VILLA NUEVA	\N
148	54	13946	YACUCHINA	\N
148	54	13947	YONOPONGO	\N
148	54	13948	INDEPENDENCIA	\N
148	54	13949	INGENIO SANTA ROSA	\N
148	54	13950	LEON ROUGES	\N
148	54	13951	LOS MOYES	\N
148	54	13952	LOS REYES	\N
148	54	13953	LOS ROJOS	\N
148	54	13954	SANTA ROSA	\N
148	54	13955	AMBERES	\N
148	54	13956	LA FLORIDA	\N
148	54	13957	LAS HIGUERITAS	\N
148	54	13958	SARGENTO MOYA	\N
148	54	13959	VILLA QUINTEROS	\N
148	54	13960	INGENIO LA PROVIDENCIA	\N
148	54	13961	RIO SECO	\N
148	54	13962	RINCON DE BALDERRAMA	\N
148	54	13963	BUENA VISTA	\N
148	54	13964	MACIO	\N
148	54	13965	LAS TALITAS	\N
148	54	13966	AGUILARES	\N
148	54	13967	ARROYO BARRIENTO	\N
148	54	13968	COLONIA MARULL	\N
148	54	13969	COLONIA NASCHI	\N
148	54	13970	HUASA RINCON	\N
148	54	13971	LOS CALLEJONES	\N
148	54	13972	MULTIFLORES	\N
148	54	13973	NASCHE	\N
148	54	13974	RINCON HUASA	\N
148	54	13975	CUESTA DE LA CHILCA	\N
148	54	13976	RIO CHICO	\N
148	54	13977	CEVIL GRANDE	\N
148	54	13978	CHAVARRIA	\N
148	54	13979	SANTA ANA	\N
148	54	13980	LOS LUNAS	\N
148	54	13981	VILLA CLODOMIRO HILERET	\N
148	54	13982	ARROYO MAL PASO	\N
148	54	13983	CEVIL SOLO	\N
148	54	13984	EL TUSCAL	\N
148	54	13985	FALDA DE ARCADIA	\N
148	54	13986	INGENIO SANTA BARBARA	\N
148	54	13987	LA TAPIA	\N
148	54	13988	LA TIPA	\N
148	54	13989	LOS CORDOBA	\N
148	54	13990	LOS GALPONES	\N
148	54	13991	LOS RIOS	\N
148	54	13992	LOS RIZOS	\N
148	54	13993	LOS SARMIENTOS	\N
148	54	13994	MARIA BLANCA	\N
148	54	13995	MONTE BELLO	\N
148	54	13996	INGENIO MARAPA	\N
148	54	13997	LOS ALISOS	\N
148	54	13998	MARAPA	\N
148	54	13999	YAMINAS	\N
148	54	14000	DOLAVON	\N
148	54	14001	EL NOGAL	\N
148	54	14002	EL POLEAR	\N
148	54	14003	NUEVA ESQUINA	\N
148	54	14004	SAN MIGUEL DE TUCUMAN	\N
148	54	14005	ESTACION EXPERIMENTAL AGRICOLA	\N
148	54	14006	ESTACION SUPERIOR AGRICOLA	\N
148	54	14007	LOS AGUIRRE	\N
148	54	14008	NUEVOS MATADEROS	\N
148	54	14009	EL CHILCAR	\N
148	54	14010	LOMA GRANDE	\N
148	54	14011	SAN JOSE DE BUENA VISTA	\N
148	54	14012	LA TUNA	\N
148	54	14013	SANTA CRUZ	\N
148	54	14014	VALENZUELA	\N
148	54	14015	LOS ARRIETAS	\N
148	54	14016	ALTO LAS FLORES	\N
148	54	14017	SANTA ISABEL	\N
148	54	14018	LOS AGUDOS	\N
148	54	14019	NUEVA TRINIDAD	\N
148	54	14020	SAN IGNACIO	\N
148	54	14021	HUASA PAMPA NORTE	\N
148	54	14022	HUASA PAMPA	\N
148	54	14023	MANUELA PEDRAZA	\N
148	54	14024	CAMPO VOLANTE	\N
148	54	14025	EL POLEAR	\N
148	54	14026	GUEMES	\N
148	54	14027	LA RINCONADA	\N
148	54	14028	LAS CEJAS	\N
148	54	14029	MASCIO PILCO	\N
148	54	14030	SAN PEDRO MARTIR	\N
148	54	14031	SIMOCA	\N
148	54	14032	YERBA BUENA	\N
148	54	14033	AMPATA	\N
148	54	14034	AMPATILLA	\N
148	54	14035	ARROYO ATAHONA	\N
148	54	14036	ATAHONA	\N
148	54	14037	CEJAS DE AROCA	\N
148	54	14038	VILLA CHICLIGASTA	\N
148	54	14039	CIUDACITA	\N
148	54	14040	EL TOBAR	\N
148	54	14041	ICHIPUCA	\N
148	54	14042	LAZARTE	\N
148	54	14043	LOS MENDOZAS	\N
148	54	14044	LOS TREJOS	\N
148	54	14045	MONTEAGUDO	\N
148	54	14046	NIOGASTA	\N
148	54	14047	PALOMINOS	\N
148	54	14048	SAN ANTONIO DE PADUA	\N
148	54	14049	SANDOVALES	\N
148	54	14050	SUD DE LAZARTE	\N
148	54	14051	TREJOS	\N
148	54	14052	VILLA SANTA ROSA	\N
148	54	14053	DURAZNO	\N
148	54	14054	EL ZANJON	\N
148	54	14055	LAS MORITAS	\N
148	54	14056	LAS SALINAS	\N
148	54	14057	POTRERILLO	\N
148	54	14058	EL CUARTEADERO	\N
148	54	14059	RINCON	\N
148	54	14060	TALLERES NACIONALES	\N
148	54	14061	EL CATORCE	\N
148	54	14062	BARRIO CASINO	\N
148	54	14063	CUATRO GATOS	\N
148	54	14064	PIE DEL ACONQUIJA	\N
148	54	14065	PUERTA SAN JAVIER	\N
148	54	14066	FRONTERITAS	\N
148	54	14067	LAS TIPAS DE COLALAO	\N
148	54	14068	EL MOLLAR	\N
148	54	14069	AMAICHA DEL VALLE	\N
148	54	14070	ANTAMA	\N
148	54	14071	LAS CARRERAS	\N
148	54	14072	LOS COLORADOS	\N
148	54	14073	LOS CORDONES	\N
148	54	14074	LOS CORPITOS	\N
148	54	14075	LOS CUARTOS	\N
148	54	14076	LOS ZAZOS	\N
148	54	14077	SAN JOSE DE CHASQUIVIL	\N
148	54	14078	TAFI DEL VALLE	\N
148	54	14079	TIO PUNCO	\N
148	54	14080	ZURITA	\N
148	54	14081	ANJUANA	\N
148	54	14082	CALIMONTE	\N
148	54	14083	COLALAO DEL VALLE	\N
148	54	14084	EL ARBOLAR	\N
148	54	14085	EL CARRIZAL	\N
148	54	14086	EL PASO	\N
148	54	14087	LOMA COLORADA	\N
148	54	14088	MANAGUA	\N
148	54	14089	PICHAO	\N
148	54	14090	QUILMES	\N
148	54	14091	QUISCA CHICA	\N
148	54	14092	TIO FRANCO	\N
148	54	14093	TOTORITAS	\N
148	54	14094	YASYAMAYO	\N
148	54	14095	CASA DE PIEDRAS	\N
148	54	14096	BARRIO DIAGONAL	\N
148	54	14097	BARRIO RIVADAVIA	\N
148	54	14098	EL COLMENAR	\N
148	54	14099	GRANJA MODELO	\N
148	54	14100	LAS TALITAS	\N
148	54	14101	LOS NOGALES	\N
148	54	14102	VILLA MARIANO MORENO	\N
148	54	14103	VILLA NUEVA ITALIA	\N
148	54	14104	COMUNA LA ESPERANZA	\N
148	54	14105	LA TOMA	\N
148	54	14106	LOS ESTANQUES	\N
148	54	14107	NUEVA ESPERANZA	\N
148	54	14108	PUEBLO OBRERO	\N
148	54	14109	TAFI VIEJO	\N
148	54	14110	TAFICILLO	\N
148	54	14111	VILLA MITRE	\N
148	54	14112	ANCAJULLI	\N
148	54	14113	ANFANA	\N
148	54	14114	CHASQUIVIL	\N
148	54	14115	EL SIAMBON	\N
148	54	14116	RACO	\N
148	54	14117	VILLA EL CADILLAL	\N
148	54	14118	ALTO DE ANFAMA	\N
148	54	14119	ASERRADERO	\N
148	54	14120	LOS PLANCHONES	\N
148	54	14121	UTURUNGU	\N
148	54	14122	ANGOSTURA	\N
148	54	14123	TOTORAL	\N
148	54	14124	BENJAMIN PAZ	\N
148	54	14125	CHOROMORO	\N
148	54	14126	CHUSCHA	\N
148	54	14127	DESMONTE	\N
148	54	14128	EL CEDRO	\N
148	54	14129	EL OJO	\N
148	54	14130	GONZALO	\N
148	54	14131	HUASAMAYO	\N
148	54	14132	JUNTAS	\N
148	54	14133	LAS CRIOLLAS	\N
148	54	14134	LOMA DEL MEDIO	\N
148	54	14135	MATO YACO	\N
148	54	14136	POSTA VIEJA	\N
148	54	14137	POTRO YACO	\N
148	54	14138	PUERTAS	\N
148	54	14139	PUESTO GRANDE	\N
148	54	14140	RIO VIPOS	\N
148	54	14141	RODEO GRANDE	\N
148	54	14142	SALAMANCA	\N
148	54	14143	SALINAS	\N
148	54	14144	SAN JULIAN	\N
148	54	14145	SEPULTURA	\N
148	54	14146	SIMBOLAR	\N
148	54	14147	TALA YACO	\N
148	54	14148	TAPIA	\N
148	54	14149	TICUCHO	\N
148	54	14150	TUNA SOLA	\N
148	54	14151	VIPOS	\N
148	54	14152	ACEQUIONES	\N
148	54	14153	AGUA ROSADA	\N
148	54	14154	BARBORIN	\N
148	54	14155	CHULCA	\N
148	54	14156	CORRAL VIEJO	\N
148	54	14157	EL BOYERO	\N
148	54	14158	EL QUEBRACHAL	\N
148	54	14159	LA DORITA	\N
148	54	14160	LAS ARCAS	\N
148	54	14161	LAS TACANAS	\N
148	54	14162	LAUREL YACO	\N
148	54	14163	LEOCADIO PAZ	\N
148	54	14164	MANANTIALES	\N
148	54	14165	MIRANDA	\N
148	54	14166	MONTE BELLO	\N
148	54	14167	PERUCHO	\N
148	54	14168	PIE DE LA CUESTA	\N
148	54	14169	PINGOLLAR	\N
148	54	14170	SAN FERNANDO	\N
148	54	14171	SAN ISIDRO	\N
148	54	14172	SAN JOSE	\N
148	54	14173	SAN PEDRO DE COLALAO	\N
148	54	14174	SAUZAL	\N
148	54	14175	TACO YANA	\N
148	54	14176	TOCO LLANA	\N
148	54	14177	TORO LOCO	\N
148	54	14178	TRANCAS	\N
148	54	14179	YUCHACO	\N
148	54	14180	ZARATE	\N
148	54	14181	LA CUESTA	\N
148	54	14182	RIARTE	\N
148	54	14183	LA ANGOSTURA	\N
148	54	14184	CEVIL REDONDO	\N
148	54	14185	CURVA DE LOS VEGA	\N
148	54	14186	LA CAVERA	\N
148	54	14187	SAN ALBERTO	\N
148	54	14188	SAN JAVIER	\N
148	54	14189	VILLA CARMELA	\N
148	54	14190	CAMINO DEL PERU	\N
148	54	14191	MARCOS PAZ	\N
148	54	14192	VILLA MARCOS PAZ	\N
148	54	14193	YERBA BUENA	\N
148	54	14194	LA SALA	\N
149	54	14195	CABO SAN PABLO	\N
149	54	14196	MISION SALESIANA	\N
149	54	14197	ESTANCIA MARIA BEHETY	\N
149	54	14198	ESTANCIA VIAMONTE	\N
149	54	14199	FRIGORIFICO CAP-RIO GRANDE	\N
149	54	14200	LAGO KHAMI	\N
149	54	14201	PUNTA MARIA	\N
149	54	14202	RIO EWAN	\N
149	54	14203	RIO GRANDE	\N
149	54	14204	RUBY	\N
149	54	14205	SAN SEBASTIAN	\N
149	54	14206	SANTA INES	\N
149	54	14207	TOLHUIN	\N
149	54	14208	BAHIA BUEN SUCESO	\N
149	54	14209	BAHIA THETIS	\N
149	54	14210	HOSTERIA PETREL	\N
149	54	14211	ISLA DE AÑO NUEVO	\N
149	54	14212	ISLA DE LOS ESTADOS	\N
149	54	14213	LAGO ESCONDIDO	\N
149	54	14214	LAPATAIA	\N
149	54	14215	PARADOR OLIVIA	\N
149	54	14216	PUERTO HARBERTON	\N
149	54	14217	SAN JUAN DEL SALVAMENTO	\N
149	54	14218	USHUAIA	\N
149	54	14219	ALMANZA	\N
149	54	14220	PUERTO PARRY	\N
149	54	14221	HOSTERIA KAIKEN	\N
149	54	14222	ISLAS MALVINAS	\N
149	54	14223	ISLAS ORCADAS DEL SUD	\N
149	54	14224	OBSERVATORIO METEOROLOGICO ORCADAS	\N
149	54	14225	BASE AEREA TENIENTE MATIENZO	\N
149	54	14226	BASE AEREA VICE CMRO. MARAMBIO	\N
149	54	14227	BASE DE EJERCITO ESPERANZA	\N
149	54	14228	BASE DE EJERCITO GENERAL BELGRANO 2	\N
149	54	14229	BASE DE EJERCITO GENERAL BELGRANO 3	\N
149	54	14230	BASE DE EJERCITO GENERAL SAN MARTIN	\N
149	54	14231	BASE DE EJERCITO PRIMAVERA	\N
149	54	14232	DESTACAMENTO NAVAL ORCADAS	\N
149	54	14233	ESTACION AERONAVAL PETREL	\N
149	54	14234	ESTACION CIENTIFICA ALMIRANTE BROWN	\N
149	54	14235	ESTACION CIENTIFICA CORBETA URUGUAY	\N
149	54	14236	PRIMAVERA	\N
\.


--
-- Data for Name: motivos_baja; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY motivos_baja (id_motivo_baja, motivo_baja) FROM stdin;
\.


--
-- Name: motivos_baja_id_motivo_baja_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('motivos_baja_id_motivo_baja_seq', 1, false);


--
-- Data for Name: niveles_academicos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY niveles_academicos (nivel_academico, orden, id_nivel_academico) FROM stdin;
Secundario	1	1
Pre-Grado	2	2
Grado	3	3
Especialización	4	4
Maestría	5	5
Doctorado	6	6
Posdoctorado	7	7
\.


--
-- Name: niveles_academicos_id_nivel_academico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('niveles_academicos_id_nivel_academico_seq', 7, true);


--
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY paises (id_pais, pais) FROM stdin;
1	Estados Unidos
51	Peru
52	Mexico
53	Cuba
54	Argentina
55	Brasil
56	Chile
57	Colombia
58	Venezuela
501	Belice
502	Guatemala
503	El Salvador
504	Honduras
505	Nicaragua
506	Costa Rica
507	Panama
509	Haiti
591	Bolivia
592	Guyana
593	Ecuador
594	Guayana Francesa
595	Paraguay
596	Martinica
597	Surinam
598	Uruguay
2	Canadá
3	Puerto Rico
4	Republica Dominicana
868	Trinidad y Tobago
1242	Bahamas
1246	Barbados
1473	Granada
1758	Santa Lucía
1767	Dominica
1784	San Vicente y Granadinas
1869	San Cristóbal y Nevis
\.


--
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY personas (nro_documento, id_tipo_doc, apellido, nombres, cuil, fecha_nac, celular, email, telefono, id_localidad, id_provincia, id_pais, id_nivel_academico, sexo) FROM stdin;
\.


--
-- Data for Name: provincias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY provincias (id_pais, id_provincia, provincia) FROM stdin;
1	2	Alabama
1	3	Alaska
1	4	Arizona
1	5	Arkansas
1	6	California
1	7	Colorado
1	8	Connecticut
1	9	Delaware
1	10	Florida
1	11	Georgia
1	12	Hawaii
1	13	Idaho
1	14	Illinois
1	15	Indiana
1	16	Iowa
1	17	Kansas
1	18	Kentucky
1	19	Louisiana
1	20	Maine
1	21	Maryland
1	22	Massachusetts
1	23	Michigan
1	24	Minnesota
1	25	Mississippi
1	26	Missouri
1	27	Montana
1	28	Nebraska
1	29	Nevada
1	30	New Hampshire
1	31	New Jersey
1	32	New Mexico
1	33	New York
1	34	North Carolina
1	35	North Dakota
1	36	Ohio
1	37	Oklahoma
1	38	Oregon
1	39	Pennsylvania
1	40	Rhode Island
1	41	South Carolina
1	42	South Dakota
1	43	Tennessee
1	44	Texas
1	45	Utah
1	46	Vermont
1	47	Virginia
1	48	Washington
1	49	West Virginia
1	50	Wisconsin
1	51	Wyoming
1	52	Distrito de Columbia
51	53	AMAZONAS
51	54	ANCASH
51	55	APURIMAC
51	56	AREQUIPA
51	57	AYACUCHO
51	58	CAJAMARCA
51	59	CUSCO
51	60	HUANUCO
51	61	HUANCAVELICA
51	62	ICA
51	63	JUNIN
51	64	LA LIBERTAD
51	65	LAMBAYEQUE
51	66	LIMA
51	67	LORETO
51	68	MADRE DE DIOS
51	69	MOQUEGUA
51	70	PASCO
51	71	PIURA
51	72	PUNO
51	73	SAN MARTIN
51	74	TACNA
51	75	TUMBES
51	76	UCAYALI
51	77	CALLAO
52	78	Aguascalientes
52	79	Baja California Norte
52	80	Baja California Sur
52	81	Campeche
52	82	Chiapas
52	83	Chihuahua
52	84	Coahuila
52	85	Colima
52	86	Distrito Federal
52	87	Durango
52	88	Estado de Mexico
52	89	Guanajuato
52	90	Guerrero
52	91	Hidalgo
52	92	Jalisco
52	93	Michoacán
52	94	Morelos
52	95	Nayarit
52	96	Nuevo León
52	97	Oaxaca
52	98	Puebla
52	99	Querétaro
52	100	Quintana Roo
52	101	San Luis Potosí
52	102	Sinaloa
52	103	Sonora
52	104	Tabasco
52	105	Tamaulipas
52	106	Tlaxcala
52	107	Veracruz
52	108	Yucatán
52	109	Zacatecas
53	110	Artemisa 
53	111	Camagüey 
53	112	Ciego de Ávila 
53	113	Cienfuegos 
53	114	Granma 
53	115	Guantánamo 
53	116	Holguín 
53	117	La Habana 
53	118	Las Tunas 
53	119	Matanzas 
53	120	Mayabeque 
53	121	Pinar del Río 
53	122	Sancti Spíritus 
53	123	Santiago de Cuba 
53	124	Villa Clara 
53	125	Isla de la Juventud 
54	126	Capital Federal
54	127	Buenos Aires
54	128	Catamarca
54	129	Cordoba
54	130	Corrientes
54	131	Chaco
54	132	Chubut
54	133	Entre Rios
54	134	Formosa
54	135	Jujuy
54	136	La Pampa
54	137	La Rioja
54	138	Mendoza
54	139	Misiones
54	140	Neuquén
54	141	Rio Negro
54	142	Salta
54	143	San Juan
54	144	San Luis
54	145	Santa Cruz
54	146	Santa Fe
54	147	Santiago del Estero
54	148	Tucumán
54	149	Tierra del Fuego, Antártida e Islas del Atlántico Sur
55	150	Acre
55	151	Alagoas
55	152	Amapá
55	153	Amazonas
55	154	Bahia
55	155	Ceará
55	156	Distrito Federal
55	157	Espírito Santo
55	158	Goiás
55	159	Maranhão
55	160	Mato Grosso
55	161	Mato Grosso do Sul
55	162	Minas Gerais
55	163	Pará
55	164	Paraíba
55	165	Paraná
55	166	Pernambuco
55	167	Piauí
55	168	Rio de Janeiro
55	169	Rio Grande do Norte
55	170	Rio Grande do Sul
55	171	Rondônia
55	172	Roraima
55	173	Santa Catarina
55	174	São Paulo
55	175	Sergipe
55	176	Tocantins
56	177	AISEN DEL GENERAL CARLOS IBAÑEZ DEL CAMPO
56	178	ANTOFAGASTA
56	179	ARAUCANIA
56	180	ATACAMA
56	181	BIOBIO
56	182	COQUIMBO
56	183	LIBERTADOR GENERAL BERNARDO O´HIGGINS
56	184	LOS LAGOS
56	185	MAGALLANES Y LA ANTARTICA CHILENA
56	186	MAULE
56	187	METROPOLITANA DE SANTIAGO
56	188	TARAPACA
56	189	VALPARAISO
56	190	ARICA Y PARINACOTA
56	191	LOS RIOS
57	192	Amazonas
57	193	Antioquia
57	194	Arauca
57	195	Atlántico
57	196	Bogotá
57	197	Bolívar
57	198	Boyacá
57	199	Caldas
57	200	Caquetá
57	201	Casanare
57	202	Cauca
57	203	César
57	204	Chocó
57	205	Córdoba
57	206	Cundinamarca
57	207	Guaviare
57	208	Huila
57	209	La Guajira
57	210	Magdalena
57	211	Meta
57	212	Nariño
57	213	Norte de Santander
57	214	Putumayo
57	215	Quindió
57	216	Risaralda
57	217	San Andrés y Providencia
57	218	Santander
57	219	Sucre
57	220	Tolima
57	221	Valle del Cauca
57	222	Guainía
57	223	Vaupés
57	224	Vichada
58	225	Zulia
58	226	Yaracuy
58	227	Vargas
58	228	Trujillo
58	229	Táchira
58	230	Sucre
58	231	Portuguesa
58	232	Nueva Esparta
58	233	Monagas
58	234	Miranda
58	235	Mérida
58	236	Lara
58	237	Guárico
58	238	Falcón
58	239	distrito federal
58	240	Dependencias Federales
58	241	Delta Amacuro
58	242	Cojedes
58	243	Carabobo
58	244	Bolívar
58	245	Barinas
58	246	Aragua
58	247	Apure
58	248	Anzoátegui
58	249	Amazonas
502	250	Alta Verapaz
502	251	Baja Verapaz
502	252	Chimaltenango
502	253	Chiquimula
502	254	Petén
502	255	El Progreso
502	256	Quiché
502	257	Escuintla
502	258	Nueva Guatemala de la Asunción
502	259	Huehuetenango
502	260	Izabal
502	261	Jalapa
502	262	Jutiapa
502	263	Quetzaltenango
502	264	Retalhuleu
502	265	Sacatepéquez
502	266	San Marcos
502	267	Santa Rosa
502	268	Sololá
502	269	Suchitepéquez
502	270	Totonicapán
502	271	Zacapa
503	272	Ahuachapán
503	273	Sonsonate
503	274	Santa Ana
503	275	Cabañas
503	276	Chalatenango
503	277	Cuscatlán
503	278	La Libertad
503	279	La Paz
503	280	San Salvador
503	281	San Vicente
503	282	Morazán
503	283	San Miguel
503	284	Usulután
503	285	La Unión
504	286	Atlántida
504	287	Colón
504	288	Comayagua
504	289	Copán
504	290	Cortés
504	291	Choluteca
504	292	El Paraíso
504	293	Francisco Morazán
504	294	Gracias a Dios
504	295	Intibucá
504	296	Islas de la Bahía
504	297	La Paz
504	298	Lempira
504	299	Ocotepeque
504	300	Olancho
504	301	Santa Bárbara
504	302	Valle
504	303	Yoro
506	304	Alajuela
506	305	Cartago
506	306	Guanacaste
506	307	Heredia
506	308	Limón
506	309	Puntarenas
506	310	San José
591	311	Beni 
591	312	Chuquisaca
591	313	Cochabamba
591	314	La Paz 
591	315	Oruro 
591	316	Pando 
591	317	Potosí 
591	318	Santa Cruz 
591	319	Tarija 
593	320	AZUAY
593	321	BOLIVAR
593	322	CAÑAR
593	323	CARCHI
593	324	COTOPAXI
593	325	CHIMBORAZO
593	326	IMBABURA
593	327	LOJA
593	328	PICHINCHA
593	329	TUNGURAHUA
593	330	EL ORO
593	331	ESMERALDAS
593	332	GUAYAS
593	333	LOS RIOS
593	334	MANABI
593	335	MORONA SANTIAGO
593	336	NAPO
593	337	PASTAZA
593	338	ZAMORA CHINCHIPE
593	339	SUCUMBIOS
593	340	ORELLANA
593	341	GALAPAGOS
593	342	SANTA ELENA
593	343	SANTO DOMINGO DE LOS TSACHILAS
595	344	Sin Provincias
598	345	Sin Provincias
2	346	Alberta
2	347	Columbia Británica
2	348	Isla del Principe Eduardo
2	349	Manitoba
2	350	Nuevo Brunswick
2	351	Nueva Escocia
2	352	Nunavut
2	353	Ontario
2	354	Quebec
2	355	Saskatchewan
2	356	Terranova y Labrador
2	357	Territorios del Noroeste
2	358	Yukon
4	359	Azua
4	360	Barahona
4	361	Dajabón
4	362	Duarte
4	363	Elías Piña
4	364	El Seibo
4	365	Espaillat
4	366	Hato Mayor
4	367	Hermanas Mirabal
4	368	Independencia
4	369	La Altagracia
4	370	La Romana
4	371	La Vega
4	372	María Trinidad Sánchez
4	373	Monseñor Nouel
4	374	Montecristi
4	375	Monte Plata
4	376	Pedernales
4	377	Peravia
4	378	Puerto Plata
4	379	Samaná
4	380	Sánchez Ramírez
4	381	San Cristóbal
4	382	San José de Ocoa
4	383	San Juan
4	384	San Pedro de Macorís
4	385	Santiago
4	386	Santiago Rodríguez
4	387	Santo Domingo
4	388	Valverde
4	389	Distrito Nacional
868	390	Puerto España
868	391	Arima
868	392	Chaguanas
868	393	Point Fortin
868	394	San Fernando
868	395	Couva-Tabaquite-Talparo
868	396	Diego Martin
868	397	Penal-Debe
868	398	Princes Town
868	399	Río Claro-Mayaro
868	400	San Juan-Laventille
868	401	Sangre Grande
868	402	Siparia
868	403	Tunapuna-Piarco
868	404	Tobago
\.


--
-- Data for Name: proyectos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY proyectos (proyecto, codigo, id_proyecto) FROM stdin;
\.


--
-- Data for Name: requisitos_convocatoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY requisitos_convocatoria (id_convocatoria, requisito, obligatorio, id_requisito) FROM stdin;
\.


--
-- Name: requisitos_convocatoria_id_requisito_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('requisitos_convocatoria_id_requisito_seq', 4, true);


--
-- Data for Name: requisitos_insc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY requisitos_insc (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca, id_requisito, cumplido, fecha) FROM stdin;
\.


--
-- Data for Name: resoluciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY resoluciones (nro_resol, anio, fecha, archivo_pdf, id_tipo_resol) FROM stdin;
\.


--
-- Data for Name: resultado_avance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY resultado_avance (id_resultado, resultado, activo) FROM stdin;
\.


--
-- Data for Name: tipo_documento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_documento (id_tipo_doc, tipo_doc) FROM stdin;
1	DNI
2	Pasaporte
\.


--
-- Data for Name: tipos_beca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipos_beca (id_tipo_beca, id_tipo_convocatoria, tipo_beca, duracion_meses, meses_present_avance, cupo_maximo, id_color, estado) FROM stdin;
\.


--
-- Name: tipos_beca_id_tipo_beca_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipos_beca_id_tipo_beca_seq', 3, true);


--
-- Data for Name: tipos_convocatoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipos_convocatoria (id_tipo_convocatoria, tipo_convocatoria) FROM stdin;
\.


--
-- Name: tipos_convocatoria_id_tipo_convocatoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipos_convocatoria_id_tipo_convocatoria_seq', 2, true);


--
-- Data for Name: tipos_resolucion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipos_resolucion (id_tipo_resol, tipo_resol, tipo_resol_corto) FROM stdin;
\.


--
-- Data for Name: universidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY universidades (id_universidad, universidad, id_pais, sigla) FROM stdin;
1	Universidad Nacional del Nordeste	\N	UNNE
\.


--
-- Name: pk_area_conocimiento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY area_conocimiento
    ADD CONSTRAINT pk_area_conocimiento PRIMARY KEY (id_area_conocimiento);


--
-- Name: pk_areas_dependencia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY areas_dependencia
    ADD CONSTRAINT pk_areas_dependencia PRIMARY KEY (id_area);


--
-- Name: pk_avance_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avance_beca
    ADD CONSTRAINT pk_avance_beca PRIMARY KEY (id_avance);


--
-- Name: pk_baja_becas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY baja_becas
    ADD CONSTRAINT pk_baja_becas PRIMARY KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: pk_becas_otorgadas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY becas_otorgadas
    ADD CONSTRAINT pk_becas_otorgadas PRIMARY KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: pk_cargos_docente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_docente
    ADD CONSTRAINT pk_cargos_docente PRIMARY KEY (id_cargo);


--
-- Name: pk_cargos_unne; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_unne
    ADD CONSTRAINT pk_cargos_unne PRIMARY KEY (id_cargo_unne);


--
-- Name: pk_carrera_dependencia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carrera_dependencia
    ADD CONSTRAINT pk_carrera_dependencia PRIMARY KEY (id_dependencia, id_carrera);


--
-- Name: pk_carreras; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carreras
    ADD CONSTRAINT pk_carreras PRIMARY KEY (id_carrera);


--
-- Name: pk_categorias_conicet; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias_conicet
    ADD CONSTRAINT pk_categorias_conicet PRIMARY KEY (id_cat_conicet);


--
-- Name: pk_categorias_incentivos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias_incentivos
    ADD CONSTRAINT pk_categorias_incentivos PRIMARY KEY (id_cat_incentivos);


--
-- Name: pk_color_carpeta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY color_carpeta
    ADD CONSTRAINT pk_color_carpeta PRIMARY KEY (id_color);


--
-- Name: pk_comision_asesora; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_asesora
    ADD CONSTRAINT pk_comision_asesora PRIMARY KEY (id_area_conocimiento, id_convocatoria);


--
-- Name: pk_convocatoria_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY convocatoria_beca
    ADD CONSTRAINT pk_convocatoria_beca PRIMARY KEY (id_convocatoria);


--
-- Name: pk_cumplimiento_obligacion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cumplimiento_obligacion
    ADD CONSTRAINT pk_cumplimiento_obligacion PRIMARY KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca, mes, anio);


--
-- Name: pk_dedicacion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dedicacion
    ADD CONSTRAINT pk_dedicacion PRIMARY KEY (id_dedicacion);


--
-- Name: pk_dependencias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencias
    ADD CONSTRAINT pk_dependencias PRIMARY KEY (id_dependencia);


--
-- Name: pk_docentes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY docentes
    ADD CONSTRAINT pk_docentes PRIMARY KEY (id_tipo_doc, nro_documento);


--
-- Name: pk_inscripcion_conv_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT pk_inscripcion_conv_beca PRIMARY KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: pk_integrante_comision_asesora; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY integrante_comision_asesora
    ADD CONSTRAINT pk_integrante_comision_asesora PRIMARY KEY (nro_documento, id_tipo_doc, id_convocatoria, id_area_conocimiento);


--
-- Name: pk_localidades; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidades
    ADD CONSTRAINT pk_localidades PRIMARY KEY (id_pais, id_provincia, id_localidad);


--
-- Name: pk_motivos_baja; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY motivos_baja
    ADD CONSTRAINT pk_motivos_baja PRIMARY KEY (id_motivo_baja);


--
-- Name: pk_niveles_academicos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY niveles_academicos
    ADD CONSTRAINT pk_niveles_academicos PRIMARY KEY (id_nivel_academico);


--
-- Name: pk_paises; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pk_paises PRIMARY KEY (id_pais);


--
-- Name: pk_personas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT pk_personas PRIMARY KEY (nro_documento, id_tipo_doc);


--
-- Name: pk_provincias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincias
    ADD CONSTRAINT pk_provincias PRIMARY KEY (id_provincia, id_pais);


--
-- Name: pk_proyectos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT pk_proyectos PRIMARY KEY (id_proyecto);


--
-- Name: pk_requisitos_convocatoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requisitos_convocatoria
    ADD CONSTRAINT pk_requisitos_convocatoria PRIMARY KEY (id_requisito);


--
-- Name: pk_requisitos_insc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requisitos_insc
    ADD CONSTRAINT pk_requisitos_insc PRIMARY KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca, id_requisito);


--
-- Name: pk_resoluciones; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resoluciones
    ADD CONSTRAINT pk_resoluciones PRIMARY KEY (nro_resol, anio, id_tipo_resol);


--
-- Name: pk_resultado_avance; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resultado_avance
    ADD CONSTRAINT pk_resultado_avance PRIMARY KEY (id_resultado);


--
-- Name: pk_tipo_documento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_documento
    ADD CONSTRAINT pk_tipo_documento PRIMARY KEY (id_tipo_doc);


--
-- Name: pk_tipos_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_beca
    ADD CONSTRAINT pk_tipos_beca PRIMARY KEY (id_tipo_beca);


--
-- Name: pk_tipos_convocatoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_convocatoria
    ADD CONSTRAINT pk_tipos_convocatoria PRIMARY KEY (id_tipo_convocatoria);


--
-- Name: pk_tipos_resolucion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_resolucion
    ADD CONSTRAINT pk_tipos_resolucion PRIMARY KEY (id_tipo_resol);


--
-- Name: pk_universidades; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY universidades
    ADD CONSTRAINT pk_universidades PRIMARY KEY (id_universidad);


--
-- Name: uk_provincia_pais; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincias
    ADD CONSTRAINT uk_provincia_pais UNIQUE (id_pais, provincia);


--
-- Name: uq_carreras_carrera; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carreras
    ADD CONSTRAINT uq_carreras_carrera UNIQUE (carrera);


--
-- Name: uq_convocatoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY convocatoria_beca
    ADD CONSTRAINT uq_convocatoria UNIQUE (convocatoria);


--
-- Name: uq_dependencias_dependencia-universidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencias
    ADD CONSTRAINT "uq_dependencias_dependencia-universidad" UNIQUE (nombre, id_universidad);


--
-- Name: uq_nivel_academico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY niveles_academicos
    ADD CONSTRAINT uq_nivel_academico UNIQUE (nivel_academico);


--
-- Name: uq_proyectos_proyecto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT uq_proyectos_proyecto UNIQUE (proyecto);


--
-- Name: uq_universidades_universidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY universidades
    ADD CONSTRAINT uq_universidades_universidad UNIQUE (universidad, id_pais);


--
-- Name: fk_areas_dependencia_dependencia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY areas_dependencia
    ADD CONSTRAINT fk_areas_dependencia_dependencia FOREIGN KEY (id_dependencia) REFERENCES dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_avance_beca_resultado_avance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avance_beca
    ADD CONSTRAINT fk_avance_beca_resultado_avance FOREIGN KEY (id_resultado) REFERENCES resultado_avance(id_resultado) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_baja_becas_becasotorgadas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY baja_becas
    ADD CONSTRAINT fk_baja_becas_becasotorgadas FOREIGN KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca) REFERENCES becas_otorgadas(id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: fk_baja_becas_motivo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY baja_becas
    ADD CONSTRAINT fk_baja_becas_motivo FOREIGN KEY (id_motivo_baja) REFERENCES motivos_baja(id_motivo_baja) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_becas_otorgadas_inscconvbeca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY becas_otorgadas
    ADD CONSTRAINT fk_becas_otorgadas_inscconvbeca FOREIGN KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca) REFERENCES inscripcion_conv_beca(id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_becas_otorgadas_resol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY becas_otorgadas
    ADD CONSTRAINT fk_becas_otorgadas_resol FOREIGN KEY (id_tipo_resol, nro_resol, anio) REFERENCES resoluciones(id_tipo_resol, nro_resol, anio);


--
-- Name: fk_cargos_doc_dedicacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_docente
    ADD CONSTRAINT fk_cargos_doc_dedicacion FOREIGN KEY (id_dedicacion) REFERENCES dedicacion(id_dedicacion) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_cargos_docente_cargo_unne; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_docente
    ADD CONSTRAINT fk_cargos_docente_cargo_unne FOREIGN KEY (id_cargo_unne) REFERENCES cargos_unne(id_cargo_unne) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_cargos_docente_dependencias; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_docente
    ADD CONSTRAINT fk_cargos_docente_dependencias FOREIGN KEY (id_dependencia) REFERENCES dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_cargos_docente_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_docente
    ADD CONSTRAINT fk_cargos_docente_docente FOREIGN KEY (nro_documento, id_tipo_doc) REFERENCES docentes(nro_documento, id_tipo_doc) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_carrera_dependencia_carreras; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carrera_dependencia
    ADD CONSTRAINT fk_carrera_dependencia_carreras FOREIGN KEY (id_carrera) REFERENCES carreras(id_carrera) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_carrera_dependencia_dependencias; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carrera_dependencia
    ADD CONSTRAINT fk_carrera_dependencia_dependencias FOREIGN KEY (id_dependencia) REFERENCES dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_comision_asesora_area_conocimiento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_asesora
    ADD CONSTRAINT fk_comision_asesora_area_conocimiento FOREIGN KEY (id_area_conocimiento) REFERENCES area_conocimiento(id_area_conocimiento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_comision_asesora_convocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_asesora
    ADD CONSTRAINT fk_comision_asesora_convocatoria FOREIGN KEY (id_convocatoria) REFERENCES convocatoria_beca(id_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_convocatoria_beca_tipoconvocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY convocatoria_beca
    ADD CONSTRAINT fk_convocatoria_beca_tipoconvocatoria FOREIGN KEY (id_tipo_convocatoria) REFERENCES tipos_convocatoria(id_tipo_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_cumplimiento_obligacion_becaotorgada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cumplimiento_obligacion
    ADD CONSTRAINT fk_cumplimiento_obligacion_becaotorgada FOREIGN KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca) REFERENCES becas_otorgadas(id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_dependencia_localidad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencias
    ADD CONSTRAINT fk_dependencia_localidad FOREIGN KEY (id_pais, id_provincia, id_localidad) REFERENCES localidades(id_pais, id_provincia, id_localidad) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_dependencias_universidades; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencias
    ADD CONSTRAINT fk_dependencias_universidades FOREIGN KEY (id_universidad) REFERENCES universidades(id_universidad) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_docente_cat_conicet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY docentes
    ADD CONSTRAINT fk_docente_cat_conicet FOREIGN KEY (id_cat_conicet) REFERENCES categorias_conicet(id_cat_conicet) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_docente_dep_conicet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY docentes
    ADD CONSTRAINT fk_docente_dep_conicet FOREIGN KEY (id_dependencia_conicet) REFERENCES dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_docentes_categorias_incentivos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY docentes
    ADD CONSTRAINT fk_docentes_categorias_incentivos FOREIGN KEY (id_cat_incentivos) REFERENCES categorias_incentivos(id_cat_incentivos) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_docentes_personas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY docentes
    ADD CONSTRAINT fk_docentes_personas FOREIGN KEY (id_tipo_doc, nro_documento) REFERENCES personas(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_insc_conv_beca_codir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_insc_conv_beca_codir FOREIGN KEY (id_tipo_doc_codir, nro_documento_codir) REFERENCES docentes(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_insc_conv_beca_dir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_insc_conv_beca_dir FOREIGN KEY (id_tipo_doc_dir, nro_documento_dir) REFERENCES docentes(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_insc_conv_beca_idproyecto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_insc_conv_beca_idproyecto FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_insc_conv_beca_lugartrabajo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_insc_conv_beca_lugartrabajo FOREIGN KEY (lugar_trabajo_becario) REFERENCES dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_insc_conv_beca_subdir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_insc_conv_beca_subdir FOREIGN KEY (id_tipo_doc_subdir, nro_documento_subdir) REFERENCES docentes(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca_area_conocimiento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_area_conocimiento FOREIGN KEY (id_area_conocimiento) REFERENCES area_conocimiento(id_area_conocimiento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_inscripcion_conv_beca_dependencias; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_dependencias FOREIGN KEY (id_dependencia) REFERENCES dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_inscripcion_conv_beca_idconvocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_idconvocatoria FOREIGN KEY (id_convocatoria) REFERENCES convocatoria_beca(id_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca_idtipobeca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_idtipobeca FOREIGN KEY (id_tipo_beca) REFERENCES tipos_beca(id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca_personas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_personas FOREIGN KEY (id_tipo_doc, nro_documento) REFERENCES personas(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_inscripcion_conv_becas_carrera; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_becas_carrera FOREIGN KEY (id_carrera) REFERENCES carreras(id_carrera) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_integrante_comision_asesora_comision_asesora; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY integrante_comision_asesora
    ADD CONSTRAINT fk_integrante_comision_asesora_comision_asesora FOREIGN KEY (id_convocatoria, id_area_conocimiento) REFERENCES comision_asesora(id_convocatoria, id_area_conocimiento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_integrante_comision_asesora_personas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY integrante_comision_asesora
    ADD CONSTRAINT fk_integrante_comision_asesora_personas FOREIGN KEY (id_tipo_doc, nro_documento) REFERENCES personas(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_localidades_provincias; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidades
    ADD CONSTRAINT fk_localidades_provincias FOREIGN KEY (id_pais, id_provincia) REFERENCES provincias(id_pais, id_provincia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_personas_localidades; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT fk_personas_localidades FOREIGN KEY (id_pais, id_localidad, id_provincia) REFERENCES localidades(id_pais, id_localidad, id_provincia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_personas_nivel_academico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT fk_personas_nivel_academico FOREIGN KEY (id_nivel_academico) REFERENCES niveles_academicos(id_nivel_academico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_personas_tipo_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT fk_personas_tipo_documento FOREIGN KEY (id_tipo_doc) REFERENCES tipo_documento(id_tipo_doc) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_provincias_paises; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincias
    ADD CONSTRAINT fk_provincias_paises FOREIGN KEY (id_pais) REFERENCES paises(id_pais) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_requisitos_convocatoria_id_convocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requisitos_convocatoria
    ADD CONSTRAINT fk_requisitos_convocatoria_id_convocatoria FOREIGN KEY (id_convocatoria) REFERENCES convocatoria_beca(id_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_requisitos_insc_idrequisito; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requisitos_insc
    ADD CONSTRAINT fk_requisitos_insc_idrequisito FOREIGN KEY (id_requisito) REFERENCES requisitos_convocatoria(id_requisito) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_requisitos_insc_inscripcion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requisitos_insc
    ADD CONSTRAINT fk_requisitos_insc_inscripcion FOREIGN KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca) REFERENCES inscripcion_conv_beca(id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_resoluciones_id_tipo_resol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resoluciones
    ADD CONSTRAINT fk_resoluciones_id_tipo_resol FOREIGN KEY (id_tipo_resol) REFERENCES tipos_resolucion(id_tipo_resol) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_tipos_beca_idcolor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_beca
    ADD CONSTRAINT fk_tipos_beca_idcolor FOREIGN KEY (id_color) REFERENCES color_carpeta(id_color) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_tipos_beca_tipoconvocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_beca
    ADD CONSTRAINT fk_tipos_beca_tipoconvocatoria FOREIGN KEY (id_tipo_convocatoria) REFERENCES tipos_convocatoria(id_tipo_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_universidades_paises; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY universidades
    ADD CONSTRAINT fk_universidades_paises FOREIGN KEY (id_pais) REFERENCES paises(id_pais) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

