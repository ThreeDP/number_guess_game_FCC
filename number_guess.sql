--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: guess_games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.guess_games (
    guess_game_id integer NOT NULL,
    user_id integer NOT NULL,
    number_of_guesses integer,
    secret_number integer
);


ALTER TABLE public.guess_games OWNER TO freecodecamp;

--
-- Name: guess_games_guess_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.guess_games_guess_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guess_games_guess_game_id_seq OWNER TO freecodecamp;

--
-- Name: guess_games_guess_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.guess_games_guess_game_id_seq OWNED BY public.guess_games.guess_game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: guess_games guess_game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guess_games ALTER COLUMN guess_game_id SET DEFAULT nextval('public.guess_games_guess_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: guess_games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.guess_games VALUES (264, 132, 308, 307);
INSERT INTO public.guess_games VALUES (265, 132, 640, 639);
INSERT INTO public.guess_games VALUES (266, 133, 154, 153);
INSERT INTO public.guess_games VALUES (267, 133, 93, 92);
INSERT INTO public.guess_games VALUES (268, 132, 825, 822);
INSERT INTO public.guess_games VALUES (269, 132, 885, 884);
INSERT INTO public.guess_games VALUES (270, 132, 1, 884);
INSERT INTO public.guess_games VALUES (271, 132, 979, 978);
INSERT INTO public.guess_games VALUES (272, 134, 582, 581);
INSERT INTO public.guess_games VALUES (273, 134, 983, 982);
INSERT INTO public.guess_games VALUES (274, 135, 461, 460);
INSERT INTO public.guess_games VALUES (275, 135, 338, 337);
INSERT INTO public.guess_games VALUES (276, 134, 265, 262);
INSERT INTO public.guess_games VALUES (277, 134, 185, 184);
INSERT INTO public.guess_games VALUES (278, 134, 1, 184);
INSERT INTO public.guess_games VALUES (279, 134, 995, 994);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (132, 'user_1716148199858');
INSERT INTO public.users VALUES (133, 'user_1716148199857');
INSERT INTO public.users VALUES (134, 'user_1716148232560');
INSERT INTO public.users VALUES (135, 'user_1716148232559');


--
-- Name: guess_games_guess_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.guess_games_guess_game_id_seq', 279, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 135, true);


--
-- Name: guess_games guess_games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guess_games
    ADD CONSTRAINT guess_games_pkey PRIMARY KEY (guess_game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: guess_games guess_games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guess_games
    ADD CONSTRAINT guess_games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

