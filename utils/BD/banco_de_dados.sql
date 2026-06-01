--
-- PostgreSQL database dump
--


-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.1

-- Started on 2026-05-31 21:30:45

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA IF NOT EXISTS public;


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
-- TOC entry 230 (class 1259 OID 49705)
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
-- TOC entry 229 (class 1259 OID 49704)
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
-- Dependencies: 229
-- Name: carrinho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carrinho_id_seq OWNED BY public.carrinho.id;


--
-- TOC entry 226 (class 1259 OID 49665)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id integer NOT NULL,
    nome character varying(50) NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 49664)
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
-- Dependencies: 225
-- Name: categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_id_seq OWNED BY public.categoria.id;


--
-- TOC entry 221 (class 1259 OID 49618)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id integer NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 49641)
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
-- TOC entry 223 (class 1259 OID 49640)
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
-- Dependencies: 223
-- Name: endereco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endereco_id_seq OWNED BY public.endereco.id;


--
-- TOC entry 232 (class 1259 OID 49724)
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
-- TOC entry 231 (class 1259 OID 49723)
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
-- Dependencies: 231
-- Name: item_carrinho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_carrinho_id_seq OWNED BY public.item_carrinho.id;


--
-- TOC entry 236 (class 1259 OID 49773)
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
-- TOC entry 235 (class 1259 OID 49772)
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
-- Dependencies: 235
-- Name: item_venda_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_venda_id_seq OWNED BY public.item_venda.id;


--
-- TOC entry 228 (class 1259 OID 49676)
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
-- TOC entry 227 (class 1259 OID 49675)
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
-- Dependencies: 227
-- Name: livro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.livro_id_seq OWNED BY public.livro.id;


--
-- TOC entry 238 (class 1259 OID 49799)
-- Name: pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagamento (
    id integer NOT NULL,
    venda_id integer NOT NULL,
    forma_pagamento character varying(20) NOT NULL,
    status character varying(20) DEFAULT 'PENDENTE'::character varying NOT NULL,
    dt_pagamento date,
    valor numeric(10,2) NOT NULL,
    CONSTRAINT chk_pagamento_forma CHECK (((forma_pagamento)::text = ANY ((ARRAY['CARTAO'::character varying, 'PIX'::character varying, 'BOLETO'::character varying])::text[]))),
    CONSTRAINT chk_pagamento_status CHECK (((status)::text = ANY ((ARRAY['PENDENTE'::character varying, 'APROVADO'::character varying, 'CANCELADO'::character varying])::text[]))),
    CONSTRAINT chk_pagamento_valor CHECK ((valor >= (0)::numeric))
);


ALTER TABLE public.pagamento OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 49798)
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
-- Dependencies: 237
-- Name: pagamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagamento_id_seq OWNED BY public.pagamento.id;


--
-- TOC entry 220 (class 1259 OID 49597)
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
    CONSTRAINT chk_usuario_tipo CHECK (((tipo)::text = ANY ((ARRAY['CLIENTE'::character varying, 'VENDEDOR'::character varying])::text[])))
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 49596)
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
-- Dependencies: 219
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- TOC entry 234 (class 1259 OID 49751)
-- Name: venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venda (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    dt_venda date DEFAULT CURRENT_DATE NOT NULL,
    valor_total numeric(10,2) NOT NULL,
    status character varying(20) DEFAULT 'PENDENTE'::character varying NOT NULL,
    CONSTRAINT chk_venda_status CHECK (((status)::text = ANY ((ARRAY['PENDENTE'::character varying, 'CONCLUIDA'::character varying, 'CANCELADA'::character varying])::text[]))),
    CONSTRAINT chk_venda_total CHECK ((valor_total >= (0)::numeric))
);


ALTER TABLE public.venda OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 49750)
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
-- Dependencies: 233
-- Name: venda_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venda_id_seq OWNED BY public.venda.id;


--
-- TOC entry 222 (class 1259 OID 49629)
-- Name: vendedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendedor (
    id integer NOT NULL
);


ALTER TABLE public.vendedor OWNER TO postgres;

