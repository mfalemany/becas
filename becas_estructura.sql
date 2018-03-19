--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.12
-- Dumped by pg_dump version 9.5.12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
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


--
-- Name: recuperar_schema_temp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.recuperar_schema_temp() RETURNS character varying
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
-- Name: antec_activ_docentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antec_activ_docentes (
    id_antecedente integer NOT NULL,
    institucion character varying(150) NOT NULL,
    cargo character varying(100) NOT NULL,
    anio_ingreso numeric(4,0) NOT NULL,
    anio_egreso numeric(4,0),
    nro_documento character varying(15) NOT NULL,
    doc_probatoria character varying(300)
);


ALTER TABLE public.antec_activ_docentes OWNER TO postgres;

--
-- Name: antec_activ_docentes_id_antecedente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antec_activ_docentes_id_antecedente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antec_activ_docentes_id_antecedente_seq OWNER TO postgres;

--
-- Name: antec_activ_docentes_id_antecedente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antec_activ_docentes_id_antecedente_seq OWNED BY public.antec_activ_docentes.id_antecedente;


--
-- Name: antec_becas_obtenidas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antec_becas_obtenidas (
    id_beca_obtenida integer NOT NULL,
    institucion character varying(100) NOT NULL,
    tipo_beca character varying(50) NOT NULL,
    nro_documento character varying(15) NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date NOT NULL,
    doc_probatoria character varying(300)
);


ALTER TABLE public.antec_becas_obtenidas OWNER TO postgres;

--
-- Name: antec_becas_obtenidas_id_beca_obtenida_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antec_becas_obtenidas_id_beca_obtenida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antec_becas_obtenidas_id_beca_obtenida_seq OWNER TO postgres;

--
-- Name: antec_becas_obtenidas_id_beca_obtenida_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antec_becas_obtenidas_id_beca_obtenida_seq OWNED BY public.antec_becas_obtenidas.id_beca_obtenida;


--
-- Name: antec_conoc_idiomas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antec_conoc_idiomas (
    id_conocimiento_idioma integer NOT NULL,
    idioma character varying(100) NOT NULL,
    lectura numeric(1,0) NOT NULL,
    escritura numeric(1,0) NOT NULL,
    conversacion numeric(1,0) NOT NULL,
    traduccion numeric(1,0) NOT NULL,
    nro_documento character varying(15),
    doc_probatoria character varying(300)
);


ALTER TABLE public.antec_conoc_idiomas OWNER TO postgres;

--
-- Name: antec_conoc_idiomas_id_conocimiento_idioma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antec_conoc_idiomas_id_conocimiento_idioma_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antec_conoc_idiomas_id_conocimiento_idioma_seq OWNER TO postgres;

--
-- Name: antec_conoc_idiomas_id_conocimiento_idioma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antec_conoc_idiomas_id_conocimiento_idioma_seq OWNED BY public.antec_conoc_idiomas.id_conocimiento_idioma;


--
-- Name: antec_cursos_perfec_aprob; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antec_cursos_perfec_aprob (
    id_curso_perfec_aprob integer NOT NULL,
    institucion character varying(150) NOT NULL,
    tema character varying(300) NOT NULL,
    carga_horaria numeric(4,0),
    fecha date,
    nro_documento character varying(15) NOT NULL,
    doc_probatoria character varying(300)
);


ALTER TABLE public.antec_cursos_perfec_aprob OWNER TO postgres;

--
-- Name: antec_cursos_perfec_aprob_id_curso_perfec_aprob_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antec_cursos_perfec_aprob_id_curso_perfec_aprob_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antec_cursos_perfec_aprob_id_curso_perfec_aprob_seq OWNER TO postgres;

--
-- Name: antec_cursos_perfec_aprob_id_curso_perfec_aprob_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antec_cursos_perfec_aprob_id_curso_perfec_aprob_seq OWNED BY public.antec_cursos_perfec_aprob.id_curso_perfec_aprob;


--
-- Name: antec_estudios_afines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antec_estudios_afines (
    id_estudio_afin integer NOT NULL,
    institucion character varying(100),
    titulo character varying(200) NOT NULL,
    nro_documento character varying(15),
    anio_desde numeric(4,0) NOT NULL,
    anio_hasta numeric(4,0),
    doc_probatoria character varying(300)
);


ALTER TABLE public.antec_estudios_afines OWNER TO postgres;

--
-- Name: antec_estudios_afines_id_estudio_afin_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antec_estudios_afines_id_estudio_afin_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antec_estudios_afines_id_estudio_afin_seq OWNER TO postgres;

--
-- Name: antec_estudios_afines_id_estudio_afin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antec_estudios_afines_id_estudio_afin_seq OWNED BY public.antec_estudios_afines.id_estudio_afin;


--
-- Name: antec_otras_actividades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antec_otras_actividades (
    id_otra_actividad integer NOT NULL,
    institucion character varying(100) NOT NULL,
    actividad character varying(200) NOT NULL,
    titulo_tema character varying(300) NOT NULL,
    nro_documento character varying(15),
    doc_probatoria character varying(300)
);


ALTER TABLE public.antec_otras_actividades OWNER TO postgres;

--
-- Name: antec_otras_actividades_id_otra_actividad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antec_otras_actividades_id_otra_actividad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antec_otras_actividades_id_otra_actividad_seq OWNER TO postgres;

--
-- Name: antec_otras_actividades_id_otra_actividad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antec_otras_actividades_id_otra_actividad_seq OWNED BY public.antec_otras_actividades.id_otra_actividad;


--
-- Name: antec_particip_dict_cursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antec_particip_dict_cursos (
    id_particip_cursos integer NOT NULL,
    institucion character varying(100) NOT NULL,
    carga_horaria numeric(4,0) NOT NULL,
    fecha date NOT NULL,
    nro_documento character varying(15),
    doc_probatoria character varying(300)
);


ALTER TABLE public.antec_particip_dict_cursos OWNER TO postgres;

--
-- Name: antec_particip_cursos_id_particip_cursos_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antec_particip_cursos_id_particip_cursos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antec_particip_cursos_id_particip_cursos_seq OWNER TO postgres;

--
-- Name: antec_particip_cursos_id_particip_cursos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antec_particip_cursos_id_particip_cursos_seq OWNED BY public.antec_particip_dict_cursos.id_particip_cursos;


--
-- Name: antec_present_reuniones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antec_present_reuniones (
    id_present_reunion integer NOT NULL,
    autores character varying(300) NOT NULL,
    titulo_trabajo character varying(200) NOT NULL,
    fecha date NOT NULL,
    nro_documento character varying(15),
    doc_probatoria character varying(300)
);


ALTER TABLE public.antec_present_reuniones OWNER TO postgres;

--
-- Name: antec_present_reuniones_id_present_reunion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antec_present_reuniones_id_present_reunion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antec_present_reuniones_id_present_reunion_seq OWNER TO postgres;

--
-- Name: antec_present_reuniones_id_present_reunion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antec_present_reuniones_id_present_reunion_seq OWNED BY public.antec_present_reuniones.id_present_reunion;


