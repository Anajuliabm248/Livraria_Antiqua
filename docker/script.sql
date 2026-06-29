--
-- PostgreSQL database dump
--

\restrict o8OSwNbAtraHcUnzGCja92j3XzUVTDX485fnJ08YcWEZGmYitd4hpaKfrHdpqtX

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.1

-- Started on 2026-06-29 20:44:08

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 50061)
-- Name: carrinho; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carrinho (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    valor_total numeric(10,2) DEFAULT 0.00 NOT NULL,
    CONSTRAINT chk_carrinho_total CHECK ((valor_total >= (0)::numeric))
);


ALTER TABLE public.carrinho OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 50069)
-- Name: carrinho_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carrinho_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carrinho_id_seq OWNER TO postgres;

--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 220
-- Name: carrinho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carrinho_id_seq OWNED BY public.carrinho.id;


--
-- TOC entry 221 (class 1259 OID 50070)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id integer NOT NULL,
    nome character varying(50) NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 50075)
-- Name: categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_id_seq OWNER TO postgres;

--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 222
-- Name: categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_id_seq OWNED BY public.categoria.id;


--
-- TOC entry 223 (class 1259 OID 50076)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id integer NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 50080)
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endereco (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    logradouro character varying(150) NOT NULL,
    numero integer NOT NULL,
    complemento character varying(50),
    bairro character varying(100) NOT NULL,
    cidade character varying(100) NOT NULL,
    estado character(2) NOT NULL,
    cep character varying(9) NOT NULL,
    pais character varying(50) DEFAULT 'Brasil'::character varying NOT NULL
);


ALTER TABLE public.endereco OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 50093)
-- Name: endereco_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endereco_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endereco_id_seq OWNER TO postgres;

--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 225
-- Name: endereco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endereco_id_seq OWNED BY public.endereco.id;


--
-- TOC entry 226 (class 1259 OID 50094)
-- Name: item_carrinho; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_carrinho (
    id integer NOT NULL,
    carrinho_id integer NOT NULL,
    livro_id integer NOT NULL,
    quantidade integer DEFAULT 1 NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    CONSTRAINT chk_item_qtd CHECK ((quantidade > 0)),
    CONSTRAINT chk_item_subtotal CHECK ((subtotal >= (0)::numeric))
);


ALTER TABLE public.item_carrinho OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 50105)
-- Name: item_carrinho_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_carrinho_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_carrinho_id_seq OWNER TO postgres;

--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 227
-- Name: item_carrinho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_carrinho_id_seq OWNED BY public.item_carrinho.id;


--
-- TOC entry 228 (class 1259 OID 50106)
-- Name: item_venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_venda (
    id integer NOT NULL,
    venda_id integer NOT NULL,
    livro_id integer NOT NULL,
    quantidade integer NOT NULL,
    preco_uni numeric(10,2) NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    CONSTRAINT chk_item_venda_preco CHECK ((preco_uni >= (0)::numeric)),
    CONSTRAINT chk_item_venda_qtd CHECK ((quantidade > 0)),
    CONSTRAINT chk_item_venda_subtotal CHECK ((subtotal >= (0)::numeric))
);


ALTER TABLE public.item_venda OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 50118)
-- Name: item_venda_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_venda_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_venda_id_seq OWNER TO postgres;

--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 229
-- Name: item_venda_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_venda_id_seq OWNED BY public.item_venda.id;


--
-- TOC entry 230 (class 1259 OID 50119)
-- Name: livro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.livro (
    id integer NOT NULL,
    categoria_id integer NOT NULL,
    nome character varying(150) NOT NULL,
    autor character varying(100) NOT NULL,
    isbn character varying(20) NOT NULL,
    descricao text,
    num_pagina integer,
    ano_lancamento integer,
    preco numeric(10,2) NOT NULL,
    quantidade integer DEFAULT 0 NOT NULL,
    img_capa character varying(255),
    vendedor_id integer,
    CONSTRAINT chk_livro_preco CHECK ((preco >= (0)::numeric)),
    CONSTRAINT chk_livro_quantidade CHECK ((quantidade >= 0))
);


