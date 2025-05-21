--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2022-06-27 16:34:43

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
-- TOC entry 3373 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 234 (class 1255 OID 73762)
-- Name: cderecho_servicio_insert(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cderecho_servicio_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	insert into servicios (id_servicio) values(NEW."id_contrato");
	insert into difuntos  (id_difunto, id_representante) values(new.id_contrato, new."id_representante");
	insert into cesion_derecho (id_cderecho, fecha_cderecho) values (NEW."id_contrato", current_date);
	return NEW;
end;

$$;


ALTER FUNCTION public.cderecho_servicio_insert() OWNER TO postgres;

--
-- TOC entry 224 (class 1255 OID 81930)
-- Name: crear_contrato(integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.crear_contrato(IN a integer, IN b integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
	valor INTEGER;
BEGIN
  INSERT into contratos(id_encargado, id_representante, fecha_contrato) VALUES (a,b, current_date);
  valor = (select currval('contrato_codigo_seq'));
 raise notice 'el valor es %', valor;
 end
$$;


ALTER PROCEDURE public.crear_contrato(IN a integer, IN b integer) OWNER TO postgres;

--
-- TOC entry 3374 (class 0 OID 0)
-- Dependencies: 224
-- Name: PROCEDURE crear_contrato(IN a integer, IN b integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON PROCEDURE public.crear_contrato(IN a integer, IN b integer) IS 'procedimiento para crear un contratom necesita valor de encargado y representante';


--
-- TOC entry 225 (class 1255 OID 90140)
-- Name: crear_representantes(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.crear_representantes()
    LANGUAGE plpgsql
    AS $$
	BEGIN
	INSERT INTO representantes
	(nombre_representante, domicilio_representante, lugar_trabajo_representante, rut_representante, telefono_representante)
	VALUES('', '', '', '', '');
	END;
$$;


ALTER PROCEDURE public.crear_representantes() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 65547)
-- Name: cesion_derecho; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cesion_derecho (
    id_cderecho integer NOT NULL,
    fecha_cderecho timestamp with time zone
);


ALTER TABLE public.cesion_derecho OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 65546)
-- Name: cesion_derecho_id_cderecho_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cesion_derecho_id_cderecho_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cesion_derecho_id_cderecho_seq OWNER TO postgres;

--
-- TOC entry 3375 (class 0 OID 0)
-- Dependencies: 219
-- Name: cesion_derecho_id_cderecho_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cesion_derecho_id_cderecho_seq OWNED BY public.cesion_derecho.id_cderecho;


--
-- TOC entry 212 (class 1259 OID 49170)
-- Name: contratos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contratos (
    id_contrato integer NOT NULL,
    fecha_contrato date NOT NULL,
    numero_factura integer,
    id_encargado integer,
    id_representante integer
);


ALTER TABLE public.contratos OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 49169)
-- Name: contrato_codigo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contrato_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contrato_codigo_seq OWNER TO postgres;

--
-- TOC entry 3376 (class 0 OID 0)
-- Dependencies: 211
-- Name: contrato_codigo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contrato_codigo_seq OWNED BY public.contratos.id_contrato;


--
-- TOC entry 216 (class 1259 OID 57355)
-- Name: difuntos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.difuntos (
    id_difunto integer NOT NULL,
    nombre_completo_difunto character varying(255),
    lugar_fallecimiento character varying(255),
    lugar_traslado character varying(255),
    ciudad character varying(50),
    rut_difunto character varying(50),
    id_representante integer
);


ALTER TABLE public.difuntos OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 57354)
-- Name: difuntos_id_difunto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.difuntos_id_difunto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.difuntos_id_difunto_seq OWNER TO postgres;

--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 215
-- Name: difuntos_id_difunto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.difuntos_id_difunto_seq OWNED BY public.difuntos.id_difunto;


--
-- TOC entry 218 (class 1259 OID 57362)
-- Name: encargados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.encargados (
    id_encargado integer NOT NULL,
    rut_encargado character varying(50),
    nombre_encargado character varying(255)
);


ALTER TABLE public.encargados OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 57361)
-- Name: encargados_id_encargado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.encargados_id_encargado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.encargados_id_encargado_seq OWNER TO postgres;