--
-- Name: antec_trabajos_publicados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antec_trabajos_publicados (
    id_trabajo_publicado integer NOT NULL,
    autores character varying(200) NOT NULL,
    datos_publicacion character varying(750) NOT NULL,
    fecha date NOT NULL,
    nro_documento character varying(15),
    doc_probatoria character varying(300)
);


ALTER TABLE public.antec_trabajos_publicados OWNER TO postgres;

--
-- Name: antec_trabajos_publicados_id_trabajo_publicado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antec_trabajos_publicados_id_trabajo_publicado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antec_trabajos_publicados_id_trabajo_publicado_seq OWNER TO postgres;

--
-- Name: antec_trabajos_publicados_id_trabajo_publicado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antec_trabajos_publicados_id_trabajo_publicado_seq OWNED BY public.antec_trabajos_publicados.id_trabajo_publicado;


--
-- Name: area_conocimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.area_conocimiento (
    id_area_conocimiento smallint NOT NULL,
    area_conocimiento character varying(75),
    area_conocimiento_corto character varying(5),
    disciplinas_incluidas character varying(400)
);


ALTER TABLE public.area_conocimiento OWNER TO postgres;

--
-- Name: areas_dependencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.areas_dependencia (
    id_area smallint NOT NULL,
    area character varying(100),
    id_dependencia smallint
);


ALTER TABLE public.areas_dependencia OWNER TO postgres;

--
-- Name: avance_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avance_beca (
    id_avance integer NOT NULL,
    fecha date,
    tipo_avance character(1),
    nro_documento character varying(15),
    id_convocatoria smallint,
    id_resultado smallint,
    observaciones character varying(500),
    id_tipo_beca smallint
);


ALTER TABLE public.avance_beca OWNER TO postgres;

--
-- Name: baja_becas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.baja_becas (
    nro_documento character varying(15) NOT NULL,
    id_convocatoria smallint NOT NULL,
    fecha_baja date,
    id_motivo_baja smallint,
    observaciones character varying(300),
    id_tipo_beca smallint NOT NULL
);


ALTER TABLE public.baja_becas OWNER TO postgres;

--
-- Name: be_area_conocimiento_id_area_conocimiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_area_conocimiento_id_area_conocimiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_area_conocimiento_id_area_conocimiento_seq OWNER TO postgres;

--
-- Name: be_area_conocimiento_id_area_conocimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_area_conocimiento_id_area_conocimiento_seq OWNED BY public.area_conocimiento.id_area_conocimiento;


--
-- Name: be_areas_dependencia_id_area_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_areas_dependencia_id_area_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_areas_dependencia_id_area_seq OWNER TO postgres;

--
-- Name: be_areas_dependencia_id_area_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_areas_dependencia_id_area_seq OWNED BY public.areas_dependencia.id_area;


--
-- Name: be_avance_beca_id_avance_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_avance_beca_id_avance_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_avance_beca_id_avance_seq OWNER TO postgres;

--
-- Name: be_avance_beca_id_avance_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_avance_beca_id_avance_seq OWNED BY public.avance_beca.id_avance;


--
-- Name: cargos_docente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargos_docente (
    id_dependencia smallint,
    id_dedicacion smallint,
    id_cargo_unne smallint,
    id_cargo smallint NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date,
    estado character(1) NOT NULL,
    nro_documento character varying(15)
);


ALTER TABLE public.cargos_docente OWNER TO postgres;

--
-- Name: be_cargos_docente_id_cargo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_cargos_docente_id_cargo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_cargos_docente_id_cargo_seq OWNER TO postgres;

--
-- Name: be_cargos_docente_id_cargo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_cargos_docente_id_cargo_seq OWNED BY public.cargos_docente.id_cargo;


--
-- Name: cargos_unne; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargos_unne (
    cargo character varying(50),
    id_cargo_unne smallint NOT NULL
);


ALTER TABLE public.cargos_unne OWNER TO postgres;

--
-- Name: be_cargos_unne_id_cargo_unne_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_cargos_unne_id_cargo_unne_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_cargos_unne_id_cargo_unne_seq OWNER TO postgres;

--
-- Name: be_cargos_unne_id_cargo_unne_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_cargos_unne_id_cargo_unne_seq OWNED BY public.cargos_unne.id_cargo_unne;


--
-- Name: carreras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carreras (
    id_carrera smallint NOT NULL,
    carrera character varying(200),
    cod_araucano smallint
);


ALTER TABLE public.carreras OWNER TO postgres;

--
-- Name: be_carreras_id_carrera_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_carreras_id_carrera_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_carreras_id_carrera_seq OWNER TO postgres;

--
-- Name: be_carreras_id_carrera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_carreras_id_carrera_seq OWNED BY public.carreras.id_carrera;


--
-- Name: dedicacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dedicacion (
    dedicacion character varying(50),
    id_dedicacion smallint NOT NULL
);


ALTER TABLE public.dedicacion OWNER TO postgres;

--
-- Name: be_dedicacion_id_dedicacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_dedicacion_id_dedicacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_dedicacion_id_dedicacion_seq OWNER TO postgres;

--
-- Name: be_dedicacion_id_dedicacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_dedicacion_id_dedicacion_seq OWNED BY public.dedicacion.id_dedicacion;


--
-- Name: dependencias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dependencias (
    id_dependencia smallint NOT NULL,
    nombre character varying(150),
    descripcion_corta character varying(30),
    id_universidad smallint,
    id_localidad smallint,
    domicilio character varying(350),
    telefono character varying(75)
);


ALTER TABLE public.dependencias OWNER TO postgres;

--
-- Name: be_dependencias_id_dependencia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_dependencias_id_dependencia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_dependencias_id_dependencia_seq OWNER TO postgres;

--
-- Name: be_dependencias_id_dependencia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_dependencias_id_dependencia_seq OWNED BY public.dependencias.id_dependencia;


--
-- Name: localidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.localidades (
    id_provincia smallint NOT NULL,
    id_localidad smallint NOT NULL,
    localidad character varying(100),
    codigo_postal character varying(10)
);


ALTER TABLE public.localidades OWNER TO postgres;

--
-- Name: be_localidades_id_localidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_localidades_id_localidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_localidades_id_localidad_seq OWNER TO postgres;

--
-- Name: be_localidades_id_localidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_localidades_id_localidad_seq OWNED BY public.localidades.id_localidad;


--
-- Name: paises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paises (
    id_pais smallint NOT NULL,
    pais character varying(100)
);


ALTER TABLE public.paises OWNER TO postgres;

--
-- Name: be_paises_id_pais_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_paises_id_pais_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_paises_id_pais_seq OWNER TO postgres;

--
-- Name: be_paises_id_pais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_paises_id_pais_seq OWNED BY public.paises.id_pais;


--
-- Name: provincias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provincias (
    id_pais smallint NOT NULL,
    id_provincia smallint NOT NULL,
    provincia character varying(100)
);


ALTER TABLE public.provincias OWNER TO postgres;

--
-- Name: be_provincias_id_provincia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_provincias_id_provincia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_provincias_id_provincia_seq OWNER TO postgres;

--
-- Name: be_provincias_id_provincia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_provincias_id_provincia_seq OWNED BY public.provincias.id_provincia;


