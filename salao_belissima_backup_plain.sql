--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0
-- Dumped by pg_dump version 13.0

-- Started on 2020-10-26 13:07:06

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
-- TOC entry 665 (class 1247 OID 33046)
-- Name: status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status AS ENUM (
    'Marcado',
    'Realizado',
    'Cancelado'
);


ALTER TYPE public.status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 33055)
-- Name: atendimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.atendimento (
    id integer NOT NULL,
    horario time without time zone NOT NULL,
    data date NOT NULL,
    id_servico integer NOT NULL,
    id_cliente integer NOT NULL,
    id_cabeleireiro integer NOT NULL,
    status public.status NOT NULL
);


ALTER TABLE public.atendimento OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 33053)
-- Name: atendimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.atendimento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.atendimento_id_seq OWNER TO postgres;

--
-- TOC entry 3111 (class 0 OID 0)
-- Dependencies: 209
-- Name: atendimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.atendimento_id_seq OWNED BY public.atendimento.id;


--
-- TOC entry 204 (class 1259 OID 33008)
-- Name: cabeleireiro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cabeleireiro (
    id integer NOT NULL,
    rua character varying NOT NULL,
    numero integer NOT NULL,
    cidade character varying(28) NOT NULL,
    estado character varying(2) NOT NULL
);


ALTER TABLE public.cabeleireiro OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 32998)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id integer NOT NULL,
    data_nascimento date NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 33078)
-- Name: comentario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comentario (
    id integer NOT NULL,
    titulo character varying(40) NOT NULL,
    descricao character varying NOT NULL,
    data date DEFAULT CURRENT_DATE NOT NULL,
    id_servico integer NOT NULL,
    id_cliente integer NOT NULL
);


ALTER TABLE public.comentario OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 33076)
-- Name: comentario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comentario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comentario_id_seq OWNER TO postgres;

--
-- TOC entry 3112 (class 0 OID 0)
-- Dependencies: 211
-- Name: comentario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comentario_id_seq OWNED BY public.comentario.id;


--
-- TOC entry 206 (class 1259 OID 33023)
-- Name: feria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feria (
    id smallint NOT NULL,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    id_usuario integer NOT NULL
);


ALTER TABLE public.feria OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 33021)
-- Name: feria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feria_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feria_id_seq OWNER TO postgres;

--
-- TOC entry 3113 (class 0 OID 0)
-- Dependencies: 205
-- Name: feria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feria_id_seq OWNED BY public.feria.id;


--
-- TOC entry 217 (class 1259 OID 33126)
-- Name: fornecedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fornecedor (
    id smallint NOT NULL,
    nome character varying(65) NOT NULL,
    email character varying NOT NULL,
    telefone character varying NOT NULL,
    cnpj character varying(18),
    cpf character varying(14),
    id_produto integer NOT NULL
);


ALTER TABLE public.fornecedor OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 33124)
-- Name: fornecedor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fornecedor_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fornecedor_id_seq OWNER TO postgres;

--
-- TOC entry 3114 (class 0 OID 0)
-- Dependencies: 216
-- Name: fornecedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fornecedor_id_seq OWNED BY public.fornecedor.id;


--
-- TOC entry 214 (class 1259 OID 33100)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    id smallint NOT NULL,
    nome character varying(25) NOT NULL,
    marca character varying(20),
    preco numeric,
    validade date,
    quantidade integer
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 33098)
-- Name: produto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produto_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produto_id_seq OWNER TO postgres;

--
-- TOC entry 3115 (class 0 OID 0)
-- Dependencies: 213
-- Name: produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produto_id_seq OWNED BY public.produto.id;


--
-- TOC entry 215 (class 1259 OID 33109)
-- Name: produto_servico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto_servico (
    id_produto integer NOT NULL,
    id_servico integer NOT NULL
);


ALTER TABLE public.produto_servico OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 33036)
-- Name: servico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servico (
    id smallint NOT NULL,
    nome character varying(25) NOT NULL,
    preco numeric NOT NULL,
    descricao character varying NOT NULL,
    hora_gasta time without time zone NOT NULL
);


ALTER TABLE public.servico OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 33034)
-- Name: servico_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servico_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.servico_id_seq OWNER TO postgres;

--
-- TOC entry 3116 (class 0 OID 0)
-- Dependencies: 207
-- Name: servico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servico_id_seq OWNED BY public.servico.id;


--
-- TOC entry 202 (class 1259 OID 32985)
-- Name: telefone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefone (
    id_usuario integer NOT NULL,
    telefone character varying NOT NULL
);


