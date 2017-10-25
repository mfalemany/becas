--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
    id_tipo_convocatoria smallint
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
    id_nivel_academico smallint
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
-- Name: area_conocimiento id_area_conocimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY area_conocimiento ALTER COLUMN id_area_conocimiento SET DEFAULT nextval('be_area_conocimiento_id_area_conocimiento_seq'::regclass);


--
-- Name: areas_dependencia id_area; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY areas_dependencia ALTER COLUMN id_area SET DEFAULT nextval('be_areas_dependencia_id_area_seq'::regclass);


--
-- Name: avance_beca id_avance; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avance_beca ALTER COLUMN id_avance SET DEFAULT nextval('be_avance_beca_id_avance_seq'::regclass);


--
-- Name: cargos_docente id_cargo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_docente ALTER COLUMN id_cargo SET DEFAULT nextval('be_cargos_docente_id_cargo_seq'::regclass);


--
-- Name: cargos_unne id_cargo_unne; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_unne ALTER COLUMN id_cargo_unne SET DEFAULT nextval('be_cargos_unne_id_cargo_unne_seq'::regclass);


--
-- Name: carreras id_carrera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carreras ALTER COLUMN id_carrera SET DEFAULT nextval('be_carreras_id_carrera_seq'::regclass);


--
-- Name: categorias_conicet id_cat_conicet; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias_conicet ALTER COLUMN id_cat_conicet SET DEFAULT nextval('categorias_conicet_id_cat_conicet_seq'::regclass);


--
-- Name: categorias_incentivos id_cat_incentivos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias_incentivos ALTER COLUMN id_cat_incentivos SET DEFAULT nextval('be_categorias_incentivos_id_cat_incentivos_seq'::regclass);


--
-- Name: color_carpeta id_color; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY color_carpeta ALTER COLUMN id_color SET DEFAULT nextval('color_carpeta_id_color_seq'::regclass);


--
-- Name: convocatoria_beca id_convocatoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY convocatoria_beca ALTER COLUMN id_convocatoria SET DEFAULT nextval('convocatoria_beca_id_convocatoria_seq'::regclass);


--
-- Name: dedicacion id_dedicacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dedicacion ALTER COLUMN id_dedicacion SET DEFAULT nextval('be_dedicacion_id_dedicacion_seq'::regclass);


--
-- Name: dependencias id_dependencia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencias ALTER COLUMN id_dependencia SET DEFAULT nextval('be_dependencias_id_dependencia_seq'::regclass);


--
-- Name: localidades id_localidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidades ALTER COLUMN id_localidad SET DEFAULT nextval('be_localidades_id_localidad_seq'::regclass);


--
-- Name: niveles_academicos id_nivel_academico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY niveles_academicos ALTER COLUMN id_nivel_academico SET DEFAULT nextval('niveles_academicos_id_nivel_academico_seq'::regclass);


--
-- Name: provincias id_provincia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincias ALTER COLUMN id_provincia SET DEFAULT nextval('be_provincias_id_provincia_seq'::regclass);


--
-- Name: requisitos_convocatoria id_requisito; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requisitos_convocatoria ALTER COLUMN id_requisito SET DEFAULT nextval('requisitos_convocatoria_id_requisito_seq'::regclass);


--
-- Name: resultado_avance id_resultado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resultado_avance ALTER COLUMN id_resultado SET DEFAULT nextval('be_resultado_avance_id_resultado_seq'::regclass);


--
-- Name: tipo_documento id_tipo_doc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_documento ALTER COLUMN id_tipo_doc SET DEFAULT nextval('be_tipo_documento_id_tipo_doc_seq'::regclass);


--
-- Name: tipos_beca id_tipo_beca; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_beca ALTER COLUMN id_tipo_beca SET DEFAULT nextval('tipos_beca_id_tipo_beca_seq'::regclass);


--
-- Name: tipos_convocatoria id_tipo_convocatoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_convocatoria ALTER COLUMN id_tipo_convocatoria SET DEFAULT nextval('tipos_convocatoria_id_tipo_convocatoria_seq'::regclass);


--
-- Name: tipos_resolucion id_tipo_resol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_resolucion ALTER COLUMN id_tipo_resol SET DEFAULT nextval('be_tipos_resolucion_id_tipo_resol_seq'::regclass);


--
-- Name: universidades id_universidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY universidades ALTER COLUMN id_universidad SET DEFAULT nextval('be_universidades_id_universidad_seq'::regclass);


--
-- Data for Name: area_conocimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY area_conocimiento (id_area_conocimiento, area_conocimiento) FROM stdin;
1	Matemática
2	Biología
3	Química
4	Física
5	Astronomía
6	Suelo
7	Mecánica
8	Termodinámica
9	Ecología
10	Agua
\.


--
-- Data for Name: areas_dependencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY areas_dependencia (id_area, area, id_dependencia) FROM stdin;
1	Departamento de Matemática	1
2	Departamento de Ingeniería Aplicada	6
3	Area contable	3
4	Departamento de Economía	4
5	Departamento de Letras	4
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

SELECT pg_catalog.setval('be_area_conocimiento_id_area_conocimiento_seq', 10, true);


--
-- Name: be_areas_dependencia_id_area_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_areas_dependencia_id_area_seq', 5, true);


--
-- Name: be_avance_beca_id_avance_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_avance_beca_id_avance_seq', 1, false);


--
-- Name: be_cargos_docente_id_cargo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_cargos_docente_id_cargo_seq', 6, true);


--
-- Name: be_cargos_unne_id_cargo_unne_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_cargos_unne_id_cargo_unne_seq', 6, true);


--
-- Name: be_carreras_id_carrera_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_carreras_id_carrera_seq', 2, true);


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

SELECT pg_catalog.setval('be_dependencias_id_dependencia_seq', 7, true);


--
-- Name: be_localidades_id_localidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_localidades_id_localidad_seq', 7, true);


--
-- Name: be_paises_id_pais_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_paises_id_pais_seq', 1, false);


--
-- Name: be_provincias_id_provincia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_provincias_id_provincia_seq', 14, true);


--
-- Name: be_resultado_avance_id_resultado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_resultado_avance_id_resultado_seq', 1, false);


--
-- Name: be_tipo_documento_id_tipo_doc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_tipo_documento_id_tipo_doc_seq', 5, true);


--
-- Name: be_tipos_resolucion_id_tipo_resol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_tipos_resolucion_id_tipo_resol_seq', 4, true);


--
-- Name: be_universidades_id_universidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('be_universidades_id_universidad_seq', 7, true);


--
-- Data for Name: becas_otorgadas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY becas_otorgadas (nro_resol, anio, nro_documento, id_tipo_doc, id_convocatoria, fecha_desde, fecha_hasta, fecha_toma_posesion, id_tipo_resol, id_tipo_beca) FROM stdin;
\.


--
-- Data for Name: cargos_docente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cargos_docente (id_dependencia, id_dedicacion, id_cargo_unne, id_cargo, fecha_desde, fecha_hasta, estado, id_tipo_doc, nro_documento) FROM stdin;
3	3	3	1	2017-09-26	2017-09-26	A	\N	\N
3	3	3	2	2017-09-26	\N	A	\N	\N
5	3	3	3	2017-10-02	2018-10-08	A	1	31255073
4	1	1	5	2012-01-01	2018-09-12	A	1	32405039
5	3	3	4	2017-10-09	2016-10-26	A	1	32405039
2	2	3	6	1998-01-01	2005-02-10	A	1	1
\.


--
-- Data for Name: cargos_unne; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cargos_unne (cargo, id_cargo_unne) FROM stdin;
Titular	1
Suplente	2
Adjunto	3
Interino	4
Jefe de Trabajos Prácticos	5
Auxiliar de Docencia	6
\.


--
-- Data for Name: carrera_dependencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY carrera_dependencia (id_dependencia, id_carrera) FROM stdin;
5	1
6	1
7	2
1	1
\.


--
-- Data for Name: carreras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY carreras (id_carrera, carrera, cod_araucano) FROM stdin;
1	Ingenieria Agronómica	102
2	Ingeniería en Alimentos	12121
\.


--
-- Data for Name: categorias_conicet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categorias_conicet (id_cat_conicet, nro_categoria, categoria) FROM stdin;
6	1	Investigador Asistente
7	2	Investigador Adjunto
8	3	Investigador Independiente
9	4	Investigador Principal
10	5	Investigador Superior
\.


--
-- Name: categorias_conicet_id_cat_conicet_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categorias_conicet_id_cat_conicet_seq', 10, true);


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
1	Amarillo
2	Verde
3	Rosa
\.


--
-- Name: color_carpeta_id_color_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('color_carpeta_id_color_seq', 3, true);


--
-- Data for Name: comision_asesora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comision_asesora (id_area_conocimiento, id_convocatoria) FROM stdin;
4	2
\.


--
-- Data for Name: convocatoria_beca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY convocatoria_beca (fecha_desde, fecha_hasta, limite_movimientos, id_convocatoria, convocatoria, id_tipo_convocatoria) FROM stdin;
2016-01-01	2016-12-30	2016-12-31	4	Becas Cofinanciadas UNNE-CONICET 2016	3
2017-10-01	2017-10-26	2017-11-03	3	Convocatoria EVC-CIN - 2017	2
2017-10-02	2017-10-30	2017-11-10	2	Convocatoria CyT - UNNE - 2016	1
\.


--
-- Name: convocatoria_beca_id_convocatoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('convocatoria_beca_id_convocatoria_seq', 4, true);


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
1	Facultad de Ciencias Agrarias	FCA	1	\N	\N	\N	\N	\N
2	Facultad de Ciencias Exactas, Naturales y Agrimensura	FACENA	1	\N	\N	\N	\N	\N
3	Facultad de Arquitectura	FA	2	\N	\N	\N	\N	\N
4	Facultad de Humanidades	FHum	3	\N	\N	\N	\N	\N
6	Facultad de Ingeniería	FIng	3	\N	\N	\N	\N	\N
7	Facultad de Ingeniería	FIng	5	\N	\N	\N	\N	\N
5	Departamento de Idiomas Modernos	DIM	1	54	2	3	\N	\N
\.


--
-- Data for Name: docentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY docentes (nro_documento, id_tipo_doc, legajo, id_cat_incentivos, id_cat_conicet, id_dependencia_conicet) FROM stdin;
31255073	1	12000	1	7	5
55241374	1	2	1	10	6
32405039	1	1	1	7	\N
1	1	12	2	8	1
\.


--
-- Data for Name: inscripcion_conv_beca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY inscripcion_conv_beca (id_dependencia, nro_documento, id_tipo_doc, id_convocatoria, fecha_hora, admisible, puntaje, beca_otorgada, id_area_conocimiento, titulo_plan_beca, justif_codirector, id_carrera, materias_plan, materias_aprobadas, prom_hist_egresados, prom_hist, carrera_posgrado, nombre_inst_posgrado, titulo_carrera_posgrado, nro_carpeta, observaciones, estado, cant_fojas, es_titular, id_tipo_beca, id_proyecto, es_egresado, anio_ingreso, anio_egreso, fecha_insc_posgrado, lugar_trabajo_becario, area_trabajo, id_tipo_doc_dir, nro_documento_dir, id_tipo_doc_codir, nro_documento_codir, id_tipo_doc_subdir, nro_documento_subdir) FROM stdin;
1	55241374	1	2	\N	\N	\N	\N	1	Titulo cualquiera	Tiene moneda	1	2	2	2.00	2.00	\N	\N	\N	\N	\N	A	\N	S	2	229	0	2	\N	\N	1	Dpto Matematica	1	55241374	1	31255073	\N	\N
7	31255073	1	2	\N	N	32.000	f	10	Algo	\N	2	2	2	2.00	2.00	\N	\N	\N	\N	\N	A	\N	S	1	66	0	2005	\N	\N	7	asdas	1	31255073	\N	\N	\N	\N
7	32405039	1	2	2017-10-23 00:00:00	N	\N	f	10	1	\N	2	1	1	1.00	1.00	\N	\N	\N	\N	\N	A	\N	S	1	455	0	2005	\N	\N	7	Cualqueira	1	32405039	\N	\N	\N	\N
7	32405039	1	3	2017-10-23 00:00:00	N	\N	f	10	Algo	\N	2	1	1	1.00	1.00	\N	\N	\N	\N	\N	A	\N	S	5	446	0	1	\N	\N	3	Área de Sarasa	1	32405039	\N	\N	\N	\N
1	18349410	1	2	2017-10-23 00:00:00	N	130.000	f	5	Me voy a rascar	\N	1	41	37	7.36	7.30	\N	\N	\N	123	\N	A	10	S	1	357	0	1995	\N	\N	1	Bedelia	1	32405039	\N	\N	\N	\N
7	18349410	1	4	2017-10-25 00:00:00	\N	42.300	\N	10	Hacer algo	\N	2	31	28	9.26	8.32	\N	\N	\N	\N	\N	A	\N	S	4	441	0	1990	\N	\N	7	Bedelia	1	1	\N	\N	\N	\N
\.


--
-- Data for Name: integrante_comision_asesora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY integrante_comision_asesora (nro_documento, id_tipo_doc, id_convocatoria, id_area_conocimiento) FROM stdin;
32405039	1	2	4
55241374	1	2	4
31255073	1	2	4
\.


--
-- Data for Name: localidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY localidades (id_provincia, id_pais, id_localidad, localidad, codigo_postal) FROM stdin;
6	54	2	Lomas de Zamora	\N
2	54	3	Resistencia	\N
5	54	4	Parana	\N
3	54	5	Clorinda	\N
1	54	6	Ituzaingo	\N
6	54	7	Ituzaingo	\N
1	54	1	Corrientes	3400
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
Secundario	1	3
Pre-Grado	2	4
Grado	3	5
Especialización	4	6
Maestría	5	7
Doctorado	6	8
Posdoctorado	7	9
\.


--
-- Name: niveles_academicos_id_nivel_academico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('niveles_academicos_id_nivel_academico_seq', 10, true);


--
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY paises (id_pais, pais) FROM stdin;
54	Argentina
591	Bolivia
595	Paraguay
598	Uruguay
55	Brasil
51	Peru
56	Chile
57	Colombia
593	Ecuador
\.