--
-- Name: resultado_avance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resultado_avance (
    id_resultado smallint NOT NULL,
    resultado character(50),
    activo boolean
);


ALTER TABLE public.resultado_avance OWNER TO postgres;

--
-- Name: be_resultado_avance_id_resultado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_resultado_avance_id_resultado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_resultado_avance_id_resultado_seq OWNER TO postgres;

--
-- Name: be_resultado_avance_id_resultado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_resultado_avance_id_resultado_seq OWNED BY public.resultado_avance.id_resultado;


--
-- Name: tipo_documento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_documento (
    id_tipo_doc smallint NOT NULL,
    tipo_doc character varying(50)
);


ALTER TABLE public.tipo_documento OWNER TO postgres;

--
-- Name: be_tipo_documento_id_tipo_doc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_tipo_documento_id_tipo_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_tipo_documento_id_tipo_doc_seq OWNER TO postgres;

--
-- Name: be_tipo_documento_id_tipo_doc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_tipo_documento_id_tipo_doc_seq OWNED BY public.tipo_documento.id_tipo_doc;


--
-- Name: tipos_resolucion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_resolucion (
    id_tipo_resol smallint NOT NULL,
    tipo_resol character varying(100) NOT NULL,
    tipo_resol_corto character varying(25) NOT NULL
);


ALTER TABLE public.tipos_resolucion OWNER TO postgres;

--
-- Name: be_tipos_resolucion_id_tipo_resol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_tipos_resolucion_id_tipo_resol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_tipos_resolucion_id_tipo_resol_seq OWNER TO postgres;

--
-- Name: be_tipos_resolucion_id_tipo_resol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_tipos_resolucion_id_tipo_resol_seq OWNED BY public.tipos_resolucion.id_tipo_resol;


--
-- Name: universidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.universidades (
    id_universidad smallint NOT NULL,
    universidad character varying(200),
    id_pais smallint,
    sigla character varying(50)
);


ALTER TABLE public.universidades OWNER TO postgres;

--
-- Name: be_universidades_id_universidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_universidades_id_universidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_universidades_id_universidad_seq OWNER TO postgres;

--
-- Name: be_universidades_id_universidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_universidades_id_universidad_seq OWNED BY public.universidades.id_universidad;


--
-- Name: becas_otorgadas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.becas_otorgadas (
    nro_resol smallint,
    anio smallint,
    nro_documento character varying(15) NOT NULL,
    id_convocatoria smallint NOT NULL,
    fecha_desde date,
    fecha_hasta date,
    fecha_toma_posesion date,
    id_tipo_resol smallint,
    id_tipo_beca smallint NOT NULL
);


ALTER TABLE public.becas_otorgadas OWNER TO postgres;

--
-- Name: carrera_dependencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carrera_dependencia (
    id_dependencia smallint NOT NULL,
    id_carrera smallint NOT NULL
);


ALTER TABLE public.carrera_dependencia OWNER TO postgres;

--
-- Name: cat_incentivos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cat_incentivos (
    id_cat_incentivos integer NOT NULL,
    cat_incentivos character(5) NOT NULL,
    descripcion character varying(30) NOT NULL
);


ALTER TABLE public.cat_incentivos OWNER TO postgres;

--
-- Name: cat_incentivos_id_cat_incentivos_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cat_incentivos_id_cat_incentivos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cat_incentivos_id_cat_incentivos_seq OWNER TO postgres;

--
-- Name: cat_incentivos_id_cat_incentivos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cat_incentivos_id_cat_incentivos_seq OWNED BY public.cat_incentivos.id_cat_incentivos;


--
-- Name: cat_incentivos_personas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cat_incentivos_personas (
    id integer NOT NULL,
    convocatoria numeric(4,0),
    nro_documento character varying(15),
    id_cat_incentivos integer
);


ALTER TABLE public.cat_incentivos_personas OWNER TO postgres;

--
-- Name: cat_incentivos_personas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cat_incentivos_personas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cat_incentivos_personas_id_seq OWNER TO postgres;

--
-- Name: cat_incentivos_personas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cat_incentivos_personas_id_seq OWNED BY public.cat_incentivos_personas.id;


--
-- Name: categorias_conicet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias_conicet (
    id_cat_conicet smallint NOT NULL,
    nro_categoria smallint,
    categoria character varying(50)
);


ALTER TABLE public.categorias_conicet OWNER TO postgres;

--
-- Name: categorias_conicet_id_cat_conicet_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_conicet_id_cat_conicet_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorias_conicet_id_cat_conicet_seq OWNER TO postgres;

--
-- Name: categorias_conicet_id_cat_conicet_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_conicet_id_cat_conicet_seq OWNED BY public.categorias_conicet.id_cat_conicet;


--
-- Name: color_carpeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.color_carpeta (
    id_color smallint NOT NULL,
    color character varying(75) NOT NULL
);


ALTER TABLE public.color_carpeta OWNER TO postgres;

--
-- Name: color_carpeta_id_color_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.color_carpeta_id_color_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.color_carpeta_id_color_seq OWNER TO postgres;

--
-- Name: color_carpeta_id_color_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.color_carpeta_id_color_seq OWNED BY public.color_carpeta.id_color;


--
-- Name: comision_asesora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comision_asesora (
    id_area_conocimiento smallint NOT NULL,
    id_convocatoria smallint NOT NULL
);


ALTER TABLE public.comision_asesora OWNER TO postgres;

--
-- Name: convocatoria_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.convocatoria_beca (
    fecha_desde date,
    fecha_hasta date,
    limite_movimientos date NOT NULL,
    id_convocatoria smallint NOT NULL,
    convocatoria character varying(300),
    id_tipo_convocatoria smallint,
    CONSTRAINT ck_convocatoria_beca_fechas CHECK ((fecha_desde <= fecha_hasta))
);


ALTER TABLE public.convocatoria_beca OWNER TO postgres;

--
-- Name: convocatoria_beca_id_convocatoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.convocatoria_beca_id_convocatoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.convocatoria_beca_id_convocatoria_seq OWNER TO postgres;

--
-- Name: convocatoria_beca_id_convocatoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.convocatoria_beca_id_convocatoria_seq OWNED BY public.convocatoria_beca.id_convocatoria;


--
-- Name: cumplimiento_obligacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cumplimiento_obligacion (
    nro_documento character varying(15) NOT NULL,
    mes numeric(2,0) NOT NULL,
    anio numeric(4,0) NOT NULL,
    fecha_cumplimiento date,
    id_convocatoria smallint NOT NULL,
    id_tipo_beca smallint NOT NULL
);


ALTER TABLE public.cumplimiento_obligacion OWNER TO postgres;

--
-- Name: disciplinas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disciplinas (
    id_disciplina integer NOT NULL,
    disciplina character varying(50) NOT NULL
);


ALTER TABLE public.disciplinas OWNER TO postgres;

--
-- Name: disciplinas_id_disciplina_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.disciplinas_id_disciplina_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disciplinas_id_disciplina_seq OWNER TO postgres;

--
-- Name: disciplinas_id_disciplina_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.disciplinas_id_disciplina_seq OWNED BY public.disciplinas.id_disciplina;


