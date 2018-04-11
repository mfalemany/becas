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
-- Name: be_antec_activ_docentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_antec_activ_docentes (
    id_antecedente integer NOT NULL,
    institucion character varying(150) NOT NULL,
    cargo character varying(100) NOT NULL,
    anio_ingreso numeric(4,0) NOT NULL,
    anio_egreso numeric(4,0),
    nro_documento character varying(15) NOT NULL,
    doc_probatoria character varying(300)
);


ALTER TABLE public.be_antec_activ_docentes OWNER TO postgres;

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

ALTER SEQUENCE public.antec_activ_docentes_id_antecedente_seq OWNED BY public.be_antec_activ_docentes.id_antecedente;


--
-- Name: be_antec_becas_obtenidas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_antec_becas_obtenidas (
    id_beca_obtenida integer NOT NULL,
    institucion character varying(100) NOT NULL,
    tipo_beca character varying(50) NOT NULL,
    nro_documento character varying(15) NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date NOT NULL,
    doc_probatoria character varying(300)
);


ALTER TABLE public.be_antec_becas_obtenidas OWNER TO postgres;

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

ALTER SEQUENCE public.antec_becas_obtenidas_id_beca_obtenida_seq OWNED BY public.be_antec_becas_obtenidas.id_beca_obtenida;


--
-- Name: be_antec_conoc_idiomas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_antec_conoc_idiomas (
    id_conocimiento_idioma integer NOT NULL,
    idioma character varying(100) NOT NULL,
    lectura numeric(1,0) NOT NULL,
    escritura numeric(1,0) NOT NULL,
    conversacion numeric(1,0) NOT NULL,
    traduccion numeric(1,0) NOT NULL,
    nro_documento character varying(15),
    doc_probatoria character varying(300)
);


ALTER TABLE public.be_antec_conoc_idiomas OWNER TO postgres;

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

ALTER SEQUENCE public.antec_conoc_idiomas_id_conocimiento_idioma_seq OWNED BY public.be_antec_conoc_idiomas.id_conocimiento_idioma;


--
-- Name: be_antec_cursos_perfec_aprob; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_antec_cursos_perfec_aprob (
    id_curso_perfec_aprob integer NOT NULL,
    institucion character varying(150) NOT NULL,
    tema character varying(300) NOT NULL,
    carga_horaria numeric(4,0),
    fecha date,
    nro_documento character varying(15) NOT NULL,
    doc_probatoria character varying(300)
);


ALTER TABLE public.be_antec_cursos_perfec_aprob OWNER TO postgres;

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

ALTER SEQUENCE public.antec_cursos_perfec_aprob_id_curso_perfec_aprob_seq OWNED BY public.be_antec_cursos_perfec_aprob.id_curso_perfec_aprob;


--
-- Name: be_antec_estudios_afines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_antec_estudios_afines (
    id_estudio_afin integer NOT NULL,
    institucion character varying(100),
    titulo character varying(200) NOT NULL,
    nro_documento character varying(15),
    anio_desde numeric(4,0) NOT NULL,
    anio_hasta numeric(4,0),
    doc_probatoria character varying(300)
);


ALTER TABLE public.be_antec_estudios_afines OWNER TO postgres;

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

ALTER SEQUENCE public.antec_estudios_afines_id_estudio_afin_seq OWNED BY public.be_antec_estudios_afines.id_estudio_afin;


--
-- Name: be_antec_otras_actividades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_antec_otras_actividades (
    id_otra_actividad integer NOT NULL,
    institucion character varying(100) NOT NULL,
    actividad character varying(200) NOT NULL,
    titulo_tema character varying(300) NOT NULL,
    nro_documento character varying(15),
    doc_probatoria character varying(300)
);


ALTER TABLE public.be_antec_otras_actividades OWNER TO postgres;

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

ALTER SEQUENCE public.antec_otras_actividades_id_otra_actividad_seq OWNED BY public.be_antec_otras_actividades.id_otra_actividad;


--
-- Name: be_antec_particip_dict_cursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_antec_particip_dict_cursos (
    id_particip_cursos integer NOT NULL,
    institucion character varying(100) NOT NULL,
    carga_horaria numeric(4,0) NOT NULL,
    fecha date NOT NULL,
    nro_documento character varying(15),
    doc_probatoria character varying(300)
);


ALTER TABLE public.be_antec_particip_dict_cursos OWNER TO postgres;

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

ALTER SEQUENCE public.antec_particip_cursos_id_particip_cursos_seq OWNED BY public.be_antec_particip_dict_cursos.id_particip_cursos;


--
-- Name: be_antec_present_reuniones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_antec_present_reuniones (
    id_present_reunion integer NOT NULL,
    autores character varying(300) NOT NULL,
    titulo_trabajo character varying(200) NOT NULL,
    fecha date NOT NULL,
    nro_documento character varying(15),
    doc_probatoria character varying(300)
);


ALTER TABLE public.be_antec_present_reuniones OWNER TO postgres;

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

ALTER SEQUENCE public.antec_present_reuniones_id_present_reunion_seq OWNED BY public.be_antec_present_reuniones.id_present_reunion;


--
-- Name: be_antec_trabajos_publicados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_antec_trabajos_publicados (
    id_trabajo_publicado integer NOT NULL,
    autores character varying(200) NOT NULL,
    datos_publicacion character varying(750) NOT NULL,
    fecha date NOT NULL,
    nro_documento character varying(15),
    doc_probatoria character varying(300)
);


ALTER TABLE public.be_antec_trabajos_publicados OWNER TO postgres;

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

ALTER SEQUENCE public.antec_trabajos_publicados_id_trabajo_publicado_seq OWNED BY public.be_antec_trabajos_publicados.id_trabajo_publicado;


--
-- Name: be_area_conocimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_area_conocimiento (
    id_area_conocimiento smallint NOT NULL,
    area_conocimiento character varying(75),
    area_conocimiento_corto character varying(5),
    disciplinas_incluidas character varying(400)
);


ALTER TABLE public.be_area_conocimiento OWNER TO postgres;

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

ALTER SEQUENCE public.be_area_conocimiento_id_area_conocimiento_seq OWNED BY public.be_area_conocimiento.id_area_conocimiento;


--
-- Name: be_avance_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_avance_beca (
    id_avance integer NOT NULL,
    fecha date,
    tipo_avance character(1),
    nro_documento character varying(15),
    id_convocatoria smallint,
    id_resultado smallint,
    observaciones character varying(500),
    id_tipo_beca smallint
);


ALTER TABLE public.be_avance_beca OWNER TO postgres;

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

ALTER SEQUENCE public.be_avance_beca_id_avance_seq OWNED BY public.be_avance_beca.id_avance;


--
-- Name: be_baja_becas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_baja_becas (
    nro_documento character varying(15) NOT NULL,
    id_convocatoria smallint NOT NULL,
    fecha_baja date,
    id_motivo_baja smallint,
    observaciones character varying(300),
    id_tipo_beca smallint NOT NULL
);


ALTER TABLE public.be_baja_becas OWNER TO postgres;

