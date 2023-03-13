--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: mart; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA mart;


ALTER SCHEMA mart OWNER TO postgres;

--
-- Name: raw; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA raw;


ALTER SCHEMA raw OWNER TO postgres;

--
-- Name: staging; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA staging;


ALTER SCHEMA staging OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;


--
-- Name: address; Type: TABLE; Schema: raw; Owner: postgres
--

CREATE TABLE raw.address (
    id integer NOT NULL,
    address_line_1 character varying(100) NOT NULL,
    address_line_2 character varying(100),
    address_line_3 character varying(100),
    city character varying(100) NOT NULL,
    state character(2) NOT NULL,
    postal_code character varying(10) NOT NULL,
    name character varying(50) NOT NULL,
    customer_id integer NOT NULL
);


ALTER TABLE raw.address OWNER TO postgres;

--
-- Name: address_id_seq; Type: SEQUENCE; Schema: raw; Owner: postgres
--

CREATE SEQUENCE raw.address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE raw.address_id_seq OWNER TO postgres;

--
-- Name: address_id_seq; Type: SEQUENCE OWNED BY; Schema: raw; Owner: postgres
--

ALTER SEQUENCE raw.address_id_seq OWNED BY raw.address.id;


--
-- Name: customer; Type: TABLE; Schema: raw; Owner: postgres
--

CREATE TABLE raw.customer (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    primary_phone character varying(20) NOT NULL,
    primary_email character varying(255)
);


ALTER TABLE raw.customer OWNER TO postgres;

--
-- Name: customer_id_seq; Type: SEQUENCE; Schema: raw; Owner: postgres
--

CREATE SEQUENCE raw.customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE raw.customer_id_seq OWNER TO postgres;

--
-- Name: customer_id_seq; Type: SEQUENCE OWNED BY; Schema: raw; Owner: postgres
--

ALTER SEQUENCE raw.customer_id_seq OWNED BY raw.customer.id;


--
-- Name: order; Type: TABLE; Schema: raw; Owner: postgres
--

CREATE TABLE raw."order" (
    order_date date,
    total double precision,
    shipping_address_id integer,
    user_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE raw."order" OWNER TO postgres;

--
-- Name: order_id_seq; Type: SEQUENCE; Schema: raw; Owner: postgres
--

CREATE SEQUENCE raw.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE raw.order_id_seq OWNER TO postgres;

--
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: raw; Owner: postgres
--

ALTER SEQUENCE raw.order_id_seq OWNED BY raw."order".id;


--
-- Name: address id; Type: DEFAULT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.address ALTER COLUMN id SET DEFAULT nextval('raw.address_id_seq'::regclass);


--
-- Name: customer id; Type: DEFAULT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.customer ALTER COLUMN id SET DEFAULT nextval('raw.customer_id_seq'::regclass);


--
-- Name: order id; Type: DEFAULT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw."order" ALTER COLUMN id SET DEFAULT nextval('raw.order_id_seq'::regclass);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: address address_customer_id_fkey; Type: FK CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.address
    ADD CONSTRAINT address_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES raw.customer(id);


--
-- Name: order order_billing_address_id_fkey; Type: FK CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw."order"
    ADD CONSTRAINT order_billing_address_id_fkey FOREIGN KEY (shipping_address_id) REFERENCES raw.address(id);


--
-- Name: order order_user_id_fkey; Type: FK CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw."order"
    ADD CONSTRAINT order_user_id_fkey FOREIGN KEY (user_id) REFERENCES raw.customer(id);


--
-- PostgreSQL database dump complete
--