--
-- TOC entry 4911 (class 2604 OID 49708)
-- Name: carrinho id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrinho ALTER COLUMN id SET DEFAULT nextval('public.carrinho_id_seq'::regclass);


--
-- TOC entry 4908 (class 2604 OID 49668)
-- Name: categoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id SET DEFAULT nextval('public.categoria_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 49644)
-- Name: endereco id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco ALTER COLUMN id SET DEFAULT nextval('public.endereco_id_seq'::regclass);


--
-- TOC entry 4913 (class 2604 OID 49727)
-- Name: item_carrinho id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_carrinho ALTER COLUMN id SET DEFAULT nextval('public.item_carrinho_id_seq'::regclass);


--
-- TOC entry 4918 (class 2604 OID 49776)
-- Name: item_venda id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda ALTER COLUMN id SET DEFAULT nextval('public.item_venda_id_seq'::regclass);


--
-- TOC entry 4909 (class 2604 OID 49679)
-- Name: livro id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro ALTER COLUMN id SET DEFAULT nextval('public.livro_id_seq'::regclass);


--
-- TOC entry 4919 (class 2604 OID 49802)
-- Name: pagamento id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento ALTER COLUMN id SET DEFAULT nextval('public.pagamento_id_seq'::regclass);


--
-- TOC entry 4904 (class 2604 OID 49600)
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- TOC entry 4915 (class 2604 OID 49754)
-- Name: venda id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda ALTER COLUMN id SET DEFAULT nextval('public.venda_id_seq'::regclass);



--
-- TOC entry 5142 (class 0 OID 49665)
-- Dependencies: 226
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categoria VALUES (1, 'Romance');
INSERT INTO public.categoria VALUES (2, 'Mistério');
INSERT INTO public.categoria VALUES (3, 'Ficção');
INSERT INTO public.categoria VALUES (4, 'Ficção Científica');
INSERT INTO public.categoria VALUES (5, 'Biografia');
INSERT INTO public.categoria VALUES (6, 'Auto-biografia');
INSERT INTO public.categoria VALUES (7, 'Fantasia');
INSERT INTO public.categoria VALUES (8, 'Thriller');
INSERT INTO public.categoria VALUES (9, 'Terror');
INSERT INTO public.categoria VALUES (10, 'Ação');
INSERT INTO public.categoria VALUES (11, 'Aventura');
INSERT INTO public.categoria VALUES (12, 'Autoajuda');
INSERT INTO public.categoria VALUES (13, 'História');
INSERT INTO public.categoria VALUES (14, 'Negócios e Finanças');
INSERT INTO public.categoria VALUES (15, 'Religião e Espiriualidade');
INSERT INTO public.categoria VALUES (16, 'Infantil');
INSERT INTO public.categoria VALUES (17, 'Infantojuvenil');
INSERT INTO public.categoria VALUES (18, 'Quadrinhos');
INSERT INTO public.categoria VALUES (19, 'Poesia');
INSERT INTO public.categoria VALUES (20, 'Distopia');
INSERT INTO public.categoria VALUES (21, 'Policial');



-- TOC entry 5144 (class 0 OID 49676)
-- Dependencies: 228
-- Data for Name: livro; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.livro VALUES (4, 1, 'Orgulho e Preconceito', 'Jane Austen ', '978-8573263350', 'rude e presunçoso. Após descobrir o envolvimento do detestável cavalheiro nos eventos que separaram sua querida irmã, Jane, e o jovem Bingley, Elizabeth está determinada a odiá-lo ainda mais. Mas uma surpreendente reviravolta poderá provar que as primeiras impressões nem sempre são incontestáveis.

Clássico romântico, Orgulho e preconceito é uma sátira social da Inglaterra do século XIX. A escrita elegante e irônica de Jane Austen tece personagens cativantes e memoráveis que acompanham a história da impetuosa Elizabeth Bennet e sua família em sua busca por amor e realização.', 424, 1818, 33.50, 18, '1780251146483_orgulho_preconceito.jpg', 2);
INSERT INTO public.livro VALUES (6, 1, 'Noites Brancas', 'Fiodor Dostoievski ', '978-6550970284', 'Noite branca é um fenômeno comum na Rússia, em especial em São Petersburgo, em que o sol permanece um pouco abaixo da linha do horizonte ao se por, deixando a madrugada clara. É nesse cenário de atmosfera lírica que dois jovens sonhadores se conhecem em uma ponte. Ao longo de quatro noites, os dois combinam de se ver para falar sobre suas vidas e compartilhar sonhos, angústias e reflexões, até o desfecho inesperado ao final do quarto encontro.
', 80, 1848, 20.99, 17, '1780250934658_noites_brancas.jpg', 2);
INSERT INTO public.livro VALUES (7, 3, 'A Morte de Ivan Ilich', 'Liev Tosltói', '978-8573263596', 'Ivan Ilitch acreditava ser um homem especial, não pensando no fim que todos terão igualmente um dia. Ele estava comprometido com a vida buscando ascensão profissional, status financeiro e o poder de um funcionário público do sistema judiciário da Rússia czarista.

No auge da carreira ele sofre um acidente trivial que gradualmente começa a atormentá-lo. Os médicos não conseguem aliviar o sofrimento dele nem lidar com a misteriosa doença que consome sua vida.

A morte de Ivan Ilitch revela o desespero que surge com a consciência despertada para a verdadeira natureza da vida.', 86, 1886, 13.99, 40, '1780266346549_morte_ivan_ilich.jpg', 2);




--
-- TOC entry 5136 (class 0 OID 49597)
-- Dependencies: 220
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuario VALUES (2, 'Silvia Justo', '688.618.500-49', '51997045895', 'silvia@gmail.com', '1234', true, 'VENDEDOR');
INSERT INTO public.usuario VALUES (4, 'Francisco José', '136.714.800-68', '51997045988', 'francisco@gmail.com', '1234', true, 'CLIENTE');


--
-- TOC entry 5138 (class 0 OID 49629)
-- Dependencies: 222
-- Data for Name: vendedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vendedor VALUES (2);


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 229
-- Name: carrinho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carrinho_id_seq', 3, true);


--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 225
-- Name: categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_id_seq', 21, true);


--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 223
-- Name: endereco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.endereco_id_seq', 2, true);


--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 231
-- Name: item_carrinho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_carrinho_id_seq', 13, true);


--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 235
-- Name: item_venda_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_venda_id_seq', 10, true);


--
-- TOC entry 5175 (class 0 OID 0)
-- Dependencies: 227
-- Name: livro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.livro_id_seq', 7, true);


--
-- TOC entry 5176 (class 0 OID 0)
-- Dependencies: 237
-- Name: pagamento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagamento_id_seq', 8, true);


--
-- TOC entry 5177 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_seq', 5, true);


--
-- TOC entry 5178 (class 0 OID 0)
-- Dependencies: 233
-- Name: venda_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venda_id_seq', 8, true);


--
-- TOC entry 4960 (class 2606 OID 49717)
-- Name: carrinho carrinho_cliente_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrinho
    ADD CONSTRAINT carrinho_cliente_id_key UNIQUE (cliente_id);


--
-- TOC entry 4962 (class 2606 OID 49715)
-- Name: carrinho carrinho_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrinho
    ADD CONSTRAINT carrinho_pkey PRIMARY KEY (id);


--
-- TOC entry 4950 (class 2606 OID 49674)
-- Name: categoria categoria_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_nome_key UNIQUE (nome);


--
-- TOC entry 4952 (class 2606 OID 49672)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id);


--
-- TOC entry 4942 (class 2606 OID 49623)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 4946 (class 2606 OID 49658)
-- Name: endereco endereco_cliente_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_cliente_id_key UNIQUE (cliente_id);


--
-- TOC entry 4948 (class 2606 OID 49656)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 4964 (class 2606 OID 49737)
-- Name: item_carrinho item_carrinho_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_carrinho
    ADD CONSTRAINT item_carrinho_pkey PRIMARY KEY (id);


--
-- TOC entry 4971 (class 2606 OID 49787)
-- Name: item_venda item_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda
    ADD CONSTRAINT item_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 4956 (class 2606 OID 49822)
-- Name: livro livro_isbn_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_isbn_key UNIQUE (isbn);


--
-- TOC entry 4958 (class 2606 OID 49694)
-- Name: livro livro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_pkey PRIMARY KEY (id);


--
-- TOC entry 4973 (class 2606 OID 49813)
-- Name: pagamento pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 4975 (class 2606 OID 49815)
-- Name: pagamento pagamento_venda_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_venda_id_key UNIQUE (venda_id);


--
-- TOC entry 4966 (class 2606 OID 49739)
-- Name: item_carrinho uq_item_carrinho; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_carrinho
    ADD CONSTRAINT uq_item_carrinho UNIQUE (carrinho_id, livro_id);


--
-- TOC entry 4936 (class 2606 OID 49615)
-- Name: usuario usuario_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_cpf_key UNIQUE (cpf);


--
-- TOC entry 4938 (class 2606 OID 49617)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 4940 (class 2606 OID 49613)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 4969 (class 2606 OID 49765)
-- Name: venda venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pkey PRIMARY KEY (id);


--
-- TOC entry 4944 (class 2606 OID 49634)
-- Name: vendedor vendedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT vendedor_pkey PRIMARY KEY (id);


--
-- TOC entry 4953 (class 1259 OID 49702)
-- Name: idx_livro_categoria; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_livro_categoria ON public.livro USING btree (categoria_id);


--
-- TOC entry 4954 (class 1259 OID 49823)
-- Name: idx_livro_isbn; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_livro_isbn ON public.livro USING btree (isbn);


--
-- TOC entry 4967 (class 1259 OID 49771)
-- Name: idx_venda_cliente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_venda_cliente ON public.venda USING btree (cliente_id);


--
-- TOC entry 4981 (class 2606 OID 49718)
-- Name: carrinho carrinho_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrinho
    ADD CONSTRAINT carrinho_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(id) ON DELETE CASCADE;


--
-- TOC entry 4976 (class 2606 OID 49624)
-- Name: cliente cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_id_fkey FOREIGN KEY (id) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 4978 (class 2606 OID 49659)
-- Name: endereco endereco_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(id) ON DELETE CASCADE;


--
-- TOC entry 4979 (class 2606 OID 49825)
-- Name: livro fk_livro_vendedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro
    ADD CONSTRAINT fk_livro_vendedor FOREIGN KEY (vendedor_id) REFERENCES public.usuario(id);


--
-- TOC entry 4982 (class 2606 OID 49740)
-- Name: item_carrinho item_carrinho_carrinho_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_carrinho
    ADD CONSTRAINT item_carrinho_carrinho_id_fkey FOREIGN KEY (carrinho_id) REFERENCES public.carrinho(id) ON DELETE CASCADE;


--
-- TOC entry 4983 (class 2606 OID 49745)
-- Name: item_carrinho item_carrinho_livro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_carrinho
    ADD CONSTRAINT item_carrinho_livro_id_fkey FOREIGN KEY (livro_id) REFERENCES public.livro(id);


--
-- TOC entry 4985 (class 2606 OID 49793)
-- Name: item_venda item_venda_livro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda
    ADD CONSTRAINT item_venda_livro_id_fkey FOREIGN KEY (livro_id) REFERENCES public.livro(id);


--
-- TOC entry 4986 (class 2606 OID 49788)
-- Name: item_venda item_venda_venda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda
    ADD CONSTRAINT item_venda_venda_id_fkey FOREIGN KEY (venda_id) REFERENCES public.venda(id) ON DELETE CASCADE;


--
-- TOC entry 4980 (class 2606 OID 49697)
-- Name: livro livro_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categoria(id);


--
-- TOC entry 4987 (class 2606 OID 49816)
-- Name: pagamento pagamento_venda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_venda_id_fkey FOREIGN KEY (venda_id) REFERENCES public.venda(id) ON DELETE CASCADE;


--
-- TOC entry 4984 (class 2606 OID 49766)
-- Name: venda venda_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);


--
-- TOC entry 4977 (class 2606 OID 49635)
-- Name: vendedor vendedor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT vendedor_id_fkey FOREIGN KEY (id) REFERENCES public.usuario(id) ON DELETE CASCADE;


-- Completed on 2026-05-31 21:30:46

--
-- PostgreSQL database dump complete
--