ALTER TABLE public.telefone OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 32974)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    cpf character varying(14) NOT NULL,
    nome character varying(60) NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 32972)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_id_seq OWNER TO postgres;

--
-- TOC entry 3117 (class 0 OID 0)
-- Dependencies: 200
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- TOC entry 2915 (class 2604 OID 33058)
-- Name: atendimento id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atendimento ALTER COLUMN id SET DEFAULT nextval('public.atendimento_id_seq'::regclass);


--
-- TOC entry 2916 (class 2604 OID 33081)
-- Name: comentario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario ALTER COLUMN id SET DEFAULT nextval('public.comentario_id_seq'::regclass);


--
-- TOC entry 2913 (class 2604 OID 33026)
-- Name: feria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feria ALTER COLUMN id SET DEFAULT nextval('public.feria_id_seq'::regclass);


--
-- TOC entry 2919 (class 2604 OID 33129)
-- Name: fornecedor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor ALTER COLUMN id SET DEFAULT nextval('public.fornecedor_id_seq'::regclass);


--
-- TOC entry 2918 (class 2604 OID 33103)
-- Name: produto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto ALTER COLUMN id SET DEFAULT nextval('public.produto_id_seq'::regclass);


--
-- TOC entry 2914 (class 2604 OID 33039)
-- Name: servico id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servico ALTER COLUMN id SET DEFAULT nextval('public.servico_id_seq'::regclass);


--
-- TOC entry 2912 (class 2604 OID 32977)
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- TOC entry 3098 (class 0 OID 33055)
-- Dependencies: 210
-- Data for Name: atendimento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.atendimento (id, horario, data, id_servico, id_cliente, id_cabeleireiro, status) FROM stdin;
1	13:30:00	2020-10-02	1	6	1	Realizado
2	14:30:00	2020-10-29	2	7	2	Marcado
3	15:30:00	2020-11-01	3	8	3	Marcado
4	16:30:00	2020-11-02	4	9	4	Marcado
5	17:30:00	2020-12-05	5	10	5	Cancelado
\.


--
-- TOC entry 3092 (class 0 OID 33008)
-- Dependencies: 204
-- Data for Name: cabeleireiro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cabeleireiro (id, rua, numero, cidade, estado) FROM stdin;
1	Rua Pereira dos Almeidas	110	Pouso Alto	MG
2	Rua Rio Verde	111	Carmo de Minas	MG
3	Rua Rio Claro	112	São Lourenço	MG
4	Rua Matriz de Sá	113	São Paulo	SP
5	Rua Imaculada Conceição	110	Baependi	MG
\.


--
-- TOC entry 3091 (class 0 OID 32998)
-- Dependencies: 203
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (id, data_nascimento) FROM stdin;
6	1990-01-01
7	1991-02-02
8	1992-03-03
9	1993-04-04
10	1994-05-05
\.


--
-- TOC entry 3100 (class 0 OID 33078)
-- Dependencies: 212
-- Data for Name: comentario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comentario (id, titulo, descricao, data, id_servico, id_cliente) FROM stdin;
1	Muito boa a selagem	Faz um ano que fiz a selagem e meu cabelo ainda continua liso.	2020-09-09	1	10
2	Franjas longas	A franja que fiz nesse salão ficou muito grande.	2020-08-10	3	9
3	Recomendo a selagem	Fiz a selagem e farei dnv, muuuuuito bom *----*.	2020-10-10	1	6
4	Barato essa chapinha	Pra quem tá com o bolso furado e tem pouca grana eu recomendo a chapinha, por ser barata.	2020-07-13	2	7
5	Lavagem muito boa	Minhas caspas sumiram com essa lavagem, gradecida imensamente! :´).	2020-10-15	4	8
\.


--
-- TOC entry 3094 (class 0 OID 33023)
-- Dependencies: 206
-- Data for Name: feria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feria (id, data_inicio, data_fim, id_usuario) FROM stdin;
1	2020-12-20	2021-01-02	1
2	2020-10-21	2021-11-03	2
3	2020-12-22	2021-01-04	3
4	2020-11-23	2021-12-05	4
5	2020-12-24	2021-01-06	5
\.