--
-- Name: docentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.docentes (
    nro_documento character varying(15) NOT NULL,
    legajo character varying(20) NOT NULL,
    id_cat_conicet smallint,
    id_dependencia_conicet smallint
);


ALTER TABLE public.docentes OWNER TO postgres;

--
-- Name: inscripcion_conv_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inscripcion_conv_beca (
    id_dependencia smallint,
    nro_documento character varying(15) NOT NULL,
    id_convocatoria smallint NOT NULL,
    fecha_hora timestamp without time zone,
    admisible character(1),
    puntaje numeric(6,3),
    beca_otorgada character varying(1),
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
    nro_carpeta character varying(20),
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
    nro_documento_dir character varying(15),
    nro_documento_codir character varying(15),
    nro_documento_subdir character varying(15),
    archivo_analitico character varying(300)
);


ALTER TABLE public.inscripcion_conv_beca OWNER TO postgres;

--
-- Name: COLUMN inscripcion_conv_beca.estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.inscripcion_conv_beca.estado IS 'Este campo trabaja en combinación con el campo "limite_movimientos" de la tabla "convocatoria_categoria". Cuando el estado de la inscripcion es Pendiente ("P"), y suponiendo que la fecha fin de inscripción ya pasó, el becario podrá seguir modificando su inscripción hasta dicha fecha. 
Está pensado para casos en los que el becario tiene problemas en su inscripción y necesita mas tiempo que el establecido en el periodo predefinido.';


--
-- Name: integrante_comision_asesora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.integrante_comision_asesora (
    nro_documento character varying(15) NOT NULL,
    id_convocatoria smallint NOT NULL,
    id_area_conocimiento smallint NOT NULL
);


ALTER TABLE public.integrante_comision_asesora OWNER TO postgres;

--
-- Name: motivos_baja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motivos_baja (
    id_motivo_baja smallint NOT NULL,
    motivo_baja character varying(75)
);


ALTER TABLE public.motivos_baja OWNER TO postgres;

--
-- Name: motivos_baja_id_motivo_baja_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.motivos_baja_id_motivo_baja_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.motivos_baja_id_motivo_baja_seq OWNER TO postgres;

--
-- Name: motivos_baja_id_motivo_baja_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.motivos_baja_id_motivo_baja_seq OWNED BY public.motivos_baja.id_motivo_baja;


--
-- Name: niveles_academicos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.niveles_academicos (
    nivel_academico character varying(50) NOT NULL,
    orden numeric(2,0) NOT NULL,
    id_nivel_academico smallint NOT NULL
);


ALTER TABLE public.niveles_academicos OWNER TO postgres;

--
-- Name: niveles_academicos_id_nivel_academico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.niveles_academicos_id_nivel_academico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.niveles_academicos_id_nivel_academico_seq OWNER TO postgres;

--
-- Name: niveles_academicos_id_nivel_academico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.niveles_academicos_id_nivel_academico_seq OWNED BY public.niveles_academicos.id_nivel_academico;


--
-- Name: personas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personas (
    nro_documento character varying(15) NOT NULL,
    id_tipo_doc smallint NOT NULL,
    apellido character varying(100),
    nombres character varying(100),
    cuil character varying(15),
    fecha_nac date,
    celular character varying(25),
    mail character varying(100),
    telefono character varying(40),
    id_localidad smallint,
    id_nivel_academico smallint,
    sexo character(1),
    archivo_titulo_grado character varying(300),
    archivo_cuil character varying(300),
    id_disciplina smallint
);


ALTER TABLE public.personas OWNER TO postgres;

--
-- Name: planes_trabajo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planes_trabajo (
    nro_documento character varying(15) NOT NULL,
    id_convocatoria smallint NOT NULL,
    id_tipo_beca smallint NOT NULL,
    plan_trabajo text,
    doc_probatoria character varying(300)
);


ALTER TABLE public.planes_trabajo OWNER TO postgres;

--
-- Name: proyectos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proyectos (
    proyecto character varying(300),
    codigo character varying(30),
    id_proyecto smallint NOT NULL
);


ALTER TABLE public.proyectos OWNER TO postgres;

--
-- Name: requisitos_convocatoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requisitos_convocatoria (
    id_convocatoria smallint NOT NULL,
    requisito character varying(100),
    obligatorio character(1),
    id_requisito smallint NOT NULL,
    id_tipo_beca smallint
);


ALTER TABLE public.requisitos_convocatoria OWNER TO postgres;

--
-- Name: requisitos_convocatoria_id_requisito_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.requisitos_convocatoria_id_requisito_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.requisitos_convocatoria_id_requisito_seq OWNER TO postgres;

--
-- Name: requisitos_convocatoria_id_requisito_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.requisitos_convocatoria_id_requisito_seq OWNED BY public.requisitos_convocatoria.id_requisito;


--
-- Name: requisitos_insc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requisitos_insc (
    nro_documento character varying(15) NOT NULL,
    id_convocatoria smallint NOT NULL,
    id_tipo_beca smallint NOT NULL,
    id_requisito smallint NOT NULL,
    cumplido character(1) DEFAULT 'N'::bpchar NOT NULL,
    fecha date,
    doc_probatoria character varying(300)
);


ALTER TABLE public.requisitos_insc OWNER TO postgres;

--
-- Name: resoluciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resoluciones (
    nro_resol smallint NOT NULL,
    anio smallint NOT NULL,
    fecha date,
    archivo_pdf character varying(100),
    id_tipo_resol smallint NOT NULL
);


ALTER TABLE public.resoluciones OWNER TO postgres;

--
-- Name: tipos_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_beca (
    id_tipo_beca smallint NOT NULL,
    id_tipo_convocatoria smallint,
    tipo_beca character varying(150),
    duracion_meses numeric(3,0),
    meses_present_avance numeric(3,0),
    cupo_maximo numeric(5,0),
    id_color smallint,
    estado character(1) DEFAULT 'A'::bpchar,
    factor numeric(3,2),
    edad_limite numeric(2,0),
    prefijo_carpeta character varying(10)
);


ALTER TABLE public.tipos_beca OWNER TO postgres;

--
-- Name: tipos_beca_id_tipo_beca_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipos_beca_id_tipo_beca_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_beca_id_tipo_beca_seq OWNER TO postgres;

--
-- Name: tipos_beca_id_tipo_beca_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipos_beca_id_tipo_beca_seq OWNED BY public.tipos_beca.id_tipo_beca;


--
-- Name: tipos_convocatoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_convocatoria (
    id_tipo_convocatoria smallint NOT NULL,
    tipo_convocatoria character varying(150)
);


ALTER TABLE public.tipos_convocatoria OWNER TO postgres;

--
-- Name: tipos_convocatoria_id_tipo_convocatoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipos_convocatoria_id_tipo_convocatoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_convocatoria_id_tipo_convocatoria_seq OWNER TO postgres;

--
-- Name: tipos_convocatoria_id_tipo_convocatoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipos_convocatoria_id_tipo_convocatoria_seq OWNED BY public.tipos_convocatoria.id_tipo_convocatoria;