--
-- Name: be_becas_otorgadas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_becas_otorgadas (
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


ALTER TABLE public.be_becas_otorgadas OWNER TO postgres;

--
-- Name: be_carrera_dependencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_carrera_dependencia (
    id_dependencia smallint NOT NULL,
    id_carrera smallint NOT NULL
);


ALTER TABLE public.be_carrera_dependencia OWNER TO postgres;

--
-- Name: be_carreras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_carreras (
    id_carrera smallint NOT NULL,
    carrera character varying(200),
    cod_araucano smallint
);


ALTER TABLE public.be_carreras OWNER TO postgres;

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

ALTER SEQUENCE public.be_carreras_id_carrera_seq OWNED BY public.be_carreras.id_carrera;


--
-- Name: be_cat_conicet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_cat_conicet (
    id_cat_conicet integer NOT NULL,
    cat_conicet character varying(75) NOT NULL
);


ALTER TABLE public.be_cat_conicet OWNER TO postgres;

--
-- Name: be_cat_conicet_id_cat_conicet_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.be_cat_conicet_id_cat_conicet_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.be_cat_conicet_id_cat_conicet_seq OWNER TO postgres;

--
-- Name: be_cat_conicet_id_cat_conicet_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.be_cat_conicet_id_cat_conicet_seq OWNED BY public.be_cat_conicet.id_cat_conicet;


--
-- Name: be_color_carpeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_color_carpeta (
    id_color smallint NOT NULL,
    color character varying(75) NOT NULL
);


ALTER TABLE public.be_color_carpeta OWNER TO postgres;

--
-- Name: be_comision_asesora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_comision_asesora (
    id_area_conocimiento smallint NOT NULL,
    id_convocatoria smallint NOT NULL
);


ALTER TABLE public.be_comision_asesora OWNER TO postgres;

--
-- Name: be_convocatoria_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_convocatoria_beca (
    fecha_desde date,
    fecha_hasta date,
    limite_movimientos date NOT NULL,
    id_convocatoria smallint NOT NULL,
    convocatoria character varying(300),
    id_tipo_convocatoria smallint,
    CONSTRAINT ck_convocatoria_beca_fechas CHECK ((fecha_desde <= fecha_hasta))
);


ALTER TABLE public.be_convocatoria_beca OWNER TO postgres;

--
-- Name: be_cumplimiento_obligacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_cumplimiento_obligacion (
    nro_documento character varying(15) NOT NULL,
    mes numeric(2,0) NOT NULL,
    anio numeric(4,0) NOT NULL,
    fecha_cumplimiento date,
    id_convocatoria smallint NOT NULL,
    id_tipo_beca smallint NOT NULL
);


ALTER TABLE public.be_cumplimiento_obligacion OWNER TO postgres;

--
-- Name: be_inscripcion_conv_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_inscripcion_conv_beca (
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


ALTER TABLE public.be_inscripcion_conv_beca OWNER TO postgres;

--
-- Name: COLUMN be_inscripcion_conv_beca.estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.be_inscripcion_conv_beca.estado IS 'Este campo trabaja en combinación con el campo "limite_movimientos" de la tabla "convocatoria_categoria". Cuando el estado de la inscripcion es Pendiente ("P"), y suponiendo que la fecha fin de inscripción ya pasó, el becario podrá seguir modificando su inscripción hasta dicha fecha. 
Está pensado para casos en los que el becario tiene problemas en su inscripción y necesita mas tiempo que el establecido en el periodo predefinido.';


--
-- Name: be_integrante_comision_asesora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_integrante_comision_asesora (
    nro_documento character varying(15) NOT NULL,
    id_convocatoria smallint NOT NULL,
    id_area_conocimiento smallint NOT NULL
);


ALTER TABLE public.be_integrante_comision_asesora OWNER TO postgres;

--
-- Name: be_localidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_localidades (
    id_provincia smallint NOT NULL,
    id_localidad smallint NOT NULL,
    localidad character varying(100),
    codigo_postal character varying(10)
);


ALTER TABLE public.be_localidades OWNER TO postgres;

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

ALTER SEQUENCE public.be_localidades_id_localidad_seq OWNED BY public.be_localidades.id_localidad;


--
-- Name: be_motivos_baja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_motivos_baja (
    id_motivo_baja smallint NOT NULL,
    motivo_baja character varying(75)
);


ALTER TABLE public.be_motivos_baja OWNER TO postgres;

--
-- Name: be_niveles_academicos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_niveles_academicos (
    nivel_academico character varying(50) NOT NULL,
    orden numeric(2,0) NOT NULL,
    id_nivel_academico smallint NOT NULL
);


ALTER TABLE public.be_niveles_academicos OWNER TO postgres;

--
-- Name: be_paises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_paises (
    id_pais smallint NOT NULL,
    pais character varying(100)
);


ALTER TABLE public.be_paises OWNER TO postgres;

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

ALTER SEQUENCE public.be_paises_id_pais_seq OWNED BY public.be_paises.id_pais;


--
-- Name: be_planes_trabajo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_planes_trabajo (
    nro_documento character varying(15) NOT NULL,
    id_convocatoria smallint NOT NULL,
    id_tipo_beca smallint NOT NULL,
    plan_trabajo text,
    doc_probatoria character varying(300)
);


ALTER TABLE public.be_planes_trabajo OWNER TO postgres;

--
-- Name: be_provincias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_provincias (
    id_pais smallint NOT NULL,
    id_provincia smallint NOT NULL,
    provincia character varying(100)
);


ALTER TABLE public.be_provincias OWNER TO postgres;

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

ALTER SEQUENCE public.be_provincias_id_provincia_seq OWNED BY public.be_provincias.id_provincia;


--
-- Name: be_requisitos_convocatoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_requisitos_convocatoria (
    id_convocatoria smallint NOT NULL,
    requisito character varying(100),
    obligatorio character(1),
    id_requisito smallint NOT NULL,
    id_tipo_beca smallint
);


ALTER TABLE public.be_requisitos_convocatoria OWNER TO postgres;

--
-- Name: be_requisitos_insc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_requisitos_insc (
    nro_documento character varying(15) NOT NULL,
    id_convocatoria smallint NOT NULL,
    id_tipo_beca smallint NOT NULL,
    id_requisito smallint NOT NULL,
    cumplido character(1) DEFAULT 'N'::bpchar NOT NULL,
    fecha date,
    doc_probatoria character varying(300)
);


ALTER TABLE public.be_requisitos_insc OWNER TO postgres;

--
-- Name: be_resoluciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_resoluciones (
    nro_resol smallint NOT NULL,
    anio smallint NOT NULL,
    fecha date,
    archivo_pdf character varying(100),
    id_tipo_resol smallint NOT NULL
);


ALTER TABLE public.be_resoluciones OWNER TO postgres;

--
-- Name: be_resultado_avance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_resultado_avance (
    id_resultado smallint NOT NULL,
    resultado character(50),
    activo boolean
);


ALTER TABLE public.be_resultado_avance OWNER TO postgres;

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

ALTER SEQUENCE public.be_resultado_avance_id_resultado_seq OWNED BY public.be_resultado_avance.id_resultado;


--
-- Name: be_tipo_documento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_tipo_documento (
    id_tipo_doc smallint NOT NULL,
    tipo_doc character varying(50)
);


ALTER TABLE public.be_tipo_documento OWNER TO postgres;

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

ALTER SEQUENCE public.be_tipo_documento_id_tipo_doc_seq OWNED BY public.be_tipo_documento.id_tipo_doc;


--
-- Name: be_tipos_beca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_tipos_beca (
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


ALTER TABLE public.be_tipos_beca OWNER TO postgres;

--
-- Name: be_tipos_convocatoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_tipos_convocatoria (
    id_tipo_convocatoria smallint NOT NULL,
    tipo_convocatoria character varying(150)
);


ALTER TABLE public.be_tipos_convocatoria OWNER TO postgres;

--
-- Name: be_tipos_resolucion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_tipos_resolucion (
    id_tipo_resol smallint NOT NULL,
    tipo_resol character varying(100) NOT NULL,
    tipo_resol_corto character varying(25) NOT NULL
);


ALTER TABLE public.be_tipos_resolucion OWNER TO postgres;

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

ALTER SEQUENCE public.be_tipos_resolucion_id_tipo_resol_seq OWNED BY public.be_tipos_resolucion.id_tipo_resol;


--
-- Name: be_universidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.be_universidades (
    id_universidad smallint NOT NULL,
    universidad character varying(200),
    id_pais smallint,
    sigla character varying(50)
);


ALTER TABLE public.be_universidades OWNER TO postgres;

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

ALTER SEQUENCE public.be_universidades_id_universidad_seq OWNED BY public.be_universidades.id_universidad;


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

ALTER SEQUENCE public.color_carpeta_id_color_seq OWNED BY public.be_color_carpeta.id_color;


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

ALTER SEQUENCE public.convocatoria_beca_id_convocatoria_seq OWNED BY public.be_convocatoria_beca.id_convocatoria;


--
-- Name: docum_solicitud_id_documentacion_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.docum_solicitud_id_documentacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.docum_solicitud_id_documentacion_seq OWNER TO sap;

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

ALTER SEQUENCE public.motivos_baja_id_motivo_baja_seq OWNED BY public.be_motivos_baja.id_motivo_baja;


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

ALTER SEQUENCE public.niveles_academicos_id_nivel_academico_seq OWNED BY public.be_niveles_academicos.id_nivel_academico;


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

ALTER SEQUENCE public.requisitos_convocatoria_id_requisito_seq OWNED BY public.be_requisitos_convocatoria.id_requisito;


--
-- Name: sap_area_conocimiento; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_area_conocimiento (
    id integer NOT NULL,
    descripcion character varying(100),
    nombre character varying(100) NOT NULL,
    aplicable character varying(20),
    prefijo_orden_poster character varying(3)
);


ALTER TABLE public.sap_area_conocimiento OWNER TO sap;

--
-- Name: sap_area_beca_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_area_beca_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_area_beca_id_seq OWNER TO sap;

--
-- Name: sap_area_beca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_area_beca_id_seq OWNED BY public.sap_area_conocimiento.id;


--
-- Name: sap_autor; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_autor (
    id integer NOT NULL,
    autor character varying(50) NOT NULL,
    sap_comunicacion_id integer NOT NULL,
    es_becario boolean
);


ALTER TABLE public.sap_autor OWNER TO sap;

--
-- Name: COLUMN sap_autor.es_becario; Type: COMMENT; Schema: public; Owner: sap
--

COMMENT ON COLUMN public.sap_autor.es_becario IS 'Columna que indica si el autor es el becario que publica la comunicacion, y por lo tanto debe ir primero en la lista del reporte.';


--
-- Name: sap_autor_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_autor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_autor_id_seq OWNER TO sap;

--
-- Name: sap_autor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_autor_id_seq OWNED BY public.sap_autor.id;


--
-- Name: sap_cargos_descripcion; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_cargos_descripcion (
    cargo character varying(5) NOT NULL,
    descripcion character varying(50),
    activo character(1) DEFAULT 'S'::bpchar
);


ALTER TABLE public.sap_cargos_descripcion OWNER TO sap;

--
-- Name: sap_cargos_persona_id_cargo_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_cargos_persona_id_cargo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_cargos_persona_id_cargo_seq OWNER TO sap;

--
-- Name: sap_cargos_persona; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_cargos_persona (
    id_cargo integer DEFAULT nextval('public.sap_cargos_persona_id_cargo_seq'::regclass) NOT NULL,
    nro_documento character varying(15),
    cargo character varying(5),
    dedicacion character varying(5),
    fecha_desde date,
    fecha_hasta date,
    nro_cargo_mapuche character varying(10),
    dependencia character varying(5),
    caracter character varying(6)
);


ALTER TABLE public.sap_cargos_persona OWNER TO sap;

--
-- Name: sap_cat_incentivos_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_cat_incentivos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_cat_incentivos_id_seq OWNER TO sap;

--
-- Name: sap_cat_incentivos; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_cat_incentivos (
    convocatoria character varying(20) NOT NULL,
    nro_documento character varying(15) NOT NULL,
    cuil character varying(15),
    categoria numeric(1,0),
    id integer DEFAULT nextval('public.sap_cat_incentivos_id_seq'::regclass) NOT NULL
);


ALTER TABLE public.sap_cat_incentivos OWNER TO sap;

--
-- Name: sap_comunicacion; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_comunicacion (
    id integer NOT NULL,
    titulo character varying(200),
    e_mail character varying(50),
    resumen text,
    resolucion character varying(50),
    telefono character varying(50),
    sap_area_beca_id integer NOT NULL,
    sap_tipo_beca_id integer NOT NULL,
    sap_dependencia_id integer NOT NULL,
    periodo_hasta date,
    periodo_desde date,
    sap_convocatoria_id integer NOT NULL,
    version_impresa integer DEFAULT 0,
    version_modificacion integer DEFAULT 0,
    usuario_id character varying(60) NOT NULL,
    proyecto_id integer,
    orden_poster character varying(15),
    evaluador_poster character varying(100),
    estado character(1) DEFAULT 'A'::bpchar
);


ALTER TABLE public.sap_comunicacion OWNER TO sap;

--
-- Name: sap_comunicacion_evaluacion; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_comunicacion_evaluacion (
    id integer NOT NULL,
    fecha_hora timestamp without time zone DEFAULT now(),
    sap_evaluacion_id integer,
    sap_comunicacion_id integer,
    evaluadores character varying(200),
    observaciones character varying(600),
    usuario_id character varying(32)
);


ALTER TABLE public.sap_comunicacion_evaluacion OWNER TO sap;

--
-- Name: sap_comunicacion_evaluacion_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_comunicacion_evaluacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_comunicacion_evaluacion_id_seq OWNER TO sap;

--
-- Name: sap_comunicacion_evaluacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_comunicacion_evaluacion_id_seq OWNED BY public.sap_comunicacion_evaluacion.id;


--
-- Name: sap_comunicacion_evaluadores_poster; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_comunicacion_evaluadores_poster (
    id bigint,
    evaluador character varying(255)
);


ALTER TABLE public.sap_comunicacion_evaluadores_poster OWNER TO sap;

--
-- Name: sap_comunicacion_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_comunicacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_comunicacion_id_seq OWNER TO sap;

--
-- Name: sap_comunicacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_comunicacion_id_seq OWNED BY public.sap_comunicacion.id;


--
-- Name: sap_convocatoria; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_convocatoria (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    fecha_desde date,
    fecha_hasta date,
    estado character(1) DEFAULT 'A'::bpchar NOT NULL,
    aplicable character varying(20),
    limite_edicion date
);


ALTER TABLE public.sap_convocatoria OWNER TO sap;

--
-- Name: sap_convocatoria_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_convocatoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_convocatoria_id_seq OWNER TO sap;

--
-- Name: sap_convocatoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_convocatoria_id_seq OWNED BY public.sap_convocatoria.id;


--
-- Name: sap_dependencia; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_dependencia (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(100),
    sigla_mapuche character varying(5),
    id_universidad smallint
);


ALTER TABLE public.sap_dependencia OWNER TO sap;

--
-- Name: sap_dependencia_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_dependencia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_dependencia_id_seq OWNER TO sap;

--
-- Name: sap_dependencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_dependencia_id_seq OWNED BY public.sap_dependencia.id;


--
-- Name: sap_disciplinas_id_disciplina_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_disciplinas_id_disciplina_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_disciplinas_id_disciplina_seq OWNER TO sap;

--
-- Name: sap_disciplinas; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_disciplinas (
    id_disciplina integer DEFAULT nextval('public.sap_disciplinas_id_disciplina_seq'::regclass) NOT NULL,
    disciplina character varying(200)
);


ALTER TABLE public.sap_disciplinas OWNER TO sap;

--
-- Name: sap_equipo; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_equipo (
    denominacion character varying(100) NOT NULL,
    fecha_inicio date,
    departamento character varying(100),
    coordinador character varying(50),
    email character varying(50),
    lineas_estudio character varying(500),
    produccion character varying(2000),
    transferencia character varying(2000),
    area_conocimiento_id integer NOT NULL,
    dependencia_id integer NOT NULL,
    convocatoria_id integer,
    usuario_id character varying(10) NOT NULL,
    id integer NOT NULL,
    codigo character varying(10)
);


ALTER TABLE public.sap_equipo OWNER TO sap;

--
-- Name: COLUMN sap_equipo.email; Type: COMMENT; Schema: public; Owner: sap
--

COMMENT ON COLUMN public.sap_equipo.email IS '
';


--
-- Name: sap_equipo_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_equipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_equipo_id_seq OWNER TO sap;

--
-- Name: sap_equipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_equipo_id_seq OWNED BY public.sap_equipo.id;


--
-- Name: sap_equipo_integrante; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_equipo_integrante (
    apellido character varying(50),
    nombre character varying(50),
    dni character varying(15),
    condicion character varying(30),
    equipo_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.sap_equipo_integrante OWNER TO sap;

--
-- Name: sap_equipo_integrante_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_equipo_integrante_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_equipo_integrante_id_seq OWNER TO sap;

--
-- Name: sap_equipo_integrante_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_equipo_integrante_id_seq OWNED BY public.sap_equipo_integrante.id;


--
-- Name: sap_equipo_palabra_clave; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_equipo_palabra_clave (
    palabra_clave character varying(25),
    equipo_id integer,
    id integer NOT NULL
);


ALTER TABLE public.sap_equipo_palabra_clave OWNER TO sap;

--
-- Name: sap_equipo_palabra_clave_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_equipo_palabra_clave_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_equipo_palabra_clave_id_seq OWNER TO sap;

--
-- Name: sap_equipo_palabra_clave_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_equipo_palabra_clave_id_seq OWNED BY public.sap_equipo_palabra_clave.id;


--
-- Name: sap_equipo_proyecto; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_equipo_proyecto (
    proyecto_id integer NOT NULL,
    id integer NOT NULL,
    equipo_id integer
);


ALTER TABLE public.sap_equipo_proyecto OWNER TO sap;

--
-- Name: sap_equipo_proyecto_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_equipo_proyecto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_equipo_proyecto_id_seq OWNER TO sap;

--
-- Name: sap_equipo_proyecto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_equipo_proyecto_id_seq OWNED BY public.sap_equipo_proyecto.id;


--
-- Name: sap_evaluacion; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_evaluacion (
    id integer NOT NULL,
    nombre character varying(100)
);


ALTER TABLE public.sap_evaluacion OWNER TO sap;

--
-- Name: sap_evaluacion_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_evaluacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_evaluacion_id_seq OWNER TO sap;

--
-- Name: sap_evaluacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_evaluacion_id_seq OWNED BY public.sap_evaluacion.id;


--
-- Name: sap_evaluadores; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_evaluadores (
    evaluador character varying(80) NOT NULL,
    id_area_conocimiento integer NOT NULL
);


ALTER TABLE public.sap_evaluadores OWNER TO sap;

--
-- Name: sap_orde_poster; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_orde_poster (
    orden character varying(255),
    e_mail character varying(255)
);


ALTER TABLE public.sap_orde_poster OWNER TO sap;

--
-- Name: sap_palabra_clave; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_palabra_clave (
    id integer NOT NULL,
    palabra_clave character varying(50),
    sap_comunicacion_id integer
);


ALTER TABLE public.sap_palabra_clave OWNER TO sap;

--
-- Name: sap_palabra_clave_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_palabra_clave_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_palabra_clave_id_seq OWNER TO sap;

--
-- Name: sap_palabra_clave_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_palabra_clave_id_seq OWNED BY public.sap_palabra_clave.id;


--
-- Name: sap_personas; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_personas (
    nro_documento character varying(15) NOT NULL,
    cuil character varying(15),
    apellido character varying(80),
    nombres character varying(80),
    archivo_cvar character varying(90),
    mail character varying(200),
    id_disciplina integer,
    id_tipo_doc smallint,
    fecha_nac date,
    celular character varying(40),
    telefono character varying(40),
    id_localidad smallint,
    id_nivel_academico smallint,
    sexo character(1),
    archivo_titulo_grado character varying(150),
    archivo_cuil character varying(150),
    id_cat_conicet smallint
);


ALTER TABLE public.sap_personas OWNER TO sap;

--
-- Name: sap_proyectos; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_proyectos (
    id integer NOT NULL,
    codigo character varying(25) NOT NULL,
    descripcion character varying(350),
    fecha_desde date,
    fecha_hasta date,
    entidad_financiadora character varying(100),
    director character varying(100),
    co_director character varying(100),
    sub_director character varying(100)
);


ALTER TABLE public.sap_proyectos OWNER TO sap;

--
-- Name: sap_proyectos_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_proyectos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_proyectos_id_seq OWNER TO sap;

--
-- Name: sap_proyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_proyectos_id_seq OWNED BY public.sap_proyectos.id;


--
-- Name: sap_solicitud_subsidio_id_solicitud_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_solicitud_subsidio_id_solicitud_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_solicitud_subsidio_id_solicitud_seq OWNER TO sap;

--
-- Name: sap_subsidio_congreso; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_subsidio_congreso (
    id_solicitud integer NOT NULL,
    nombre character varying(200),
    lugar character varying(200),
    fecha_desde date,
    fecha_hasta date,
    costo_inscripcion numeric(10,2),
    costo_pasajes numeric(10,2),
    costo_estadia numeric(10,2),
    abstract character varying(5000)
);


ALTER TABLE public.sap_subsidio_congreso OWNER TO sap;

--
-- Name: sap_subsidio_docum_solicitud; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_subsidio_docum_solicitud (
    id_documentacion integer DEFAULT nextval('public.docum_solicitud_id_documentacion_seq'::regclass) NOT NULL,
    descripcion character varying(150),
    archivo character varying(150),
    id_solicitud integer
);


ALTER TABLE public.sap_subsidio_docum_solicitud OWNER TO sap;

--
-- Name: sap_subsidio_estadia; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_subsidio_estadia (
    id_solicitud integer NOT NULL,
    institucion character varying(100),
    lugar character varying(100),
    fecha_desde date,
    fecha_hasta date,
    costo_pasaje numeric(10,2),
    costo_estadia numeric(10,2),
    plan_trabajo character varying(5000)
);


ALTER TABLE public.sap_subsidio_estadia OWNER TO sap;

--
-- Name: sap_subsidio_eval_congreso; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_subsidio_eval_congreso (
    id_solicitud integer NOT NULL,
    cvar_solicitante numeric(5,2),
    justif_relac_proyecto numeric(5,2),
    observaciones character varying(2000)
);


ALTER TABLE public.sap_subsidio_eval_congreso OWNER TO sap;

--
-- Name: sap_subsidio_eval_estadia; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_subsidio_eval_estadia (
    id_solicitud integer NOT NULL,
    cvar_solicitante numeric(5,2),
    justif_relac_proyecto numeric(5,2),
    plan_trabajo numeric(5,2),
    observaciones character varying(2000)
);


ALTER TABLE public.sap_subsidio_eval_estadia OWNER TO sap;

--
-- Name: sap_subsidio_solicitud; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_subsidio_solicitud (
    id_solicitud integer DEFAULT nextval('public.sap_solicitud_subsidio_id_solicitud_seq'::regclass) NOT NULL,
    nro_documento character varying(15),
    tipo_subsidio character(1),
    id_dependencia integer,
    codigo_proyecto character varying(30),
    id_convocatoria integer,
    estado character(1) DEFAULT 'A'::bpchar,
    hash_cierre character(32),
    evaluador character varying(15)
);


ALTER TABLE public.sap_subsidio_solicitud OWNER TO sap;

--
-- Name: sap_tipo_beca; Type: TABLE; Schema: public; Owner: sap
--

CREATE TABLE public.sap_tipo_beca (
    id integer NOT NULL,
    descripcion character varying(100)
);


ALTER TABLE public.sap_tipo_beca OWNER TO sap;

--
-- Name: sap_tipo_beca_id_seq; Type: SEQUENCE; Schema: public; Owner: sap
--

CREATE SEQUENCE public.sap_tipo_beca_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sap_tipo_beca_id_seq OWNER TO sap;

--
-- Name: sap_tipo_beca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sap
--

ALTER SEQUENCE public.sap_tipo_beca_id_seq OWNED BY public.sap_tipo_beca.id;


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

ALTER SEQUENCE public.tipos_beca_id_tipo_beca_seq OWNED BY public.be_tipos_beca.id_tipo_beca;


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

ALTER SEQUENCE public.tipos_convocatoria_id_tipo_convocatoria_seq OWNED BY public.be_tipos_convocatoria.id_tipo_convocatoria;


--
-- Name: id_antecedente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_activ_docentes ALTER COLUMN id_antecedente SET DEFAULT nextval('public.antec_activ_docentes_id_antecedente_seq'::regclass);


--
-- Name: id_beca_obtenida; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_becas_obtenidas ALTER COLUMN id_beca_obtenida SET DEFAULT nextval('public.antec_becas_obtenidas_id_beca_obtenida_seq'::regclass);


--
-- Name: id_conocimiento_idioma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_conoc_idiomas ALTER COLUMN id_conocimiento_idioma SET DEFAULT nextval('public.antec_conoc_idiomas_id_conocimiento_idioma_seq'::regclass);


--
-- Name: id_curso_perfec_aprob; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_cursos_perfec_aprob ALTER COLUMN id_curso_perfec_aprob SET DEFAULT nextval('public.antec_cursos_perfec_aprob_id_curso_perfec_aprob_seq'::regclass);


--
-- Name: id_estudio_afin; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_estudios_afines ALTER COLUMN id_estudio_afin SET DEFAULT nextval('public.antec_estudios_afines_id_estudio_afin_seq'::regclass);


--
-- Name: id_otra_actividad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_otras_actividades ALTER COLUMN id_otra_actividad SET DEFAULT nextval('public.antec_otras_actividades_id_otra_actividad_seq'::regclass);


--
-- Name: id_particip_cursos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_particip_dict_cursos ALTER COLUMN id_particip_cursos SET DEFAULT nextval('public.antec_particip_cursos_id_particip_cursos_seq'::regclass);


--
-- Name: id_present_reunion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_present_reuniones ALTER COLUMN id_present_reunion SET DEFAULT nextval('public.antec_present_reuniones_id_present_reunion_seq'::regclass);


--
-- Name: id_trabajo_publicado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_trabajos_publicados ALTER COLUMN id_trabajo_publicado SET DEFAULT nextval('public.antec_trabajos_publicados_id_trabajo_publicado_seq'::regclass);


--
-- Name: id_area_conocimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_area_conocimiento ALTER COLUMN id_area_conocimiento SET DEFAULT nextval('public.be_area_conocimiento_id_area_conocimiento_seq'::regclass);


--
-- Name: id_avance; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_avance_beca ALTER COLUMN id_avance SET DEFAULT nextval('public.be_avance_beca_id_avance_seq'::regclass);


--
-- Name: id_carrera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_carreras ALTER COLUMN id_carrera SET DEFAULT nextval('public.be_carreras_id_carrera_seq'::regclass);


--
-- Name: id_cat_conicet; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_cat_conicet ALTER COLUMN id_cat_conicet SET DEFAULT nextval('public.be_cat_conicet_id_cat_conicet_seq'::regclass);


--
-- Name: id_color; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_color_carpeta ALTER COLUMN id_color SET DEFAULT nextval('public.color_carpeta_id_color_seq'::regclass);


--
-- Name: id_convocatoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_convocatoria_beca ALTER COLUMN id_convocatoria SET DEFAULT nextval('public.convocatoria_beca_id_convocatoria_seq'::regclass);


--
-- Name: id_localidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_localidades ALTER COLUMN id_localidad SET DEFAULT nextval('public.be_localidades_id_localidad_seq'::regclass);


--
-- Name: id_nivel_academico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_niveles_academicos ALTER COLUMN id_nivel_academico SET DEFAULT nextval('public.niveles_academicos_id_nivel_academico_seq'::regclass);


--
-- Name: id_provincia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_provincias ALTER COLUMN id_provincia SET DEFAULT nextval('public.be_provincias_id_provincia_seq'::regclass);


--
-- Name: id_requisito; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_requisitos_convocatoria ALTER COLUMN id_requisito SET DEFAULT nextval('public.requisitos_convocatoria_id_requisito_seq'::regclass);


--
-- Name: id_resultado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_resultado_avance ALTER COLUMN id_resultado SET DEFAULT nextval('public.be_resultado_avance_id_resultado_seq'::regclass);


--
-- Name: id_tipo_doc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_tipo_documento ALTER COLUMN id_tipo_doc SET DEFAULT nextval('public.be_tipo_documento_id_tipo_doc_seq'::regclass);


--
-- Name: id_tipo_beca; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_tipos_beca ALTER COLUMN id_tipo_beca SET DEFAULT nextval('public.tipos_beca_id_tipo_beca_seq'::regclass);


--
-- Name: id_tipo_convocatoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_tipos_convocatoria ALTER COLUMN id_tipo_convocatoria SET DEFAULT nextval('public.tipos_convocatoria_id_tipo_convocatoria_seq'::regclass);


--
-- Name: id_tipo_resol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_tipos_resolucion ALTER COLUMN id_tipo_resol SET DEFAULT nextval('public.be_tipos_resolucion_id_tipo_resol_seq'::regclass);


--
-- Name: id_universidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_universidades ALTER COLUMN id_universidad SET DEFAULT nextval('public.be_universidades_id_universidad_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_area_conocimiento ALTER COLUMN id SET DEFAULT nextval('public.sap_area_beca_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_autor ALTER COLUMN id SET DEFAULT nextval('public.sap_autor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_comunicacion ALTER COLUMN id SET DEFAULT nextval('public.sap_comunicacion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_comunicacion_evaluacion ALTER COLUMN id SET DEFAULT nextval('public.sap_comunicacion_evaluacion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_convocatoria ALTER COLUMN id SET DEFAULT nextval('public.sap_convocatoria_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_dependencia ALTER COLUMN id SET DEFAULT nextval('public.sap_dependencia_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo ALTER COLUMN id SET DEFAULT nextval('public.sap_equipo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo_integrante ALTER COLUMN id SET DEFAULT nextval('public.sap_equipo_integrante_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo_palabra_clave ALTER COLUMN id SET DEFAULT nextval('public.sap_equipo_palabra_clave_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo_proyecto ALTER COLUMN id SET DEFAULT nextval('public.sap_equipo_proyecto_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_evaluacion ALTER COLUMN id SET DEFAULT nextval('public.sap_evaluacion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_palabra_clave ALTER COLUMN id SET DEFAULT nextval('public.sap_palabra_clave_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_proyectos ALTER COLUMN id SET DEFAULT nextval('public.sap_proyectos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_tipo_beca ALTER COLUMN id SET DEFAULT nextval('public.sap_tipo_beca_id_seq'::regclass);


--
-- Name: id; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_comunicacion
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- Name: pk; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo_proyecto
    ADD CONSTRAINT pk PRIMARY KEY (id);


--
-- Name: pk_antec_activ_docentes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_activ_docentes
    ADD CONSTRAINT pk_antec_activ_docentes PRIMARY KEY (id_antecedente);


--
-- Name: pk_antec_becas_obtenidas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_becas_obtenidas
    ADD CONSTRAINT pk_antec_becas_obtenidas PRIMARY KEY (id_beca_obtenida);


--
-- Name: pk_antec_conoc_idiomas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_conoc_idiomas
    ADD CONSTRAINT pk_antec_conoc_idiomas PRIMARY KEY (id_conocimiento_idioma);


--
-- Name: pk_antec_cursos_perfec_aprob; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_cursos_perfec_aprob
    ADD CONSTRAINT pk_antec_cursos_perfec_aprob PRIMARY KEY (id_curso_perfec_aprob);


--
-- Name: pk_antec_estudios_afines; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_estudios_afines
    ADD CONSTRAINT pk_antec_estudios_afines PRIMARY KEY (id_estudio_afin);


--
-- Name: pk_antec_otras_actividades; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_otras_actividades
    ADD CONSTRAINT pk_antec_otras_actividades PRIMARY KEY (id_otra_actividad);


--
-- Name: pk_antec_particip_cursos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_particip_dict_cursos
    ADD CONSTRAINT pk_antec_particip_cursos PRIMARY KEY (id_particip_cursos);


--
-- Name: pk_antec_present_reuniones; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_present_reuniones
    ADD CONSTRAINT pk_antec_present_reuniones PRIMARY KEY (id_present_reunion);


--
-- Name: pk_antec_trabajos_publicados; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_trabajos_publicados
    ADD CONSTRAINT pk_antec_trabajos_publicados PRIMARY KEY (id_trabajo_publicado);


--
-- Name: pk_area_conocimiento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_area_conocimiento
    ADD CONSTRAINT pk_area_conocimiento PRIMARY KEY (id_area_conocimiento);


--
-- Name: pk_autor_id; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_autor
    ADD CONSTRAINT pk_autor_id PRIMARY KEY (id);


--
-- Name: pk_avance_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_avance_beca
    ADD CONSTRAINT pk_avance_beca PRIMARY KEY (id_avance);


--
-- Name: pk_baja_becas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_baja_becas
    ADD CONSTRAINT pk_baja_becas PRIMARY KEY (nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: pk_becas_otorgadas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_becas_otorgadas
    ADD CONSTRAINT pk_becas_otorgadas PRIMARY KEY (nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: pk_cargos; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_cargos_persona
    ADD CONSTRAINT pk_cargos PRIMARY KEY (id_cargo);


--
-- Name: pk_cargos_descripcion; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_cargos_descripcion
    ADD CONSTRAINT pk_cargos_descripcion PRIMARY KEY (cargo);


--
-- Name: pk_carrera_dependencia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_carrera_dependencia
    ADD CONSTRAINT pk_carrera_dependencia PRIMARY KEY (id_dependencia, id_carrera);


--
-- Name: pk_carreras; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_carreras
    ADD CONSTRAINT pk_carreras PRIMARY KEY (id_carrera);


--
-- Name: pk_cat_conicet; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_cat_conicet
    ADD CONSTRAINT pk_cat_conicet PRIMARY KEY (id_cat_conicet);


--
-- Name: pk_cat_incentivos; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_cat_incentivos
    ADD CONSTRAINT pk_cat_incentivos PRIMARY KEY (convocatoria, nro_documento);


--
-- Name: pk_color_carpeta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_color_carpeta
    ADD CONSTRAINT pk_color_carpeta PRIMARY KEY (id_color);


--
-- Name: pk_comision_asesora; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_comision_asesora
    ADD CONSTRAINT pk_comision_asesora PRIMARY KEY (id_area_conocimiento, id_convocatoria);


--
-- Name: pk_comunicacion_evaluacion; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_comunicacion_evaluacion
    ADD CONSTRAINT pk_comunicacion_evaluacion PRIMARY KEY (id);


--
-- Name: pk_congreso; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_congreso
    ADD CONSTRAINT pk_congreso PRIMARY KEY (id_solicitud);


--
-- Name: pk_convocatoria_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_convocatoria_beca
    ADD CONSTRAINT pk_convocatoria_beca PRIMARY KEY (id_convocatoria);


--
-- Name: pk_cumplimiento_obligacion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_cumplimiento_obligacion
    ADD CONSTRAINT pk_cumplimiento_obligacion PRIMARY KEY (nro_documento, id_convocatoria, id_tipo_beca, mes, anio);


--
-- Name: pk_disciplinas; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_disciplinas
    ADD CONSTRAINT pk_disciplinas PRIMARY KEY (id_disciplina);


--
-- Name: pk_docum_solicitud; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_docum_solicitud
    ADD CONSTRAINT pk_docum_solicitud PRIMARY KEY (id_documentacion);


--
-- Name: pk_equipo; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo
    ADD CONSTRAINT pk_equipo PRIMARY KEY (id);


--
-- Name: pk_equipointegrante; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo_integrante
    ADD CONSTRAINT pk_equipointegrante PRIMARY KEY (id);


--
-- Name: pk_equipopalabra; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo_palabra_clave
    ADD CONSTRAINT pk_equipopalabra PRIMARY KEY (id);


--
-- Name: pk_estadia; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_estadia
    ADD CONSTRAINT pk_estadia PRIMARY KEY (id_solicitud);


--
-- Name: pk_eval_congreso_id_solicitud; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_eval_congreso
    ADD CONSTRAINT pk_eval_congreso_id_solicitud PRIMARY KEY (id_solicitud);


--
-- Name: pk_eval_estadia_id_solicitud; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_eval_estadia
    ADD CONSTRAINT pk_eval_estadia_id_solicitud PRIMARY KEY (id_solicitud);


--
-- Name: pk_evaluacion; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_evaluacion
    ADD CONSTRAINT pk_evaluacion PRIMARY KEY (id);


--
-- Name: pk_evaluador; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_evaluadores
    ADD CONSTRAINT pk_evaluador PRIMARY KEY (evaluador, id_area_conocimiento);


--
-- Name: pk_id; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_convocatoria
    ADD CONSTRAINT pk_id PRIMARY KEY (id);


--
-- Name: pk_inscripcion_conv_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT pk_inscripcion_conv_beca PRIMARY KEY (nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: pk_integrante_comision_asesora; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_integrante_comision_asesora
    ADD CONSTRAINT pk_integrante_comision_asesora PRIMARY KEY (nro_documento, id_convocatoria, id_area_conocimiento);


--
-- Name: pk_localidades; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_localidades
    ADD CONSTRAINT pk_localidades PRIMARY KEY (id_localidad);


--
-- Name: pk_motivos_baja; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_motivos_baja
    ADD CONSTRAINT pk_motivos_baja PRIMARY KEY (id_motivo_baja);


--
-- Name: pk_niveles_academicos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_niveles_academicos
    ADD CONSTRAINT pk_niveles_academicos PRIMARY KEY (id_nivel_academico);


--
-- Name: pk_paises; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_paises
    ADD CONSTRAINT pk_paises PRIMARY KEY (id_pais);


--
-- Name: pk_palabra_clave; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_palabra_clave
    ADD CONSTRAINT pk_palabra_clave PRIMARY KEY (id);


--
-- Name: pk_personas; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_personas
    ADD CONSTRAINT pk_personas PRIMARY KEY (nro_documento);


--
-- Name: pk_planes_trabajo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_planes_trabajo
    ADD CONSTRAINT pk_planes_trabajo PRIMARY KEY (nro_documento, id_convocatoria, id_tipo_beca);


--
-- Name: pk_provincias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_provincias
    ADD CONSTRAINT pk_provincias PRIMARY KEY (id_provincia);


--
-- Name: pk_proyectos; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_proyectos
    ADD CONSTRAINT pk_proyectos PRIMARY KEY (id);


--
-- Name: pk_requisitos_convocatoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_requisitos_convocatoria
    ADD CONSTRAINT pk_requisitos_convocatoria PRIMARY KEY (id_requisito);


--
-- Name: pk_requisitos_insc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_requisitos_insc
    ADD CONSTRAINT pk_requisitos_insc PRIMARY KEY (nro_documento, id_convocatoria, id_tipo_beca, id_requisito);


--
-- Name: pk_resoluciones; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_resoluciones
    ADD CONSTRAINT pk_resoluciones PRIMARY KEY (nro_resol, anio, id_tipo_resol);


--
-- Name: pk_resultado_avance; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_resultado_avance
    ADD CONSTRAINT pk_resultado_avance PRIMARY KEY (id_resultado);


--
-- Name: pk_solicitud_proyecto; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_solicitud
    ADD CONSTRAINT pk_solicitud_proyecto PRIMARY KEY (id_solicitud);


--
-- Name: pk_tipo_documento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_tipo_documento
    ADD CONSTRAINT pk_tipo_documento PRIMARY KEY (id_tipo_doc);


--
-- Name: pk_tipos_beca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_tipos_beca
    ADD CONSTRAINT pk_tipos_beca PRIMARY KEY (id_tipo_beca);


--
-- Name: pk_tipos_convocatoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_tipos_convocatoria
    ADD CONSTRAINT pk_tipos_convocatoria PRIMARY KEY (id_tipo_convocatoria);


--
-- Name: pk_tipos_resolucion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_tipos_resolucion
    ADD CONSTRAINT pk_tipos_resolucion PRIMARY KEY (id_tipo_resol);


--
-- Name: pk_universidades; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_universidades
    ADD CONSTRAINT pk_universidades PRIMARY KEY (id_universidad);


--
-- Name: sap_area_beca_pkey; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_area_conocimiento
    ADD CONSTRAINT sap_area_beca_pkey PRIMARY KEY (id);


--
-- Name: sap_dependencia_pkey; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_dependencia
    ADD CONSTRAINT sap_dependencia_pkey PRIMARY KEY (id);


--
-- Name: sap_tipo_beca_pkey; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_tipo_beca
    ADD CONSTRAINT sap_tipo_beca_pkey PRIMARY KEY (id);


--
-- Name: uk_provincia_pais; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_provincias
    ADD CONSTRAINT uk_provincia_pais UNIQUE (id_pais, provincia);


--
-- Name: uq_carreras_carrera; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_carreras
    ADD CONSTRAINT uq_carreras_carrera UNIQUE (carrera);


--
-- Name: uq_cat_conicet; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_cat_conicet
    ADD CONSTRAINT uq_cat_conicet UNIQUE (cat_conicet);


--
-- Name: uq_convocatoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_convocatoria_beca
    ADD CONSTRAINT uq_convocatoria UNIQUE (convocatoria);


--
-- Name: uq_inscripcion_conv_beca_nro-carpeta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT "uq_inscripcion_conv_beca_nro-carpeta" UNIQUE (nro_carpeta, id_convocatoria);


--
-- Name: uq_nivel_academico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_niveles_academicos
    ADD CONSTRAINT uq_nivel_academico UNIQUE (nivel_academico);


--
-- Name: uq_nro_cargo_mapuche; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_cargos_persona
    ADD CONSTRAINT uq_nro_cargo_mapuche UNIQUE (nro_cargo_mapuche);


--
-- Name: uq_personas_cuil; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_personas
    ADD CONSTRAINT uq_personas_cuil UNIQUE (cuil);


--
-- Name: uq_sigla_mapuche; Type: CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_dependencia
    ADD CONSTRAINT uq_sigla_mapuche UNIQUE (sigla_mapuche);


--
-- Name: uq_tipos_beca_prefijo-carpeta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_tipos_beca
    ADD CONSTRAINT "uq_tipos_beca_prefijo-carpeta" UNIQUE (prefijo_carpeta);


--
-- Name: uq_universidades_universidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_universidades
    ADD CONSTRAINT uq_universidades_universidad UNIQUE (universidad, id_pais);


--
-- Name: fki_convocatoria; Type: INDEX; Schema: public; Owner: sap
--

CREATE INDEX fki_convocatoria ON public.sap_comunicacion USING btree (sap_convocatoria_id);


--
-- Name: fki_sap_comunicacion; Type: INDEX; Schema: public; Owner: sap
--

CREATE INDEX fki_sap_comunicacion ON public.sap_autor USING btree (sap_comunicacion_id);


--
-- Name: fki_sap_dependencia; Type: INDEX; Schema: public; Owner: sap
--

CREATE INDEX fki_sap_dependencia ON public.sap_comunicacion USING btree (sap_dependencia_id);


--
-- Name: fki_sap_tipo_beca; Type: INDEX; Schema: public; Owner: sap
--

CREATE INDEX fki_sap_tipo_beca ON public.sap_comunicacion USING btree (sap_tipo_beca_id);


--
-- Name: fk_abance_beca-id_tipo_beca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_avance_beca
    ADD CONSTRAINT "fk_abance_beca-id_tipo_beca" FOREIGN KEY (id_convocatoria, id_tipo_beca, nro_documento) REFERENCES public.be_becas_otorgadas(id_convocatoria, id_tipo_beca, nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_activ_docentes-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_activ_docentes
    ADD CONSTRAINT "fk_antec_activ_docentes-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_becas_obtenidas-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_becas_obtenidas
    ADD CONSTRAINT "fk_antec_becas_obtenidas-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_conoc_idiomas-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_conoc_idiomas
    ADD CONSTRAINT "fk_antec_conoc_idiomas-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_cursos_perfec_aprob-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_cursos_perfec_aprob
    ADD CONSTRAINT "fk_antec_cursos_perfec_aprob-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_estudios_afines-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_estudios_afines
    ADD CONSTRAINT "fk_antec_estudios_afines-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_otras_actividades-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_otras_actividades
    ADD CONSTRAINT "fk_antec_otras_actividades-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_particip_dict_cursos-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_particip_dict_cursos
    ADD CONSTRAINT "fk_antec_particip_dict_cursos-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_present_reuniones-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_present_reuniones
    ADD CONSTRAINT "fk_antec_present_reuniones-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_antec_trabajos_publicados-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_antec_trabajos_publicados
    ADD CONSTRAINT "fk_antec_trabajos_publicados-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_area; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo
    ADD CONSTRAINT fk_area FOREIGN KEY (area_conocimiento_id) REFERENCES public.sap_area_conocimiento(id);


--
-- Name: fk_avance_beca_resultado_avance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_avance_beca
    ADD CONSTRAINT fk_avance_beca_resultado_avance FOREIGN KEY (id_resultado) REFERENCES public.be_resultado_avance(id_resultado) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_baja_becas-beca_otorgada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_baja_becas
    ADD CONSTRAINT "fk_baja_becas-beca_otorgada" FOREIGN KEY (nro_documento, id_convocatoria, id_tipo_beca) REFERENCES public.be_becas_otorgadas(nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_baja_becas_motivo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_baja_becas
    ADD CONSTRAINT fk_baja_becas_motivo FOREIGN KEY (id_motivo_baja) REFERENCES public.be_motivos_baja(id_motivo_baja) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_becas_otorgadas-insc_conv_beca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_becas_otorgadas
    ADD CONSTRAINT "fk_becas_otorgadas-insc_conv_beca" FOREIGN KEY (nro_documento, id_convocatoria, id_tipo_beca) REFERENCES public.be_inscripcion_conv_beca(nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_becas_otorgadas_resol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_becas_otorgadas
    ADD CONSTRAINT fk_becas_otorgadas_resol FOREIGN KEY (id_tipo_resol, nro_resol, anio) REFERENCES public.be_resoluciones(id_tipo_resol, nro_resol, anio);


--
-- Name: fk_cargos_persona-dependencia; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_cargos_persona
    ADD CONSTRAINT "fk_cargos_persona-dependencia" FOREIGN KEY (dependencia) REFERENCES public.sap_dependencia(sigla_mapuche) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_cargos_personas-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_cargos_persona
    ADD CONSTRAINT "fk_cargos_personas-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_carrera_dependencia-id_dependencia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_carrera_dependencia
    ADD CONSTRAINT "fk_carrera_dependencia-id_dependencia" FOREIGN KEY (id_dependencia) REFERENCES public.sap_dependencia(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_carrera_dependencia_carreras; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_carrera_dependencia
    ADD CONSTRAINT fk_carrera_dependencia_carreras FOREIGN KEY (id_carrera) REFERENCES public.be_carreras(id_carrera) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_cat_incentivos-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_cat_incentivos
    ADD CONSTRAINT "fk_cat_incentivos-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_comision_asesora_area_conocimiento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_comision_asesora
    ADD CONSTRAINT fk_comision_asesora_area_conocimiento FOREIGN KEY (id_area_conocimiento) REFERENCES public.be_area_conocimiento(id_area_conocimiento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_comision_asesora_convocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_comision_asesora
    ADD CONSTRAINT fk_comision_asesora_convocatoria FOREIGN KEY (id_convocatoria) REFERENCES public.be_convocatoria_beca(id_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_comunicacion; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_palabra_clave
    ADD CONSTRAINT fk_comunicacion FOREIGN KEY (sap_comunicacion_id) REFERENCES public.sap_comunicacion(id);


--
-- Name: fk_comunicacion; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_comunicacion_evaluacion
    ADD CONSTRAINT fk_comunicacion FOREIGN KEY (sap_comunicacion_id) REFERENCES public.sap_comunicacion(id);


--
-- Name: fk_comunicacion-id_proyecto; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_comunicacion
    ADD CONSTRAINT "fk_comunicacion-id_proyecto" FOREIGN KEY (proyecto_id) REFERENCES public.sap_proyectos(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_congreso-id_solicitud; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_congreso
    ADD CONSTRAINT "fk_congreso-id_solicitud" FOREIGN KEY (id_solicitud) REFERENCES public.sap_subsidio_solicitud(id_solicitud) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_convocatoria; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_comunicacion
    ADD CONSTRAINT fk_convocatoria FOREIGN KEY (sap_convocatoria_id) REFERENCES public.sap_convocatoria(id);


--
-- Name: fk_convocatoria; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo
    ADD CONSTRAINT fk_convocatoria FOREIGN KEY (convocatoria_id) REFERENCES public.sap_convocatoria(id);


--
-- Name: fk_convocatoria_beca_tipoconvocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_convocatoria_beca
    ADD CONSTRAINT fk_convocatoria_beca_tipoconvocatoria FOREIGN KEY (id_tipo_convocatoria) REFERENCES public.be_tipos_convocatoria(id_tipo_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_cumplimiento_obligacion-becas_otorgadas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_cumplimiento_obligacion
    ADD CONSTRAINT "fk_cumplimiento_obligacion-becas_otorgadas" FOREIGN KEY (nro_documento, id_convocatoria, id_tipo_beca) REFERENCES public.be_inscripcion_conv_beca(nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_dependencia; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo
    ADD CONSTRAINT fk_dependencia FOREIGN KEY (dependencia_id) REFERENCES public.sap_dependencia(id);


--
-- Name: fk_dependencia-id_universidad; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_dependencia
    ADD CONSTRAINT "fk_dependencia-id_universidad" FOREIGN KEY (id_universidad) REFERENCES public.be_universidades(id_universidad) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_equipo; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo_palabra_clave
    ADD CONSTRAINT fk_equipo FOREIGN KEY (equipo_id) REFERENCES public.sap_equipo(id);


--
-- Name: fk_equipo; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo_proyecto
    ADD CONSTRAINT fk_equipo FOREIGN KEY (equipo_id) REFERENCES public.sap_equipo(id);


--
-- Name: fk_equipo; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo_integrante
    ADD CONSTRAINT fk_equipo FOREIGN KEY (equipo_id) REFERENCES public.sap_equipo(id);


--
-- Name: fk_equipo-proyecto_id; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_equipo_proyecto
    ADD CONSTRAINT "fk_equipo-proyecto_id" FOREIGN KEY (proyecto_id) REFERENCES public.sap_proyectos(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_estadia-id_solicitud; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_estadia
    ADD CONSTRAINT "fk_estadia-id_solicitud" FOREIGN KEY (id_solicitud) REFERENCES public.sap_subsidio_solicitud(id_solicitud) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_eval_congreso_id_solicitud; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_eval_congreso
    ADD CONSTRAINT fk_eval_congreso_id_solicitud FOREIGN KEY (id_solicitud) REFERENCES public.sap_subsidio_congreso(id_solicitud) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_eval_estadia_id_solicitud; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_eval_estadia
    ADD CONSTRAINT fk_eval_estadia_id_solicitud FOREIGN KEY (id_solicitud) REFERENCES public.sap_subsidio_estadia(id_solicitud) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_evaluadores_id_areaconocimiento; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_evaluadores
    ADD CONSTRAINT fk_evaluadores_id_areaconocimiento FOREIGN KEY (id_area_conocimiento) REFERENCES public.sap_area_conocimiento(id);


--
-- Name: fk_insc_conv_beca-id_dependencia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT "fk_insc_conv_beca-id_dependencia" FOREIGN KEY (id_dependencia) REFERENCES public.sap_dependencia(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca-id_proyecto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT "fk_inscripcion_conv_beca-id_proyecto" FOREIGN KEY (id_proyecto) REFERENCES public.sap_proyectos(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca-lugar_trabajo_becario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT "fk_inscripcion_conv_beca-lugar_trabajo_becario" FOREIGN KEY (lugar_trabajo_becario) REFERENCES public.sap_dependencia(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT "fk_inscripcion_conv_beca-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca-nro_documento_codir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT "fk_inscripcion_conv_beca-nro_documento_codir" FOREIGN KEY (nro_documento_codir) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca-nro_documento_dir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT "fk_inscripcion_conv_beca-nro_documento_dir" FOREIGN KEY (nro_documento_dir) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca-nro_documento_subdir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT "fk_inscripcion_conv_beca-nro_documento_subdir" FOREIGN KEY (nro_documento_subdir) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca_area_conocimiento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_area_conocimiento FOREIGN KEY (id_area_conocimiento) REFERENCES public.be_area_conocimiento(id_area_conocimiento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_inscripcion_conv_beca_idconvocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_idconvocatoria FOREIGN KEY (id_convocatoria) REFERENCES public.be_convocatoria_beca(id_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_beca_idtipobeca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_beca_idtipobeca FOREIGN KEY (id_tipo_beca) REFERENCES public.be_tipos_beca(id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_inscripcion_conv_becas_carrera; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_inscripcion_conv_beca
    ADD CONSTRAINT fk_inscripcion_conv_becas_carrera FOREIGN KEY (id_carrera) REFERENCES public.be_carreras(id_carrera) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_integrante_comision_asesora_comision_asesora; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_integrante_comision_asesora
    ADD CONSTRAINT fk_integrante_comision_asesora_comision_asesora FOREIGN KEY (id_convocatoria, id_area_conocimiento) REFERENCES public.be_comision_asesora(id_convocatoria, id_area_conocimiento) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_localidades_id-provincia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_localidades
    ADD CONSTRAINT "fk_localidades_id-provincia" FOREIGN KEY (id_provincia) REFERENCES public.be_provincias(id_provincia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_personas-id_cat_conicet; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_personas
    ADD CONSTRAINT "fk_personas-id_cat_conicet" FOREIGN KEY (id_cat_conicet) REFERENCES public.be_cat_conicet(id_cat_conicet) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_personas-id_disciplina; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_personas
    ADD CONSTRAINT "fk_personas-id_disciplina" FOREIGN KEY (id_disciplina) REFERENCES public.sap_disciplinas(id_disciplina) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_personas-id_localidad; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_personas
    ADD CONSTRAINT "fk_personas-id_localidad" FOREIGN KEY (id_localidad) REFERENCES public.be_localidades(id_localidad) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_personas-id_nivel_academico; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_personas
    ADD CONSTRAINT "fk_personas-id_nivel_academico" FOREIGN KEY (id_nivel_academico) REFERENCES public.be_niveles_academicos(id_nivel_academico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_personas-id_tipo_doc; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_personas
    ADD CONSTRAINT "fk_personas-id_tipo_doc" FOREIGN KEY (id_tipo_doc) REFERENCES public.be_tipo_documento(id_tipo_doc) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_planes_trabajo-insc_conv_beca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_planes_trabajo
    ADD CONSTRAINT "fk_planes_trabajo-insc_conv_beca" FOREIGN KEY (nro_documento, id_convocatoria, id_tipo_beca) REFERENCES public.be_inscripcion_conv_beca(nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_provincias_paises; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_provincias
    ADD CONSTRAINT fk_provincias_paises FOREIGN KEY (id_pais) REFERENCES public.be_paises(id_pais) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_requisitos_convocatoria-id_tipo_beca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_requisitos_convocatoria
    ADD CONSTRAINT "fk_requisitos_convocatoria-id_tipo_beca" FOREIGN KEY (id_tipo_beca) REFERENCES public.be_tipos_beca(id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_requisitos_convocatoria_id_convocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_requisitos_convocatoria
    ADD CONSTRAINT fk_requisitos_convocatoria_id_convocatoria FOREIGN KEY (id_convocatoria) REFERENCES public.be_convocatoria_beca(id_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_requisitos_insc-insc_conv_beca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_requisitos_insc
    ADD CONSTRAINT "fk_requisitos_insc-insc_conv_beca" FOREIGN KEY (nro_documento, id_convocatoria, id_tipo_beca) REFERENCES public.be_inscripcion_conv_beca(nro_documento, id_convocatoria, id_tipo_beca) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_requisitos_insc_idrequisito; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_requisitos_insc
    ADD CONSTRAINT fk_requisitos_insc_idrequisito FOREIGN KEY (id_requisito) REFERENCES public.be_requisitos_convocatoria(id_requisito) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_resoluciones_id_tipo_resol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_resoluciones
    ADD CONSTRAINT fk_resoluciones_id_tipo_resol FOREIGN KEY (id_tipo_resol) REFERENCES public.be_tipos_resolucion(id_tipo_resol) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_sap_comunicacion; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_autor
    ADD CONSTRAINT fk_sap_comunicacion FOREIGN KEY (sap_comunicacion_id) REFERENCES public.sap_comunicacion(id);


--
-- Name: fk_sap_evaluacion; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_comunicacion_evaluacion
    ADD CONSTRAINT fk_sap_evaluacion FOREIGN KEY (sap_evaluacion_id) REFERENCES public.sap_evaluacion(id);


--
-- Name: fk_solicitud_proyecto-dependencia; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_solicitud
    ADD CONSTRAINT "fk_solicitud_proyecto-dependencia" FOREIGN KEY (id_dependencia) REFERENCES public.sap_dependencia(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_solicitud_subsidio-id_convocatoria; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_solicitud
    ADD CONSTRAINT "fk_solicitud_subsidio-id_convocatoria" FOREIGN KEY (id_convocatoria) REFERENCES public.sap_convocatoria(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_subsidio_solicitud-nro_documento; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_solicitud
    ADD CONSTRAINT "fk_subsidio_solicitud-nro_documento" FOREIGN KEY (nro_documento) REFERENCES public.sap_personas(nro_documento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_tipos_beca_idcolor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_tipos_beca
    ADD CONSTRAINT fk_tipos_beca_idcolor FOREIGN KEY (id_color) REFERENCES public.be_color_carpeta(id_color) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_tipos_beca_tipoconvocatoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_tipos_beca
    ADD CONSTRAINT fk_tipos_beca_tipoconvocatoria FOREIGN KEY (id_tipo_convocatoria) REFERENCES public.be_tipos_convocatoria(id_tipo_convocatoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_universidades_paises; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.be_universidades
    ADD CONSTRAINT fk_universidades_paises FOREIGN KEY (id_pais) REFERENCES public.be_paises(id_pais) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: pk_docum_solicitud-id_solicitud; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_subsidio_docum_solicitud
    ADD CONSTRAINT "pk_docum_solicitud-id_solicitud" FOREIGN KEY (id_solicitud) REFERENCES public.sap_subsidio_solicitud(id_solicitud) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: sap_area_beca_id; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_comunicacion
    ADD CONSTRAINT sap_area_beca_id FOREIGN KEY (sap_area_beca_id) REFERENCES public.sap_area_conocimiento(id);


--
-- Name: sap_dependencia; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_comunicacion
    ADD CONSTRAINT sap_dependencia FOREIGN KEY (sap_dependencia_id) REFERENCES public.sap_dependencia(id);


--
-- Name: sap_tipo_beca; Type: FK CONSTRAINT; Schema: public; Owner: sap
--

ALTER TABLE ONLY public.sap_comunicacion
    ADD CONSTRAINT sap_tipo_beca FOREIGN KEY (sap_tipo_beca_id) REFERENCES public.sap_tipo_beca(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: TABLE sap_area_conocimiento; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_area_conocimiento FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_area_conocimiento FROM sap;
GRANT ALL ON TABLE public.sap_area_conocimiento TO sap;


--
-- Name: SEQUENCE sap_area_beca_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_area_beca_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_area_beca_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_area_beca_id_seq TO sap;


--
-- Name: TABLE sap_autor; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_autor FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_autor FROM sap;
GRANT ALL ON TABLE public.sap_autor TO sap;


--
-- Name: SEQUENCE sap_autor_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_autor_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_autor_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_autor_id_seq TO sap;


--
-- Name: TABLE sap_comunicacion; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_comunicacion FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_comunicacion FROM sap;
GRANT ALL ON TABLE public.sap_comunicacion TO sap;


--
-- Name: TABLE sap_comunicacion_evaluacion; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_comunicacion_evaluacion FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_comunicacion_evaluacion FROM sap;
GRANT ALL ON TABLE public.sap_comunicacion_evaluacion TO sap;


--
-- Name: SEQUENCE sap_comunicacion_evaluacion_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_comunicacion_evaluacion_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_comunicacion_evaluacion_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_comunicacion_evaluacion_id_seq TO sap;


--
-- Name: SEQUENCE sap_comunicacion_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_comunicacion_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_comunicacion_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_comunicacion_id_seq TO sap;


--
-- Name: TABLE sap_convocatoria; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_convocatoria FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_convocatoria FROM sap;
GRANT ALL ON TABLE public.sap_convocatoria TO sap;


--
-- Name: SEQUENCE sap_convocatoria_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_convocatoria_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_convocatoria_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_convocatoria_id_seq TO sap;


--
-- Name: TABLE sap_dependencia; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_dependencia FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_dependencia FROM sap;
GRANT ALL ON TABLE public.sap_dependencia TO sap;


--
-- Name: SEQUENCE sap_dependencia_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_dependencia_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_dependencia_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_dependencia_id_seq TO sap;


--
-- Name: TABLE sap_equipo; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_equipo FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_equipo FROM sap;
GRANT ALL ON TABLE public.sap_equipo TO sap;


--
-- Name: SEQUENCE sap_equipo_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_equipo_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_equipo_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_equipo_id_seq TO sap;


--
-- Name: TABLE sap_equipo_integrante; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_equipo_integrante FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_equipo_integrante FROM sap;
GRANT ALL ON TABLE public.sap_equipo_integrante TO sap;


--
-- Name: SEQUENCE sap_equipo_integrante_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_equipo_integrante_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_equipo_integrante_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_equipo_integrante_id_seq TO sap;


--
-- Name: TABLE sap_equipo_palabra_clave; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_equipo_palabra_clave FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_equipo_palabra_clave FROM sap;
GRANT ALL ON TABLE public.sap_equipo_palabra_clave TO sap;


--
-- Name: SEQUENCE sap_equipo_palabra_clave_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_equipo_palabra_clave_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_equipo_palabra_clave_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_equipo_palabra_clave_id_seq TO sap;


--
-- Name: TABLE sap_equipo_proyecto; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_equipo_proyecto FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_equipo_proyecto FROM sap;
GRANT ALL ON TABLE public.sap_equipo_proyecto TO sap;


--
-- Name: SEQUENCE sap_equipo_proyecto_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_equipo_proyecto_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_equipo_proyecto_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_equipo_proyecto_id_seq TO sap;


--
-- Name: TABLE sap_evaluacion; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_evaluacion FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_evaluacion FROM sap;
GRANT ALL ON TABLE public.sap_evaluacion TO sap;


--
-- Name: SEQUENCE sap_evaluacion_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_evaluacion_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_evaluacion_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_evaluacion_id_seq TO sap;


--
-- Name: TABLE sap_palabra_clave; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_palabra_clave FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_palabra_clave FROM sap;
GRANT ALL ON TABLE public.sap_palabra_clave TO sap;


--
-- Name: SEQUENCE sap_palabra_clave_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_palabra_clave_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_palabra_clave_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_palabra_clave_id_seq TO sap;


--
-- Name: TABLE sap_proyectos; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_proyectos FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_proyectos FROM sap;
GRANT ALL ON TABLE public.sap_proyectos TO sap;


--
-- Name: SEQUENCE sap_proyectos_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_proyectos_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_proyectos_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_proyectos_id_seq TO sap;


--
-- Name: TABLE sap_tipo_beca; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON TABLE public.sap_tipo_beca FROM PUBLIC;
REVOKE ALL ON TABLE public.sap_tipo_beca FROM sap;
GRANT ALL ON TABLE public.sap_tipo_beca TO sap;


--
-- Name: SEQUENCE sap_tipo_beca_id_seq; Type: ACL; Schema: public; Owner: sap
--

REVOKE ALL ON SEQUENCE public.sap_tipo_beca_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sap_tipo_beca_id_seq FROM sap;
GRANT ALL ON SEQUENCE public.sap_tipo_beca_id_seq TO sap;


--
-- PostgreSQL database dump complete
--