ALTER TABLE public.livro OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 50134)
-- Name: livro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.livro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.livro_id_seq OWNER TO postgres;

--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 231
-- Name: livro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.livro_id_seq OWNED BY public.livro.id;


--
-- TOC entry 232 (class 1259 OID 50135)
-- Name: pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagamento (
    id integer NOT NULL,
    venda_id integer NOT NULL,
    forma_pagamento character varying(20) NOT NULL,
    status character varying(20) DEFAULT 'PENDENTE'::character varying NOT NULL,
    dt_pagamento date,
    valor numeric(10,2) NOT NULL,
    CONSTRAINT chk_pagamento_forma CHECK (((forma_pagamento)::text = ANY (ARRAY[('CARTAO'::character varying)::text, ('PIX'::character varying)::text, ('BOLETO'::character varying)::text]))),
    CONSTRAINT chk_pagamento_status CHECK (((status)::text = ANY (ARRAY[('PENDENTE'::character varying)::text, ('APROVADO'::character varying)::text, ('CANCELADO'::character varying)::text]))),
    CONSTRAINT chk_pagamento_valor CHECK ((valor >= (0)::numeric))
);


ALTER TABLE public.pagamento OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 50147)
-- Name: pagamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagamento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagamento_id_seq OWNER TO postgres;

--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 233
-- Name: pagamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagamento_id_seq OWNED BY public.pagamento.id;


--
-- TOC entry 234 (class 1259 OID 50148)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    cpf character varying(14) NOT NULL,
    telefone character varying(20),
    email character varying(100) NOT NULL,
    senha character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    tipo character varying(20) NOT NULL,
    CONSTRAINT chk_usuario_tipo CHECK (((tipo)::text = ANY (ARRAY[('CLIENTE'::character varying)::text, ('VENDEDOR'::character varying)::text])))
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 50162)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_id_seq OWNER TO postgres;

--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 235
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- TOC entry 236 (class 1259 OID 50163)
-- Name: venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venda (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    dt_venda date DEFAULT CURRENT_DATE NOT NULL,
    valor_total numeric(10,2) NOT NULL,
    status character varying(20) DEFAULT 'PENDENTE'::character varying NOT NULL,
    CONSTRAINT chk_venda_status CHECK (((status)::text = ANY (ARRAY[('PENDENTE'::character varying)::text, ('CONCLUIDA'::character varying)::text, ('CANCELADA'::character varying)::text]))),
    CONSTRAINT chk_venda_total CHECK ((valor_total >= (0)::numeric))
);


ALTER TABLE public.venda OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 50175)
-- Name: venda_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venda_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.venda_id_seq OWNER TO postgres;

--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 237
-- Name: venda_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venda_id_seq OWNED BY public.venda.id;


--
-- TOC entry 238 (class 1259 OID 50176)
-- Name: vendedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendedor (
    id integer NOT NULL
);


ALTER TABLE public.vendedor OWNER TO postgres;