--
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY personas (nro_documento, id_tipo_doc, apellido, nombres, cuil, fecha_nac, celular, email, telefono, id_localidad, id_provincia, id_pais, id_nivel_academico) FROM stdin;
31255073	1	Morales	Susana Beatriz	27312550739	1984-11-23	0379-154551427	susanabeatrizmorales1@gmail.com	No tiene	4	5	54	3
32405039	1	Alemany	Marcelo Federico	20324050397	1986-07-17	0379-154844649	mfalemany@gmail.com	No tiene	1	1	54	9
55241374	1	Alemany Morales	Marcelo Ricardo	20552413742	2016-02-16	\N	\N	\N	1	1	54	3
18349410	1	Dure	Guillermo Ernesto	\N	1967-10-07	15246989	dureguier@gmail.com	3794-844444	1	1	54	3
1	1	Baglieto	Juan Carlos	\N	1942-11-01	3794551433	era_en_abril@gmail.com	No tiene	2	6	54	3
\.


--
-- Data for Name: provincias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY provincias (id_pais, id_provincia, provincia) FROM stdin;
54	1	Corrientes
54	2	Chaco
54	3	Formosa
54	4	Misiones
54	5	Entre Rios
54	6	Buenos Aires
54	7	Santiago del Estero
54	8	Jujuy
54	9	Catamarca
54	10	Santa Fe
54	12	Mendoza
51	14	Lima
\.


--
-- Data for Name: proyectos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY proyectos (proyecto, codigo, id_proyecto) FROM stdin;
Efectos colaterales del crecimiento edilicio de la ciudad de Resistencia. 	12D005	72
Antroposemiótica de las prácticas culturales. Análisis del tatuaje carcelario en las ciudades de Corrientes y Paraná. 	13H003	208
 Construcciones metodológicas en la educación inicial: interacción didáctica y concepciones docentes. 	13H007	212