--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 217
-- Name: encargados_id_encargado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.encargados_id_encargado_seq OWNED BY public.encargados.id_encargado;


--
-- TOC entry 210 (class 1259 OID 49163)
-- Name: representantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.representantes (
    id_representante integer NOT NULL,
    nombre_representante character varying(50) NOT NULL,
    domicilio_representante character varying(50),
    lugar_trabajo_representante character varying(50),
    rut_representante character varying(50),
    telefono_representante character varying
);


ALTER TABLE public.representantes OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 49162)
-- Name: representante_id_representante_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.representante_id_representante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.representante_id_representante_seq OWNER TO postgres;

--
-- TOC entry 3379 (class 0 OID 0)
-- Dependencies: 209
-- Name: representante_id_representante_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.representante_id_representante_seq OWNED BY public.representantes.id_representante;


--
-- TOC entry 214 (class 1259 OID 49177)
-- Name: servicios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servicios (
    id_servicio integer NOT NULL,
    urna character varying(50),
    nombre_cementerio character varying(50),
    traslado character varying(50)
);


ALTER TABLE public.servicios OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 49176)
-- Name: servicio_codigo_servicio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servicio_codigo_servicio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.servicio_codigo_servicio_seq OWNER TO postgres;

--
-- TOC entry 3380 (class 0 OID 0)
-- Dependencies: 213
-- Name: servicio_codigo_servicio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servicio_codigo_servicio_seq OWNED BY public.servicios.id_servicio;


--
-- TOC entry 3197 (class 2604 OID 65550)
-- Name: cesion_derecho id_cderecho; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cesion_derecho ALTER COLUMN id_cderecho SET DEFAULT nextval('public.cesion_derecho_id_cderecho_seq'::regclass);


--
-- TOC entry 3193 (class 2604 OID 49173)
-- Name: contratos id_contrato; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratos ALTER COLUMN id_contrato SET DEFAULT nextval('public.contrato_codigo_seq'::regclass);


--
-- TOC entry 3195 (class 2604 OID 57358)
-- Name: difuntos id_difunto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difuntos ALTER COLUMN id_difunto SET DEFAULT nextval('public.difuntos_id_difunto_seq'::regclass);


--
-- TOC entry 3196 (class 2604 OID 57365)
-- Name: encargados id_encargado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encargados ALTER COLUMN id_encargado SET DEFAULT nextval('public.encargados_id_encargado_seq'::regclass);


--
-- TOC entry 3192 (class 2604 OID 49166)
-- Name: representantes id_representante; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.representantes ALTER COLUMN id_representante SET DEFAULT nextval('public.representante_id_representante_seq'::regclass);


--
-- TOC entry 3194 (class 2604 OID 49180)
-- Name: servicios id_servicio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios ALTER COLUMN id_servicio SET DEFAULT nextval('public.servicio_codigo_servicio_seq'::regclass);


--
-- TOC entry 3367 (class 0 OID 65547)
-- Dependencies: 220
-- Data for Name: cesion_derecho; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cesion_derecho (id_cderecho, fecha_cderecho) FROM stdin;
6	2022-05-26 00:00:00-04
7	2022-05-26 00:00:00-04
8	2022-05-26 00:00:00-04
9	2022-05-26 00:00:00-04
38	2022-06-07 00:00:00-04
39	2022-06-07 00:00:00-04
41	2022-06-07 00:00:00-04
43	2022-06-09 00:00:00-04
44	2022-06-09 00:00:00-04
45	2022-06-09 00:00:00-04
46	2022-06-09 00:00:00-04
\.


