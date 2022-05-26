--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2022-03-24 20:25:25

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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3341 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 24656)
-- Name: archaeologists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.archaeologists (
    arch_id integer NOT NULL,
    arch_name character varying(50) NOT NULL,
    arch_salary money NOT NULL,
    arch_qualification character varying(20) NOT NULL,
    arch_specialization character varying(20) NOT NULL
);


ALTER TABLE public.archaeologists OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 24655)
-- Name: archaeologists_arch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.archaeologists_arch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.archaeologists_arch_id_seq OWNER TO postgres;

--
-- TOC entry 3342 (class 0 OID 0)
-- Dependencies: 209
-- Name: archaeologists_arch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.archaeologists_arch_id_seq OWNED BY public.archaeologists.arch_id;


--
-- TOC entry 216 (class 1259 OID 24696)
-- Name: findings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.findings (
    finding_id integer NOT NULL,
    arch_id integer NOT NULL,
    item_id integer NOT NULL,
    finding_type character varying(20) NOT NULL,
    finding_place character varying(30) NOT NULL,
    finding_data date NOT NULL,
    finding_condition character varying(10) NOT NULL
);


ALTER TABLE public.findings OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24694)
-- Name: findings_arch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.findings_arch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.findings_arch_id_seq OWNER TO postgres;

--
-- TOC entry 3343 (class 0 OID 0)
-- Dependencies: 214
-- Name: findings_arch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.findings_arch_id_seq OWNED BY public.findings.arch_id;


--
-- TOC entry 213 (class 1259 OID 24693)
-- Name: findings_finding_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.findings_finding_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.findings_finding_id_seq OWNER TO postgres;

--
-- TOC entry 3344 (class 0 OID 0)
-- Dependencies: 213
-- Name: findings_finding_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.findings_finding_id_seq OWNED BY public.findings.finding_id;


--
-- TOC entry 215 (class 1259 OID 24695)
-- Name: findings_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.findings_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.findings_item_id_seq OWNER TO postgres;

--
-- TOC entry 3345 (class 0 OID 0)
-- Dependencies: 215
-- Name: findings_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.findings_item_id_seq OWNED BY public.findings.item_id;


--
-- TOC entry 212 (class 1259 OID 24663)
-- Name: items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.items (
    item_id integer NOT NULL,
    item_value money NOT NULL,
    item_era date NOT NULL,
    item_name character varying(20) NOT NULL,
    item_owner character varying(5) NOT NULL
);


ALTER TABLE public.items OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 24662)
-- Name: items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.items_item_id_seq OWNER TO postgres;

--
-- TOC entry 3346 (class 0 OID 0)
-- Dependencies: 211
-- Name: items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.items_item_id_seq OWNED BY public.items.item_id;


--
-- TOC entry 3176 (class 2604 OID 24659)
-- Name: archaeologists arch_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.archaeologists ALTER COLUMN arch_id SET DEFAULT nextval('public.archaeologists_arch_id_seq'::regclass);


--
-- TOC entry 3178 (class 2604 OID 24699)
-- Name: findings finding_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.findings ALTER COLUMN finding_id SET DEFAULT nextval('public.findings_finding_id_seq'::regclass);


--
-- TOC entry 3179 (class 2604 OID 24700)
-- Name: findings arch_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.findings ALTER COLUMN arch_id SET DEFAULT nextval('public.findings_arch_id_seq'::regclass);


--
-- TOC entry 3180 (class 2604 OID 24701)
-- Name: findings item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.findings ALTER COLUMN item_id SET DEFAULT nextval('public.findings_item_id_seq'::regclass);


--
-- TOC entry 3177 (class 2604 OID 24666)
-- Name: items item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items ALTER COLUMN item_id SET DEFAULT nextval('public.items_item_id_seq'::regclass);


--
-- TOC entry 3329 (class 0 OID 24656)
-- Dependencies: 210
-- Data for Name: archaeologists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.archaeologists (arch_id, arch_name, arch_salary, arch_qualification, arch_specialization) FROM stdin;
\.


--
-- TOC entry 3335 (class 0 OID 24696)
-- Dependencies: 216
-- Data for Name: findings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.findings (finding_id, arch_id, item_id, finding_type, finding_place, finding_data, finding_condition) FROM stdin;
\.


--
-- TOC entry 3331 (class 0 OID 24663)
-- Dependencies: 212
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.items (item_id, item_value, item_era, item_name, item_owner) FROM stdin;
\.


--
-- TOC entry 3347 (class 0 OID 0)
-- Dependencies: 209
-- Name: archaeologists_arch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.archaeologists_arch_id_seq', 1, false);


--
-- TOC entry 3348 (class 0 OID 0)
-- Dependencies: 214
-- Name: findings_arch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.findings_arch_id_seq', 1, false);


--
-- TOC entry 3349 (class 0 OID 0)
-- Dependencies: 213
-- Name: findings_finding_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.findings_finding_id_seq', 1, false);


--
-- TOC entry 3350 (class 0 OID 0)
-- Dependencies: 215
-- Name: findings_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.findings_item_id_seq', 1, false);


--
-- TOC entry 3351 (class 0 OID 0)
-- Dependencies: 211
-- Name: items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.items_item_id_seq', 1, false);


--
-- TOC entry 3182 (class 2606 OID 24661)
-- Name: archaeologists archaeologists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.archaeologists
    ADD CONSTRAINT archaeologists_pkey PRIMARY KEY (arch_id);


--
-- TOC entry 3186 (class 2606 OID 24703)
-- Name: findings findings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT findings_pkey PRIMARY KEY (finding_id);


--
-- TOC entry 3184 (class 2606 OID 24668)
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_id);


--
-- TOC entry 3187 (class 2606 OID 24704)
-- Name: findings finding_arch; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT finding_arch FOREIGN KEY (arch_id) REFERENCES public.archaeologists(arch_id);


--
-- TOC entry 3188 (class 2606 OID 24709)
-- Name: findings findings_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT findings_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(item_id);


-- Completed on 2022-03-24 20:25:26

--
-- PostgreSQL database dump complete
--

