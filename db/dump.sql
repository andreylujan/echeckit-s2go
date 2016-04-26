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
    "position" integer DEFAULT 0 NOT NULL,
    detail_id integer
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
    assigned_user_id integer,
    pdf text
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

COPY data_parts (id, subsection_id, type, name, icon, required, created_at, updated_at, ancestry, max_images, max_length, data, "position", detail_id) FROM stdin;
2	1	Comment	Observación	\N	t	2016-04-15 17:42:10.469244	2016-04-15 23:03:46.678793	\N	\N	\N	\N	0	\N
5	\N	ChecklistItem	Limpieza y orden	\N	t	2016-04-15 17:42:10.522952	2016-04-15 23:03:46.696405	1	\N	\N	\N	0	\N
6	\N	ChecklistItem	Encendido de interactivo	\N	t	2016-04-15 17:42:10.525578	2016-04-15 23:03:46.699564	1	\N	\N	\N	0	\N
7	\N	ChecklistItem	Foco Visible	\N	t	2016-04-15 17:42:10.529164	2016-04-15 23:03:46.702524	3	\N	\N	\N	0	\N
8	\N	ChecklistItem	Interactivo PS4	\N	t	2016-04-15 17:42:10.531593	2016-04-15 23:03:46.70543	3	\N	\N	\N	0	\N
9	\N	ChecklistItem	Muebles PS4	\N	t	2016-04-15 17:42:10.53381	2016-04-15 23:03:46.708367	3	\N	\N	\N	0	\N
17	5	Label	Zona	\N	t	2016-04-25 15:43:57.637724	2016-04-25 15:43:57.637724	\N	\N	\N	{"width":"100%"}	1	\N
18	5	Label	Dealer	\N	t	2016-04-25 15:44:04.205912	2016-04-25 15:44:04.205912	\N	\N	\N	{"width":"100%"}	2	\N
19	5	Label	Tienda	\N	t	2016-04-25 15:44:10.215188	2016-04-25 15:44:10.215188	\N	\N	\N	{"width":"100%"}	3	\N
20	5	Label	Dirección	\N	t	2016-04-25 15:44:17.941773	2016-04-25 15:44:17.941773	\N	\N	\N	{"width":"100%"}	4	\N
21	5	Label	Región	\N	t	2016-04-25 15:44:29.246072	2016-04-25 15:44:29.246072	\N	\N	\N	{"width":"50%"}	5	\N
22	5	Label	Comuna	\N	t	2016-04-25 15:44:36.245802	2016-04-25 15:44:36.245802	\N	\N	\N	{"width":"50%"}	6	\N
23	5	Comment	Referencia	\N	f	2016-04-25 15:45:35.350551	2016-04-25 15:45:35.350551	\N	\N	140	{"hint":"Ingrese una referencia para la ubicación"}	7	\N
1	1	Checklist	Protocolo	/images/protocolo.png	t	2016-04-15 17:42:10.461723	2016-04-15 23:03:46.673051	\N	\N	\N	\N	0	\N
3	2	Checklist	Kit punto de venta	/images/kit_punto_venta.png	t	2016-04-15 17:42:10.483137	2016-04-15 23:03:46.690222	\N	\N	\N	\N	0	\N
4	2	Gallery	Fotos kit punto de venta	/images/fotos.png	t	2016-04-15 17:42:10.490415	2016-04-15 23:03:46.693363	\N	\N	\N	\N	0	\N
11	4	Custom	Stock	/images/stock_venta.png	t	2016-04-15 22:17:30.676276	2016-04-15 23:12:30.359618	\N	\N	\N	{"companies":["Playstation","Nintendo","Xbox"],"type":"stock"}	0	\N
12	4	Custom	Más vendidos	/images/mas_vendidos.png	t	2016-04-15 22:18:27.923577	2016-04-15 23:16:15.648643	\N	\N	\N	{"companies":["Playstation","Nintendo","Xbox"],"type":"top_sales"}	2	\N
13	4	Custom	Quiebre de Stock	/images/quiebre_stock.png	t	2016-04-15 22:31:28.211666	2016-04-15 23:16:15.643817	\N	\N	\N	{"companies":["Playstation","Nintendo","Xbox"],"type":"stock_break"}	3	\N
14	4	Custom	Acciones de Competencia	/images/acciones_competencia.png	t	2016-04-15 22:32:14.91753	2016-04-15 23:13:24.219779	\N	\N	\N	{"companies":["Playstation","Nintendo","Xbox"],"type":"competition"}	4	\N
15	4	Custom	Venta	/images/ventas.png	t	2016-04-15 22:49:24.897771	2016-04-15 23:12:24.369667	\N	\N	\N	{"companies":["Playstation","Nintendo","Xbox"],"type":"sales"}	1	\N
\.


--
-- Name: data_parts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('data_parts_id_seq', 23, true);


--
-- Data for Name: dealers; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY dealers (id, name, created_at, updated_at, contact, phone_number, address) FROM stdin;
4	Costanera Center	2016-04-22 00:04:12.492775	2016-04-22 00:04:12.492775	\N	\N	\N
5	Plaza Vespucio	2016-04-22 00:04:28.326938	2016-04-22 00:04:28.326938	\N	\N	\N
6	Plaza Oeste	2016-04-22 00:04:37.704059	2016-04-22 00:04:37.704059	\N	\N	\N
\.


--
-- Name: dealers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('dealers_id_seq', 6, true);


--
-- Data for Name: dealers_zones; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY dealers_zones (dealer_id, zone_id) FROM stdin;
4	5
5	7
6	7
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
9	03438049b602d653d06f892d1991c60a.gif	\N	3	2016-04-20 08:19:30.561546	2016-04-20 08:19:30.561546	1
93	03438049b602d653d06f892d1991c60a.gif	\N	1	2016-04-21 14:06:48.25399	2016-04-21 14:06:48.25399	1
95	03438049b602d653d06f892d1991c60a.gif	8	1	2016-04-21 14:45:03.682336	2016-04-21 14:45:03.682336	\N
96	8031d7be315805dc8f98c01e842d0d54.jpg	\N	3	2016-04-21 15:22:07.728967	2016-04-21 15:22:07.728967	\N
97	f1db97b361b4bb0a2288708193ace660.jpg	\N	3	2016-04-21 15:22:12.195165	2016-04-21 15:22:12.195165	\N
99	8755775a06e75829e55377740aacaae1.jpg	\N	3	2016-04-21 15:30:51.43389	2016-04-21 15:30:51.43389	\N
100	40d9d9f9559577582e0b10a854116289.jpg	\N	3	2016-04-21 15:44:48.636738	2016-04-21 15:44:48.636738	\N
101	5ed889abb4e5fec64cd2e2058222baff.jpg	\N	3	2016-04-21 16:07:46.414946	2016-04-21 16:07:46.414946	3
102	5ed889abb4e5fec64cd2e2058222baff.jpg	\N	3	2016-04-21 16:08:52.216119	2016-04-21 16:08:52.216119	3
103	2050a18e5d5eae126c7aa614e7704446.jpg	7	3	2016-04-21 16:08:55.703407	2016-04-21 16:08:55.703407	\N
104	3e0037f6219377a7dd81982df2ddded4.jpg	4	3	2016-04-21 17:46:49.407268	2016-04-21 17:46:49.407268	\N
105	3e0037f6219377a7dd81982df2ddded4.jpg	4	3	2016-04-21 17:47:43.480724	2016-04-21 17:47:43.480724	\N
106	c243706c2446de976edf7ccc8f242031.jpg	12	3	2016-04-21 17:47:46.808004	2016-04-21 17:47:46.808004	\N
107	07b20c3bf37619b858bd49344e15ea57.jpg	4	3	2016-04-21 17:53:42.012127	2016-04-21 17:53:42.012127	\N
108	eb8b9126ad24c15efc7e260e82cd09b7.jpg	12	3	2016-04-21 17:54:30.330094	2016-04-21 17:54:30.330094	\N
109	f02bea37fec18a82c6f0d47482c7b868.jpg	13	3	2016-04-21 17:54:58.828287	2016-04-21 17:54:58.828287	\N
110	3fefa5bded93b00b3aabbcbf140b188a.jpg	14	3	2016-04-21 17:55:45.848878	2016-04-21 17:55:45.848878	\N
111	89eba43fe87401f9a3ad762cb920baf0.jpg	\N	3	2016-04-21 17:56:11.131322	2016-04-21 17:56:11.131322	3
112	0e8effb3f54f3d0256079d6622e40c8d.jpg	\N	3	2016-04-22 00:53:56.051396	2016-04-22 00:53:56.051396	\N
113	8e195705357159bfb444800f06a4c2da.jpg	\N	3	2016-04-22 00:54:48.584384	2016-04-22 00:54:48.584384	6
114	6f66458f2a02f5c6b74a86fb4e926038.jpg	\N	3	2016-04-22 00:55:06.696125	2016-04-22 00:55:06.696125	2
115	23653b6eb99534e719c803b6d6d38ced.jpg	\N	3	2016-04-22 02:09:32.961225	2016-04-22 02:09:32.961225	\N
116	da8980c5af24f116ff1c8960f0a9cee3.jpg	\N	3	2016-04-22 02:09:48.286276	2016-04-22 02:09:48.286276	\N
117	da8980c5af24f116ff1c8960f0a9cee3.jpg	\N	3	2016-04-22 02:10:00.42741	2016-04-22 02:10:00.42741	\N
118	1da1609938867a58231dc7374de607fc.jpg	\N	3	2016-04-22 02:47:58.628602	2016-04-22 02:47:58.628602	\N
119	9d588a37fcfec58387205a978c778cf3.jpg	\N	3	2016-04-22 02:48:06.322819	2016-04-22 02:48:06.322819	\N
120	4b2acf3591ab2db35b8a898d3ebf2aab.jpg	\N	3	2016-04-22 02:48:29.852219	2016-04-22 02:48:29.852219	1
121	41311f536080e38e4ab21b8d9d12b833.jpg	\N	3	2016-04-22 02:48:48.942421	2016-04-22 02:48:48.942421	3
122	85dc41a9dce4d4516a65a3bd7ea3ae74.jpg	4	1	2016-04-22 16:46:35.397021	2016-04-22 16:46:35.397021	\N
123	48e7a80acadc1138102ff8cad181aa2c.jpg	\N	3	2016-04-22 16:53:48.74132	2016-04-22 16:53:48.74132	3
124	48e7a80acadc1138102ff8cad181aa2c.jpg	\N	3	2016-04-22 16:53:52.414667	2016-04-22 16:53:52.414667	2
125	5dd724618beea3d9f108da3d330b9bc6.jpg	\N	3	2016-04-22 16:53:56.107992	2016-04-22 16:53:56.107992	3
126	278a65f5cb37a49085b1260cb045f018.jpg	\N	3	2016-04-22 16:54:00.613459	2016-04-22 16:54:00.613459	6
127	03438049b602d653d06f892d1991c60a.gif	\N	1	2016-04-22 18:34:15.012629	2016-04-22 18:34:15.012629	1
\.


--
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('images_id_seq', 127, true);


