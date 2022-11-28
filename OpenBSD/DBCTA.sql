CREATE ROLE dbcta WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD /SCRAM-PWD/

DROP DATABASE IF EXISTS "DBCTA";

CREATE DATABASE "DBCTA"
    WITH
    OWNER = dbcta
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- SEQUENCE: public.centro_id_seq

DROP SEQUENCE IF EXISTS public.centro_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.centro_id_seq
    INCREMENT 1
    START 1
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.centro_id_seq
    OWNER TO dbcta;

GRANT ALL ON SEQUENCE public.centro_id_seq TO dbcta;

-- Table: public.centro

DROP TABLE IF EXISTS public.centro;

CREATE TABLE IF NOT EXISTS public.centro
(
    id integer NOT NULL DEFAULT nextval('centro_id_seq'::regclass),
    corporacion character varying(25) COLLATE pg_catalog."default" NOT NULL,
    division character varying(25) COLLATE pg_catalog."default",
    centro character varying(25) COLLATE pg_catalog."default" NOT NULL,
    lat_long point NOT NULL,
    CONSTRAINT centro_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.centro
    OWNER to dbcta;

GRANT ALL ON TABLE public.centro TO dbcta;


-- SEQUENCE: public.canal_id_seq

DROP SEQUENCE IF EXISTS public.canal_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.canal_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.canal_id_seq
    OWNER TO dbcta;

GRANT ALL ON SEQUENCE public.canal_id_seq TO dbcta;

-- Table: public.canal

DROP TABLE IF EXISTS public.canal;

CREATE TABLE IF NOT EXISTS public.canal
(
    id integer NOT NULL DEFAULT nextval('canal_id_seq'::regclass),
    corporacion character varying(25) COLLATE pg_catalog."default" NOT NULL,
    division character varying(25) COLLATE pg_catalog."default" NOT NULL,
    programa character varying(25) COLLATE pg_catalog."default" NOT NULL,
    frec_khz bigint NOT NULL,
    podcast text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT canal_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.canal
    OWNER to dbcta;

GRANT INSERT, DELETE, SELECT, UPDATE ON TABLE public.canal TO dbcta;


-- SEQUENCE: public.scanner_id_seq

DROP SEQUENCE IF EXISTS public.scanner_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.scanner_id_seq
    INCREMENT 1
    START 1
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.scanner_id_seq
    OWNER TO dbcta;

GRANT ALL ON SEQUENCE public.scanner_id_seq TO dbcta;

-- Table: public.scanner

DROP TABLE IF EXISTS public.scanner;

CREATE TABLE IF NOT EXISTS public.scanner
(
    id integer NOT NULL DEFAULT nextval('scanner_id_seq'::regclass),
    "POP" character varying(25) COLLATE pg_catalog."default" NOT NULL,
    lat_long point NOT NULL,
    "LHN" character varying(25) COLLATE pg_catalog."default" NOT NULL,
    "PCB" character varying(25) COLLATE pg_catalog."default" NOT NULL,
    "SDR" character varying(25) COLLATE pg_catalog."default" NOT NULL,
    ant_tipo character varying(25) COLLATE pg_catalog."default" NOT NULL,
    ant_modelo character varying(25) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT scanner_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.scanner
    OWNER to dbcta;

GRANT ALL ON TABLE public.scanner TO dbcta;
