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
    id_localidad smallint
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
-- Name: direccion_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE direccion_beca (
    nro_documento character varying(15) NOT NULL,
    id_tipo_doc smallint NOT NULL,
    id_convocatoria smallint NOT NULL,
    tipo character(1) NOT NULL,
    id_categoria smallint NOT NULL,
    id_tipo_doc_dir smallint,
    nro_documento_dir character varying(15)
);


ALTER TABLE direccion_beca OWNER TO postgres;

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
    id_tipo_beca smallint NOT NULL
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
    id_color smallint
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

SELECT pg_catalog.setval('be_cargos_docente_id_cargo_seq', 4, true);


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

SELECT pg_catalog.setval('be_universidades_id_universidad_seq', 5, true);


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
5	3	3	4	2017-10-09	2017-10-26	A	1	32405039
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
2017-10-01	2017-10-26	2017-11-03	3	Convocatoria EVC-CIN - 2017	1
2016-01-01	2016-12-30	2016-12-31	4	Becas Cofinanciadas UNNE-CONICET 2016	3
2017-10-02	2017-10-30	2017-11-10	2	Convocatoria CyT - UNNE - 2016	3
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

COPY dependencias (id_dependencia, nombre, descripcion_corta, id_universidad, id_pais, id_provincia, id_localidad) FROM stdin;
1	Facultad de Ciencias Agrarias	FCA	1	\N	\N	\N
2	Facultad de Ciencias Exactas, Naturales y Agrimensura	FACENA	1	\N	\N	\N
3	Facultad de Arquitectura	FA	2	\N	\N	\N
4	Facultad de Humanidades	FHum	3	\N	\N	\N
6	Facultad de Ingeniería	FIng	3	\N	\N	\N
7	Facultad de Ingeniería	FIng	5	\N	\N	\N
5	Departamento de Idiomas Modernos	DIM	1	54	2	3
\.


--
-- Data for Name: direccion_beca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY direccion_beca (nro_documento, id_tipo_doc, id_convocatoria, tipo, id_categoria, id_tipo_doc_dir, nro_documento_dir) FROM stdin;
\.


--
-- Data for Name: docentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY docentes (nro_documento, id_tipo_doc, legajo, id_cat_incentivos, id_cat_conicet, id_dependencia_conicet) FROM stdin;
31255073	1	12000	1	7	5
55241374	1	2	1	10	6
32405039	1	1	1	7	\N
\.


--
-- Data for Name: inscripcion_conv_beca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY inscripcion_conv_beca (id_dependencia, nro_documento, id_tipo_doc, id_convocatoria, fecha_hora, admisible, puntaje, beca_otorgada, id_area_conocimiento, titulo_plan_beca, justif_codirector, id_carrera, materias_plan, materias_aprobadas, prom_hist_egresados, prom_hist, carrera_posgrado, nombre_inst_posgrado, titulo_carrera_posgrado, nro_carpeta, observaciones, estado, cant_fojas, es_titular, id_tipo_beca) FROM stdin;
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
32405039	1	Alemany	Marcelo Federico	20324050397	1986-07-17	0379-154844649	mfalemany@gmail.com	No tiene	1	1	54	4
31255073	1	Morales	Susana Beatriz	27312550739	1984-11-23	0379-154551427	susanabeatrizmorales1@gmail.com	No tiene	4	5	54	3
55241374	1	Alemany Morales	Marcelo Ricardo	20552413742	2016-02-16	\N	\N	\N	1	1	54	9
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
-- Data for Name: requisitos_convocatoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY requisitos_convocatoria (id_convocatoria, requisito, obligatorio, id_requisito) FROM stdin;
\.


--
-- Name: requisitos_convocatoria_id_requisito_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('requisitos_convocatoria_id_requisito_seq', 1, false);


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

COPY tipos_beca (id_tipo_beca, id_tipo_convocatoria, tipo_beca, duracion_meses, meses_present_avance, cupo_maximo, id_color) FROM stdin;
1	1	Pre-grado	\N	\N	\N	\N
5	2	Pre-Grado	\N	\N	\N	\N
4	3	Cofinanciadas UNNE-CONICET	60	12	150	1
2	1	Iniciación	12	6	250	3
3	1	Perfeccionamiento	36	18	20	2
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
-- Name: pk_direccion_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY direccion_beca
    ADD CONSTRAINT pk_direccion_beca PRIMARY KEY (nro_documento, id_tipo_doc, id_convocatoria, id_categoria, tipo);


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
-- Name: pk_requisitos_convocatoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requisitos_convocatoria
    ADD CONSTRAINT pk_requisitos_convocatoria PRIMARY KEY (id_convocatoria, id_requisito);


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
-- Name: uq_nivel_academico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY niveles_academicos
    ADD CONSTRAINT uq_nivel_academico UNIQUE (nivel_academico);


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
-- Name: fk_direccion_beca_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY direccion_beca
    ADD CONSTRAINT fk_direccion_beca_docente FOREIGN KEY (id_tipo_doc_dir, nro_documento) REFERENCES docentes(id_tipo_doc, nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


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

