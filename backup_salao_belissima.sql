PGDMP         9                x            salaooo    13.0    13.0 X    ;           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            <           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            =           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            >           1262    50245    salaooo    DATABASE     g   CREATE DATABASE salaooo WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE salaooo;
                postgres    false            �           1247    50301    estadeferias    TYPE     >   CREATE TYPE public.estadeferias AS ENUM (
    'V',
    'F'
);
    DROP TYPE public.estadeferias;
       public          postgres    false            �           1247    50273    sexo    TYPE     E   CREATE TYPE public.sexo AS ENUM (
    'Masculino',
    'Feminino'
);
    DROP TYPE public.sexo;
       public          postgres    false            �           1247    50331    status    TYPE     W   CREATE TYPE public.status AS ENUM (
    'Marcado',
    'Realizado',
    'Cancelado'
);
    DROP TYPE public.status;
       public          postgres    false            �            1255    50430    estadeferias()    FUNCTION     �  CREATE FUNCTION public.estadeferias() RETURNS void
    LANGUAGE plpgsql
    AS $$
declare f feria%rowtype;
BEGIN
	for f in (select * from feria) loop
	
		if (f.data_inicio <= CURRENT_DATE and f.data_fim >= CURRENT_DATE) then
				update feria set estadeferias = 'V' where 
				id = f.id;
			 else 
			 	update feria set estadeferias = 'F' where 
				id = f.id;
			 end if;
			 
	end loop;
	return;
END;
$$;
 %   DROP FUNCTION public.estadeferias();
       public          postgres    false            �            1255    50427    verifica_atendimento()    FUNCTION        CREATE FUNCTION public.verifica_atendimento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF (NEW.data IN (SELECT atendimento.data FROM atendimento) and
		NEW.horario IN (SELECT atendimento.horario FROM atendimento) and 
		NEW.id_cabeleireiro IN (SELECT atendimento.id_cabeleireiro FROM atendimento WHERE horario = NEW.horario and data = NEW.data)) THEN
		RAISE EXCEPTION 'O corte para esse dia e com esse cabeleireiro neste horário não está disponível!';
	END IF;
	
	IF (NEW.data < CURRENT_DATE OR NEW.data = CURRENT_DATE AND NEW.horario < LOCALTIME OR NEW.id_cabeleireiro NOT IN (SELECT atendimento.id_cabeleireiro FROM atendimento)) THEN
		RAISE EXCEPTION 'Data e horário inválidos ou o cabeleireiro não existe!';
	END IF;
	
	RETURN NEW;
	END;