El sesgo de género en los discursos de los siglos XVIII-XX. 	13H012	216
Satisfacción de necesidades de Alimentación Enteral Específica en Corrientes Capital. Estudio exploratorio nosocomial y domiciliario. 	13I006	220
El crecimiento industrial de Puerto Tirol: un caso de desarrollo local endogeno? 	13M004	232
Desarrollo de metodología para pronóstico de producción envariedades citrícolas de interés en el NEA 	13CA03	181
Evaluación in vitro de la miogenesis luego de la intoxicación con venenos de serpientes de la flia. Viperidae de la región nordeste de argentina. 	13CF02	185
Estudio del comportamiento resistente y relación tensión - deformación en suelos arcillosos del área metropolitana del Gran Resistencia. 2ª etapa. 	13D005	189
Cuantificación y tipificación de Áreas Urbanas Deficitarias Críticas para la intervención integral del hábitat social del Gran Resistencia 	12SC01	406
Bases atómicas topográficas aplicadas en anatomía quirúrgicas del tratamiento oncológico. 	01/14	424
Desarrollo normal del sistema nervioso central. Su expresión en estudios prenatales de diagnóstico por imágenes. 	12/14	432
Evolución clínica de lesiones cutáneas tratadas con fisioterapia en pacientes con enfermedades crónicas prevalentes en hospitales públicos de Corrientes. 	22/14	441
Modelado de sistemas de puntos cuánticos: estructura electrónica y propiedades electromagnéticas 	PICT 2012-2866	446
La población y su territorio. La acción antrópica en la configuración territorial del Iberá (Corrientes, Argentina). 	12IH01	120
Estudios biosistematicos y biogeograficos en plantas vasculares americanas, con énfasis en Sapindaceae, Malvaceae- Grewioideae y  	PICTO 2011-202	452
Dispositivos de acompañamiento en la formación, su incidencia en las prácticas docentes. 	13H004	209
La formación de docentes en educación infantil entre el neoliberalismo y la construcción de ciudadanía. 	13H008	213
Fortalezas en alumnos ingresantes a la Facultad de Medicina de la UNNE. 	13I001	217
Determinación inmunohistoquímica de ghrelina en odontoblastos de piezas dentarias permanentes. 	13J003	224
Relación entre lactato deshidrogenasa en saliva y estado periodontal en pacientes de la Facultad de Odontología de la UNNE. 	13J004	225
Crisis, transformaciones productivas, y políticas públicas. El desarrollo económico y social en la Provincia del Chaco en la segunda mitad del siglo XX. 	13M001	229
Competitividad, ingresos y políticas públicas regionales. 	13M006	233
Salud intestinal y producción en pollos alimentados con leguminosa de grano en reemplazo parcial de la soja 	13CB01	182
Optimización y control de las radiaciones no ionizantes. 	13F015	200
Una netbook solar para cada alumno de una escuela rural. 	13F016	201
Estudios filopgeneticos en Rubiaceae, Balanophoeaceae, Hydnoraceae y Poaceae basados en un enfoque multidisciplinario 	PICTO 2011-199	453
Develando mitos y leyendas sobre el uso y aplicación de plantas contra picaduras de víboras en el Nordeste Argentino 	PICTO 2011-196	459
Ecoepidemiología de las enfermedades transmisibles y emergentes en el departamento de Santo Tome (en la zona de la futura represa Garabí). 	13I009	221
Aspectos de la producción y calidad de carne bubalina. 	14CB03	263
Movimientos sociales, conflictos y organizaciones en Corrientes y Chaco. Un estudio comparativo de situaciones. 	14CH01	266
Problemas de seguridad relacionados con el uso de medicamentos, dispositivos médicos y otras sustancias en el Nordeste Argentino. 	14CI01	269
Burnout de los trabajadores de la salud como factor participante en la seguridad del paciente. 	14CI04	272
Diseño e implementación de tecnica alternativa para detección de fibrosis quística en pacientes enfermos y portadores 	PFIP 2009	414
Patología vaginal Microbiana Prevalente y Genotipificación del HPV en mujeres asistidas en centros de atención primaria de la salud de Corrientes. 	02/14	425
Uso de la simulación clínica como herramienta de enseñanzas de competencias médicas. 	14/14	433
Las Áreas Urbanas Deficitarias Críticas como unidades de planificación e intervención de una política integral del hábitat social. 	PICT 2014-0999	447
La dimensión del hombre desde la perspectiva de la salud. 	12II01	121
Valorización de Productos Vegetales de la Region NEA. Mangos y Pomelos minimamente procesados tratados por la luz UV-C 	PICT BICENTEN. 2010-1496	465
Obtención de ovocitos para producción in vitro de embriones mediante la aplicación de implantes de melatonina en búfalas (Bubalus bubalis) con anestro estacional en el NEA 	PICT 2014-1385	472
Nematodes Parásitos en Anfibios del Nordeste Argentino: Aspectos Sistemáticos y Ecológicos. 	PICT 2012-0661	442
Análisis comparativo en caracteres de producción y adaptación al medio de Bovinos Angus seleccionados localmente y sus cruzas con Angus de cabaña y Brangus 3/8. 	11B003	6
Sistemática y ecología de los helmintos parásitos en anfibios del nordeste argentino 	02945	481
Los procedimientos provinciales para la prevención y solución de conflictos de usuarios y consumidores. 	13G005	206
Conocimiento profesional docente y buenas prácticas en la universidad 	13H005	210
Los sucesos críticos en la historia de formación de docentes universitarios y su relación con sus trayectos personales,profesionales y sociales:Nueve casos de profesores que inciaron sus trayectos profesionales en los años 50, 60 y 70 en una universidad nacional. 	13H009	214
Frecuencia de bocavirus y metapneumovirus en niños menores de 5 años en dos ciudades del norte argentino. 	13I003	218
Determinación de la estabilidad del color y resistencia a la compresión y flexión de dos materiales utilizados para la confección de coronas provisorias. 	13J001	222
Desarrollo estrategias para mejoramiento de la sanidad citrícola en variedades de interés del NEA 	13CA01	179
Estudios bioquímico-moleculares aplicables a la producción y sanidad de carnes. 	13CB02	183
Diseño y desarrollo de productos farmacéuticos para uso en medicina veterinaria. Control de calidad y eficacia clínica. 	13B016	171
Educación antitabáquica en atención primaria de la salud. 	12I004	101
Turismo comunitario rural en organizaciones de Productores Familiares del Departamento de San Cosme, Corrientes. 	14B012	254
Efectos de distintos programas de alimentación sobre el crecimiento y la reproducción en poblaciones maternas del pollo Campero INTA. 	14CB01	261
Aspectos de producción y calidad de carne bovina en el nordeste argentino. 	14CB04	264
El Río Paraná como escenario de conflicto. Actividades productivas, territorialidades y sujetos en las riberas de la Región Nordeste después del 2000. 	14CH02	267
Seguridad de los pacientes en ámbitos de práctica de estudiantes de la Carrera de Licenciatura en Enfermería. 	14CI02	270
Bancos Provinciales en el Nordeste Argentino. Una investigación comparativa sobre sus impáctos en las estructuras económicas y sociales de la región. 	14CM01	273
El HER 2 en el cáncer gástrico. Determinación de la expresión, biomarcador molecular. 	03/14	426
PRUNAPE - Prueba de pesquisa de trastornos de desarrollo en niños menores de 6 años en el primer nivel de escuelas primarias de Corrientes. 	15/14	434
Aislamiento de hongos autóctonos de la microbiota del tracto digestivo de peces nativos y evaluación de su potencial aplicación 	PICTO 2011-198	415
Biodiversidad de helmintos parásitos de planorbídeos y anfibios en arroceras de Corrientes, Argentina. 	11220150100119CO	443
Biodiversidad y conservación de los recursos vegetales del Iberá (Corrientes, Argentina). 	12IA01	110
Fauna íctica de la cuenca del Iberá: Nuevos aspectos de la diversidad y estructura de las comunidades de peces. 	12IB01	111
Hacia una comunidad saludable: perfil metabólico-infeccioso en ambientes de los Esteros del Iberá. 	12IF01	112
Evaluación de la biodiversidad de anfibios y reptiles del macrosistema Iberá (Corrientes, Argentina) e identificación de áreas prioritarias de conservación. 	12IF02	113
Medicación intraconducto utilizando gel de aloe vera y acondicionamiento final del conducto radicular. 	13J005	226
Evaluación espacio-temporal de las características físico-químicas de los sedimentos y las aguas de dos cursos tributarios del río Paraná. 	14Q004	357
La fauna de insectos y conchostracos del Triásico Medio a Superior de la Cuenca Cuyana: estudio sistemático, paleoecológico y bioestratigráfico. 	14Q006	359
Desarrollo de herramientas tecnológicas para la enseñanza de Educación vial a personas con discapacidades visuales y auditivas. 	14R001	361
La Atención Primaria de la Salud en Poblaciones Aborígenes Urbanas. El caso de los Barrios MAPIC y TOBA en Resistencia, Chaco. 	14S002	363
Estudios morfo-anatómicos, embriológicos y etnobotánicos en especies americanas de angiospermas. 	15A002	365
Efectos de las perturbaciones antrópicas sobre las comunidades de termitas en la Reserva Iberá (Corrientes) y su rol como bioindicadores. 	15F001	367
Diversidad, funciones y servicios ecosistémicos de arañas (araneae, arachnida) en áreas protegidas y productivas del chaco húmedo. 	15F003	369
Determinación de la eficacia del uso de plantas medicinales en las prácticas Odontológicas. 	15J001	371
Estudios biosistemáticos y filogenéticos en especies sudamericanas de Asteraceae y Plantaginaceae. 	15P002	373
Caracterizacion y evolucion cariotipica del genero Arachis por medio de hidridacion insitu flourescente y determinacion del con.. 	PICTO 2011-230	454
Aspectos dinámicos y moleculares del desarrollo in vitro de embriones de búfalo (Bubalus bubalis) 	PICT 2013-0346	404
Comprobar el comportamiento ético del Estudiante enfermero con miras a fortalecer sus actitudes y aptitudes para el ejercicio de la profesión. 	04/14	427
Integración teórica práctica en estudiantes del internado rotatotorio del área obstetricia. 	16/14	435
Indicadores Multitaxonómicos de Biodiversidad en el Sitio Ramsar Humedales Chaco. 	PICTO 2011-244	411
Paleoasociaciones (invertebrados y flora) del Neogeno del Noreste de Argentina: Taxonomia, Bioestratigrafia y Paleoambiente. 	PICTO 2011-216	444
Biodiversidad de heterópteros acuáticos y semiacuáticos (insecta) del Iberá (Provincia de Corrientes, Argentina). 	12IF03	114
Identificación y caracterización de factores que influyen en el componente bucal de la salud de los pobladores del Iberá. 	12IJ01	122
Analisis de los cambios gemónicos y epigenéticos que se producen durante los procesos de hidridacion y poliploidizacion utilidad 	PICTO 2011-260	460
Eco-epidemiología de Stegomyia albopicta (Diptera: Culicidae) en el nordeste de Argentina 	PICT 2014-2338	471
Tecnicas de Asimilacion de datos Regionales con Validacion y Aplicacion en el norte Argentino 	PICT 2011-2452	466
Estudio de patologías de origen genético y susceptibilidad a enfermedades con impacto sanitario-productivo en caballos de Argentina 	PICT 2012-2610	407
Historia de accesos y exclusiones a la cultura escrita en la Argentina. Concepciones, políticas y prácticas. Entre la colonia y el siglo XXI 	PICTO 2011-224	409
Producción de plantas de mandioca de cultivares de interés para el NEA mediante métodos biotecnológicos y evaluación del comportamiento agronómico. 	11A002	1
Biomonitoreo del estado sanitario en peces del Río Paraná. 	11B002	5
Elaboración de un plan estratégico para el Puerto de Barranqueras. 	11D003	8
Diversidad de artrópodos predadores, descomponedores y polinizadores del Chaco Oriental Húmedo. 	11F005	12
Bases internas de la competitividad de las PyMEs y su impacto en el área comercial en las ciudades de Rosario, Resistencia y Corrientes 	1ECO158	413
Sistemas de información y TIC: métodos y herramientas. 	11F013	14
Verdad real en el proceso, su interpretación por las sentencias de los superiores tribunales de justicia de las provincias del nordeste. Un análisis desde la teoría de la argumentación jurídica. 	11G006	19
Estudios de megafloras seleccionadas del triásico y jurásico de Argentina y sus vinculaciones con otras floras fósiles coetáneas de Gondwana. 	14Q005	358
El Sitio "Isla El Disparito" Laguna Trin, una ventana a la vida durante el Holoceno en el Macrosistema Iberá: estudio exploratorio interdisciplinario. 	14Q007	360
Visitas y encomiendas en el Paraguay Colonial. Un estudio de caso a mediados del siglo XVII. 	14S001	362
Optimización de prácticas agronómicas que inciden en la productividad y calidad de ananá (Ananas comosus L. Merr) en el NEA desde un enfoque ecofisiológico. 	15A001	364
Evaluación integral del origen del ligamento suspensorio del miembro anterior en equinos. 	15B001	366
Interacciones moleculares en complejos modelo pequeños y su efecto sobre las propiedades magnéticas de los mismos. 	15F002	368
Estimación de parámetros en modelos de crecimiento de tumores y modelos multiescala para sistemas complejos vivientes. 	15F004	370
Estudios de origen, diversidad genética e historia evolutiva de las especies invasoras del género cardiospermum (sapindaceae) y senecio madagascariensis poir. (asteraceae): un instrumento para la gestión de control biológico. 	15P001	372
Hongos agaricoides de la Selva Atlántica Argentina. Análisis de comunidades en ambientes naturales y forestados. 	15P003	374
Desarrollo de protocolos de diagnóstico de aplicación en medicina oncológica. 	14I011	333
Prevalencia de sobrepeso y obesidad en escolares de la ciudad de Corrientes. 	05/14	428
Diseño de un currículum complementario interdisciplinario como estrategia para la integración de carreras de grado en Ciencias de la Salud. 	17/14	436
Nuevos aportes al analisis y genotoxicidad de residuos de pesticidad en agua y alimentos 	PICTO 2011-240	445
Estudio comparativo de la diversidad de artrópodos en ecosistemas terrestres del Iberá, Corrientes, Argentina. 	12IF04	115
Estado ecológico actual del Iberá (Corrientes, Argentina). 	12IF08	448
El peronismo: entre el gobierno y la oposicion. Actores y prácticas politicas en Corrientes, Chaco y Formosa (1945-1973 	PICTO 2011-210	455
Desarrollo de sistemas de propagación masiva de especies leñosas basados en el uso de biorreactores de inmersion temporal 	PICTO 2011-213	461
Evaluación de los recursos pesqueros aguas abajo de la represa de Yacyretá 	CONVENIO ACTA 25	408
Análisis de la vía del PI3-K/AKT y de su efector, FoxO3a, en los mecanismos moleculares involucrados en la acción antiapoptótica de la Eritropoyetina. 	PIP N° 112-201106-00016	410
Estudios biosistemáticos y biogeográficos en plantas vasculares americanas, con énfasis en Sapindaceae y Malvaceae-Grewioideae 	13A012	153
Importancia de la reproducción sexual en diferentes sistemas genéticos y en el mejoramiento genético del género paspalum. 	11A003	2
Análisis de estabilidad y falla localizada en taludes de suelos empleados como defensa contra inundaciones en el Gran Resistencia. 	11D001	7
Propiedades fisicoquímicas y funcionales de legumbres cultivadas en el NEA. 	11F003	11
Las prácticas docentes de Nivel Primario para Jóvenes y Adultos en contextos de Interculturalidad. Análisis de un caso en la Provincia del Chaco en el Nordeste Argentino 	445/13 CD	412
Propiedades de interés industrial en bacterias lácticas autóctonas de Corrientes II. 	11F011	13
Violencia de Género: conflicto entre derechos humanos de las mujeres y prácticas sociales e institucionales en Corrientes (período 2000-2010). Análisis desde una perspectiva jurídica y política de género. 	11G002	16
Degradación ruminal de tres especies forrajeras en cabras y evaluación de su potencial nutricional en la terminación de cabritos. 	12B005	62
Desarrollo de un scanner 3D y tecnología complementaria. 	14F024	304
Análisis de Seguridad y Predicción temprana de falla localizada en taludes de suelos empleados como defensa contra inundaciones en el Gran resistencia. 	PICT JOVENES 2013-0790	467
Refrigeración solar por compresion de vapor de capacidad variable y almacenamiento en cambio de fase alimentado con generación eléctrica fotovoltaica. 	14F006	287
Interpretación fisio-patológica de los diferentes tipos de shock. Estudio experimental en un modelo de ratas. 	07/14	429
Puesta a punto de técnicas de laboratorio para la determinación de marcadores moleculares de alto riesgo en enfermedades neoplásicas. 	18/14	437
Calidad de agua para usos agropecuario en los departamentos de bella vista y saladas, corrientes. 	13A011	152
Avifauna de los Esteros del Iberá: Biodiversidad, biogeografía y conservación. 	12IF05	116
La actividad forestal en el Chaco y los sectores conexos. Efectos socioeconómicos y ambientales a través del tiempo. 	11H001	25
Situación y uso del Iberá. Ordenamiento territorial. (Corrientes, Argentina). 	12IR01	449
Megaflora de la Formacion Carrizal, Triásico Medio-Superior, Provincia de San Juan, Argentina: Diversidad Biológica, Tafonomia y  	PICTO 2011-223	456
Ecopidemiología de arbovirus, monitoreo de sus vectores (Diptera: Culicidae) y reservorios en el norte Argentino 	PICTO 2011-246	462
Utilización de Microorganismos autóctonos en raciones para juveniles de Rhamdia quelen. Efectos sobre parámetros de crecimiento, morfología intestinal y respuesta inmune. 	PICT JOVENES 2013-1465	468
Identificación de factores y optimización de variables agronómicas que inciden en la productividad y calidad de ananá (Ananas comosus L. Merr) en el NEA. 	11A004	3
Palinología de la flora angiospérmica del nordeste Argentino. 	11F001	9
Gestión judicial: Situación y prospectiva de la organización de la Justicia de la Provincia de Corrientes para la tutela efectiva del crédito. 	11G001	15
Evaluación de la implementación de la reforma al Plan de Estudio de las Carreras de Abogacía y Notariado, aprobado por Resolución Nº 052/03 del C.S. y normas de aplicación complementaria. 	11G005	18
Mirada Tres: la mirada y el lenguaje en el aula. Hacia la reconstrucción del conocimiento profesional docente y la enseñanza en la Educación Inicial. 	11H017	30
La Diócesis de Corrientes entre 1934 y 1972. Labor de Mons. Vicentín. 	11H022	34
Evaluación de variables productivas y bioquímico-nutricionales de bubalus bubalis de distintas provincias del nordeste argentino. 	12B007	63
Hábitat y desigualdad social. Antropología de las áreas urbanas deficitarias críticas (AUDC) en el AMGR. 	12C007	68
Impacto del sistema de acción tutorial en la facultad de ingeniería de la universidad nacional del nordeste. 	12D006	73
Modelos de decisión para la sincronización de procesos en sistemas distribuidos. 	12F003	77
Estudios de biología reproductiva comparada, ontogenia y desarrollo gonadal de vertebrados amniotas y anamniotas del Nordeste de Argentina. 	12F008	81
Estudio taxonómico-filogenético en rubiáceas americanas basado en un abordaje combinado: palinología, morfo-anatomía, embriología y citogenética. 	12F013	85
Desarrollo de equipos didácticos para el fortalecimiento de la enseñanza de la física. Promoción del aprovechamiento de las energías no convencionales. 	12F020	89
Empresa familiar y cooperativa: situaciones problemáticas y soluciones jurídicas y económicas para la sustentabilidad de las micropymes regionales. 	12G006	93
Lo agrario y lo rural como construcción semiótica en el NEA. Identidades, diferencias y transformaciones de los sujetos y sus escenarios. 	12H009	97
Perfil metabólico y determinantes de progresión neoplásica en carcinoma renal humano a células claras: implementación de cultivos primarios para su estudio. 	12I008	104
Políticas urbanas en las provincias de Corrientes y Chaco. Planificación, gestión y evaluación de sus procesos de urbanización. 	12C002	65
Población originaria en la provincia del Chaco: territorios en conflicto a partir del año 2000. 	12C008	69
Mecánica computacional aplicada al análisis de materiales compuestos bifásicos. 	12D007	74
Historia natural de anfibios y reptiles del nordeste argentino. 	12F004	78
Los géneros notomabuya y copeoglossum (squamata: mabuyidae) en el Gran Chaco Argentino-Paraguayo 	12F009	82
Diversidad y distribución de las epífitas vasculares en copernicia alba y en otros hospedantes de bosques del nordeste argentino. 	12F014	86
Estudio, caracterización y aprovechamiento de las propiedades físico-químicas del biogás generado por biodegradación de residuos efluentes industriales. 	12F021	90
Escuela secundaria y trabajo docente en el nordeste argentino. Políticas, regulaciones y actores educativos para una "nueva escuela secundaria". 	12H001	94
Tensiones, rupturas y continuidades. La relación entre prensa y política en la provincia de Corrientes (1880-1999). 	12H010	98
La mortalidad general en la provincia del Chaco y su relación con los determinantes de la salud. Análisis de su distribución y tendencia en el período 1990-2015. 	12I005	102
Hipoxia tisular sistémica: estudios "in vivo" e "in vitro" de la programación eritroide y la apoptosis en diferentes tejidos. 	12I009	105
Ecoepidemiología de la esquistosomiasis en la cuenca del río Uruguay (Corrientes, Argentina) II. 	12I012	107
Análisis de estilos de aprendizaje de estudiantes universitarios. Posibles derivaciones para la enseñanza en la Carrera de Medicina de la UNNE 	12I014	109
Ubicación cefalométrica del hueso hioides en niños respiradores bucales diagnosticados clínicamente. 	12J002	124
Análisis de los aspectos bioéticos y éticos en la formación del odontólogo. 	12J004	126
Análisis de las prescripciones farmacológicas realizadas por odontólogos en un instituto de servicio social. Impacto de una intervención educativa. 	12J007	128
Evaluación clínica de diferentes técnicas de diagnóstico de caries dental en dentición primaria. 	12J011	130
Estudio integral de la infección por toxocara canis en el nea. 	12L002	132
Figuras asociativas en la producción de soja en el Chaco. Grado de desarrollo de su información contable. 	12M002	134
El patrimonio pictórico de el fogón de los arrieros (Chaco, 1940-1970). Análisis crítico y catalogación. 	12N001	136
Estudios anatómicos en especies adaptadas a condiciones anormales de nutrición. 	12P001	138
Subjetivación política y juventud. Estudios de casos múltiples y comparados en Corrientes y Resistencia. 	12R001	140
Cultivos alternativos condimentarios, aromáticos y medicinales para la diversificación de la producción del noroeste de corrientes. 	13A001	142
Alternativas tecnologicas en mecanización agrícola aplicadas en cultivos extensivos desarrollados en el nea 	13A003	144
Impacto de estreses bioticos y abioticos en la potencialidad de produccion de maiz y trigo en el nea 	13A005	146
Manejo sustentable del suelo (sistemas de labranzas y secuencias de cultivos) para pequeños productores de Corrientes 	13A007	148
Transferencia génica desde especies tetraploides apomícticas hacia híbridos tetraploides sexuales de origen experimental en el grupo Plicatula de Paspalum. 	13A008	149
Genética de la apomixis, filogenias y mejoramiento genético en gramíneas y compuestas nativas de Sudamérica. Parte II. 	13A009	150
Espacio público en el Gran Resistencia. Proyecto y diseño urbano. 	12C004	66
Gestión integrada del agua pluvial urbana. 	12D003	70
Fitoplancton y perifiton de ambientes acuáticos del nordeste argentino. 	12F001	75
Universidad y escuela secundaria mancomunadamente por la enseñanza-aprendizaje de la física. 	12F005	79
Actividad alexitérica y antimicrobiana de plantas utilizadas en la etnomedicina. Caracterización química y biológica. 	12F010	83
Caracterización y evolución cariotípica del género arachis por medio de hibridación in situ fluorescente, determinación del contenido de ADN y microdisección cromosómica. 	12F016	87
La contratación moderna. Su aplicación. 	12G001	91
Lo fantástico en la trama cultural. Los entornos del significado. 	12H003	95
Las tecnologías de la información y la comunicación en las prácticas educativas de docentes universitarios. Un estudio de casos de las facultades de artes, diseño y ciencias de la cultura (fadyc) y de arquitectura y urbanismo (FAU), de la UNNE. 	12H013	99
Consideraciones anatomo-quirúrgicas sobre el sistema autónomo simpático abdominopélvico. 	12I006	103
Rol de eritropoyetina y su receptor en relación con la hipoxia, angiogénesis y apoptosis tumoral en el carcinoma de células renales. 	12I010	106
Importancia de parásitos y vectores de Corrientes que desarrollan los estadios juveniles en el suelo: leishmaniasis y parasitosis intestinales. 	12I013	108
Estudio comparativo in vitro de la fuerza de unión, sustrato- sistema adhesivo- resina reforzada según tratamiento recibido por el esmalte dentario. 	12J001	123
Efectos de los contactos mediotrusivos en la articulación temporomandibular. 	12J003	125
Actividad antibacteriana in vitro de la stevia rebaudiana bertoni sobre microorganismos del biofilm dental. 	12J006	127
Enfermedad periodontal: microorganismos periodontopatógenos relacionados. 	12J009	129
Diagnóstico molecular temprano de genotipos carcinogénicos de helicobacter pylori en muestras de biopsias gástricas en población infantil. 	12L001	131
Detección de legionella pneumophila en los sistemas de almacenamiento de agua potable del Área Metropolitana del Gran Resistencia (AMGR). 	12L003	133
Funciones actuales del sistema de responsabilidad del proveedor ante el consumidor. 	12M003	135
Patrimonio cultural chaqueño. Identificación, análisis e inventario. 	12N002	137
Biodiversidad de ascomycetes liquenizados, basidiomycetes y briofitas del norte argentino y regiones limítrofes. 	12P002	139
Origen electrónico y efectos novedosos de propiedades magnéticas moleculares. 	12T001	141
Evaluación de la producción y características reproductivas de ovinos en cruzamientos con raza Santa Inês 	13A002	143
Compactación del suelo causado por el tránsito de maquinarias agrícolas en la región nea. 	13A004	145
Conocimiento de los hongos patogenos ocurriendo sobre especies de la flora cultivada y nativa del ne argentino y su manejo. 	13A006	147
Aplicaciones de las técnicas de cultivo in vitro en el mejoramiento de arroz 	13A010	151
Estudio comparativo de los modificadores nominales y las alternancias de la transitividad en variedades toba habladas en las provincias de Chaco y Formosa, Argentina 	PICTO 2011-222	403
Beca con Linea Prioritaria 	11A000	401
Beca CONICET sin Proyecto 	11A001	402
Cuantificación y evolución de parámetros químicos-físicos y biológicos en suelos con cambio de uso de la provincia del Chaco. 	12A002	53
Evaluación de leguminosas forrajeras, nativas y exóticas de potencial uso para el enriquecimiento de pastizales. 	12A003	54
Manejo sustentable de los recursos hídricos en diferentes procesos de uso en el norte argentino: propuestas en el espacio cuenca. 	12A004	55
Evaluación del secuestro de carbono en sistemas agrosilvopastoriles del nea. 	12A006	56
Establecimiento, micropropagación y conservación in vitro de germoplasma de especies vegetales de interés regional y nacional. 	12A007	57
Cultivo in vitro de orquídeas nativas de argentinas de interés regional. 	12A008	58
Cultivo in vitro de especies ornamentales nativas. 	12A009	59
Cantidad y calidad de las fracciones orgánicas en suelos rojos de misiones bajo sistemas naturales y cultivados. 	12A010	60
Uso de biofertilizantes y lombricompuesto. Efecto en la productividad del cultivo y en la colonización de microorganismos rizosféricos. 	12A011	61
Transformaciones territoriales. Articulaciones, espacialidades y estrategias ambientales en el AMGR. 	12C001	64
Estudios de la caracterización genética y carga parasitaria de Trypanosoma cruzi en pacientes chagásicos en diferentes situaciones clínicas de la enfermedad. 	13L002	228
Mandioca en sistemas intensivos de producción para el NEA. 	14A002	238
Estudios multidisciplinarios y evolutivos en géneros de ciperáceas con especial énfasis en malezas de cultivos subtropicales. 	14A008	244
Aspectos higiénico sanitarios de los establecimientos elaboradores de alimentos en la ciudad de Corrientes y su relacion con la salud pública. 	14B005	248
Estrategia de recría para lograr entore de vaquillas a los 18 meses. 	14B011	253
La casa moderna. El hábitat doméstico en Corrientes y Resistencia. Diseño, materialidad, ambiente y signo. 	14C004	258
Proyecto de planta de reciclado de Residuos de Aparatos Eléctricos y Electrónicos (RAEE) para la región Nordeste Argentino (NEA). 	14D002	275
Evaluación aerodinámica de aerogeneradores mediante ensayos en túnel de viento. 	14D006	279
Estudios físico-químicos, morfológicos y nutricionales de materias primas y productos terminados y optimización de sus procesos. 	14F002	283
Restauración del bosque ribereño en la Reserva Natural Rincón de Santa María (Corrientes). 	14F007	288
El Rendimiento Académico de los Ingresantes a la FACENA -UNNE desde la perspectiva del Análisis Estadístico Implicativo. 	14F011	292
Estudios xilológicos en el Neógeno del Noroeste Argentino. 	14F015	296
Estabilidad, acotamiento y propiedades cualitativas afines de sistemas de ecuaciones diferenciales bidimensionales. 	14F020	300
Perfil del Juez: Capacidades requeridas para acceder a la Magistratura. 	14G001	305
Desarrollo sustentable en ambitos rurales y urbanos, su incidencia en los recursos naturales y calidad de vida de la población. 	14G005	309
Las Prácticas de Maternaje Qom y su aporte a la formación de grado en Educación Bilingüe Intercultural en contextos sociales con Pueblos Indígenas. Tercera Etapa. 	14H001	313
Agenciamientos del cuerpo: facticidad y representación simbólica para la inclusión social. 	14H005	317
Formación para el trabajo para jóvenes y trayectorias socioeducativas y laborales. Análisis de la articulación entre el mundo laboral y educativo en sectores productivos específicos de Chaco y Corrientes. 	14H009	321
Sistemática y filogenia de algunos géneros sudamericanos de Angiospermas. 	14P001	350
Contextos de Trabajo: entramados, poder y violencia.Estudios sobre organismos del estado, programas sociales,sector rural y cambio tecnológico. 	13M002	230
Estudios sobre diversidad y vigor híbrido en especies forrajeras del género Paspalum. 	14A004	240
Detección de infección natural de diferentes especies de Leishmania y Leptospiras en muestras de animales no domésticos mediante técnicas de biología molecular. 	14B002	245
Análisis comparativo de los factores involucrados en la dinámica de transmisión de la enfermedad de Chagas en áreas urbanas y periurbanas marginales de las ciudades de Corrientes y Resistencia. 	14B006	249
Evaluación de los efectos genotóxicos del clorpirifos en prochilodus lineatus (pisces, prochilodontidae). 	14B013	255
Análisis, interacción reflexiva y caracterización de procesos recientes de ordenación y planificación territorial en Argentina y el Nordeste. 	14C005	259
Bíomasa de la región NEA: cuantificación, evaluación, caracterización. Procesamiento ecológicamente sustentable: pirólisis, biodigestores, briquetas. 	14D003	276
Modelización del comportamiento Macroeconómico de la Inflación con Modos Deslizantes. 	14D007	280
Desarrollo de tecnologías para la inclusión de personas con discapacidad. 	14F003	284
Respuesta dieléctrica efectiva mediante métodos recursivos y escalables en cómputo de alto desempeño. 	14F008	289
Caracterización físico química y bacteriológica de recursos hídricos superficiales de elevado valor estratégico (Provincia de Corrientes) utilizando herramientas quimiométricas de análisis. 	14F012	293
Interacciones moleculares en entornos quimicos y bioquimicos. Interacciones hole-lumps Efectos sobre la Estructura y Reactividad. 	14F017	297
Estudio biológico multifocal e interdisciplinario de los vertebrados e invertebrados del Paraje Tres Cerros, Corrientes, Argentina: conocimiento actual para futuros planes gestión y manejo de un área protegida. 	14F021	301
La construcción de institucionalidad social en el MERCOSUR: Dinámica socio-política del Estado, el empresariado y la sociedad civil, en el proceso de integración regional, durante el período 2013/2016 	14G002	306
Sistemática jurídica social del servicio público de energía eléctrica de la Provincia de Corrientes. 	14G006	310
El héroe y el poder: elecciones y rupturas. Transtextualidades en torno a las figuras de Aquiles y Alejandro en el cine. 	14H002	314
Las mujeres indígenas en la Provincia del Chaco: del espacio doméstico al espacio público. 	14H006	318
La construcción del conocimiento didáctico del contenido (CDC) en profesores experimentados y principiantes de la Universidad Nacional del Nordeste. Estudio de casos múltiples. 	14H010	322
Desarrollo de propuestas de geoindicadores para el estudio de los usos del suelo en las provincias de Chaco y Corrientes. 	14H012	324
Caracterización del primer nivel de atención de la ciudad de Corrientes. Evaluación desde la perspectiva de la atención primaria de la salud. 	14I002	326
Estudio del perfíl lipidico e inmunológico de la progresión neoplasica en carcinoma renal de células claras. 	14I004	328
Humanización de los profesionales médicos: nivel de empatía en los primeros años de Carrera. 	14I008	330
Prevalencia de deficiencias nutricionales en pacientes con obesidad moderada-severa del Nordeste Argentino. 	14I010	332
Perfil electroforético de proteínas presentes en la saliva de pacientes edentúlos. 	14J001	335
Estudio de la Salud Bucal en Centros de Desarrollo Infantil de la ciudad de Corrientes. 	14J003	337
Aspectos Clínicos y Predictivos del Precáncer Bucal en relación a factores de riesgo en pacientes de la provincia de Corrientes, Argentina. 	14J005	339
Estudio comparativo de lesiones periapicales con técnicas retroalveolares estandarizadas y su correlación con la TC en pacientes que concurren a la FOUNNE. 	14J006	340
La organización espacial del NEA y su incidencia en el desarrollo regional al iniciarse el siglo XXI. Algunos análisis y aportes geográficos, en distintas escalas, sobre configuraciones y dinámicas territoriales. 	13H001	207
La práctica profesional de los noveles profesores en Ciencia Humanas (Historia y Geografía). Análisis de la relación entre las concepciones epistemológicas y las propuestas de enseñanza de los profesores noveles 	13H006	211
Transmisión intergeneracional de prácticas comunicativas bilingües (guaraní/castellano): estudio sobre el discurso de la prohibición del guaraní en Corrientes. 	13H011	215
Diseño de real time PCR para detección simultánea de microorganismos de transmisión sexual de difícil aislamiento. 	13I004	219
Perfil epidemiológico de caries secundaria, anomalías de la oclusión y disfunción temporomandibular en pacientes de la Facultad de Odontología de la UNNE. 	13J002	223
Evaluación de la sensibilidad in vitro de especies de Malassezia frente a antifúngicos de uso clínico. 	13L001	227
Riesgos psicosociales en el trabajo. Nuevas dimensiones de las condiciones y medio ambiente de trabajo, percepción de los trabajadores, e impacto en las empresas y organizaciones. 	13M003	231
Inserción laboral de los contadores públicos, licenciados en administración y en economía de la Universidad Nacional del Nordeste 	13M007	234
Cultivo in vitro de tejidos para la crioconservación de germoplasma vegetal. 	14A003	239
Estrategias de manejo de fitoplasmosis para la producción forestal de paraíso (Melia azedarach). 	14A005	241
Desarrollo estrategias para la optimización de la nutrición citrícola en variedades de intererés NEA 	13CA02	180
Proteínas de venenos ofidicos con potencial aplicación farmacológica 	13CF01	184
Empresa de Familia chaqueña. Diseño de un instrumento formal "Protocolo Familiar" para la consolidación del desarrollo organizacional. 	13M008	235
Diagnóstico de endo y ecto parásitos en búfalos (Bubalus bubalis); en las distintas categorías susceptibles, en los departamentos del Noroeste de la Provincia de Corrientes. 	14B008	251
Calidad de canales y carne porcina con diferentes técnicas de manejo. 	14CB02	262
Desigualdades hídricas: territorios en conflicto en las provincias del NEA a partir del año 2000. 	14CC01	265
La Universidad Nacional del Nordeste y procesos sociopolíticos de la región en el contexto de los 70. Génesis de su institucionalización y desmembramiento según prácticas y discursos de actores académicos y extra académicos. 	14CH03	268
Seguridad del paciente asociada a la utilización del equipamiento kinefisiatrico en Servicios de Kinesiologia. 	14CI03	271
Mastofauna de los Esteros del Iberá: diversidad, distribución, características ecológicas y perfil parasitológico. 	12IF07	118
Importancia de la reproducción sexual en la evolución y el mejoramiento genético de especies poliploides del género Paspalum L. 	PICT 2012-0261	423
Diseño de protocolos para el compromiso ocular en pacientes con traumatismo encefalocraneal. 	08/14	430
Evaluación de calidad de aulas virtuales de la Facultad de Medicina. 	19/14	438
Diversidad de termitas e invertebrados de la hojarasca y el suelo en la Reserva Natural del Iberá (Provincia de Corrientes) y aportes para su conservación. 	12IF06	117
Desarrollo de un equipo portatil para la caracterizacion electrica de sistemas de generación con Tecnologia Fotovoltaica 	PICTO 2011-255	450
Diseño e Implementacion de un sistema de control por bioseñales para un robot manipulador 	PICTO 2011-249	457
Propiedades Ópticas de Materiales Compuestos Nanoestructurados 	PICT EQ.TRAB. 2013-0696	469
Variabilidad genética en poblaciones naturales y sintéticas de especies poliploides sexuales del género Paspalum L. 	PICTO OTNA 2011-080	463
Pluralismo y sistema jurídico: la interpretación de la normativa consuetudinaria de los pueblos originarios del nordeste y su armonización con el derecho vigente. 	11G007	20
Conciencia jurídica material. Legislación Nac. E Internacional. Implicancia de Tratados Internacionales en el fallo Arancibia Clavel. 	11G008	21
Legislación internacional penal y procesal (comunitaria) en materia de delitos de tráfico, en particular, el tráfico de personas con fines de explotación sexual y laboral (trabajo forzoso). 	11G010	22
Conciencia jurídica, derecho y obra institucional de Juan Eusebio Torrent. 	11G012	24
Saberes y prácticas cognitivas en el contexto de la formación disciplinar en biología. Su contribución al logro de ciudadanía. 	11H006	26
El transporte de cargas y de pasajeros desde sus orígenes hasta la actualidad a través de las fuentes documentales escritas, orales y de imagen y sonido. El caso del Chaco. 	11H009	27
La inclusión exclusión social en el área metropolitana del Gran Resistencia. Desde una visión espacial. 	11H011	28
Producción, análisis y difusión de información geográfica de naturaleza sanitaria. Una aproximación al estudio de la relación salud-ambiente en el Chaco. 	11H014	29
Producción y comprensión de discursos de circulación social en la región NEA. Descripción, análisis y aplicaciones. 	11H023	35
Prevalencia de la enfermedad renal crónica y factores de riesgo en los aborígenes de Chaco Argentina. 	11I005	37
Desempeño académico de los ingresantes al Plan 2000 de la Carrera de Medicina, su relación con el rendimiento académico en la carrera y con el acceso a las Residencias Médicas. 	11I008	38
Aplicaciones de la Citología exfoliativa como método diagnóstico en lesiones de la cavidad bucal en pacientes atendidos en Centros de Atención Primaria de la salud en la ciudad de Corrientes. 	11J006	42
Uso de la Fosfatasa Alcalina salival como marcador bioquímico de la enfermedad periodontal. 	11J007	43
Estudio In Vitro de la Microfiltración utilizando diferentes materiales adhesivos 	11J011	44
Aspectos fisiológicos de plantas de tomate que crecen en condiciones de suelos anegados 	11P001	47
Palinotaxonomía y palinología aplicada a la caracterización de mieles de apis mellifera l. Y tetragonisca angustula latreille en el nordeste argentino. 	11P002	48
Territorio algodonero. Procesos de construcción de la identidad socio-productiva, y de reestructuración de la agricultura en el Chaco. (1920-1952 y 1991-2011). 	11S001	51
Aporte y descomposición de hojarasca de pinus elliottii y eucaliptus grandis y su influencia en las propiedades del suelo en el parque chaqueño. 	12A001	52
Las representaciones gráficas en la formación de alumnos de la carrera de arquitectura de la FAU-UNNE. 	12C006	67
Huella hídrica del agua del nea orientado al uso agrícola y humano. 	12D004	71
Aprendizajes significativos de matemática mediante b-learning en el inicio de los estudios universitarios. 	12F002	76
Taxonomía, biodiversidad y conservación de la herpetofauna de Corrientes, Chaco y Formosa (Argentina). 	12F007	80
Comunidades de termitas del nordeste argentino: estructura, ecología nutricional y fauna asociada. 	12F012	84
Estudio epidemiológico molecular de los virus linfotrópicos t humanos tipos 1 y 2 en donantes de sangre de Corrientes. 	12F018	88
Nuevos desafíos de la globalización: implicancias de la dimensión jurídica, política, económica, y ambiental para un desarrollo territorial local. 	12G003	92
Construcción de subjetividades e institucionalización de prácticas en concepciones filosóficas actuales 	12H006	96
Estudio de la anatomía topográfica en cortes fetales y adultos como base para el diagnostico imagenologico y técnicas quirúrgicas clásicas en oncología y endoscópicas. 	12I001	100
Estudios sistemáticos, filogenéticos y biogeográficos en especies seleccionadas de la flora americana. 	13A013	154
Los Glyptodontidae (Xenarthra) neógenos y cuaternarios de América del Sur: diversidad, filogenia y bioestratigrafía. 	13Q001	236
Valor nutritivo de alimentos y la gestión ambiental en la producción ganadera del NEA. 	14A006	242
Evaluación de la utilización de repelentes a base de deltametrina en la prevención de leishmaniosis canina en un área de la ciudad de Corrientes (continuación). 	14B003	246
Determinación de biomarcadores tumorales en neoplasias mamarias caninas. 	14B007	250
Rehabilitación higrotérmico-energética de edificios en el NEA: evaluación, diagnóstico, desarrollo de soluciones técnico-constructivas y valoración costo-beneficio. Calificación energética de la edificación. 	14C001	256
Arquitectura y Territorio chaqueño como espacio sociocultural singular. Perspectivas teóricas, históricas y patrimoniales. 	14C006	260
Estudios de nuevos métodos de investigación geotécnica aplicables a la práctica de ingeniería del NEA - Tercera Etapa. 	14D004	277
Evaluación del grado de depuración de efluente de Industria textil por parámetros no convencionales. Propuesta de remediación de Impacto Ambiental. 	14F004	285
Estimación de parámetros usando asimilación de datos en procesos de interacción entre las escalas resueltas y las parametrizaciones. 	14F009	290
Caracterización de Inusuales Interacciones Moleculares. 	14F013	294
Aplicación de criterios de optimización energética y seguridad, en la resolución de problemas de diseño en las construcciones Ingenieriles- tecnológicas inteligentesen la región. 	14F018	298
Cuantificación de compuestos fitoquímicos presentes en alimentos vegetales producidos en la región del NEA procesados con métodos de preservación no térmicos. 	14F022	302
Ley, derecho, sociedad y poder en Corrientes. Nuevo análisis histórico a partir de las conclusiones metodológicas de autores clásicos contemporáneos. 	14G003	307
Cooperativas de trabajadores y Empresas recuperadas. Viabilidad de un ente estatal regulador para sustentar la viabilidad de las mismas. 	14G007	311
Políticas de memoria y usos públicos de la historia en el Nordeste argentino. 	14H003	315
Buenas Prácticas en la Educación Infantil. Estudio de casos en el Area Metropolitana del Gran Resistencia- Chaco. 	14H007	319
Indígenas en la Universidad Nacional del Nordeste. Análisis de las experiencias estudiantiles y la participación. 	14H011	323
Sindrome de Burnout en los estudiantes que finalizan la carrera de medicina. 	14I001	325
Percepción de los estudiantes de enfermería sobre la calidad de los instrumentos de evaluación y su correlación con el rendimiento académico durtante el primer ciclo de la carrera. Período 2015 - 2018. 	14I003	327
Genotipificación viral de HPV y aspectos epidemiológicos de cervicopatías detectadas en centros de atención primaria de la salud de Corrientes. 	14I006	329
El estado nutricional de la embarazada repercute sobre los resultados maternos y perinatales. 	14I009	331
Rigidez arterial como marcador de daño vascular medida por velocidad de la onda de pulso, en estudiantes universitarios y embarazadas de Corrientes, Argentina. 	14I013	334
Evaluación de la salud bucal de los pacientes con discapacidad intelectual de la Provincia de Corrientes. 	14J002	336
Competencias TIC de los docentes de la Universidad Nacional del Nordeste. 	14J004	338
Efecto anti-hipertensivo ocular del activador del plasminogeno tisular en ovinos. 	20/14	439
DESARROLLO DE AUTOPARTES EN EL NEA (COLVEN-UNNE) 	FITR INDUSTRIA - 2013	475
Manejo de riego en cultivo de invernadero 	13A014	155
Enterococcus spp como indicador de contaminación en aguas de las provincias de Chaco y Corrientes. 	13B001	156
Reservorio y vector de leishmaniosis visceral canina en el NEA. 	13B002	157
Integración de los nervios autónomos con el plexo lumbosacro en caninos. 	13B003	158
Sistematizacion de Linfocentros Parietales o Musculares y Viscerales en Caprinos. 	13B004	159
Suplementación con harina de cartamo a bovinos alimentados con henos de baja calidad en el nordeste argentino. 	13B005	160
Cultivo primario para estudio de anomalías y neutralización mediada por anticuerpos en laminitis aguda inducida por veneno de serpiente. 	13B006	161
Uso de silo de mandioca (manihot sculenta) como fuente alternativa de energía, no convencional en la alimentación para cerdos en la región NEA. 	13B007	162
Caracterización de recursos zoogenéticos en la región semiárida de Formosa. 	13B008	163
Intoxicaciones inducidas por plantas, de curso sobre-agudo, agudo y crónico, en animales de interés económico del NEA. 	13B009	164
Efecto de la Gonadotrofina Corionica Equina sobre la preñez en rodeos de vacas y bufalas inseminados artificialmente en el NEA. 	13B010	165
Aproximación al diagnóstico integral de enfermedades del cuello en pequeños animales. 	13B011	166
Identificación de cepas de Brucella spp. En rumiantes domésticos en la región del nordeste argentino. 	13B012	167
Producción de carne, leche y derivados de búfalos con valor nutracéutico, y evaluación de sus efectos antiateromatosos y anticancerígenos sobre modelos biológicos experimentales. 	13B013	168
Respuestas de adaptación al ambiente social humano en perros domésticos. 	13B014	169
Probióticos en piscicultura: Aislamiento y evaluación de propiedades benéficas de levaduras pertenecientes a la microbiota intestinal. 	13B015	170
Desarrollo de pautas metodológicas e instrumentos de gestión participativa, para la intervención integral en Áreas urbanas críticas. 	13C001	172
Nociones de tiempo implícitas en la arquitectura. Construcción de dispositivos para su detección en el análisis de obra y consideración en el proceso de proyecto. 	13C002	173
Construcción social e institucional del espacio urbano. Formulación de recomendaciones de mejoramiento. Estudio de caso: Barrio San Pedro Pescador, Colonia Benítez, Chaco. 1980/2017. 	13C003	174
Análisis del comportamiento constructivo, estructural y desempeño ambiental de edificios a través de modelos analógicos y simulaciones aplicando la lectura de la imagen. 	13C004	175
La transposición tecnológica aplicada a la resolución de problemas de diseño arquitectónico. 	13C005	176
Atlas del paisaje cultural, urbano y rural, y del patrimonio arquitectónico de la provincia de Corrientes. 	13C006	177
Ambiente y sustentabilidad en la arquitectura y las ciudades. 	13C007	178
Desarrollo de un modelo matemático de simulación de fuerzas, aceleración y desplazamiento transversal en vehículos terrestres de dos ejes. Sobreviraje, subviraje. Simulación de frenado de motor y por fricción. Análisis del punto límite de estabilidad. 	13D001	186
Análisis del efecto del viento en estructuras livianas mediante ensayos en túnel de viento con modelos reducidos de tableros de puentes, torres reticuladas metálicas y antenas. 	13D002	187
Optimización multiobjetivo de estructuras metálicas empleadas en la industria de la construcción. 	13D003	188
Cálculo fraccionario y teoría de distribuciones. 	13F001	190
Síntesis, química y reactividad de peróxidos cíclicos. Parte III. 	13F002	191
Paleoasociaciones de invertebrados (Neógeno) de los Valles Calchaquíes y Quebrada de Humahuaca, Argentina . 	13F003	192
Estudio teórico-experimental dirigido a la síntesis de compuestos organoboro de interés biológico: ácidos a-aminoborónicos y sus ésteres. 	13F005	193
Estudio de las condiciones de producción de modelos en Matemática y en su enseñanza secundaria y universitaria 	13F006	194
Topología de la descomposición de la densidad electrónica y efectos de deslocalización electrónica, interacciones intramoleculares y reactividad. 	13F008	195
Estudios ab-initio del efecto de tensiones generalizadas sobre las propiedades elásticas y electrónicas de materiales cristalinos y nano-estructurados. 	13F009	196
Métodos y herramientas para la calidad del software. 	13F010	197
Desarrollo de un sistema de detección de radiaciones basado en un arreglo de fotodiodos. 	13F011	198
Estimación Paramétrica en Modelos Polarimétricos. 	13F012	199
Tecnología en Salud como Derecho Humano. Implicancias jurídico-profesionales del Ingeniero Biomédico. 	13G001	202
El intervencionismo estatal en los poderes provinciales: prospectiva para la construcción de un nuevo federalismo. El caso Corrientes. 	13G002	203
La gestión pública en la agenda estatal en el orden jurídico local, regional y global. 	13G003	204
Niñez vulnerable: costo de su protección integral. 	13G004	205
Caracterización y análisis de la expresión de genes asociados con la tolerancia a estrés osmótico y generación de procedimientos aplicables a la clonación masiva de genotipos tolerantes. 	14A001	237
Biotaxonomía de leguminosas megatérmicas y de germoplasma de Arachis (maní). 	14A007	243
Estudio comparativo citológico, citoinmunohistoquímico, histopatológico e inmunohistoquímico en el diagnostico de leishmaniosis canina (continuación). 	14B004	247
Evaluación de la diversidad íctica en la planicie del Río Parana Medio. 	14B009	252
Modelos metodológicos comunes en las praxis proyectuales: Impactos en la formación, la profesión y la investigación en diseño. 	14C003	257
Estudio de las competitividades provinciales y las asimetrías en el Norte Grande Argentino. 	14D001	274
Toxicidad de Arsénico en Aguas y Matrices Biológicas en la Provincia del Chaco. 	14D005	278
Innovación con TIC para fortalecer la enseñanza y aprendizaje de las actividades de laboratorio de Química y de Física en los primeros años de facena. 	14F001	282
Química de las formulaciones farmacéuticas genéricas. 	14F005	286
Proteasas digestivas de Piaractus mesopotamicus (pacú). Su aislamiento y caracterización. 	14F010	291
Estudios xilológicos del Pérmico y Triásico del Sur de Sudamérica. 	14F014	295
Análisis y procesamiento de señales biológicas mediante técnicas digitales. 	14F019	299
Sinergia de fuentes de energía no convencionales en entornos urbanos: estudio y desarrollo de modelos para el análisis y prospección de un nuevo paradigma basado en la generación distribuida. 	14F023	303
Aproximación al problema del injusto tributario en la provincia de Corrientes. 	14G004	308
Acción estatal en relación al trabajo infantil: problemática juridico-social en las provincias de Chaco y Corrientes. 	14G008	312
CARACTERIZACION DE LA COMUNIDAD DE INSECTOS EN UNA ESCALA ESPACIAL. VARIACION EN AREAS PROTEGIDAS Y EN SISTEMAS PRODUCTIVOS DEL CHACO 	16F020	533
Filosofía del Lenguaje y Habla de la Experiencia. Elucidación de una conjunción dinámica en el "devenir lingüístico" de la producción de conocimientos. 	14H004	316
La evaluación didáctica en profesores universitarios expertos de la UNNE. 	14H008	320
Adquisición inicial y transmisión de Steptococos mutans en niños menores de 24 meses. 	14J007	341
Parámetros histopatológicos y moleculares indicativos del riesgo de transformación maligna en lesiones precancerosas de la cavidad oral. 	14J008	342
Paracoccidioidomicosis en Argentina. Epidemiología molecular de una enfermedad olvidada y reemergente en el noreste argentino. 	14L001	343
Eco-epidemiología de Stegomyia albopicta (Diptera: Culicidae) en el noreste de Argentina. 	14L002	344
Ecoepidemiología de la lieishmaniaisis visceral en un área receptiva de la provincia del Chaco. 	14L003	345
Estructuras de covarianza para la modelización del rendimiento académico en carreras de Cs. Económicas. 	14M001	346
Aplicación de métodos matemáticos para evaluar la eficiencia y la vulnerabilidad de los alumnos en los primeros años de estudios universitarios. 	14M002	347
Reconfiguración de identidades en la producción audiovisual del Nordeste y Noroeste argentino. Análisis representacional crítico contrastivo (2010-2014). 	14N001	348
Corporeidad y conocimiento en la formación: estudio exploratorio desde la Expresión Corporal en alumnas del Profesorado en Educación Inicial. 	14N002	349
Hongos potencialmente biocontroladores del vector biológico del HLB en cítricos. 	14P002	351
Análisis de la diferenciación genómica en el germoplasma primario y secundario del maní. 	14P003	352
Estudios citogenéticos, evolutivos y filogeográficos en especies seleccionadas del nordeste argentino: una contribución al conocimiento de la biodiversidad y la conservación de la flora regional. 	14P004	353
Caracterización de los cambios genómicos y epigenéticos que se producen durante los procesos de hibridación y poliploidización en sistemas vegetales. 	14P005	354
Dinámica de la vegetación de las islas del Alto Paraná desde 1980 a 2014, causas y consecuencias. 	14Q001	355
Los scelidotheriinae ameghino (xenarthra, pilosa, mylodontidae) de Argentina. 	14Q003	356
Aplicación de OCT (Tomografía de Coherencia Óptica) como valor predictivo visual en pacientes con tumor hipofisiario. 	09/14	431
Electroestimulación muscular selectiva en pacientes con hipotrofias post lesiones traumáticas y de nervios periféricos. SUK UNNE. 	21/14	440
Relevamiento y propuestas de ampliación y/o modificación de la legislación ambiental de la Reserva Natural del Iberá. 	12IG01	119
Rol del sistema Eritropoyetina (EPO) y su receptor (EPO-R) en relacion con la hipoxia, angiogénesis,proliferacion y apoptosis 	PICTO 2011-212	451
Caracterizacion de daños causados por el viento a obras e infraestructura civil en cinco provincias del nordeste de Argentina 	PICTO 2011-187	458
Caraterización de las Legumbres con Potencial valor nutritivo cultivadas por pequeños y medianos productores del NEA 	PICT BICENTEN. 2010-2341	464
Epidemiología molecular de la paracoccidioidomicosis en Argentina. Caracterización de la epidemiología de una enfermedad olvidada y reemergente en el nordeste argentino. 	PICT 2014-0954	470
Generación de tecnologías alternativas para la promoción y el desarrollo forestal regional. 	11A005	4
Efectos de solvente en propiedades magnética de compuestos pequeños de interés biológico y/o tecnológico. 	11F002	10
Desigualdad e inequitativa transferencia de ingresos en la Argentina desde la crisis de la convertibilidad (2000-2010). Análisis de las alternativas de políticas fiscales y redistributivas integradoras para garantizar una propuesta de "ingreso ciudadano". Posibles impactos en el NEA. 	11G003	17
Impacto de la producción bubalina en el desarrollo local de la Provincia de Corrientes. Ventajas de la explotación pecuaria y normas jurídicas para el crecimiento económico. 	11G011	23
El análisis documental en las bibliotecas públicas de la ciudad de Resistencia 	11H020	32
Patrones de argumentación y síntesis de creencias sobre el conocimiento, el conocer y el aprender de estudiantes de profesorado en su contexto de formación. 	11H019	31
El proceso lectural en los ingresantes. Interacción entre estrategias cognitivas básicas, competencia comunicativa y efecto estético. 	11H021	33
Función cardíaca y arterial mediante cardiografía de impedancia en estudiantes universitarios y embarazadas de Corrientes, Argentina. 	11I004	36
Variabilidad de la maduración dental, en escolares que presentan correspondencia entre Edad Cronológica y Maduración Esqueletal. 	11J001	39
Efectividad de la tintura de propóleos en el tratamiento de las queilitis angulares. 	11J003	40
Caracterización histológica del tejido gingival sometido a fuerzas ortodóncicas. 	11J004	41
Niveles de caries y necesidad de tratamiento periodontal en relación al ph salival en pacientes con Síndrome de Down. 	11J015	45
Estudio de la triquinosis como enfermedad emergente y probable tropicalización regional. 	11L004	46
Análisis del estado ecológico de lagunas periurbanas (Corrientes, Argentina). 	11Q001	49
Análisis de sustancias tóxicas en matrices de consumo humano y/o animal. Aspectos antropológicos y jurídicos. 	11R001	50
Buenas Prácticas Comunicacionales. Aplicación y Evaluación de un Dispositivo de Formación: Role Playing de Entrevista Médica Estructurada 	23/15	473
Diversidad y papel funcional de los invertebrados herbívoros en ecosistemas acuáticos del nordeste de Argentina. 	PICT 2011-2160	474
Equipo de caracterización eléctrica y medición de parámetros ambientales para evaluar sistemas de generación FV 	PICT tipo A	476
Sistema Móvil De Bombeo Solar Y Desalinización De Agua 	MINCyT 001	477
Maletin Solar - Convocatoria de Proyectos de Vinculación Tecnológica, Jorge A.Sábato". 	MINCyT 002	478
Importancia de la reproducción sexual en diferentes sistemas genéticos de Paspalum y en el mejoramiento genético de especies apomícticas 	PIP Nº 112-201101-00469	479
Genetic variation, cytotype associations and geographical parthenogenesis in the subtropical grass genus Paspalum 	PCB II - 20150202-0167	480
Biología de la conservación del Yetapá de Collar (Aves, Tyrannidae: Alectrurus risora). 	PIP 114-201101-00329	482
Plan de conservación de los bosques en galería de los riachos formoseños utilizando al Muitú (Crax fasciolata) como especie bandera 	D-0134-2012	483
Efectos de las cascadas tróficas sobre las poblaciones de aves de pastizal del NE argentino: poniendo a prueba la hipótesis de liberación de mesodepredadores 	PICT 2014-3397	484
Estudio de la historia evolutiva de la avifauna del Cono Sur de Sudamérica: desentramando la complejidad de patrones y factores de diversificación en la región 	PIP 112 201301 00803	485
Estudio del efecto del río Paraná-Paraguay como barrera geográfica para Passeriformes de bosques: un enfoque filogeográfico, morfológico y comportamental 	PICT 2014-2057	486
Estudio del efecto del río Paraná-Paraguay como barrera geográfica para Aves y Artrópodos mediante el análisis de sus códigos de barras genético. Investigador Responsable. 	IBOL D3657	487
CRITERIOS URBANO-AMBIENTALES Y SOCIALES DE DISEÑO PARA LA FORMULACIÓN DE PROYECTOS DE VIVIENDA SOCIAL Y DE MEJORAMIENTO BARRIAL EN ÁREAS VULNERABLES 	PIP 11220110100881	488
Hacia una cartografía sociolingüística de los nuevos usos y modo de transmisión de las lenguas guaraní, quichua, qom, moqoit y wichi (Corrientes, Santiago del Estero y Chaco). 	PICT 2013-2283	489
Diseño y construcción de caudalímetro electromagnético y sistema remoto de transmisión de datos. 	14D008	281
Desarrollo de Sistemas de Propagación Clonal de Especies de Interés Forestal e Industrial mediante el uso de Biorreactores de Inmersión Temporal 	16A001	490
Sistemas Genéticos y Diversidad en el Género Paspalum (Poaceae) 	16A002	491
Estudios Morfo Anatómicos de Especies de Interés Agronómico 	16A003	492
Calidad Integral de las Mieles de Apis Melifera L. en el Nordeste Argentino 	16A004	493
Potencial Antividad promotora del Crecimiento Vegeral de Bacterias Endofiticas Aisladas de Cultivos de la Region del NEA Argentino 	16A005	494
Calidad de Suelos en el Chaco Semiárido, Impacto del Uso Agropecuario 	16A006	495
Impacto del Sistema Forestal Bajo Pinus sp. Sobre la Calidad, Cantidad y Distribución de las Fracciones Orgánicas y su Efecto en el Secuentro de Carbono 	16A007	496
Fisiología de Estreses Abióticos en Cultivos de Importancia Regional 	16A008	497
Evaluación del Secuestro de Carbono en Sistemas Agrosilvopastoriles del NEA 	16A009	498
Biotecnología Aplicada a la Propagación y Conservacón de Germoplasma de Especies Vegetales de Interés Ornamental, Alimenticio o Industrial 	16A010	499
Evolución de Parámetros Fisicos, Químicos y Biológicos de Suelos en Sistemas Productivos Agrícolas y Silvopasteriles en la Provincia del Chaco 	16A011	500
Caracterización de la Aptitud Forrajera de Fabáceas para Sistemas Ganaderos del NEA 	16A012	501
Bioinsumos y Polvo de Roca Basáltica. Efecto en la Productividad de los Cultivos y en la Actividad Biológica del Suelo. 	16A013	502
Caracterización de Fitopatógenos que Afectan Cultivos de Arroz, Maíz y Trigo en la Región Noreste de Argentina. Epidemiología y Alternativas de Control. 	16A014	503
Biotecnología Aplicada al Mejoramiento Genético de Orquídeas Tropicales y Subtropicales de Interés Regional 	16A015	504
Histología e histopatología del hígado de peces de la región Nea: análisis en condiciones naturales y experimentales 	16B001	505
POLICULTIVO DE JUVENILES DE PACU Y SABALO EN UN SISTEMA DE CULTIVO ACUAPONICO: ADAPTACION A LA REGION NEA, OPTIMIZACION CON EL AGREGADO DE MICROORGANISMOS NITRIFICANTES Y ESCALAMIENTO A MEDIANA ESCALA 	16B002	506
CONCENTRACION, BIOACCESIBILIDAD Y ESPECIACION DE ALGUNOS MINERALES TRAZA EN ARROZ CULTIVADO EN LA PROVINCIA DE CORRIENTES 	16B003	507
ANALISIS EPIDEMIOLOGICO DE PARASITOS QUE AFECTAN A ESPECIES SILVESTRES AL INGRESO A COMPLEJOS ECOLOGICOS Y PREVIA LIBERACION EN EL NEA 	16B004	508
EVALUACION DE LOS EFECTOS DE LA DOMPERIDONA EN CANINOS CON LEISHMANOSIS VISCERAL 	16B006	509
EPIDEMIOLOGIA Y UTILIDAD DE PRUEBAS DIAGNOSTICAS PARA ANEMIA INFECCIOSA EQUINA EN UN AREA ENDEMICA DE LA REPUBLICA ARGENTINA 	16B007	510
APLICACION DE LA CRONOMETRIA DENTAL PARA LA DETERMINACION DE LA EDAD EN BUFALAS DE CORRIENTES, EVALUACION PRODUCTIVA Y BIOQUIMICO-NUTRICIONAL 	16B008	511
SISTEMATIZACION DE LINFOCENTROS EN OVINO 	16B009	512
EFECTO DE LA FRECUENCIA DE PUNCIONES IN VIVO SOBRE LA CANTIDAD Y CALIDAD OVOCITARIA PARA LA PRODUCCION IN VITRO DE EMBRIONES EN BUFALOS 	16B010	513
Proceso de Metropolización del Gran Resistencia. Políticas y Estrategias 	16C001	514
Espacio Público y Movilidad en el Gran Corrientes y Gran Resistencia 	16C002	515
Caracterización Urbano-Ambiental de Áreas Deficitarias Críticas del Gran Resistencia 	16C003	516
Habitat, Desigualdad Social y Políticas Urbanas. Desarrollo de Pautas de Intervención Urbana para la Integración Social en el AMGR 	16C004	517
La Enseñanza-Aprendizaje del Proceso de Diseño Arquitectónico: Evolución y Prospectiva en un Contexto Mediado por Tecnologías Digitales y Nuevos Paradigmas Proyectuales. 	16C005	518
Competencias en el Desempeño de Futuros Arquitectos en Torno al Problema Habitacional de los Sectores Pobres 	16C007	519
INCIDENCIA DE LOS PERFILES DE LOS ALUMNOS EN EL RENDIMIENTO ACADEMICO EN MATEMATICA DEL PRIMER AÑO DE LA UNIVERSIDAD 	16F002	520
Caracterización fitoquímica de plantas de la región, como fuente de drogas psocotrópicas y/o antídotos contra venenos. 	16F003	521
USO RACIONAL DE PLANTAS MEDICINALES REGIONALES COMO MEDICAMENTOS FITOTERAPICOS ANTIOXIDANTES Y ANTIMICROBIANOS 	16F004	522
Tipicidad del Queso Artesanal de Corrientes. Mejora de la producción mediante el empleo del fermento GAUCHO y enzimas autóctonas. 	16F005	523
Aspectos Taxonómicos y Ecológicos de Endoparásitos de Roedores y Murciélagos de Corrientes. 	16F006	524
Diversidad y Características Ecológicas de Ectoparásitos de Mamíferos Silvestres y Domésticos de la Provincia de Corrientes 	16F007	525
Paleovegetación y Paleoambiente de la Fm Palo Pintado, Neógeno del Norte de Argentina. 	16F008	526
Importancia Ecológica y Servicios Ecosistemáticos Brindados por las Comunidades de Termitas en el Nordeste Argentino 	16F010	527
Desarrollo Gonadal y Biología reproductiva de Vertebrados del Nordeste de Argentina 	16F011	528
Análisis Biogeográfico, Taxonómico y Ecológico de la Herpetofauna del Nordeste Argentino 	16F012	529
HISTORIA NATURAL DE ANFIBIOS Y REPTILES DEL NORDESTE ARGENTINO 	16F013	530
ESTUDIO DE LA MORFOLOGIA, ANATOMIA Y ECOFISIOLOGIA TEGUMENTARIA EN VERTEBRADOS DEL NORDESTE ARGENTINO 	16F014	531
PROPIEDADES FISICOQUÍMICAS Y FUNCIONALES DE LEGUMBRES CULTIVADAS EN EL NEA. PARTE II: AISLADOS PROTEICOS Y ALMIDONES 	16F017	532
ESTUDIOS BIOSISTEMATICOS EN DIFERENTES FAMILIAS DE PLANTAS VASCULARES AMERICANAS: UN APORTE A LA CARACTERIZACION Y CONSERVACION DE LA DIVERSIDAD FLORISTICA 	16F022	534
La Dimensión Jurídica de la Globalización. impacto en el Nuevo Código 	16G001	535
Los Criterios Judiciales en Materia de Recursos Públicos en Corrientes y Chaco 	16G002	536
El Nordeste Argentino se Mira con Lentes de Género. El Acceso de las Mujeres a Cargo de Decisión en el Sector Público 	16G003	537
´Y Asegurar los Beneficios de la Libertad...¨: La Exigibilidad de los derechos Sociales y Crítica a las Políticas Públicas Sobre las Desigualdades y la Pobreza en la Argentina. 	16G004	538
Análisis Dogmático de la Legislación Penal sobre Estupefacientes (Ley 23.737) y su Consonancia con el Bloque Constitucional de Instrumentos sobre Derechos Humanos. Una MIrada Regional, Comparada, alternativa y superadora. 	16G005	539
Derecho Penal y Nuevas Tecnologías: Grooming, Sexting y Bullyng, etc 	16G006	540
Representación Política: un Estudio de los Sistemas Representativos de los Pueblos Originarios de América y su Aplicación en las Comunidades Locales 	16G008	541
Instituciones y Desempeño Socio Económico en la Región NEA Desde la Perspectiva del Análisis Económico del Derecho 	16G009	542
Estudio Sobre el Acceso a Justicia en las Provincias del NEA 	16G010	543
Incidencia del Código Civil y Comercial de la Nación en el Derecho Privado patrimonial Argentino 	16G011	544
Economía Social y Desarrollo Regional: Aportes para una Construcción Teórica y Funcional de sus Organzaciones en la Región Centro y Nea 	16G012	545
FORMACION PARA LA INVESTIGACION DISCIPLINAR EN LA UNIVERSIDAD. UN ESTUDIO SOBRE CONTEXTOS, SUJETOS Y PROCESOS COGNITIVOS 	16H001	546
PROCESOS DE SUBJETIVACION E INSTITUCIONALIZACION EN PROBLEMATICS FILOSOFICAS CONTEMPORANEAS 	16H002	547
EDUCACION ENTRE INDIGENAS EN EL CHACO ARGENTINO: PASADO Y PRESENTE DE UNA CONFIGURACION SECULAR ENTRE ESTADO, IGLESIAS Y PUEBLOS INDIGENAS 	16H003	548
JOVENES Y ADULTOS EN PROCESOS FORMATIVOS. LA PRACTICA DOCENTE, SUS DIMENSIONES NORMATIVAS Y EXPERIENCIAS SUBJETIVAS EN DIFERENTES CONTEXTOS INSTITUCIONALES. 	16H004	549
Crecimiento Urbano y Salud Ambiental en Ciudades Intermedias de la Provincia del Chaco (1990-2015) 	16H005	550
Estudio Exploratorio del Impacto de las Políticas Públicas de Lectura en la Provincia del Chaco: Análisis Cualitativo de las Prácticas Pedagogicas de Lectura de Docentes y de las Prácticas Lectoras de Estudiantes del Nivel Secundario (2005-2015) 	16H006	551
La Inclusión de las TIC, en la Enseñanza de los Profesores y en los Estudios de Alumnos Universitarios. Estudio de Casos Múltiples en Facultades de la Ciudad de Resistencia, Chaco, de la UNNE 	16H007	552
Descripción y Análisis de Prácticas Letradas Académicas de Estudiantes de la Facultad de Humanidades de la UNNE 2017/2020. 	16H009	553
La Experiencia Escolar en la Escuela Secundaria. Perspectivas y Participación de Actores Educativos Para la Acción Transformadora 	16H012	554
Bases Anatómicas y Topográficas del Tronco Aplicadas en Anatomía Quirúrgica del Tratamiento Oncológico 	16I001	555
Estudio de la Irrigación de los Nervios Periféricos. Anatomía Quirúrgica de la Cirugía Conservadora de los miembros en Oncología. 	16I002	556
Estudio de la Optimización de la Sañalación Celular en la Busqueda de Nuevas Dianas Terapéuticas en Pacientes con Cáncer. 	16I003	557
Determinantes Moleculares de Progresión Neoplasica en el Carcinomal Renal Relacionados con la Hipoxia y la Heterogeneidad Intratumoral. 	16I005	558
Perspectiva de Estudiantes de Ciencias de la Salud Respecto al Aprendizaje, Derivaciones Factibles en el Ámbito Universitario 	16I006	559
Ecoepidemiología de las Parasitosis Intestinales y Equistosomiasis en la Provincia de Corrientes 	16I007	560
Factores de Riesgo para la Transmisión de Leishmaniasis Tegumentar Americana (LTA) en Áreas Endémicas de la Provincia de Corrients. 	16I008	561
Determinación del Verdadero Intérvalo de Muerte (VIM). Variación de Parámetros Orgánicos Humanos en Función del Tiempo. 	16I009	562
Epidemiología Molecular de HTLV-1/2, HIV-1,HBV, HDV, HCV e Implicancias Inmuno-Virológicas de la Coinfección HTLV-1/2HIV-1 en Diferentes Poblaciones de Corrientes. 	16I010	563
Aportes para la actualización de mapas de vientos extremos de Argentina 	16D005	592
DETERMINACION DE LAS PROPIEDADES ANTIABACTERIANA, ADHESIVA Y LIBERACION DE FLUOR Y FLAVONOIDES DEL CEMENTO DE LONOMERO VITREO MODIFICADO CON EXTRACTO DE PROPOLEO 	16J001	564
ESTUDIO MORFOMETRICO DE LAS PIEZAS DENTARIAS PERMANENTE QUE CONFORMAN EL GRUPO MOLAR HUMANO 	16J002	565
Evaluación clínica y microbiológica de diferentes técnicas de remoción químico mecánica de caries dentinarias en niños. 	16J003	566
LA ENSEÑANZA DE LA ETICA MEDIANTE DISCUSION DE DILEMAS Y EL RAZONAMIENTO MORAL EN ESTUDIANTES DE ODONTOLOGIA 	16J004	567
ESTUDIO DESCRIPTIVO DE LAS DISFUNCIONES TEMPORO MANDIBULARES EN PACIENTES DEL HOSPITAL ODONTOLOGICO DE LA UNNE 	16J006	568
ACTIVIDAD DE LA MUCINA SALIVAL EN RELACION A LA ENFERMEDAD PERIODONTAL 	16J007	569
ESTUDIO IN VITRO DE LA FUERZA DE ADHESION DE BRACKETS A LA SUPERFICIE DEL ESMALTE DENTARIO POSBLANQUEADO CON PEROXIDO DE CARBAMINA EN DIFERENTES CONCENTRACIONES, EN INTERVALOS DE TIEMPO Y CON LA APLICACION DE ANTIOXIDANTES Y FLAVONOIDES 	16J008	570
CELULAS MADRE DE PULPA DENTAL DE TERCEROS MOLARES INCLUIDOS: OBTENCION Y CULTIVO 	16J009	571
DETERMINACION DE FACTORES DE RIESGO LOCALES Y SISTEMICOS PREVALENTES EN LA ETIOLOGIA DE PATOLOGIAS PERIODONTALES DE PACIENTES DE LA FACULTAD DE ODONTOLOGIA DE LA UNNE 	16J010	572
CONCENTRACION DE PROTEINAS TOTALES SALIVALES Y NIVELES DE CARIES EN PACIENTES ADOLESCENTES DE LA FACULTAD DE ODONTOLOGIA 	16J011	573
DIAGNOSTICO COMPLEMENTARIO EN ODONTOLOGIA: MICROBIOLOGICO, MOLECULAR CITOLOGICO Y BIOQUIMICO. 	16J012	574
La Toxocariosis y su Vinculación con Factores Sanitarios y Ambientales en el NEA 	16L002	575
Resistencia Frente a Fosfomicina, Colistina y Tigeciclina en Enterobacterias Provenientes de Nuestras Clínicas y Ambientales: Frecuencia y Mecanismos Involucrados. 	16L003	576
Comparación de Métodos de Detección e Identificación de Legionella Pnemophila en Muestra de Agua. 	16L004	577
EL NUEVO SISTEMA DE RESPONSABILIDAD CIVIL EN EL DERECHO PRIVADO ARGENTINO, A PARTIR DEL CODIGO CIVIL Y COMERCIAL 	16M001	578
Análisis Histórico Crítico del Acervo Patrimonial de El Fogón de los Arrieros: Obra Mural, Producción Arquitectónico-Funcional y Arte Documento. 	16N001	579
FILOGENIA, EVOLUCION, BIOGEOGRAFIA, REPRODUCCION Y TAXONOMIA DE RUBIACEAS HERBACEAS DE SUDAMERICA, CON ENFASIS EN ESPECIES ARVENSES DE ARGENTINA 	16P001	580
BIODIVERSIDAD DE ASCOMYCETES LIQUENIZADOS, BASIDIOMYCETES Y BRIOFITAS DEL NORTE ARGENTINO Y REGIONES LIMITROFES 	16P002	581
GERMOPLASMA DE LEGUMINOSAS DE INTERES PRODUCTIVO: CONSERVACION, CARACTERIZACION Y PREMEJORAMIENTO 	16P003	582
Procesos de Construcción de Identidad Vinculados a una Actitud Económica. El Caso del Algodón en el Chaco Durante la Etapa Territoriana. 	16S001	583
Ideologías Lingüísticas en las Políticas Referidas a Lenguasa Indígenas de la Región NEA. 	16S002	584
La Política y el Estado en los Margenes. Saberes, Identidades, Culturas y Prácticas Políticas en el Nordeste Arentino (S. XX-XXI) 	16S003	585
Concepciones Críticas y Prácticas Alternativas a Formas Hegemónicas de Representación y Organización del Trabajo y la Producción Actuales 	16W001	586
Estudios en Gubernamentalidad: Problemas, Objetos y Conceptos en su Relación con la Política, los Procesos de Subjetivación y el Trabajo. 	16W002	587
Participación Política Juvenil. Procesos de Socialización y Subjetivación en las Ciudades de Resistencia t Corrientes 	16W004	588
Simulación numérica del proceso biológico de crecimiento de células tumorales, 1er etapa 	16D001	589
Manejo integral del agua pluvial en ciudades polderizadas del nordeste argentino 	16D003	590
Huella hídrica urbana y en actividades productivas rurales de Chaco y Corrientes 	16D004	591
El puerto de Barranqueras y su encuadre en un esquema multimodal de cargas para la región 	16D007	593
Estudio y caracterización de calefones solares construidos con alumnos de la FaCENA para su instalación en zonas rurales. 	16F009	594
Diseño asistido por computadora de inhibidores de fosfolipasas a2 en venenos de serpientes que habitan el nordeste argentino. 	16F021	595
Paisaje y territorio: expansión urbana y sustentabilidad en el AMGR 	16C006	596
Simulación computacional del comportamiento de falla de materiales cuasifragiles 	16D002	597
Acústica no lineal y pulsos ultrasónicos aplicados a la evaluación no destructiva de las propiedades mecánicas de materiales y del estado de integridad de componentes 	16D006	598
Modelos de decisión y operadores de agregación para la administración de procesos en sistemas distribuidos. 	16F001	599
Promoción del pensamiento computacional para favorecer la formación en STEM. 	16F016	600
TI en los sistemas de información: modelos, métodos y herramientas 	16F019	601
Unificación de Criterios Interpretativos en los Poderes Judiciales del Nordeste. Aportes de las Teorías de la Interpretación Jurídica y de la Argumentación Jurídica. Efectivo Acceso a la Justicia. 	16G007	609
Obtención y Validación de Antígenos para su Aplicación en Pruebas Dianósticas para Toxocariosis 	16L001	610
La Participación en Contextos Sociales de Vulnerabilidqd. Hacia nuevas estrategias de ciudadanía y Relaciones Políticas 	16W003	611
Caracterización sedimentológica, isotópica, paleobiológica, paleobiogeoquímica, paleoambiental y paleoclimática de la transición sinrift a postrift de la cuenca jurásica/eocretácica del Chubut central. Correlación con la cuenca jurásica del Deseado 	PIP-112 / 201001 / 00034	612
Bases Internas de la competitividad de las PYMES en la ciudades de Rosarios, Resistencia y Corrientes y su impacto en el área comercial. 	1ECO158	613
Indígenas en la Universidad Nacional del Nordeste. Análisis de las Experiencias estudiantiles y la participación. Grupo de Estudio y Extensión sobre Pueblos Indígenas y Educación en el Chaco Argentino 	PIH011-2014	614
HER 2 en el cáncer gástrico determinación de la expresión, biomarcador molecular	RESOL 4441/14 CD FAC MED	615
\.


--
-- Data for Name: requisitos_convocatoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY requisitos_convocatoria (id_convocatoria, requisito, obligatorio, id_requisito) FROM stdin;
2	Fotocopia de DNI	0	1
2	Aval de la autoridad de la Facultad o Instituto	1	2
3	Fotocopia de DNI	1	3
3	Fotocopia de Partida de Nacimiento	0	4
3	Constancia de Alumno Regular	0	5
4	Copia de Partida de Nacimiento	0	6
4	Constancia de Grupo Sanguíneo	1	7
4	Titulo Universitario	1	8
\.


--
-- Name: requisitos_convocatoria_id_requisito_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('requisitos_convocatoria_id_requisito_seq', 8, true);


--
-- Data for Name: resoluciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY resoluciones (nro_resol, anio, fecha, archivo_pdf, id_tipo_resol) FROM stdin;
988	1993	1993-06-13	1993-988-cdfca.pdf	2
162	2003	2017-09-18	2003-162-cdfce.pdf	3
1	2000	2000-01-10	2000-1-cdfca.pdf	2
161	2003	2017-09-18	2003-161-cs.pdf	1
2	2002	2002-01-01	2002-2-cs.pdf	1
1232	2003	2003-09-24	2003-1232-cdfca.pdf	2
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
3	DNI Temporario
4	Libreta Civica
5	Libreta de Enrolamiento
\.


--
-- Data for Name: tipos_beca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipos_beca (id_tipo_beca, id_tipo_convocatoria, tipo_beca, duracion_meses, meses_present_avance, cupo_maximo, id_color, estado) FROM stdin;
1	1	Pre-grado	\N	\N	\N	\N	A
5	2	Pre-Grado	\N	\N	\N	\N	A
4	3	Cofinanciadas UNNE-CONICET	60	12	150	1	A
2	1	Iniciación	12	6	250	3	A
3	1	Perfeccionamiento	36	18	20	2	I
\.


--
-- Name: tipos_beca_id_tipo_beca_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipos_beca_id_tipo_beca_seq', 5, true);


--
-- Data for Name: tipos_convocatoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipos_convocatoria (id_tipo_convocatoria, tipo_convocatoria) FROM stdin;
1	Becas Internas CyT - UNNE
2	Becas EVC-CIN
3	Becas UNNE-CONICET
\.


--
-- Name: tipos_convocatoria_id_tipo_convocatoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipos_convocatoria_id_tipo_convocatoria_seq', 3, true);


--
-- Data for Name: tipos_resolucion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipos_resolucion (id_tipo_resol, tipo_resol, tipo_resol_corto) FROM stdin;
2	Consejo Directivo - Facultad de Ciencias Agrarias	C.D. F.C.A
1	Consejo Superior	C.S.
3	Consejo Directivo - Facultad de Ciencias Económicas	C.D. F.C.E.
4	Consejo Directivo - Facultad de Ciencias Exactas	C.D. F.C.Ex.
\.


--
-- Data for Name: universidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY universidades (id_universidad, universidad, id_pais, sigla) FROM stdin;
1	Universidad Nacional del Nordeste	54	UNNE
2	Universidad Nacional de Misiones	54	UNAM
3	Universidad Nacional de Santiago del Estero	54	UNSE
4	Universidad Nacional de Jujuy	54	UNJU
5	Universidad Nacional de Buenos Aires	54	UBA
6	Universidad Nacional de la Plata	54	UNP
\.


--
-- Name: area_conocimiento pk_area_conocimiento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY area_conocimiento
    ADD CONSTRAINT pk_area_conocimiento PRIMARY KEY (id_area_conocimiento);


--
-- Name: areas_dependencia pk_areas_dependencia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY areas_dependencia
    ADD CONSTRAINT pk_areas_dependencia PRIMARY KEY (id_area);


--
-- Name: avance_beca pk_avance_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avance_beca
    ADD CONSTRAINT pk_avance_beca PRIMARY KEY (id_avance);


--
-- Name: baja_becas pk_baja_becas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY baja_becas
    ADD CONSTRAINT pk_baja_becas PRIMARY KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: becas_otorgadas pk_becas_otorgadas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY becas_otorgadas
    ADD CONSTRAINT pk_becas_otorgadas PRIMARY KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: cargos_docente pk_cargos_docente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_docente
    ADD CONSTRAINT pk_cargos_docente PRIMARY KEY (id_cargo);


--
-- Name: cargos_unne pk_cargos_unne; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_unne
    ADD CONSTRAINT pk_cargos_unne PRIMARY KEY (id_cargo_unne);


--
-- Name: carrera_dependencia pk_carrera_dependencia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carrera_dependencia
    ADD CONSTRAINT pk_carrera_dependencia PRIMARY KEY (id_dependencia, id_carrera);


--
-- Name: carreras pk_carreras; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carreras
    ADD CONSTRAINT pk_carreras PRIMARY KEY (id_carrera);


--
-- Name: categorias_conicet pk_categorias_conicet; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias_conicet
    ADD CONSTRAINT pk_categorias_conicet PRIMARY KEY (id_cat_conicet);


--
-- Name: categorias_incentivos pk_categorias_incentivos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias_incentivos
    ADD CONSTRAINT pk_categorias_incentivos PRIMARY KEY (id_cat_incentivos);


--
-- Name: color_carpeta pk_color_carpeta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY color_carpeta
    ADD CONSTRAINT pk_color_carpeta PRIMARY KEY (id_color);


--
-- Name: comision_asesora pk_comision_asesora; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_asesora
    ADD CONSTRAINT pk_comision_asesora PRIMARY KEY (id_area_conocimiento, id_convocatoria);


--
-- Name: convocatoria_beca pk_convocatoria_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY convocatoria_beca
    ADD CONSTRAINT pk_convocatoria_beca PRIMARY KEY (id_convocatoria);


--
-- Name: cumplimiento_obligacion pk_cumplimiento_obligacion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cumplimiento_obligacion
    ADD CONSTRAINT pk_cumplimiento_obligacion PRIMARY KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca, mes, anio);


