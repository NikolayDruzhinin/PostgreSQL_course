--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2022-05-26 17:57:46

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 32927)
-- Name: archaeologists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.archaeologists (
    arch_id integer NOT NULL,
    arch_name character varying(50) NOT NULL,
    arch_salary money NOT NULL,
    arch_qualification character varying(50) NOT NULL,
    arch_specialization character varying(50) NOT NULL
);


ALTER TABLE public.archaeologists OWNER TO postgres;

--
-- TOC entry 217 (class 1255 OID 32985)
-- Name: get_all_even_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_all_even_id() RETURNS SETOF public.archaeologists
    LANGUAGE plpgsql
    AS $$
declare
	r archaeologists%rowtype;
begin
	for r in
		select * from archaeologists where arch_id % 2 = 0
	loop
		return next r;
	end loop;
	return;
end;
$$;


ALTER FUNCTION public.get_all_even_id() OWNER TO postgres;

--
-- TOC entry 216 (class 1255 OID 32958)
-- Name: my_func(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.my_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if (new.finding_data > now()) then
			raise exception '% incorrect date', new.finding_data;
		end if;
		
		if (new.finding_condition != 'average' or
		   new.finding_condition != 'good' or
		   new.finding_condition != 'bad') then
		    raise exception '% incorrect finding condition', new.finding_condition;
		end if;
	end;
$$;


ALTER FUNCTION public.my_func() OWNER TO postgres;

--
-- TOC entry 218 (class 1255 OID 32989)
-- Name: raise_salary(integer, money); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.raise_salary(key_ integer, summ money) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin 
	loop
		update archaeologists set arch_salary = arch_salary + summ where arch_id = key_;
		
		if found then
			return;
		end if;
		
        	raise notice 'Key is not found!';
		return;
	end loop;
end;
$$;


ALTER FUNCTION public.raise_salary(key_ integer, summ money) OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 32926)
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
-- TOC entry 3345 (class 0 OID 0)
-- Dependencies: 209
-- Name: archaeologists_arch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.archaeologists_arch_id_seq OWNED BY public.archaeologists.arch_id;


--
-- TOC entry 214 (class 1259 OID 32941)
-- Name: findings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.findings (
    finding_id integer NOT NULL,
    arch_id integer,
    item_id integer,
    finding_type character varying(50) NOT NULL,
    finding_place character varying(50) NOT NULL,
    finding_data date NOT NULL,
    finding_condition character varying(50) NOT NULL
);


ALTER TABLE public.findings OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 32940)
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
-- TOC entry 3348 (class 0 OID 0)
-- Dependencies: 213
-- Name: findings_finding_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.findings_finding_id_seq OWNED BY public.findings.finding_id;


--
-- TOC entry 212 (class 1259 OID 32934)
-- Name: items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.items (
    item_id integer NOT NULL,
    item_value money NOT NULL,
    item_era character varying(50) NOT NULL,
    item_name character varying(50) NOT NULL,
    item_owner character varying(50) NOT NULL
);


ALTER TABLE public.items OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 32933)
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
-- TOC entry 3350 (class 0 OID 0)
-- Dependencies: 211
-- Name: items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.items_item_id_seq OWNED BY public.items.item_id;


--
-- TOC entry 215 (class 1259 OID 32981)
-- Name: old_findings; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.old_findings AS
 SELECT archaeologists.arch_name,
    items.item_name,
    findings.finding_data
   FROM ((public.archaeologists
     JOIN public.findings ON ((archaeologists.arch_id = findings.arch_id)))
     JOIN public.items ON ((findings.item_id = items.item_id)))
  WHERE (findings.finding_data < '1900-01-01'::date);


ALTER TABLE public.old_findings OWNER TO postgres;

--
-- TOC entry 3181 (class 2604 OID 32930)
-- Name: archaeologists arch_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.archaeologists ALTER COLUMN arch_id SET DEFAULT nextval('public.archaeologists_arch_id_seq'::regclass);


--
-- TOC entry 3183 (class 2604 OID 32944)
-- Name: findings finding_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.findings ALTER COLUMN finding_id SET DEFAULT nextval('public.findings_finding_id_seq'::regclass);


--
-- TOC entry 3182 (class 2604 OID 32937)
-- Name: items item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items ALTER COLUMN item_id SET DEFAULT nextval('public.items_item_id_seq'::regclass);


--
-- TOC entry 3334 (class 0 OID 32927)
-- Dependencies: 210
-- Data for Name: archaeologists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.archaeologists (arch_id, arch_name, arch_salary, arch_qualification, arch_specialization) FROM stdin;
2	Sarah	$4,440.00	Associate	Field archaeology
3	Conrod	$3,350.00	Assistant	Classical archaeology
4	Nikolas	$8,900.00	Professor	Prehistoric archaeology
5	James	$5,050.00	Professor	Field archaeology
6	Franchesko	$4,440.00	Associate	Underwater archaeology
7	Simon	$3,350.00	Assistant	Classical archaeology
10	Jaggermeister	$7,000.00	Professor	Landscape archaeology
9	Amadeo	$2,500.00	Intern	Classical archaeology
8	Nemo	$1,902.00	Intern	Zooarchaeology
1	Patrik	$5,100.00	Professor	Field archaeology
\.