--
-- Data for Name: invitations; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY invitations (id, role_id, confirmation_token, email, created_at, updated_at, accepted) FROM stdin;
2	1	DxZP34rJaAZeTJf0Tr_4AAhE6MK6ozmVhp6_vDLXjckR66DhY32v03W8uM5e1fPtVNaArCUu9GvFHtev9vEI1g	plluch@ewin.cl	2016-04-19 15:44:35.139074	2016-04-19 15:44:35.139074	f
6	2	2dT50qR5jh4Bw0aSw5LZWYc0dpJc12PovSjKNOAOL2zV0OermDXVbA7Xkje1D2D5IE3-9Rv0byeKkHeAG0Wc-A	ncanto@ewin.cl	2016-04-19 16:11:44.264023	2016-04-19 16:11:44.264023	f
11	1	dgIvWoR_n8Oa4OCQVwmf1y28e2DwuUZMrZKwPbCFfJHgeIBT5xMSi8f4w0u3zSfepuh03o8OjWsbf5am8Q62zg	orlandoflores@equipotouch.com	2016-04-20 13:25:57.236136	2016-04-20 13:25:57.236136	f
13	1	OCqxX9tdAe4SyMuLSak2coqXEIIIlFzczlZsF3wVN95ghVg2RUNT47gXVp-D0u4rMCrUcoh5iTCtsuR833H3Qg	orlandooflores1709@gmail.com	2016-04-20 13:26:45.318149	2016-04-20 13:26:45.318149	f
17	1	hZTbH1KTPGC-WBumvEeWQddYDfYZaCAOrRiNoUTPcgRh5GtNP8nNczongbHBBjPNbGaP8RbOJ9ohYvV99Z6J1A	andreylujan@gmail.com	2016-04-22 12:03:02.647808	2016-04-22 12:03:02.647808	f
16	2	GDLNTTnC-JNQaiVx--XBllAzq18AdIAnliLxoDx0fB5M5oT4P38iO6iFbvfiIAAeWCIa5gFdXFwaZTxDmk7JdQ	alujan@ewin.cl	2016-04-22 12:02:59.383639	2016-04-22 12:04:25.822519	t
19	1	i4N7YX0cUQFdGVgmt-v1c2ln3LfiU_DRdBJfi6w1J_KF9wEIvwUwJ5EsE_alIEAfxYCxDDr5-Lku6bU-bWAGGg	manueliasquero7@gmail.com	2016-04-22 12:08:23.299405	2016-04-22 12:08:23.299405	f
21	1	tFkn2MmgzAhKExatbz24lUiW9coAYWpo4E755yreWhmlX0B_jm7sKsu-WPmkdlne_pvRS09Jbye7yTmE6qrfig	panchojjorge82@gmail.com	2016-04-22 12:10:02.388381	2016-04-22 12:10:02.388381	f
18	1	Fo5dhzsc1H9VH1xr3kc_zcxdtxHKv19xDyQf1jasOxAPiCCdL8Uvp3kdl9UpnwkPE1GcsVzEVMmCt7Z9KFzxeQ	acardona@ewin.cl	2016-04-22 12:07:03.314268	2016-04-22 12:11:56.888429	t
20	1	tLypPd8FyCLMRZTfmTlsEkhtG-sFhsAsPzM3my2nds2KckeoSBRmvEBgu9Th0dkdbsegaGNoce_VeYiQ2SVQKg	orlandoflores1709@gmail.com	2016-04-22 12:08:56.406178	2016-04-22 12:40:53.695255	t
33	1	ExyZwULRqIEubnKLyxxQ0N0agiml5svAyKHerlsf_zt7yagw4dwuuifvgGIXfsFV_ZShDlggY2ewWqkMt3pQrA	atroncoso@ewin.cl	2016-04-25 16:14:12.00924	2016-04-25 16:14:12.00924	f
27	1	U6FHAXwgoCIdRAa6O6zq4gTiMBjfC1UoE1nhm2gJqv_pHmYT5GxmkfVoIxO8EFsapQsJvxSpazQnFLWRWQRFmw	dhernandez@ewin.cl	2016-04-22 17:01:46.172905	2016-04-22 17:01:57.68409	t
36	1	017lqRTaWAm_lrrpMa9FqMaCd98ourwlySeIcAjp7IvaXxQBezPPKEz7IvfGMPO6-FXQY7rxNUB3Vl6yEu3w1g	alvaro.mc2@gmail.com	2016-04-25 16:24:02.719588	2016-04-25 16:24:12.322143	t
\.


