--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.6
-- Dumped by pg_dump version 9.6.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: smart_validator; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE smart_validator WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE smart_validator OWNER TO postgres;

\connect smart_validator

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
-- Name: update_timestamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION update_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_timestamp() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: announcements; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE announcements (
    id integer NOT NULL,
    asn bigint NOT NULL,
    prefix cidr NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE announcements OWNER TO svt1;

--
-- Name: announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE announcements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE announcements_id_seq OWNER TO svt1;

--
-- Name: announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE announcements_id_seq OWNED BY announcements.id;


--
-- Name: archive_snapshot_times; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE archive_snapshot_times (
    id integer NOT NULL,
    start timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE archive_snapshot_times OWNER TO svt1;

--
-- Name: archive_snapshot_times_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE archive_snapshot_times_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE archive_snapshot_times_id_seq OWNER TO svt1;

--
-- Name: archive_snapshot_times_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE archive_snapshot_times_id_seq OWNED BY archive_snapshot_times.id;


--
-- Name: archived_conflicts; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE archived_conflicts (
    id integer NOT NULL,
    prefix cidr NOT NULL,
    reason integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE archived_conflicts OWNER TO svt1;

--
-- Name: archived_conflicts_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE archived_conflicts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE archived_conflicts_id_seq OWNER TO svt1;

--
-- Name: archived_conflicts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE archived_conflicts_id_seq OWNED BY archived_conflicts.id;


--
-- Name: archived_resolutions; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE archived_resolutions (
    id integer NOT NULL,
    prefix cidr NOT NULL,
    asn bigint NOT NULL,
    max_length integer NOT NULL,
    method integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE archived_resolutions OWNER TO svt1;

--
-- Name: archived_resolutions_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE archived_resolutions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE archived_resolutions_id_seq OWNER TO svt1;

--
-- Name: archived_resolutions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE archived_resolutions_id_seq OWNED BY archived_resolutions.id;


--
-- Name: as_rankings; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE as_rankings (
    country text,
    asn bigint,
    rank double precision,
    name text
);


ALTER TABLE as_rankings OWNER TO svt1;

--
-- Name: conflict_timeline_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE conflict_timeline_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE conflict_timeline_id_seq OWNER TO svt1;

--
-- Name: conflicts_test; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE conflicts_test (
    id integer NOT NULL,
    verified_announcement_id integer,
    validated_roa_id integer,
    route_validity integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE conflicts_test OWNER TO svt1;

--
-- Name: conflicts_test_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE conflicts_test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE conflicts_test_id_seq OWNER TO svt1;

--
-- Name: conflicts_test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE conflicts_test_id_seq OWNED BY conflicts_test.id;


--
-- Name: validated_roas; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE validated_roas (
    id integer NOT NULL,
    asn bigint NOT NULL,
    prefix cidr NOT NULL,
    max_length integer NOT NULL,
    filtered boolean DEFAULT false,
    whitelisted boolean DEFAULT false,
    trust_anchor_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE validated_roas OWNER TO svt1;

--
-- Name: validated_roas_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE validated_roas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE validated_roas_id_seq OWNER TO svt1;

--
-- Name: validated_roas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE validated_roas_id_seq OWNED BY validated_roas.id;


--
-- Name: custom_announcements; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE custom_announcements (
    id integer DEFAULT nextval('validated_roas_id_seq'::regclass) NOT NULL,
    asn bigint NOT NULL,
    prefix cidr NOT NULL,
    blocking_status integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE custom_announcements OWNER TO svt1;

--
-- Name: global_announcements; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE global_announcements (
    id integer DEFAULT nextval('validated_roas_id_seq'::regclass) NOT NULL,
    asn bigint NOT NULL,
    prefix cidr NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE global_announcements OWNER TO svt1;

--
-- Name: local_announcements; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE local_announcements (
    id integer DEFAULT nextval('validated_roas_id_seq'::regclass) NOT NULL,
    asn bigint NOT NULL,
    prefix cidr NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE local_announcements OWNER TO svt1;

--
-- Name: local_conflicts; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE local_conflicts (
    id integer NOT NULL,
    local_announcement_id integer,
    blocking_status integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE local_conflicts OWNER TO svt1;

--
-- Name: local_conflicts_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE local_conflicts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE local_conflicts_id_seq OWNER TO svt1;

--
-- Name: local_conflicts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE local_conflicts_id_seq OWNED BY local_conflicts.id;


--
-- Name: netflows; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE netflows (
    id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    protocol smallint NOT NULL,
    duration double precision NOT NULL,
    src cidr NOT NULL,
    dst cidr NOT NULL,
    packets integer NOT NULL,
    bytes bigint NOT NULL,
    flows integer DEFAULT 1 NOT NULL,
    filter_type integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    dstport integer,
    srcport integer
);


ALTER TABLE netflows OWNER TO svt1;

--
-- Name: netflows_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE netflows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE netflows_id_seq OWNER TO svt1;

--
-- Name: netflows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE netflows_id_seq OWNED BY netflows.id;


--
-- Name: payload_roas; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE payload_roas (
    id integer NOT NULL,
    asn bigint NOT NULL,
    prefix cidr NOT NULL,
    max_length integer NOT NULL,
    filtered boolean DEFAULT false,
    whitelisted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE payload_roas OWNER TO svt1;

--
-- Name: payload_roas_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE payload_roas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payload_roas_id_seq OWNER TO svt1;

--
-- Name: payload_roas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE payload_roas_id_seq OWNED BY payload_roas.id;


--
-- Name: rpki_validated_roas; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE rpki_validated_roas (
    id integer DEFAULT nextval('validated_roas_id_seq'::regclass) NOT NULL,
    asn bigint NOT NULL,
    prefix cidr NOT NULL,
    max_length integer NOT NULL,
    filtered boolean DEFAULT false,
    whitelisted boolean DEFAULT false,
    trust_anchor_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE rpki_validated_roas OWNER TO svt1;

--
-- Name: rtr_status_entries; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE rtr_status_entries (
    id integer NOT NULL,
    router inet NOT NULL,
    state integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE rtr_status_entries OWNER TO svt1;

--
-- Name: rtr_status_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE rtr_status_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rtr_status_entries_id_seq OWNER TO svt1;

--
-- Name: rtr_status_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE rtr_status_entries_id_seq OWNED BY rtr_status_entries.id;


--
-- Name: settings; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE settings (
    id integer NOT NULL,
    key text NOT NULL,
    value text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE settings OWNER TO svt1;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE settings_id_seq OWNER TO svt1;

--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE settings_id_seq OWNED BY settings.id;


--
-- Name: test_table; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE test_table (
    id integer NOT NULL,
    verified_announcement_id integer,
    validated_roa_id integer,
    route_validity integer
);


ALTER TABLE test_table OWNER TO svt1;

--
-- Name: test_table_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE test_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_table_id_seq OWNER TO svt1;

--
-- Name: test_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE test_table_id_seq OWNED BY test_table.id;


--
-- Name: timeline_conflicts; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE timeline_conflicts (
    id integer DEFAULT nextval('conflict_timeline_id_seq'::regclass) NOT NULL,
    count integer,
    check_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE timeline_conflicts OWNER TO svt1;

--
-- Name: trust_anchors; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE trust_anchors (
    id integer NOT NULL,
    ca_name text NOT NULL,
    certification_location text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE trust_anchors OWNER TO svt1;

--
-- Name: trust_anchors_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE trust_anchors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trust_anchors_id_seq OWNER TO svt1;

--
-- Name: trust_anchors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE trust_anchors_id_seq OWNED BY trust_anchors.id;


--
-- Name: user_announcements; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE user_announcements (
    id integer NOT NULL,
    asn bigint NOT NULL,
    prefix cidr NOT NULL,
    blocking_state integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    announcement_id integer
);


ALTER TABLE user_announcements OWNER TO svt1;

--
-- Name: user_announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE user_announcements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_announcements_id_seq OWNER TO svt1;

--
-- Name: user_announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE user_announcements_id_seq OWNED BY user_announcements.id;


--
-- Name: user_prefixes; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE user_prefixes (
    id integer DEFAULT nextval('validated_roas_id_seq'::regclass) NOT NULL,
    prefix cidr NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE user_prefixes OWNER TO svt1;

--
-- Name: validated_roas_old; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE validated_roas_old (
    id integer,
    asn bigint,
    prefix cidr,
    max_length integer,
    filtered boolean,
    whitelisted boolean,
    trust_anchor_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE validated_roas_old OWNER TO svt1;

--
-- Name: validated_roas_verified_announcements; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE validated_roas_verified_announcements (
    id integer NOT NULL,
    announcement_id integer,
    validated_roa_id integer,
    route_validity integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE validated_roas_verified_announcements OWNER TO svt1;

--
-- Name: validated_roas_verified_announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE validated_roas_verified_announcements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE validated_roas_verified_announcements_id_seq OWNER TO svt1;

--
-- Name: validated_roas_verified_announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE validated_roas_verified_announcements_id_seq OWNED BY validated_roas_verified_announcements.id;


--
-- Name: verified_announcements; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE verified_announcements (
    id integer NOT NULL,
    announcement_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE verified_announcements OWNER TO svt1;

--
-- Name: verified_announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE verified_announcements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE verified_announcements_id_seq OWNER TO svt1;

--
-- Name: verified_announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE verified_announcements_id_seq OWNED BY verified_announcements.id;


--
-- Name: watched_announcements; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE watched_announcements (
    id integer NOT NULL,
    asn bigint NOT NULL,
    prefix cidr NOT NULL,
    blocking_state integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    announcement_id integer
);


ALTER TABLE watched_announcements OWNER TO svt1;

--
-- Name: watched_announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE watched_announcements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE watched_announcements_id_seq OWNER TO svt1;

--
-- Name: watched_announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE watched_announcements_id_seq OWNED BY watched_announcements.id;


--
-- Name: watched_prefixes; Type: TABLE; Schema: public; Owner: svt1
--

CREATE TABLE watched_prefixes (
    id integer NOT NULL,
    prefix cidr NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE watched_prefixes OWNER TO svt1;

--
-- Name: watched_prefixes_id_seq; Type: SEQUENCE; Schema: public; Owner: svt1
--

CREATE SEQUENCE watched_prefixes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE watched_prefixes_id_seq OWNER TO svt1;

--
-- Name: watched_prefixes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svt1
--

ALTER SEQUENCE watched_prefixes_id_seq OWNED BY watched_prefixes.id;


--
-- Name: announcements id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY announcements ALTER COLUMN id SET DEFAULT nextval('announcements_id_seq'::regclass);


--
-- Name: archive_snapshot_times id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY archive_snapshot_times ALTER COLUMN id SET DEFAULT nextval('archive_snapshot_times_id_seq'::regclass);


--
-- Name: archived_conflicts id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY archived_conflicts ALTER COLUMN id SET DEFAULT nextval('archived_conflicts_id_seq'::regclass);


--
-- Name: archived_resolutions id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY archived_resolutions ALTER COLUMN id SET DEFAULT nextval('archived_resolutions_id_seq'::regclass);


--
-- Name: conflicts_test id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY conflicts_test ALTER COLUMN id SET DEFAULT nextval('conflicts_test_id_seq'::regclass);


--
-- Name: local_conflicts id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY local_conflicts ALTER COLUMN id SET DEFAULT nextval('local_conflicts_id_seq'::regclass);


--
-- Name: netflows id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY netflows ALTER COLUMN id SET DEFAULT nextval('netflows_id_seq'::regclass);


--
-- Name: payload_roas id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY payload_roas ALTER COLUMN id SET DEFAULT nextval('payload_roas_id_seq'::regclass);


--
-- Name: rtr_status_entries id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY rtr_status_entries ALTER COLUMN id SET DEFAULT nextval('rtr_status_entries_id_seq'::regclass);


--
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY settings ALTER COLUMN id SET DEFAULT nextval('settings_id_seq'::regclass);


--
-- Name: test_table id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY test_table ALTER COLUMN id SET DEFAULT nextval('test_table_id_seq'::regclass);


--
-- Name: trust_anchors id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY trust_anchors ALTER COLUMN id SET DEFAULT nextval('trust_anchors_id_seq'::regclass);


--
-- Name: user_announcements id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY user_announcements ALTER COLUMN id SET DEFAULT nextval('user_announcements_id_seq'::regclass);


--
-- Name: validated_roas id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY validated_roas ALTER COLUMN id SET DEFAULT nextval('validated_roas_id_seq'::regclass);


--
-- Name: validated_roas_verified_announcements id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY validated_roas_verified_announcements ALTER COLUMN id SET DEFAULT nextval('validated_roas_verified_announcements_id_seq'::regclass);


--
-- Name: verified_announcements id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY verified_announcements ALTER COLUMN id SET DEFAULT nextval('verified_announcements_id_seq'::regclass);


--
-- Name: watched_announcements id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY watched_announcements ALTER COLUMN id SET DEFAULT nextval('watched_announcements_id_seq'::regclass);


--
-- Name: watched_prefixes id; Type: DEFAULT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY watched_prefixes ALTER COLUMN id SET DEFAULT nextval('watched_prefixes_id_seq'::regclass);


--
-- Name: announcements announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (id);


--
-- Name: archive_snapshot_times archive_snapshot_times_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY archive_snapshot_times
    ADD CONSTRAINT archive_snapshot_times_pkey PRIMARY KEY (id);


--
-- Name: archived_conflicts archived_conflicts_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY archived_conflicts
    ADD CONSTRAINT archived_conflicts_pkey PRIMARY KEY (id);


--
-- Name: archived_resolutions archived_resolutions_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY archived_resolutions
    ADD CONSTRAINT archived_resolutions_pkey PRIMARY KEY (id);


--
-- Name: validated_roas_verified_announcements conflict_con; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY validated_roas_verified_announcements
    ADD CONSTRAINT conflict_con UNIQUE (announcement_id, validated_roa_id, route_validity);


--
-- Name: validated_roas conflict_test; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY validated_roas
    ADD CONSTRAINT conflict_test UNIQUE (asn, prefix, max_length);


--
-- Name: conflicts_test conflicts_test_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY conflicts_test
    ADD CONSTRAINT conflicts_test_pkey PRIMARY KEY (id);


--
-- Name: archived_conflicts constraintname; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY archived_conflicts
    ADD CONSTRAINT constraintname UNIQUE (prefix, reason);


--
-- Name: custom_announcements custom_announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY custom_announcements
    ADD CONSTRAINT custom_announcements_pkey PRIMARY KEY (id);


--
-- Name: global_announcements global_announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY global_announcements
    ADD CONSTRAINT global_announcements_pkey PRIMARY KEY (id);


--
-- Name: local_announcements local_announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY local_announcements
    ADD CONSTRAINT local_announcements_pkey PRIMARY KEY (id);


--
-- Name: local_conflicts local_conflicts_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY local_conflicts
    ADD CONSTRAINT local_conflicts_pkey PRIMARY KEY (id);


--
-- Name: netflows netflows_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY netflows
    ADD CONSTRAINT netflows_pkey PRIMARY KEY (id);


--
-- Name: payload_roas payload_con; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY payload_roas
    ADD CONSTRAINT payload_con UNIQUE (asn, prefix, max_length);


--
-- Name: payload_roas payload_roas_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY payload_roas
    ADD CONSTRAINT payload_roas_pkey PRIMARY KEY (id);


--
-- Name: rpki_validated_roas rpki_validated_roas_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY rpki_validated_roas
    ADD CONSTRAINT rpki_validated_roas_pkey PRIMARY KEY (id);


--
-- Name: rtr_status_entries rtr_status_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY rtr_status_entries
    ADD CONSTRAINT rtr_status_entries_pkey PRIMARY KEY (id);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: test_table test_table_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY test_table
    ADD CONSTRAINT test_table_pkey PRIMARY KEY (id);


--
-- Name: timeline_conflicts timeline_conflicts_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY timeline_conflicts
    ADD CONSTRAINT timeline_conflicts_pkey PRIMARY KEY (id);


--
-- Name: trust_anchors trust_anchors_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY trust_anchors
    ADD CONSTRAINT trust_anchors_pkey PRIMARY KEY (id);


--
-- Name: announcements uniq_key; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY announcements
    ADD CONSTRAINT uniq_key UNIQUE (asn, prefix);


--
-- Name: local_announcements uniq_pair; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY local_announcements
    ADD CONSTRAINT uniq_pair UNIQUE (asn, prefix);


--
-- Name: user_announcements user_announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY user_announcements
    ADD CONSTRAINT user_announcements_pkey PRIMARY KEY (id);


--
-- Name: user_prefixes user_prefixes_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY user_prefixes
    ADD CONSTRAINT user_prefixes_pkey PRIMARY KEY (id);


--
-- Name: validated_roas validated_roas_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY validated_roas
    ADD CONSTRAINT validated_roas_pkey PRIMARY KEY (id);


--
-- Name: validated_roas_verified_announcements validated_roas_verified_announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY validated_roas_verified_announcements
    ADD CONSTRAINT validated_roas_verified_announcements_pkey PRIMARY KEY (id);


--
-- Name: verified_announcements verified_announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY verified_announcements
    ADD CONSTRAINT verified_announcements_pkey PRIMARY KEY (id);


--
-- Name: watched_announcements watched_announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY watched_announcements
    ADD CONSTRAINT watched_announcements_pkey PRIMARY KEY (id);


--
-- Name: watched_prefixes watched_prefixes_pkey; Type: CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY watched_prefixes
    ADD CONSTRAINT watched_prefixes_pkey PRIMARY KEY (id);


--
-- Name: idx_announcements_prefix; Type: INDEX; Schema: public; Owner: svt1
--

CREATE INDEX idx_announcements_prefix ON announcements USING btree (prefix);


--
-- Name: idx_trust_anchors_ca_name; Type: INDEX; Schema: public; Owner: svt1
--

CREATE INDEX idx_trust_anchors_ca_name ON trust_anchors USING btree (ca_name);


--
-- Name: idx_validated_roas_prefix; Type: INDEX; Schema: public; Owner: svt1
--

CREATE INDEX idx_validated_roas_prefix ON validated_roas USING btree (prefix);


--
-- Name: idx_verified_announcements; Type: INDEX; Schema: public; Owner: svt1
--

CREATE INDEX idx_verified_announcements ON verified_announcements USING btree (announcement_id);


--
-- Name: trust_anchors set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON trust_anchors FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: validated_roas set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON validated_roas FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: announcements set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON announcements FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: settings set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON settings FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: netflows set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON netflows FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: verified_announcements set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON verified_announcements FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: archived_conflicts set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON archived_conflicts FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: archive_snapshot_times set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON archive_snapshot_times FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: archived_resolutions set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON archived_resolutions FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: conflicts_test set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON conflicts_test FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: local_announcements set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON local_announcements FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: local_conflicts set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON local_conflicts FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: validated_roas_verified_announcements set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON validated_roas_verified_announcements FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: watched_prefixes set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON watched_prefixes FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: watched_announcements set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON watched_announcements FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: user_announcements set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON user_announcements FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: rtr_status_entries set_timestamp; Type: TRIGGER; Schema: public; Owner: svt1
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON rtr_status_entries FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: conflicts_test conflicts_test_validated_roa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY conflicts_test
    ADD CONSTRAINT conflicts_test_validated_roa_id_fkey FOREIGN KEY (validated_roa_id) REFERENCES validated_roas(id);


--
-- Name: conflicts_test conflicts_test_verified_announcement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY conflicts_test
    ADD CONSTRAINT conflicts_test_verified_announcement_id_fkey FOREIGN KEY (verified_announcement_id) REFERENCES verified_announcements(id);


--
-- Name: user_announcements fk_announcement_id; Type: FK CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY user_announcements
    ADD CONSTRAINT fk_announcement_id FOREIGN KEY (announcement_id) REFERENCES announcements(id);


--
-- Name: watched_announcements fk_announcement_id; Type: FK CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY watched_announcements
    ADD CONSTRAINT fk_announcement_id FOREIGN KEY (announcement_id) REFERENCES announcements(id);


--
-- Name: local_conflicts local_conflicts_local_announcement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY local_conflicts
    ADD CONSTRAINT local_conflicts_local_announcement_id_fkey FOREIGN KEY (local_announcement_id) REFERENCES local_announcements(id);


--
-- Name: validated_roas validated_roas_trust_anchor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY validated_roas
    ADD CONSTRAINT validated_roas_trust_anchor_id_fkey FOREIGN KEY (trust_anchor_id) REFERENCES trust_anchors(id);


--
-- Name: rpki_validated_roas validated_roas_trust_anchor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY rpki_validated_roas
    ADD CONSTRAINT validated_roas_trust_anchor_id_fkey FOREIGN KEY (trust_anchor_id) REFERENCES trust_anchors(id);


--
-- Name: validated_roas_verified_announcements validated_roas_verified_announcements_announcement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY validated_roas_verified_announcements
    ADD CONSTRAINT validated_roas_verified_announcements_announcement_id_fkey FOREIGN KEY (announcement_id) REFERENCES announcements(id);


--
-- Name: validated_roas_verified_announcements validated_roas_verified_announcements_validated_roa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY validated_roas_verified_announcements
    ADD CONSTRAINT validated_roas_verified_announcements_validated_roa_id_fkey FOREIGN KEY (validated_roa_id) REFERENCES validated_roas(id);


--
-- Name: verified_announcements verified_announcements_announcement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svt1
--

ALTER TABLE ONLY verified_announcements
    ADD CONSTRAINT verified_announcements_announcement_id_fkey FOREIGN KEY (announcement_id) REFERENCES announcements(id);


--
-- Name: announcements; Type: ACL; Schema: public; Owner: svt1
--

GRANT ALL ON TABLE announcements TO tomas;


--
-- Name: announcements_id_seq; Type: ACL; Schema: public; Owner: svt1
--

GRANT ALL ON SEQUENCE announcements_id_seq TO tomas;


--
-- Name: validated_roas; Type: ACL; Schema: public; Owner: svt1
--

GRANT ALL ON TABLE validated_roas TO tomas;


--
-- Name: validated_roas_id_seq; Type: ACL; Schema: public; Owner: svt1
--

GRANT ALL ON SEQUENCE validated_roas_id_seq TO tomas;


--
-- Name: netflows; Type: ACL; Schema: public; Owner: svt1
--

GRANT ALL ON TABLE netflows TO tomas;


--
-- Name: netflows_id_seq; Type: ACL; Schema: public; Owner: svt1
--

GRANT ALL ON SEQUENCE netflows_id_seq TO tomas;


--
-- Name: settings; Type: ACL; Schema: public; Owner: svt1
--

GRANT ALL ON TABLE settings TO tomas;


--
-- Name: settings_id_seq; Type: ACL; Schema: public; Owner: svt1
--

GRANT ALL ON SEQUENCE settings_id_seq TO tomas;


--
-- Name: trust_anchors; Type: ACL; Schema: public; Owner: svt1
--

GRANT ALL ON TABLE trust_anchors TO tomas;


--
-- Name: trust_anchors_id_seq; Type: ACL; Schema: public; Owner: svt1
--

GRANT ALL ON SEQUENCE trust_anchors_id_seq TO tomas;


--
-- Name: verified_announcements; Type: ACL; Schema: public; Owner: svt1
--

GRANT ALL ON TABLE verified_announcements TO tomas;


--
-- Name: verified_announcements_id_seq; Type: ACL; Schema: public; Owner: svt1
--

GRANT ALL ON SEQUENCE verified_announcements_id_seq TO tomas;


--
-- PostgreSQL database dump complete
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.6
-- Dumped by pg_dump version 9.6.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

--
-- Data for Name: trust_anchors; Type: TABLE DATA; Schema: public; Owner: svt1
--

COPY trust_anchors (id, ca_name, certification_location, created_at, updated_at) FROM stdin;
5	APNIC from IANA RPKI Root	rsync://rpki.apnic.net/repository/apnic-rpki-root-iana-origin.cer	2017-12-20 12:28:36.247512	2017-12-20 12:28:36.247512
6	AfriNIC RPKI Root	rsync://rpki.afrinic.net/repository/AfriNIC.cer	2017-12-20 12:28:36.336274	2017-12-20 12:28:36.336274
7	LACNIC RPKI Root	rsync://repository.lacnic.net/rpki/lacnic/rta-lacnic-rpki.cer	2017-12-20 12:28:36.346221	2017-12-20 12:28:36.346221
8	RIPE NCC RPKI Root	rsync://rpki.ripe.net/ta/ripe-ncc-ta.cer	2017-12-20 12:28:36.382146	2017-12-20 12:28:36.382146
\.


--
-- Name: trust_anchors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svt1
--

SELECT pg_catalog.setval('trust_anchors_id_seq', 8, true);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.6
-- Dumped by pg_dump version 9.6.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: svt1
--

COPY settings (id, key, value, created_at, updated_at) FROM stdin;
4	conflictHandler.thresholdDays	0	2018-01-04 20:57:04.062513	2018-01-04 20:57:04.062513
3	conflictHandler.heuristic	1	2018-01-04 20:57:04.051515	2018-01-08 12:46:35.881838
\.


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svt1
--

SELECT pg_catalog.setval('settings_id_seq', 4, true);


--
-- PostgreSQL database dump complete
--

