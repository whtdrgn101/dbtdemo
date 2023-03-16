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

ALTER TABLE mart.fct_order OWNER TO postgres;

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
-- Name: order_product; Type: TABLE; Schema: raw; Owner: postgres
--

CREATE TABLE raw.order_product (
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    purchased_price double precision NOT NULL
);


ALTER TABLE raw.order_product OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: raw; Owner: postgres
--

CREATE TABLE raw.product (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    supplier_price double precision NOT NULL
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
-- Name: product id; Type: DEFAULT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.product ALTER COLUMN id SET DEFAULT nextval('raw.product_id_seq'::regclass);

--
-- Data for Name: address; Type: TABLE DATA; Schema: raw; Owner: postgres
--

COPY raw.address (id, address_line_1, address_line_2, address_line_3, city, state, postal_code, name, customer_id) FROM stdin;
1	2873 Myersville Rd	\N	\N	Uniontown	OH	44685	Home	1
2	2873 Myersville Rd	\N	\N	Uniontown	OH	44685	Home	2
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: raw; Owner: postgres
--

COPY raw.customer (id, first_name, last_name, primary_phone, primary_email) FROM stdin;
1	Timothy	DeWees	234-458-3088	timothy.dewees@gmail.com
2	Kristina	DeWees	330-205-7798	floodthelast@yahoo.com
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: raw; Owner: postgres
--

COPY raw."order" (order_date, total, shipping_address_id, user_id, id) FROM stdin;
2023-03-12	45.53	2	2	1
2023-03-12	595.82	1	1	2
\.


--
-- Data for Name: order_product; Type: TABLE DATA; Schema: raw; Owner: postgres
--

COPY raw.order_product (order_id, product_id, purchased_price) FROM stdin;
1	1	1195
1	2	1195
1	3	1295
2	1	1195
2	2	1195
2	3	1495
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: raw; Owner: postgres
--

COPY raw.product (id, name, supplier_price, base_price) FROM stdin;
1	Les Paul Standard	750.11	1656.34
2	Fender Stratocaster - Player Series	1195.11	1956.34
3	Ernie Ball Music Man Axis Deluxe	1300	2385
\.


--
-- Name: address_id_seq; Type: SEQUENCE SET; Schema: raw; Owner: postgres
--

SELECT pg_catalog.setval('raw.address_id_seq', 2, true);


--
-- Name: customer_id_seq; Type: SEQUENCE SET; Schema: raw; Owner: postgres
--

SELECT pg_catalog.setval('raw.customer_id_seq', 2, true);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: raw; Owner: postgres
--

SELECT pg_catalog.setval('raw.order_id_seq', 2, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: raw; Owner: postgres
--

SELECT pg_catalog.setval('raw.product_id_seq', 3, true);


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

ALTER TABLE ONLY raw."order"
    ADD CONSTRAINT order_billing_address_id_fkey FOREIGN KEY (shipping_address_id) REFERENCES raw.address(id);


--
-- Name: order_product order_product_order_id_fkey; Type: FK CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.order_product
    ADD CONSTRAINT order_product_order_id_fkey FOREIGN KEY (order_id) REFERENCES raw."order"(id);


--
-- Name: order_product order_product_product_id_fkey; Type: FK CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw.order_product
    ADD CONSTRAINT order_product_product_id_fkey FOREIGN KEY (product_id) REFERENCES raw.product(id);


--
-- Name: order order_user_id_fkey; Type: FK CONSTRAINT; Schema: raw; Owner: postgres
--

ALTER TABLE ONLY raw."order"
    ADD CONSTRAINT order_user_id_fkey FOREIGN KEY (user_id) REFERENCES raw.customer(id);


--
-- PostgreSQL database dump complete
--