--
-- Name: dedicacion pk_dedicacion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dedicacion
    ADD CONSTRAINT pk_dedicacion PRIMARY KEY (id_dedicacion);


--
-- Name: dependencias pk_dependencias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencias
    ADD CONSTRAINT pk_dependencias PRIMARY KEY (id_dependencia);


--
-- Name: docentes pk_docentes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY docentes
    ADD CONSTRAINT pk_docentes PRIMARY KEY (id_tipo_doc, nro_documento);


--
-- Name: inscripcion_conv_beca pk_inscripcion_conv_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT pk_inscripcion_conv_beca PRIMARY KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: integrante_comision_asesora pk_integrante_comision_asesora; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY integrante_comision_asesora
    ADD CONSTRAINT pk_integrante_comision_asesora PRIMARY KEY (nro_documento, id_tipo_doc, id_convocatoria, id_area_conocimiento);


--
-- Name: localidades pk_localidades; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidades
    ADD CONSTRAINT pk_localidades PRIMARY KEY (id_pais, id_provincia, id_localidad);


--
-- Name: motivos_baja pk_motivos_baja; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY motivos_baja
    ADD CONSTRAINT pk_motivos_baja PRIMARY KEY (id_motivo_baja);


--
-- Name: niveles_academicos pk_niveles_academicos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY niveles_academicos
    ADD CONSTRAINT pk_niveles_academicos PRIMARY KEY (id_nivel_academico);


