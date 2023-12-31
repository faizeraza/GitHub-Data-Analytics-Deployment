PGDMP     &                    {            gdadatawarehouse    15.4    15.4 #    (           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            )           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            *           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            +           1262    33495    gdadatawarehouse    DATABASE     �   CREATE DATABASE gdadatawarehouse WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
     DROP DATABASE gdadatawarehouse;
                postgres    false            �            1255    33802    update_user_dimension()    FUNCTION     a  CREATE FUNCTION public.update_user_dimension() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if the user_name already exists in user_dimension
    IF EXISTS (SELECT 1 FROM user_dimension WHERE user_name = NEW.user_name) THEN
        -- Update the user's data
        UPDATE user_dimension
        SET
            followers = NEW.followers,
            user_location = NEW.user_location,
            total_repos = NEW.total_repos,
            total_gists = NEW.total_gists,
            email = NEW.email,
            join_date = NEW.join_date
        WHERE user_name = NEW.user_name;

        -- Return null to prevent the INSERT into user_dimension
        RETURN NULL;
    ELSE
        -- Perform the INSERT operation directly here
--         INSERT INTO user_dimension (user_name, followers, user_location, total_repos, total_gists, email, join_date)
--         VALUES (NEW.user_name, NEW.followers, NEW.user_location, NEW.total_repos, NEW.total_gists, NEW.email, NEW.join_date);

        -- Return null to prevent the INSERT into trending_repositories_fact
        RETURN NEW;
    END IF;
END;
$$;
 .   DROP FUNCTION public.update_user_dimension();
       public          postgres    false            �            1259    33788    rank_dimension_rank_id_seq    SEQUENCE     �   CREATE SEQUENCE public.rank_dimension_rank_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.rank_dimension_rank_id_seq;
       public          postgres    false            �            1259    33578    rank_dimension    TABLE     �   CREATE TABLE public.rank_dimension (
    rank_id integer DEFAULT nextval('public.rank_dimension_rank_id_seq'::regclass) NOT NULL,
    rank_category character varying(20),
    rank_value integer
);
 "   DROP TABLE public.rank_dimension;
       public         heap    postgres    false    219            �            1259    33789 &   repository_dimension_repository_id_seq    SEQUENCE     �   CREATE SEQUENCE public.repository_dimension_repository_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.repository_dimension_repository_id_seq;
       public          postgres    false            �            1259    33562    repository_dimension    TABLE       CREATE TABLE public.repository_dimension (
    repository_id integer DEFAULT nextval('public.repository_dimension_repository_id_seq'::regclass) NOT NULL,
    repo_name character varying(100) NOT NULL,
    repo_language character varying(50),
    topics text[],
    description text
);
 (   DROP TABLE public.repository_dimension;
       public         heap    postgres    false    220            �            1259    33790    time_dimension_time_id_seq    SEQUENCE     �   CREATE SEQUENCE public.time_dimension_time_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.time_dimension_time_id_seq;
       public          postgres    false            �            1259    33585    time_dimension    TABLE       CREATE TABLE public.time_dimension (
    time_id integer DEFAULT nextval('public.time_dimension_time_id_seq'::regclass) NOT NULL,
    time_stamp timestamp without time zone,
    day_of_week character varying,
    month character varying,
    year character varying
);
 "   DROP TABLE public.time_dimension;
       public         heap    postgres    false    221            �            1259    33791 &   trending_repositories_fact_fact_id_seq    SEQUENCE     �   CREATE SEQUENCE public.trending_repositories_fact_fact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.trending_repositories_fact_fact_id_seq;
       public          postgres    false            �            1259    33592    trending_repositories_fact    TABLE     7  CREATE TABLE public.trending_repositories_fact (
    fact_id integer DEFAULT nextval('public.trending_repositories_fact_fact_id_seq'::regclass) NOT NULL,
    repository_id integer,
    user_id integer,
    stars integer,
    forks integer,
    contributions integer,
    rank_id integer,
    time_id integer
);
 .   DROP TABLE public.trending_repositories_fact;
       public         heap    postgres    false    222            �            1259    33792    user_dimension_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_dimension_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.user_dimension_user_id_seq;
       public          postgres    false            �            1259    33571    user_dimension    TABLE     s  CREATE TABLE public.user_dimension (
    user_id integer DEFAULT nextval('public.user_dimension_user_id_seq'::regclass) NOT NULL,
    user_name character varying(100) NOT NULL,
    followers integer,
    user_location character varying(100),
    total_repos integer,
    total_gists integer,
    email character varying(100),
    join_date timestamp without time zone
);
 "   DROP TABLE public.user_dimension;
       public         heap    postgres    false    223                      0    33578    rank_dimension 
   TABLE DATA           L   COPY public.rank_dimension (rank_id, rank_category, rank_value) FROM stdin;
    public          postgres    false    216   3                 0    33562    repository_dimension 
   TABLE DATA           l   COPY public.repository_dimension (repository_id, repo_name, repo_language, topics, description) FROM stdin;
    public          postgres    false    214   �8                 0    33585    time_dimension 
   TABLE DATA           W   COPY public.time_dimension (time_id, time_stamp, day_of_week, month, year) FROM stdin;
    public          postgres    false    217   �l                  0    33592    trending_repositories_fact 
   TABLE DATA           �   COPY public.trending_repositories_fact (fact_id, repository_id, user_id, stars, forks, contributions, rank_id, time_id) FROM stdin;
    public          postgres    false    218   Fp                 0    33571    user_dimension 
   TABLE DATA           �   COPY public.user_dimension (user_id, user_name, followers, user_location, total_repos, total_gists, email, join_date) FROM stdin;
    public          postgres    false    215   �~       ,           0    0    rank_dimension_rank_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.rank_dimension_rank_id_seq', 298, true);
          public          postgres    false    219            -           0    0 &   repository_dimension_repository_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.repository_dimension_repository_id_seq', 298, true);
          public          postgres    false    220            .           0    0    time_dimension_time_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.time_dimension_time_id_seq', 298, true);
          public          postgres    false    221            /           0    0 &   trending_repositories_fact_fact_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.trending_repositories_fact_fact_id_seq', 298, true);
          public          postgres    false    222            0           0    0    user_dimension_user_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.user_dimension_user_id_seq', 298, true);
          public          postgres    false    223            �           2606    33583 "   rank_dimension rank_dimension_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.rank_dimension
    ADD CONSTRAINT rank_dimension_pkey PRIMARY KEY (rank_id);
 L   ALTER TABLE ONLY public.rank_dimension DROP CONSTRAINT rank_dimension_pkey;
       public            postgres    false    216            �           2606    33569 .   repository_dimension repository_dimension_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.repository_dimension
    ADD CONSTRAINT repository_dimension_pkey PRIMARY KEY (repository_id);
 X   ALTER TABLE ONLY public.repository_dimension DROP CONSTRAINT repository_dimension_pkey;
       public            postgres    false    214            �           2606    33590 "   time_dimension time_dimension_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.time_dimension
    ADD CONSTRAINT time_dimension_pkey PRIMARY KEY (time_id);
 L   ALTER TABLE ONLY public.time_dimension DROP CONSTRAINT time_dimension_pkey;
       public            postgres    false    217            �           2606    33597 :   trending_repositories_fact trending_repositories_fact_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.trending_repositories_fact
    ADD CONSTRAINT trending_repositories_fact_pkey PRIMARY KEY (fact_id);
 d   ALTER TABLE ONLY public.trending_repositories_fact DROP CONSTRAINT trending_repositories_fact_pkey;
       public            postgres    false    218            �           2606    33576 "   user_dimension user_dimension_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.user_dimension
    ADD CONSTRAINT user_dimension_pkey PRIMARY KEY (user_id);
 L   ALTER TABLE ONLY public.user_dimension DROP CONSTRAINT user_dimension_pkey;
       public            postgres    false    215            �           2620    33803 ,   user_dimension insert_user_dimension_trigger    TRIGGER     �   CREATE TRIGGER insert_user_dimension_trigger BEFORE INSERT ON public.user_dimension FOR EACH ROW EXECUTE FUNCTION public.update_user_dimension();
 E   DROP TRIGGER insert_user_dimension_trigger ON public.user_dimension;
       public          postgres    false    235    215            �           2606    33608 B   trending_repositories_fact trending_repositories_fact_rank_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trending_repositories_fact
    ADD CONSTRAINT trending_repositories_fact_rank_id_fkey FOREIGN KEY (rank_id) REFERENCES public.rank_dimension(rank_id);
 l   ALTER TABLE ONLY public.trending_repositories_fact DROP CONSTRAINT trending_repositories_fact_rank_id_fkey;
       public          postgres    false    216    3204    218            �           2606    33598 H   trending_repositories_fact trending_repositories_fact_repository_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trending_repositories_fact
    ADD CONSTRAINT trending_repositories_fact_repository_id_fkey FOREIGN KEY (repository_id) REFERENCES public.repository_dimension(repository_id);
 r   ALTER TABLE ONLY public.trending_repositories_fact DROP CONSTRAINT trending_repositories_fact_repository_id_fkey;
       public          postgres    false    218    3200    214            �           2606    33613 B   trending_repositories_fact trending_repositories_fact_time_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trending_repositories_fact
    ADD CONSTRAINT trending_repositories_fact_time_id_fkey FOREIGN KEY (time_id) REFERENCES public.time_dimension(time_id);
 l   ALTER TABLE ONLY public.trending_repositories_fact DROP CONSTRAINT trending_repositories_fact_time_id_fkey;
       public          postgres    false    217    3206    218            �           2606    33603 B   trending_repositories_fact trending_repositories_fact_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trending_repositories_fact
    ADD CONSTRAINT trending_repositories_fact_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_dimension(user_id);
 l   ALTER TABLE ONLY public.trending_repositories_fact DROP CONSTRAINT trending_repositories_fact_user_id_fkey;
       public          postgres    false    218    215    3202               �  x�UXK�,�\?�IQ��xc`���ƀ��;��T���T*Cd0H����/���~����-~~��m��^c������h���3ۺO�m�W��l�|��f��m+�ُ5�hv!�����ݣ7zo┋��\ ��.�v^0'O���s7�P���M�8��ޣ���օ2F�q��i�_��������d�uM;	s��皹r���~`�6��.sD�!;�f �i�z�=[W�z!X3GV��-Nub�!\�ȟ6
���2������ֆ���	[��6f=%݄l����ak�6��
f��|��n���t���"�i���|i��q�Kl��̞_̞/������7������������2;_f�/f�of������a���2���3#ۺX,g��u%l�_����ɱ�/�+l��w�mG���B���i�1���^��m_4���(jَ�4�fy��sь� �(���(��vę�H�s�	H�#���\4�ḣ@�C/���������!��Ɗke����~�r:�2���B��cg�ð���Q~D�vD��GK3� ݾkoH��	�:��f�9�PP����+�ՠ���]H�#�
)�
E���8cޟ�|�J�t[�����W��B�xF�I�2/���aA�u�+ث�|�%�Ig��[lֶ^�ɴ���$�#�Y����6��z�G�w��%�}�=jG��G�V����#����J�tR�~�!}�u��-�w~�t��ͣ�c|�R���%����U� ~���jJeq$ł?9s��'g��|��	_�3t`�'gH�\_9�D�����K97ʽ�B;'�8�I f�|�N&ь'g������Kf>@���v�������A���܅�\����q3#��$ڇ]W�9�@���OU91�K��$�UR��REI��*)����*Φ�TW�,�
K��+������-1��1^`���0�M"�� V�L�e��K~�H��'EN�^�P%��D�U�9��p�0 Q����*3�)��m�uoW��ƦW%otX�L6�%l��ܼ_D{C��N�u�O3�d���jOU���G�z6��)`:��5���	6�i�y��
G�&d5j�4̮Y��^Ӗ�К�Wk��k�#8\T���j(=�{���L�h=�/,܆'	�s���)Wm�#.(`B�@TAb(#�8��C���J9D�=m���<�á��0�8�iH=]�d�j��D���4A�|n(������a(��h*�T�{6Oc;�50�=��<�IK�"�k"@����5�A�{Vs7��rz]wj p��J<>Tڡ�pM@K\̥�	PN`J5���P�;_��iSc�[��X0� W5��	M >��C`_�:ER���r�p���|�vo�Y'Y$�� q�� ְ+�hI/���t<!�.��s��?t(7�X*�<\2�psJ�IՑ���O&�)��%�N�����D<&�T�����Ǳ��j��W�f�            x��}ysǕ��՟"�����*�@�`�nxCI���ى�PTWg7J��*UUly�AY�u��l�dZ�dk��({$�+b���h �K��{�eB�V<E�ETWef����;�U�j뮎��_я��N��]]�Gk֡����{�l7�-��-��^�z��:��]�W/�+~WjV������]k��.���A��G���(W5���@�q��U�WP�0VY���b��o��8��~w�2f���{����O����?vue�Z������{��$�~�tS��&ڦ�0�1ݴ�nG;M���0���� ��nP�t��IǍS��)MA�f��n_��MU��Uiݤ		��RZ�[��iQ>	L�kു]\zvď���C���B��c;��nƍ ����r�k��h�B^a͚QE�4��j�O���l�2��nڋ5V��T-��N*֓=wY�0���`Q;(M��t��|b�~�︁���ȜjŘ�Uz���LeC�Fn��m,@��)���D��Ȫ�1ӝ�H�N�vbc.R�����8ES�n�<^9�)ˎ�\=m��N��}��|��O����U{���Ӱ��NRLa���EU�u�x*�V�O����������a{N��ǎj����(�^��7?۱-�׬�RI�c��;혻�;I�6�X�Ju�:1����$uZ~W;i�vLic-.aC�:
ecE�
RUE��/�D��%�6�(�ת����{�嵐C�J��S �'(V�V���K��:	�?M˽�U�af��%v~gŧ�v�6Q����kֱ��(3�-M�9��a��W��[�B�V�7M��]7-���2t�'P�J�f�U?��b?�^�G dlh��{>���k��6QڎR;p�v���?:���������@�MmwC��f�ݶ��j�a��?S���^0��'�hhn�j�z�:f��:	���܆�<���Tw���ݵ R��.-�0m�A�v��F�-�S�cl����d�.��t�v����������	:�a����^Ս!��D˝�ؖޖ^R�y������6�X�7p��H��� h;�D�Z͛�,��mc]_��X�o����9^.*�$W��ּ�����?�u���r1�ފ��M�o��?+� ĩ��v;v��'}g�_�׬�zo��O7��t������]\����巷N?���������'o>?���_/�}�R�[��^��̲�:�l�:a�����vC���9z4I�i�*��@�ĺ�q��=�������0zш�����T'�à���5��)��D��u�xeM׬=���{�����_���&���6ο���o�r���s������+`|�k�7��z���6y�/����na�����a�0�]%T�@O�$�z]�Ju�Jzd;!
�w����o�Fc�[���M,�����^�����=/����K�6�K�kf�Oj!�r�^چ6&9
�~��𔶢��h����Ju�:����)x(8{oy�O���Vj��@�m��ŕ�F~�W�&H���`{@�G.;$�K�:(0Z>����sHLI���.��<�P�`�,�I �����0ޡ��7Xi�B�s��H�6j�$`�Axb��*f�S+�P�\ ����g�[D#��<�!���P	�TR�U���n�eX��@�(r4Lu�6(޸�^�V���&I�Am�Z``��:���$V��Y~�Q60�����AI���"��$�twŏ�.u�Yqcf.3�X���
�;��Oz11`"QG��n�D�vW�J�H �0�^j��E½X��x�πѦ,���܌*��L�@$���X�I7Tѱ=*�w=s-zq�$"x����|Đ�q��/Jc�b{���v������;M��ꑸv��{~NC���K�@�`�l�n��_\�qնS̍���Uۦ�;��v�pAH�*�0���Ö۽� ���{])r� S\�1�p�V�N.�0H��֏�C�p!��S-.��Dm?Y�r�m�ߍ�� �a��Ї�5��3wM��hTu�zY��(�.�.����[�̇��l�5�T��'k�����]R望R��Q`jF�Wf�JUG�2�U5�Oa2�0@-fR� P����Vq��H�CR)��]�@ʇf0i�t�&��!����x����y�S��0!�A�1��J^EOUj�����s
dFm3:����i���_/���3�V�ƪf�� �;Ƭ3��$[c����������j��-��&�	a�(��&-�)���
���o�z� �S�u�����
<ȼ"����'^R*�(��<k��]Ð��GW�&����4Н�h��9 ��>40-��
�d�!��S���@�Mӂ`��%HX	������?{qp��?��+��hHq�T��풠�B?�>*�5Z��^�f�"F	�R�K�O�l�n�g�W��NB���i��^�pZ��ņ�;ޏ=N�7�G*c�)��v��:�k8�����G��Q�y"Q�L��D�F�Yn�1V�jKS�5�a��=-�*���@7�pdfh��c$�*�/��^y�'$�I��p�fr�j�q$l9(�4�S�Ka���.� �|U"�d~w%4����X��Y�j���' �@�i!}j��̂I p뵗 ���6"̀
Y}OERC���*c5k��X'��ʦ�m�E�)O�ś���m�KU��*گ��Y�Bf�e�a����G�e�3���66�*���N���P����כ�U��?8���K�n��������n~|u��/���x���3O� ƞ�p-���[?u��5��x����� �c�nl�����!]��g�/�޺x7�.}t�7�l����ӿۺ�[�#�Wя�n���ϟ)o^tbp���/�_ye�ʙ��tQz���(�~����7Pn����=���_��j��?6^|mp�������#���7��9G�.������\ܼ�T����K���Qfv�|	�`~ �3M���TC��?����Y�8�|"�Y�b�(�'K������Ih����Y����$C�x�c6�f|��:�R�	l/�ɆD�#큚@^`;�q5�MCڳ���I�IN��	������֕J���b{��J�zF��0�c��{�`9_Ј54���Dw�\�PY�1V���������Y�+�ݼQ���w�C�]��UR�t�iD��= 6�\�C�o
w3�W���������*ac ޓ�5[XSlˌ�a����0~�4N|)���nLǲ�B��1�A�������C�8h���v�b3��P�rװ#�2�!�e���Р��XWeҧ,t�T/1�����/�Z3�����U7�0��	/Ib|3G��Bdȁ�Al� ���աB�	;�"6�^�������+c�Vˏc�6;�d�/k ��岅���v����i�q���&ÿ�Q�� ���t�L�d���U�L�"޿8Q�M�� !�3oMӯ�,�q���n}^"[�B�1JJ��Ū����&v��4��1EP��C�,h'�L�{�B �ǉ2o�qSw�0���C�S��@� NQ:C���F��a9iBF*�Uk�:��6�����
#",v��<0��q=OG<��6T�q[�6M4V $�̋�i)��52V0B`��%�O��:�U�`Ӆ9�6uD�X̠NF�8�?�H@����:A�����eD-�i��ٽ{�z5⇕�u�'ُ8�!��f�tc �|�!�3���q�G�
��[��t�vbiǾ���w@��rX�De-�Qc*�2�R��.��Ǭ��|� DR�2�C��v+���+6Ȗm�ٴ��%�,A�D�Cƈ�Q1��h<07-�;v� ���H�bÌ[^�9琤L��Rc�3�2	����Z.Kۊ�=ft�؅�u�yY� ��F��M׉`f[i�D�.�1+STL��[X�=Hh\Ո�[��5^���.p�T��0�Ă�����7�U�7p��4-�[24t��<�P�v���"Z;t[7�G��6��5BА\�� ;/�#�J������~RY���    �Ẅy��,���1f�vӜ�"P	��C.�eZ[a�hՂp��L%�� �0�ND`@����GB<����E��;`��Ď�.��2	�c�"���[Ңh^Ȼ����e� �U�	�H��?~y����~�֏qm�:i��f�.
0
�Yc��'iI����5s����R����VҰ��2?�7��,,��&{�<2���G 
YN�7m�;n�v ��y5f�l̒ŽET	�]���.k=�Q��#Ky"�.LEk�1�ሒ�	#Ŕ�t���:�l�io	aѮ���^-�DmMF��sdB�6df>/ޥ�e�f�h |tDUƧ,���p��a���Q�9ݜXȒ�K��r��9cu��qg��,������ @���={3��#@3 ���i�C�r�7zmq��`��~}�b��u��O�a�s;����e�e��� r���2��G������~� (j�+��^��*��-,���Ȓ�ׅ���ؒ{$����F�����%��=��~�L&� ��{0�d�.0�x`rL&n{���W�L|{&�h���]`2�0��=&�� �d�o0�|`�L&� ��&�r����[ ���I�M�'�D��P+��V$!�Д5+�c�y�e <P�{��3hb�,���34�ߊ������S����t�"*�:	�T�ӱ�5��=Z��G�b�%���6&�P�.{�R����?�j����+S��1@f�j-���4��zp��L��1�����$a��m���I)M��~��܄������R|����=�WN���	'���w{��ht���J��ܜ�=��=��{ĮJ;�0��T�j��n?U�0t�Z
1֦uz_ˇ:���f�����Keh1<�"_M�1��N�d��e�`�B斆����{��ġ��[,҂]��T^�3)L�A)�����N�-���d퇰�)�"!T���4Z
!���,:�˯dh�h�-0K�h#)�#��ڐ�:6O�?�a��B|�P|�WH0�t5gЪɐ�������jv�Hej�
N9�w��{������s~)�c���֬�˧�/����+�����Vr���럽�u�����V�&hҷ^����ev�i, �f�n�����6�����[�:�X��/����B��+��w�ب����U��u� �d�k����l��g� y]��IEFf�O��' ��G�%��Ė	�a�m����~�'�9n�\?'�W�
U��WɛƎ~��s���t�*̬�*�]I3YlOe�zk���5�x���u��F���6�퐕�NW:k��i�F���-$�Sv9���S�ΈrO�Pb�S�����.��?H�6��p�h�����:]���S:� �����\;�@���D^��p��'=��O�^F')�F�X׎Lwb�x�DU�~�Mv�$�"�(�8l
��=Sk�wN=���M�@�|�Z8~��̻fbmcIG)32��EW�b���Y����G�lu4�?�ZQs�<�=�����
��		�2��r(���7����+��ͨ?=i��q������UR����lo�lj����͐DБkmb���:���m� \�����W^��:� f ё�����x�7����c�{�i�/��
>�#���?N<J�!uI���������u��7�Xfp��c[C#H����]<%�>�%t�N�mL~�Y��`���OJ#�!�^@#��J�&�c�9�|~���'u�����������ss��`H�7n/�7ğR.g����4^r�w���]�x�N�+*����y(mm,�$}�[�W�c&��)�JAR��6W��R���5=�,[�E�]���O�وsb�MV	v���#�^�
�����%?�&j�pRԩ��<��c8����q����c���o7ԑ�f����_����r��h����nRc�]O�^�w� Jut�ND�WG'K��K�/A�#�sdy3Z�Z��X)/����'9?�`�LC�)����a��H֗��������t^���Ϯ��3�;�;�����%��b;��ż�w#�&y�v(��������fv��&~�n��m�θ�$�l%;q �y���˕�0C0H���(�)��a�0�t	�9Y�3#��HEsTI�sa���bK�̚�(ݐ|���>]�/�V�TD������lP'u�Y��,��a�P���䴔����J�� �Ё�D+$���f�#!B$V�P�x�PH�"�V;�ͽ�'��=I�_8�5K!	���Ab��p|�F�bK��r����=�,4g��ʆ��,sF@���-,�y���VuP�fCN��.k�G�}	���_/�~c�
rfb���Nvf�����$-�ч�h�8�R�x�މ�>��=$����}=`4���1k۩�!7c���}G��P
Ty�����ωT�u+֭@��X�
Xm;�����3�Xv1J�^r|�e>E��Y��X�Wi'�n�=�~ʏ��e���G}q��\��7��ӿB9��	�R�6���d�bC�p��6���˙7Lu�JM��a~�ܓ>đh��=�u���V-�kİ�����ڊ��a	�w�G����C+phfnf���Z��o�j�:mq�����\%y<�~�ۛ~�˯��L\;�:�Ȥ�2`o����BT��7�Ԛ���/qD�ڼ�����闿���ो��_���[P\��#���խw�l������8{i��k�<�~�����[�_.TҘlu� ��B```Q�7��w��~Ȗ6P*�8�O~[m~���G�)�W���GE�KGE�����e��"�l9�D��F��+k���t��k���Y]�t�d8���4b�I�zd�:(��[����v�/�JC�ؒ]�m^aHQDz|Rn�(����-��U��������nǩ�����dQE�i�ܻ�x��ԍg@5݁7
�>T ��V��[9�?�<0�������.H���6��u����	�c��\�y�t�\�P�u�|�����57�� jwqM���))(
�ç�x�]���Z��Cmm��~8$��(�oYF9����0.�x�T�3W�N���`U>��x ?�X1�������`�)�Z�����!��M?��)�06� ��-��Q�޺DՉ�;���վ�z�ccߖ&r��樎��s�ձ;c<�����T��dձ�ǁo�q����w+GIu�zoDyV�k�%��z�gɨ��߻9H��u�X��sR:��=
��X��~�]r���}��ݛ�%�a�8Cg�{���%��Qn*�s��,"MZʮ�2CQ�Sfj|��P���+!�'��h�[�t�/��-,��G�^a|����ҩ;[� ��#hf�J���H8>��S	w�r����E�s���_Fo(���0�!'8'F����S�*�%�d��Y�3�\��A4����A7�_�]��7�rV'��L)/`HY�xdAN�����
R��ʄ�L�������٩Z����ԫw�q�^{#s�cd�c�7F�>~�,��;�5�Z������O޹��ԃ��cd��bd�Ȕcd&F�;12��#3Q�vbd&��F��D���U�dwC����e!��z��ŪL<�L~�<����r��d�މU����*�c�8Ver�NĪLֿQڋ����{Q������ɩ;���:9}�g��N��#����}���:U��RT�ƾ;)�S�9%Eu�� '�m�|���-KJQ�"�rV����=���:5}k�RT�G���������O��	��N^�y��������t���NQ�����ST�'og~�驻:?��- ���;���F�_�)��}�5�6� 7�7�����[Н)�nv=D耑Ekl���z�*{�v1��c�ƺ�����d,�)	s����~�� � 	�����$�9M��H B�	�q��P$����� ���2K����&�8n?�lN4��\�*�z���+��Cz�P��~�N���O����+f�!QV5�0�:RĢe�Q�|ܽ�h�    F��O3��V�VI �IÝ�F��Zu�J}�U�Z�j�e������t��M����\������^.
L̼]�������XU�m����+a����8k8�����D#���zm�ނϱ� X-zxh��ö����s�bkVR=:CA�m��/��W����Z�_~%�W87.�;x�e�>������˧"W^���K�������Q��/oA��3�o�:nQ���b~A���B�8�����ܗ��&'�~v㵧o<��n�|ap����������Kg�T_^{�p�]v}>J���~��P�;T��/���.ԭd�^2���+x%u�c�(�� ��7v��-d1�Rɀ���57��у��-�~�:yˬq����2�Fa���>�C�#V�I�,a�C����K��;P�� /��`�CZ�c�d�oj	+*M�M' m�E֊�>B�>j>��_�R
�☔�˒��Z��J&[�U-��>Gb�;z3� \X_��HPSfr@4w2R �4"����}�#
��Y��%�
:�7�TAye�[�=ʮ�CN����eN���x/�Ƈ;��D��+�g�]!MH�؉e��(`����ie�a(`3)����f1��$���<��b>�e?��Z��ٌ�%�_&�sd����n9�	?��<xAL��q@�'9z�(<$�?EJF�n����ŋ�3�"��A2��C@_��ء�{��C:}؅L������2|&�*3|���v�}�g/m��}�uΔߵwa�a�7�<b�X���l ���I20��6/�1~�/j�j�5�$T���M����*��u�j�@��$z0�V:'C�O/1h��L��ěh9���/N�y_D��n��6-��0���Ȭ��J���Sw�%��3�E{Q���>�܉8@�ϔ�\�-�q��坙^��UJ�è,y� �d���W��=�>���f-�lKA:�SD~���$<�|�IҾ���3�5t�z)�c���ۤL��,��ڝ����}��41m-���N�$@j\*�W��=��~"�Cɍ��S��֚�����n����Lv�R+�c���mj�n�"^Y)O;�R�O��x湍�޿q��?��(<q��Ơ�Di�8ܖtb����Q��TQ�;a/�s�3K(IA(P���V_�1M�~�N�+?Ϳj3��V��}����A��^��8K��S�R�95$�9�Ă7��%�7�J�K}����������RKخ��sLw�P^a2D��?�*�J6uVKo�V]֝��/����D�[�jI��=�8�V���+��Q��ꡙ���g��]��ƦQ~l�����Q/0K���� �y�ڵ0{�������Z�Dn��՗�,��'�pڢ|AӜ�����vjV&b)�9��N#
�[c���9���oK�a�n/��_�jb��UL�����r�V��/��]t�w��?9�ٙ��'�%w{�Q������_\��k2���W[�8�������������E����ߧ�q9���\�����g�x����*�̴���mkL�h�m����
��R�ӷ	��)@֑��l-9�Y���U�w�:`�
�S�/��Ň�%&B�8�ƦJ����'��Doญ��	��n�!�� }���)�����6_�����μI_��ς��m�?;x���[�>u��'r��Ư�����BO̿c��K[�'���&�u�q*���K���PR;iNq���j�::G�WNBk��־��~�S�M�����F�l�y6���Ñ�Ց���0!I�1Ԙ���t�����\m6p/3��i8�$eL~v����6�J	a2>EqHPx��hXh�m����|U$�`(�|�	���M�6��g{��zl��F�ض�g��k�J$ и���c���$�ǧ%����-Cҥ�5"�)f�FHŚ�K����ܐ��uo���l/���Jܥ�lf��A��VFTvn��Ws�U2]٢�"�WrT���9;@��SR�<FqT�kϥ�������~�'�ߠč�K���JwT�C�Oh� 'P0Vt�|��f�0�b7\�{���Z���L����I")e؁�s��
=����V�i��"�R�l�afs��N���Qv�3ݥ�Qvx������N��lk�Y���_�/<:G�9�T��޹����K����s����O>ۼ����O���c։y�ʶ�] �A��z�퍗/l�{fp���c��EeB�3�&�%`�V�s�	��<�y���p�����89P���ŗW���V�����o���j/�>v(]�z�e"�4�hA�13�P������4F9[6cӑ�DTr���l;�,3\h$�o˶���6�H������j�&���ö	�s���F%���֏R )7��\�7�Bd������4��-0ަ���tB�/����\�r�dβ&E�P�����I0J�x�ȱ�󇌇'3�z���!Spң�t'����b����2ݘ1\�F?y?I����C�'���#��u_���Nć�����Y���~��ƙ�:7��ϛO�����z���ӝ_�bp����~v&�n�vv��y�C���g���1J�{_�s�F��f���Y@��mt~�Є��+�q(Ā��EP3���-����(�7^˪�����U�ꍗ޼q�c\@��g%�c��Ս�}X�M��0����?:�P`D�rf↟�s����R/�B!Z��}*
@2Xk���l�nrr�4M;	���,�I9���)	iSQ��Ԝ`�E�DXF�KT�W���p��D�ifV�r�$6 �W@q�#1���&�֓=,е�6Q�8F�<J�Y����s� �9���`��E�]���5�K$ұ㲿N�t,�5:����l2��Yl�L�$��&.�~�P6 >$���<X��Ef�h�9�.��Dq�4�'g{l�S��7E���>�M�X�|�t���L:�X�e��56^=���{�kol�������(N� �r�fk�wmQ{�`g�O�yWy�Y��I������8"sC4<a%���!)�+�~�JT�R�V�P�༶Ol:g��v�;�Av��I<Л���r�Ƽ��p С�z��vȔ��������Ɣ��Ns���Y'5��3;,ֽDDk� M�'��JqS2iI4��y4��Z�A��&ϥ�]v�5kp�Z��g�����w>�x�٭K޺����_^{`d��37~���+|y���o��ϭ?>���[̴'������B�4[�$�5�8M�N:P�zɒ3\�2���e�-a%��G-Wt<���6T2�)r������[R�L�i������cJ������	�H�r#���6}����b�_������<������"ݣ�7�~qϨ�v�ɒ�����n��&v���	��>\�H�y��9��6q��,F�~8!9�ؔn�:�k��>
�u��Q�q M.9��JI�Ό����*MZB������.;^�sL���$bf�_,�Sbxn��(h�*yq�%��v�~�׬}���:h�KB��R��s	]�f����>Y�������c��Eb�;�\e��d�گ��DO���9�A���հeQ��T��υ�ps@�d< 4M<�B�����7��oJ�us����e;��*��j��
��I3c��!�Ni�qh9������l����_�z<���X�?u'������[��Q���mס��%�e�c�`�K6pwچ�2 �<����9r:�e@��H\�q�ٜ�����T�ͺ ����0$�8�J�OyӁ��$��JI����3�1�$���Ș�m�}��/\�}��*�zۖ�7B�Ťc�H�![���;*��C:�_� �"�*��E��/�a�;ypM���+'�I�哭4�x6M{���u,h.�Bp����$'!A"���26O�y����f������M���XgZ�!���U�ꢩ�w�x35à�hi���*��g'#d�y�W�d�Ř�pU�;%��P �Y;���ك�vF?�7NޥV�)�D�&�d1��#}s`K�Yӡ��.>1:�� �  $Ւ���d�T�ًʧ�2u&�~�j��L��h��^²�-��K�����ř��/�Xr��F�b�I���������"�nrR�77�e��z��S�=U�Q"9�hm3�i<\�M�Za��^Ǎ��}���392�M]�l�RN"b<M�9���{rHfɧ46�)Ax�束d��?� ��6m�cK�� �J��v7�_/�}F�@-���d�2�}�[�ࡢ^AwyoT�ez**��>r���W�gӜ
��������&i` ���'��$n�j�����˔L�M���29>'c�9H-���b7�0�
�߄�'�>0�<��럮����E��s���lIR>�t���b1Zh��n;�^4��n�9Cʒ$y�R�Yu
;�K�bZh48�i�8)��엶\�k�x�v�2צǬCa�b��e!1�\G�@�<#����P 8a���W$�v�ي�f��"2&Sf�1TY��n��{ɘ�?ԟݢ�Ծ�fMWP)8�9j�%6=~M��E�-y�-��)�������3�_���N̓ a:���s|e�Ῥ_��k���Ѕ���aJsx���\z��g��������w6�|Nw~�����o|����/�DQ�/�a�7~����?<wv���/��u��-)u�k��>���7~}mp휭6>:7��ō_~e#}`��nל����"9Ϻ���g�)d'�$��kP��p11�/ۊ�~���J��nC�V��RZ�k���T2��r<�侒��A/jO�낒��2vx"�;�`���d��1V���J�(!�n::kdKH���8w7�>�KVغ>7��@�g$���6��a��,ؼ�����2�Z�;`=�$1��񊶘Pʑ���J�{��m`r6�m�,B�O��yW��*��}�pRqThl��{ܖ���&Onj������Y�S`���T��H�R����         `  x��ڱ��@��:y���!��xf�'�Pr�8����r2��W��S���,']�=-�I�"mk�����ߧ�����?�UU��U��@UGU�J�	������F �@�0e
��)(SP��LA��m-kV�YQgEa���0Ί�8+
�(���0Ί�8c
�)4�И�1c
��)S0�`L���1c
+SX�Bl��R��0Ί�8+
�(���0Ί�8+
�(3/
�)8Sp��L���3g
��)S�L!�B0�`
q�зշ�t/Y���,Q��	˔e�eƲ�eL�3��:SH��L!�B2�d
��)$SH��LA� ˭Cn��;�]���n���.`�a������z��!�C��@�=z(�P��C��B��Y�^d���x?=__]�]��8�v;�]���n��hУA�=z�0�a�à�A�=z�X��~?�AW<&]�t�c��IW<&]�t�c��IW<ƝC�=z8�p���á�C�=z���#�Gn��v�c��IW<&]�w�xL��1�Ǥ+��xL:�ѡG�zt��#�GB��	=z$�H������>��������N���a'�S�5��V�9�vv�C��@�=z��!�C��@�
=z(�8��x�ݱ������[a��u�%���a'�S�5�A�=�hУA�=z�0�a�à�A�=z�y�h��W���?��u����N`��k�3ح�s��:젇C�=z8�p���á�C�=z��q��\$޾N���/����V�9�vvɺ�>�	�vvУC�=:��УC��	=z$�H��#�GB�d�>�����eO�          *  x�m�k�ިD[��˼�\z�㸵Kp���J.����.O���}v��2�����*O�"��_/�wj�����Z��>��2���Z����7��;@̇��K�OO�U���9���V���e��.=�l�;&`|�ݯn<F����E�<����$���W�ܜ�(�9�������i-�����s��e��%��K�c���]kQ�*9f� ��@���=���A��z����S$�/�(ڭG-����E�h�G��<�-?	$�6�Qj��W[�Q|��^$���[�<|�h�Y?=��z;��X�����4��N$�D���U��z��j�!M:�i��g���OO{��oy/�Q�{1��ў1�7z
c>��.�������1��ܢ6ڷ�lk5����
�v�z��;k%�:���g���0"�@�����ݛ1ͪ�4�63�%e0��=�cD�������+K9gC�����5m4��z�؊��-x�Ї^��h����s�QS6��J�fD����Y�f�z������yF�ny��},��0
�/}c��B�d��G}_$�I2]r4'���!/4Cj�uZ�Cb`IH��iFF�p��;�a`F�X����H٢���Km�no��&�����f<t�Eg������bI=�O����ױd��]�j��c!u�`�Z��@Hs�ҭyx���K�0_;(�!���5u�k54�XH�5��>�����غ���DƄk�>W����S�G;�$^��ZStN�B���~��^҈�PȡuM�֊��]a{{�kC!�ȡ}��q��'w顷�&,�m�!����m����(�.�	�ܛF����*֪��8�n/�,��4�n�1^ӇR�DC��BA�g9�u-�]VL#!��}�T�E���B5G%J!_**���H���C;��R[:5C��3�ό��9���@ȟ������2�����!�'�	��89��9��2ʟ���-/0#���_���T������v���I<ف�b�h�c8���t
7;0�����������XL��=;�؊����d�fFCnc��Y��+;0z������С�?�C�P��|���p�߬�ԛy���|�ef���nv0nv`0p��M��ud��2i��:���hy�dh*ߜP���^���ah��At,��f���)����&I�l=���M'�m�ض�=2YH��ݺA�zPq�����r��F;���ɟ��7�~���pr��4gshD�e")/�Qҋ'�W<�$6/�K ��o.�	�N�A�>�����`��޳�c�w���<є���-��i�Hl~'UI	?Ij�^��4M9��뼡�@94	e�b����,õ�ri��R����Uj��m��ksOT\�F�ۜ�z��R_4_+���ģ�9Im}�L��-��5E;=����&�HL����Ka0?�N�+׫�r?�+VV/��������@0�S[�V��fJ�)/*�)�wS�pZ0�\%٢.�����_D9�I\�m!9oX{=�I�Tg���>�m!���(ڰ��c��p�L<�J���	_Ӌṿ'J��+s�J����I�i�̜_΄<�;wg�dg�_i���Z��Jz�R'�Tn��ܴ>�T��"uY�B@��-��\,!vR����������4ɑ'��Ѵ鄼3e?�V��N�Ȼ�������.��%Nl+s�A�q���Ǔ�5��
e9���aH�P�(����"��L1OϒD��d���;�d�����ɨ�f]NJ�J���z֦Ƞ�ed咋%U�<�$U��u|$���Q2�|8�V3�$Ct7����ˮ��	�K�@�eq�7KS�h���:�:M =�f����~&8K�I�lY$#����I��'S���w	K7��z`�S��������w9qct�N��2~�	5�n����D�Q2��b�@��N�CH��	$�E����'�X�#@œ�)L_�p6����}�+S�vIr4����L8�S|���JR*��W�Z3me�7���ƪ'��x�@�x �2����G����4���H(�����ͦ�}�K���̑��ǐ�1^&gdթӟ!Qr������M�����/��j�lC��}}r���w���[�y?��\��Iv���&}%:JZ�U�\�Q;����_�P�\XHm̎�+֛�ʫ$\|�1AT3Lt���BI���)\_�N��U:s�I*))_z��J��8�R&b.ǰ�|�F�É�9pf[k/e�BZ�&˚�����YEϐy_ֽD�M,O���p������R��ζ����xPS��z��QH�#ܿ;B���46l�.�r���%�/����40ެ	UeRt*jM>L��LB�؏3�� E��5� �M�T����k�	;�Zz��0*�+�h.��M�AU)#%�Oz�0���\Tѕ��OV��&��K��[�b�QL�|�-Nr�}Ѡ��cx�+څ���aQd��Xࡡ�X�[p������!O��]@L6��*��P��F�Rx��D��,z�S�����$	����Ԛ�F�lIXb�����ia5Tu��$��,M�����Z2.���7|HN\��N����	�tI�Q�Ý,M!��/ե�j���R�'i�h֮�Mu� ��P���ׅ�һ���ڤR���}8���֤$�M�r��F5�߇��T6�jY{�&Q44��GDv��9�؜�!�-g��bAax�fF�G/����fbR}*.I�i6#�Dћdф�p�����,jv{8�<`Tde�[ϰr�U�-�	!n��8.�k���zns3��t(Q�^ܣ�6=R��Aф�凘�/�������Ӌ?�$".�2$P�+.��\�As�Rw�{����j_j�CI��������%�o��v�zv�JIv���ߨlF5�ɷI��0�:�ƅ5��BI�����v8��>�\��ϒ�� .CͭG�S4����JqH���N��&cA�y�5���b�Kz����@8������H�Ĥ��TH��9Z���j���?;a%�����������I�-ߚ݁5��.��m0�~!���D-R�=���I�aSK ������uq��,�ts�lSB��_���s_����R'�!N_$��>��	�:��f�|k�҄�FTI�+�a^Hlڄ�V7k���T\t'i|�I�b�c$a���z������p>{1����mV���ϝ�nT�����y$C��'9��sE�êu�~�G����5E<�}�4� ����A&u�C��H$�	t_ܐR]X�QO"���r+����M<[D���;ɕ�~~� �����l ��K
��F����]4SV�Yɍ��b���R!����(�.ɍ�������(I�eK���慃xsIix�6�j�M��x�� =H �e���5�,�8`�-��(��Xρ�f��p�e�n8?���>h>3[��s�Y�Т��ѷ��O��o�$�_��D�Kc�yX	]K�|�!7|_W����I����'J�&� i�[��!
>����t+���K&iw>��n�����i�m���z6�K�E~��B�hp�?���"��/��/"��M��            x�}Z�r۸�}����'r7^�$��S��m�O��TMA$"�H���7���������6HJ����)UD �e��7�8{�M�a<T��Ŷ(I�#B�NC>� �fJτ�(Ŗ�}e�z�J̕�]7X�1��w�L�d6��y?�
㰒���T� �3%fa4Q���"�h�}��<s�����ƣ�q? ���fg\~�,w����P�3E����dB�}(�UY�
>���C,�L������*/sZD�TS��Q3Mt�ޘ�ܛ|[���G�4�gY��ѭ,�)Nfr�d�F64�j釆"�r��+ZOǓ8fng�����I�nͪr�`��#�2�܃)���������`v�R�X=/��ǲ��fQ3��υk�*��Nl���zg+���86�,�e3?�ֻSB�t4��$bn5�+�ͣ��a��t��T���x�7��,.Ņ�qә��D�]��y�,���hQ�͜�\-i�eb؆�	>�֩��ԟR��R�mHH�O�!�t����)7ˬ1��1�s���KO�O��7��3M�`o������=v����^wύ��Eo�S�<���_D�O���B�{�:q��л9��iM�皽��M�}c�:�t�o��Y�\1_�����/����	�2�1n[>��T::�R��\ш���3Ą3-�Sk��L��k���+v�*��\�0��BM�:�"��o߆)�VE���L�	�ʝ)�_<ڕ�nb3�r��9��PM�r���V�7,�n9��A�Ue���i�*�h�=��-O���<B=Sr&������-$x������7�(�n�|]>�[CN
�N$8����۲-��,�5���EV��=����>�*�ٛ�!\BN��$N�ǿ|�K)N�#�E��68E�D�I�2gv�k+�3ynhg�V�baVLr��WH(����d��Dhv��r�&�k��a8���(O	7ȭ@nh}0EYveK)���,Ӱ!�0�)$I<�l������	���`� �ƻ��գ54L&	���u�)+�d���R��W�)�3;5�Q�3#��%�����Ե��+9(�'��)�kvs7L0�3�@2��(n"RVا�uSr��./x��r]�{D�O��+�b�lQ����1��)c�h�7�Y"��$��<ں��im�uV�8��Q���UDq%CO��p�F����x}�/���b�[�Q���(\�%o�ٿT��u`�>5����<�g�@T$�(�1���0 G	�w�o��
o�Y��從���+�z/ ���aI�%C�`���Y韱�'�j�y7i��ĚB_�D�@�Me���.˩+*������P����"+���Dt�{E�]��}��]�'��P��Gx�+��h��p�f=c�7g
|��䡺lq�9��H ЮFt��QxH4���?5�=���{^��u2QA�%�~���q���K�����~����+ ��&b��~��t�aB8<9K>�Ô�%p�˱iW<�[$�cI(��$��~�,�p�y���r����*d���P� }���-��F@2�K����2W��,����o�mK:O\�3H;(L� <��S"�? ��'�z! i�"JB"����]C�N��re���sJ:󀈩[�g���*����M�W��+IA��K�ܢ,7�0I�@��{R�0~�`���l[��65��?�>�`g�~�d�#98�Oi������[�a�[�<,2�|��m�1��	�.	�c`�L���x���L_�&�M)���d L�����[�>�T�Q#�nm���'Sm��京
`F�ȋ%!��t���z��Ĭ�� �*����J�W�?�������>Ꮳ3ɩWV�]T��&���H�h�~pUӂ��W��Q.�=�Q`��B��K�nz�wB�t!�G�)R0�S��=EFri��$�@�8����-* (��r�2����Y�)2�(���$�6˒�D������[.	� ��<�H)s@��?�����-2}	�N�<�:"�A�U��u��,��=�t�u-%:vpo��"H��}�⋰H��&E�N��B��va��b)���H/VԞSP��Y�'nן�����	�T��!_@��P�u��?���kY�~;=F�'���HP^�!�4�n�}�ئd*V�%,�H�_��!IH�MC�j�_����i(�.�+�:#%�z�p;TX�adq|Gp9��(�;�M4J�5��<84��'m&�N��)Y��z�
{���>�	�jQ�r5��]U74�[��c-9Rj^2]:��d�$�jb!�ľ]�)�w��B�\y�Y��q���G4R��z @���_L�/��z�#%�>�:3�)�;�/�EΠ�s�[B��'ǔEeVMe`�� �Jkޚ�F%�ֶ5 ������֐��#ژ�H�s��xE�(d���A��	���k,�j؁��8{���S���joJ�`�"��v��
���wv�%�+@ϳMF�Gsа�=��_��= �vw>�/n=� �<w�D2�=��?��I<2�%�zX���8��h���6/��9*�ʝ�2S��]����P�9b�����?���/7�?���"|:�/��� ���j�j�%t��r�̫�u�oIl���qй۽C��@�� ���y>��L'~�I;q/#R"0�f�f���,�����vk���ա���
ȋ!R«���0�m���S_$ E,uK��~�bu�[�kpuW;iA�}~��g�5yB�"Bs��@��#(�;��w���%���bz<��5��QB±����|�?��1#����_?����PC�����ߝ�.�!�͉��t�)�u�P�Sq��_w�4�H�aQ�W�ݱX�#�J_�-��D�4��J07e��~~s˔=�}��s�ʷ��k|d�	�j=(:YBQ��Y$�f�������oQ�Pa��	$㧪�5�Hk+���٢�z�zѣB�&����2�[��R(qX'��ԏM<v�I�h߷$0�3<zFI��s������2]z� ��`���3[�����8"Ѳ�:�({��^���網�;�ۃ{��ϱ��EC�o���Ǜ�8
��пi�'$����L��B"sh� ߬����b?��|���0@���BjTI�~i+ꅃ��9Cos�I��zK@[]MY�^���{��x�p�=�*���i�OÙ�c��vSo���WpK�6Y��W���z�1��F�(���wO���oZ�X�D�8���a����z�*�\P���I3�Oԍհ�IC�t31g_&SgȂ�`�
3���H�L���ꆍ(���'3����2+cP��ڷ%C�����Q[;ԧ"��Q���I����  �t� �����x� !mU6�mX*�����n�e���AC�P�T	�(9�S�7����
��}�����,쒪�'"9 ��l5��弛s��}@!���4�,�,��91b7-Tm㊎@�H.<�)~|�C�.�Z}���ׯ��sV�C=._�rG�9E�6�����"�s��=�.��7޺�U���i�w�Ʒr(x����.Q��% �䰴fAks�X�{��Z��
V � >S~=p!1M;�}
���g2nt���9�����n{��Q��GB5Q*�,�-���jR�C�*�_�H@Z�HW��� X|j������M6�³���¹SЩ�8P#x�F4C�G&D�$�b߇�	�5D-��I��Ed���&xD
6�_�spԞ<Sߣ�L����M�k+2w,��(���"�?W��5��Ӹ�ҕ�}	����*|�X���<��{�75�H3t���.����ɭ�;��No�tI|�Br|5���nI��W�����i����[��G�ܕ��4�ZF]Ko�F��n�o, �@�p�|�c��ԏQC��R��,,�ѻ��[?I�|�U��Qp
��C�� �w��!Ƙ��e����!ӭ�P)�ئ�-*�[�z���|7��xJ�ޱf�\{h�p`��^��!5�w�X
B�X@�Bk�"��}�e���F��8f_�r��ZK�(��ʹY���C�k�7��� *  �Ԥ���MՑ`<�
�F�X�.B�0bCL~.[�nj���S�$�oLE]:!Y������J�8�i�|Hs9 uL= �X�}irr.uE�����ݭ��yn���T�g��u�6$R��{(�_Qo�l^v!�NR�{�t��U�����1��������j	[_���؈)	حl��/�?o+&KQ����y���`t�
��3�p���N� #�K/(Sy	y+�G#�R
�w~�����h��r9��%�����j� x�����^W���߳(���),�$�*�vG����^���g�?�t&*�����jv��AZCw����u�hȩ��oU��@�9�������)B�	ꯟ�����rq«�^0�t���weN=k}�c�����UE�ĥj��I�DH���:�@E��ȖTc��Y�X$Pp.;�H��V=���;�|ĪrQ�QX��Ov��HÌ��b��0�"��g���buͮ����6B
i0 I�l�/~U���p�w�	�F
0�Z@-������<#%O��j2���     