--
-- TOC entry 3359 (class 0 OID 49170)
-- Dependencies: 212
-- Data for Name: contratos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contratos (id_contrato, fecha_contrato, numero_factura, id_encargado, id_representante) FROM stdin;
104	2022-05-25	\N	1	\N
105	2022-05-25	\N	1	\N
6	2022-05-26	666	1	105
7	2022-05-26	666	1	105
8	2022-05-26	666	1	105
9	2022-05-26	666	1	105
38	2022-06-07	\N	1	105
39	2022-06-07	\N	1	105
41	2022-06-07	\N	1	106
43	2022-06-09	\N	1	105
44	2022-06-09	\N	1	106
45	2022-06-09	\N	1	106
46	2022-06-09	\N	1	106
\.


--
-- TOC entry 3363 (class 0 OID 57355)
-- Dependencies: 216
-- Data for Name: difuntos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.difuntos (id_difunto, nombre_completo_difunto, lugar_fallecimiento, lugar_traslado, ciudad, rut_difunto, id_representante) FROM stdin;
38	\N	\N	\N	\N	\N	105
39	\N	\N	\N	\N	\N	105
41	\N	\N	\N	\N	\N	106
43	\N	\N	\N	\N	\N	105
44	\N	\N	\N	\N	\N	106
45	\N	\N	\N	\N	\N	106
46	\N	\N	\N	\N	\N	106
\.


--
-- TOC entry 3365 (class 0 OID 57362)
-- Dependencies: 218
-- Data for Name: encargados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.encargados (id_encargado, rut_encargado, nombre_encargado) FROM stdin;
1	17800	David
\.