--
-- Name: invitations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('invitations_id_seq', 36, true);


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
213	3	\N	869405b3e4b47d9d0b33cc9e842d4825211349cc96a1af82f16ef0c31a45e078	156d09389dcfdc5a20388702ae7ed726b9dc49bd909e4d53ecf41c57f5c2b308	7200	\N	2016-04-20 03:22:06.57189	user
214	3	\N	9492e436f83b29fefff59c618a04c723ffc4e1b8a47abf87bd24d700cd23599f	69af9849a48d5996cae8d4def98e478a7cd8c03c85567747e6735cb88132a5a4	7200	\N	2016-04-20 03:23:44.218188	user
215	3	\N	96ce826848d765cb9b438c8c35ea99724bfdc00d9d27a177ec207b74e92054f4	389b6dd22bf22a3d41209ca62ccffa0ea7aa1e6c7427ed00ea3f8056844e437c	7200	\N	2016-04-20 03:27:23.103542	user
216	3	\N	374f596d47985aed00bfdf5a4ab78afa8c9fe62e04173b5b42918318d165f121	a17582a893ad728669a6fc3fc5f42e807d6d82c0119de898d6a8c3b7ad1f11e3	7200	\N	2016-04-20 03:32:35.561153	user
217	3	\N	3339ab47bfcdd0fde515294983d93f8e556f3ad6a89292f4b27571f2ad36a59c	fcf749b66703e346e2590b8317ccd2234370b9d3d55d41597e13583f8645519d	7200	\N	2016-04-20 03:35:20.104706	user
218	3	\N	c5f47c204b26b5be82d1353462f2658c38c2365912cd9ab8dd3865e58b22dccf	e98a9d3a3123109f216c7129c4d4549f3687ff054c403fa1dfa042e661977f40	7200	\N	2016-04-20 03:39:03.312965	user
219	3	\N	b0693d6db928fcc5e23fc6def6d2253b402070b07251f899b505ed9fe687ec22	38e4f90966d791e6aebcca999f114bb3ae45eab1a30a851ab520be42bd675fa3	7200	\N	2016-04-20 03:41:31.211018	user
220	3	\N	05d16784496a15c3b57914e1171661dea84c4041b483ba62cb29148d0300b160	f00f115e23e6b09971818b86ba57aecd22592f7225b38894c2d7e0959fd6a2c2	7200	\N	2016-04-20 03:47:30.516051	user
221	3	\N	6a7337c39032df86b9002709c7df7f03ffdc46ad41a144cd872b40f05a600f71	eab9f3b10ef1e94e155cab9b0904b381e7172c1b185c789526ab7b92b8b49c0f	7200	\N	2016-04-20 04:02:50.839886	user
222	3	\N	c6af85f6d675c2bbec0ad8c5edf9f06b13f8e96d05e22068c9ac606afb537f74	ed807e09dc37553dba8d002ce9910a3f33755e8b51918e529683ebd6501ef8ae	7200	\N	2016-04-20 04:06:34.282536	user
223	3	\N	2bbe25be50e6eb8aca3212c87022171675445d84436d01eee25205d7e0bb8bbb	25d9dece9ab0211f8678f06667ea98275c7ceb69cb81572437e07502d5fd4fdb	7200	\N	2016-04-20 04:10:59.654681	user
224	3	\N	520b4a36618291c5e45e733820b6e2a99c331f694176b8f72e6b82f19c88f9f9	a613ce5fec00891ec39f27a9305337b559c40fc3358d40f28694f1d4fa373dc5	7200	\N	2016-04-20 04:14:08.223484	user
225	3	\N	95a24451368fdc37635fbdb37fe9ac1549fa9262988e655e9d84b4fbeea2ef0f	d2bbc641f46c3161d9eeb47cd4b9f0131ccedaaf84a77118f6f221338dc15c9c	7200	\N	2016-04-20 04:17:41.152943	user
226	3	\N	fa11c623f0e65392e76792aceaf1adf7869f7a67331f25fdfe4236e3314dac87	76796adf38e840c959832b7c53b79b7ee55d75ec1957fe84be6e6a0dc71160ac	7200	\N	2016-04-20 04:21:08.990897	user
227	3	\N	10dcd316c29f80ea79fb3f8618b841e76627660b11fc58093ea23c3e7332a4a3	ae1f99453f20580f1edb7c5bb5bd47280e361f65c17b73e712a34534b1f9a308	7200	\N	2016-04-20 04:23:44.4081	user
228	3	\N	54e675c91d45a31bc3a6bd069d79ffd35996546dec5b5d1cd73013acf0edf382	6cd4d5a97e3fa50e91b581186d53d57288cf3e7bf39cce1acea717e9b74fcc9d	7200	\N	2016-04-20 04:27:55.076188	user
229	1	\N	229853f107aab79b43b482aa3a5c38fa7bb57336f9419a72c13921f140c8855e	994e74edbf7b0b322911456e4d24c74cde95ed8fb9cb22fd563b6d693a0f9c06	7200	\N	2016-04-20 04:27:56.266794	user
230	3	\N	fca4758384d274f89c70c59146c23b3886b4c9ee06c361b3c44e4c552d721bdb	68dc02f32c8e818189d22097830a2a85829f3e851924e368afee5ac49cb15dc1	7200	\N	2016-04-20 04:33:02.230814	user
231	3	\N	53cc45b2f9dd56a09c7f5c4df54ddc161d8806d30794818cf27e9b6885e6ff33	25c361f853966d97e3c8568f462dafcb8adfd74aac046e5c05b21c5366c9fa33	7200	\N	2016-04-20 04:36:31.178184	user
232	3	\N	de0a1a4aebc84f9f6372701c7d1fda91c380549a6f38468297df7b08c6395554	4a1d152050a5c953f14dac806257e58ff674750eec3b115ee03238c0105500c1	7200	\N	2016-04-20 04:40:06.179479	user
233	3	\N	96f90cfd7f9f32b790e44feba47230214cfb29891b94d1bc41a9100e4d5cff95	c82a3e40519f5ab54984f602109f24ac233dd13db04cd13532d7c8f5d35e3316	7200	\N	2016-04-20 04:43:43.516297	user
234	3	\N	0b828c637d58d42fc7683bbef9f92ff100b9826466fd7a7eb517ba60ed1b7909	efb6212f104be108a67a30ecf95d5e24c4e9c7ab33f02dedce5ad81e38d48e45	7200	\N	2016-04-20 04:49:13.861748	user
235	3	\N	61e83638494f62fac4445392706888712341374dbdfc49be60d73b18636fcb7e	fbaf5db6572bb419620571da52604fb2318e5f13c070c762227ae9591f195759	7200	\N	2016-04-20 05:39:35.534651	user
236	3	\N	fad64e59319ef938373e29269acd8edf9c7d68493f8a46db5a93d2a4cce48f2b	c51427e8045c6cf946cf976e6668ef5dd5ebc2b4b7fdb33b2421edadd152b761	7200	\N	2016-04-20 05:47:09.302353	user
237	3	\N	449676d0d3f2862681ed24f84f60c9de0bfa0eac1b5de9a280e4085cf7a72475	dcc513cbbf89220ccdffaf1e7bf3add606f8d2db20f2d7ba76ed426dc5d02510	7200	\N	2016-04-20 05:56:44.039439	user
238	3	\N	c97008f0b9f180b6ba05cf1248074a04a4ea21b67fd3b6168c5bb43e8dbf32ed	e25073dc16cec1cc7a868788bd2abce885db579bfef59d238bcf1ef310f57964	7200	\N	2016-04-20 06:09:46.255981	user
239	3	\N	f5cb4d578254cdcf586fd342b228964a7bc582f4fcefdb66a99ecbc707395a5d	d72399246b61473fdbe43ba746ea50866fa99f940b6f9cba99ec23319742178d	7200	\N	2016-04-20 06:39:02.990692	user
240	3	\N	dcd81510243f76849b5cbda710d757bad3fd8464c1c4abeb9900960750a42535	7a0692d1519cd946f461ee52dd048dc250637800d017c22f83fa90bbed1531fc	7200	\N	2016-04-20 06:42:31.282762	user
241	3	\N	c54dba1cb91bafda4b97a5a2153d19a0036753810e59306ee2266a5e2c44b68c	2a1565a1d53b6cdfaff5860084b644231278a6339ec99a38119b9ed6e1a1cd54	7200	\N	2016-04-20 06:45:37.79208	user
242	3	\N	f919ed3edd433bd88b3a5eb78b62e85af2e5999b5160e617a89d92c8e4db7fff	ee5f83da754d183e3d387e7ada809193ac3725778ade20aeee27c8315166eec5	7200	\N	2016-04-20 06:49:56.302291	user
243	3	\N	f59958d40df2c9194f3ced85d93d1d5b216910554f3c6f24814b528939119390	02bd0563c927433b9dd2ee8bff60c78f92a096fbfc3f9d5e7c8e20a4bcae6f0a	7200	\N	2016-04-20 07:08:26.995017	user
244	3	\N	00f644611828fbfd486a3b7794d96b7c54da6b26a845dead2bd9cd2a46b0a7d2	4e5225e11d09dd84178a85b4a75e035aa120cdc858df666ec211bada3b0f73b6	7200	\N	2016-04-20 07:10:01.895161	user
245	3	\N	4dd173c4500a53a46f943d36a91585d68f0ce86289c315a6a78414f4918e92ed	5fbc303c1583d74019d9e6bd07ba7bd4f95518359c64be34cb3177fc433d459e	7200	\N	2016-04-20 07:10:03.626984	user
246	3	\N	610f21a644bed064cdf4f7959b7a9d4579d58bd57a6e3624d3100d6396bc9db6	6acb49a03eea275cac9cddb3cd50833610abdb9720263f4c61f2d4e195c2c9ba	7200	\N	2016-04-20 07:18:49.679313	user
247	3	\N	aeb6c11ba95217799d6a74981ee0defc7d8fdaa77fde48ff0049b631e8f071b0	15a92f29ce054e8266f0650d91b5dfc23593e9f02057998b947e443360f7ff92	7200	\N	2016-04-20 07:25:15.121512	user
248	3	\N	a38b73a5a483c0218ba0547950bdfca027de1304fff0c5c453351405fdb5d015	fa837c03c0ec504194198b66b183fc65f5eef87d61aba146137957767a569d90	7200	\N	2016-04-20 07:38:05.411051	user
249	3	\N	ee431393998501cd151625c5fe63b70c31f94fbc9141ee988189551744f37553	d01d9fa4bb2d69e23be38b4ed6219fcf65b12e64cf0f28e036c5e606dfc51a2c	7200	\N	2016-04-20 09:06:04.495837	user
250	3	\N	5073408ea2d057d1d57902906e6eee255275674170f995bc464a9e9dad3dc502	791a8976d4fa829e0d857e9a207a5b9ea488f3f5a13e00400955d03b516e47cb	7200	\N	2016-04-20 09:09:45.921781	user
251	3	\N	b3a510a67fa6a3003e5036f9d0d8d65f44f1d9ad24429fc1ca95e6e7a92c885b	b2e1273fa587cd0e7e7632eee7dfa4480aa3f7040431d469d50d34f9e24b1cdc	7200	\N	2016-04-20 09:15:22.834164	user
252	3	\N	ba1bff6e0fc63dc0c60c9b9b53c0533c4cf66817f8f68f0d7f86dd01760aa57b	1808728ab41f025b99dc1040da9bdbbd98f9f8f678559538479bee17bda9d74a	7200	\N	2016-04-20 09:19:10.860355	user
253	3	\N	7b4d0c10c296a0eb114ec0e3dfb2982f484c676dd08fab48e30f5062f8ffa454	aa63da448fb9a1b533eb08a2ccbd8fb2e0df62a20e2f49002a12703d94083291	7200	\N	2016-04-20 09:25:05.030841	user
254	3	\N	e12c8d319e0914e3baf0ef758ed3eef1e49bbd4ab89a5c2597a69701b77c5dc7	bee5959e19ccbcfb3ab576ce958c331b6791745b33d94c3724ed5c1e530f0d06	7200	\N	2016-04-20 09:29:10.454356	user
255	3	\N	3534d2e66246bcb08340706afbc8d5ee05b1219244e83de426afbb4cec8ad676	4c33753b97f84666a6888206e98ae07c76a7ca0d4692a6511268d25bb5cc77fb	7200	\N	2016-04-20 09:34:02.189686	user
256	3	\N	5035f65d56c6f3123cd0f594b6bbc05dea78e117b37e9a267685baccd016a195	3e259111815cdc2c94144babcb3335c0f26a9994f7dce531dfb2eb65c5d1ff03	7200	\N	2016-04-20 09:38:00.000085	user
257	3	\N	99367c060c806d62dcfc61f5defadf3bef9bbe9f65164bdebc5f32d91f0e84bd	3ba3b9500d65d6f589c880b7d4431ad3e0badeb6d7464619f390444a1c872ced	7200	\N	2016-04-20 09:57:05.5405	user
258	3	\N	af68e348e271f93e96f012901117c1c173772207cfe33cb7f881bd4fa50e9aed	3f576adf0f899b1ade2eb88441acf43eaf5c7691242baf87a78e64ee3e43a40e	7200	\N	2016-04-20 09:59:56.572593	user
259	3	\N	e20658a152bcc6fd0d8fdeb3dc7141eb9c743d0bc5130ad867fc738dc548803e	a58ad7e4d8fec070f2ec8d77ee2a71ac67ce4d43f9d7b3cc4d07cbc127187f4e	7200	\N	2016-04-20 10:09:28.196118	user
260	3	\N	65e52bf4d68305c81e1543312200916d44b54fe962675865011dfa64ae1d8395	90ba0b19efbfb8b88968550e2697abd34e3afdbaad5761f1dadc9b66a2dfbe7a	7200	\N	2016-04-20 10:16:32.858265	user
261	3	\N	de14da7871e295ea8e6134ba785649c2a7c1a2624a7d4a747349868c9a36dd79	19e2cb7eb699b070037a59f3bbdd5a857758b45e084f06731c4e0be723c5dcd3	7200	\N	2016-04-20 10:21:06.912749	user
262	3	\N	8656a61a0c95657191e11cc68a17654efcfeb133ad7af43faae3314f1514f483	c06c97c03dfc70dd6061bb71a67231814e1d1eb7ddaec3ebd795a3548ac6f412	7200	\N	2016-04-20 10:37:44.182277	user
263	3	\N	65d7d2e941ffcae8fa1ec4372aec21c2b53535b4948a4e03fa348ed5c46952a0	0bf318e6b0f2d00772cd3a9a7c87e48e8dccef79e050f176d768af9e86c8930c	7200	\N	2016-04-20 10:52:18.198391	user
264	3	\N	cd1ba155c251d0280fc5330901e0f813d2f36379324b3e41bdb9e47d24de9345	211ef24efeb95d3211090e2a8e66e18335f50960f2c8e95bb54da35ded50d3a7	7200	\N	2016-04-20 11:04:10.51138	user
265	3	\N	39c74f6efda517e4cd9dadb05968e340caf101460e188b22a1879e9d3801d40d	a23cd3f7a82208c397c078dde694385d8dd91cf5dc806d790b257f454eee3ed8	7200	\N	2016-04-20 11:09:16.289911	user
266	3	\N	005bdaa975e9727c5c0f622adcb2966418ebea3064367a0d92205509e63d033a	c743567bbbe0465ad437b624f3c6bff95278fd8b5895b4eca659623cc8f6632b	7200	\N	2016-04-20 12:26:53.086112	user
267	3	\N	54320b33793c13fd415b83b4ef76a4c190d708c342a486f54b8dab28d116a385	7de2766205d84af091f35545a98ff13ce01db91419b4fd6019799b0614b6d83e	7200	\N	2016-04-20 12:30:18.396461	user
268	1	\N	63318a748f186d4485bdd49a4c67720f9308593ec9424ecb5f21be53ab043866	d74a97858cc35bc4fd3412ecc1951ed5d6358a80a2c8b72ebd08aa5080585036	7200	\N	2016-04-20 12:40:12.773945	user
269	1	\N	a3aeb7039db302b64adb389d3fb56c3391c4af8acbfdff65c2d830b47dacbb3c	1bdece6b6cf06e89d2cb79e9e99e5ec3d600ce55722a9cb583bb8c3157304237	7200	\N	2016-04-20 12:44:23.814717	user
270	1	\N	45ae478623232b3aa75d4e488c63c5d03a82c59fc0d42fa9fab99ec7c62bcc33	1ef0d4c329e59030c3783b78a6ef55dfcb60e8d41a7053418cb56f1f5728a382	7200	\N	2016-04-20 12:44:45.72349	user
271	3	\N	01f9f800e82ab0c92a4a09cb36198f5f9e0ab715599718f7041682f6599a29bf	74e287140094dff9119d2349dfdf0d007fd8ca19c63f5791bf6c17053b75a4d3	7200	\N	2016-04-20 12:45:21.368232	user
272	3	\N	19ea63e12ada3fdd0e2340ba4c71cc1751d3762ca67c1aea4d83e8b1c0d0812a	27a8eb5d5b5f207587adc88040d4880d3ba44b8921ee092c2b1e6e709a8de01d	7200	\N	2016-04-20 12:45:34.481223	user
273	1	\N	c9c1c7621f863ee9df15976ae36e00bd827ca0e1a7e40315d847a46c5a05b032	a611b31a908488e8a0f04473ac4ac7ed9fd6034823d17aa657280b57b928f1b9	7200	\N	2016-04-20 13:06:44.5655	user
274	3	\N	685a7b8ac32a2fc95184137851bb4ed693b500f8b1f43fcc894a42e1e46678d2	0ae6faa185aef894a6210382e6f33d95ccdfda2213e7d8291d4822896efcbf5c	7200	\N	2016-04-20 13:11:26.18364	user
275	3	\N	70364b772a1fa9dd709aab6a8fbb115e63ebd4a97e81fdb1dc0aefe8f0f5716d	4220d23e910acc64664b8594c5d6d2628ce7e50c983c90bc3d27736c0141fe25	7200	\N	2016-04-20 13:12:47.638634	user
276	3	\N	38fb95e9c2dc1f08e3d9262d6196b40ec14d9c1b0120bfe92cc598e8977b8391	fe5789be0fb7517b8a245b93c17979343bf6e0ec7a3f89dac5138a050893aea5	7200	\N	2016-04-20 13:13:15.853507	user
277	3	\N	62270545a36964bdd14f40bd6647f1f367a3b4f2d19f10eaa176bcf87333df54	c29fb162ceadc6c7a6264ef60e6a7892713cbae6cc4c536a5c82e1ffcbeb0bde	7200	\N	2016-04-20 13:16:31.670766	user
278	1	\N	ec1510df4e58549a020a6b9eecee1e6f1e4d064981bedc6447712b89611134d4	895f9541c06d83ecaac5523bc6eeb24c8762e56e1823c3a23c2d74ed79502837	7200	\N	2016-04-20 13:23:25.557102	user
279	3	\N	24e2f646a851720bf6c4a1844c780cb1f4bad79e94daf25c21b15d99abb8ff9c	f544ed3571fe1c4078444cfd65123bab36bacb75585b52283232a53ffac272f9	7200	\N	2016-04-20 13:50:03.280387	user
280	3	\N	44e2cff5f9c96e9ab0995d355f17225191e69163b8db18511abb136b9386c7d3	6629d2376c27780ad1b73177030c929a39381f31aaa98e44bb118e0796aa278b	7200	\N	2016-04-20 14:00:44.539162	user
281	3	\N	5e75d23c85f898d3e72539646e51725e6f76a9e3f75a92e38ac99f8034584579	6c94443d93ee78db61d6ae160c8789594308fa9c75b0907c24078f1d1ca4caf4	7200	\N	2016-04-20 14:04:30.719183	user
282	3	\N	daea5252610d1555dbe2833a6a21d9ac51f8257a9144fb446beec0f27429ad60	9d66c6428ee5126486f36a7eee7da4e9904c16d1d8c3b1364f63330052c58b16	7200	\N	2016-04-20 14:11:22.145747	user
283	1	\N	d8d79d54aaa05b69b5742b99841d5ff763631473944cacab6b243e554d18ac1e	54242752ff032c8e377ce6986fd1726d38d9ef9fd7e875c84503a66242aae2c6	7200	\N	2016-04-20 14:12:44.52652	user
284	3	\N	27de73ee61b689a85bc86bf468d09e76ef0c3c887330c17530e2502982df6263	b5da2279a12bb8acdf9b216cf0869fd9341f4780bddba66eb72b99e6114b1d07	7200	\N	2016-04-20 14:16:01.789628	user
285	3	\N	8d2a005ba0ce51b2fc645e90fce6e5471117447598ba33d5803e5e6cbfe4bf9e	922a23c4c856f8d02cb94dea2f925474a5d44c28a7a38f9b4cda6f4f044638d7	7200	\N	2016-04-20 14:19:18.803556	user
286	3	\N	fe8f706527f7fa13ce96bfefda48c98fd39a849d7fc1cc4f16738ac3e155c6d5	0fcbbd344467ec242d080f1a2c6d40a1db5bd6eed6b34dd61d6582765a8857a0	7200	\N	2016-04-20 14:22:25.155678	user
287	3	\N	2e6aa00d2c9d1438dba6975a2e5c93ddd1d279e96e3b8704e913b9a331cc6a50	d735428de2f65058de334e2da54955c50202694b96b17c0a53691644fe4b2ff9	7200	\N	2016-04-20 14:36:26.651512	user
288	3	\N	36229d22d7c1fdef0cb3c75891f6f009cbdbed81e43db08b6d60c4c2854b45b8	2f9f219177d3af5fe7c4c25b5d09f65a35f3e540257842df74946f9a6967fcfd	7200	\N	2016-04-20 14:43:06.778649	user
289	3	\N	441080f8a019f0d8ddde7e54023705da26f2eb00d3302aadad6cd27adf58ed48	da06de4310964269cd03cc9c3f1692f1c58fd78953f5be4e6782c41a33a59ada	7200	\N	2016-04-20 15:00:58.025365	user
290	3	\N	03c9aae53cb2f23c4110866fe39514243c6f60337daf3174e5083fef94d727c1	61645872671040a93a20b1c4d56c061d4ab9d9abd0e082a67183002db7cebd67	7200	\N	2016-04-20 15:05:05.521499	user
291	3	\N	51d6cc9833d8694daa685eadf515bedb056ad5eb1b2c60505e65ce16a72b5f50	7432dfa28e54a74be93632aac2ad0627171ce63eeebb871f6a816cce28eff873	7200	\N	2016-04-20 15:07:58.134507	user
292	3	\N	6ccc4afbad027cf12a975fb501a7a59d941c3572a5688d86f17e2ab5a3808e7c	9013188f1c68fd402f55607b0d90dfa85ed2e83e688e7c492ea636a97db65998	7200	\N	2016-04-20 15:12:09.761461	user
293	1	\N	974d10af285b7e81acd5a1aa20a3d2d2848690433d46028a776219b0909176c9	8b4ee9ba131bf85fe205fd52828e54f9c88d118874d45c16c04188c4555a189a	7200	\N	2016-04-20 19:50:06.553171	user
294	1	\N	e505a6cd0987d38a7481a3c2bdc3917bd90d4dbefb7209db2f7491892a3fe54c	4b71741054a4b14b1d447602da34efc0774a4c6c03349c674483066caded58d3	7200	\N	2016-04-21 14:06:26.875941	user
295	3	\N	e28f2ac801651abbd42b5a83cf807163ea8f1e65762a22352549730373bef5b4	d0048378e3f29d42c868eb5fd7c0c19a2f6edd497be3f1b5558f2d59fef2d233	7200	\N	2016-04-21 14:17:14.475463	user
296	3	\N	8a3267d131a57c856a8a5828b21f98ef548b7bf39245b3d1e8c789624f00b366	8cde64030c919d4930efcc0c9344ef3c2e68168eb8881378b5ae1dc4890154c8	7200	\N	2016-04-21 14:36:56.289892	user
297	3	\N	ea92790133cec172372a7ef5c6c260493f30f35dcf7411614a854aefebe1f14e	09820ec03e414e1d3ce1e61a6b2f4c312b18bec1c372138f5941b3c91a84f088	7200	\N	2016-04-21 14:58:41.526553	user
298	3	\N	635e548dc64972129a0128678aac72f3929dbc4652a24cd6389c38e9cea4ba66	31fff4330ae5f6d1e635c375ccc91d45a76b5ca1b397dcd2f37f1e96e6873659	7200	\N	2016-04-21 15:01:51.63879	user
299	3	\N	40e5c5e2fd7e1efcd695efc91220e59795557055e2132220ae8a692aae443f01	4a3af386d3057bd1057fed220dcb76f83bd7d46eadc0326a9e8f522c54a89745	7200	\N	2016-04-21 15:02:12.106504	user
300	3	\N	2bdfb10faaae154a4d9ebef6404f58cd492e782b6482817a5c97ce669e3d219c	879d8e2e51940d309e13b0d57198affca0cb9346b5f4e9a556750ed6ceaf493b	7200	\N	2016-04-21 15:03:16.46677	user
301	3	\N	1c54a30ac67989596c0644c0bdc3c7b4449e741951900ded112399e5d86dc442	12f2dc56041e5885715209be5adb826bfa65ff08a61b785ce02f57f098880d90	7200	\N	2016-04-21 15:16:07.483508	user
302	3	\N	a7cb4b947df81351cc5f7693608e77e69804e2cfa1f939a137458e9fbf31225d	6d150fd9510c4ef11da19dfc0145e6df018c7debaa91568f1f9ef729daaf9108	7200	\N	2016-04-21 15:21:09.325717	user
303	3	\N	5e70fe65af362554fe0ebe2f840b516175d8dfb3d1829f142716280b5fb1c09e	fc5d8925350138031e923a6ad8fee83666be70bffe4eb102fa6cdb6b922fdac0	7200	\N	2016-04-21 15:29:32.05848	user
304	3	\N	cdb2c24222a62ca93a5c8db805a6447f70def08067cc76bc36b91cb300377cd3	ba7350963642c002e6c32e9f2506557f5b1d2f9be2c2e3deaac3454599b85936	7200	\N	2016-04-21 15:37:07.762381	user
305	3	\N	f07288358bc92af895f4f9afa584e82de2c56c8b271140400b06bbf28a596b7d	ddfbdd70bafb9475e71696ac09d7a6a25eb87aab31877d723ccc65ce9ac4bf58	7200	\N	2016-04-21 15:43:58.687495	user
306	3	\N	51aa5b13de6da1df5186637f3527d647cd01f01c8b19fd29c77efa0cd9b9166d	5e491309a062717838cad9966a7c3d124b70dda5ed03877722946154847a26a3	7200	\N	2016-04-21 15:47:06.77554	user
307	3	\N	49635d16b53526e29963178e3ad350d7afcf966b4271a63c693c9c5ee23675f8	1e82932b53bd9b2795d1c840934d7899f81ffb4c1c8f53e21f8956ddda175edf	7200	\N	2016-04-21 16:07:01.489798	user
308	3	\N	b3d19b7176ef2e9c27646ad9c82c2b681292a0992cae2d6312702baf28fbd7f2	77b62d867578affa79b230507045a6c195a4b14c67245fe696c6dbca030ccf42	7200	\N	2016-04-21 17:46:15.155014	user
309	3	\N	8724535d3268f8adf96c36b2d81379dab9dfd328b4a5868a194b74c0ddae8a89	be0b269552c42ed4f31faa1a76ac2ec42d143c2869349632a6f40be4c79c2a04	7200	\N	2016-04-21 17:53:10.250066	user
310	1	\N	1a6d9b5f5cb0f2cb9a7d619e0e628b9b958f308190e361c16ff5aa6c4cae6383	efbc72d6f6208c1b75a33ae013be7112d826b38c9d862c167f44eb22ada3f11e	7200	\N	2016-04-21 18:06:35.119536	user
311	1	\N	b579e716a362adcf105d959aaed4b1cac1cce118f631935e33af2d382b2dc58e	f8bf9384acc87e13e6affec0a539f514c3a9dc04128efa8fdbe901bb54e333ef	7200	\N	2016-04-21 18:20:50.46153	user
312	1	\N	7fa99dc2b74f6abf664c5a290b3ea124ec79a25c48148a60befa1776417f9264	8641d60464798a8114a803fcbc6f41533d768f5a4986df41d88060dd16e1c1a7	7200	\N	2016-04-21 18:28:24.8137	user
313	1	\N	4de01c8771d49fad7d05805a7941fa5df53c8d4d2f54cc1a340ac2879640c280	0818ff2af46c69a09ead66a2835a14edc782286260d733ccf98f81cb69467eeb	7200	\N	2016-04-21 19:01:27.386602	user
314	3	\N	df6a31df6ccd888dd0a80c04a78e4b5903233aa84bb9f4cce9f315e5aa0e55f2	1b269e687548db0ab6887f3c6bc74a7192f4b6a720f91b548d92a9a528fe5607	7200	\N	2016-04-21 20:45:41.121943	user
315	1	\N	e577a42da69058a64c6abefc187eec9b64cb3bdb284e51645f29fcfe8513fe73	4c3c9747158dcd35a5c8d2ca307f8b89b06de81dbddece342e5c9ae49860207d	7200	\N	2016-04-21 21:37:01.749149	user
316	3	\N	5eb6ebb3ba626d097cc579458970c7c973f61d70984694ee818df02e44933d17	6ea13548910bdc8de107e777498522b258eac1394371aff4b97502f9b469e051	7200	\N	2016-04-21 22:52:09.605208	user
317	3	\N	51aa8683a1cf68cdd37563781ceb3027aeaa38afed6e7ffdb481b6ccf347dda5	2b647f2f719309dbf214cbc33f4d385f31afd6d070411bfefacd92ead0d36975	7200	\N	2016-04-21 22:52:35.19684	user
318	3	\N	bb2a2bcf036b4de49cdbf591ed780add95e8177993d1983028822bd773fdefbb	02d1d079ede3734fd6cd015536d56ef5068882d02a9dd054ff552d9af6563f5b	7200	\N	2016-04-21 23:07:55.68882	user
319	3	\N	da517f99831f28eb086d31f251131d50b04babb0f0fd58b58adc1a7136c3d491	3a390fdc77365133340dd056539b5e7548c345eb00b62f102289bf5890f4211c	7200	\N	2016-04-21 23:13:25.3418	user
320	1	\N	2ceca99715e9270e67978ab625e6f7f4ed6a5b6d3e48d3586aaabda6f9d2656e	da4767c36bdf7b77bbb6c3b49d1b5717a815eaec4807c752c8f66eb5a9d55d67	7200	\N	2016-04-21 23:15:17.545529	user
321	3	\N	ebb60b6926b4d4b796a06286f929641a4aad6464645b78b4c869db7f7567b6d5	b4e2f49bfc0f0278b43e282da827c03d558df30d2b4d13b362a4693307fc7251	7200	\N	2016-04-21 23:23:51.840492	user
322	3	\N	fdc29526932a87aa825ed287764df7cd514e16e9294843a9ccf54ac7134881e9	6e37110bfd645ea1ccabf696cfa24fafe8ea12b1b9e749079b9e2ee5b1a39cae	7200	\N	2016-04-21 23:24:23.784729	user
323	1	\N	00a641f0081914a6c54c16acd8e3d1ca16a4726a0348b385bc34335c02307166	8c9714633c9d17993725e737a2ad8ef62a6c434b2dbade0f52396cc32a18af63	7200	\N	2016-04-22 00:09:57.972301	user
324	1	\N	e23ed5fb743e95cd4bb2daa1c96d47eb0899e51fab78787dd51f24aa7adfb22b	a18e613d6f26b86b9b185b2ac5ed8cd3fc5082c4c06e94982aa7c88674160979	7200	\N	2016-04-22 00:39:03.401962	user
325	3	\N	e79ac4b9139dc2344a754134c190e1c9dd7e316933daeaaaba209e5e72ba7d27	72737dc15561e642e4280c1c2ac4762332bbb2ae94d04ba2810eabaf251ec783	7200	\N	2016-04-22 00:39:58.770511	user
326	1	\N	3ef2318ce128b293d99a981a87047a323fb0535cc9b21fef669e3ca8f8605860	947f57b82fd13733d69777d5f0dc17223748508f7ffb07cae184c238a0fe94e8	7200	\N	2016-04-22 00:56:55.943338	user
327	3	\N	ab29d9351befaf04d744d4f8c098bce854bdff38cd3aa34dd75b398851051ab2	bb917816a6a6ae4a1ea0e6beaac734e6a610f7281ee87631e6f2353e3ba39a6f	7200	\N	2016-04-22 01:00:38.753873	user
328	3	\N	4336af4aa2a8e04d4beb80b08810b1c5b7ab67cfca0f085816b8273e53cc31f0	a5f642a33d7c9a3212c0d2cb419828af96aa9329a964f88fbc667e378aed751a	7200	\N	2016-04-22 01:02:10.975091	user
329	3	\N	0c0f44a99d44c2b2901a8729fc515636962183f4e0883c935b113617d3634e68	986550572239430a8293475ab7abb149919da5d65195735a25dc5ee554167f7b	7200	\N	2016-04-22 01:13:06.418818	user
330	1	\N	2ac5297a9821bea149676b77db3184ed3f5b197b179fa7144fb1dd48b7d5d4a2	c446bc7ec7e14d1429e459b6c834e735dbf8a99d7646f57e51db8ab15c94da18	7200	\N	2016-04-22 01:34:18.031148	user
331	1	\N	6df7e1f5bdf3badbe0cc978fc4428212583dd53f428c72c0216ff1958201bf0a	e156046fc6966639bdce68ad654a3be40a72cdd59320cb1779665a8bfc914dab	7200	\N	2016-04-22 01:40:26.522057	user
332	3	\N	958827f27a3302d4f2ff4806e933c3ae58d32b0b68eaf843a941877298f9a329	2cab4561e7274ae13617adc1dd96d1939082763e0772db3c7de776f9db5871b2	7200	\N	2016-04-22 01:51:30.855542	user
333	3	\N	195e243b278d0943bd0285d40060d459e13304ccd158c20b53b31ccca5aaa3c4	76b277fb378f965ba24d607b8f09064c70b8a8d475b78e1499aa921ec1ac06c7	7200	\N	2016-04-22 02:12:15.083852	user
334	3	\N	7b9a83ab0029842c48a0db216cda16f7d801bb3fb05fbe010cfbd0a95a487dad	f63bd69e3856a6b0bb25050a2012f87e0710c5896fe30928c130d0a01f82e650	7200	\N	2016-04-22 02:12:52.388455	user
335	1	\N	d73fe82c036830db3ca4300d16b08a708fb02d44bd5f117af52c43e7f4b26606	61030c923d4429427570cb18b94160b02b742142492871484f4a5636e4e35301	7200	\N	2016-04-22 02:12:52.926011	user
336	3	\N	44242787b0c514affec224a241507209219f63e4d2fc89f3ade7d3394d0eddbb	f82d0580f96a18bc64d6a446b4340c424cb91e9a57c54141e3a3256f723ca950	7200	\N	2016-04-22 02:16:17.737856	user
337	3	\N	54004876978707e5ab633f917eebaeee009f21ab1733a1154e81d01850ab13d7	9d377a8971944f3f6f929047fd98b42dc83ca5510410c351d4bc5d92facd9f47	7200	\N	2016-04-22 02:27:21.2676	user
338	3	\N	401804f53a0507e5b04433732a0e2f3763e08b65d1ce51ded59b400a9ee01b7d	265ad009944173a5c68d0c615099a1c22837043b694285d6377c10eb6a33328e	7200	\N	2016-04-22 03:06:29.116845	user
339	1	\N	d072cb8f11d80800e084a548f434ce4c11fd46de83abb8be8d1b15fa12e47213	c6ba520b63dab879501965667b38758f58e0d94c5c15f76bb4fa2397140ae368	7200	\N	2016-04-22 11:38:32.147733	user
340	3	\N	2b57dcdb2a9ecd646d473a4b9b7d812b7ff3cd0de59b403f3db9fa35cf79abcc	5b51f53827578a71dc3eb8a76a3c54cc83342c5b7ee7af3697d75ad12b197174	7200	\N	2016-04-22 11:45:22.022894	user
341	1	\N	d0b5387e09b4b1c2b43b4592058f76e35f5c085c995b65fc83f8173df013398a	f4a88ffb5a95736dd1a65d9a4b49b86f6653d2b3d6d7bed4dbe5684240da473b	7200	\N	2016-04-22 12:01:28.726391	user
342	1	\N	73776ca49d9e9a1ef3209275ee9a578f0e5de01f215410e12f50a33ace1eb659	78bc696ad65e1fce4a4a27ad8b22c93509b6c98977181066cb81493e6b04be00	7200	\N	2016-04-22 12:05:15.586678	user
343	3	\N	86ee91e282123896223408efb870364b8eea27885fd7053a2ed08c40b8080f5a	460bcd0b3326a18584a6fd0445bd83c80ac2c89979d20664d41f4c5267c84800	7200	\N	2016-04-22 12:06:28.52326	user
344	3	\N	0bcd192820bbca650182000d2fb5d32c2f6a8bf022c23214b7117aa9caca9ade	064731f8492cf022e2ab0891875b48f6c0420653af4bb79f91b2dee43b3f220a	7200	\N	2016-04-22 12:07:14.575518	user
345	3	\N	888eac7e905e1ea9edbf9ad7f1466a1c4dc8b46e3865ae91ce24697a6c9292dd	02d9afde556fdac36b9dbd5d399261e612cef3d2282c4c93dc049fa540687e08	7200	\N	2016-04-22 12:07:15.66349	user
346	3	\N	e718d42a5fb743adc6411c2beff2b291d2784cadebc4c908ba908aa4110d2a1b	3a62a60dfaca6191743f9008eef5189feece924af9e7ec3f076db78e447eff55	7200	\N	2016-04-22 12:09:29.665411	user
347	3	\N	5ec5a597f38b3af441e43b868ca03140b9506b35de2aec6059efac8fbb055a67	e11f1e66e213c71670be2f4b6fe4da0dff440e4b383138bdf1d0a5a7166a609a	7200	\N	2016-04-22 12:10:10.472588	user
348	3	\N	17a33319c5451a70db72a74ad9b9aef53525f0ba0bd426d77a45a60ce624ffbf	00c563c9a0267ef7da7fdc799b9f3a1f1eb88aa77d1a2943b81639e3e8e58682	7200	\N	2016-04-22 12:10:10.561297	user
349	3	\N	ac54c36dbe1302f1db238e709a55f0bb91c147b687d64dce459de4cb9f74e648	c9f097b6d3f757581e29290664e0302c3101230e6ed0b9357a886f37f3b11c1b	7200	\N	2016-04-22 12:13:23.898607	user
350	3	\N	f343e4873420ccdada4e6da93573f6e9c57fd6b407049b27c7052ea6daae71ff	c5ddc132e48401520720e4ee63a7db801e4c013838f7619fecf5e562de2e5b38	7200	\N	2016-04-22 12:22:09.777041	user
351	3	\N	ff16811f498c5935288fe0e82b302ce6c3a2af6cdd2256437cb776bda11e624a	3004794a7cf27f2d80a730bb71772a7074b7752e3c485c9a2d07a320ad2459ac	7200	\N	2016-04-22 12:23:36.757482	user
352	1	\N	9dde415f39434d7dbafdeddb434cc18c9f2a330e7c1da1095e2a205400271d00	a14f8f1273e478dc35fb58250057a111e7fe31efabc6e728112dc8c11b191d4a	7200	\N	2016-04-22 12:28:28.863894	user
353	1	\N	4b4d474596667861892317fbe8fdbe2316dea94c5d29ebc1c7879a9cd8434fe1	cc142399266b530ffa7e73b929ff1a87e7171ac8cfd23d1957e35a851759b0c2	7200	\N	2016-04-22 12:30:39.730524	user
354	1	\N	da7604cc972bf77ed229c455277a5f89ce6d1d3aa09f891603792b04a537f0b5	076a80354be4fa3c33bf1cc5cf900e409b8d0269a056e45adb6c9a3ad2470f19	7200	\N	2016-04-22 12:32:41.813508	user
355	3	\N	18e4f641aa8e0ca1b057ff5bb56fc45ecd759d20563d745ac7fabcf607747cca	9244cfd9fb3cca212a9bd1072c35eee1a90986b752f2806859f6d04e19f66675	7200	\N	2016-04-22 12:40:33.979209	user
356	3	\N	a81d85c713c7488bd341ad114a39e49752031ac726368836f755c56c2b98540d	dd5fe7e4b458afbca4dfb2e49da2009bdc3546accac29f913004069018cc8040	7200	\N	2016-04-22 12:49:38.164186	user
357	3	\N	c2323f1ff7d5549d11920f3b57e5e6114db01eba20444ef1bba13940d24f3797	e6f21de234a7ada07e1ced273c88043cb56a04685e7c1276cce32660b52920f6	7200	\N	2016-04-22 12:54:40.283971	user
358	1	\N	16c52b17f884e98136e26cd66460ea8672d81a3b5073b9625d385b7004c82213	d97093dfc581c5bb1e9bc197a0ddc804d82aa0036b07c610fbfd232074fcf427	7200	\N	2016-04-22 12:56:40.895688	user
359	3	\N	03f35a1200dfe8da396eb3abf34102e9697af18ca4d04e6793b92913cb240605	de3c08f3c8c37b7800830a62700f111470b205fb065e4c2fb06b9fea35c26111	7200	\N	2016-04-22 13:00:28.499736	user
360	3	\N	074ac7f95f9fcdcf5e3b995c2f12462df4f91534b926cfd14212aa4a0e331a3d	c1e9a3b594a7d3c7ce92e013b2485155fb1a8c0e11329c37340515faa706ea2d	7200	\N	2016-04-22 13:14:01.213891	user
361	3	\N	0483d5402447b935cf537e3dde4f4ffb335ecda129c92b9b23e18c87ac0515ae	b3336d551d1a9dae7c87d21131c4c509a23db61a9447db8ec3c61a6d2942bc89	7200	\N	2016-04-22 13:18:58.338989	user
362	1	\N	42fcec9ab0cf3f730149cbaf85f76cffe0bbadbf10d43d9e264cccf0222d5fde	28ba9e46338e7bff1e0eef3705560c6214b16301c3b110ca381cb5e39b1f56b3	7200	\N	2016-04-22 13:25:50.748366	user
363	3	\N	b1d79a87f037b7b16051f276c34affdb8a64261a02e5405e7ff68d69c7988bfc	5724d563ecdff028aef923df8ec2b3dd173cf354988877b279e5e5e728160d7b	7200	\N	2016-04-22 13:29:01.014754	user
364	1	\N	a930a808b77242c779a68babc873818a7a9d3f027c39b8d441e72f3e2fab52fd	4f5fee69217912886c750031034de654d686b540923fc51bdba3a25c97499b68	7200	\N	2016-04-22 13:38:20.840941	user
365	3	\N	5e5eef4049a99c4e65608b9a05fa0ab8d65d98f1e5819a1d82ed5a8e65e0c00e	cde5579652cc86cffa470986548d20de6b83e8d6e0da189b63080b0764c7a3e9	7200	\N	2016-04-22 13:47:25.67471	user
366	1	\N	9cfc3393e013bfa90e95d4a44ef1cb2b7b5fd5fc2d5ac9e32992661b0bc0786e	cdfe3a1e4443c60130e8718e90eda199466f8460e8bd71d515d9b8fba425bb49	7200	\N	2016-04-22 13:48:16.602768	user
367	1	\N	ba825e592e35c24521eb12724255e9866358e5a0c7945516a3f0ddee93f72788	64f06b5c5c2d4b61e315927ff5094c8ba8a4eec5def14ad0db0a433617cb8774	7200	\N	2016-04-22 13:48:20.95695	user
368	1	\N	c1328af05dcd3775c92053359227487778001571ed557dcc799e8ccbc1333bee	380460bb7c5d5d785d3f6c788b661bf2fe850048699184915f947319e89d9040	7200	\N	2016-04-22 13:50:20.121899	user
369	4	\N	31a85e12d77a1f802af73352c495587064b316f93d47b80abe2e8cd87f7cdf4f	f625d27f4e6c7e9d110bf7b2569bccfedcd084176a2c4c0a5b77ae4ef077da46	7200	\N	2016-04-22 13:56:13.921766	user
370	3	\N	3aacf257980cd90a925e59457562f4113595ce93561986a2271aaf7c4e538b34	3f61dbf4481a8a075089346f6244ed8f9768ea2b88c2bda13fd8f309e9b2ce7f	7200	\N	2016-04-22 13:57:48.453325	user
371	3	\N	8d13b7568fe385fab738e56b5c149379b4f0b0134a9e4687117186868b6414ae	7ddaee116b72a94d05eaca1c136cbe062c57bf5a15f952192e41b38df09f3a99	7200	\N	2016-04-22 13:57:49.933761	user
372	3	\N	6a96929824abd1f0cf4bfb5e77c9aa5fde29fd568fb92ca77933566e1862c5ba	ba2e5042547cee1771d9e7b29aad2255575fff348f0156e65559810a7c6e230b	7200	\N	2016-04-22 13:57:50.071196	user
373	3	\N	c4d1284f8349a6e4aece79613e73cc218ac8688f4b4b436c081a1bb7166fbf86	40b7113d0b72c38b0469b7f4fef4b1d93b1e5af92fd70e37f750e98699aa096a	7200	\N	2016-04-22 13:57:56.835708	user
374	5	\N	d221536ce01184db8f34f54b0103bb5b9a57e52b03345501fdca18161558973b	bef40e7d60d97b15a7520a70518cdb9e43be179896d6a08c4cdb19aadf836d02	7200	\N	2016-04-22 14:03:02.247309	user
375	1	\N	857d04e70a34daa25c68c8226c66e1fcd63c17a2c0d2d4cdc05d27db2013c4f0	bc66d658e4830da1ea768824a916b0632f658672857c7eb7c319c97081bf24c1	7200	\N	2016-04-22 14:03:04.523341	user
376	9	\N	8880c77cce4c10bd39ef007c7f5a081d4133b3cc3fcce902e81613df07d62778	8bde07c2d5430358280a594a575515aa34d37a15806d81282d3af52133069cda	7200	\N	2016-04-22 14:13:37.814707	user
377	4	\N	a06f4bb521e790c55ff346aeff0f1706b251c2e07780a5e332bf151a5f72e6a8	052f8152e30293967495a12c6d446d85368ba892233b59f04dbfae4e1b99ef86	7200	\N	2016-04-22 14:23:22.101641	user
378	4	\N	352c9c086c04f9dcfbc913b55ea156e9e9b5dd67dfe9dccf6260a24cc61a2d6c	e1dacecca0215e89f1f5fd51f257500216deb30d7106c2785b60df2fb95736ad	7200	\N	2016-04-22 14:23:26.851246	user
379	5	\N	c16e883c965f2d8f201b7afd8451b9ba695d028ca306452957f6183126da9463	5584c8941a7f3c6661e0f3273e3d1381b72f737fe7dcff7646776917f60104b5	7200	\N	2016-04-22 14:24:22.394337	user
380	1	\N	690de4444178f11b9ea7d71793fae92592e461522434b092e95c9f4eed69fe17	bf93565b75e928b45530b3461d397eed54160abde67f26623bf96f700e0b9b5f	7200	\N	2016-04-22 14:24:32.796447	user
381	3	\N	3f2259b8a29b694815cd2909d97dc1f457cf55f3fb5233bc83775c167d87460a	f7416ef3b5a765d3eacf158857defbbaeec3fd30cd06a7c208e4be48c5643925	7200	\N	2016-04-22 14:27:37.279603	user
382	3	\N	f4b9df1bf71e234d14fe4707a2f71f49827ca05d01c47a5fad9cb7edbf959474	1522f34cde8d8cf72bc9bcec1962b761f6056e0e15dcad9013c7df16d68d9437	7200	\N	2016-04-22 14:27:37.492832	user
383	3	\N	e0ea52203572a350aea2577789817e691287fb73f152a883a80853e90a717b0d	73e91fdfeec46836b80a834afc4669ad0119f75966a7b00c01feb6ec8b43dd10	7200	\N	2016-04-22 14:27:37.604623	user
384	3	\N	deb0a5dd13969c5fff6c47855186bc48e41866852e452051241ac742ae6306d0	c5b8c65e8dfca9e250e2da8ad61ae2ab3fc5a74ff1096c36d4f1007ecb3ab59f	7200	\N	2016-04-22 14:27:39.184154	user
385	1	\N	6cd541d6024cb02dbbea3937488325153679e5d30b5de86dd33ddb09cc88aa4b	0140615f068f93079dd5f336e55124340f129770e75e12c8f618d15f463fb765	7200	\N	2016-04-22 14:34:37.353325	user
386	1	\N	e5ab08ce9967a1c29b43be51bd6acb649cc372e911b540242073eafaed4491f9	dbc0d6deca1838b95148d2758e3f397c4db6b5ce95b708d27552c39ba5dfd6b7	7200	\N	2016-04-22 14:48:04.392369	user
387	5	\N	0cdeaa51ae716a275dc8a04ec267627fd6bab899f408721531d4e9f10f3e99a6	b8d107c06e729b432c03ad32ff64eea5ec40f0d865935bb31592e02054dfd284	7200	\N	2016-04-22 14:58:19.889788	user
388	5	\N	a0b03a93c4b71123980faa11a44a9f776e38501e48021e8420eb5c5fea6bafd4	b0735b8fab8977657d695bc1b7567fc24f01abe0a0d681e65e9ae0e8de74f293	7200	\N	2016-04-22 14:58:20.215329	user
389	4	\N	4e79c29176eb65468ba34a6ae4cb13a71e18f69200ced81239362e199ebfda1f	6ee259c5006794ef5c54e725677d5ee90c3f62e4422feb1b08bf868227f11ead	7200	\N	2016-04-22 14:58:31.09318	user
390	3	\N	721420d0fd83d939234af582358dcfdce724a8851849e3cc12ab5abc3951cd66	413a0ec5eb5caeb3d200829b2285b1eec64ce8ab206824052297f75197155df0	7200	\N	2016-04-22 15:15:27.750281	user
391	3	\N	ffcc83cd23b9ec6e2791b89703374975914846be5a9b9dc35aa6c391430dbcfc	1955464d32879e966d3a2ab0a25de00bca4ccac1db591165f74b6ce25fd5dec3	7200	\N	2016-04-22 15:45:20.064054	user
392	3	\N	7ef029f6569d0ef0d0831127f36f0b4bc00a75778ffb161b3c53a0cd6d417763	a5b29ce3c411099aee6bd3eea2b53dda42e9a73c5529d84ba45a654d466a85e8	7200	\N	2016-04-22 15:56:51.858031	user
393	3	\N	5a0a3607b345a5d3c175d591b1c94dc4c0380e71048930acbd4ba55cd8b0f982	134165bde5925c62bcfb614afa0cecf13b5ac8b76a29cbfdd90e8411750b3190	7200	\N	2016-04-22 15:57:53.989211	user
394	3	\N	9329b134b6db3fe12d47c42aa1021395bf6e635cdb4b7d2c05b5bc01c15500d2	608ee4b806227f747bbb30eb40442e9298148df0785e36a2a81e16013d18d113	7200	\N	2016-04-22 15:59:39.845503	user
395	3	\N	d2aa13f35f99597533d372d61d1ba37fd1fce110fafe5603ad397ca26c493de9	250e0eef361038abc2554ddb655162bd81edafe4ca37c8768bf7dfe356d3927f	7200	\N	2016-04-22 16:00:32.756062	user
396	3	\N	73d8fa3a77c38f4917da0d1b4db0fc38c7a4abc83ae1d02a4cd9cf2300af6771	ac93aca9079b783bb897ec6f7a40ecb9a18daafea597c01e7be5c7fd312ad6b1	7200	\N	2016-04-22 16:03:37.500976	user
397	3	\N	e06a09b9c085c86840a626d4726c4a40cd102cea0f54b8fd29a6d1fe2aa5efc2	59dc360e496bb11ebf4c69266bae3b6b2c0caf8be4cd458e9777f0d3796fdd9e	7200	\N	2016-04-22 16:04:38.037944	user
398	1	\N	8714c545f46ad6652be242c214295b17cf0ac5a8add45b359fa1e04ab7778428	67b3de65f3eba1178f8691741b3e83db2103ea322b3b0704cadfec50d15763c1	7200	\N	2016-04-22 16:05:17.672746	user
399	1	\N	0a8b89db0a1a985e102a7d2975e3c723f954ebdb11ff75581bcc835390be4a98	e03ebe0ff14c441140999bd3be00a4b9e5e3fe0f28c7525bd3fd165b47edb89c	7200	\N	2016-04-22 16:05:47.713383	user
400	1	\N	5a445a7edcc3215d0f822748399243d968f2d36748f1a4c946b4399884e0824b	d2403a9473683c13f65e618a8fea43fd19e685825399e1843b46db7599f88bf0	7200	\N	2016-04-22 16:06:21.46468	user
401	1	\N	4765e7dc3fc0df657deac3bd3519df18720f36c5e981b4398d61baea3f0eecf9	cffb22082061c7e96dd9fa4d6702dbdeb2cd22f9ee9197621010505c87245d7b	7200	\N	2016-04-22 16:06:53.815074	user
402	3	\N	632257f836c46a9792f35e137b90fdaf93f405f607edde358a29d9a1e1230e54	3d473018db1690e74c975627d0368b0ea476b17ad6005c1814288192e3e542ee	7200	\N	2016-04-22 16:07:16.986991	user
403	1	\N	86fb91b92ca53809b335c1e433ce7149c3b77572117b272fd82c3cce36c54978	c74569a209167557257f059f9f6a6d2dac2bad1ebe9eb0505fee26ae9d9f6e52	7200	\N	2016-04-22 16:08:31.460559	user
404	1	\N	ff5c6e219848de53ec47098e29747550a3929d6d0b26b2b21b90c95b646bb995	6c51e6822cdb59d5257a6e8b92abfee75d72ec9e88bca38cca1f1d141fb6751a	7200	\N	2016-04-22 16:10:00.032619	user
405	1	\N	d5fd90e97c2ff13964c4f61b269eda3ed698d7cb0c9a157c47b44216a9eeb5a2	44ae389e3e7499a6214d1cb9a5e55ade3b2efa20b1c600cc6591d98ef3497b86	7200	\N	2016-04-22 16:11:04.051842	user
406	3	\N	ae65204c7b67f9d72e91aa965434521e5e00649eedfb5f21c35ac4fe3a93fd04	14a8a4bc2dbaaef56433bc7d505749ded400fca6000bd1a01a6841c8d424ab4b	7200	\N	2016-04-22 16:14:57.359284	user
407	3	\N	13d51ad8bc843dd39fcb4bfabd07887206b4359fe744780150f75c626234b565	3ce9d1d9213371d73be69585d8ebe6d5a002a87692822abbf36c3afdb5d77259	7200	\N	2016-04-22 16:30:19.009482	user
408	3	\N	de253f2b51d85029b3134e5d1dd929547246b986fc9d813ad88cd00b49899cf1	8f3d2659e1ea8a93ffcf5f6a59f2e70fa5b3b854921671fae8b77f27e1f8ba15	7200	\N	2016-04-22 16:31:47.168764	user
409	3	\N	696b65a84b9761a748dda5bbb2eb8059d7704a56ca5178fc060f4b55d603a0c1	984170ec0d438c77c629ad6ecfdd0935f7a91aaa99ea178522f3940eb5dba5e1	7200	\N	2016-04-22 16:35:46.668941	user
410	3	\N	828c69c23071c7c1242e2c3409537e08fedffc4ecf59a430df4a5e8889562594	4910239298e20166b3f8c5fe0400189d2045d346374aac364654e900814223b7	7200	\N	2016-04-22 16:35:46.786637	user
411	3	\N	ab046b47f42e2a28c91173b141552ccc752634cd28932cff1bd3a68bcd551f31	96aa5bd824ee99103fd5b469fba331a1e96e2c0981ed1e9b3227643bb8d811df	7200	\N	2016-04-22 16:43:44.396964	user
412	1	\N	ba6af66a0dc84040ad1d1046cb1bbb2837f6a61c4b7e42df9532db3c6cc07184	3b604196dcfbd55db00ec8bf4bf5940d461bc50f49ce45d360a0be9990ab85a9	7200	\N	2016-04-22 17:00:28.67965	user
413	1	\N	ef2fa7b322b43b08799c1ce10ad490ce2f3ccd780ca34b5e55442092d8dc9280	73b0fbb0aa8f16d1a5792a9234b3ca7d430a298490c414ee3007ca077dd55b7f	7200	\N	2016-04-22 17:01:19.586082	user
414	1	\N	db04c2bb9e917bf45fb341a8bceeebe444f00710c4d8be74e54ede5a911715da	5b6f01cbee5a52d9215981c0ece7df0631c5663625ff9c5ab2330cfdf13dcbd6	7200	\N	2016-04-22 17:09:59.394907	user
415	1	\N	a1cc16793e0a8cbf142c080179ec6151ca4a8ed1318afb2f322b89cfe5beaaa6	27173d38117d378d3c42919380eeb246c9d048f7ed56e659bb70e1e3028d3109	7200	\N	2016-04-22 17:13:38.586678	user
416	1	\N	13124977a825574610f22142ce1f3f1a033c64b50ac590d06c47dfdadb6fa5c8	95e6af577223af3923fbbe5d5cdb0c7a7575bbd7de56a59ef1f66b24fa4b49f4	7200	\N	2016-04-22 18:19:39.773202	user
417	3	\N	c7f3e715109425f58dd55329b6a9ab47603a1bd09a8a4b9d374f9f2335d15877	6d3eca2f0a765071a6ac58febfeec9724ecb2b196cd2e3a53b6b47a014101725	7200	\N	2016-04-22 18:27:13.003239	user
418	1	\N	da6275cfe65d7ab6d2b1b3f3d497502eb3da08ecd7a28a718201e7a846a9867c	5a7b65cb94349b6bbefeca54889338b15f9ce8898d20e2d5fc31995421f5e9c7	7200	\N	2016-04-22 18:33:03.699097	user
419	3	\N	6e0da6676bee658149123421bd90b4f8a1fe1595403cbb4f2ae973b1e9a82919	564a7b2db8f5c6de4b7e93d07c41a7708225bde3749cedf07396a4c1cac2e4db	7200	\N	2016-04-22 18:36:12.417856	user
420	3	\N	de37821e4a474e1faf979590bfc8d4e916bd2b7d9c4b94f671c21e45e6e3b2cb	a6bd21f6385cdf22e9c56668d85ac646046da64426cb444c18f41ace1b066728	7200	\N	2016-04-22 18:36:37.729594	user
421	1	\N	aaf631e61406b18a6db2b32de8fdefcc9c6397b7537b3a7a223c10526851b7bd	4f7c09e0e04387c535be897c2b50796d89c9c5981f250730ce88007e95e26998	7200	\N	2016-04-22 20:22:12.494874	user
422	1	\N	aafa85bb0a74e5e9c5899b006eaada349bc494a8b1654be24a38cef8c512ec2e	33f9082302cc5fc670dde0be9fd2400d57207d9aa6064d6d779f82c3a8f8315b	7200	\N	2016-04-22 20:32:50.295108	user
423	3	\N	05dc750f2c7353e046832645c65a69c4c4c3133702ecfbc618c301516f598ee8	587bff24a72533d316f65b1e77ba4beb80b1dc56734e9113bffc00a11fa2ca8e	7200	\N	2016-04-22 21:24:19.943504	user
424	1	\N	74e27155c5bf995c46e471786ad46c9e28e7a8dc38d084cb16838627dabc62ec	b25689f45371a81da1d84fc0e5da9e84be4dab8d1eed05985915ac65f2819e7f	7200	\N	2016-04-22 21:46:39.734897	user
425	1	\N	820e8276c566e407331947ccf0e8abcd12daa7d5b27c97be0e092746354788a7	37f95ca2ffe56f503715d8390d12b4b8bdef3844fc04a52f1f39d3ec8e287088	7200	\N	2016-04-25 12:37:59.738875	user
426	1	\N	54ab788ada029813288a8c0b1882429e643e320c61186ff53589b876cdc878fd	da6f4a0f53849ddc12a9d7c5038134efd94cca316eddad14145fbbd37fe3c911	7200	\N	2016-04-25 13:32:59.222054	user
427	1	\N	b426e5d16a4fac52d7a63410ace636f792e67a81b5428c625a48af93489d9929	a58b09e5d779e902506075f3807600cabc76da7e5760dc31765394bb6b710bb3	7200	\N	2016-04-25 13:38:47.684589	user
428	1	\N	c2040d39f90ffa189673be141a6a0343f71a5fe608891c14657df4d3901aed76	5856cef15fe899334fcd587468ee49ddda12e5d15d1afec3bafa40cd69f33ccf	7200	\N	2016-04-25 13:50:13.514273	user
429	1	\N	5c1e45c21ca041a0f2b3a5225c1bc73c8a9240005367c5b405a245ceedaf0379	5ca331a7af6457b6ee7767714de74e5051f8066a792a134756ef60a4ab89a5d4	7200	\N	2016-04-25 14:26:13.914319	user
430	1	\N	b821588785ca2d2e076c8a9012c9773f40a5ca6553224f676083532a146c3253	f6d3f4bf43809525e59e1b998027bdfe513a65103f7dbb79856bba54c7f12f00	7200	\N	2016-04-25 14:27:44.233621	user
431	3	\N	a0fb72b19f043d5cfebec41517b534b8a1dc05f5709bd66918e96068bfbfc7b6	bf668333ce1f4a03518b390ef0d09d9d9d5c736a170537d7d5c2d37e5917a08c	7200	\N	2016-04-25 15:04:59.049185	user
432	3	\N	03e53074e407fe4eba4a43fc0a6fff3ee6058c79ce814436f182b9d00e4215fb	74fd416199d07d2f888fc3982705cefb1fcf9358b81030ba3e920f24d64433c8	7200	\N	2016-04-25 15:12:51.870716	user
433	3	\N	513e159f9cafa3c3161b1f722817a4e9dfcb09274266d889e3b2aeaef7ba8d6d	d2c3e67a09722110e5582ebe63801e8e881602e108d9c755711f065004cf40d9	7200	\N	2016-04-25 15:19:25.867961	user
434	3	\N	800f44e39406cbf96161fd7ab21e06608befee4c9c360096ac1b38ae36d4b2df	72295c51d1826861f0cdfbf37c0c57b6f79c04ad19ad6ff86b2272cf746d61c0	7200	\N	2016-04-25 15:25:14.852203	user
435	3	\N	8886a71240a15c851e427c4cb20dca66c755f2c10d8f7c43158c303a6c982293	882d2f2a0dbd3b9dff1ffe903cbc22a24d943b6412ab39621ca26e1452485764	7200	\N	2016-04-25 15:30:06.369954	user
436	3	\N	3874a13d67c492a70c0b81ed0e0bd1cd584a36931151d7b80214945d8d9d2738	ccd8191c6113ac126bbd22558870627638737307a4e8597f7b7c1060ff885c3d	7200	\N	2016-04-25 15:33:44.671391	user
437	3	\N	45f1df9bf7a95684595d35e9b1e293cc2302a105c27f9d12700a8b84f7b690ec	21827ce42f951903bce4aa72778e095e13ed70370bc0993a2cfdefdeb6ae8ba6	7200	\N	2016-04-25 15:37:17.90793	user
438	1	\N	06dd3e1076f0e0a8710448ff7bff143d9dbae251726c01ca2bec9aec58c010a7	e16771d11c3adeb663b0ff17cb0a4cf470920a6b65a9e52c2535a5d6cc7e5e08	7200	\N	2016-04-25 15:39:49.427549	user
439	3	\N	a9da705fd30dc12420b32dd9abdad41732d728e1494c48995e6b3a26656cb2e3	fd959f71438f4a1d64334ea544535335797ef2a1d6b8fb51d87a58b3e3747710	7200	\N	2016-04-25 15:41:03.674417	user
440	1	\N	ff43ea72e45a0fa2e233ba356a1a63063e78f1d8046b214da04fbf14622196ea	58653adceb039ca35a6482b277bde596e3841b200bc2ca46b4865efbe74b9cf2	7200	\N	2016-04-25 15:46:11.939705	user
441	1	\N	cbeb042736f6013f36369a0001aa8b73a599a3983b7b77bfd4608697154014dd	e6ee8e2c0b2d1e2e0fe21b98dc11284d2ad70c25bdf4c4298da61c385c44142d	7200	\N	2016-04-25 15:48:38.143447	user
442	1	\N	06640bb73d20f0f8b53f2015ef78e9d914755d80431e02ccb3c5d353dad43d4c	fb12cd50b23a4ef6bd952196bc3f3516f36abb1af916bba9d6a6869970835750	7200	\N	2016-04-25 15:49:37.215595	user
443	1	\N	9efd8904aef0eeaccdefc825e6031546a652179a39be5ab90bff183ed6d8ab4d	add6748319e1ac99aacef5433c52e4fcd370925613e701ebd09d24e4a4357535	7200	\N	2016-04-25 15:51:34.77779	user
444	3	\N	8dc295f4e74c5603064fd730e98df8995267ebf94d6ce13343e1dec7e4a42f81	8800335a3f5f93cb47a99262c8a8fe5d8b98e95dfc942cf65c8c418dc155399a	7200	\N	2016-04-25 16:02:15.295482	user
445	3	\N	ad6455bb723db6cc0d8397d6d61dd2b5df12878c42a2011d8342fd6a71718c40	948044510179b86b376ab8d0d33d7fcf73c1a12bd49465ec9ed13cc6c2b51e3a	7200	\N	2016-04-25 16:05:00.497489	user
446	1	\N	200935b7a38a6a208b833435212d0928ce7a312d661bf3f2180db3f77e76c1d0	cd253e5af8ecb756ce52c23575351c9989b628c44ad79e8d89bceefe78120231	7200	\N	2016-04-25 16:57:52.304371	user
447	3	\N	20c4a6518d13e3afd0ad987ab70fe8194a4621219eb7a5c581d52d8cdd13e57d	a8c03c2ecf88b9b1531128ec7d3efff5aa63a3200a94400ff6aa35ba248ddddb	7200	\N	2016-04-25 17:03:44.192047	user
448	3	\N	42ede141429c531fc20b02c699bbbd9a6a1633cd788a4d7f3e7c8a511ac246a4	fe09f1d9e48e1474efb71f4e9d9c5b393e8cfea8e5819809b877c6fcbe460797	7200	\N	2016-04-25 17:06:09.092635	user
449	1	\N	900339feb536eab9f98b0800dbfadbab3542f19e65593bf807e54c52bfa1a5ea	872725fa709561f6f8bf12247674ceb05cf486323cc61f045a0826bebf055b86	7200	\N	2016-04-25 17:25:04.796581	user
450	1	\N	40ccd505a1c16f7bbdc86473f19d31c0e2cf24bf623999f1702611ed8ca76a37	a1f5e2342cb2058a619389f1e9d143e94ee38f7e2c0c1a5b9ea2c1a24f8b40b0	7200	\N	2016-04-25 17:27:47.142447	user
451	3	\N	2a1a8e6ac795568b38885ef9d9db79c9b94d7b4ae92b5ab8ddd6717daf7fd0c4	661c66b24120cdf1d1e321ea99e5d66ae9d0df3ae2a7e5a41f31d7f278398f58	7200	\N	2016-04-25 17:34:05.752611	user
452	1	\N	b9c2710231c8360eb52ff766bbcee460cfb65d10f8c1c3bbb87766362e2cd6e7	3010a9d007878f200d01eb4f2ced04557b35a1e4146188a7c5d34f97f1ff19bc	7200	\N	2016-04-25 17:38:12.036243	user
453	1	\N	304a2582e98cf381e2e270901089a2e95e0d210e940ce20950906a608f4ab427	564dfe3cede57a86d39a400f28d8d64b5b579eb7fc31d66a0279cc757a75218f	7200	\N	2016-04-25 17:44:59.590669	user
454	3	\N	5041c62ca7db178b7fea44692f6e1e808c12f3e15e7a3515336d000e7ea407a6	1374ea8dd020d8763c72eb8e2e3dc9ca4d900383ab9d84ed128f3b439812a689	7200	\N	2016-04-25 18:03:18.401224	user
455	1	\N	032f121a7591c57c2f0e0824222bed08da49f074b09882d68f450191cda38e72	4fc3ff628b05153cd6d5666963a3e072056512edfbd65888c9a7125fde15c5b0	7200	\N	2016-04-25 18:08:24.538762	user
456	3	\N	ba87c6b677afbb7501023f4a2bd69428b9e9e4e65c0458988893a28abb167515	c30c2a0508e50b68d8d42267df3e04649c559ed791bf89ae2415e1a184febcb8	7200	\N	2016-04-25 18:11:48.46109	user
457	1	\N	df4a969ffefb78fa7594d6fd4f9e09c6b4d7f52522ada23ef9def398da49525e	9d6984547781df592b36a12cdf6004960f20c104b1f2847f2ead87b86d52a045	7200	\N	2016-04-25 18:12:57.872512	user
458	1	\N	ff7be3ac2aa889e87e47da58336d50f208eb248d668c1db16a2d8642989474b4	2d1c3519cc3d8b3b216b3509af98f982ca06c82d340b11c864c16ec1d72db225	7200	\N	2016-04-25 18:15:05.308245	user
459	3	\N	39937dcd496359f1855ddca0dec4bd790b801e580e304b198de5d40c2916be85	a554e8587a30e538f59d1d8f1ff128541d38c000281a92b3cbdd5bdd64842606	7200	\N	2016-04-25 18:23:37.092218	user
460	3	\N	fd70a64375cc1b6162601c4d086b5fd563dc66d4358e238724e3739dc4c7908a	05424591923966fdbf45b2959420877847d5d08facb6c032a51bc93dece1ecc0	7200	\N	2016-04-25 18:27:38.042469	user
461	3	\N	6231d6f913746d8de6e04bf037f78a99c22bc8f432b2162f04820626ca3802c9	8655ef72cad9c661f88257cefa4bb1f4705a98dbcd05a0258d0b5f51bf63e3c9	7200	\N	2016-04-25 18:41:49.890223	user
462	3	\N	c79de429155d9c40e6ff1b64b31e224fbb17f74a861bbe19ba1bdee1ec2194f2	7169624015253d73084aa91dc203425f4da19b1855f06251d9a936d50abb551f	7200	\N	2016-04-25 18:48:28.210532	user
463	3	\N	4a528a46f50355b0dae41961096bebb713d0b0862a967da189e0c61ffc0f11fe	4277fd2b47480c0aae64097eae69a7347209ffa0dccc59836bd4c1cc20040a6e	7200	\N	2016-04-25 18:53:46.014222	user
464	3	\N	89d9692af9cfa7cec9c8cf5668859646c676e45a0d81c6bfe214be38afe8269c	7c9eb2b2a86abfef79b68c77d0316f2c736e9da638cb2b802542bb8dee73ab9b	7200	\N	2016-04-25 19:11:59.149829	user
465	1	\N	505e2045b438943781f0f4dbc84d94ac6e69a887339ccc2245d87f8937099832	fc6df426150110819bded34340fed37957f8c5edfdb4e7470783bc8bf6724249	7200	\N	2016-04-25 19:14:35.564356	user
466	1	\N	e164a2dd8dfce22c9aee84313bd38a5e9abf81508261687e6c5c107188b32371	0f69fb7e0517d156d4a01898930d94dcab38ba50db9d60dfc4475b183e395e75	7200	\N	2016-04-25 19:15:06.36442	user
467	3	\N	46ff07c4b10e6c016b0c3290a0cabc4ea990df67a989c3ae438a03bb7b4ebc14	11a0f72b8faa891325bf0dfb5c7a43d82532a4b06b77cdeae5ebcc3ea8c9765e	7200	\N	2016-04-25 19:15:09.221651	user
468	1	\N	87ec9d498bfe978823f39c3d761c4a8cc4f44473f68504e8d5bd3e7582ab3c3c	21cc6dec0e7d1eac2152b1f5e7d498c4e17598936d1b4fce811bcce5a5879b04	7200	\N	2016-04-25 19:15:42.408298	user
469	1	\N	899954f9d903e7acd84f76acb2fbc7baf11e856db88bdf25c07018e142e538c3	c78919dac0c980b8a0a82135b9eeed6d8deff03d25e6d33d72bc27149b2812c6	7200	\N	2016-04-25 19:28:08.794227	user
470	1	\N	84aa44b7833697b77da5f66042480b77c0e6eb97beb3133a8b719bcc3efe75fd	afb14197cca85880a3f226ebbae85fb553a7ba9c8586fc3a56e881cb99c621fb	7200	\N	2016-04-25 19:28:21.750167	user
471	1	\N	b41daa5f7b8595963d69b2c50d582ef83c4cddc98b6af420f2b1097f7e1e1585	e9e4ba88ab2398c7d6b5a4d3d28fc4d313945733a306edf1bf500b86ce87665a	7200	\N	2016-04-25 20:00:22.567116	user
472	3	\N	3691661a21ce1e574f1efdb6d39e0923ac49299eb143768bd48d15cf59bdbb6a	b1916b2ddea6c117add5e223c12f2b8e4d3fc3f282cc5c5b0f77d644412a33f0	7200	\N	2016-04-25 20:04:06.986686	user
473	3	\N	22d6bc0e55c6c2420f6a581622155fcfbbe8a43f0b846746e332e0f7c2f529f5	a34e4b532ca4c4d6981f909ab15302bc66375ddb4cea389c1e9ceecc79600eee	7200	\N	2016-04-25 20:07:37.673049	user
474	3	\N	6a944e08eed686ba9579aee1d493ce1d06678dc3d5f292ea7322712ffeb4d120	45f885b7373b007d9f9db01819f61f44de2d550d3e9f780bede4498104b61cae	7200	\N	2016-04-25 20:10:07.023025	user
475	3	\N	565e451510fd34631a5bf229844b4e762f99b5998084ecd9de8d3079c5baddfa	9450d71591b03c04ae894717ad9cc7639b9d286600e0731fea27c2098a730f4d	7200	\N	2016-04-25 20:13:01.835398	user
476	3	\N	a036564a6bd91341486220b7a41b1e9706d4d95f29163d9b2fde3b5d6e3f0a5a	32ab2b3c2e4c65d639875251319457e23a320d856072b48eec4a29b8d29bf2e3	7200	\N	2016-04-25 20:16:00.824456	user
477	3	\N	9fc907abdd18a7d4bead9274fbc3d7e3216429c28e1fc0dbc2a34cd25830c426	7445a8e42ac2540c31394beba3fa928e09a0197405d9012767609be8a5772eb5	7200	\N	2016-04-25 20:19:03.28509	user
478	1	\N	4455341a1fd8c70fe6025ed1b2150a878056767c453ecf53adc05ca14555fb1c	47ac89e368784ceb07d5f6687e05b20d4a962c63746af79266790db094d45268	7200	\N	2016-04-26 13:22:47.830683	user
479	3	\N	847a227b2f84edff5f24a233e4a25147042dfd1bb20c465a5fb7d57b7e87223f	592ad28f2baa332bbb1682aa50c16c517fcc71779b1b2677cd79dd39dee34928	7200	\N	2016-04-26 13:28:37.203629	user
480	3	\N	3e4a8a34e5e25f46348c5dd9809fffe0cd3941513027f56c7d3b88a1965066d9	c581add855f9982aa1fbea0a1a9cf84af820a4056908b11d64512608d640c53e	7200	\N	2016-04-26 13:32:06.621258	user
481	3	\N	a65e8e91974060901a0ee1cacf12ac2170b0eb29fffc41ae607008790c44d596	1110640caa0b09584983fe7f561f7b23eb34bf78f385cb8d0a5a984949c96d0f	7200	\N	2016-04-26 13:40:49.903425	user
482	3	\N	b6f544ec5df64765684ec57b271520352549f8b217a628886a6e8a7198d99938	40afa08f24e07909ddc1043701a9b0b7f7090a43d6465945e638dcd6c2f59d47	7200	\N	2016-04-26 13:51:16.535804	user
\.


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('oauth_access_tokens_id_seq', 482, true);


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