--
-- Name: id_antecedente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_activ_docentes ALTER COLUMN id_antecedente SET DEFAULT nextval('public.antec_activ_docentes_id_antecedente_seq'::regclass);


--
-- Name: id_beca_obtenida; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_becas_obtenidas ALTER COLUMN id_beca_obtenida SET DEFAULT nextval('public.antec_becas_obtenidas_id_beca_obtenida_seq'::regclass);


--
-- Name: id_conocimiento_idioma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_conoc_idiomas ALTER COLUMN id_conocimiento_idioma SET DEFAULT nextval('public.antec_conoc_idiomas_id_conocimiento_idioma_seq'::regclass);


--
-- Name: id_curso_perfec_aprob; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_cursos_perfec_aprob ALTER COLUMN id_curso_perfec_aprob SET DEFAULT nextval('public.antec_cursos_perfec_aprob_id_curso_perfec_aprob_seq'::regclass);


--
-- Name: id_estudio_afin; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_estudios_afines ALTER COLUMN id_estudio_afin SET DEFAULT nextval('public.antec_estudios_afines_id_estudio_afin_seq'::regclass);


--
-- Name: id_otra_actividad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_otras_actividades ALTER COLUMN id_otra_actividad SET DEFAULT nextval('public.antec_otras_actividades_id_otra_actividad_seq'::regclass);


--
-- Name: id_particip_cursos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_particip_dict_cursos ALTER COLUMN id_particip_cursos SET DEFAULT nextval('public.antec_particip_cursos_id_particip_cursos_seq'::regclass);


--
-- Name: id_present_reunion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_present_reuniones ALTER COLUMN id_present_reunion SET DEFAULT nextval('public.antec_present_reuniones_id_present_reunion_seq'::regclass);


--
-- Name: id_trabajo_publicado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_trabajos_publicados ALTER COLUMN id_trabajo_publicado SET DEFAULT nextval('public.antec_trabajos_publicados_id_trabajo_publicado_seq'::regclass);


--
-- Name: id_area_conocimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_conocimiento ALTER COLUMN id_area_conocimiento SET DEFAULT nextval('public.be_area_conocimiento_id_area_conocimiento_seq'::regclass);


--
-- Name: id_area; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas_dependencia ALTER COLUMN id_area SET DEFAULT nextval('public.be_areas_dependencia_id_area_seq'::regclass);


--
-- Name: id_avance; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avance_beca ALTER COLUMN id_avance SET DEFAULT nextval('public.be_avance_beca_id_avance_seq'::regclass);


--
-- Name: id_cargo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos_docente ALTER COLUMN id_cargo SET DEFAULT nextval('public.be_cargos_docente_id_cargo_seq'::regclass);


--
-- Name: id_cargo_unne; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos_unne ALTER COLUMN id_cargo_unne SET DEFAULT nextval('public.be_cargos_unne_id_cargo_unne_seq'::regclass);


--
-- Name: id_carrera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carreras ALTER COLUMN id_carrera SET DEFAULT nextval('public.be_carreras_id_carrera_seq'::regclass);