--
-- TOC entry 3357 (class 0 OID 49163)
-- Dependencies: 210
-- Data for Name: representantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.representantes (id_representante, nombre_representante, domicilio_representante, lugar_trabajo_representante, rut_representante, telefono_representante) FROM stdin;
104	Jack Sharrem	46 Sloan Lane	Kebonkaret	42.14.196.73	9086462761
105	Evvie Stoner	0595 High Crossing Alley	Ostroróg	219.87.83.227	7999520961
106	Rockey Tranfield	9 David Parkway	Kubangwaru	85.157.120.11	8636712821
107	Hyacinthie Rapsey	55 School Lane	San Onofre	36.140.29.233	6353189909
108	Don Sulman	8 Corben Place	Marcabamba	3.86.244.63	8336554579
109	Olympe Potteril	86 Emmet Center	Orangeville	21.23.172.32	1807921615
110	Norri Ilyin	11977 Superior Street	Słońsk	182.190.90.119	4752261821
111	Grant Cutmore	735 Dwight Park	Masinloc	110.95.114.170	3113959264
112	Wiley Lumly	088 Schlimgen Alley	K’ulashi	21.119.44.255	3864194171
113	Theresita Bullick	249 Mallard Terrace	Vahdat	250.174.142.135	5256703189
114	Brunhilda Scatcher	9596 Forest Dale Plaza	Oton	75.12.67.108	3279714117
115	Erny Abthorpe	0254 Kropf Center	Ar Ruways	216.108.126.9	8293276952
116	Teador Coronado	30332 Sunfield Lane	João Alfredo	167.40.220.117	4507376597
117	Karol McFetrich	2897 Miller Street	Lugo	86.230.200.196	7334808520
118	Tootsie Golightly	26 Walton Trail	Argentan	29.238.29.44	1461375365
119	Wilma Delion	519 Daystar Drive	Semalang	10.233.79.135	3728488082
120	L;urette Bridgwood	5461 Sycamore Trail	Parapat	54.175.225.48	4598083899
121	Sallie Paulsen	72 Morning Avenue	Huangjiakou	187.113.232.180	7543408638
122	Kakalina Lile	4875 David Avenue	Pretoria	206.39.210.72	7644901693
123	Mirella Lisciardelli	5 Garrison Alley	Gujiadian	176.123.207.30	3363677075
124	Gay Ovitz	3 Ridge Oak Road	Lazaro Cardenas	197.208.94.243	2953002446
125	Hannah Tackle	49672 Kingsford Lane	Wagar	49.239.156.61	7536394892
126	Broddy Wyburn	9 Loeprich Terrace	Zhouxi	247.185.25.36	2534590347
127	Tiff Heister	0 Erie Drive	Villa Ángela	170.83.161.249	8244535538
128	Blondell Chaikovski	868 Artisan Parkway	Triesenberg	71.133.240.133	5575923126
129	Rosanna Burcher	86572 Chinook Court	Khairpur	22.0.106.80	3409460690
130	Roseanne Pilipets	5 Pankratz Center	Ţawr al Bāḩah	190.19.66.242	1225320080
131	Noelyn Testo	76 Harper Crossing	Al Ḩammāmāt	199.57.198.203	8446820521
132	Roanne Kirstein	51 Marcy Junction	Venilale	31.245.68.127	1471498845
133	Karoline Aidler	352 Fordem Park	Cicapar	142.214.176.148	3123206669
134	Cristen Antonsson	34614 Grasskamp Road	Telsen	253.227.117.38	5823791864
135	Kay Pople	67 Fairfield Crossing	Benito Juarez	103.154.38.63	3037877695
136	Gan Rounding	6456 Steensland Alley	Nesterovskaya	168.133.45.63	2906245182
137	Aldwin Lehrian	73 Golf Course Court	Ananindeua	218.17.178.171	5824033324
138	Felix Arpe	64 Alpine Way	Lelkowo	58.163.13.206	4802165791
139	Rania Lindelof	4 Stoughton Center	Larvik	215.198.94.224	4212682122
140	Brnaby Stanes	8266 David Pass	Cabrobó	95.116.83.36	3275350815
141	Marilin Aujean	279 High Crossing Junction	Cestas	236.90.157.118	1396360759
142	Chrissie Snowman	51 Bashford Street	Tama	9.87.14.86	1658182898
143	Pyotr Greendale	96454 Delaware Court	Aylmer	47.194.113.208	5215285274
144	Lucina Vennings	0 Summerview Junction	Ruse	71.119.66.15	1204487119
145	Carilyn Berens	9844 Atwood Point	Romanovo	186.228.37.166	3912061286
146	Baryram Stollenbeck	2 Meadow Valley Court	Nicolas Bravo	250.194.29.12	1475301503
147	Kelcie Ferres	1883 School Hill	Kujang	178.77.206.7	6462397590
148	Hansiain Bignal	011 Sutteridge Street	Harbutowice	239.29.23.48	9573525055
149	Zia Goodison	85 Muir Road	Normanton	16.255.245.101	4789648947
150	Tessi MacEntee	57 Mallard Point	Quchomo	115.208.27.4	5536811432
151	Hazel Adlard	72636 Packers Parkway	Shilu	109.180.123.143	1449393353
152	Vickie Cuerdall	891 Loomis Way	Londres	77.95.240.190	5794166428
153	Sol Lucia	3045 Main Court	Enzan	35.211.37.26	7517340060
\.


--
-- TOC entry 3361 (class 0 OID 49177)
-- Dependencies: 214
-- Data for Name: servicios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.servicios (id_servicio, urna, nombre_cementerio, traslado) FROM stdin;
7	\N	\N	\N
8	\N	\N	\N
9	\N	\N	\N
6	\N	\N	}
38	\N	\N	\N
39	\N	\N	\N
41	\N	\N	\N
43	\N	\N	\N
44	\N	\N	\N
45	\N	\N	\N
46	\N	\N	\N
\.


--
-- TOC entry 3381 (class 0 OID 0)
-- Dependencies: 219
-- Name: cesion_derecho_id_cderecho_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cesion_derecho_id_cderecho_seq', 1, false);


