PGDMP  /    3        	    	    |        	   logistics #   16.4 (Ubuntu 16.4-0ubuntu0.24.04.2)    17.0 Q    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16388 	   logistics    DATABASE     u   CREATE DATABASE logistics WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE logistics;
                     postgres    false            �            1259    16393    customer    TABLE     �   CREATE TABLE public.customer (
    street character varying NOT NULL,
    nr integer NOT NULL,
    city character varying NOT NULL,
    postcode character varying NOT NULL,
    name character varying NOT NULL,
    id integer NOT NULL
);
    DROP TABLE public.customer;
       public         heap r       postgres    false            �            1259    16520    customer_id_seq    SEQUENCE     x   CREATE SEQUENCE public.customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.customer_id_seq;
       public               admin    false            �            1259    16534    customer_id_seq1    SEQUENCE     �   CREATE SEQUENCE public.customer_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.customer_id_seq1;
       public               postgres    false    215            �           0    0    customer_id_seq1    SEQUENCE OWNED BY     D   ALTER SEQUENCE public.customer_id_seq1 OWNED BY public.customer.id;
          public               postgres    false    226            �            1259    16419    goods    TABLE     \   CREATE TABLE public.goods (
    name character varying NOT NULL,
    id integer NOT NULL
);
    DROP TABLE public.goods;
       public         heap r       postgres    false            �            1259    16523    goods_id_seq    SEQUENCE     u   CREATE SEQUENCE public.goods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.goods_id_seq;
       public               admin    false            �            1259    16544    goods_id_seq1    SEQUENCE     �   CREATE SEQUENCE public.goods_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.goods_id_seq1;
       public               postgres    false    218            �           0    0    goods_id_seq1    SEQUENCE OWNED BY     >   ALTER SEQUENCE public.goods_id_seq1 OWNED BY public.goods.id;
          public               postgres    false    227            �            1259    16595    order_nr_seq    SEQUENCE     u   CREATE SEQUENCE public.order_nr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.order_nr_seq;
       public               admin    false            �            1259    16426    order    TABLE     �  CREATE TABLE public."order" (
    customer character varying NOT NULL,
    weight integer NOT NULL,
    sender character varying NOT NULL,
    receiver character varying NOT NULL,
    goods character varying NOT NULL,
    order_nr character varying DEFAULT ('ORD'::text || lpad((nextval('public.order_nr_seq'::regclass))::text, 4, '0'::text)) NOT NULL,
    date date DEFAULT CURRENT_DATE NOT NULL,
    id integer NOT NULL,
    archive boolean
);
    DROP TABLE public."order";
       public         heap r       postgres    false    232            �            1259    16518    order_id_seq    SEQUENCE     u   CREATE SEQUENCE public.order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.order_id_seq;
       public               admin    false            �            1259    16555    order_id_seq1    SEQUENCE     �   CREATE SEQUENCE public.order_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.order_id_seq1;
       public               postgres    false    219            �           0    0    order_id_seq1    SEQUENCE OWNED BY     @   ALTER SEQUENCE public.order_id_seq1 OWNED BY public."order".id;
          public               postgres    false    228            �            1259    16405    send_rec    TABLE       CREATE TABLE public.send_rec (
    street character varying NOT NULL,
    nr integer NOT NULL,
    city character varying,
    postcode character varying,
    name character varying NOT NULL,
    sender boolean NOT NULL,
    receiver boolean NOT NULL,
    id integer NOT NULL
);
    DROP TABLE public.send_rec;
       public         heap r       admin    false            �            1259    16669 	   receivers    VIEW     �   CREATE VIEW public.receivers AS
 SELECT id,
    name,
    street,
    nr,
    city,
    postcode
   FROM public.send_rec
  WHERE (receiver = true);
    DROP VIEW public.receivers;
       public       v       admin    false    216    216    216    216    216    216    216            �            1259    16565    send_rec_id_seq    SEQUENCE     �   CREATE SEQUENCE public.send_rec_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.send_rec_id_seq;
       public               admin    false    216            �           0    0    send_rec_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.send_rec_id_seq OWNED BY public.send_rec.id;
          public               admin    false    229            �            1259    16673    senders    VIEW     �   CREATE VIEW public.senders AS
 SELECT id,
    name,
    street,
    nr,
    city,
    postcode
   FROM public.send_rec
  WHERE (sender = true);
    DROP VIEW public.senders;
       public       v       admin    false    216    216    216    216    216    216    216            �            1259    16598    tour_nr_seq    SEQUENCE     t   CREATE SEQUENCE public.tour_nr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.tour_nr_seq;
       public               admin    false            �            1259    16458    tour    TABLE     l  CREATE TABLE public.tour (
    truck character varying NOT NULL,
    order_1 character varying NOT NULL,
    archive boolean,
    tour_nr character varying DEFAULT ('TOUR'::text || lpad((nextval('public.tour_nr_seq'::regclass))::text, 4, '0'::text)) NOT NULL,
    id integer NOT NULL,
    order_2 character varying,
    order_3 character varying,
    date date
);
    DROP TABLE public.tour;
       public         heap r       admin    false    233            �            1259    16681    tour_active    VIEW     �   CREATE VIEW public.tour_active AS
 SELECT id,
    tour_nr,
    truck,
    order_1,
    order_2,
    order_3
   FROM public.tour
  WHERE (archive = false);
    DROP VIEW public.tour_active;
       public       v       admin    false    220    220    220    220    220    220    220            �            1259    16677    tour_archive    VIEW     �   CREATE VIEW public.tour_archive AS
 SELECT tour_nr,
    truck,
    order_1,
    order_2,
    order_3
   FROM public.tour
  WHERE (archive = true);
    DROP VIEW public.tour_archive;
       public       v       admin    false    220    220    220    220    220    220            �            1259    16575    tour_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tour_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.tour_id_seq;
       public               admin    false    220            �           0    0    tour_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.tour_id_seq OWNED BY public.tour.id;
          public               admin    false    230            �            1259    16412    trucks    TABLE     �   CREATE TABLE public.trucks (
    capacity integer NOT NULL,
    lic_plate character varying NOT NULL,
    id integer NOT NULL
);
    DROP TABLE public.trucks;
       public         heap r       postgres    false            �            1259    16585    trucks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.trucks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.trucks_id_seq;
       public               postgres    false    217            �           0    0    trucks_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.trucks_id_seq OWNED BY public.trucks.id;
          public               postgres    false    231            �            1259    16496    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL
);
    DROP TABLE public.users;
       public         heap r       admin    false            �            1259    16495    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public               admin    false    222            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public               admin    false    221            	           2604    16535    customer id    DEFAULT     k   ALTER TABLE ONLY public.customer ALTER COLUMN id SET DEFAULT nextval('public.customer_id_seq1'::regclass);
 :   ALTER TABLE public.customer ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    215                       2604    16545    goods id    DEFAULT     e   ALTER TABLE ONLY public.goods ALTER COLUMN id SET DEFAULT nextval('public.goods_id_seq1'::regclass);
 7   ALTER TABLE public.goods ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    227    218                       2604    16556    order id    DEFAULT     g   ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq1'::regclass);
 9   ALTER TABLE public."order" ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    228    219            
           2604    16566    send_rec id    DEFAULT     j   ALTER TABLE ONLY public.send_rec ALTER COLUMN id SET DEFAULT nextval('public.send_rec_id_seq'::regclass);
 :   ALTER TABLE public.send_rec ALTER COLUMN id DROP DEFAULT;
       public               admin    false    229    216                       2604    16576    tour id    DEFAULT     b   ALTER TABLE ONLY public.tour ALTER COLUMN id SET DEFAULT nextval('public.tour_id_seq'::regclass);
 6   ALTER TABLE public.tour ALTER COLUMN id DROP DEFAULT;
       public               admin    false    230    220                       2604    16586 	   trucks id    DEFAULT     f   ALTER TABLE ONLY public.trucks ALTER COLUMN id SET DEFAULT nextval('public.trucks_id_seq'::regclass);
 8   ALTER TABLE public.trucks ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    231    217                       2604    16499    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public               admin    false    222    221    222            �          0    16393    customer 
   TABLE DATA           H   COPY public.customer (street, nr, city, postcode, name, id) FROM stdin;
    public               postgres    false    215   [       �          0    16419    goods 
   TABLE DATA           )   COPY public.goods (name, id) FROM stdin;
    public               postgres    false    218   _\       �          0    16426    order 
   TABLE DATA           i   COPY public."order" (customer, weight, sender, receiver, goods, order_nr, date, id, archive) FROM stdin;
    public               postgres    false    219   �\       �          0    16405    send_rec 
   TABLE DATA           Z   COPY public.send_rec (street, nr, city, postcode, name, sender, receiver, id) FROM stdin;
    public               admin    false    216   �^       �          0    16458    tour 
   TABLE DATA           \   COPY public.tour (truck, order_1, archive, tour_nr, id, order_2, order_3, date) FROM stdin;
    public               admin    false    220   `       �          0    16412    trucks 
   TABLE DATA           9   COPY public.trucks (capacity, lic_plate, id) FROM stdin;
    public               postgres    false    217   �`       �          0    16496    users 
   TABLE DATA           7   COPY public.users (id, username, password) FROM stdin;
    public               admin    false    222   a       �           0    0    customer_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.customer_id_seq', 1, false);
          public               admin    false    224            �           0    0    customer_id_seq1    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.customer_id_seq1', 12, true);
          public               postgres    false    226            �           0    0    goods_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.goods_id_seq', 8, true);
          public               admin    false    225            �           0    0    goods_id_seq1    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.goods_id_seq1', 8, true);
          public               postgres    false    227            �           0    0    order_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.order_id_seq', 2, true);
          public               admin    false    223            �           0    0    order_id_seq1    SEQUENCE SET     <   SELECT pg_catalog.setval('public.order_id_seq1', 28, true);
          public               postgres    false    228            �           0    0    order_nr_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.order_nr_seq', 28, true);
          public               admin    false    232            �           0    0    send_rec_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.send_rec_id_seq', 10, true);
          public               admin    false    229            �           0    0    tour_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.tour_id_seq', 7, true);
          public               admin    false    230            �           0    0    tour_nr_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.tour_nr_seq', 7, true);
          public               admin    false    233            �           0    0    trucks_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.trucks_id_seq', 5, true);
          public               postgres    false    231            �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 4, true);
          public               admin    false    221                       2606    16537    customer customer_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_pkey;
       public                 postgres    false    215                       2606    16613    customer customer_unique 
   CONSTRAINT     S   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_unique UNIQUE (name);
 B   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_unique;
       public                 postgres    false    215                        2606    16547    goods goods_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.goods
    ADD CONSTRAINT goods_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.goods DROP CONSTRAINT goods_pkey;
       public                 postgres    false    218            "           2606    16628    goods goods_unique 
   CONSTRAINT     M   ALTER TABLE ONLY public.goods
    ADD CONSTRAINT goods_unique UNIQUE (name);
 <   ALTER TABLE ONLY public.goods DROP CONSTRAINT goods_unique;
       public                 postgres    false    218            $           2606    16558    order order_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_pkey;
       public                 postgres    false    219            &           2606    16646    order order_unique 
   CONSTRAINT     S   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_unique UNIQUE (order_nr);
 >   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_unique;
       public                 postgres    false    219                       2606    16568    send_rec send_rec_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.send_rec
    ADD CONSTRAINT send_rec_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.send_rec DROP CONSTRAINT send_rec_pkey;
       public                 admin    false    216                       2606    16621    send_rec send_rec_unique 
   CONSTRAINT     S   ALTER TABLE ONLY public.send_rec
    ADD CONSTRAINT send_rec_unique UNIQUE (name);
 B   ALTER TABLE ONLY public.send_rec DROP CONSTRAINT send_rec_unique;
       public                 admin    false    216            (           2606    16578    tour tour_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.tour
    ADD CONSTRAINT tour_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.tour DROP CONSTRAINT tour_pkey;
       public                 admin    false    220                       2606    16588    trucks trucks_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.trucks
    ADD CONSTRAINT trucks_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.trucks DROP CONSTRAINT trucks_pkey;
       public                 postgres    false    217                       2606    16648    trucks trucks_unique 
   CONSTRAINT     T   ALTER TABLE ONLY public.trucks
    ADD CONSTRAINT trucks_unique UNIQUE (lic_plate);
 >   ALTER TABLE ONLY public.trucks DROP CONSTRAINT trucks_unique;
       public                 postgres    false    217            *           2606    16501    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 admin    false    222            ,           2606    16503    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public                 admin    false    222            1           2606    16649    tour order_1_fk    FK CONSTRAINT     v   ALTER TABLE ONLY public.tour
    ADD CONSTRAINT order_1_fk FOREIGN KEY (order_1) REFERENCES public."order"(order_nr);
 9   ALTER TABLE ONLY public.tour DROP CONSTRAINT order_1_fk;
       public               admin    false    3366    219    220            2           2606    16654    tour order_2_fk    FK CONSTRAINT     v   ALTER TABLE ONLY public.tour
    ADD CONSTRAINT order_2_fk FOREIGN KEY (order_2) REFERENCES public."order"(order_nr);
 9   ALTER TABLE ONLY public.tour DROP CONSTRAINT order_2_fk;
       public               admin    false    3366    219    220            3           2606    16659    tour order_3_fk    FK CONSTRAINT     v   ALTER TABLE ONLY public.tour
    ADD CONSTRAINT order_3_fk FOREIGN KEY (order_3) REFERENCES public."order"(order_nr);
 9   ALTER TABLE ONLY public.tour DROP CONSTRAINT order_3_fk;
       public               admin    false    3366    219    220            -           2606    16615    order order_customer_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_customer_fk FOREIGN KEY (customer) REFERENCES public.customer(name);
 C   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_customer_fk;
       public               postgres    false    3350    215    219            .           2606    16634    order order_goods_fk    FK CONSTRAINT     u   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_goods_fk FOREIGN KEY (goods) REFERENCES public.goods(name);
 @   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_goods_fk;
       public               postgres    false    3362    219    218            /           2606    16629    order order_rec_fk    FK CONSTRAINT     y   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_rec_fk FOREIGN KEY (receiver) REFERENCES public.send_rec(name);
 >   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_rec_fk;
       public               postgres    false    219    216    3354            0           2606    16622    order order_send_fk    FK CONSTRAINT     x   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_send_fk FOREIGN KEY (sender) REFERENCES public.send_rec(name);
 ?   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_send_fk;
       public               postgres    false    219    3354    216            4           2606    16664    tour tour_trucks_fk    FK CONSTRAINT     x   ALTER TABLE ONLY public.tour
    ADD CONSTRAINT tour_trucks_fk FOREIGN KEY (truck) REFERENCES public.trucks(lic_plate);
 =   ALTER TABLE ONLY public.tour DROP CONSTRAINT tour_trucks_fk;
       public               admin    false    3358    220    217            �   G  x�e��n�0����l����"���@b�rI��ő���o�Ɗ�^�IQ������{�6�AKX`e�C��+��6�
ϓM!&��#�aK�ʪ�ZB<ء-[����aS$I����c�ek�&�i%��w��>��\K	C�0��s��'�R����O+��3���jdH�&zǱ�g+L�mrb'�5,,����{f���Lُ�W��<��CNS�,�A6��`|ʏ�-.t��5�nJ��y�����G}���5Q��5x�{��|�%f�z,��h^�s��l��+���ɚ�*9.����$�C��d�����o+�ٛ`�}���j      �   8   x�;���$�Ӑ���*5/39�ӈ+��2;�Ә����N������*NS�=... �m      �     x��U�n�0<S_��@2��h�i}qOA.�M�US�T�������KE��2�8��k	3��������m8��p�X�$��LWZ�Tլ������k����R�N�$b4�9IH�N�+�������S�����kQn�y<�Ƀ�~���ۘ(�.�}���x����gu<H0����-���5"�6~��Z��O-6͈5��VE��#��n�rS.D�>��� �C��n��틖F_�3�'K9��2�YJ�xy}���[�Wf`�����;��!Y�����1� �gѴ���^7`����O�2��h�1d��{p���l3 ���'}�U��߮1pnY
�Q�O<�����?=��k��-٧�#����:��:G�����V'f�
���{�Y*���Գ��m2zNs[�L��`;�6;}G���9�T.7��3�UIlb`G>d��� B�gC��f�s�c�ݱ��җk.��oCJ�ě�I�x��T���7�ґh��8J}�N}����!p8
�`Oq�uז.      �   :  x�m�MN�0���S�����dYXtQ�T�b3m�*4�(
x�F��*�b�V�@�;ϼ7�{�Z=�=��`��u�#!a�kMi���S�7�	��'�k�$��8��L�@�f�6÷z�pJ{[��+C�W0wʺ㡇8%��yD�y�b1���9�>��ZC�1�#��Xk�zHX��}e�� �2�B�jx7��D��۟HYAC�u	ؙ��(HD��n�Z�1��rn���OM�jl���5���_��)����k�3�mdTA��
��+u������)�U���>!?�;�!/|%���I��C���V��      �   �   x�u��
�0@�ӯ�L����}�æCd����c�V��rH��X	1�P���+��}FDQ�J�y5��%v~�&x����e%#������2�.+���8�Q�����LH��o��V�u����t卼�,'c��DT      �   M   x�32200��R0426��4�2�+���[�pA�],}9���A
@�~�&P�P�� NS�=... ��N      �   7   x�3�,I-.��I,�7426�2��8�3���bF��)��y�Q���=... �p     