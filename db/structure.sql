SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET search_path = public, pg_catalog;

--
-- Name: address; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE address AS (
	name character varying(90),
	street character varying(90),
	city character varying(90),
	state character varying(90),
	zipcode character varying(10)
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: readings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE readings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tracking_number integer DEFAULT 1 NOT NULL,
    temperature double precision DEFAULT 0.0 NOT NULL,
    humidity double precision DEFAULT 0.0 NOT NULL,
    battery_charge double precision DEFAULT 0.0 NOT NULL,
    thermostat_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: thermostats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE thermostats (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    household_token text NOT NULL,
    location address DEFAULT '(,,,,)'::address NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: stats; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW stats AS
 SELECT readings.thermostat_id,
    'temperature'::text AS stats_type,
    avg(readings.temperature) AS average,
    max(readings.temperature) AS maximum,
    min(readings.temperature) AS minimum
   FROM (readings
     JOIN thermostats ON ((thermostats.id = readings.thermostat_id)))
  GROUP BY readings.thermostat_id
UNION
 SELECT readings.thermostat_id,
    'humidity'::text AS stats_type,
    avg(readings.humidity) AS average,
    max(readings.humidity) AS maximum,
    min(readings.humidity) AS minimum
   FROM (readings
     JOIN thermostats ON ((thermostats.id = readings.thermostat_id)))
  GROUP BY readings.thermostat_id
UNION
 SELECT readings.thermostat_id,
    'battery_charge'::text AS stats_type,
    avg(readings.battery_charge) AS average,
    max(readings.battery_charge) AS maximum,
    min(readings.battery_charge) AS minimum
   FROM (readings
     JOIN thermostats ON ((thermostats.id = readings.thermostat_id)))
  GROUP BY readings.thermostat_id;


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: readings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY readings
    ADD CONSTRAINT readings_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: thermostats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY thermostats
    ADD CONSTRAINT thermostats_pkey PRIMARY KEY (id);


--
-- Name: index_readings_on_thermostat_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_readings_on_thermostat_id ON readings USING btree (thermostat_id);


--
-- Name: index_thermostats_on_household_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_thermostats_on_household_token ON thermostats USING btree (household_token);


--
-- Name: fk_rails_7c067bcadb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY readings
    ADD CONSTRAINT fk_rails_7c067bcadb FOREIGN KEY (thermostat_id) REFERENCES thermostats(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20190821144350'),
('20190821201356'),
('20190822122805'),
('20190902215814');


