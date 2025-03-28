PGDMP     3    	                }            cl1    12.22    12.22 K    v           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            w           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            x           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            y           1262    25178    cl1    DATABASE     �   CREATE DATABASE cl1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_Indonesia.1252' LC_CTYPE = 'English_Indonesia.1252';
    DROP DATABASE cl1;
                postgres    false            �            1255    33416    set_default_role()    FUNCTION     �   CREATE FUNCTION public.set_default_role() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF NEW.id_role IS NULL THEN
			SELECT id_role INTO NEW.id_role FROM role WHERE default_role = TRUE LIMIT 1;
		END IF;
		RETURN NEW;
	END;
$$;
 )   DROP FUNCTION public.set_default_role();
       public          postgres    false            �            1255    41588    trigger_iden_insert()    FUNCTION       CREATE FUNCTION public.trigger_iden_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.resource_identifier IS NULL THEN
	SELECT identifier FROM resource_identifier INTO NEW.resource_identifier WHERE default_identifier = TRUE LIMIT 1;
	END IF;
	RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.trigger_iden_insert();
       public          postgres    false            �            1259    33406 
   migrations    TABLE     �   CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);
    DROP TABLE public.migrations;
       public         heap    postgres    false            �            1259    33404    migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public          postgres    false    214            z           0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public          postgres    false    213            �            1259    41575 
   permission    TABLE     �   CREATE TABLE public.permission (
    permission character varying(50) NOT NULL,
    resource_type character varying(50),
    resource_identifier character varying(50),
    permission_id integer NOT NULL
);
    DROP TABLE public.permission;
       public         heap    postgres    false            �            1259    41590    permission_permission_id_seq    SEQUENCE     �   CREATE SEQUENCE public.permission_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.permission_permission_id_seq;
       public          postgres    false    215            {           0    0    permission_permission_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.permission_permission_id_seq OWNED BY public.permission.permission_id;
          public          postgres    false    217            �            1259    25202    profile    TABLE     �   CREATE TABLE public.profile (
    id_profile integer NOT NULL,
    id_user integer NOT NULL,
    fullname character varying(100) NOT NULL,
    alamat character varying(100) NOT NULL,
    notelp integer NOT NULL,
    foto_profil character varying(255)
);
    DROP TABLE public.profile;
       public         heap    postgres    false            �            1259    25200    profile_id_profile_seq    SEQUENCE     �   CREATE SEQUENCE public.profile_id_profile_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.profile_id_profile_seq;
       public          postgres    false    205            |           0    0    profile_id_profile_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.profile_id_profile_seq OWNED BY public.profile.id_profile;
          public          postgres    false    204            �            1259    41580    resource_identifier    TABLE     �   CREATE TABLE public.resource_identifier (
    identifier_id integer NOT NULL,
    identifier character varying(20) NOT NULL,
    default_identifier boolean DEFAULT false
);
 '   DROP TABLE public.resource_identifier;
       public         heap    postgres    false            �            1259    25234    role    TABLE     �   CREATE TABLE public.role (
    id_role integer NOT NULL,
    nama_role character varying(50) NOT NULL,
    default_role boolean DEFAULT false
);
    DROP TABLE public.role;
       public         heap    postgres    false            �            1259    25232    role_id_role_seq    SEQUENCE     �   CREATE SEQUENCE public.role_id_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.role_id_role_seq;
       public          postgres    false    209            }           0    0    role_id_role_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.role_id_role_seq OWNED BY public.role.id_role;
          public          postgres    false    208            �            1259    41599    role_permission    TABLE     j   CREATE TABLE public.role_permission (
    id_role integer NOT NULL,
    id_permission integer NOT NULL
);
 #   DROP TABLE public.role_permission;
       public         heap    postgres    false            �            1259    25222 	   user_role    TABLE     �   CREATE TABLE public.user_role (
    id_user_role integer NOT NULL,
    id_user integer NOT NULL,
    id_role integer NOT NULL
);
    DROP TABLE public.user_role;
       public         heap    postgres    false            �            1259    25193    users    TABLE     �  CREATE TABLE public.users (
    id_users integer NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(10) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    password_salt character varying(50),
    password_last_changed timestamp without time zone,
    password_expired boolean DEFAULT false,
    id_role integer
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    41614    user_effective_permission_view    VIEW     �  CREATE VIEW public.user_effective_permission_view AS
 SELECT u.id_users,
    u.username,
    r.id_role,
    r.nama_role,
    p.permission,
    p.resource_type,
    p.resource_identifier
   FROM ((((public.users u
     JOIN public.user_role ur ON ((u.id_users = ur.id_user)))
     JOIN public.role r ON ((ur.id_role = r.id_role)))
     JOIN public.role_permission rp ON ((r.id_role = rp.id_role)))
     JOIN public.permission p ON ((rp.id_permission = p.permission_id)));
 1   DROP VIEW public.user_effective_permission_view;
       public          postgres    false    218    215    215    215    203    203    207    207    209    209    215    218            �            1259    33384    user_login_log    TABLE     %  CREATE TABLE public.user_login_log (
    login_id integer NOT NULL,
    user_id integer NOT NULL,
    login_timestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ip_address character varying(50),
    login_success boolean DEFAULT false,
    device_info character varying(50)
);
 "   DROP TABLE public.user_login_log;
       public         heap    postgres    false            �            1259    25220    user_role_id_user_role_seq    SEQUENCE     �   CREATE SEQUENCE public.user_role_id_user_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.user_role_id_user_role_seq;
       public          postgres    false    207            ~           0    0    user_role_id_user_role_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.user_role_id_user_role_seq OWNED BY public.user_role.id_user_role;
          public          postgres    false    206            �            1259    25191    users_id_users_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_users_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.users_id_users_seq;
       public          postgres    false    203                       0    0    users_id_users_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.users_id_users_seq OWNED BY public.users.id_users;
          public          postgres    false    202            �            1259    25242    veryfication    TABLE     �   CREATE TABLE public.veryfication (
    id_verifikasi integer NOT NULL,
    id_user integer NOT NULL,
    kode_veryfikasi integer NOT NULL,
    status_veryfikasi character varying(50) NOT NULL,
    expired_at character varying(50)
);
     DROP TABLE public.veryfication;
       public         heap    postgres    false            �            1259    25240    veryfication_id_verifikasi_seq    SEQUENCE     �   CREATE SEQUENCE public.veryfication_id_verifikasi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.veryfication_id_verifikasi_seq;
       public          postgres    false    211            �           0    0    veryfication_id_verifikasi_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.veryfication_id_verifikasi_seq OWNED BY public.veryfication.id_verifikasi;
          public          postgres    false    210            �
           2604    33409    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    213    214            �
           2604    41592    permission permission_id    DEFAULT     �   ALTER TABLE ONLY public.permission ALTER COLUMN permission_id SET DEFAULT nextval('public.permission_permission_id_seq'::regclass);
 G   ALTER TABLE public.permission ALTER COLUMN permission_id DROP DEFAULT;
       public          postgres    false    217    215            �
           2604    25205    profile id_profile    DEFAULT     x   ALTER TABLE ONLY public.profile ALTER COLUMN id_profile SET DEFAULT nextval('public.profile_id_profile_seq'::regclass);
 A   ALTER TABLE public.profile ALTER COLUMN id_profile DROP DEFAULT;
       public          postgres    false    205    204    205            �
           2604    25237    role id_role    DEFAULT     l   ALTER TABLE ONLY public.role ALTER COLUMN id_role SET DEFAULT nextval('public.role_id_role_seq'::regclass);
 ;   ALTER TABLE public.role ALTER COLUMN id_role DROP DEFAULT;
       public          postgres    false    208    209    209            �
           2604    25225    user_role id_user_role    DEFAULT     �   ALTER TABLE ONLY public.user_role ALTER COLUMN id_user_role SET DEFAULT nextval('public.user_role_id_user_role_seq'::regclass);
 E   ALTER TABLE public.user_role ALTER COLUMN id_user_role DROP DEFAULT;
       public          postgres    false    206    207    207            �
           2604    25196    users id_users    DEFAULT     p   ALTER TABLE ONLY public.users ALTER COLUMN id_users SET DEFAULT nextval('public.users_id_users_seq'::regclass);
 =   ALTER TABLE public.users ALTER COLUMN id_users DROP DEFAULT;
       public          postgres    false    203    202    203            �
           2604    25245    veryfication id_verifikasi    DEFAULT     �   ALTER TABLE ONLY public.veryfication ALTER COLUMN id_verifikasi SET DEFAULT nextval('public.veryfication_id_verifikasi_seq'::regclass);
 I   ALTER TABLE public.veryfication ALTER COLUMN id_verifikasi DROP DEFAULT;
       public          postgres    false    211    210    211            o          0    33406 
   migrations 
   TABLE DATA           :   COPY public.migrations (id, migration, batch) FROM stdin;
    public          postgres    false    214   \       p          0    41575 
   permission 
   TABLE DATA           c   COPY public.permission (permission, resource_type, resource_identifier, permission_id) FROM stdin;
    public          postgres    false    215   -\       f          0    25202    profile 
   TABLE DATA           ]   COPY public.profile (id_profile, id_user, fullname, alamat, notelp, foto_profil) FROM stdin;
    public          postgres    false    205   X\       q          0    41580    resource_identifier 
   TABLE DATA           \   COPY public.resource_identifier (identifier_id, identifier, default_identifier) FROM stdin;
    public          postgres    false    216   �\       j          0    25234    role 
   TABLE DATA           @   COPY public.role (id_role, nama_role, default_role) FROM stdin;
    public          postgres    false    209   �\       s          0    41599    role_permission 
   TABLE DATA           A   COPY public.role_permission (id_role, id_permission) FROM stdin;
    public          postgres    false    218   �\       m          0    33384    user_login_log 
   TABLE DATA           t   COPY public.user_login_log (login_id, user_id, login_timestamp, ip_address, login_success, device_info) FROM stdin;
    public          postgres    false    212   ]       h          0    25222 	   user_role 
   TABLE DATA           C   COPY public.user_role (id_user_role, id_user, id_role) FROM stdin;
    public          postgres    false    207   ,]       d          0    25193    users 
   TABLE DATA           �   COPY public.users (id_users, username, email, password, created_at, password_salt, password_last_changed, password_expired, id_role) FROM stdin;
    public          postgres    false    203   O]       l          0    25242    veryfication 
   TABLE DATA           n   COPY public.veryfication (id_verifikasi, id_user, kode_veryfikasi, status_veryfikasi, expired_at) FROM stdin;
    public          postgres    false    211   ^       �           0    0    migrations_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.migrations_id_seq', 1, false);
          public          postgres    false    213            �           0    0    permission_permission_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.permission_permission_id_seq', 1, true);
          public          postgres    false    217            �           0    0    profile_id_profile_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.profile_id_profile_seq', 1, true);
          public          postgres    false    204            �           0    0    role_id_role_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.role_id_role_seq', 3, true);
          public          postgres    false    208            �           0    0    user_role_id_user_role_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.user_role_id_user_role_seq', 1, true);
          public          postgres    false    206            �           0    0    users_id_users_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_id_users_seq', 4, true);
          public          postgres    false    202            �           0    0    veryfication_id_verifikasi_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.veryfication_id_verifikasi_seq', 1, true);
          public          postgres    false    210            �
           2606    33411    migrations migrations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.migrations DROP CONSTRAINT migrations_pkey;
       public            postgres    false    214            �
           2606    41594    permission permission_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (permission_id);
 D   ALTER TABLE ONLY public.permission DROP CONSTRAINT permission_pkey;
       public            postgres    false    215            �
           2606    25209    profile profile_id_user_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_id_user_key UNIQUE (id_user);
 E   ALTER TABLE ONLY public.profile DROP CONSTRAINT profile_id_user_key;
       public            postgres    false    205            �
           2606    25207    profile profile_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (id_profile);
 >   ALTER TABLE ONLY public.profile DROP CONSTRAINT profile_pkey;
       public            postgres    false    205            �
           2606    41585 ,   resource_identifier resource_identifier_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.resource_identifier
    ADD CONSTRAINT resource_identifier_pkey PRIMARY KEY (identifier_id);
 V   ALTER TABLE ONLY public.resource_identifier DROP CONSTRAINT resource_identifier_pkey;
       public            postgres    false    216            �
           2606    41603 $   role_permission role_permission_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (id_role, id_permission);
 N   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT role_permission_pkey;
       public            postgres    false    218    218            �
           2606    25239    role role_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id_role);
 8   ALTER TABLE ONLY public.role DROP CONSTRAINT role_pkey;
       public            postgres    false    209            �
           2606    33390 "   user_login_log user_login_log_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.user_login_log
    ADD CONSTRAINT user_login_log_pkey PRIMARY KEY (login_id);
 L   ALTER TABLE ONLY public.user_login_log DROP CONSTRAINT user_login_log_pkey;
       public            postgres    false    212            �
           2606    25231    user_role user_role_id_role_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_id_role_key UNIQUE (id_role);
 I   ALTER TABLE ONLY public.user_role DROP CONSTRAINT user_role_id_role_key;
       public            postgres    false    207            �
           2606    25229    user_role user_role_id_user_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_id_user_key UNIQUE (id_user);
 I   ALTER TABLE ONLY public.user_role DROP CONSTRAINT user_role_id_user_key;
       public            postgres    false    207            �
           2606    25227    user_role user_role_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id_user_role);
 B   ALTER TABLE ONLY public.user_role DROP CONSTRAINT user_role_pkey;
       public            postgres    false    207            �
           2606    25199    users users_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_users);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    203            �
           2606    25249 %   veryfication veryfication_id_user_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.veryfication
    ADD CONSTRAINT veryfication_id_user_key UNIQUE (id_user);
 O   ALTER TABLE ONLY public.veryfication DROP CONSTRAINT veryfication_id_user_key;
       public            postgres    false    211            �
           2606    25247    veryfication veryfication_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.veryfication
    ADD CONSTRAINT veryfication_pkey PRIMARY KEY (id_verifikasi);
 H   ALTER TABLE ONLY public.veryfication DROP CONSTRAINT veryfication_pkey;
       public            postgres    false    211            �
           1259    33415    unique_default_role    INDEX     o   CREATE UNIQUE INDEX unique_default_role ON public.role USING btree (default_role) WHERE (default_role = true);
 '   DROP INDEX public.unique_default_role;
       public            postgres    false    209    209            �
           2620    41589    permission auto_insert_iden    TRIGGER        CREATE TRIGGER auto_insert_iden BEFORE INSERT ON public.permission FOR EACH ROW EXECUTE FUNCTION public.trigger_iden_insert();
 4   DROP TRIGGER auto_insert_iden ON public.permission;
       public          postgres    false    215    221            �
           2620    33417    users before_insert_user    TRIGGER     y   CREATE TRIGGER before_insert_user BEFORE INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.set_default_role();
 1   DROP TRIGGER before_insert_user ON public.users;
       public          postgres    false    220    203            �
           2606    33391    user_login_log fk_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_login_log
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id_users) ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.user_login_log DROP CONSTRAINT fk_user;
       public          postgres    false    203    2755    212            �
           2606    41609 2   role_permission role_permission_id_permission_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_id_permission_fkey FOREIGN KEY (id_permission) REFERENCES public.permission(permission_id);
 \   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT role_permission_id_permission_fkey;
       public          postgres    false    215    2778    218            �
           2606    41604 ,   role_permission role_permission_id_role_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.role(id_role);
 V   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT role_permission_id_role_fkey;
       public          postgres    false    218    2767    209            o      x������ � �      p      x�+�L-����M���4����� :�      f   3   x�3�4�����L�O,JI�K������+(J-�0�0�45������ ��      q      x�3���,����� 
j�      j       x�3�LL����L�2�,-N-�,����� Q��      s      x�3�4����� ]      m      x������ � �      h      x�3�4�4����� �X      d   �   x����
�@D�_��e�c��J��6M�5�DB��U�U�b���s�a�<���My��' `ˮ�R�V�&�$��mb���=�Ud�J"B����yɏ�v��3WL�Ir5���d&����(�s���q��~�D���tS"#��#�����D�      l   #   x�3�4�442662���K���K������� S      