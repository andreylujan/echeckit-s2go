--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE ar_internal_metadata (
    key integer NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO echeckit;

--
-- Name: ar_internal_metadata_key_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE ar_internal_metadata_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ar_internal_metadata_key_seq OWNER TO echeckit;

--
-- Name: ar_internal_metadata_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE ar_internal_metadata_key_seq OWNED BY ar_internal_metadata.key;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name text NOT NULL,
    organization_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO echeckit;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO echeckit;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: data_parts; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE data_parts (
    id integer NOT NULL,
    subsection_id integer,
    type text NOT NULL,
    name text NOT NULL,
    icon text,
    required boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ancestry character varying,
    max_images integer,
    max_length integer,
    data json,
    "position" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.data_parts OWNER TO echeckit;

--
-- Name: data_parts_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE data_parts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_parts_id_seq OWNER TO echeckit;

--
-- Name: data_parts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE data_parts_id_seq OWNED BY data_parts.id;


--
-- Name: dealers; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE dealers (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    contact text,
    phone_number text,
    address text
);


ALTER TABLE public.dealers OWNER TO echeckit;

--
-- Name: dealers_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE dealers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dealers_id_seq OWNER TO echeckit;

--
-- Name: dealers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE dealers_id_seq OWNED BY dealers.id;


--
-- Name: dealers_zones; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE dealers_zones (
    dealer_id integer,
    zone_id integer
);


ALTER TABLE public.dealers_zones OWNER TO echeckit;

--
-- Name: images; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE images (
    id integer NOT NULL,
    image text,
    data_part_id integer,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    category_id integer
);


ALTER TABLE public.images OWNER TO echeckit;

--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_id_seq OWNER TO echeckit;

--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE images_id_seq OWNED BY images.id;


--
-- Name: invitations; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE invitations (
    id integer NOT NULL,
    role_id integer NOT NULL,
    confirmation_token text NOT NULL,
    email text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    accepted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.invitations OWNER TO echeckit;

--
-- Name: invitations_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invitations_id_seq OWNER TO echeckit;

--
-- Name: invitations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE invitations_id_seq OWNED BY invitations.id;


--
-- Name: oauth_access_grants; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE oauth_access_grants (
    id integer NOT NULL,
    resource_owner_id integer NOT NULL,
    application_id integer NOT NULL,
    token character varying NOT NULL,
    expires_in integer NOT NULL,
    redirect_uri text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    scopes character varying
);


ALTER TABLE public.oauth_access_grants OWNER TO echeckit;

--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE oauth_access_grants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_access_grants_id_seq OWNER TO echeckit;

--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE oauth_access_grants_id_seq OWNED BY oauth_access_grants.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE oauth_access_tokens (
    id integer NOT NULL,
    resource_owner_id integer,
    application_id integer,
    token character varying NOT NULL,
    refresh_token character varying,
    expires_in integer,
    revoked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    scopes character varying
);


ALTER TABLE public.oauth_access_tokens OWNER TO echeckit;

--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE oauth_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_access_tokens_id_seq OWNER TO echeckit;

--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE oauth_access_tokens_id_seq OWNED BY oauth_access_tokens.id;


--
-- Name: oauth_applications; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE oauth_applications (
    id integer NOT NULL,
    name character varying NOT NULL,
    uid character varying NOT NULL,
    secret character varying NOT NULL,
    redirect_uri text NOT NULL,
    scopes character varying DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.oauth_applications OWNER TO echeckit;

--
-- Name: oauth_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE oauth_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_applications_id_seq OWNER TO echeckit;

--
-- Name: oauth_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE oauth_applications_id_seq OWNED BY oauth_applications.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE organizations (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.organizations OWNER TO echeckit;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organizations_id_seq OWNER TO echeckit;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;


--
-- Name: platforms; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE platforms (
    id integer NOT NULL,
    name text NOT NULL,
    organization_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.platforms OWNER TO echeckit;

--
-- Name: platforms_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE platforms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.platforms_id_seq OWNER TO echeckit;

--
-- Name: platforms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE platforms_id_seq OWNED BY platforms.id;


--
-- Name: platforms_top_list_items; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE platforms_top_list_items (
    platform_id integer,
    top_list_item_id integer
);


ALTER TABLE public.platforms_top_list_items OWNER TO echeckit;

--
-- Name: regions; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE regions (
    id integer NOT NULL,
    name text NOT NULL,
    ordinal integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.regions OWNER TO echeckit;

--
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regions_id_seq OWNER TO echeckit;

--
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE regions_id_seq OWNED BY regions.id;


--
-- Name: report_types; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE report_types (
    id integer NOT NULL,
    name text,
    organization_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.report_types OWNER TO echeckit;

--
-- Name: report_types_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE report_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_types_id_seq OWNER TO echeckit;

--
-- Name: report_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE report_types_id_seq OWNED BY report_types.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE reports (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    report_type_id integer NOT NULL,
    dynamic_attributes json DEFAULT '{}'::json NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    creator_id integer NOT NULL,
    limit_date timestamp without time zone,
    finished boolean,
    assigned_user_id integer
);


ALTER TABLE public.reports OWNER TO echeckit;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reports_id_seq OWNER TO echeckit;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE reports_id_seq OWNED BY reports.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.roles OWNER TO echeckit;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO echeckit;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO echeckit;

--
-- Name: section_types; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE section_types (
    id integer NOT NULL,
    name text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.section_types OWNER TO echeckit;

--
-- Name: section_types_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE section_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.section_types_id_seq OWNER TO echeckit;

--
-- Name: section_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE section_types_id_seq OWNED BY section_types.id;


--
-- Name: sections; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE sections (
    id integer NOT NULL,
    "position" integer,
    name text,
    organization_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    section_type_id integer NOT NULL
);


ALTER TABLE public.sections OWNER TO echeckit;

--
-- Name: sections_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sections_id_seq OWNER TO echeckit;

--
-- Name: sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE sections_id_seq OWNED BY sections.id;


--
-- Name: stores; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE stores (
    id integer NOT NULL,
    name text NOT NULL,
    dealer_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    zone_id integer NOT NULL,
    contact text,
    phone_number text,
    address text
);


ALTER TABLE public.stores OWNER TO echeckit;

--
-- Name: stores_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE stores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stores_id_seq OWNER TO echeckit;

--
-- Name: stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE stores_id_seq OWNED BY stores.id;


--
-- Name: subsection_item_types; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE subsection_item_types (
    id integer NOT NULL,
    name text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.subsection_item_types OWNER TO echeckit;

--
-- Name: subsection_item_types_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE subsection_item_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subsection_item_types_id_seq OWNER TO echeckit;

--
-- Name: subsection_item_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE subsection_item_types_id_seq OWNED BY subsection_item_types.id;


--
-- Name: subsection_items; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE subsection_items (
    id integer NOT NULL,
    subsection_item_type_id integer NOT NULL,
    subsection_id integer NOT NULL,
    has_details boolean NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.subsection_items OWNER TO echeckit;

--
-- Name: subsection_items_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE subsection_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subsection_items_id_seq OWNER TO echeckit;

--
-- Name: subsection_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE subsection_items_id_seq OWNED BY subsection_items.id;


--
-- Name: subsections; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE subsections (
    id integer NOT NULL,
    section_id integer,
    name text NOT NULL,
    icon text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.subsections OWNER TO echeckit;

--
-- Name: subsections_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE subsections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subsections_id_seq OWNER TO echeckit;

--
-- Name: subsections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE subsections_id_seq OWNED BY subsections.id;


--
-- Name: top_list_items; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE top_list_items (
    id integer NOT NULL,
    top_list_id integer,
    name text NOT NULL,
    images text[] DEFAULT '{}'::text[] NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.top_list_items OWNER TO echeckit;

--
-- Name: top_list_items_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE top_list_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.top_list_items_id_seq OWNER TO echeckit;

--
-- Name: top_list_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE top_list_items_id_seq OWNED BY top_list_items.id;


--
-- Name: top_lists; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE top_lists (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    name text,
    icon text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.top_lists OWNER TO echeckit;

--
-- Name: top_lists_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE top_lists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.top_lists_id_seq OWNER TO echeckit;

--
-- Name: top_lists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE top_lists_id_seq OWNED BY top_lists.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    rut text,
    first_name text,
    last_name text,
    phone_number text,
    address text,
    image text,
    role_id integer NOT NULL
);


ALTER TABLE public.users OWNER TO echeckit;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO echeckit;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: zones; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE zones (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    region_id integer NOT NULL
);


ALTER TABLE public.zones OWNER TO echeckit;

--
-- Name: zones_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE zones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zones_id_seq OWNER TO echeckit;

--
-- Name: zones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE zones_id_seq OWNED BY zones.id;


--
-- Name: key; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY ar_internal_metadata ALTER COLUMN key SET DEFAULT nextval('ar_internal_metadata_key_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY data_parts ALTER COLUMN id SET DEFAULT nextval('data_parts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY dealers ALTER COLUMN id SET DEFAULT nextval('dealers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY images ALTER COLUMN id SET DEFAULT nextval('images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY invitations ALTER COLUMN id SET DEFAULT nextval('invitations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY oauth_access_grants ALTER COLUMN id SET DEFAULT nextval('oauth_access_grants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY oauth_access_tokens ALTER COLUMN id SET DEFAULT nextval('oauth_access_tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY oauth_applications ALTER COLUMN id SET DEFAULT nextval('oauth_applications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY platforms ALTER COLUMN id SET DEFAULT nextval('platforms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY regions ALTER COLUMN id SET DEFAULT nextval('regions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY report_types ALTER COLUMN id SET DEFAULT nextval('report_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY reports ALTER COLUMN id SET DEFAULT nextval('reports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY section_types ALTER COLUMN id SET DEFAULT nextval('section_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY sections ALTER COLUMN id SET DEFAULT nextval('sections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY stores ALTER COLUMN id SET DEFAULT nextval('stores_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY subsection_item_types ALTER COLUMN id SET DEFAULT nextval('subsection_item_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY subsection_items ALTER COLUMN id SET DEFAULT nextval('subsection_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY subsections ALTER COLUMN id SET DEFAULT nextval('subsections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY top_list_items ALTER COLUMN id SET DEFAULT nextval('top_list_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY top_lists ALTER COLUMN id SET DEFAULT nextval('top_lists_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY zones ALTER COLUMN id SET DEFAULT nextval('zones_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
\.


--
-- Name: ar_internal_metadata_key_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('ar_internal_metadata_key_seq', 1, false);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY categories (id, name, organization_id, created_at, updated_at) FROM stdin;
1	Exhibiciones Playstation	1	2016-04-16 00:40:43.339057	2016-04-16 00:40:43.339057
2	Exhibiciones competencia promociones comunicadas	1	2016-04-16 00:40:43.344246	2016-04-16 00:40:43.344246
3	Best practice	1	2016-04-16 00:40:43.346826	2016-04-16 00:40:43.346826
4	Muebles y pilares	1	2016-04-16 00:40:43.34914	2016-04-16 00:40:43.34914
5	Activaciones	1	2016-04-16 00:40:43.351726	2016-04-16 00:40:43.351726
6	Productos más vendidos	1	2016-04-16 00:40:43.354134	2016-04-16 00:40:43.354134
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('categories_id_seq', 6, true);


--
-- Data for Name: data_parts; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY data_parts (id, subsection_id, type, name, icon, required, created_at, updated_at, ancestry, max_images, max_length, data, "position") FROM stdin;
13	4	Custom	Quiebre de Stock	\N	t	2016-04-15 22:31:28.211666	2016-04-15 23:16:15.643817	\N	\N	\N	{"companies":["Playstation","Nintendo","Xbox"],"type":"stock_break"}	3
1	1	Checklist	Protocolo	\N	t	2016-04-15 17:42:10.461723	2016-04-15 23:03:46.673051	\N	\N	\N	\N	0
2	1	Comment	Observación	\N	t	2016-04-15 17:42:10.469244	2016-04-15 23:03:46.678793	\N	\N	\N	\N	0
3	2	Checklist	Kit punto de venta	\N	t	2016-04-15 17:42:10.483137	2016-04-15 23:03:46.690222	\N	\N	\N	\N	0
4	2	Gallery	Fotos kit punto de venta	\N	t	2016-04-15 17:42:10.490415	2016-04-15 23:03:46.693363	\N	\N	\N	\N	0
5	\N	ChecklistItem	Limpieza y orden	\N	t	2016-04-15 17:42:10.522952	2016-04-15 23:03:46.696405	1	\N	\N	\N	0
6	\N	ChecklistItem	Encendido de interactivo	\N	t	2016-04-15 17:42:10.525578	2016-04-15 23:03:46.699564	1	\N	\N	\N	0
7	\N	ChecklistItem	Foco Visible	\N	t	2016-04-15 17:42:10.529164	2016-04-15 23:03:46.702524	3	\N	\N	\N	0
8	\N	ChecklistItem	Interactivo PS4	\N	t	2016-04-15 17:42:10.531593	2016-04-15 23:03:46.70543	3	\N	\N	\N	0
9	\N	ChecklistItem	Muebles PS4	\N	t	2016-04-15 17:42:10.53381	2016-04-15 23:03:46.708367	3	\N	\N	\N	0
12	4	Custom	Más vendidos	\N	t	2016-04-15 22:18:27.923577	2016-04-15 23:16:15.648643	\N	\N	\N	{"companies":["Playstation","Nintendo","Xbox"],"type":"top_sales"}	2
14	4	Custom	Acciones de Competencia	\N	t	2016-04-15 22:32:14.91753	2016-04-15 23:13:24.219779	\N	\N	\N	{"companies":["Playstation","Nintendo","Xbox"],"type":"competition"}	4
11	4	Custom	Stock	\N	t	2016-04-15 22:17:30.676276	2016-04-15 23:12:30.359618	\N	\N	\N	{"companies":["Playstation","Nintendo","Xbox"],"type":"stock"}	0
15	4	Custom	Venta	\N	t	2016-04-15 22:49:24.897771	2016-04-15 23:12:24.369667	\N	\N	\N	{"companies":["Playstation","Nintendo","Xbox"],"type":"sales"}	1
\.


--
-- Name: data_parts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('data_parts_id_seq', 15, true);


--
-- Data for Name: dealers; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY dealers (id, name, created_at, updated_at, contact, phone_number, address) FROM stdin;
1	Ripley	2016-04-15 17:42:10.362803	2016-04-15 17:42:10.362803	\N	\N	\N
2	Falabella	2016-04-15 17:42:10.365456	2016-04-15 17:42:10.365456	\N	\N	\N
3	Costanera Center	2016-04-15 17:42:10.367577	2016-04-15 17:42:10.367577	\N	\N	\N
\.


--
-- Name: dealers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('dealers_id_seq', 3, true);


--
-- Data for Name: dealers_zones; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY dealers_zones (dealer_id, zone_id) FROM stdin;
1	1
2	1
3	1
1	2
2	3
3	3
\.


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY images (id, image, data_part_id, user_id, created_at, updated_at, category_id) FROM stdin;
1	03438049b602d653d06f892d1991c60a.gif	\N	1	2016-04-16 00:54:45.252033	2016-04-16 00:54:45.252033	1
2	03438049b602d653d06f892d1991c60a.gif	\N	1	2016-04-16 00:58:23.552014	2016-04-16 00:58:23.552014	1
3	03438049b602d653d06f892d1991c60a.gif	\N	1	2016-04-16 01:13:44.174788	2016-04-16 01:13:44.174788	1
4	03438049b602d653d06f892d1991c60a.gif	\N	1	2016-04-16 01:14:02.905589	2016-04-16 01:14:02.905589	1
5	03438049b602d653d06f892d1991c60a.gif	\N	1	2016-04-16 01:37:29.1825	2016-04-16 01:37:29.1825	1
6	03438049b602d653d06f892d1991c60a.gif	\N	1	2016-04-16 01:37:37.489151	2016-04-16 01:37:37.489151	1
7	03438049b602d653d06f892d1991c60a.gif	\N	3	2016-04-18 15:02:31.904277	2016-04-18 15:02:31.904277	1
8	03438049b602d653d06f892d1991c60a.gif	\N	3	2016-04-18 23:15:49.921888	2016-04-18 23:15:49.921888	1
\.


--
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('images_id_seq', 8, true);


--
-- Data for Name: invitations; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY invitations (id, role_id, confirmation_token, email, created_at, updated_at, accepted) FROM stdin;
2	1	DxZP34rJaAZeTJf0Tr_4AAhE6MK6ozmVhp6_vDLXjckR66DhY32v03W8uM5e1fPtVNaArCUu9GvFHtev9vEI1g	plluch@ewin.cl	2016-04-19 15:44:35.139074	2016-04-19 15:44:35.139074	f
6	2	2dT50qR5jh4Bw0aSw5LZWYc0dpJc12PovSjKNOAOL2zV0OermDXVbA7Xkje1D2D5IE3-9Rv0byeKkHeAG0Wc-A	ncanto@ewin.cl	2016-04-19 16:11:44.264023	2016-04-19 16:11:44.264023	f
9	1	aXnQFo-E2k79u125ZCkxAlLGdZFtklTfrd52EBtJ73mKxJqGe6NsSS9PqfKkNODg-ZbM_Z7j5zI3Uibk7DoqPg	alvaro.mc2@gmail.com	2016-04-19 20:48:30.167672	2016-04-19 20:48:56.400982	t
\.


--
-- Name: invitations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('invitations_id_seq', 9, true);


--
-- Data for Name: oauth_access_grants; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY oauth_access_grants (id, resource_owner_id, application_id, token, expires_in, redirect_uri, created_at, revoked_at, scopes) FROM stdin;
\.


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('oauth_access_grants_id_seq', 1, false);


--
-- Data for Name: oauth_access_tokens; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY oauth_access_tokens (id, resource_owner_id, application_id, token, refresh_token, expires_in, revoked_at, created_at, scopes) FROM stdin;
1	1	\N	dda3d132faad2502c28b1d9ba2535038b4a726cbd8268f10fb250bc6c197fefd	d4be6e229fc62a2153ab125541429c57570ad29f3f2c54309138de2636f95532	7200	\N	2016-04-15 17:43:49.54345	user
2	3	\N	0944e6f361e10132442c167b49895de78106438b78554b9584d5199345cbc946	7ae299bc66471203298cdd5858d9f26f7cc7662bef7b05f357e45f4001811658	7200	\N	2016-04-15 17:44:01.957344	user
3	3	\N	c1051aa4fcdb9c13794eb715c972ff1646e93e41350ec3a36a718a9fab4ec6df	aceb243dce9c02640b819ff2d5ead18f67ee0eaf3c72a16aac1ff9d88be5e2c7	7200	\N	2016-04-15 17:47:04.466374	user
4	3	\N	f5d06cea3e9e6f2019834bc81c6bc5735f96f62e07fd8e1b419b796e6528edc2	c8e07af17c366b2bdb8668b18a64d03d74913641ae8f3fa49dec7b9c8fdac44a	7200	\N	2016-04-15 18:01:42.122338	user
5	1	\N	ef0ad67dd7fe59849075acb814d075b1d2bc243b8fadb8aa9c435f1130cdced6	4c0afece8df087c9d0eecdddc074e3f5305463e4649077ce808d397aeb6543e0	7200	\N	2016-04-15 18:18:59.138505	user
6	3	\N	bb5edc44f522d5bfb01101ca525e08aae59e32be491dac6ccdcedafa905afbfc	03ff6e335dfe22beee241d8f28dd96e21270967b47bcebc90615b422f755996a	7200	\N	2016-04-15 18:22:47.218746	user
7	3	\N	0a4e04acbcdf9e49e7c510fb11f1f303c0feecc52d9614a740a3a04bec79ddd7	6e067ce44a637d17090e5b296576797e16d3906d1bb132c2db4bfa0c892924a0	7200	\N	2016-04-15 18:27:27.21323	user
8	3	\N	108df968c0a49ea8ad2f131b85289cb1e601fe4bd4eb3fc28327e9db71c3b88c	95f5eb550de777c6f24cfb4b8a7e5168d9233a4af5152710438d07689b32afec	7200	\N	2016-04-15 18:33:09.130864	user
9	1	\N	601e19ae0d3224def51a338e8e0642666b1f2715ccc6085ac2c0a70fd48f16ca	6a56034b28dc57239d3a8fc8685d78c082dc32c5e5c867ceaec49ef5ac2aa0c1	7200	\N	2016-04-15 18:34:47.740871	user
10	3	\N	3bdca3df944d7bdf89c7eb1ea0142b215c1023d907bdd1d6c8f9ef186cc6f59b	8aa5f0c43c422f6254ac927076a3dd9dc4ec1242fb9326ec2bb31cdaa3b348d4	7200	\N	2016-04-15 18:35:39.633567	user
11	1	\N	15ee0e4264f4409ed8a33bab81eacb3dab92f84b4495be2595fbee9074017747	22877b7c7c1d144c452f7e0a479b502314837b25fce851c1e6126690e5f391df	7200	\N	2016-04-15 18:53:06.454832	user
12	1	\N	934c38fa9a8f83dc6d252e7a0a0f6d3d0dbddaf8fa60d2f6106319ffbeef3b54	746da7bed0fe88b9a325f4fe3ef2c6332ad7c7aec4dada04d66c3d0e65c6d421	7200	\N	2016-04-15 20:08:06.827614	user
13	1	\N	472f33636aead507b2cbd53398d128d7bcbebe8523bc8524e682e6d7cb015a4d	820ea26e55c8af537b8cd83ce48b1b6e031f7eb4dad907bf6aeaf011e9a6cc3f	7200	\N	2016-04-15 20:20:38.370616	user
14	1	\N	b650bf34c8733a32503416701a446371c139881870a1f142818750e85c0d0ba0	e93288b28e80b077a467245dc23ba9e38817e5cf15e6f679bdc76e625caa5bc4	7200	\N	2016-04-15 20:26:22.557059	user
15	1	\N	073f4faca492ae2c19b487ac6d787c4556f9f6e20761df61b8fcb7a4bd66a492	ed1f8ac7ab70776e6cf9611c43d50169a513fc07e066154b3a5f6da364acd7f2	7200	\N	2016-04-15 20:34:47.336207	user
16	1	\N	08322660f31d253d2dddf585d81ce087ba32bece72b0a8063b35528738d983c4	07b645b83551a2ec6029ec214212fd8fc524014263b7d1294b8ec59a6258a43a	7200	\N	2016-04-15 20:35:55.829403	user
17	1	\N	e5e94da8c43f030865ba969910e7aaff6ee12e722a976cfcf2bb0f7b7f3063f0	584967bf8762f8cb449214536dfef47afc2d1b8684cacdf7a65f057ea377a234	7200	\N	2016-04-15 20:36:29.015968	user
18	1	\N	b77fb0fb3ecba691d077c29ac196a8bbd0d6648bdf9bcaf53de3759ee815427a	53208608f7a0a491b6ee42737d12cf2993f35fb33b11f39b56fdfdd4a98b7d9c	7200	\N	2016-04-15 20:38:44.319842	user
19	1	\N	7aeab59983a8116bd9b5af2fdb9508919b9b756760356907744584ced31b1498	a85d2aea18dc7e3ca83ffdeb07090430b0fcd6d3a4077f32743322fec5f94c34	7200	\N	2016-04-15 20:47:09.257022	user
20	1	\N	705a0e924dd8a442932b1bfe88feb368447b0589add93196766db60ee2f7d8c4	8391bf75d2060316f4938c9eb1fab78c56eb18933b7066ae9de02fec87c7251c	7200	\N	2016-04-15 21:28:05.909518	user
21	1	\N	001e353c568fbc54c352dcf143f728e1657f80229f71f27ce6bd0379b433505c	df7ab4c9dec70a1a989585ff9a9a17e0ff1dd2f184a6a6cff979f328858352de	7200	\N	2016-04-15 21:58:27.232021	user
22	1	\N	a69ece81b4a4e87c8aa8193294ac96946cdc164fb5b7159a9803575ed8646430	c3a9a7e03bd2d802b39642a460f37a4419b32ea0ca574c7ad089b1c93cc9d7b5	7200	\N	2016-04-16 00:54:38.476373	user
23	1	\N	efa95b8ceae26c4dd58ed32ea85a11da39dc093dd9a9824f75ff56f75d40ab5b	3ca060048b9c7b2b8120099cec142406089e7bd3f6c0137042b363744bb764df	7200	\N	2016-04-16 01:13:35.4969	user
24	3	\N	1a57026c13d0ef8674992d098cb13a7aaa7f02328d97ab5a05e0cada9fdfc7f6	44828d9d962a8b856183b8d3b142a7e5e0f250ff3e9b85490fb1413b40518ce8	7200	\N	2016-04-16 14:29:38.127995	user
25	3	\N	47e29db61c9a04ffed7946220de37d231344871bef02261e817eecdd6ef547bd	66e850444c8f8962f6b96717ec2e9bbbcd35efaa85e517cc387e5d3ad0613612	7200	\N	2016-04-16 14:38:42.950668	user
26	3	\N	d427dc72db042fa59cddcee79de73d6435cbe12534c88d8af488381538fc91a6	fcea0581f62b3593157308787e57ebf76fefbc98d23017fde6aba5847dd2aa9f	7200	\N	2016-04-16 14:45:36.81149	user
27	3	\N	99ca5ee6c1c5cafa90624bd6e9124359687c0b95c4021bb8f46762937febd36c	2f9bc15b8f787826ea36d7b004d4864b2993fc5f2720a9cf8576e78ffb8bf6d9	7200	\N	2016-04-16 14:51:49.771818	user
28	3	\N	4a60436a2208b4dff1975b385b0182f059e9bcdfac2ed29ded4d5c8a5f47c572	90a3a62055210bbde29cd3096f1e5afc3f259470347a0786ace388dad704f7c8	7200	\N	2016-04-16 15:24:39.309723	user
29	3	\N	ba64371a2245e7be142175a09521b50230ea39700d6ca14a6275be1316480a2b	735acdac92c6f872fadef6b5b731a2598965bf14eaacf1722f9df5024c8a8672	7200	\N	2016-04-16 15:28:16.642402	user
30	3	\N	181b3dc5231e6b8d79c914cbaf1ca3f2a15665f1863d3890f9bb0e1707d0664b	cce83c7d72f17ce11e4a67d883a97096045861da788252c56d4fbc609d147e34	7200	\N	2016-04-16 15:33:12.719612	user
31	3	\N	c7485f59c1843ffeefafa68f4d5659876d7863f7220b328dcaea3f0862f97315	c0c1c0c1e5a03aa6b60c5ca95993a8e0c79617862abc3deb70c9b04ac81a32ec	7200	\N	2016-04-16 15:46:16.530502	user
32	3	\N	d389c8dce7e6b116b8c3aaf295dd961d5eccf8495b195f0176b7f189c70367c0	37613c9f91bf2161ed27557f051ee75a469989fa42e91736424b137bedcc557c	7200	\N	2016-04-16 15:49:29.46456	user
33	3	\N	a9cbe02131549ba13e76df034875df5747e5ed07ee93b82a302e60bfa943f82e	5e9db3325c7adb78e76a11f0fef5487d148506a6e4f5ca4594f1b52cbbaded8a	7200	\N	2016-04-16 15:52:29.823922	user
34	3	\N	fcc1a6aec4ff16545504e4df29259a5cc4f1fb490829187b8abb1eae711763b7	0b08f09d807814ae501e0809d9b3923a11d6a4a395a7385293252fa945354900	7200	\N	2016-04-16 15:59:59.959888	user
35	3	\N	1377d9d0acd06942ea0c685b151d3f3839fbdd5ba5519fda0463f4651e418491	2b4c287a26ffb33f4af7c01a7d88411046eaa453400db5bc59bacd8ca8dd278f	7200	\N	2016-04-16 16:24:12.548309	user
36	3	\N	e5e84970ba9d9aec9b9c65a07a3f2cea06d3cc7437c626844ae1bcd2d41659dc	4802d38f29288ece3b880a70257e0511a5aaccc0f011e5b43f1a82848e2be23a	7200	\N	2016-04-16 16:33:06.139825	user
37	3	\N	9506ea37cb97cfcabdff36210d6f238dbfda8aa199cedd2722a192396844af03	d0e7e0de0d9ec1ee20ec13bc1ad3c1365d5b4f36a2f1fa1e2fef8f1d0496c8d9	7200	\N	2016-04-16 16:36:47.793038	user
38	3	\N	946d780ead9549073d88636d041f39667c9c5989e14b8467deafeb701806f498	4ba093c8ad41ea3a431b91bcabde49e5e35b3c52863fb48f85fb3fe36c5068b0	7200	\N	2016-04-16 18:40:09.013001	user
39	3	\N	d7c0ed11b0a43ebaa4f93651c9cf9bf1912b44c47dcf311b8815c408412b9c96	4d340c6249e2f8f1e03bd6ab0bc13d34787809a0958a329097ea88ac4da006f3	7200	\N	2016-04-16 18:53:46.526406	user
40	3	\N	b943684cf5a9d819768244135fb31520204f82b07fb453d548668c2a269f014c	a8733e655607032559f9d7f5c474d9d60d08b241958b7069205454e3782ceed2	7200	\N	2016-04-16 19:02:28.808805	user
41	3	\N	08fd16e8bcc374e2d152853b569e4cff054abae45660529145700c4e5058db51	a27e672469652ee4deb00c0eca29c4558685538204a6fd2f0f337cfbc0dab314	7200	\N	2016-04-16 19:08:01.577265	user
42	3	\N	d156dd44dd332cf1c8240ff88197307ba40da43d8c98a4948eb1fad65b380069	c460213baf1a817cd9765a8902cbde161bfa336ebaa70b85383a5e56dcc737b5	7200	\N	2016-04-16 19:12:16.336549	user
43	3	\N	8339945c191b2cf5602aa6c4391c04eb8433c391b5486341333ec04eb7222453	8a20400fb647a20388193e86895356ec8ec570528036b903fbe4226be8578d25	7200	\N	2016-04-16 19:18:48.82762	user
44	3	\N	f2e16c2a8964bd78cdeac1dca81e37006b065bbab3fcce2ea97868b147617227	aec2605549825d699d9d797a52559187508877383d70dbdf040fd958ce503e98	7200	\N	2016-04-16 19:23:05.125499	user
45	3	\N	b4e4f669a39e5a5ac979f2dd9afcbe62529d8ad8e334fb6d83a3b5d56acb8b1b	ee1ca0d9aa55a3216b9acab528819ead34e888804244864401b886877474fe95	7200	\N	2016-04-16 19:33:06.598975	user
46	3	\N	7bf153a743920d2f1039c8d7f34595a2db48d25a25f9534efd776feb96234171	7c96ce60724713062e23c95b4c2019bf68169bade78b0c6b2260192339f9c856	7200	\N	2016-04-16 19:35:56.816955	user
47	3	\N	1bcbc8040f2fb329c046d377dcd14eccd3b7d46c27a93591ed0b7160c6d99108	6cc46a177b631b31dac0da70f4969e9ea82e61b96abdeb05cb5de26135dbbd10	7200	\N	2016-04-16 19:40:44.138434	user
48	1	\N	30d86cd18ad3c90fc5f9402c09c24082856e333587ef22437ea550efaa5f20fd	f306aa2bef0e567bd269c615dec90bc9dd6bd4b611c28974c96ff0cbabb8b758	7200	\N	2016-04-18 13:36:39.704772	user
49	3	\N	b34025883e0ad2f5dd0a4f9713bc8ae02ef85700ebd1f023fc24684ea9303feb	a85e6a4d610b00346316e962a4c8eff73fd8b5e1575401578ad18ee612ff8cb0	7200	\N	2016-04-18 13:37:12.862908	user
50	1	\N	7293da44405e4e0bf8ed93613fbeffbdba2a7a6d6b3e7d33838875a046e79d0c	4ecdd7364d0e47ef5d0a7e3e027da1c0391c630b3fbdc17b666d5460c6eb925f	7200	\N	2016-04-18 13:37:45.869121	user
51	3	\N	9b905e82f9b1b61f2e5fb6c8da6ede48bb790868b4f19c4f270c65251031ee22	561fcb2ab061ee7ac1add75013246f5832dd5c4d0f6bbeafd816c159cf9ef28e	7200	\N	2016-04-18 14:35:56.230354	user
52	3	\N	60a0707b2aededce630d80a05583dd657cbcd557540e742a15f23b272b4bdeed	0c5fff52a49c3ab8f008ac40f6855382092f2f06a75826ee6545289e3c044c27	7200	\N	2016-04-18 14:36:17.042132	user
53	3	\N	4c093364ffb1f6b0d33c28dc41099a7b122dc69ca230421a905862bf88a56976	6727507d04347aec6ff8401503c6c6d12864aa9dd8408a8efdd785e7f819afc4	7200	\N	2016-04-18 14:40:54.168751	user
54	3	\N	f76febf9c07c82776a38fc3ae885b340d4b59efeefc8a3ca929df746a4a4df75	fa61da81aa3c7fcd0293793053d1f540f9f67dc7ad835dd1e884cefeefe1430d	7200	\N	2016-04-18 14:52:45.207637	user
55	1	\N	a868fbce04b47dd7f1b13b5236b804f7f81598d7334c1e85358d0cd22cdb7135	27b4e8124fbae65359067022e945eff020f448a0ae02dd55078aab88fea2c58f	7200	\N	2016-04-18 15:03:25.482745	user
56	3	\N	57d9e1524c35c1dbf3b9a830840c341e520dd4af3a80bf1d41c99a6c98777465	6a360e7dea4dbe9de29d3a18d9e01d221897e720ae994c44a7020ff7b2877919	7200	\N	2016-04-18 15:09:32.007612	user
57	3	\N	2da417a46d4e14951cc7b575205f23a2c4546e66dcb84cf66b5bdb2f9904f913	712748b71c9fabd617af71d3f8ab05d04ee81a91fb25b4dcd0ace2b5c797aa53	7200	\N	2016-04-18 15:13:19.251902	user
58	3	\N	efd5a2730d6ab9ac07854f1b513782a1fcf92eac96899523b96b91dff9698c65	f01bcd7227de8b3571a8ec7bd5693555f364349bbe3a5e55af6954e230b59bb1	7200	\N	2016-04-18 15:17:21.30141	user
59	3	\N	6f40038541d882699da7e2e40a6c692b3b4ce21984db6aa85d44ad4bdc57998b	3938544b0880809722f9e77ebffbefb7d39a026405cd3d5d9ac905f604103612	7200	\N	2016-04-18 15:44:41.751152	user
60	3	\N	294b550b354ff9733803cd905a14152aafe999c9d468146277cdd29d70b8e8e3	88e3cdb6b8b9061e9f8ccb48e0c6884cd9ec88e85c3dab0f719fee250d3fb75a	7200	\N	2016-04-18 15:48:42.039351	user
61	3	\N	d2337f53645e2357790a09b93cd3121841b599ac7b5a2641d1cf629a6d82e12d	5312b9cfbbea3dd736e1e99c8c40a4ac57c1d2bc3467fd7856c8561c32b65c83	7200	\N	2016-04-18 15:50:19.874957	user
62	3	\N	0d0a820215e01e2eaca147e5b29c4a84d34ddb777ebc7643d7a947591e96ac97	09fe0e57848e672417f0681420a90c698b8ac34260925273c7ed6f326fbdc7eb	7200	\N	2016-04-18 15:54:27.400237	user
63	3	\N	306cc5b9f6c58f2d259d30bd3f5b789686c20bc7106de6436128e5979ca1fda1	1fc01b639bc6846cda4e6c3158295ed71cff7cabd9813874412a3ff1208abe83	7200	\N	2016-04-18 16:06:08.744649	user
64	3	\N	841bb8ab4776b12542865af928c4b99c79247d3c7782fe8961b1fc7c6d6dcf5d	78e7497ab3e7a1355d268475cbb80c69f053453190c2e63031943c59bb97f3c3	7200	\N	2016-04-18 16:09:00.811994	user
65	3	\N	2df326f0a8365147418ae4cfe5e8da59a1dcf04e8cc07c621ac1fc2269ae3764	426008ec0522c8c7ac78d4641a480dd909998ae15392b60128c70e04f2005edc	7200	\N	2016-04-18 16:22:00.481394	user
66	3	\N	19a0ac53be520cff8f38c55543fd6d4afc552d56230ca8534443329279859e12	5afdf24cc935243d17a15617a5629d5d3f958546a59e4cf480bcbb96902f3190	7200	\N	2016-04-18 16:26:26.588003	user
67	3	\N	5880d37b264785fdef267be436b152b6eb8856f3b8664a32a3dbdd27f1a0979c	82be6afccef763fad9b305965c16c6c1aa47c4d1364f0b9338de2f20f30bc96e	7200	\N	2016-04-18 16:31:55.026244	user
68	3	\N	0c4804a5a77b6d92a5e6010998a005536617092b780038c12d7af0aa404fc3ef	76497444c1ccbe760ece011fd3b5daf9eabfcf4f7310d44e51e755e7553fd3fa	7200	\N	2016-04-18 16:33:53.496999	user
69	3	\N	89cd55ad7267b1630e14f408d98912f83363fb20f5b5d35a428f76c3a2c32cf3	7ac4faec935fa64fa86be5d462477e138cb129ad7b143e0bbb097acac5e47d7f	7200	\N	2016-04-18 16:35:45.41144	user
70	3	\N	bec7cff784e39890e83ba09dd13e14409748ccfac41389f2f5ed7cc14cfc9a74	edb16c8c2e510a43a7f22ff06e348c1be1d95ae7c90f0b9e962ff022417438c7	7200	\N	2016-04-18 16:36:16.982171	user
71	3	\N	1747f8b84ebd17dacd895368ef4707d3fe28409dd21f04a7295eb14b76eb3fd4	212179ffe54eb78164201bd9107e900a9e7cda9597a61e0a47efe3e4b214e036	7200	\N	2016-04-18 16:37:12.37693	user
72	1	\N	975c2b5c7463ce544101154fae3f434a84706ca7bac49f29ed0dc4ace6e83287	32806ba6f6a4d46f6f7fd6a62aaef6a44064440d0c993d1b2c211a055b5b83eb	7200	\N	2016-04-18 16:37:24.083892	user
73	1	\N	c47000c49d82b259d8c0a0fc208c861c9ee6677a173726ad50b9b05ba4408a0b	41d044d8d72abe2aca2190076cb4b55cdc33208afd82bb89e3c1cd24bbc2dbf0	7200	\N	2016-04-18 16:41:43.899294	user
74	3	\N	d7f7bc494bc3ba8502fa4c3cca50c1095f0e0445cb4a0f5bcc021fe45789e12c	faebad203603821a9e5bc4c783a4ef4de8d817be942ad8394453462df16835c5	7200	\N	2016-04-18 16:43:06.714188	user
75	1	\N	118da3101bda827a99ec58f28b12c9bf33ef1d0916c24f838860d0e719bb42fc	03421856dda2ef3376e237c6dc0d043574f91f910d329fd314a42bc7b86378af	7200	\N	2016-04-18 16:45:02.978068	user
76	1	\N	f416256612f9f9a7f32f114006e401541c06372834d957f3a39ddd4d2d22ce85	bddba37716889a8b543b3602b1bf48cdec8605a73b50226225672bc2e16a2706	7200	\N	2016-04-18 16:45:40.614833	user
77	1	\N	95ebfb15cc3d9be307382c74ad67ce2dcb43aa431b837d7268475f7734b70dfc	240fc3f5a86a9787f50891db2a9b30614c392f1572bb9e6910fd7a64d325fd40	7200	\N	2016-04-18 16:49:17.26717	user
78	1	\N	71b855b131fd5132fb076fc441cc13d366cb5ade6d90673a6a7352c30614dddb	8dcf43d5b042b511a430c9ffefff0220f2c1c643b7f684ca389a20d9c8d74c03	7200	\N	2016-04-18 16:49:39.037604	user
79	3	\N	b57553786c69c1100472c5cdf64740dea5a10a5856f76e8ddacda22c905367e8	e599e0a45fd55456440e343ccf63d5cf7e2ab6fe3faa296cd7643974d5e0b9a2	7200	\N	2016-04-18 16:59:56.843102	user
80	1	\N	672dc5f3972fa784a909ad51d259a379eda18a41937eb1808fcf3f13730aed66	ebbfa8232e7e17a3ae64b5b6307be4c24edf81d47da8e1756832cc7a57577a9f	7200	\N	2016-04-18 17:10:51.654489	user
81	1	\N	52b25d6679d88a8cc790cd9ac61d526e8495111eb43cea465f85588a1115f3a7	c6822b0757f409057719d4bb6ffdef73170ad82250a1d386572a547239903733	7200	\N	2016-04-18 17:14:32.976706	user
82	1	\N	261826c8dd55f800038c40937536b1ca830717f1ab1d044fa2dff5c9b845b122	223c8c656d058f7d176c6be8a9a118caa3cccff4198751e9f0957a5c05b30c43	7200	\N	2016-04-18 17:15:26.548223	user
83	1	\N	b1100871c8591cd000ce9c4f361a37252447a9ed26b2cdb920f3641e4f3cbf27	e6453c2e3ade5301dd76dfb6e8cf1aff9c8fc244ba552296a5957d04d62300da	7200	\N	2016-04-18 17:16:46.830355	user
84	1	\N	5e8705040eec201b5e41e20159404b596fad690b1937a951033aedbdee2d75ed	2eee3dd311683b1c4585ab99d62d9e0f6c0c4f95c1fa0c0dfee27e79c3550751	7200	\N	2016-04-18 17:20:13.78063	user
85	3	\N	f1247a626f607f62f0207007e45777b7c86d08e82e9feb0e03ae6163750f59a4	e1dd87a58621c08472017014ef16c2dd99455231fc9bd23dea326b1579bd4dff	7200	\N	2016-04-18 17:37:06.5676	user
86	3	\N	d1a4ab3d18e0f4d54720c004390b539533bed9d2903492b090522dbe6ab62669	8dba39b18c8aa4fcef873913e968aa53e87452aba8359552e92466c4c3ba8a72	7200	\N	2016-04-18 17:51:59.053229	user
87	3	\N	9b3bb4105b1b71e18c911f364fddd003b2100afdb2b50cc24cba928c8fac3b7c	e5f4e970563721a6c8a2d44da8c6e604623c73fa71c30cf4a08b33596ee71346	7200	\N	2016-04-18 17:54:53.100841	user
88	3	\N	f29d4aeb62d609cd03cbf51a275ff28d68ceeb0ef4dd46834c090a246e21b35e	646f55d5b50a3a968684acefa9e7442abede8012e609c75034fb3fa957d5ad36	7200	\N	2016-04-18 18:05:50.893024	user
89	3	\N	e3bcc9d7b69a927e355e04aa61426fa68633b5a1c204514d2a363456b5db4bee	a95e3978096f42c27ea50782f02a9231fe1945d9f1fb68d1b80ef2f80a6c0219	7200	\N	2016-04-18 18:09:26.681508	user
90	3	\N	0f37cb0eeccdd777d5093f39aa312f5923edfe6df3e765cec0183012bf0532ea	e84f3afa20a3aecdeeb00330dced5df94dc233d286e3a1000312f6816b235538	7200	\N	2016-04-18 18:15:18.779849	user
91	3	\N	a5a9b77f728ef8669062970ecae893914270a9e4812633351863cbada9b2b8d6	b4a2068e929ea49163a321d3235172ca236a7c84ead7445a664728c5823e8946	7200	\N	2016-04-18 18:18:20.82453	user
92	3	\N	be33afc9e3f6a056effc4fba8d974450272467fd460ff26bdc19ac88c625525e	ffdf1fda6ae8488b8c00d20f5bfc92ff8ca294e2e54f4e0e32e0784d5be49142	7200	\N	2016-04-18 19:01:56.19798	user
93	3	\N	c6e1d589f30f381fea6552687731a1dc81c33ec442a1cab650a67cea169e09db	076591ab3c7ab5805d8a8dda048feab58661730dae947902bd4f550932495b2f	7200	\N	2016-04-18 19:04:29.173969	user
94	3	\N	1ac138f249f576d38d33bba515dabe85887889d9f4fc650a69c7b77fd102c6c6	001e368f97ad007471e09eede87dc919319d35cbc3f3f3bb59d5b6134a83317c	7200	\N	2016-04-18 19:12:33.163435	user
95	3	\N	c9431ce96f923b79bc6f656f0e9131b94ec24ced73aaa2240c691864f25da5ad	7c92fc8db97afd53f4cfc0c720d646804ef9be393a56e0f14ec7d57be6b126de	7200	\N	2016-04-18 19:16:15.254795	user
96	3	\N	52d3e178906644a6b982285c02f74d004d0617be52154f0cf622fe9d796ee90c	b769c4b58ad059b7e047f5790d0a5b0e9e8a902407ee382ad4e8b25f054b434e	7200	\N	2016-04-18 19:24:24.558833	user
97	3	\N	4b952f0f72c796f002bd24f394fec498ed4f1c7c5589ae7743b1d650072f11fa	fcd597b39e994332d6705e97010bacccd03e9edddbba02f412549899b4f9d582	7200	\N	2016-04-18 19:38:40.391552	user
98	3	\N	dd13d6f9a6fcd3861a68b77a48dbe21c1d107d30a00e7dd612940d0042efeb3c	b57849cccea844834aacf111b18076ebdd1ba96b5132c81b8e8efc81f56c21c6	7200	\N	2016-04-18 20:08:40.220942	user
99	3	\N	6f29d46d61f60774d455e489127faa99c87607c21ea5e1db126bd5611399860c	e178676814075334bda3ca1b24cbdb6459c4085047fc32acf23486dcf8d335b2	7200	\N	2016-04-18 20:09:45.030871	user
100	3	\N	bdb984f5ab3efb45dda80e110863539a4f54dfb7188be7f53f439a7b71f05117	6675faf7a1782c324b8a491d28b5fc7af5a81b247f842f46c844e1510a163635	7200	\N	2016-04-18 20:12:49.990768	user
101	3	\N	f3aba6a45ba5c4ea1cb6e4ac7970de669f10987ef3001c56c7d1177c116dd940	ca466cb95b3d593b1efa61b0e46dda3e8d867728d7f71d70a9d45d894c0d47f0	7200	\N	2016-04-18 20:20:56.736544	user
102	3	\N	ee383f8df4d5a69ae3024bdd840394e2f8ffe8e6c3afde42ea89776fa6a2850a	b3c8453ee247515adad4c0ea0bbf739154fd56ae5d5861403b9f381575e7627e	7200	\N	2016-04-18 20:25:56.798372	user
103	3	\N	34219879cdfeee3ecffbd6d3398657cee28533045f2dc7e6ec5b0b0c4b3cee7f	3addfd7d8d45a6af3f3c8d3ef6899352e729f05572c5b599e46f84fa3e033fce	7200	\N	2016-04-18 20:35:16.09696	user
104	3	\N	5a73ec5e171a5c4450940a5550ae03bf88bbe555c68157005a44fd2e8b46963e	3e47e08595d1c1059b8e9ed2d5368586ecebfde29c4ceebcf1c2c321f130939f	7200	\N	2016-04-18 20:37:58.619561	user
105	3	\N	c1726274e2097e536baa2f3b1372e7d98e4302f209c1b3eb2c6d203d62eade28	0d3c03389c9d21024487c7ffb09cbde966eca52fc01cc238a0001d58d6df5080	7200	\N	2016-04-18 20:41:17.822496	user
106	3	\N	d54f3b0bd6aa84096518c106217106164a11dedda2445eb6d2cd73eb3053d45a	a316740ea55912b1c0bf0e90d82c531018778aff36a55923407f9f942ee17bfa	7200	\N	2016-04-18 20:47:48.752641	user
107	3	\N	5b2d71946960d09d0f2f97ed2eb1c470b8474f363a0ac96bef573f24e8a934f2	a03b285d7ab600256d73abff4b40e2f4c2eb2778e0b3af38c1e2017bfdffc1b8	7200	\N	2016-04-18 20:50:52.433874	user
108	3	\N	37ce460649dad1044dc354192ac9348868b4057c499e2f40fbf9b4a604d1c5ce	13686b601798a791b7a38922c412517489740df36b4488a27e00ea9dce09136c	7200	\N	2016-04-18 20:55:26.750001	user
109	3	\N	0445a1865a54113393b63f217f64afc03e5a4706ae964468e6ec90d5683b90a3	a688f6b8024be1f7a8f08c8f303a90da849453f3595df4ad630280f371cfe064	7200	\N	2016-04-18 21:02:45.269315	user
110	3	\N	1afd271c558d052b75ca0617cff379f54e9c7f1db592ab584b5376b1d07af3d1	e68b3481c24fa7896cfafe219e5bb22bbbe5bd6252c0998ac4ec9de2be30c93b	7200	\N	2016-04-18 21:08:15.597136	user
111	3	\N	b20a2da45be140c5f8cbc4dc38811600ea3cf6ff52b64389eed008afcb8d5ec6	5a09b5ccef5175ddc2271c8b5eba5dd0a5fc6d9fa31b7e2dcc437c99893d3fe9	7200	\N	2016-04-18 21:11:37.967695	user
112	3	\N	d6a611fa05bf1652214a7fada08b534e97ce9a058088e805288fd24c1e5cea2d	431c67ba038589009f9b9ab9de2839b6469113f3a3b230f286dd7b7bcf18d6c1	7200	\N	2016-04-18 21:18:27.473726	user
113	3	\N	8535a021add97dee7c45d04f2cc922ff23e143f151ec381a8859868ef925c435	168e21528d4d786d3b4f6ac87c971a93f1f6aa5f92fa9456fd86d6d7d405bfe9	7200	\N	2016-04-18 21:23:59.761031	user
114	3	\N	a5e74d3c659012b2f3fc6f322829b706155f39148f4a4f4f301e82110c3d8727	e276e5ceffce92962d3ff74723d775068c1f84f3d7ac75b3136c3a5e3a43acfb	7200	\N	2016-04-18 21:28:46.843422	user
115	3	\N	3c192ddbf147b912976fde0e6a8a5205e693ee5dfe3f66c2b66f7a90df089c36	69f308bf1a5c6aedddbb260ed8ea1b2a5187a425ec77921e56e60c58073466c7	7200	\N	2016-04-18 21:31:20.466929	user
116	3	\N	490fa36f993bd1bc6df217277a788eeaf86c1448ccb7a600f5d93c54b5bc7b29	dabe31feb52a69d1f19cea560e28abe416a5c0c6b081e3d642e958a6b130f116	7200	\N	2016-04-18 21:37:47.385146	user
117	3	\N	10c2adaf242c3d4a2cdddfcffe154f97d9b060273ea67c4b0984d910e5eeaf36	58083fb5c69a623ac10f917012c7d8087c45c88435bd04179d1c45723513b3b0	7200	\N	2016-04-18 21:40:35.207018	user
118	3	\N	6fdd0e33d4f36abfd74ac57f2d3c07b262e6a5d1e04f947bfec38b40de674dd5	d7e94ff423b6b35a0264f639d4eb15e1b69ab6da027c58d7206d7476bbaad885	7200	\N	2016-04-18 21:43:19.028128	user
119	3	\N	a539f6b62735353b52abd57211fc84ad72ad45f63c14e03b8ac259eb03844d73	3a50321b5fe8fa0280e3250994b7fbccb49462f34d5a0fc410863ced5d2fdaac	7200	\N	2016-04-18 21:51:56.926054	user
120	3	\N	e3fa87ad891a98e319483a98ecf7de13f5c7fdb30920bbb6ace0e191f6b64374	6946d92c958fb80131c9b1be80541aa859f0af4e888052d538227bf90dac0dd4	7200	\N	2016-04-18 21:56:57.039325	user
121	3	\N	ad60a5f29034546e4dfdd75d0176332b0317457f5548d814a1db919fb3700fe8	d0dee68c03c08be6b7c8adb101edc16a55b082abb8d9fde58bef5f83af026627	7200	\N	2016-04-18 22:20:16.035558	user
122	1	\N	513152d1c43d29f985fd8c459a41b9299894bfe1578f3e914d4820e1bd9a4c66	7c51aa931fe6beb05a58c1a2aa389f08af2df248a95824c5e4ba08af0b45fada	7200	\N	2016-04-18 22:23:56.441847	user
123	1	\N	be6736f76cdfaa171ec909dc343592fba48a19676b0f3b9e1cca34a3e0d05b3f	6c6bc214c770b8216eccc6349932bdecd0e22d719ca5e321e6aad8d57d70be36	7200	\N	2016-04-19 01:07:06.993136	user
124	1	\N	bd37c094d018227ba6192d4876b833120d5619392cd22a99fef149846985ea62	ac2af4c0a641f2facc9fe89f5f990552c2b55ce879ec2fdcc20c32f2389a4742	7200	\N	2016-04-19 01:10:16.825305	user
125	1	\N	caa1f967fc50792cd48dde69ec95489059f3125cea83e142d2499635ae7c5f5a	c2ff73aa230cf6fa7c97ac45629c1e6e35865fd8bf28e8136d1c260672594920	7200	\N	2016-04-19 01:14:07.515378	user
126	1	\N	ec31c8007fc5e715ee4cb3d501903e96c500c0f5805c726c9b90db1a09391eb9	ba7194b63cb4806cb1640a6ac20a3658d349418b58790a23137f6c46ce506bd8	7200	\N	2016-04-19 01:14:29.62929	user
127	1	\N	58ff2a8b193cd9a2592e6ac3a79282e5a686aabc3af3b96ff5e95f8b2424c77c	bd1cc703ab2fe73dc63ef2a13799fe3927af0f9b038277142f60b1692735e20b	7200	\N	2016-04-19 01:19:44.025704	user
128	3	\N	e8c1ee0b27bca3cbcc2fb392ebc246a2a915faed8b73407443199a87c9d88d53	30d2352951808aeb191a926edf91fe40ae71ec5cc722a523b868c693fff021c1	7200	\N	2016-04-19 01:21:16.546999	user
129	1	\N	5a83704e821510b873c652a738aa0f2d933e6b14980af40bb8f1bb9666851fcd	0c208a80cb434c159ae766792ab612bc8cff710b932a037f118ce025453f262d	7200	\N	2016-04-19 01:53:46.966532	user
130	1	\N	5aef968de1b6d48914ad33700098c29b9be5fe30307212059494a05f37e9b6a2	0b5c5c0035212ab3cf65bc422afb3f50585ff6a74f5b7c7b1474ed229e1da1d5	7200	\N	2016-04-19 02:51:59.212907	user
131	3	\N	0a458ae71397c8cc0c41276b494a5daa3dfa5602517e46f5cab527d4600f3718	b85828800e5e63416a25842ceb71ecf9d00f7b9062bd54c7daa0726d222ecd4d	7200	\N	2016-04-19 12:48:09.944194	user
132	3	\N	2dfb11c7bee96f848162bdc3d77d6d24f6a98afaf92042c9c2cac01955c60517	e168094f47318cf57b2ddb25a6d331a5d68672ddd118ee4ae9ee0b2c80d97893	7200	\N	2016-04-19 12:49:42.52639	user
133	3	\N	e14117006dcb3da8c2810d1501ba444a970cfaf6bba82974d7d865c0189d7229	0baf841e8bb4770fa25a27d551c001e4bb1d7b43b7b84036a2418811289baca8	7200	\N	2016-04-19 12:52:04.859948	user
134	1	\N	e07ba98043fef5d340bba6a0b1fc3204ed3a26c682bd0d1abb05b67280b2caed	2281d80481bd2c14829510b8777f12cfe2d1e56c431eb03688571558f66a7ee4	7200	\N	2016-04-19 13:11:22.802105	user
135	3	\N	9ef339b6667c7b106f1ab9186ad4076732e849c68cbe24db95af4fe9196850bc	1fc16171f3c6e16b0342d9608a06dfc9f2edc1e7d0f084a2a8184adca8b19193	7200	\N	2016-04-19 13:19:23.328761	user
136	3	\N	f6f9e4f59da5cc67ad571cbef0fc00a41bd45c1e44e572f15b04a9707fc19b27	222719396f99b2980d847346718da75ae0fbdf2c020bdab686970c7379891c89	7200	\N	2016-04-19 13:22:43.237364	user
137	3	\N	237bd6aeff74ae01c76fb27f1b00b9bf941316db92ce8efc028ca96b5ee93826	1c7805281c48c47143d5a055d8b1931233faf54060213718ef273c054d455bb4	7200	\N	2016-04-19 13:24:46.549834	user
138	3	\N	55a874fd8333c20958bac2f0d49b2b6a452315c3a7711c97a47ed2352c9833cd	e0188e6d4090fc1de016bdf5a9fbba10a102cefda716c6c18bdf976d33bfdd2d	7200	\N	2016-04-19 13:26:57.469947	user
139	3	\N	efce198e9d6a3011ae863b15a1a0975be6804e740d784f96638583084676eab1	c8f4a2e8b545cda71da111dcad603d8c0677129d31bcf347232dbb516e2b48c9	7200	\N	2016-04-19 13:29:39.944444	user
140	3	\N	771467e2db68f14c648a1b315004ff3d49ff09fdd8f55f121d7b04ce61fc402d	d6645c91f487a6b2794b5e0f319ed5402153b01d7c48f0dc1d89faf549bc9913	7200	\N	2016-04-19 13:32:34.661174	user
141	3	\N	bae815b11da0ed8156f332a204bffa74fe3e972c93c16f9b31d3a842601bd9c1	379cc3702e63c19b363e16142cd25bb9b949c5e13af478844f3e5f837d3e38b9	7200	\N	2016-04-19 13:36:06.108242	user
142	3	\N	cf1a09242b3279dde95d1bf7325ca41b1a4dd7d49e428d54c35baa57d8602bf4	33684b582f70ef32d0ab3d60e8786bf8860deda98252efd39744b11609b8db98	7200	\N	2016-04-19 13:38:08.33603	user
143	3	\N	829d196d82f6815d0a0a88482575e01622ff84e51fd74258c5a733bf7e827dfd	14069cb36d83ae05690ab457137a0acf019ad77bc902a43ec0df6a473f9621c0	7200	\N	2016-04-19 13:40:08.022595	user
144	3	\N	b33d7320fe5f71e939e993ec96c414b78b88733ab6e8712026a6b9eef51e0979	9bdb598338236e88923d22121753dc8a01165216b630e6b4bb3755a78a8261f6	7200	\N	2016-04-19 13:42:09.164207	user
145	3	\N	32800d2d0e21aae9e94af917a6c3739831c25b31d0d94adc282acf14af67fa96	5963577a7576e19f79ab3ee499b9b8d5b6c99948531280165dfc495dc0043f7a	7200	\N	2016-04-19 14:05:50.61915	user
146	3	\N	7184be3c76d3f92bbfce8cf6cb072d3f61f53c2201397eaf9396fdeecb3385c1	07a10b48351bb3840c721b2af81a03977c6303263bea1a1084c96c0cc8d936bf	7200	\N	2016-04-19 14:14:13.168877	user
147	3	\N	7378582c52c55ec792ccc88dea6d92a89755228702ae9619b47397fce009749f	a28d98908c3d1da29d0791d32ac3bce1397ec767ee647c030f7e050866273f23	7200	\N	2016-04-19 14:23:59.912564	user
148	3	\N	cb761072da9d02c3b479f2087961253d58b4468b720a61079e42be330b0ac35d	665e047bdff9475f16ed41db611807642921b7381ffebde7a3924a852eb4184e	7200	\N	2016-04-19 15:06:00.597338	user
149	1	\N	9e29fe695f4c9a137eb0ac56c7dd1f4d63fecb56d66a2770c78c6f9042a92b7b	6b28435292d603262fff2a49734b4ef613633efb6e8c9921f15ed15257d48ed2	7200	\N	2016-04-19 15:28:20.683401	user
150	1	\N	38311fd68f4fc3381b9c9566463f8455c39a4b467d83680b3056416d656bd5a0	eac23ef1b1606be0ccaf5865bfab7cae287e188993d1c810024f679007907fff	7200	\N	2016-04-19 15:28:44.787576	user
151	3	\N	60d3abdef29703c10bd48d710e11adbb544621a3192ff4c7d6314c0b4705615f	802a51bd6f63ca3b0b9a5caae55017717ed907e040bddaa1318bc53d0205cfa5	7200	\N	2016-04-19 15:38:33.671972	user
152	1	\N	ff5c5525f22a1d7f08ab7745b576e754dccf8703ef65e625f2df0b15e734b8ea	a1f47c2c7d53efcea9be0d4728d1e0b48aea54c701fce126af022b048299a749	7200	\N	2016-04-19 15:38:57.026802	user
153	1	\N	26ad7ca4c8a970460f3e7dbbc1a85e33760b74814626f3e8792b860e1a3d3ab9	88e65e633f7fe986018866c432f123d179702e7b7e0a0406911f962cf7b2c88d	7200	\N	2016-04-19 15:40:35.877953	user
154	1	\N	0ac9ea1ced3b61bb6064f260eabb4714be94495af22d4a4b0ff74c06bf4e59b8	0a29e0d63a1425fd67d83eeb36a039b9d5578b8c8e9d68a5b58ada47c528a7d0	7200	\N	2016-04-19 15:40:53.754414	user
155	1	\N	008899f257f51bf6b890b8a261d239e521a0fd43f98f52ab8980ecf4127ece31	3aec71fdc077959dc7ebfc5c545560f2336d47b7ece3ede79db9312fedb51837	7200	\N	2016-04-19 15:48:16.320583	user
156	3	\N	f11abd1ca530fe8a835a27b94d55da2d4cf9e7c6f97a144e0a798bd9a8bad314	6c0f0d4a4982655062d52df8345645b9f3e03506034c0a0d8d30efe3ffcba645	7200	\N	2016-04-19 16:15:41.817117	user
157	3	\N	55e3ba77fdb67a1dd86f5bbf7b57795c02af76e657afe584e6787f4890ffc4d3	3706196ee20b5fa26b26cb05b098eeb42104d730def10b6fda12f2c9cd2d7783	7200	\N	2016-04-19 17:03:27.841876	user
158	3	\N	9e87e863c34787db89d1988265a8a27af46bffce423f9c61ba6653312d6f17b4	c73db3c9158555df54e86c5058f3432c95353fba917bc94ddd9e3e98ed4a91e9	7200	\N	2016-04-19 17:19:33.866619	user
159	3	\N	41aed914f9064a6bcea200606edaf1b9e092edf22e145822f49f47f3b68139bb	a0c1adb423c31ec46842945c012471a25bb3c0d90fa384ecf48b5873c2e71fd2	7200	\N	2016-04-19 17:22:03.231291	user
160	1	\N	8ec1e5d844ad9caba7a7e4dc4997c2eada94f630c88b0b56d23856182021ad03	b19bc901e8e33b0a43548bbffe1ca20406bf13c1757de238584b06b96a6c4196	7200	\N	2016-04-19 17:32:56.666128	user
161	3	\N	99afe152e7cb98b0c755164f8929d9af97561b9dcd2b51656809a73a6d39f7f0	e6c1936d483c0a6f207a06e87c822fd3f3b0284a0bed4b334744fbbcedef56d7	7200	\N	2016-04-19 17:53:45.25748	user
162	3	\N	b10be4d5e74f53af48dfb867d2cff7167f4c43c34b803c201a07714e21aa34e3	5481fb8880224d62c7de8cd5f68224e1a24b31982c7fb1ce8f1c65c523331ed4	7200	\N	2016-04-19 17:56:01.82242	user
163	3	\N	d1a9bfeaa8c7fc949ec8c7db8242038c53ada40804210d4d7c43296f59879c0c	ef139f242593d1d57479abb1dd931f4f21976f7feb157c4a5c8399b883905798	7200	\N	2016-04-19 17:57:37.429783	user
164	3	\N	876fc2d8cf8dbad301e79610aafd76b11dd08389c7641c0c3b9938dffabbcca2	14008d1f0d697a44c91d83b1407097b2cc714541e05c146e17ffe30ad62a02a6	7200	\N	2016-04-19 18:01:13.654466	user
165	3	\N	fc336cbea583da1bf8b1b866330c5c0018a56d0d5acece5e189ccd96a9609143	3fee0645a4e9c0a3dec27ccd254dc215b1f6a6a87b0fdca765847b24c0e8cbd5	7200	\N	2016-04-19 18:03:07.789905	user
166	3	\N	c0972591dc92f039e54c062474c46c61218716e64782febac529d0650be2cdcb	f2c8229738f88e35b04cb8e2d24314e7f3aa0d22cc02727090c30442e9dfe632	7200	\N	2016-04-19 18:07:38.799054	user
167	3	\N	cdffb2081662be9f37f78bc3ec2880dbad38e4e3c6928392ee35605c79891a82	3ab96ae816c17dc1bafa264592b05865e84f3e578eb8decf39bf7f921b5576ec	7200	\N	2016-04-19 18:10:11.574146	user
168	3	\N	9c21684d5bf9c20732dc23335fde563b1d4612b8d7e7386c8bb620cc69aa9913	8a0f6d59512596c04448126d79ed864edc4c4d0610415a0021bf6867d3828a76	7200	\N	2016-04-19 18:13:03.319902	user
169	3	\N	dabaf3909966dca878333046ce6b2696f590502b5161f5b7aab2c2e24d885d9f	390578e00b58ce4d4c65265f5293a7027a55d4ac4ebeac7fa23a42ce58563970	7200	\N	2016-04-19 18:21:16.292808	user
170	3	\N	56685b573ce01430297eb795d9af99d2df7928a55380f550f99a99a4bf06d0f3	2c23fdad8553a00e3d384add2c9ff98d53e498c29a9778e4130ba26aad264e14	7200	\N	2016-04-19 18:28:49.087626	user
171	3	\N	64873e3d39ac87ab7dc4e9677225645a7513d24d7ee43554992b1d8a7bcb847c	ebe3fc9f918478b2330455a7abd38509b98c27c16e6ddb9a4f34474f4a8a20d0	7200	\N	2016-04-19 18:32:23.804611	user
172	3	\N	95f3f0365dd72f6c9d395ce0afdc23f9bcbd38e5c20a44512d91c20fa5423eed	8b5f08c7ef2de32c52e4ef58d265a5801773b2b24c325864d7a030efefc08328	7200	\N	2016-04-19 18:36:37.279788	user
173	3	\N	d3fc495ccde45c1ab264880ed345a4d1587a071f8f6e159e66d59c079b5a79e1	da7d68807c7c65ee078f2d30c29c9f75727b1d07827788e54f03b42972d07fe7	7200	\N	2016-04-19 18:39:44.52	user
174	3	\N	b8008b9464c6b72a39fe6f74dd6aca73cc490f92ac6a18aa874363381781024d	7e21d13846ab4588f631f26397f4c04ad879c8b5e450f5050d9a7698b68012be	7200	\N	2016-04-19 18:57:42.550372	user
175	3	\N	70cedef36705d01863f6deb30c4133908e68b0d1848cb10cb3740add3c77dcf3	9b45944a29af575dccdda0bda3466a6457ee9aebb2fafe256dd46263e9805af6	7200	\N	2016-04-19 19:01:29.721125	user
176	3	\N	638c2406834eb6d514642824ddfc98b24d8465ffc156824aa6b3ee1b6230fa86	73024932cd7f1fd1cc8a0890a666b7320f805144d05882d3e6d9f5644a9dab6e	7200	\N	2016-04-19 19:05:25.689308	user
177	3	\N	fcf761767a83163efb3944adc2f806acff40d5f42c81c02b070b4d5d7b01ed0d	2b6002da1c78aedb4e343bb9b8cecaf14323c226b39d2abbce6e29c99e8f69cc	7200	\N	2016-04-19 19:08:38.147709	user
178	3	\N	5185ed4cd62656be28f11dbfa3a8a8800f673436324cc3e56bbcbf844a827fd4	b1b7ed682cb22ff936c010d000fbb61e9e131e67d15fead789e87efadd18e75f	7200	\N	2016-04-19 19:20:04.982328	user
179	3	\N	4e5eb69bd875f8c7f50e5fb3458786ea6f41e51e14ab34d866455cef69a670b8	5b55ba4e4f70e1df827cb459792f327e3a1e4a1fd945e4c57261b953bafb126c	7200	\N	2016-04-19 19:23:00.328338	user
180	3	\N	d8b8fda2f2f435354f46bb9ce89855d6e194c225aa0a4481155bcec2e7c0caf5	c370c5b5ad3359a4af1a80acf933eaca2f8bed8e27df0dc8e710239dcb40e97e	7200	\N	2016-04-19 19:28:50.39315	user
181	3	\N	57d81aa94531fd75dbf4ab205c9af4ec81ff2d68c847ab7d431c51488a500b0a	cd485d27bb2aa36c3cd5cc712d866056cd22dafa5122043b0abd7beb5d252f50	7200	\N	2016-04-19 19:41:12.166618	user
182	3	\N	70581ba7b8ab90bfcb8199b6bce42a49a7b3836265a282ad976974a4d2593374	8e5c4a7ad9cb08abaa926687420181b54def3337e94f7a40cf12ae42dee2899c	7200	\N	2016-04-19 20:01:47.81549	user
183	3	\N	6b1c5fe1451942b34057961f6a7ada6dbe610bb5fb37796d755745c3ee115da5	80039abf80c138031980988e4c5e242becec9a1b0f488264c61ed8e0c11ccc02	7200	\N	2016-04-19 20:05:49.532831	user
184	3	\N	a41589536c8b9546b968808d3b17051799e2e05c03d34df559853a53c0a1025d	884562e1716081c77bcf11326cbe74c685ce6584023cdf4289a4828c905c178f	7200	\N	2016-04-19 20:16:13.410751	user
185	3	\N	391c6fdc8da347b6e5045e0a1565e345153165d0d05cd947db2f48fc9a28df6c	9aec187fa7cbaef7c154e6e889bb4de9c40fb06012128ae0f9aebc14daec5366	7200	\N	2016-04-19 20:20:13.522519	user
186	3	\N	9eb1cc6763eaec944ff7852cc6e3d4e3d064990578127d897c6a1664e41b63e8	28b3322b24aed373d31a0d9ae7b3f26992e6a085af49e8f75c1ff09f30ef4c3a	7200	\N	2016-04-19 20:27:08.033857	user
187	3	\N	078cbf51fb5ecd3a0d2e3b7e9a210544257691d080a4b19673872bd936eb280b	cd838ab7d1aeebdce4e5d3eaf325cc92ee6828fb3e8c2b52a3d4b0fe3d32b546	7200	\N	2016-04-19 20:37:30.101816	user
188	3	\N	4b0f9a6c9c5f4a6a13233febae496fc7ee0dbcfd6e3f2013d9f0f6f1ab48a3b6	f7fdb16763ee51e0bad76aa3e0d112f923f30b72b374f8dac6021126e604cc73	7200	\N	2016-04-19 20:42:14.874099	user
189	3	\N	79eeb33925682679de65e213121aef6a210d3c84d0b3bea9a3d9a2503de5548b	8f219822a156139a195a2ec118a5c88e30eaaabc2e9ed97c8c69545384c7f936	7200	\N	2016-04-19 20:46:26.378571	user
190	1	\N	e3dc4e6faa07d77799ec1357ebaf92992724afffc3ec9dd4d371fd35c9cf60fa	5bd335ca310bf8a60db137bc9ef48b385214ece4d4ddd4f2bea1f720a386ea9f	7200	\N	2016-04-19 20:47:18.62165	user
191	1	\N	cf0f6729f8c144f8dbfd7b13a19fdcf98633522a70aaf6273b277fabd4ef5b86	5a437f0a4aa25682cf20f90b608befa44a592acd334a4ccd2df0ec1eeb5666b3	7200	\N	2016-04-19 20:48:21.202252	user
192	3	\N	bebc2a67157cc26a8f1198102f6cd249ec250d70d0e597b5439ac038d46e6655	1dc36c78cd408f5a5788ccff6b6068cae46b54cd79499e66e817970140c7dad4	7200	\N	2016-04-19 20:49:45.612324	user
193	3	\N	4fed7378c3d98cf39c3ea4276eec0712711615bcb619d2c563b231380226a735	8795ac086d67752486ae447aceb36ed4f70b2277f090bc0dc2327aaa6701e6c5	7200	\N	2016-04-19 21:01:13.001564	user
194	3	\N	1f2205c118bd4544a32baf7faf92f6f2b21c6322a25d6d324935cbc6fa921566	d763ebca8d4d2b01c270c2a541e91937ee55917fa1518fb66e1a3dc5e28c6ef9	7200	\N	2016-04-19 21:04:41.451001	user
195	3	\N	4f661faf36cd49b1ae6b41f74b98fb42bc9c650666d68ba689d4ebfbb2dc1712	1a20346654b4cb101a091295f9226f377caade53248d2fcf5411801ac82ee91c	7200	\N	2016-04-19 21:08:07.229369	user
196	3	\N	37a3bff0066bbaebfb4c1b3d862a461fee4c20e2bf9b3b4919319c863711076a	6db7dc63d5ca6e1f44b59fd6d5636b3e29cfeb79be0911b26e048ea7fda4819e	7200	\N	2016-04-19 21:15:52.296446	user
197	3	\N	77531befec40643b89716de7e10fe135e04dba5fb5315b78a9204ad6cb65a699	ae0513a2f5960ada77296373265eacd6c905a42fa0a754d1fc4f6be1b3c0c4ce	7200	\N	2016-04-19 21:21:40.986994	user
198	3	\N	ee82aa52449444fff094cae0dca449414bbfc97e5c490929c6a016fdfc894901	7e8832a04560f0430f10a93b7e0e2ebbd51ab71403d3ae7ac7a66e93b4dbb27b	7200	\N	2016-04-19 21:24:33.704069	user
199	3	\N	29801be43d557e37da8248613fff989eadab9ba43d1446ebe71f6f6585cca9b8	eea9a599bb544c534a5c491192917d474ba572e6a58c4c0db4ead8155ae50045	7200	\N	2016-04-19 21:27:30.074566	user
200	3	\N	cef8b424d938dbc8cfa39a68c358ffc22c610c6375a33d3a9068abecf365c300	ddd12c817962e51956fb6a4f168574c19f3e587ebf0fab8bf626ab26d57861ff	7200	\N	2016-04-19 21:31:45.522491	user
201	3	\N	1e826e713afd7cb2fcaef35f3166b369bfc36d8acb36303580d2a540614a94dd	7155e551340c8d30b258e7e4f8045bebedb44c8bcd59046fe0cd8b9de1fca274	7200	\N	2016-04-19 21:40:09.240582	user
202	3	\N	a7b08f0e4398425b19c64f015b3e76a98925c15a2b3e34e76ae1312e3547d672	98b52746043575c5135f93bbf4f8b221a2d923015ccef7a7de050d2863d3cc1f	7200	\N	2016-04-19 21:55:45.257908	user
203	1	\N	38e739d8f4d7ad45768c8af68068d9991506d0ac8f492de11ca22ef2b8dae02c	dc19b281614d45004128414a302e7cd4fffa0811de746815a63da0d606ce2e87	7200	\N	2016-04-19 22:12:06.332282	user
204	1	\N	aca563eaa2c3905d43559ed4cfd0ec6d752bcea891ba94234b2fd430274fa2da	fd1704dc016bfe8f71421a8d302f7861a149feb7d7858f738fe84d0a8a98e0b0	7200	\N	2016-04-19 22:16:24.877522	user
205	1	\N	5c5f5d0da544e01f3842edb6ce1527e237378290a4cbb1d4ae8cca004d5b1d15	066bbc8e5d91af5c8c11cc7b498cf1b827d7de52f75e6f661acdf6cdc12a5fc5	7200	\N	2016-04-19 22:40:06.403679	user
206	1	\N	72fcf8da9ad87d3fb6fc742a36b7dd580233d26db6d518b64abf1eaa1f7c61f0	9cc38cc15395a57bbe7b8e52ad8e69163482ab07143e0f5c3238f2c7eac8ce90	7200	\N	2016-04-19 22:41:04.49699	user
207	1	\N	852ad03415f61deb6df1c4a85bb17d9370ee8de262de56420e2e6659e2dc6ca0	2b88cf90b2c26455319769ab39e5f3cdd1cb6dd517329ead0015f95dd2dffd81	7200	\N	2016-04-19 22:50:16.163318	user
208	1	\N	cf34335b8ce5f3e5cb8634ecb497d11be55d6be830034efc539a5d2589d0df4a	1d309a386e0cd65ff07760813c104042788e539b7291007189cf0160a647d039	7200	\N	2016-04-19 23:40:57.506929	user
209	1	\N	c024e29b97a846eaaddeedfe88f99d912014565147abf2cfcacb8d18a987f3ee	7e89024a4f75b764ef07d46cb8de231f865983616cd454690eb70dab1ae76627	7200	\N	2016-04-19 23:45:07.786712	user
210	1	\N	0667bbef1375dd42be081a829b683df3aa3a8e370c5dec88446ecab4a1dc23ed	28fbd22196eba40af06ca6175ab87adf48da3ef3348785803ea3a465859bb7c3	7200	\N	2016-04-20 00:55:05.293181	user
211	1	\N	edfdf7c65df298e3d5665cb9a36e62a103be2e9faed22296b4b6021593b55b0c	53554054124c861e4e691ebf742fc50227703995a88a865835abf9489ccc66e5	7200	\N	2016-04-20 02:26:08.590445	user
212	1	\N	78ef38296f05d14d7072ea66e74325fd0341bb400dc3e5eb99b32ece1c58a0b1	dedfed66ffa42f8b5d5f4166ef62681e388b6c9185cf89e423f952152035726b	7200	\N	2016-04-20 02:26:53.981599	user
\.


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('oauth_access_tokens_id_seq', 212, true);


--
-- Data for Name: oauth_applications; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY oauth_applications (id, name, uid, secret, redirect_uri, scopes, created_at, updated_at) FROM stdin;
\.


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('oauth_applications_id_seq', 1, false);


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY organizations (id, name, created_at, updated_at) FROM stdin;
1	Playstation	2016-04-15 17:42:10.229564	2016-04-15 17:42:10.229564
\.


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('organizations_id_seq', 1, true);


--
-- Data for Name: platforms; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY platforms (id, name, organization_id, created_at, updated_at) FROM stdin;
1	Playstation 4	1	2016-04-15 21:57:54.653444	2016-04-15 21:57:54.653444
2	Xbox 360	1	2016-04-15 21:57:54.657251	2016-04-15 21:57:54.657251
3	Wii U	1	2016-04-15 21:57:54.659775	2016-04-15 21:57:54.659775
4	PC	1	2016-04-15 21:57:54.662336	2016-04-15 21:57:54.662336
5	Playstation 3	1	2016-04-15 21:57:54.664536	2016-04-15 21:57:54.664536
6	Xbox One	1	2016-04-15 21:57:54.66673	2016-04-15 21:57:54.66673
\.


--
-- Name: platforms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('platforms_id_seq', 6, true);


--
-- Data for Name: platforms_top_list_items; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY platforms_top_list_items (platform_id, top_list_item_id) FROM stdin;
1	1
2	1
5	1
5	1
1	2
2	2
3	2
4	2
5	2
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY regions (id, name, ordinal, created_at, updated_at) FROM stdin;
1	Región Metropolitana	13	2016-04-15 17:42:10.374561	2016-04-15 17:42:10.374561
\.


--
-- Name: regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('regions_id_seq', 1, true);


--
-- Data for Name: report_types; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY report_types (id, name, organization_id, created_at, updated_at) FROM stdin;
1	Reporte Diario	\N	2016-04-15 18:55:40.157292	2016-04-15 18:55:40.157292
2	Promoción	1	2016-04-15 19:06:59.697493	2016-04-15 19:06:59.697493
3	Reporte Diario	1	2016-04-15 21:57:53.998883	2016-04-15 21:57:53.998883
\.


--
-- Name: report_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('report_types_id_seq', 3, true);


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY reports (id, organization_id, report_type_id, dynamic_attributes, created_at, updated_at, creator_id, limit_date, finished, assigned_user_id) FROM stdin;
1	1	1	{"data_parts":[{"id":2,"value":"Soy un comentario"},{"id":3,"value":{}}],"dealer_id":1,"zone_id":3,"store_id":1}	2016-04-15 18:56:25.028199	2016-04-15 18:56:25.028199	1	\N	\N	\N
2	1	1	{"data_parts":[{"id":2,"value":"Soy un comentario"},{"id":3,"value":{}}],"dealer_id":1,"zone_id":3,"store_id":1}	2016-04-15 18:57:56.402906	2016-04-15 18:57:56.402906	1	\N	\N	\N
3	1	1	{"data_parts":[{"id":2,"value":"Soy un comentario"},{"id":3,"value":{}}],"dealer_id":1,"zone_id":3,"store_id":1}	2016-04-15 18:58:13.389895	2016-04-15 18:58:13.389895	1	\N	\N	\N
4	1	1	{"data_parts":[{"id":2,"value":"Soy un comentario"},{"id":3,"value":{}}],"dealer_id":1,"zone_id":3,"store_id":1}	2016-04-15 18:58:27.701894	2016-04-15 18:58:27.701894	1	\N	\N	\N
5	1	1	{"data_parts":[{"id":2,"value":"Soy un comentario"},{"id":3,"value":{}}],"dealer_id":1,"zone_id":3,"store_id":1,"creator_name":"Pablo Lluch","report_type_name":"Reporte Diario"}	2016-04-15 20:26:26.010133	2016-04-15 20:26:26.010133	1	\N	\N	\N
6	1	1	{"data_parts":[{"id":2,"value":"Soy un comentario"}],"dealer_id":1,"zone_id":3,"store_id":1,"limit_date":"2016-05-15T20:33:54.572Z","creator_name":"Daniel Hernández","report_type_name":"Reporte Diario"}	2016-04-18 17:32:09.28943	2016-04-18 17:32:09.28943	3	\N	f	1
7	1	1	{"data_parts":[{"id":2,"value":"Soy un comentario"}],"dealer_id":1,"zone_id":3,"store_id":1,"limit_date":"2016-05-15T20:33:54.572Z","creator_name":"Daniel Hernández","report_type_name":"Reporte Diario"}	2016-04-18 18:42:05.804064	2016-04-18 18:42:05.804064	3	\N	f	1
8	1	1	{"sections":[{"id":0,"data_section":[{"map_location":{"latitude":33.33121,"longitude":120.12331}},{"zone_location":{"zone":1,"dealer":2,"store":3}},{"address_location":{"address":"text","region":"text","comuna":"text","reference":"text"}}]},{"id":1,"data_section":[{"protocolo":{"checklist":[{"type":"boolean","value":"true - false"}],"observacion":"text"}},{"kit_punto_venta":{"checklist":[{"type":"boolean - cantidad - observ","value":"(true - false) - null","detalle":{"cual":"text","observacion":"text","cantidad":"text"}}]}}]},{"id":2,"data_section":[{"stock":{"amount_value":[{"sr_hardware":[{"platform":"playstation","value":20000},{"platform":"nintendo","value":20000},{"platform":"xbox","value":20000}]},{"sr_accesories":[{"platform":"playstation","value":20000},{"platform":"nintendo","value":20000},{"platform":"xbox","value":20000}]},{"sr_games":[{"platform":"playstation","value":20000},{"platform":"nintendo","value":20000},{"platform":"xbox","value":20000}]},{"hc_promot_ft":[{"platform":"playstation","cant":2},{"platform":"nintendo","cant":3},{"platform":"xbox","cant":5}]},{"hc_promot_pt":[{"platform":"playstation","cant":1},{"platform":"nintendo","cant":8},{"platform":"xbox","cant":5}]}]}},{"venta":{"amount_value":[{"vr_hardware":[{"platform":"playstation","value":20000},{"platform":"nintendo","value":20000},{"platform":"xbox","value":20000}]},{"vr_accesories":[{"platform":"playstation","value":20000},{"platform":"nintendo","value":20000},{"platform":"xbox","value":20000}]},{"vr_games":[{"platform":"playstation","value":20000},{"platform":"nintendo","value":20000},{"platform":"xbox","value":20000}]},{"hc_promot_ft":[{"platform":"playstation","cant":2},{"platform":"nintendo","cant":3},{"platform":"xbox","cant":5}]},{"hc_promot_pt":[{"platform":"playstation","cant":1},{"platform":"nintendo","cant":8},{"platform":"xbox","cant":5}]}]}},{"more_sale":{"list":[{"game_name":"text","game_amount":[{"platform":"playstation","cant":8},{"platform":"nintendo","cant":8},{"platform":"xbox","cant":8}],"game_value":[{"platform":"playstation","value":2000},{"platform":"nintendo","cant":3000},{"platform":"xbox","cant":4000}],"game_sku":[{"platform":"playstation","sku":8123},{"platform":"nintendo","sku":823423},{"platform":"xbox","sku":8123}]}]}},{"stock_break":{"list":[{"game_name":"text","game_amount":[{"platform":"playstation","cant":8},{"platform":"nintendo","cant":8},{"platform":"xbox","cant":8}],"game_value":[{"platform":"playstation","value":2000},{"platform":"nintendo","cant":3000},{"platform":"xbox","cant":4000}],"game_sku":[{"platform":"playstation","sku":8123},{"platform":"nintendo","sku":823423},{"platform":"xbox","sku":8123}]}]}},{"competition":{"list":[{"title_action":"text","product_name":"text","amount":20,"details":{"cual":"text","observacion":"text","cantidad":20}}]}}]}],"creator_name":"Daniel Hernández","report_type_name":"Reporte Diario"}	2016-04-19 21:44:23.11381	2016-04-19 21:44:23.11381	3	\N	f	1
\.


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('reports_id_seq', 8, true);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY roles (id, organization_id, name, created_at, updated_at) FROM stdin;
1	1	Supervisor	2016-04-15 17:42:10.239587	2016-04-15 17:42:10.239587
2	1	Promotor	2016-04-15 17:42:10.242849	2016-04-15 17:42:10.242849
\.


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('roles_id_seq', 2, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY schema_migrations (version) FROM stdin;
20160322223718
20160322231941
20160323025328
20160323042207
20160323042717
20160323043319
20160404150911
20160404151416
20160405152207
20160405152807
20160405153117
20160405154518
20160405183833
20160405184132
20160405224351
20160405224519
20160406030813
20160406045619
20160411181805
20160411183027
20160411183044
20160411183622
20160411185503
20160411185629
20160413235150
20160415141034
20160415182447
20160415202820
20160415205012
20160415221131
20160415225142
20160415230344
20160415232358
20160415232837
20160415235635
20160416003058
20160418163743
20160418202753
\.


--
-- Data for Name: section_types; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY section_types (id, name, created_at, updated_at) FROM stdin;
1	location	2016-04-15 17:42:10.439837	2016-04-15 17:42:10.439837
2	data	2016-04-15 17:42:10.442169	2016-04-15 17:42:10.442169
3	gallery	2016-04-15 17:42:10.444287	2016-04-15 17:42:10.444287
\.


--
-- Name: section_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('section_types_id_seq', 3, true);


--
-- Data for Name: sections; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY sections (id, "position", name, organization_id, created_at, updated_at, section_type_id) FROM stdin;
1	\N	Ubicación	1	2016-04-15 17:42:10.502932	2016-04-15 17:42:10.502932	1
2	\N	Checklists comercial	1	2016-04-15 17:42:10.507336	2016-04-15 17:42:10.507336	2
3	\N	Productos	1	2016-04-15 17:42:10.511898	2016-04-15 17:42:10.511898	2
4	\N	Galería	1	2016-04-15 17:42:10.514344	2016-04-15 17:42:10.514344	3
\.


--
-- Name: sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('sections_id_seq', 4, true);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY spatial_ref_sys  FROM stdin;
\.


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY stores (id, name, dealer_id, created_at, updated_at, zone_id, contact, phone_number, address) FROM stdin;
1	Microplay	1	2016-04-15 17:42:10.424642	2016-04-15 17:42:10.424642	1	\N	\N	\N
2	PCFactory	1	2016-04-15 17:42:10.427755	2016-04-15 17:42:10.427755	1	\N	\N	\N
3	Zmart	2	2016-04-15 17:42:10.430274	2016-04-15 17:42:10.430274	2	\N	\N	\N
4	Microplay	3	2016-04-15 17:42:10.433013	2016-04-15 17:42:10.433013	3	\N	\N	\N
\.


--
-- Name: stores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('stores_id_seq', 4, true);


--
-- Data for Name: subsection_item_types; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY subsection_item_types (id, name, created_at, updated_at) FROM stdin;
\.


--
-- Name: subsection_item_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('subsection_item_types_id_seq', 1, false);


--
-- Data for Name: subsection_items; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY subsection_items (id, subsection_item_type_id, subsection_id, has_details, name, created_at, updated_at) FROM stdin;
\.


--
-- Name: subsection_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('subsection_items_id_seq', 1, false);


--
-- Data for Name: subsections; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY subsections (id, section_id, name, icon, created_at, updated_at) FROM stdin;
1	2	Protocolo	\N	2016-04-15 17:42:10.477011	2016-04-15 17:42:10.508445
2	2	Kit Punto de venta	\N	2016-04-15 17:42:10.49289	2016-04-15 17:42:10.509684
4	3	Productos	\N	2016-04-15 22:08:49.236727	2016-04-15 22:08:49.236727
\.


--
-- Name: subsections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('subsections_id_seq', 4, true);


--
-- Data for Name: top_list_items; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY top_list_items (id, top_list_id, name, images, created_at, updated_at) FROM stdin;
1	1	Call of Duty: Black Ops III	{http://charlieintel.com/wp-content/uploads/2015/04/image1.jpg,https://vgboxart.com/boxes/PS4/72885-call-of-duty-black-ops-iii.png}	2016-04-15 21:58:09.065666	2016-04-15 21:58:09.105148
2	1	Lego Marvel Super Heroes	{http://images.pushsquare.com/games/ps4/lego_marvel_super_heroes/cover_large.jpg,http://40.media.tumblr.com/0a933e16f3c7a1ab10c21904ed9dae19/tumblr_mxnsguv8Rw1qzwtdlo1_1280.jpg}	2016-04-15 21:58:09.087025	2016-04-15 21:58:09.107276
\.


--
-- Name: top_list_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('top_list_items_id_seq', 2, true);


--
-- Data for Name: top_lists; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY top_lists (id, organization_id, name, icon, created_at, updated_at) FROM stdin;
1	1	\N	\N	2016-04-15 21:58:09.103492	2016-04-15 21:58:09.103492
\.


--
-- Name: top_lists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('top_lists_id_seq', 1, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, created_at, updated_at, rut, first_name, last_name, phone_number, address, image, role_id) FROM stdin;
1	pablo.lluch@gmail.com	$2a$10$omDQz5Q2ENtxFwq7Zm7m/eiIWwe4n/ZBi7ZyPTCr1SOdnWPGZLpR.	\N	\N	\N	\N	\N	\N	\N	2016-04-15 17:42:10.347673	2016-04-15 17:42:10.347673	17.085.953-7	Pablo	Lluch	\N	\N	\N	1
3	daniel.hernandezjara@gmail.com	$2a$10$GTd6UawN/nji8LVcNo30duFoW656lPM7QQjybCspDnNVbyx5PIPOS	\N	\N	\N	\N	\N	\N	\N	2016-04-15 17:42:59.187912	2016-04-18 14:35:56.225827	Tantoteimporta	Daniel	Hernández	\N	\N	\N	1
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('users_id_seq', 3, true);


--
-- Data for Name: zones; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY zones (id, name, created_at, updated_at, region_id) FROM stdin;
1	Zona Oriente	2016-04-15 17:42:10.39894	2016-04-15 17:42:10.39894	1
2	Zona Centro	2016-04-15 17:42:10.407201	2016-04-15 17:42:10.407201	1
3	Zona Sur	2016-04-15 17:42:10.412322	2016-04-15 17:42:10.412322	1
\.


--
-- Name: zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('zones_id_seq', 3, true);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: data_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY data_parts
    ADD CONSTRAINT data_parts_pkey PRIMARY KEY (id);


--
-- Name: dealers_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY dealers
    ADD CONSTRAINT dealers_pkey PRIMARY KEY (id);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY invitations
    ADD CONSTRAINT invitations_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_grants_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY oauth_applications
    ADD CONSTRAINT oauth_applications_pkey PRIMARY KEY (id);


--
-- Name: organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: platforms_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY platforms
    ADD CONSTRAINT platforms_pkey PRIMARY KEY (id);


--
-- Name: regions_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: report_types_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY report_types
    ADD CONSTRAINT report_types_pkey PRIMARY KEY (id);


--
-- Name: reports_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: section_types_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY section_types
    ADD CONSTRAINT section_types_pkey PRIMARY KEY (id);


--
-- Name: sections_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: stores_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: subsection_item_types_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY subsection_item_types
    ADD CONSTRAINT subsection_item_types_pkey PRIMARY KEY (id);


--
-- Name: subsection_items_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY subsection_items
    ADD CONSTRAINT subsection_items_pkey PRIMARY KEY (id);


--
-- Name: subsections_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY subsections
    ADD CONSTRAINT subsections_pkey PRIMARY KEY (id);


--
-- Name: top_list_items_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY top_list_items
    ADD CONSTRAINT top_list_items_pkey PRIMARY KEY (id);


--
-- Name: top_lists_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY top_lists
    ADD CONSTRAINT top_lists_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: zones_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id);


--
-- Name: index_categories_on_organization_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_categories_on_organization_id ON categories USING btree (organization_id);


--
-- Name: index_categories_on_organization_id_and_name; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_categories_on_organization_id_and_name ON categories USING btree (organization_id, name);


--
-- Name: index_data_parts_on_ancestry; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_data_parts_on_ancestry ON data_parts USING btree (ancestry);


--
-- Name: index_data_parts_on_subsection_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_data_parts_on_subsection_id ON data_parts USING btree (subsection_id);


--
-- Name: index_dealers_on_name; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_dealers_on_name ON dealers USING btree (name);


--
-- Name: index_dealers_zones_on_dealer_id_and_zone_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_dealers_zones_on_dealer_id_and_zone_id ON dealers_zones USING btree (dealer_id, zone_id);


--
-- Name: index_images_on_category_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_images_on_category_id ON images USING btree (category_id);


--
-- Name: index_images_on_data_part_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_images_on_data_part_id ON images USING btree (data_part_id);


--
-- Name: index_images_on_user_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_images_on_user_id ON images USING btree (user_id);


--
-- Name: index_invitations_on_email; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_invitations_on_email ON invitations USING btree (email);


--
-- Name: index_invitations_on_role_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_invitations_on_role_id ON invitations USING btree (role_id);


--
-- Name: index_oauth_access_grants_on_token; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_grants_on_token ON oauth_access_grants USING btree (token);


--
-- Name: index_oauth_access_tokens_on_refresh_token; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_refresh_token ON oauth_access_tokens USING btree (refresh_token);


--
-- Name: index_oauth_access_tokens_on_resource_owner_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_oauth_access_tokens_on_resource_owner_id ON oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: index_oauth_access_tokens_on_token; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_token ON oauth_access_tokens USING btree (token);


--
-- Name: index_oauth_applications_on_uid; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_applications_on_uid ON oauth_applications USING btree (uid);


--
-- Name: index_organizations_on_name; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_organizations_on_name ON organizations USING btree (name);


--
-- Name: index_platforms_on_organization_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_platforms_on_organization_id ON platforms USING btree (organization_id);


--
-- Name: index_platforms_on_organization_id_and_name; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_platforms_on_organization_id_and_name ON platforms USING btree (organization_id, name);


--
-- Name: index_platforms_top_list_items_on_platform_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_platforms_top_list_items_on_platform_id ON platforms_top_list_items USING btree (platform_id);


--
-- Name: index_platforms_top_list_items_on_top_list_item_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_platforms_top_list_items_on_top_list_item_id ON platforms_top_list_items USING btree (top_list_item_id);


--
-- Name: index_regions_on_name; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_regions_on_name ON regions USING btree (name);


--
-- Name: index_regions_on_ordinal; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_regions_on_ordinal ON regions USING btree (ordinal);


--
-- Name: index_report_types_on_organization_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_report_types_on_organization_id ON report_types USING btree (organization_id);


--
-- Name: index_reports_on_assigned_user_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_reports_on_assigned_user_id ON reports USING btree (assigned_user_id);


--
-- Name: index_reports_on_creator_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_reports_on_creator_id ON reports USING btree (creator_id);


--
-- Name: index_reports_on_organization_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_reports_on_organization_id ON reports USING btree (organization_id);


--
-- Name: index_reports_on_report_type_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_reports_on_report_type_id ON reports USING btree (report_type_id);


--
-- Name: index_roles_on_organization_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_roles_on_organization_id ON roles USING btree (organization_id);


--
-- Name: index_roles_on_organization_id_and_name; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_roles_on_organization_id_and_name ON roles USING btree (organization_id, name);


--
-- Name: index_sections_on_organization_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_sections_on_organization_id ON sections USING btree (organization_id);


--
-- Name: index_sections_on_section_type_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_sections_on_section_type_id ON sections USING btree (section_type_id);


--
-- Name: index_stores_on_dealer_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_stores_on_dealer_id ON stores USING btree (dealer_id);


--
-- Name: index_stores_on_dealer_id_and_name; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_stores_on_dealer_id_and_name ON stores USING btree (dealer_id, name);


--
-- Name: index_stores_on_zone_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_stores_on_zone_id ON stores USING btree (zone_id);


--
-- Name: index_subsection_items_on_subsection_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_subsection_items_on_subsection_id ON subsection_items USING btree (subsection_id);


--
-- Name: index_subsection_items_on_subsection_id_and_name; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_subsection_items_on_subsection_id_and_name ON subsection_items USING btree (subsection_id, name);


--
-- Name: index_subsection_items_on_subsection_item_type_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_subsection_items_on_subsection_item_type_id ON subsection_items USING btree (subsection_item_type_id);


--
-- Name: index_subsections_on_section_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_subsections_on_section_id ON subsections USING btree (section_id);


--
-- Name: index_top_list_items_on_top_list_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_top_list_items_on_top_list_id ON top_list_items USING btree (top_list_id);


--
-- Name: index_top_list_items_on_top_list_id_and_name; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_top_list_items_on_top_list_id_and_name ON top_list_items USING btree (top_list_id, name);


--
-- Name: index_top_lists_on_organization_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_top_lists_on_organization_id ON top_lists USING btree (organization_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_role_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_users_on_role_id ON users USING btree (role_id);


--
-- Name: index_users_on_rut; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_rut ON users USING btree (rut);


--
-- Name: index_zones_on_name; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_zones_on_name ON zones USING btree (name);


--
-- Name: index_zones_on_region_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_zones_on_region_id ON zones USING btree (region_id);


--
-- Name: fk_rails_1c28d2d72e; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY subsection_items
    ADD CONSTRAINT fk_rails_1c28d2d72e FOREIGN KEY (subsection_item_type_id) REFERENCES subsection_item_types(id);


--
-- Name: fk_rails_263a69a9b8; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY data_parts
    ADD CONSTRAINT fk_rails_263a69a9b8 FOREIGN KEY (subsection_id) REFERENCES subsections(id);


--
-- Name: fk_rails_2f99738edd; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT fk_rails_2f99738edd FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: fk_rails_3268570edc; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY images
    ADD CONSTRAINT fk_rails_3268570edc FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_5549d82170; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY images
    ADD CONSTRAINT fk_rails_5549d82170 FOREIGN KEY (data_part_id) REFERENCES data_parts(id);


--
-- Name: fk_rails_612e015e24; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY zones
    ADD CONSTRAINT fk_rails_612e015e24 FOREIGN KEY (region_id) REFERENCES regions(id);


--
-- Name: fk_rails_642f17018b; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY users
    ADD CONSTRAINT fk_rails_642f17018b FOREIGN KEY (role_id) REFERENCES roles(id);


--
-- Name: fk_rails_79ab8015ac; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY sections
    ADD CONSTRAINT fk_rails_79ab8015ac FOREIGN KEY (section_type_id) REFERENCES section_types(id);


--
-- Name: fk_rails_883497e553; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY invitations
    ADD CONSTRAINT fk_rails_883497e553 FOREIGN KEY (role_id) REFERENCES roles(id);


--
-- Name: fk_rails_8fa20c9b22; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT fk_rails_8fa20c9b22 FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: fk_rails_9b62c09e5c; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT fk_rails_9b62c09e5c FOREIGN KEY (dealer_id) REFERENCES dealers(id);


--
-- Name: fk_rails_9dab9b62a6; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY images
    ADD CONSTRAINT fk_rails_9dab9b62a6 FOREIGN KEY (category_id) REFERENCES categories(id);


--
-- Name: fk_rails_a0c783f1b4; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY report_types
    ADD CONSTRAINT fk_rails_a0c783f1b4 FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: fk_rails_a4a802255b; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT fk_rails_a4a802255b FOREIGN KEY (zone_id) REFERENCES zones(id);


--
-- Name: fk_rails_ac0b9e937d; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY sections
    ADD CONSTRAINT fk_rails_ac0b9e937d FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: fk_rails_b05d9609ae; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY top_list_items
    ADD CONSTRAINT fk_rails_b05d9609ae FOREIGN KEY (top_list_id) REFERENCES top_lists(id);


--
-- Name: fk_rails_c912a99069; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT fk_rails_c912a99069 FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: fk_rails_cca0adb3f7; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY top_lists
    ADD CONSTRAINT fk_rails_cca0adb3f7 FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: fk_rails_d0ffedf8a4; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT fk_rails_d0ffedf8a4 FOREIGN KEY (report_type_id) REFERENCES report_types(id);


--
-- Name: fk_rails_d8e1e90dd2; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY platforms
    ADD CONSTRAINT fk_rails_d8e1e90dd2 FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: fk_rails_dd9427d3db; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY subsections
    ADD CONSTRAINT fk_rails_dd9427d3db FOREIGN KEY (section_id) REFERENCES sections(id);


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