--
-- Name: paises pk_paises; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pk_paises PRIMARY KEY (id_pais);


--
-- Name: personas pk_personas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT pk_personas PRIMARY KEY (nro_documento, id_tipo_doc);


--
-- Name: provincias pk_provincias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincias
    ADD CONSTRAINT pk_provincias PRIMARY KEY (id_provincia, id_pais);


--
-- Name: proyectos pk_proyectos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT pk_proyectos PRIMARY KEY (id_proyecto);


--
-- Name: requisitos_convocatoria pk_requisitos_convocatoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requisitos_convocatoria
    ADD CONSTRAINT pk_requisitos_convocatoria PRIMARY KEY (id_convocatoria, id_requisito);


--
-- Name: resoluciones pk_resoluciones; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resoluciones
    ADD CONSTRAINT pk_resoluciones PRIMARY KEY (nro_resol, anio, id_tipo_resol);


--
-- Name: resultado_avance pk_resultado_avance; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resultado_avance
    ADD CONSTRAINT pk_resultado_avance PRIMARY KEY (id_resultado);


--
-- Name: tipo_documento pk_tipo_documento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_documento
    ADD CONSTRAINT pk_tipo_documento PRIMARY KEY (id_tipo_doc);


--
-- Name: tipos_beca pk_tipos_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_beca
    ADD CONSTRAINT pk_tipos_beca PRIMARY KEY (id_tipo_beca);


