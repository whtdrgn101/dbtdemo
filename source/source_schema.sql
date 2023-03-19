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

DROP SCHEMA IF EXISTS mart CASCADE;

CREATE SCHEMA mart;

ALTER SCHEMA mart OWNER TO postgres;

GRANT ALL ON ALL TABLES IN SCHEMA mart to postgres;

--
-- Name: raw; Type: SCHEMA; Schema: -; Owner: postgres
--

DROP SCHEMA IF EXISTS raw CASCADE;

CREATE SCHEMA raw;


ALTER SCHEMA raw OWNER TO postgres;

GRANT ALL ON ALL TABLES IN SCHEMA raw to postgres;

--
-- Name: staging; Type: SCHEMA; Schema: -; Owner: postgres
--

DROP SCHEMA IF EXISTS staging CASCADE;

CREATE SCHEMA staging;

ALTER SCHEMA staging OWNER TO postgres;

GRANT ALL ON ALL TABLES IN SCHEMA staging to postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: holiday; Type: TABLE; Schema: raw; Owner: postgres
--

DROP TABLE IF EXISTS raw.holiday CASCADE;

CREATE TABLE raw.holiday (
	id integer NOT NULL,
	date_key date NOT NULL,
	name varchar(100) NOT NULL,
	is_work_day boolean NOT NULL default true
);

ALTER TABLE raw.holiday OWNER to postgres;

--
-- Name: address_id_seq; Type: SEQUENCE; Schema: raw; Owner: postgres
--

CREATE SEQUENCE raw.holiday_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE raw.holiday_id_seq OWNER TO postgres;

--
-- Name: address; Type: TABLE; Schema: raw; Owner: postgres
--

DROP TABLE IF EXISTS raw.address CASCADE;

CREATE TABLE raw.address (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    name character varying(50) NOT NULL,
    address_line_1 character varying(100) NOT NULL,
    address_line_2 character varying(100),
    address_line_3 character varying(100),
    city character varying(100) NOT NULL,
    state character(2) NOT NULL,
    postal_code character varying(10) NOT NULL
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

DROP TABLE IF EXISTS raw.customer CASCADE;

CREATE TABLE raw.customer (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    customer_since_date date NULL,
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

DROP TABLE IF EXISTS raw.orders CASCADE;

CREATE TABLE raw.orders (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    order_date date NOT NULL,
    shipping_address_id integer,
    po_number varchar(100) NULL,
    tax double precision NOT NULL DEFAULT 0.0,
    total double precision
);


ALTER TABLE raw.orders OWNER TO postgres;

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

ALTER SEQUENCE raw.order_id_seq OWNED BY raw.orders.id;


--
-- Name: order_product; Type: TABLE; Schema: raw; Owner: postgres
--

CREATE TABLE raw.order_product (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer not null default 1,
    purchased_price double precision NOT NULL,
    subtotal double precision NOT NULL
);

CREATE SEQUENCE raw.order_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE raw.order_product OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: raw; Owner: postgres
--

CREATE TABLE raw.product (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    manufacturer varchar(255) NOT NULL,
    manufacturer_part_number varchar(255) NULL,
    internal_part_number varchar(255) NOT NULL,
    supplier_price double precision NOT NULL,
    base_price double precision NOT NULL
);


ALTER TABLE raw.product OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE; Schema: raw; Owner: postgres
--

CREATE SEQUENCE raw.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE raw.product_id_seq OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: raw; Owner: postgres
--

ALTER SEQUENCE raw.product_id_seq OWNED BY raw.product.id;

--
-- Name: address id; Type: DEFAULT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.holiday ALTER COLUMN id SET DEFAULT nextval('raw.holiday_id_seq'::regclass);

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

ALTER TABLE ONLY raw.orders ALTER COLUMN id SET DEFAULT nextval('raw.order_id_seq'::regclass);


--
-- Name: order id; Type: DEFAULT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.order_product ALTER COLUMN id SET DEFAULT nextval('raw.order_product_id_seq'::regclass);

--
-- Name: product id; Type: DEFAULT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.product ALTER COLUMN id SET DEFAULT nextval('raw.product_id_seq'::regclass);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.holiday
    ADD CONSTRAINT holiday_pkey PRIMARY KEY (id);

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

ALTER TABLE ONLY raw.orders
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);

--
-- Name: order_product order_product_pkey; Type: CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.order_product
    ADD CONSTRAINT order_product_pkey PRIMARY KEY (id);

--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: address address_customer_id_fkey; Type: FK CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.address
    ADD CONSTRAINT address_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES raw.customer(id);


--
-- Name: order order_billing_address_id_fkey; Type: FK CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.orders
    ADD CONSTRAINT order_billing_address_id_fkey FOREIGN KEY (shipping_address_id) REFERENCES raw.address(id);


--
-- Name: order_product order_product_order_id_fkey; Type: FK CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.order_product
    ADD CONSTRAINT order_product_order_id_fkey FOREIGN KEY (order_id) REFERENCES raw.orders(id);


--
-- Name: order_product order_product_product_id_fkey; Type: FK CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.order_product
    ADD CONSTRAINT order_product_product_id_fkey FOREIGN KEY (product_id) REFERENCES raw.product(id);


--
-- Name: order order_customer_id_fkey; Type: FK CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.orders
    ADD CONSTRAINT order_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES raw.customer(id);