$$;
 -   DROP FUNCTION public.verifica_atendimento();
       public          postgres    false            �            1259    50339    atendimento    TABLE       CREATE TABLE public.atendimento (
    id integer NOT NULL,
    horario time without time zone NOT NULL,
    data date NOT NULL,
    id_servico integer NOT NULL,
    id_cliente integer NOT NULL,
    id_cabeleireiro integer NOT NULL,
    status public.status NOT NULL
);
    DROP TABLE public.atendimento;
       public         heap    postgres    false    675            �            1259    50337    atendimento_id_seq    SEQUENCE     �   CREATE SEQUENCE public.atendimento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.atendimento_id_seq;
       public          postgres    false    210            ?           0    0    atendimento_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.atendimento_id_seq OWNED BY public.atendimento.id;
          public          postgres    false    209            �            1259    50287    cabeleireiro    TABLE     �   CREATE TABLE public.cabeleireiro (
    id integer NOT NULL,
    rua character varying NOT NULL,
    numero integer NOT NULL,
    cidade character varying(28) NOT NULL,
    estado character varying(2) NOT NULL
);
     DROP TABLE public.cabeleireiro;
       public         heap    postgres    false            �            1259    50277    cliente    TABLE     {   CREATE TABLE public.cliente (
    id integer NOT NULL,
    data_nascimento date NOT NULL,
    sexo public.sexo NOT NULL
);
    DROP TABLE public.cliente;
       public         heap    postgres    false    653            �            1259    50362 
   comentario    TABLE        CREATE TABLE public.comentario (
    id integer NOT NULL,
    titulo character varying(40) NOT NULL,
    descricao character varying NOT NULL,
    data date DEFAULT CURRENT_DATE NOT NULL,
    id_servico integer NOT NULL,
    id_cliente integer NOT NULL
);
    DROP TABLE public.comentario;
       public         heap    postgres    false            �            1259    50360    comentario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.comentario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.comentario_id_seq;
       public          postgres    false    212            @           0    0    comentario_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.comentario_id_seq OWNED BY public.comentario.id;
          public          postgres    false    211            �            1259    50307    feria    TABLE     �   CREATE TABLE public.feria (
    id smallint NOT NULL,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    id_usuario integer NOT NULL,
    estadeferias public.estadeferias NOT NULL
);
    DROP TABLE public.feria;
       public         heap    postgres    false    663            �            1259    50305    feria_id_seq    SEQUENCE     �   CREATE SEQUENCE public.feria_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.feria_id_seq;
       public          postgres    false    206            A           0    0    feria_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.feria_id_seq OWNED BY public.feria.id;
          public          postgres    false    205            �            1259    50411 
   fornecedor    TABLE       CREATE TABLE public.fornecedor (
    id smallint NOT NULL,
    nome character varying(65) NOT NULL,
    email character varying NOT NULL,
    telefone character varying NOT NULL,
    cnpj character varying(18),
    cpf character varying(14),
    id_produto integer NOT NULL
);
    DROP TABLE public.fornecedor;
       public         heap    postgres    false            �            1259    50409    fornecedor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.fornecedor_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.fornecedor_id_seq;
       public          postgres    false    217            B           0    0    fornecedor_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.fornecedor_id_seq OWNED BY public.fornecedor.id;
          public          postgres    false    216            �            1259    50384    produto    TABLE     �   CREATE TABLE public.produto (
    id smallint NOT NULL,
    nome character varying(25) NOT NULL,
    marca character varying(20),
    preco numeric DEFAULT 0.00 NOT NULL,
    validade date,
    quantidade integer
);
    DROP TABLE public.produto;
       public         heap    postgres    false            �            1259    50382    produto_id_seq    SEQUENCE     �   CREATE SEQUENCE public.produto_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.produto_id_seq;
       public          postgres    false    214            C           0    0    produto_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.produto_id_seq OWNED BY public.produto.id;
          public          postgres    false    213            �            1259    50394    produto_servico    TABLE     j   CREATE TABLE public.produto_servico (
    id_produto integer NOT NULL,
    id_servico integer NOT NULL
);
 #   DROP TABLE public.produto_servico;
       public         heap    postgres    false            �            1259    50435    produtos    MATERIALIZED VIEW     (  CREATE MATERIALIZED VIEW public.produtos AS
 SELECT pdt.nome AS produto,
    pdt.id AS "código",
    pdt.marca,
    pdt.preco AS "preço",
    forn.nome AS fonecedor,
    forn.telefone
   FROM (public.produto pdt
     JOIN public.fornecedor forn ON ((pdt.id = forn.id_produto)))
  WITH NO DATA;
 (   DROP MATERIALIZED VIEW public.produtos;
       public         heap    postgres    false    217    214    214    214    214    217    217            �            1259    50320    servico    TABLE       CREATE TABLE public.servico (
    id smallint NOT NULL,
    nome character varying(25) NOT NULL,
    preco numeric NOT NULL,
    descricao character varying NOT NULL,
    hora_gasta time without time zone NOT NULL,
    CONSTRAINT servico_preco_check CHECK ((preco > (0)::numeric))
);
    DROP TABLE public.servico;
       public         heap    postgres    false            �            1259    50318    servico_id_seq    SEQUENCE     �   CREATE SEQUENCE public.servico_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.servico_id_seq;
       public          postgres    false    208            D           0    0    servico_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.servico_id_seq OWNED BY public.servico.id;
          public          postgres    false    207            �            1259    50431 	   serviços    VIEW     �   CREATE VIEW public."serviços" AS
 SELECT servico.id AS "código",
    servico.nome AS "serviço",
    servico.preco AS "preço",
    servico.descricao AS "descrição",
    servico.hora_gasta AS "tempoduração"
   FROM public.servico;
    DROP VIEW public."serviços";
       public          postgres    false    208    208    208    208    208            �            1259    50259    telefone    TABLE     k   CREATE TABLE public.telefone (
    id_usuario integer NOT NULL,
    telefone character varying NOT NULL
);
    DROP TABLE public.telefone;
       public         heap    postgres    false            �            1259    50248    usuario    TABLE     �   CREATE TABLE public.usuario (
    id integer NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    cpf character varying(14) NOT NULL,
    nome character varying(60) NOT NULL
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            �            1259    50246    usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.usuario_id_seq;
       public          postgres    false    201            E           0    0    usuario_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;
          public          postgres    false    200            u           2604    50342    atendimento id    DEFAULT     p   ALTER TABLE ONLY public.atendimento ALTER COLUMN id SET DEFAULT nextval('public.atendimento_id_seq'::regclass);
 =   ALTER TABLE public.atendimento ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    209    210            v           2604    50365    comentario id    DEFAULT     n   ALTER TABLE ONLY public.comentario ALTER COLUMN id SET DEFAULT nextval('public.comentario_id_seq'::regclass);
 <   ALTER TABLE public.comentario ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    211    212            r           2604    50310    feria id    DEFAULT     d   ALTER TABLE ONLY public.feria ALTER COLUMN id SET DEFAULT nextval('public.feria_id_seq'::regclass);
 7   ALTER TABLE public.feria ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    205    206            z           2604    50414    fornecedor id    DEFAULT     n   ALTER TABLE ONLY public.fornecedor ALTER COLUMN id SET DEFAULT nextval('public.fornecedor_id_seq'::regclass);
 <   ALTER TABLE public.fornecedor ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216    217            x           2604    50387 
   produto id    DEFAULT     h   ALTER TABLE ONLY public.produto ALTER COLUMN id SET DEFAULT nextval('public.produto_id_seq'::regclass);
 9   ALTER TABLE public.produto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    214    214            s           2604    50323 
   servico id    DEFAULT     h   ALTER TABLE ONLY public.servico ALTER COLUMN id SET DEFAULT nextval('public.servico_id_seq'::regclass);
 9   ALTER TABLE public.servico ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    207    208    208            q           2604    50251 
   usuario id    DEFAULT     h   ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);
 9   ALTER TABLE public.usuario ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200    201            0          0    50339    atendimento 
   TABLE DATA           i   COPY public.atendimento (id, horario, data, id_servico, id_cliente, id_cabeleireiro, status) FROM stdin;
    public          postgres    false    210   <l       *          0    50287    cabeleireiro 
   TABLE DATA           G   COPY public.cabeleireiro (id, rua, numero, cidade, estado) FROM stdin;
    public          postgres    false    204   �l       )          0    50277    cliente 
   TABLE DATA           <   COPY public.cliente (id, data_nascimento, sexo) FROM stdin;
    public          postgres    false    203   �m       2          0    50362 
   comentario 
   TABLE DATA           Y   COPY public.comentario (id, titulo, descricao, data, id_servico, id_cliente) FROM stdin;
    public          postgres    false    212   n       ,          0    50307    feria 
   TABLE DATA           T   COPY public.feria (id, data_inicio, data_fim, id_usuario, estadeferias) FROM stdin;
    public          postgres    false    206   �o       7          0    50411 
   fornecedor 
   TABLE DATA           V   COPY public.fornecedor (id, nome, email, telefone, cnpj, cpf, id_produto) FROM stdin;
    public          postgres    false    217   �o       4          0    50384    produto 
   TABLE DATA           O   COPY public.produto (id, nome, marca, preco, validade, quantidade) FROM stdin;
    public          postgres    false    214   �p       5          0    50394    produto_servico 
   TABLE DATA           A   COPY public.produto_servico (id_produto, id_servico) FROM stdin;
    public          postgres    false    215   �q       .          0    50320    servico 
   TABLE DATA           I   COPY public.servico (id, nome, preco, descricao, hora_gasta) FROM stdin;
    public          postgres    false    208   r       (          0    50259    telefone 
   TABLE DATA           8   COPY public.telefone (id_usuario, telefone) FROM stdin;
    public          postgres    false    202   ~s       '          0    50248    usuario 
   TABLE DATA           A   COPY public.usuario (id, email, password, cpf, nome) FROM stdin;
    public          postgres    false    201   �s       F           0    0    atendimento_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.atendimento_id_seq', 16, true);
          public          postgres    false    209            G           0    0    comentario_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.comentario_id_seq', 7, true);
          public          postgres    false    211            H           0    0    feria_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.feria_id_seq', 5, true);
          public          postgres    false    205            I           0    0    fornecedor_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.fornecedor_id_seq', 5, true);
          public          postgres    false    216            J           0    0    produto_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.produto_id_seq', 6, true);
          public          postgres    false    213            K           0    0    servico_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.servico_id_seq', 5, true);
          public          postgres    false    207            L           0    0    usuario_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.usuario_id_seq', 13, true);
          public          postgres    false    200            �           2606    50344    atendimento atendimento_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.atendimento
    ADD CONSTRAINT atendimento_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.atendimento DROP CONSTRAINT atendimento_pkey;
       public            postgres    false    210            �           2606    50294    cabeleireiro cabeleireiro_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.cabeleireiro
    ADD CONSTRAINT cabeleireiro_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.cabeleireiro DROP CONSTRAINT cabeleireiro_pkey;
       public            postgres    false    204            �           2606    50281    cliente cliente_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    203            �           2606    50371    comentario comentario_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT comentario_pkey PRIMARY KEY (id, id_cliente);
 D   ALTER TABLE ONLY public.comentario DROP CONSTRAINT comentario_pkey;
       public            postgres    false    212    212            �           2606    50312    feria feria_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.feria
    ADD CONSTRAINT feria_pkey PRIMARY KEY (id, id_usuario);
 :   ALTER TABLE ONLY public.feria DROP CONSTRAINT feria_pkey;
       public            postgres    false    206    206            �           2606    50421 (   fornecedor fornecedor_email_cnpj_cpf_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_cnpj_cpf_key UNIQUE (email, cnpj, cpf);
 R   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_cnpj_cpf_key;
       public            postgres    false    217    217    217            �           2606    50419    fornecedor fornecedor_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_pkey;
       public            postgres    false    217            �           2606    50393    produto produto_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_pkey;
       public            postgres    false    214            �           2606    50398 $   produto_servico produto_servico_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.produto_servico
    ADD CONSTRAINT produto_servico_pkey PRIMARY KEY (id_produto, id_servico);
 N   ALTER TABLE ONLY public.produto_servico DROP CONSTRAINT produto_servico_pkey;
       public            postgres    false    215    215            �           2606    50329    servico servico_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.servico
    ADD CONSTRAINT servico_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.servico DROP CONSTRAINT servico_pkey;
       public            postgres    false    208            �           2606    50266    telefone telefone_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_pkey PRIMARY KEY (id_usuario, telefone);
 @   ALTER TABLE ONLY public.telefone DROP CONSTRAINT telefone_pkey;
       public            postgres    false    202    202            |           2606    50258    usuario usuario_email_cpf_key 
   CONSTRAINT     ^   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_cpf_key UNIQUE (email, cpf);
 G   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_email_cpf_key;
       public            postgres    false    201    201            ~           2606    50256    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    201            �           2620    50428     atendimento atendimento_invalido    TRIGGER     �   CREATE TRIGGER atendimento_invalido BEFORE INSERT OR UPDATE ON public.atendimento FOR EACH ROW EXECUTE FUNCTION public.verifica_atendimento();
 9   DROP TRIGGER atendimento_invalido ON public.atendimento;
       public          postgres    false    220    210            �           2606    50355 ,   atendimento atendimento_id_cabeleireiro_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.atendimento
    ADD CONSTRAINT atendimento_id_cabeleireiro_fkey FOREIGN KEY (id_cabeleireiro) REFERENCES public.cabeleireiro(id);
 V   ALTER TABLE ONLY public.atendimento DROP CONSTRAINT atendimento_id_cabeleireiro_fkey;
       public          postgres    false    204    210    2948            �           2606    50350 '   atendimento atendimento_id_cliente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.atendimento
    ADD CONSTRAINT atendimento_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id);
 Q   ALTER TABLE ONLY public.atendimento DROP CONSTRAINT atendimento_id_cliente_fkey;
       public          postgres    false    203    210    2946            �           2606    50345 '   atendimento atendimento_id_servico_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.atendimento
    ADD CONSTRAINT atendimento_id_servico_fkey FOREIGN KEY (id_servico) REFERENCES public.servico(id);
 Q   ALTER TABLE ONLY public.atendimento DROP CONSTRAINT atendimento_id_servico_fkey;
       public          postgres    false    210    2952    208            �           2606    50295 !   cabeleireiro cabeleireiro_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.cabeleireiro
    ADD CONSTRAINT cabeleireiro_id_fkey FOREIGN KEY (id) REFERENCES public.usuario(id);
 K   ALTER TABLE ONLY public.cabeleireiro DROP CONSTRAINT cabeleireiro_id_fkey;
       public          postgres    false    201    2942    204            �           2606    50282    cliente cliente_id_fkey    FK CONSTRAINT     s   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_id_fkey FOREIGN KEY (id) REFERENCES public.usuario(id);
 A   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_id_fkey;
       public          postgres    false    201    2942    203            �           2606    50377 %   comentario comentario_id_cliente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT comentario_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.comentario DROP CONSTRAINT comentario_id_cliente_fkey;
       public          postgres    false    203    2946    212            �           2606    50372 %   comentario comentario_id_servico_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT comentario_id_servico_fkey FOREIGN KEY (id_servico) REFERENCES public.servico(id);
 O   ALTER TABLE ONLY public.comentario DROP CONSTRAINT comentario_id_servico_fkey;
       public          postgres    false    208    2952    212            �           2606    50313    feria feria_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feria
    ADD CONSTRAINT feria_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.cabeleireiro(id) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.feria DROP CONSTRAINT feria_id_usuario_fkey;
       public          postgres    false    206    204    2948            �           2606    50422 %   fornecedor fornecedor_id_produto_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_id_produto_fkey FOREIGN KEY (id_produto) REFERENCES public.produto(id);
 O   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_id_produto_fkey;
       public          postgres    false    217    214    2958            �           2606    50399 /   produto_servico produto_servico_id_produto_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.produto_servico
    ADD CONSTRAINT produto_servico_id_produto_fkey FOREIGN KEY (id_produto) REFERENCES public.produto(id);
 Y   ALTER TABLE ONLY public.produto_servico DROP CONSTRAINT produto_servico_id_produto_fkey;
       public          postgres    false    2958    215    214            �           2606    50404 /   produto_servico produto_servico_id_servico_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.produto_servico
    ADD CONSTRAINT produto_servico_id_servico_fkey FOREIGN KEY (id_servico) REFERENCES public.servico(id);
 Y   ALTER TABLE ONLY public.produto_servico DROP CONSTRAINT produto_servico_id_servico_fkey;
       public          postgres    false    215    208    2952            �           2606    50267 !   telefone telefone_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);
 K   ALTER TABLE ONLY public.telefone DROP CONSTRAINT telefone_id_usuario_fkey;
       public          postgres    false    2942    201    202            8           0    50435    produtos    MATERIALIZED VIEW DATA     +   REFRESH MATERIALIZED VIEW public.produtos;
          public          postgres    false    219    3130            0   �   x�m�1!���_,I�So�ܥs��P8Z��_���r�s����L!!�dI��4׵l�O���N��$C5��^�q����pH�f<x��#k�	����S��\�˺U��b����Ui4\kW�k�HMV҈������C�p�t�B�I��d����S�      *   �   x�=�A
�0�ur�9��V�]�`!4�����"�f$m6�F\� ��i���?_�!!h��"��N~"gqJ��4s��E6��N�RJt'KлPJE��y�\T#L�0�8E
y�[��z\�{mu��E�?�1yF�cU�	���"tFry-��;#=)X�->vR�/�(A�      )   [   x�U�1� Dњ��fT�x
[
���3�L~���-��Nj(��U[m�d*(���
J��SA�jJ��h`#�E8����K����1��dI-N      2   z  x�m��N�0���S\GPS%)m)����Y�ɵ�O��}��������)���w���,�n<�<!adC���=&��<>'Ƶ��"����x$�j�ʻF�Dht�#(�2��P䪄E �D�w�p��n�G�q�������F�ڎk#y5���Y���j�\yˮ���8�Xc�vCQk�w��3Y�Gբ����@�#4��#m�{$�����"�ZlEL�H 9��TQ�K(���^i(IA���:Է5ˊ1�0S��]o������︕_LV�FGi�/��5WZ���n$�4<��Ϗ��F'p�jzސ�'p�����p��,���S5���;ibuxs�u'H�!jW����M/QH���T#�����]      ,   N   x�E���0�7�
;�ݠ#����H(�NB�`�]d�*OF�,)��~~��GrF�}@�I��U=��wY����n���      7   �   x�]�1r� Ekq
_`	�MG�4)2��v�pfmco���)�b���@�S��%����a��y��-|4�:�	�Jk�B����p�)"R!�IJP�e�p7�e���`�dT+����ž{b��l#�I�/���>���`�dT����!�Z�#�ȋ"��^}����O�B&���t-�N�`z7�	���y�s��[����G�{'��ࣩ��s*�LY9�b��)�tr���_̈́}�      4   �   x�E�1n�0Eg���J6kxv��Y��6��%�Ms�!�Ԥ	����x�ã|-�lG����-�I�'GCh|�"M����5g;F���$���Ww[���ia/�?e���Y�i�9o\lW�o<6HТ�*ǔc����Z�?��ƙap�pBj�C��`�i�Is��ڎ��^�ĉ��&������3�u*=x�X��[D�w�K�wg��W�O�      5      x�3�4�2�4�2bCNc m����� (0      .   `  x�M��J�@�ϛ�磻��R#JQ�G/�d�LIv��$J�F�	>E^��Ђ�]v��}��̼R�%5fO��ZANp��s�����@��rå>2i�S��������"^�q47��ʧIF�g�+q�r��@�y��d�~3�	4���m.�5�Ur�H�-Y/`�o�������Ya�la����H{S���V�����,:UEx�d�@��Q�� P���Pp��¥�?��PQ��4O؏ڍ����V���K;GpT���@��U8�I=lm� D �������L&1i���6�U��B
=��pt����I[���_9����jƖ����^��Gy3���4��?r­]      (   g   x�M��	C1D�u����W����_G���@�� �o�g���X�����+b��! gj6$̜ZV,�۷�aCY��R�bCpgN]a���	�?\�#��)�      '   N  x�}RAN�0<�_�DMҦ��H$D/�,�I����������N|�w3���͡C��Bkv�;p�1/J��<�}��U�X�=ӟ��028�O�ʩah�R�S3���� [�ʽW�0X����{����(��RLB����_��Ɯz�$���S� ��$*�ER�L��@a4�EqE	�5��,��l����&���8wM+?�w��H�kZ| �}�d�\�BĚP/ N�����rft6�o�j�q���P������m3�묪�Y��������[OG#YoM��?�(.Gq��|n�#��Ҡj�p����9p��_2��0�2     