--
-- Name: tipos_convocatoria pk_tipos_convocatoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_convocatoria
    ADD CONSTRAINT pk_tipos_convocatoria PRIMARY KEY (id_tipo_convocatoria);


--
-- Name: tipos_resolucion pk_tipos_resolucion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_resolucion
    ADD CONSTRAINT pk_tipos_resolucion PRIMARY KEY (id_tipo_resol);


--
-- Name: universidades pk_universidades; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY universidades
    ADD CONSTRAINT pk_universidades PRIMARY KEY (id_universidad);


--
-- Name: provincias uk_provincia_pais; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincias
    ADD CONSTRAINT uk_provincia_pais UNIQUE (id_pais, provincia);


--
-- Name: niveles_academicos uq_nivel_academico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY niveles_academicos
    ADD CONSTRAINT uq_nivel_academico UNIQUE (nivel_academico);


--
-- Name: proyectos uq_proyectos_proyecto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT uq_proyectos_proyecto UNIQUE (proyecto);


--
-- Name: universidades uq_universidades_universidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY universidades
    ADD CONSTRAINT uq_universidades_universidad UNIQUE (universidad, id_pais);


--
-- Name: areas_dependencia fk_areas_dependencia_dependencia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY areas_dependencia
    ADD CONSTRAINT fk_areas_dependencia_dependencia FOREIGN KEY (id_dependencia) REFERENCES dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: avance_beca fk_avance_beca_resultado_avance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avance_beca
    ADD CONSTRAINT fk_avance_beca_resultado_avance FOREIGN KEY (id_resultado) REFERENCES resultado_avance(id_resultado) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: baja_becas fk_baja_becas_becasotorgadas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY baja_becas
    ADD CONSTRAINT fk_baja_becas_becasotorgadas FOREIGN KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca) REFERENCES becas_otorgadas(id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: baja_becas fk_baja_becas_motivo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY baja_becas
    ADD CONSTRAINT fk_baja_becas_motivo FOREIGN KEY (id_motivo_baja) REFERENCES motivos_baja(id_motivo_baja) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: becas_otorgadas fk_becas_otorgadas_inscconvbeca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY becas_otorgadas
    ADD CONSTRAINT fk_becas_otorgadas_inscconvbeca FOREIGN KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca) REFERENCES inscripcion_conv_beca(id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: becas_otorgadas fk_becas_otorgadas_resol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY becas_otorgadas
    ADD CONSTRAINT fk_becas_otorgadas_resol FOREIGN KEY (id_tipo_resol, nro_resol, anio) REFERENCES resoluciones(id_tipo_resol, nro_resol, anio);


--
-- Name: cargos_docente fk_cargos_doc_dedicacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_docente
    ADD CONSTRAINT fk_cargos_doc_dedicacion FOREIGN KEY (id_dedicacion) REFERENCES dedicacion(id_dedicacion) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cargos_docente fk_cargos_docente_cargo_unne; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_docente
    ADD CONSTRAINT fk_cargos_docente_cargo_unne FOREIGN KEY (id_cargo_unne) REFERENCES cargos_unne(id_cargo_unne) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cargos_docente fk_cargos_docente_dependencias; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_docente
    ADD CONSTRAINT fk_cargos_docente_dependencias FOREIGN KEY (id_dependencia) REFERENCES dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cargos_docente fk_cargos_docente_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargos_docente
    ADD CONSTRAINT fk_cargos_docente_docente FOREIGN KEY (nro_documento, id_tipo_doc) REFERENCES docentes(nro_documento, id_tipo_doc) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: carrera_dependencia fk_carrera_dependencia_carreras; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carrera_dependencia
    ADD CONSTRAINT fk_carrera_dependencia_carreras FOREIGN KEY (id_carrera) REFERENCES carreras(id_carrera) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: carrera_dependencia fk_carrera_dependencia_dependencias; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carrera_dependencia
    ADD CONSTRAINT fk_carrera_dependencia_dependencias FOREIGN KEY (id_dependencia) REFERENCES dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: comision_asesora fk_comision_asesora_area_conocimiento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_asesora
    ADD CONSTRAINT fk_comision_asesora_area_conocimiento FOREIGN KEY (id_area_conocimiento) REFERENCES area_conocimiento(id_area_conocimiento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: comision_asesora fk_comision_asesora_convocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_asesora
    ADD CONSTRAINT fk_comision_asesora_convocatoria FOREIGN KEY (id_convocatoria) REFERENCES convocatoria_beca(id_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: convocatoria_beca fk_convocatoria_beca_tipoconvocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY convocatoria_beca
    ADD CONSTRAINT fk_convocatoria_beca_tipoconvocatoria FOREIGN KEY (id_tipo_convocatoria) REFERENCES tipos_convocatoria(id_tipo_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cumplimiento_obligacion fk_cumplimiento_obligacion_becaotorgada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cumplimiento_obligacion
    ADD CONSTRAINT fk_cumplimiento_obligacion_becaotorgada FOREIGN KEY (id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca) REFERENCES becas_otorgadas(id_tipo_doc, nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: dependencias fk_dependencia_localidad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencias
    ADD CONSTRAINT fk_dependencia_localidad FOREIGN KEY (id_pais, id_provincia, id_localidad) REFERENCES localidades(id_pais, id_provincia, id_localidad) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: dependencias fk_dependencias_universidades; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencias
    ADD CONSTRAINT fk_dependencias_universidades FOREIGN KEY (id_universidad) REFERENCES universidades(id_universidad) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: docentes fk_docente_cat_conicet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY docentes
    ADD CONSTRAINT fk_docente_cat_conicet FOREIGN KEY (id_cat_conicet) REFERENCES categorias_conicet(id_cat_conicet) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: docentes fk_docente_dep_conicet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY docentes
    ADD CONSTRAINT fk_docente_dep_conicet FOREIGN KEY (id_dependencia_conicet) REFERENCES dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: docentes fk_docentes_categorias_incentivos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY docentes
    ADD CONSTRAINT fk_docentes_categorias_incentivos FOREIGN KEY (id_cat_incentivos) REFERENCES categorias_incentivos(id_cat_incentivos) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: docentes fk_docentes_personas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY docentes
    ADD CONSTRAINT fk_docentes_personas FOREIGN KEY (id_tipo_doc, nro_documento) REFERENCES personas(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: inscripcion_conv_beca fk_insc_conv_beca_codir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_insc_conv_beca_codir FOREIGN KEY (id_tipo_doc_codir, nro_documento_codir) REFERENCES docentes(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: inscripcion_conv_beca fk_insc_conv_beca_dir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_insc_conv_beca_dir FOREIGN KEY (id_tipo_doc_dir, nro_documento_dir) REFERENCES docentes(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: inscripcion_conv_beca fk_insc_conv_beca_idproyecto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_insc_conv_beca_idproyecto FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: inscripcion_conv_beca fk_insc_conv_beca_lugartrabajo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_insc_conv_beca_lugartrabajo FOREIGN KEY (lugar_trabajo_becario) REFERENCES dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: inscripcion_conv_beca fk_insc_conv_beca_subdir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_insc_conv_beca_subdir FOREIGN KEY (id_tipo_doc_subdir, nro_documento_subdir) REFERENCES docentes(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: inscripcion_conv_beca fk_inscripcion_conv_beca_area_conocimiento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_area_conocimiento FOREIGN KEY (id_area_conocimiento) REFERENCES area_conocimiento(id_area_conocimiento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: inscripcion_conv_beca fk_inscripcion_conv_beca_dependencias; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_dependencias FOREIGN KEY (id_dependencia) REFERENCES dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: inscripcion_conv_beca fk_inscripcion_conv_beca_idconvocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_idconvocatoria FOREIGN KEY (id_convocatoria) REFERENCES convocatoria_beca(id_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: inscripcion_conv_beca fk_inscripcion_conv_beca_idtipobeca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_idtipobeca FOREIGN KEY (id_tipo_beca) REFERENCES tipos_beca(id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: inscripcion_conv_beca fk_inscripcion_conv_beca_personas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_personas FOREIGN KEY (id_tipo_doc, nro_documento) REFERENCES personas(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: inscripcion_conv_beca fk_inscripcion_conv_becas_carrera; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_becas_carrera FOREIGN KEY (id_carrera) REFERENCES carreras(id_carrera) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: integrante_comision_asesora fk_integrante_comision_asesora_comision_asesora; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY integrante_comision_asesora
    ADD CONSTRAINT fk_integrante_comision_asesora_comision_asesora FOREIGN KEY (id_convocatoria, id_area_conocimiento) REFERENCES comision_asesora(id_convocatoria, id_area_conocimiento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: integrante_comision_asesora fk_integrante_comision_asesora_personas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY integrante_comision_asesora
    ADD CONSTRAINT fk_integrante_comision_asesora_personas FOREIGN KEY (id_tipo_doc, nro_documento) REFERENCES personas(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: localidades fk_localidades_provincias; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidades
    ADD CONSTRAINT fk_localidades_provincias FOREIGN KEY (id_pais, id_provincia) REFERENCES provincias(id_pais, id_provincia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: personas fk_personas_localidades; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT fk_personas_localidades FOREIGN KEY (id_pais, id_localidad, id_provincia) REFERENCES localidades(id_pais, id_localidad, id_provincia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: personas fk_personas_nivel_academico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT fk_personas_nivel_academico FOREIGN KEY (id_nivel_academico) REFERENCES niveles_academicos(id_nivel_academico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: personas fk_personas_tipo_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT fk_personas_tipo_documento FOREIGN KEY (id_tipo_doc) REFERENCES tipo_documento(id_tipo_doc) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: provincias fk_provincias_paises; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincias
    ADD CONSTRAINT fk_provincias_paises FOREIGN KEY (id_pais) REFERENCES paises(id_pais) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: requisitos_convocatoria fk_requisitos_convocatoria_id_convocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requisitos_convocatoria
    ADD CONSTRAINT fk_requisitos_convocatoria_id_convocatoria FOREIGN KEY (id_convocatoria) REFERENCES convocatoria_beca(id_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: resoluciones fk_resoluciones_id_tipo_resol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resoluciones
    ADD CONSTRAINT fk_resoluciones_id_tipo_resol FOREIGN KEY (id_tipo_resol) REFERENCES tipos_resolucion(id_tipo_resol) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tipos_beca fk_tipos_beca_idcolor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_beca
    ADD CONSTRAINT fk_tipos_beca_idcolor FOREIGN KEY (id_color) REFERENCES color_carpeta(id_color) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tipos_beca fk_tipos_beca_tipoconvocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_beca
    ADD CONSTRAINT fk_tipos_beca_tipoconvocatoria FOREIGN KEY (id_tipo_convocatoria) REFERENCES tipos_convocatoria(id_tipo_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: universidades fk_universidades_paises; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY universidades
    ADD CONSTRAINT fk_universidades_paises FOREIGN KEY (id_pais) REFERENCES paises(id_pais) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

