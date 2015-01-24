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


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ratings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ratings (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    title text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    section_id uuid NOT NULL
);


--
-- Name: ratings_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ratings_tags (
    rating_id uuid NOT NULL,
    tag_id uuid NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sections; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sections (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    color text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tags (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    email text NOT NULL,
    crypted_password text NOT NULL,
    salt text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    remember_me_token text,
    remember_me_token_expires_at timestamp without time zone,
    reset_password_token text,
    reset_password_token_expires_at timestamp without time zone,
    reset_password_email_sent_at timestamp without time zone
);


--
-- Name: ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (id);


--
-- Name: sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_ratings_on_section_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_on_section_id ON ratings USING btree (section_id);


--
-- Name: index_ratings_tags_on_rating_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_tags_on_rating_id ON ratings_tags USING btree (rating_id);


--
-- Name: index_ratings_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_tags_on_tag_id ON ratings_tags USING btree (tag_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_remember_me_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_remember_me_token ON users USING btree (remember_me_token);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_499709a628; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT fk_rails_499709a628 FOREIGN KEY (section_id) REFERENCES sections(id);


--
-- Name: fk_rails_523cbd1703; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings_tags
    ADD CONSTRAINT fk_rails_523cbd1703 FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- Name: fk_rails_f50cde9ccd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings_tags
    ADD CONSTRAINT fk_rails_f50cde9ccd FOREIGN KEY (rating_id) REFERENCES ratings(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20141115132046');

INSERT INTO schema_migrations (version) VALUES ('20141115132141');

INSERT INTO schema_migrations (version) VALUES ('20141122181032');

INSERT INTO schema_migrations (version) VALUES ('20141122195807');

INSERT INTO schema_migrations (version) VALUES ('20141122195808');

INSERT INTO schema_migrations (version) VALUES ('20141206185515');

INSERT INTO schema_migrations (version) VALUES ('20141206185923');

INSERT INTO schema_migrations (version) VALUES ('20141207110514');

INSERT INTO schema_migrations (version) VALUES ('20141207110608');