--
-- TOC entry 3105 (class 0 OID 33126)
-- Dependencies: 217
-- Data for Name: fornecedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fornecedor (id, nome, email, telefone, cnpj, cpf, id_produto) FROM stdin;
1	Jumencio Silva	jumencio@jumencio.com	5535991234567	\N	111.222.333-44	5
2	Embeleza Supra	embelezasupra@embelezasupra.com	5535991234588	04.293.287/0001-46	111.222.333-55	4
3	Produtos Silva	produtossilva@produtossilva.com	5535991234599	11.202.494/0001-03	\N	3
4	Prado Prato Pratício	ppp@ppp.com	5535991234500	76.273.339/0001-23	\N	2
5	Antonio Serviços	antonioservicos@antonioservicos.com	5535991234511	51.211.112/0001-22	111.222.333-66	1
\.


--
-- TOC entry 3102 (class 0 OID 33100)
-- Dependencies: 214
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto (id, nome, marca, preco, validade, quantidade) FROM stdin;
1	Desmaia Cabelo	Olivina	15.50	2022-12-12	20
2	Shampoo Clear Men	Clear	10.50	2023-12-03	50
3	Selagem Grande	Fridora	20.50	2021-10-05	30
4	Descolorante em pó	Descolorilda	9.99	2022-05-01	40
5	Condicionador Chiclete	Havanaunana	17.75	2025-12-25	74
\.


--
-- TOC entry 3103 (class 0 OID 33109)
-- Dependencies: 215
-- Data for Name: produto_servico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto_servico (id_produto, id_servico) FROM stdin;
3	1
2	4
5	4
1	3
5	1
\.


--
-- TOC entry 3096 (class 0 OID 33036)
-- Dependencies: 208
-- Data for Name: servico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.servico (id, nome, preco, descricao, hora_gasta) FROM stdin;
1	Selagem	80.00	Selagem de qualidade! Inveje as inimigas com seu cabelo liso.	04:30:00
2	Botox	50.00	Melhor alisamento custo benefício, mesmo levando um choque intenso não terá frizz.	02:30:00
3	Franja	20.00	Tem vontade de ser tornar uma Kawaii? Com a franja que faremos ficará igualzinha.	00:30:00
4	Lavagem Intensa	25.00	A melhor lavagem da região, usamos Clear Anticaspa e Desmaia Cabelo.	00:45:00
5	Chapinha	18.00	Quer ter o cabelo liso pra ir naquele casamento e arrasar? Garantimos isso pra você.	01:00:00
\.


--
-- TOC entry 3090 (class 0 OID 32985)
-- Dependencies: 202
-- Data for Name: telefone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telefone (id_usuario, telefone) FROM stdin;
1	+5535991011101
2	+5535991111292
3	+5535991211383
4	+5535991311474
5	+5535991411565
6	+5535991511656
7	+5535991611747
8	+5535991711838
9	+5535991811929
10	+5535991911010
\.


--
-- TOC entry 3089 (class 0 OID 32974)
-- Dependencies: 201
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id, email, password, cpf, nome) FROM stdin;
1	marilia@marilia.com	senha123	111.111.111.11	Marilia Dias
2	joana@joana.com	senha123	111.111.111.12	Joana Marta
3	maria@maria.com	senha123	111.111.111.13	Maria Joaquina
4	felisbina@felisbina.com	senha123	111.111.111.14	Felisbina Silva
5	josue@josue.com	senha123	111.111.111.15	Josué Antonieta
6	mirnalva@mirnalva.com	senha123	111.111.111.16	Mirnalva Silvana
7	elizandra@elizandra.com	senha123	111.111.111.17	Elizandra Ana
8	geralda@geralda.com	senha123	111.111.111.18	Geralda Silva
9	matheusa@matheusa.com	senha123	111.111.111.19	Matheusa Souza
10	silvana@silvana.com	senha123	111.111.111.10	Silvana Salomé
\.


--
-- TOC entry 3118 (class 0 OID 0)
-- Dependencies: 209
-- Name: atendimento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.atendimento_id_seq', 5, true);


--
-- TOC entry 3119 (class 0 OID 0)
-- Dependencies: 211
-- Name: comentario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_id_seq', 5, true);


--
-- TOC entry 3120 (class 0 OID 0)
-- Dependencies: 205
-- Name: feria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feria_id_seq', 5, true);


--
-- TOC entry 3121 (class 0 OID 0)
-- Dependencies: 216
-- Name: fornecedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fornecedor_id_seq', 5, true);


--
-- TOC entry 3122 (class 0 OID 0)
-- Dependencies: 213
-- Name: produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_id_seq', 5, true);


--
-- TOC entry 3123 (class 0 OID 0)
-- Dependencies: 207
-- Name: servico_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servico_id_seq', 5, true);


--
-- TOC entry 3124 (class 0 OID 0)
-- Dependencies: 200
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_seq', 10, true);