--
-- TOC entry 4904 (class 2604 OID 50180)
-- Name: carrinho id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrinho ALTER COLUMN id SET DEFAULT nextval('public.carrinho_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 50181)
-- Name: categoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id SET DEFAULT nextval('public.categoria_id_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 50182)
-- Name: endereco id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco ALTER COLUMN id SET DEFAULT nextval('public.endereco_id_seq'::regclass);


--
-- TOC entry 4909 (class 2604 OID 50183)
-- Name: item_carrinho id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_carrinho ALTER COLUMN id SET DEFAULT nextval('public.item_carrinho_id_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 50184)
-- Name: item_venda id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda ALTER COLUMN id SET DEFAULT nextval('public.item_venda_id_seq'::regclass);


--
-- TOC entry 4912 (class 2604 OID 50185)
-- Name: livro id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro ALTER COLUMN id SET DEFAULT nextval('public.livro_id_seq'::regclass);


--
-- TOC entry 4914 (class 2604 OID 50186)
-- Name: pagamento id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento ALTER COLUMN id SET DEFAULT nextval('public.pagamento_id_seq'::regclass);


--
-- TOC entry 4916 (class 2604 OID 50187)
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- TOC entry 4918 (class 2604 OID 50188)
-- Name: venda id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda ALTER COLUMN id SET DEFAULT nextval('public.venda_id_seq'::regclass);


--
-- TOC entry 5135 (class 0 OID 50061)
-- Dependencies: 219
-- Data for Name: carrinho; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carrinho (id, cliente_id, valor_total) FROM stdin;
4	6	47.15
\.


--
-- TOC entry 5137 (class 0 OID 50070)
-- Dependencies: 221
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (id, nome) FROM stdin;
1	Romance
2	Mistério
3	Ficção
4	Ficção Científica
5	Biografia
6	Auto-biografia
7	Fantasia
8	Thriller
9	Terror
10	Ação
11	Aventura
12	Autoajuda
13	História
14	Negócios e Finanças
15	Religião e Espiriualidade
16	Infantil
17	Infantojuvenil
18	Quadrinhos
19	Poesia
20	Distopia
21	Policial
\.


--
-- TOC entry 5139 (class 0 OID 50076)
-- Dependencies: 223
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (id) FROM stdin;
6
\.


--
-- TOC entry 5140 (class 0 OID 50080)
-- Dependencies: 224
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.endereco (id, cliente_id, logradouro, numero, complemento, bairro, cidade, estado, cep, pais) FROM stdin;
3	6	Rua Rui Ramos	55	Casa	Silva	Sapucaia do Sul	RS	93210250	Brasil
\.


--
-- TOC entry 5142 (class 0 OID 50094)
-- Dependencies: 226
-- Data for Name: item_carrinho; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_carrinho (id, carrinho_id, livro_id, quantidade, subtotal) FROM stdin;
22	4	8	1	47.15
\.


--
-- TOC entry 5144 (class 0 OID 50106)
-- Dependencies: 228
-- Data for Name: item_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_venda (id, venda_id, livro_id, quantidade, preco_uni, subtotal) FROM stdin;
11	9	7	1	13.99	13.99
12	10	6	1	20.99	20.99
13	10	4	1	33.50	33.50
14	11	7	1	13.99	13.99
15	11	6	2	20.99	41.98
16	12	7	1	13.99	13.99
17	13	7	2	13.99	27.98
18	13	8	1	47.15	47.15
\.


--
-- TOC entry 5146 (class 0 OID 50119)
-- Dependencies: 230
-- Data for Name: livro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.livro (id, categoria_id, nome, autor, isbn, descricao, num_pagina, ano_lancamento, preco, quantidade, img_capa, vendedor_id) FROM stdin;
6	1	Noites Brancas	Fiodor Dostoievski 	978-6550970284	Noite branca é um fenômeno comum na Rússia, em especial em São Petersburgo, em que o sol permanece um pouco abaixo da linha do horizonte ao se por, deixando a madrugada clara. É nesse cenário de atmosfera lírica que dois jovens sonhadores se conhecem em uma ponte. Ao longo de quatro noites, os dois combinam de se ver para falar sobre suas vidas e compartilhar sonhos, angústias e reflexões, até o desfecho inesperado ao final do quarto encontro.\n	80	1848	20.99	15	1780250934658_noites_brancas.jpg	2
4	1	Orgulho e Preconceito	Jane Austen 	978-8573263350	rude e presunçoso. Após descobrir o envolvimento do detestável cavalheiro nos eventos que separaram sua querida irmã, Jane, e o jovem Bingley, Elizabeth está determinada a odiá-lo ainda mais. Mas uma surpreendente reviravolta poderá provar que as primeiras impressões nem sempre são incontestáveis.\n\nClássico romântico, Orgulho e preconceito é uma sátira social da Inglaterra do século XIX. A escrita elegante e irônica de Jane Austen tece personagens cativantes e memoráveis que acompanham a história da impetuosa Elizabeth Bennet e sua família em sua busca por amor e realização.	424	1818	33.50	18	1780251146483_orgulho_preconceito.jpg	2
7	3	A Morte de Ivan 	Liev Tosltói	978-8573263596	Ivan Ilitch acreditava ser um homem especial, não pensando no fim que todos terão igualmente um dia. Ele estava comprometido com a vida buscando ascensão profissional, status financeiro e o poder de um funcionário público do sistema judiciário da Rússia czarista.\r\n\r\nNo auge da carreira ele sofre um acidente trivial que gradualmente começa a atormentá-lo. Os médicos não conseguem aliviar o sofrimento dele nem lidar com a misteriosa doença que consome sua vida.\r\n\r\nA morte de Ivan Ilitch revela o desespero que surge com a consciência despertada para a verdadeira natureza da vida.	86	1886	13.99	17	1780266346549_morte_ivan_ilich.jpg	2
8	4	Admirável Mundo Novo	Aldous Huxley	978-6558881455	Uma sociedade inteiramente organizada segundo princípios científicos, na qual a mera menção das antiquadas palavras “pai” e “mãe” produzem repugnância. Um mundo de pessoas programadas em laboratório, e adestradas para cumprir seu papel numa sociedade de castas biologicamente definidas já no nascimento. Um mundo no qual a literatura, a música e o cinema só têm a função de solidificar o espírito de conformismo. Um universo que louva o avanço da técnica, a linha de montagem, a produção em série, a uniformidade, e que idolatra Henry Ford. Essa é a visão desenvolvida no clarividente romance distópico de Aldous Huxley, que ao lado de 1984, de George Orwell, constituem os exemplos mais marcantes, na esfera literária, da tematização de estados autoritários. Se o livro de Orwell criticava acidamente os governos totalitários de esquerda e de direita, o terror do stalinismo e a barbárie do nazifascismo, em Huxley o objeto é a sociedade capitalista, industrial e tecnológica, em que a racionalidade se tornou a nova religião, em que a ciência é o novo ídolo, um mundo no qual a experiência do sujeito não parece mais fazer nenhum sentido, e no qual a obra de Shakespeare adquire tons revolucionários. Entretanto, o moderno clássico de Huxley não é um mero exercício de futurismo ou de ficção científica. Trata-se, o que é mais grave, de um olhar agudo acerca das potencialidades autoritárias do próprio mundo em que vivemos. Como um alerta de que, ao não se preservarem os valores da civilização humanista, o que nos aguarda não é o róseo paraíso iluminista da liberdade, mas os grilhões de um admirável mundo novo.\r\n	315	1932	47.15	12	1780324141298_admiravel_mundo_novo.jpg	7
\.


--
-- TOC entry 5148 (class 0 OID 50135)
-- Dependencies: 232
-- Data for Name: pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagamento (id, venda_id, forma_pagamento, status, dt_pagamento, valor) FROM stdin;
11	11	CARTAO	APROVADO	2026-06-01	55.97
12	12	PIX	APROVADO	2026-06-01	13.99
13	13	PIX	APROVADO	2026-06-01	75.13
10	10	BOLETO	CANCELADO	2026-06-01	54.49
9	9	PIX	CANCELADO	2026-06-29	13.99
\.


--
-- TOC entry 5150 (class 0 OID 50148)
-- Dependencies: 234
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id, nome, cpf, telefone, email, senha, ativo, tipo) FROM stdin;
2	Silvia Justo	688.618.500-49	51997045895	silvia@gmail.com	1234	t	VENDEDOR
4	Francisco José	136.714.800-68	51997045988	francisco@gmail.com	1234	t	CLIENTE
6	Ana Júlia Bock Medina	040.044.670-71	51997045016	anajuliabm248@gmail.com	1234	t	CLIENTE
7	Alencar	123.123.123-20	51997045044	alencar@gmail.com	1234	t	VENDEDOR
\.


--
-- TOC entry 5152 (class 0 OID 50163)
-- Dependencies: 236
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venda (id, cliente_id, dt_venda, valor_total, status) FROM stdin;
11	6	2026-06-01	55.97	CONCLUIDA
12	6	2026-06-01	13.99	CONCLUIDA
13	6	2026-06-01	75.13	CONCLUIDA
10	6	2026-05-31	54.49	CANCELADA
9	6	2026-05-31	13.99	CANCELADA
\.


--
-- TOC entry 5154 (class 0 OID 50176)
-- Dependencies: 238
-- Data for Name: vendedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendedor (id) FROM stdin;
2
7
\.


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 220
-- Name: carrinho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carrinho_id_seq', 4, true);


--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 222
-- Name: categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_id_seq', 21, true);


--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 225
-- Name: endereco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.endereco_id_seq', 3, true);


--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 227
-- Name: item_carrinho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_carrinho_id_seq', 22, true);


--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 229
-- Name: item_venda_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_venda_id_seq', 18, true);


--
-- TOC entry 5175 (class 0 OID 0)
-- Dependencies: 231
-- Name: livro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.livro_id_seq', 8, true);


--
-- TOC entry 5176 (class 0 OID 0)
-- Dependencies: 233
-- Name: pagamento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagamento_id_seq', 13, true);


--
-- TOC entry 5177 (class 0 OID 0)
-- Dependencies: 235
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_seq', 7, true);


--
-- TOC entry 5178 (class 0 OID 0)
-- Dependencies: 237
-- Name: venda_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venda_id_seq', 24, true);


--
-- TOC entry 4936 (class 2606 OID 50190)
-- Name: carrinho carrinho_cliente_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrinho
    ADD CONSTRAINT carrinho_cliente_id_key UNIQUE (cliente_id);


--
-- TOC entry 4938 (class 2606 OID 50192)
-- Name: carrinho carrinho_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrinho
    ADD CONSTRAINT carrinho_pkey PRIMARY KEY (id);


--
-- TOC entry 4940 (class 2606 OID 50194)
-- Name: categoria categoria_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_nome_key UNIQUE (nome);


--
-- TOC entry 4942 (class 2606 OID 50196)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id);


--
-- TOC entry 4944 (class 2606 OID 50198)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 4946 (class 2606 OID 50200)
-- Name: endereco endereco_cliente_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_cliente_id_key UNIQUE (cliente_id);


--
-- TOC entry 4948 (class 2606 OID 50202)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 4950 (class 2606 OID 50204)
-- Name: item_carrinho item_carrinho_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_carrinho
    ADD CONSTRAINT item_carrinho_pkey PRIMARY KEY (id);


--
-- TOC entry 4954 (class 2606 OID 50206)
-- Name: item_venda item_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda
    ADD CONSTRAINT item_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 4958 (class 2606 OID 50208)
-- Name: livro livro_isbn_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_isbn_key UNIQUE (isbn);


--
-- TOC entry 4960 (class 2606 OID 50210)
-- Name: livro livro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_pkey PRIMARY KEY (id);


--
-- TOC entry 4962 (class 2606 OID 50212)
-- Name: pagamento pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 4964 (class 2606 OID 50214)
-- Name: pagamento pagamento_venda_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_venda_id_key UNIQUE (venda_id);


--
-- TOC entry 4952 (class 2606 OID 50216)
-- Name: item_carrinho uq_item_carrinho; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_carrinho
    ADD CONSTRAINT uq_item_carrinho UNIQUE (carrinho_id, livro_id);


--
-- TOC entry 4966 (class 2606 OID 50218)
-- Name: usuario usuario_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_cpf_key UNIQUE (cpf);


--
-- TOC entry 4968 (class 2606 OID 50220)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 4970 (class 2606 OID 50222)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 4973 (class 2606 OID 50224)
-- Name: venda venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pkey PRIMARY KEY (id);


--
-- TOC entry 4975 (class 2606 OID 50226)
-- Name: vendedor vendedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT vendedor_pkey PRIMARY KEY (id);


--
-- TOC entry 4955 (class 1259 OID 50227)
-- Name: idx_livro_categoria; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_livro_categoria ON public.livro USING btree (categoria_id);


--
-- TOC entry 4956 (class 1259 OID 50228)
-- Name: idx_livro_isbn; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_livro_isbn ON public.livro USING btree (isbn);


--
-- TOC entry 4971 (class 1259 OID 50229)
-- Name: idx_venda_cliente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_venda_cliente ON public.venda USING btree (cliente_id);


--
-- TOC entry 4976 (class 2606 OID 50230)
-- Name: carrinho carrinho_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrinho
    ADD CONSTRAINT carrinho_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(id) ON DELETE CASCADE;


--
-- TOC entry 4977 (class 2606 OID 50235)
-- Name: cliente cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_id_fkey FOREIGN KEY (id) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 4978 (class 2606 OID 50240)
-- Name: endereco endereco_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(id) ON DELETE CASCADE;


--
-- TOC entry 4983 (class 2606 OID 50245)
-- Name: livro fk_livro_vendedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro
    ADD CONSTRAINT fk_livro_vendedor FOREIGN KEY (vendedor_id) REFERENCES public.usuario(id);


--
-- TOC entry 4979 (class 2606 OID 50250)
-- Name: item_carrinho item_carrinho_carrinho_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_carrinho
    ADD CONSTRAINT item_carrinho_carrinho_id_fkey FOREIGN KEY (carrinho_id) REFERENCES public.carrinho(id) ON DELETE CASCADE;


--
-- TOC entry 4980 (class 2606 OID 50255)
-- Name: item_carrinho item_carrinho_livro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_carrinho
    ADD CONSTRAINT item_carrinho_livro_id_fkey FOREIGN KEY (livro_id) REFERENCES public.livro(id);


--
-- TOC entry 4981 (class 2606 OID 50260)
-- Name: item_venda item_venda_livro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda
    ADD CONSTRAINT item_venda_livro_id_fkey FOREIGN KEY (livro_id) REFERENCES public.livro(id);


--
-- TOC entry 4982 (class 2606 OID 50265)
-- Name: item_venda item_venda_venda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda
    ADD CONSTRAINT item_venda_venda_id_fkey FOREIGN KEY (venda_id) REFERENCES public.venda(id) ON DELETE CASCADE;


--
-- TOC entry 4984 (class 2606 OID 50270)
-- Name: livro livro_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categoria(id);


--
-- TOC entry 4985 (class 2606 OID 50275)
-- Name: pagamento pagamento_venda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_venda_id_fkey FOREIGN KEY (venda_id) REFERENCES public.venda(id) ON DELETE CASCADE;


--
-- TOC entry 4986 (class 2606 OID 50280)
-- Name: venda venda_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);


--
-- TOC entry 4987 (class 2606 OID 50285)
-- Name: vendedor vendedor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT vendedor_id_fkey FOREIGN KEY (id) REFERENCES public.usuario(id) ON DELETE CASCADE;


-- Completed on 2026-06-29 20:44:09

--
-- PostgreSQL database dump complete
--

\unrestrict o8OSwNbAtraHcUnzGCja92j3XzUVTDX485fnJ08YcWEZGmYitd4hpaKfrHdpqtX