COPY reports (id, organization_id, report_type_id, dynamic_attributes, created_at, updated_at, creator_id, limit_date, finished, assigned_user_id, pdf) FROM stdin;
36	1	1	{"sections":[{"id":1,"data_section":[{"map_location":{"latitude":-33.4428552,"longitude":-70.6258573}},{"zone_location":{"zone":"7","dealer":"6","store":"11"}},{"address_location":{"address":"","region":"Región","comuna":"","reference":""}}]},{"id":2,"data_section":[{"protocolo":{"checklist":[{"type":"boolean","value":true},{"type":"boolean","value":null}],"observation":""}},{"kit_punto_venta":{"checklist":[{"type":1,"value":null},{"type":0,"value":null},{"type":1,"value":null}]}}]},{"id":2,"data_section":[{"stock":{"amount_value":[{"sr_hardware":[{"platform":"PlayStation","value":""},{"platform":"Nintendo","value":""},{"platform":"XBOX","value":""}]},{"sr_accesories":[{"platform":"PlayStation","value":""},{"platform":"Nintendo","value":""},{"platform":"XBOX","value":""}]},{"sr_games":[{"platform":"PlayStation","value":""},{"platform":"Nintendo","value":""},{"platform":"XBOX","value":""}]},{"hc_promot_ft":[{"platform":"PlayStation","cant":""},{"platform":"Nintendo","cant":""},{"platform":"XBOX","cant":""}]},{"hc_promot_pt":[{"platform":"PlayStation","cant":""},{"platform":"Nintendo","cant":""},{"platform":"XBOX","cant":""}]}]}},{"venta":{"amount_value":[{"vr_hardware":[{"platform":"PlayStation","value":""},{"platform":"Nintendo","value":""},{"platform":"XBOX","value":""}]},{"vr_accesories":[{"platform":"PlayStation","value":""},{"platform":"Nintendo","value":""},{"platform":"XBOX","value":""}]},{"vr_games":[{"platform":"PlayStation","value":""},{"platform":"Nintendo","value":""},{"platform":"XBOX","value":""}]},{"hc_promot_ft":[{"platform":"PlayStation","cant":""},{"platform":"Nintendo","cant":""},{"platform":"XBOX","cant":""}]},{"hc_promot_pt":[{"platform":"PlayStation","cant":""},{"platform":"Nintendo","cant":""},{"platform":"XBOX","cant":""}]}]}},{"more_sale":{"list":[]}},{"stock_break":{"list":[]}},{"competition":{"list":[]}}]}],"creator_name":"Pablo Lluch","report_type_name":"Reporte Diario"}	2016-04-22 16:46:23.666626	2016-04-22 16:46:26.021456	1	\N	t	1	4dbcb580e175d6088d652839a1e4b8c6.pdf
37	1	1	{"sections":[{"id":1,"data_section":[{"map_location":{"latitude":-33.4428585,"longitude":-70.6258417}},{"zone_location":{"zone":"7","dealer":"6","store":"11"}},{"address_location":{"address":"Luis Montaner 461","region":"Región Metropolitana","comuna":"Providencia","reference":""}}]},{"id":2,"data_section":[{"protocolo":{"checklist":[{"type":"boolean","value":true},{"type":"boolean","value":null}],"observation":""}},{"kit_punto_venta":{"checklist":[{"type":1,"value":null},{"type":0,"value":null},{"type":1,"value":null}]}}]},{"id":2,"data_section":[{"stock":{"amount_value":[{"sr_hardware":[{"platform":"PlayStation","value":""},{"platform":"Nintendo","value":""},{"platform":"XBOX","value":""}]},{"sr_accesories":[{"platform":"PlayStation","value":""},{"platform":"Nintendo","value":""},{"platform":"XBOX","value":""}]},{"sr_games":[{"platform":"PlayStation","value":""},{"platform":"Nintendo","value":""},{"platform":"XBOX","value":""}]},{"hc_promot_ft":[{"platform":"PlayStation","cant":""},{"platform":"Nintendo","cant":""},{"platform":"XBOX","cant":""}]},{"hc_promot_pt":[{"platform":"PlayStation","cant":""},{"platform":"Nintendo","cant":""},{"platform":"XBOX","cant":""}]}]}},{"venta":{"amount_value":[{"vr_hardware":[{"platform":"PlayStation","value":""},{"platform":"Nintendo","value":""},{"platform":"XBOX","value":""}]},{"vr_accesories":[{"platform":"PlayStation","value":""},{"platform":"Nintendo","value":""},{"platform":"XBOX","value":""}]},{"vr_games":[{"platform":"PlayStation","value":""},{"platform":"Nintendo","value":""},{"platform":"XBOX","value":""}]},{"hc_promot_ft":[{"platform":"PlayStation","cant":""},{"platform":"Nintendo","cant":""},{"platform":"XBOX","cant":""}]},{"hc_promot_pt":[{"platform":"PlayStation","cant":""},{"platform":"Nintendo","cant":""},{"platform":"XBOX","cant":""}]}]}},{"more_sale":{"list":[]}},{"stock_break":{"list":[]}},{"competition":{"list":[]}}]}],"creator_name":"Pablo Lluch","report_type_name":"Reporte Diario"}	2016-04-22 16:50:37.941715	2016-04-22 16:50:40.153605	1	\N	t	1	b472a44f916e3d487a1fdf502417d015.pdf
38	1	1	{"sections":[{"id":1,"data_section":[{"map_location":{"latitude":-33.4428732,"longitude":-70.6258431}},{"zone_location":{"zone":"7","dealer":"6","store":"13"}},{"address_location":{"address":"Luis Montaner 461","region":"Región Metropolitana","comuna":"Providencia","reference":""}}]},{"id":2,"data_section":[{},{"kit_punto_venta":{"checklist":[{"type":1,"value":null},{"type":0,"value":null},{"type":1,"value":null}]}}]},{"id":2,"data_section":[{"stock":{}},{"venta":{}},{"more_sale":{"list":[]}},{"stock_break":{"list":[]}},{"competition":{"list":[]}}]}],"creator_name":"Daniel Hernández","report_type_name":"Reporte Diario"}	2016-04-22 16:53:46.736425	2016-04-22 16:53:49.007839	3	\N	t	3	9077d22dd20cb7653ea240d1bb666706.pdf
35	1	1	{"sections":[{"id":1,"data_section":[{"map_location":{"latitude":-33.5153623,"longitude":-70.6021602}},{"zone_location":{"zone":"7","dealer":"5","store":"8"}},{"address_location":{"address":"","region":"Región","comuna":"","reference":""}}]},{"id":2,"data_section":[{"protocolo":{"checklist":[{"type":"boolean","value":true},{"type":"boolean","value":true}],"observation":""}},{"kit_punto_venta":{"checklist":[{"type":1,"value":null},{"type":0,"value":null},{"type":1,"value":null}]}}]},{"id":2,"data_section":[{"stock":{"amount_value":[{"sr_hardware":[{"platform":"PlayStation","value":"50"},{"platform":"Nintendo","value":"40"},{"platform":"XBOX","value":"30"}]},{"sr_accesories":[{"platform":"PlayStation","value":"50"},{"platform":"Nintendo","value":"40"},{"platform":"XBOX","value":"30"}]},{"sr_games":[{"platform":"PlayStation","value":"50"},{"platform":"Nintendo","value":"40"},{"platform":"XBOX","value":"30"}]},{"hc_promot_ft":[{"platform":"PlayStation","cant":"1"},{"platform":"Nintendo","cant":"1"},{"platform":"XBOX","cant":"1"}]},{"hc_promot_pt":[{"platform":"PlayStation","cant":"1"},{"platform":"Nintendo","cant":"0"},{"platform":"XBOX","cant":"0"}]}]}},{"venta":{"amount_value":[{"vr_hardware":[{"platform":"PlayStation","value":"3000000"},{"platform":"Nintendo","value":"1000000"},{"platform":"XBOX","value":"500000"}]},{"vr_accesories":[{"platform":"PlayStation","value":"1000000"},{"platform":"Nintendo","value":"500000"},{"platform":"XBOX","value":"300000"}]},{"vr_games":[{"platform":"PlayStation","value":"500000"},{"platform":"Nintendo","value":"300000"},{"platform":"XBOX","value":"150000"}]},{"hc_promot_ft":[{"platform":"PlayStation","cant":""},{"platform":"Nintendo","cant":""},{"platform":"XBOX","cant":""}]},{"hc_promot_pt":[{"platform":"PlayStation","cant":""},{"platform":"Nintendo","cant":""},{"platform":"XBOX","cant":""}]}]}},{"more_sale":{"list":[]}},{"stock_break":{"list":[]}},{"competition":{"list":[]}}]}],"creator_name":"Manuel Quero","report_type_name":"Reporte Diario"}	2016-04-22 14:44:25.018759	2016-04-22 14:44:27.545113	4	\N	t	4	c53180b0fbc1de0c3b7c4fc5d68ba30c.pdf
\.


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('reports_id_seq', 38, true);


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
20160420030309
20160422145650
20160422213053
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
5	Falabella	4	2016-04-22 00:05:58.514802	2016-04-22 00:05:58.514802	5	\N	\N	\N
6	Paris	4	2016-04-22 00:06:18.943373	2016-04-22 00:06:18.943373	5	\N	\N	\N
7	Ripley	4	2016-04-22 00:06:25.049467	2016-04-22 00:06:25.049467	5	\N	\N	\N
8	Falabella	5	2016-04-22 00:07:02.287709	2016-04-22 00:07:02.287709	7	\N	\N	\N
9	Paris	5	2016-04-22 00:07:09.598361	2016-04-22 00:07:09.598361	7	\N	\N	\N
10	Ripley	5	2016-04-22 00:07:16.430748	2016-04-22 00:07:16.430748	7	\N	\N	\N
11	Falabella	6	2016-04-22 00:07:27.817255	2016-04-22 00:07:27.817255	7	\N	\N	\N
12	Paris	6	2016-04-22 00:07:36.701695	2016-04-22 00:07:36.701695	7	\N	\N	\N
13	Ripley	6	2016-04-22 00:07:42.605089	2016-04-22 00:07:42.605089	7	\N	\N	\N
\.