--
-- Name: id_cat_incentivos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_incentivos ALTER COLUMN id_cat_incentivos SET DEFAULT nextval('public.cat_incentivos_id_cat_incentivos_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_incentivos_personas ALTER COLUMN id SET DEFAULT nextval('public.cat_incentivos_personas_id_seq'::regclass);


--
-- Name: id_cat_conicet; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias_conicet ALTER COLUMN id_cat_conicet SET DEFAULT nextval('public.categorias_conicet_id_cat_conicet_seq'::regclass);


--
-- Name: id_color; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.color_carpeta ALTER COLUMN id_color SET DEFAULT nextval('public.color_carpeta_id_color_seq'::regclass);


--
-- Name: id_convocatoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatoria_beca ALTER COLUMN id_convocatoria SET DEFAULT nextval('public.convocatoria_beca_id_convocatoria_seq'::regclass);


--
-- Name: id_dedicacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dedicacion ALTER COLUMN id_dedicacion SET DEFAULT nextval('public.be_dedicacion_id_dedicacion_seq'::regclass);


--
-- Name: id_dependencia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dependencias ALTER COLUMN id_dependencia SET DEFAULT nextval('public.be_dependencias_id_dependencia_seq'::regclass);


--
-- Name: id_disciplina; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas ALTER COLUMN id_disciplina SET DEFAULT nextval('public.disciplinas_id_disciplina_seq'::regclass);


--
-- Name: id_localidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.localidades ALTER COLUMN id_localidad SET DEFAULT nextval('public.be_localidades_id_localidad_seq'::regclass);


--
-- Name: id_nivel_academico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveles_academicos ALTER COLUMN id_nivel_academico SET DEFAULT nextval('public.niveles_academicos_id_nivel_academico_seq'::regclass);


--
-- Name: id_provincia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincias ALTER COLUMN id_provincia SET DEFAULT nextval('public.be_provincias_id_provincia_seq'::regclass);


--
-- Name: id_requisito; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requisitos_convocatoria ALTER COLUMN id_requisito SET DEFAULT nextval('public.requisitos_convocatoria_id_requisito_seq'::regclass);


--
-- Name: id_resultado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultado_avance ALTER COLUMN id_resultado SET DEFAULT nextval('public.be_resultado_avance_id_resultado_seq'::regclass);


--
-- Name: id_tipo_doc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_documento ALTER COLUMN id_tipo_doc SET DEFAULT nextval('public.be_tipo_documento_id_tipo_doc_seq'::regclass);


--
-- Name: id_tipo_beca; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_beca ALTER COLUMN id_tipo_beca SET DEFAULT nextval('public.tipos_beca_id_tipo_beca_seq'::regclass);


--
-- Name: id_tipo_convocatoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_convocatoria ALTER COLUMN id_tipo_convocatoria SET DEFAULT nextval('public.tipos_convocatoria_id_tipo_convocatoria_seq'::regclass);


--
-- Name: id_tipo_resol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_resolucion ALTER COLUMN id_tipo_resol SET DEFAULT nextval('public.be_tipos_resolucion_id_tipo_resol_seq'::regclass);


--
-- Name: id_universidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universidades ALTER COLUMN id_universidad SET DEFAULT nextval('public.be_universidades_id_universidad_seq'::regclass);


--
-- Name: pk_antec_activ_docentes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_activ_docentes
    ADD CONSTRAINT pk_antec_activ_docentes PRIMARY KEY (id_antecedente);


--
-- Name: pk_antec_becas_obtenidas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_becas_obtenidas
    ADD CONSTRAINT pk_antec_becas_obtenidas PRIMARY KEY (id_beca_obtenida);


--
-- Name: pk_antec_conoc_idiomas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_conoc_idiomas
    ADD CONSTRAINT pk_antec_conoc_idiomas PRIMARY KEY (id_conocimiento_idioma);


--
-- Name: pk_antec_cursos_perfec_aprob; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_cursos_perfec_aprob
    ADD CONSTRAINT pk_antec_cursos_perfec_aprob PRIMARY KEY (id_curso_perfec_aprob);


--
-- Name: pk_antec_estudios_afines; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_estudios_afines
    ADD CONSTRAINT pk_antec_estudios_afines PRIMARY KEY (id_estudio_afin);


--
-- Name: pk_antec_otras_actividades; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_otras_actividades
    ADD CONSTRAINT pk_antec_otras_actividades PRIMARY KEY (id_otra_actividad);


--
-- Name: pk_antec_particip_cursos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_particip_dict_cursos
    ADD CONSTRAINT pk_antec_particip_cursos PRIMARY KEY (id_particip_cursos);


--
-- Name: pk_antec_present_reuniones; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_present_reuniones
    ADD CONSTRAINT pk_antec_present_reuniones PRIMARY KEY (id_present_reunion);


--
-- Name: pk_antec_trabajos_publicados; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_trabajos_publicados
    ADD CONSTRAINT pk_antec_trabajos_publicados PRIMARY KEY (id_trabajo_publicado);


--
-- Name: pk_area_conocimiento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_conocimiento
    ADD CONSTRAINT pk_area_conocimiento PRIMARY KEY (id_area_conocimiento);


--
-- Name: pk_areas_dependencia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas_dependencia
    ADD CONSTRAINT pk_areas_dependencia PRIMARY KEY (id_area);


--
-- Name: pk_avance_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avance_beca
    ADD CONSTRAINT pk_avance_beca PRIMARY KEY (id_avance);


--
-- Name: pk_baja_becas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.baja_becas
    ADD CONSTRAINT pk_baja_becas PRIMARY KEY (nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: pk_becas_otorgadas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.becas_otorgadas
    ADD CONSTRAINT pk_becas_otorgadas PRIMARY KEY (nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: pk_cargos_docente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos_docente
    ADD CONSTRAINT pk_cargos_docente PRIMARY KEY (id_cargo);


--
-- Name: pk_cargos_unne; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos_unne
    ADD CONSTRAINT pk_cargos_unne PRIMARY KEY (id_cargo_unne);


--
-- Name: pk_carrera_dependencia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrera_dependencia
    ADD CONSTRAINT pk_carrera_dependencia PRIMARY KEY (id_dependencia, id_carrera);


--
-- Name: pk_carreras; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carreras
    ADD CONSTRAINT pk_carreras PRIMARY KEY (id_carrera);


--
-- Name: pk_cat_incentivos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_incentivos
    ADD CONSTRAINT pk_cat_incentivos PRIMARY KEY (id_cat_incentivos);


--
-- Name: pk_cat_incentivos_personas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_incentivos_personas
    ADD CONSTRAINT pk_cat_incentivos_personas PRIMARY KEY (id);


--
-- Name: pk_categorias_conicet; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias_conicet
    ADD CONSTRAINT pk_categorias_conicet PRIMARY KEY (id_cat_conicet);


--
-- Name: pk_color_carpeta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.color_carpeta
    ADD CONSTRAINT pk_color_carpeta PRIMARY KEY (id_color);


--
-- Name: pk_comision_asesora; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comision_asesora
    ADD CONSTRAINT pk_comision_asesora PRIMARY KEY (id_area_conocimiento, id_convocatoria);


--
-- Name: pk_convocatoria_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatoria_beca
    ADD CONSTRAINT pk_convocatoria_beca PRIMARY KEY (id_convocatoria);


--
-- Name: pk_cumplimiento_obligacion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cumplimiento_obligacion
    ADD CONSTRAINT pk_cumplimiento_obligacion PRIMARY KEY (nro_documento, id_convocatoria, id_tipo_beca, mes, anio);


--
-- Name: pk_dedicacion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dedicacion
    ADD CONSTRAINT pk_dedicacion PRIMARY KEY (id_dedicacion);


--
-- Name: pk_dependencias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dependencias
    ADD CONSTRAINT pk_dependencias PRIMARY KEY (id_dependencia);


--
-- Name: pk_discriplinas-id_disciplina; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas
    ADD CONSTRAINT "pk_discriplinas-id_disciplina" PRIMARY KEY (id_disciplina);


--
-- Name: pk_docentes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docentes
    ADD CONSTRAINT pk_docentes PRIMARY KEY (nro_documento);


--
-- Name: pk_inscripcion_conv_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion_conv_beca
    ADD CONSTRAINT pk_inscripcion_conv_beca PRIMARY KEY (nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: pk_integrante_comision_asesora; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrante_comision_asesora
    ADD CONSTRAINT pk_integrante_comision_asesora PRIMARY KEY (nro_documento, id_convocatoria, id_area_conocimiento);


--
-- Name: pk_localidades; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.localidades
    ADD CONSTRAINT pk_localidades PRIMARY KEY (id_localidad);


--
-- Name: pk_motivos_baja; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motivos_baja
    ADD CONSTRAINT pk_motivos_baja PRIMARY KEY (id_motivo_baja);


--
-- Name: pk_niveles_academicos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveles_academicos
    ADD CONSTRAINT pk_niveles_academicos PRIMARY KEY (id_nivel_academico);


--
-- Name: pk_paises; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paises
    ADD CONSTRAINT pk_paises PRIMARY KEY (id_pais);


--
-- Name: pk_personas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT pk_personas PRIMARY KEY (nro_documento);


--
-- Name: pk_planes_trabajo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes_trabajo
    ADD CONSTRAINT pk_planes_trabajo PRIMARY KEY (nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: pk_provincias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincias
    ADD CONSTRAINT pk_provincias PRIMARY KEY (id_provincia);


--
-- Name: pk_proyectos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT pk_proyectos PRIMARY KEY (id_proyecto);


--
-- Name: pk_requisitos_convocatoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requisitos_convocatoria
    ADD CONSTRAINT pk_requisitos_convocatoria PRIMARY KEY (id_requisito);


--
-- Name: pk_requisitos_insc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requisitos_insc
    ADD CONSTRAINT pk_requisitos_insc PRIMARY KEY (nro_documento, id_convocatoria, id_tipo_beca, id_requisito);


--
-- Name: pk_resoluciones; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resoluciones
    ADD CONSTRAINT pk_resoluciones PRIMARY KEY (nro_resol, anio, id_tipo_resol);


--
-- Name: pk_resultado_avance; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultado_avance
    ADD CONSTRAINT pk_resultado_avance PRIMARY KEY (id_resultado);


--
-- Name: pk_tipo_documento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_documento
    ADD CONSTRAINT pk_tipo_documento PRIMARY KEY (id_tipo_doc);


--
-- Name: pk_tipos_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_beca
    ADD CONSTRAINT pk_tipos_beca PRIMARY KEY (id_tipo_beca);


--
-- Name: pk_tipos_convocatoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_convocatoria
    ADD CONSTRAINT pk_tipos_convocatoria PRIMARY KEY (id_tipo_convocatoria);


--
-- Name: pk_tipos_resolucion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_resolucion
    ADD CONSTRAINT pk_tipos_resolucion PRIMARY KEY (id_tipo_resol);


--
-- Name: pk_universidades; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universidades
    ADD CONSTRAINT pk_universidades PRIMARY KEY (id_universidad);


--
-- Name: uk_provincia_pais; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincias
    ADD CONSTRAINT uk_provincia_pais UNIQUE (id_pais, provincia);


--
-- Name: uq_carreras_carrera; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carreras
    ADD CONSTRAINT uq_carreras_carrera UNIQUE (carrera);


--
-- Name: uq_cat_incentivos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_incentivos
    ADD CONSTRAINT uq_cat_incentivos UNIQUE (cat_incentivos);


--
-- Name: uq_cat_incentivos-descripcion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_incentivos
    ADD CONSTRAINT "uq_cat_incentivos-descripcion" UNIQUE (descripcion);


--
-- Name: uq_convocatoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatoria_beca
    ADD CONSTRAINT uq_convocatoria UNIQUE (convocatoria);


--
-- Name: uq_dependencias_dependencia-universidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dependencias
    ADD CONSTRAINT "uq_dependencias_dependencia-universidad" UNIQUE (nombre, id_universidad);


--
-- Name: uq_inscripcion_conv_beca_nro-carpeta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion_conv_beca
    ADD CONSTRAINT "uq_inscripcion_conv_beca_nro-carpeta" UNIQUE (nro_carpeta, id_convocatoria);


--
-- Name: uq_nivel_academico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveles_academicos
    ADD CONSTRAINT uq_nivel_academico UNIQUE (nivel_academico);


--
-- Name: uq_proyectos_proyecto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT uq_proyectos_proyecto UNIQUE (proyecto);


--
-- Name: uq_tipos_beca_prefijo-carpeta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_beca
    ADD CONSTRAINT "uq_tipos_beca_prefijo-carpeta" UNIQUE (prefijo_carpeta);


--
-- Name: uq_universidades_universidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universidades
    ADD CONSTRAINT uq_universidades_universidad UNIQUE (universidad, id_pais);


--
-- Name: fk_abance_beca-id_tipo_beca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avance_beca
    ADD CONSTRAINT "fk_abance_beca-id_tipo_beca" FOREIGN KEY (id_convocatoria, id_tipo_beca, nro_documento) REFERENCES public.becas_otorgadas(id_convocatoria, id_tipo_beca, nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_activ_docentes_nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_activ_docentes
    ADD CONSTRAINT fk_antec_activ_docentes_nro_documento FOREIGN KEY (nro_documento) REFERENCES public.personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_becas_obtenidas_nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_becas_obtenidas
    ADD CONSTRAINT fk_antec_becas_obtenidas_nro_documento FOREIGN KEY (nro_documento) REFERENCES public.personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_conoc_idiomas_nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_conoc_idiomas
    ADD CONSTRAINT fk_antec_conoc_idiomas_nro_documento FOREIGN KEY (nro_documento) REFERENCES public.personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_cursos_perfec_aprob_nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_cursos_perfec_aprob
    ADD CONSTRAINT fk_antec_cursos_perfec_aprob_nro_documento FOREIGN KEY (nro_documento) REFERENCES public.personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_estudios_afines_nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_estudios_afines
    ADD CONSTRAINT fk_antec_estudios_afines_nro_documento FOREIGN KEY (nro_documento) REFERENCES public.personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_otras_actividades_nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_otras_actividades
    ADD CONSTRAINT fk_antec_otras_actividades_nro_documento FOREIGN KEY (nro_documento) REFERENCES public.personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_particip_dict_cursos_nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_particip_dict_cursos
    ADD CONSTRAINT fk_antec_particip_dict_cursos_nro_documento FOREIGN KEY (nro_documento) REFERENCES public.personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_present_reuniones_nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_present_reuniones
    ADD CONSTRAINT fk_antec_present_reuniones_nro_documento FOREIGN KEY (nro_documento) REFERENCES public.personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_trabajos_publicados_nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antec_trabajos_publicados
    ADD CONSTRAINT fk_antec_trabajos_publicados_nro_documento FOREIGN KEY (nro_documento) REFERENCES public.personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_areas_dependencia_dependencia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas_dependencia
    ADD CONSTRAINT fk_areas_dependencia_dependencia FOREIGN KEY (id_dependencia) REFERENCES public.dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_avance_beca_resultado_avance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avance_beca
    ADD CONSTRAINT fk_avance_beca_resultado_avance FOREIGN KEY (id_resultado) REFERENCES public.resultado_avance(id_resultado) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_baja_becas-becas_otorgadas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.baja_becas
    ADD CONSTRAINT "fk_baja_becas-becas_otorgadas" FOREIGN KEY (nro_documento, id_convocatoria, id_tipo_beca) REFERENCES public.inscripcion_conv_beca(nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_baja_becas_motivo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.baja_becas
    ADD CONSTRAINT fk_baja_becas_motivo FOREIGN KEY (id_motivo_baja) REFERENCES public.motivos_baja(id_motivo_baja) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_becas_otorgadas-insc_conv_beca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.becas_otorgadas
    ADD CONSTRAINT "fk_becas_otorgadas-insc_conv_beca" FOREIGN KEY (nro_documento, id_convocatoria, id_tipo_beca) REFERENCES public.inscripcion_conv_beca(nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_becas_otorgadas_resol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.becas_otorgadas
    ADD CONSTRAINT fk_becas_otorgadas_resol FOREIGN KEY (id_tipo_resol, nro_resol, anio) REFERENCES public.resoluciones(id_tipo_resol, nro_resol, anio);


--
-- Name: fk_cargos_doc_dedicacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos_docente
    ADD CONSTRAINT fk_cargos_doc_dedicacion FOREIGN KEY (id_dedicacion) REFERENCES public.dedicacion(id_dedicacion) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_cargos_docente_cargo_unne; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos_docente
    ADD CONSTRAINT fk_cargos_docente_cargo_unne FOREIGN KEY (id_cargo_unne) REFERENCES public.cargos_unne(id_cargo_unne) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_cargos_docente_dependencias; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos_docente
    ADD CONSTRAINT fk_cargos_docente_dependencias FOREIGN KEY (id_dependencia) REFERENCES public.dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_carrera_dependencia_carreras; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrera_dependencia
    ADD CONSTRAINT fk_carrera_dependencia_carreras FOREIGN KEY (id_carrera) REFERENCES public.carreras(id_carrera) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_carrera_dependencia_dependencias; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrera_dependencia
    ADD CONSTRAINT fk_carrera_dependencia_dependencias FOREIGN KEY (id_dependencia) REFERENCES public.dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_cat_incentivos_personas-id_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_incentivos_personas
    ADD CONSTRAINT "fk_cat_incentivos_personas-id_categoria" FOREIGN KEY (id_cat_incentivos) REFERENCES public.cat_incentivos(id_cat_incentivos) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_cat_incentivos_personas-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cat_incentivos_personas
    ADD CONSTRAINT "fk_cat_incentivos_personas-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_comision_asesora_area_conocimiento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comision_asesora
    ADD CONSTRAINT fk_comision_asesora_area_conocimiento FOREIGN KEY (id_area_conocimiento) REFERENCES public.area_conocimiento(id_area_conocimiento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_comision_asesora_convocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comision_asesora
    ADD CONSTRAINT fk_comision_asesora_convocatoria FOREIGN KEY (id_convocatoria) REFERENCES public.convocatoria_beca(id_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_convocatoria_beca_tipoconvocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatoria_beca
    ADD CONSTRAINT fk_convocatoria_beca_tipoconvocatoria FOREIGN KEY (id_tipo_convocatoria) REFERENCES public.tipos_convocatoria(id_tipo_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_cumplimiento_obligacion-becas_otorgadas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cumplimiento_obligacion
    ADD CONSTRAINT "fk_cumplimiento_obligacion-becas_otorgadas" FOREIGN KEY (nro_documento, id_convocatoria, id_tipo_beca) REFERENCES public.inscripcion_conv_beca(nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_dependencias_id-localidad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dependencias
    ADD CONSTRAINT "fk_dependencias_id-localidad" FOREIGN KEY (id_localidad) REFERENCES public.localidades(id_localidad) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_dependencias_universidades; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dependencias
    ADD CONSTRAINT fk_dependencias_universidades FOREIGN KEY (id_universidad) REFERENCES public.universidades(id_universidad) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_docente_cat_conicet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docentes
    ADD CONSTRAINT fk_docente_cat_conicet FOREIGN KEY (id_cat_conicet) REFERENCES public.categorias_conicet(id_cat_conicet) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_docente_dep_conicet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docentes
    ADD CONSTRAINT fk_docente_dep_conicet FOREIGN KEY (id_dependencia_conicet) REFERENCES public.dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_docentes_nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docentes
    ADD CONSTRAINT fk_docentes_nro_documento FOREIGN KEY (nro_documento) REFERENCES public.personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_docentes_nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos_docente
    ADD CONSTRAINT fk_docentes_nro_documento FOREIGN KEY (nro_documento) REFERENCES public.docentes(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_insc_conv_beca-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion_conv_beca
    ADD CONSTRAINT "fk_insc_conv_beca-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_insc_conv_beca-nro_documento_codir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion_conv_beca
    ADD CONSTRAINT "fk_insc_conv_beca-nro_documento_codir" FOREIGN KEY (nro_documento_codir) REFERENCES public.docentes(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_insc_conv_beca-nro_documento_dir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion_conv_beca
    ADD CONSTRAINT "fk_insc_conv_beca-nro_documento_dir" FOREIGN KEY (nro_documento_dir) REFERENCES public.docentes(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_insc_conv_beca-nro_documento_subdir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion_conv_beca
    ADD CONSTRAINT "fk_insc_conv_beca-nro_documento_subdir" FOREIGN KEY (nro_documento_subdir) REFERENCES public.docentes(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_insc_conv_beca_lugartrabajo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion_conv_beca
    ADD CONSTRAINT fk_insc_conv_beca_lugartrabajo FOREIGN KEY (lugar_trabajo_becario) REFERENCES public.dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca_area_conocimiento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_area_conocimiento FOREIGN KEY (id_area_conocimiento) REFERENCES public.area_conocimiento(id_area_conocimiento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_inscripcion_conv_beca_dependencias; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_dependencias FOREIGN KEY (id_dependencia) REFERENCES public.dependencias(id_dependencia) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_inscripcion_conv_beca_idconvocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_idconvocatoria FOREIGN KEY (id_convocatoria) REFERENCES public.convocatoria_beca(id_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca_idtipobeca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_idtipobeca FOREIGN KEY (id_tipo_beca) REFERENCES public.tipos_beca(id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_becas_carrera; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_becas_carrera FOREIGN KEY (id_carrera) REFERENCES public.carreras(id_carrera) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_integrante_comision_asesora-docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrante_comision_asesora
    ADD CONSTRAINT "fk_integrante_comision_asesora-docente" FOREIGN KEY (nro_documento) REFERENCES public.docentes(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_integrante_comision_asesora_comision_asesora; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrante_comision_asesora
    ADD CONSTRAINT fk_integrante_comision_asesora_comision_asesora FOREIGN KEY (id_convocatoria, id_area_conocimiento) REFERENCES public.comision_asesora(id_convocatoria, id_area_conocimiento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_localidades_id-provincia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.localidades
    ADD CONSTRAINT "fk_localidades_id-provincia" FOREIGN KEY (id_provincia) REFERENCES public.provincias(id_provincia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_personas-id_disciplina; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT "fk_personas-id_disciplina" FOREIGN KEY (id_disciplina) REFERENCES public.disciplinas(id_disciplina) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_personas_id_localidad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT fk_personas_id_localidad FOREIGN KEY (id_localidad) REFERENCES public.localidades(id_localidad) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_personas_nivel_academico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT fk_personas_nivel_academico FOREIGN KEY (id_nivel_academico) REFERENCES public.niveles_academicos(id_nivel_academico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_personas_tipo_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT fk_personas_tipo_documento FOREIGN KEY (id_tipo_doc) REFERENCES public.tipo_documento(id_tipo_doc) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_planes_trabajo-insc_conv_beca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes_trabajo
    ADD CONSTRAINT "fk_planes_trabajo-insc_conv_beca" FOREIGN KEY (nro_documento, id_convocatoria, id_tipo_beca) REFERENCES public.inscripcion_conv_beca(nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_provincias_paises; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincias
    ADD CONSTRAINT fk_provincias_paises FOREIGN KEY (id_pais) REFERENCES public.paises(id_pais) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_requisitos_convocatoria-id_tipo_beca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requisitos_convocatoria
    ADD CONSTRAINT "fk_requisitos_convocatoria-id_tipo_beca" FOREIGN KEY (id_tipo_beca) REFERENCES public.tipos_beca(id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_requisitos_convocatoria_id_convocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requisitos_convocatoria
    ADD CONSTRAINT fk_requisitos_convocatoria_id_convocatoria FOREIGN KEY (id_convocatoria) REFERENCES public.convocatoria_beca(id_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_requisitos_insc-insc_conv_beca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requisitos_insc
    ADD CONSTRAINT "fk_requisitos_insc-insc_conv_beca" FOREIGN KEY (nro_documento, id_convocatoria, id_tipo_beca) REFERENCES public.inscripcion_conv_beca(nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_requisitos_insc_idrequisito; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requisitos_insc
    ADD CONSTRAINT fk_requisitos_insc_idrequisito FOREIGN KEY (id_requisito) REFERENCES public.requisitos_convocatoria(id_requisito) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_resoluciones_id_tipo_resol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resoluciones
    ADD CONSTRAINT fk_resoluciones_id_tipo_resol FOREIGN KEY (id_tipo_resol) REFERENCES public.tipos_resolucion(id_tipo_resol) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_tipos_beca_idcolor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_beca
    ADD CONSTRAINT fk_tipos_beca_idcolor FOREIGN KEY (id_color) REFERENCES public.color_carpeta(id_color) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_tipos_beca_tipoconvocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_beca
    ADD CONSTRAINT fk_tipos_beca_tipoconvocatoria FOREIGN KEY (id_tipo_convocatoria) REFERENCES public.tipos_convocatoria(id_tipo_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_universidades_paises; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universidades
    ADD CONSTRAINT fk_universidades_paises FOREIGN KEY (id_pais) REFERENCES public.paises(id_pais) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

