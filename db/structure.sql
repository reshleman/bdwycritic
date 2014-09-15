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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: event_preferences; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE event_preferences (
    id integer NOT NULL,
    user_id integer NOT NULL,
    event_id integer NOT NULL,
    wants_to_see boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: event_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE event_preferences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE event_preferences_id_seq OWNED BY event_preferences.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    venue character varying(255),
    description text,
    closing_date date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    nyt_event_id integer,
    nyt_updated_at timestamp without time zone,
    num_user_reviews integer DEFAULT 0,
    num_media_reviews integer DEFAULT 0
);


--
-- Name: media_reviews; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE media_reviews (
    id integer NOT NULL,
    url character varying(255) NOT NULL,
    event_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    headline character varying(255) NOT NULL,
    author character varying(255),
    source character varying(255) NOT NULL,
    sentiment double precision
);


--
-- Name: user_reviews; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_reviews (
    id integer NOT NULL,
    body text NOT NULL,
    rating integer NOT NULL,
    user_id integer NOT NULL,
    event_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: event_review_statistics; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW event_review_statistics AS
 SELECT events.id AS event_id,
    avg(user_reviews.rating) AS average_user_review,
    avg(media_reviews.sentiment) AS average_media_review
   FROM ((events
   LEFT JOIN user_reviews ON ((events.id = user_reviews.event_id)))
   LEFT JOIN media_reviews ON ((events.id = media_reviews.event_id)))
  GROUP BY events.id;


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: media_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE media_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE media_reviews_id_seq OWNED BY media_reviews.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: user_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_reviews_id_seq OWNED BY user_reviews.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_digest character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    admin boolean DEFAULT false,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_preferences ALTER COLUMN id SET DEFAULT nextval('event_preferences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY media_reviews ALTER COLUMN id SET DEFAULT nextval('media_reviews_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_reviews ALTER COLUMN id SET DEFAULT nextval('user_reviews_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: event_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY event_preferences
    ADD CONSTRAINT event_preferences_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: media_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY media_reviews
    ADD CONSTRAINT media_reviews_pkey PRIMARY KEY (id);


--
-- Name: user_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_reviews
    ADD CONSTRAINT user_reviews_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_event_preferences_on_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_event_preferences_on_event_id ON event_preferences USING btree (event_id);


--
-- Name: index_event_preferences_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_event_preferences_on_user_id ON event_preferences USING btree (user_id);


--
-- Name: index_media_reviews_on_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_media_reviews_on_event_id ON media_reviews USING btree (event_id);


--
-- Name: index_user_reviews_on_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_reviews_on_event_id ON user_reviews USING btree (event_id);


--
-- Name: index_user_reviews_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_reviews_on_user_id ON user_reviews USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140818144801');

INSERT INTO schema_migrations (version) VALUES ('20140818151334');

INSERT INTO schema_migrations (version) VALUES ('20140818171425');

INSERT INTO schema_migrations (version) VALUES ('20140818193159');

INSERT INTO schema_migrations (version) VALUES ('20140818205532');

INSERT INTO schema_migrations (version) VALUES ('20140820170639');

INSERT INTO schema_migrations (version) VALUES ('20140821171658');

INSERT INTO schema_migrations (version) VALUES ('20140821174501');

INSERT INTO schema_migrations (version) VALUES ('20140822165749');

INSERT INTO schema_migrations (version) VALUES ('20140825193637');

INSERT INTO schema_migrations (version) VALUES ('20140829175123');

INSERT INTO schema_migrations (version) VALUES ('20140904191344');

INSERT INTO schema_migrations (version) VALUES ('20140905143607');