--
-- TOC entry 2935 (class 2606 OID 33060)
-- Name: atendimento atendimento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atendimento
    ADD CONSTRAINT atendimento_pkey PRIMARY KEY (id);


--
-- TOC entry 2929 (class 2606 OID 33015)
-- Name: cabeleireiro cabeleireiro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cabeleireiro
    ADD CONSTRAINT cabeleireiro_pkey PRIMARY KEY (id);


--
-- TOC entry 2927 (class 2606 OID 33002)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2937 (class 2606 OID 33087)
-- Name: comentario comentario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT comentario_pkey PRIMARY KEY (id);


--
-- TOC entry 2931 (class 2606 OID 33028)
-- Name: feria feria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feria
    ADD CONSTRAINT feria_pkey PRIMARY KEY (id);


--
-- TOC entry 2943 (class 2606 OID 33136)
-- Name: fornecedor fornecedor_email_cnpj_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_cnpj_cpf_key UNIQUE (email, cnpj, cpf);


--
-- TOC entry 2945 (class 2606 OID 33134)
-- Name: fornecedor fornecedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2939 (class 2606 OID 33108)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2941 (class 2606 OID 33113)
-- Name: produto_servico produto_servico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto_servico
    ADD CONSTRAINT produto_servico_pkey PRIMARY KEY (id_produto, id_servico);


--
-- TOC entry 2933 (class 2606 OID 33044)
-- Name: servico servico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servico
    ADD CONSTRAINT servico_pkey PRIMARY KEY (id);


--
-- TOC entry 2925 (class 2606 OID 32992)
-- Name: telefone telefone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_pkey PRIMARY KEY (id_usuario, telefone);


--
-- TOC entry 2921 (class 2606 OID 32984)
-- Name: usuario usuario_email_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_cpf_key UNIQUE (email, cpf);


--
-- TOC entry 2923 (class 2606 OID 32982)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 2952 (class 2606 OID 33071)
-- Name: atendimento atendimento_id_cabeleireiro_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atendimento
    ADD CONSTRAINT atendimento_id_cabeleireiro_fkey FOREIGN KEY (id_cabeleireiro) REFERENCES public.cabeleireiro(id);


--
-- TOC entry 2951 (class 2606 OID 33066)
-- Name: atendimento atendimento_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atendimento
    ADD CONSTRAINT atendimento_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id);


--
-- TOC entry 2950 (class 2606 OID 33061)
-- Name: atendimento atendimento_id_servico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atendimento
    ADD CONSTRAINT atendimento_id_servico_fkey FOREIGN KEY (id_servico) REFERENCES public.servico(id);


--
-- TOC entry 2948 (class 2606 OID 33016)
-- Name: cabeleireiro cabeleireiro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cabeleireiro
    ADD CONSTRAINT cabeleireiro_id_fkey FOREIGN KEY (id) REFERENCES public.usuario(id);


--
-- TOC entry 2947 (class 2606 OID 33003)
-- Name: cliente cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_id_fkey FOREIGN KEY (id) REFERENCES public.usuario(id);


--
-- TOC entry 2954 (class 2606 OID 33093)
-- Name: comentario comentario_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT comentario_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id) ON DELETE CASCADE;


--
-- TOC entry 2953 (class 2606 OID 33088)
-- Name: comentario comentario_id_servico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT comentario_id_servico_fkey FOREIGN KEY (id_servico) REFERENCES public.servico(id);


--
-- TOC entry 2949 (class 2606 OID 33029)
-- Name: feria feria_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feria
    ADD CONSTRAINT feria_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.cabeleireiro(id) ON DELETE CASCADE;


--
-- TOC entry 2957 (class 2606 OID 33137)
-- Name: fornecedor fornecedor_id_produto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_id_produto_fkey FOREIGN KEY (id_produto) REFERENCES public.produto(id);


--
-- TOC entry 2955 (class 2606 OID 33114)
-- Name: produto_servico produto_servico_id_produto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto_servico
    ADD CONSTRAINT produto_servico_id_produto_fkey FOREIGN KEY (id_produto) REFERENCES public.produto(id);


--
-- TOC entry 2956 (class 2606 OID 33119)
-- Name: produto_servico produto_servico_id_servico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto_servico
    ADD CONSTRAINT produto_servico_id_servico_fkey FOREIGN KEY (id_servico) REFERENCES public.servico(id);


--
-- TOC entry 2946 (class 2606 OID 32993)
-- Name: telefone telefone_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


-- Completed on 2020-10-26 13:07:06

--
-- PostgreSQL database dump complete
--