--
-- TOC entry 3382 (class 0 OID 0)
-- Dependencies: 211
-- Name: contrato_codigo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contrato_codigo_seq', 46, true);


--
-- TOC entry 3383 (class 0 OID 0)
-- Dependencies: 215
-- Name: difuntos_id_difunto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.difuntos_id_difunto_seq', 5, true);


--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 217
-- Name: encargados_id_encargado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.encargados_id_encargado_seq', 1, true);


--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 209
-- Name: representante_id_representante_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.representante_id_representante_seq', 153, true);


--
-- TOC entry 3386 (class 0 OID 0)
-- Dependencies: 213
-- Name: servicio_codigo_servicio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servicio_codigo_servicio_seq', 2, true);


--
-- TOC entry 3209 (class 2606 OID 65552)
-- Name: cesion_derecho cesion_derecho_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cesion_derecho
    ADD CONSTRAINT cesion_derecho_pkey PRIMARY KEY (id_cderecho);


--
-- TOC entry 3201 (class 2606 OID 49175)
-- Name: contratos contrato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratos
    ADD CONSTRAINT contrato_pkey PRIMARY KEY (id_contrato);


--
-- TOC entry 3205 (class 2606 OID 57371)
-- Name: difuntos difuntos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difuntos
    ADD CONSTRAINT difuntos_pkey PRIMARY KEY (id_difunto);


--
-- TOC entry 3207 (class 2606 OID 57369)
-- Name: encargados encargados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encargados
    ADD CONSTRAINT encargados_pkey PRIMARY KEY (id_encargado);


--
-- TOC entry 3199 (class 2606 OID 49168)
-- Name: representantes representante_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.representantes
    ADD CONSTRAINT representante_pkey PRIMARY KEY (id_representante);


--
-- TOC entry 3203 (class 2606 OID 49182)
-- Name: servicios servicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios
    ADD CONSTRAINT servicio_pkey PRIMARY KEY (id_servicio);


--
-- TOC entry 3216 (class 2620 OID 73763)
-- Name: contratos trigger_contratos; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_contratos AFTER INSERT ON public.contratos FOR EACH ROW EXECUTE FUNCTION public.cderecho_servicio_insert();


--
-- TOC entry 3215 (class 2606 OID 65673)
-- Name: cesion_derecho cesion_derecho_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cesion_derecho
    ADD CONSTRAINT cesion_derecho_fk FOREIGN KEY (id_cderecho) REFERENCES public.contratos(id_contrato);


--
-- TOC entry 3213 (class 2606 OID 65668)
-- Name: difuntos difuntos_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difuntos
    ADD CONSTRAINT difuntos_fk_1 FOREIGN KEY (id_difunto) REFERENCES public.servicios(id_servicio);


--
-- TOC entry 3210 (class 2606 OID 65685)
-- Name: contratos encargados_contratos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratos
    ADD CONSTRAINT encargados_contratos FOREIGN KEY (id_encargado) REFERENCES public.encargados(id_encargado);


--
-- TOC entry 3211 (class 2606 OID 73738)
-- Name: contratos representante_contrato; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratos
    ADD CONSTRAINT representante_contrato FOREIGN KEY (id_representante) REFERENCES public.representantes(id_representante);


--
-- TOC entry 3214 (class 2606 OID 73743)
-- Name: difuntos representante_difunto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difuntos
    ADD CONSTRAINT representante_difunto FOREIGN KEY (id_representante) REFERENCES public.representantes(id_representante);


--
-- TOC entry 3212 (class 2606 OID 65658)
-- Name: servicios servicios_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios
    ADD CONSTRAINT servicios_fk FOREIGN KEY (id_servicio) REFERENCES public.contratos(id_contrato);


-- Completed on 2022-06-27 16:34:44

--
-- PostgreSQL database dump complete
--