--
-- Name: stores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('stores_id_seq', 13, true);


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

COPY subsections (id, section_id, name, created_at, updated_at) FROM stdin;
1	2	Protocolo	2016-04-15 17:42:10.477011	2016-04-15 17:42:10.508445
2	2	Kit Punto de venta	2016-04-15 17:42:10.49289	2016-04-15 17:42:10.509684
4	3	Productos	2016-04-15 22:08:49.236727	2016-04-15 22:08:49.236727
5	1	Ubicación	2016-04-25 15:27:24.125528	2016-04-25 15:27:24.125528
\.


--
-- Name: subsections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('subsections_id_seq', 5, true);


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
3	daniel.hernandezjara@gmail.com	$2a$10$vaLbouR6j8fFgqLFp90IKeNyic/Z6S0sYwyiO830ASpSM3o3Xg5Ei	1366	2016-04-22 12:05:32.674414	\N	\N	\N	\N	\N	2016-04-15 17:42:59.187912	2016-04-22 12:05:32.674939	Tantoteimporta	Daniel	Hernández	\N	\N	\N	1
5	orlandoflores1709@gmail.com	$2a$10$sm2PykSASCerbeiRUj1tqOUX4isx/GquayEJMNCeOkmnBjNgDY6Re	\N	\N	\N	\N	\N	\N	\N	2016-04-22 13:53:51.624215	2016-04-22 13:53:51.624215	12.642.650-K	Orlando	Flores	\N	\N	\N	1
6	panchojjorge82@gmail.com	$2a$10$/GIruwsP.iqPdcg2ExTwjO2jmuftR.6HN2rlwJ07R7aKI2rmwpb0C	\N	\N	\N	\N	\N	\N	\N	2016-04-22 13:54:38.035957	2016-04-22 13:54:38.035957	15.363.568-4	Francisco	Jorge	\N	\N	\N	1
4	manueliasquero7@gmail.com	$2a$10$unI.nA9MQFWi7f1cUvUhNO.wsbjLfnBe4Oa6X47LflELXX2KzQE6e	\N	\N	\N	\N	\N	\N	\N	2016-04-22 13:51:37.960018	2016-04-25 21:07:53.697643	16.287.973-1	Manuel	Quero	\N	\N		1
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('users_id_seq', 17, true);


--
-- Data for Name: zones; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY zones (id, name, created_at, updated_at, region_id) FROM stdin;
7	Sur Poniente	2016-04-22 00:00:47.909653	2016-04-22 00:02:24.81397	1
5	Oriente	2016-04-22 00:00:18.967798	2016-04-22 00:02:36.016832	1
\.


--
-- Name: zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('zones_id_seq', 7, true);


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
-- Name: index_data_parts_on_detail_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_data_parts_on_detail_id ON data_parts USING btree (detail_id);


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