--
-- TOC entry 3338 (class 0 OID 32941)
-- Dependencies: 214
-- Data for Name: findings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.findings (finding_id, arch_id, item_id, finding_type, finding_place, finding_data, finding_condition) FROM stdin;
1	4	1	Tomb	Egypt	1924-11-04	average
2	7	2	Temple	Italy	1814-03-09	average
3	9	4	Equipment	Egypt	1541-05-13	bad
4	2	5	Treasure	UK	2009-06-05	good
5	8	8	Remains of animal	Philippines	2007-02-15	bad
6	6	7	Ruins	Italy	1709-10-10	average
7	1	9	Monument	Spain	1868-01-08	average
8	8	6	Remains of animal	Egypt	1799-06-15	bad
9	3	9	Monument	Spain	1926-06-01	good
10	5	1	Cemetery	Spain	1939-03-18	bad
11	4	1	Tomb	Italy	1804-11-04	good
12	10	2	Temple	Mexico	1814-03-09	average
13	4	4	Equipment	Russia	1771-05-13	good
15	10	10	Remains of animal	Philippines	1991-02-02	good
16	3	10	Ruins	China	1739-11-10	bad
17	4	9	Monument	Sweden	1831-05-08	good
18	8	6	Remains of animal	Egypt	1799-06-15	bad
19	7	9	Monument	Spain	1926-06-01	good
20	5	3	Equipment	UK	1905-09-13	bad
21	1	1	Cemetery	Spain	1939-03-18	bad
14	2	5	Treasure	Ukraine	2022-02-24	bad
22	2	4	Ruins	Egypt	2022-05-12	good
\.


--
-- TOC entry 3336 (class 0 OID 32934)
-- Dependencies: 212
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.items (item_id, item_value, item_era, item_name, item_owner) FROM stdin;
1	$1,000.00	100BC	Pharaon tomb	Pharaon
2	$2,000.00	323BC	Ancient temple	Nobleman
3	$1,500.00	100AD	Golden helmet	Warrior
4	$1,500.00	150AD	Ancient weapon	Warrior
5	$3,000.00	600AD	Treasure	King
6	$4,000.00	Mesozoic era	Dinosaurs ones	Animal
7	$3,500.00	79 AD	The lost city	n/a
8	$5,000.00	Cenozoic era	Fish bones	Fish
9	$8,000.00	300BC	Ancient monument	Nobleman
10	$7,000.00	Paleozoic era	Ancient insect	Insect
\.


--
-- TOC entry 3352 (class 0 OID 0)
-- Dependencies: 209
-- Name: archaeologists_arch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.archaeologists_arch_id_seq', 10, true);


--
-- TOC entry 3353 (class 0 OID 0)
-- Dependencies: 213
-- Name: findings_finding_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.findings_finding_id_seq', 24, true);


--
-- TOC entry 3354 (class 0 OID 0)
-- Dependencies: 211
-- Name: items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.items_item_id_seq', 10, true);


--
-- TOC entry 3185 (class 2606 OID 32932)
-- Name: archaeologists archaeologists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.archaeologists
    ADD CONSTRAINT archaeologists_pkey PRIMARY KEY (arch_id);


--
-- TOC entry 3189 (class 2606 OID 32946)
-- Name: findings findings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT findings_pkey PRIMARY KEY (finding_id);


--
-- TOC entry 3187 (class 2606 OID 32939)
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_id);


--
-- TOC entry 3192 (class 2620 OID 32959)
-- Name: findings test_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER test_trigger BEFORE INSERT OR UPDATE ON public.findings FOR EACH ROW EXECUTE FUNCTION public.my_func();


--
-- TOC entry 3190 (class 2606 OID 32947)
-- Name: findings findings_arch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT findings_arch_id_fkey FOREIGN KEY (arch_id) REFERENCES public.archaeologists(arch_id);


--
-- TOC entry 3191 (class 2606 OID 32952)
-- Name: findings findings_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT findings_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(item_id);


--
-- TOC entry 3344 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE archaeologists; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.archaeologists TO test;


--
-- TOC entry 3346 (class 0 OID 0)
-- Dependencies: 214
-- Name: COLUMN findings.arch_id; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT(arch_id) ON TABLE public.findings TO test;


--
-- TOC entry 3347 (class 0 OID 0)
-- Dependencies: 214
-- Name: COLUMN findings.finding_data; Type: ACL; Schema: public; Owner: postgres
--

GRANT UPDATE(finding_data) ON TABLE public.findings TO test;


--
-- TOC entry 3349 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE items; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.items TO test;


--
-- TOC entry 3351 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE old_findings; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.old_findings TO test;


-- Completed on 2022-05-26 17:57:47

--
-- PostgreSQL database dump complete
--

