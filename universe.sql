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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(50) NOT NULL,
    galaxy_type text NOT NULL,
    discoverer character varying(50),
    radius_in_light_years double precision
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    planet_id integer,
    name character varying(50) NOT NULL,
    is_regular boolean NOT NULL,
    diameter_in_km double precision
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer,
    name character varying(50) NOT NULL,
    has_moon boolean NOT NULL,
    number_of_moons integer,
    radius_in_km double precision
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet_moon (
    planet_id integer NOT NULL,
    moon_id integer NOT NULL,
    is_dwarf_planet boolean
);


ALTER TABLE public.planet_moon OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    galaxy_id integer,
    name character varying(50) NOT NULL,
    star_type text NOT NULL,
    solar_radius integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way Galaxy', 'spiral', 'Galileo Galilei', 52850);
INSERT INTO public.galaxy VALUES (2, 'Andromeda Galaxy', 'spiral', 'Abd al-Rahman al-Sufi', 220000);
INSERT INTO public.galaxy VALUES (3, 'Hercules A', 'elliptical', '', 1500000);
INSERT INTO public.galaxy VALUES (4, 'Malin 1', 'spiral', 'David Malin', 650000);
INSERT INTO public.galaxy VALUES (5, 'NGC 4889', 'elliptical', 'William Herschel', 2200000);
INSERT INTO public.galaxy VALUES (6, 'UGC 2885', 'spiral', 'Vera Rubin', 800000);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 3, 'Luna', true, 3475);
INSERT INTO public.moon VALUES (2, 4, 'Deimos', true, 12.4);
INSERT INTO public.moon VALUES (3, 4, 'Phobos', false, 22.5);
INSERT INTO public.moon VALUES (4, 5, 'Ananke', false, 20);
INSERT INTO public.moon VALUES (5, 5, 'Arche', false, 3);
INSERT INTO public.moon VALUES (6, 5, 'Callisto', true, 4800);
INSERT INTO public.moon VALUES (7, 5, 'Erinome', false, 3.2);
INSERT INTO public.moon VALUES (8, 7, 'Aegir', true, 6);
INSERT INTO public.moon VALUES (9, 7, 'Anthe', true, 1);
INSERT INTO public.moon VALUES (10, 7, 'Bestla', true, 7);
INSERT INTO public.moon VALUES (11, 7, 'Pan', true, 19.2);
INSERT INTO public.moon VALUES (12, 7, 'Phoebe', true, 220);
INSERT INTO public.moon VALUES (13, 7, 'Rhea', true, 1528);
INSERT INTO public.moon VALUES (14, 7, 'Tarqeq', false, 7);
INSERT INTO public.moon VALUES (15, 6, 'Ariel', true, 1160);
INSERT INTO public.moon VALUES (16, 6, 'Cordelia', true, 26);
INSERT INTO public.moon VALUES (17, 6, 'Cupid', true, 12);
INSERT INTO public.moon VALUES (18, 6, 'Juliet', true, 84);
INSERT INTO public.moon VALUES (19, 6, 'Oberon', true, 1526);
INSERT INTO public.moon VALUES (20, 6, 'Puck', false, 154);
INSERT INTO public.moon VALUES (21, 6, 'Titania', true, 1578);
INSERT INTO public.moon VALUES (22, 6, 'Umbriel', true, 1190);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 1, 'Mercury', false, 0, 2439.7);
INSERT INTO public.planet VALUES (2, 1, 'Venus', false, 0, 6051.8);
INSERT INTO public.planet VALUES (3, 1, 'Earth', true, 1, 6371);
INSERT INTO public.planet VALUES (4, 1, 'Mars', true, 2, 3396.2);
INSERT INTO public.planet VALUES (5, 1, 'Jupiter', true, 95, 69911);
INSERT INTO public.planet VALUES (6, 1, 'Uranus', true, 27, 25362);
INSERT INTO public.planet VALUES (7, 1, 'Saturn', true, 145, 58232);
INSERT INTO public.planet VALUES (8, 1, 'Neptune', true, 14, 24622);
INSERT INTO public.planet VALUES (9, 1, 'Ceres', false, 0, 473.6);
INSERT INTO public.planet VALUES (10, 1, 'Makemake', true, 1, 715.6);
INSERT INTO public.planet VALUES (11, 1, 'Haumea', true, 2, 816.3);
INSERT INTO public.planet VALUES (12, 1, 'Eris', true, 1, 1163);
INSERT INTO public.planet VALUES (13, 1, 'Pluto', true, 5, 1188.3);


--
-- Data for Name: planet_moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet_moon VALUES (3, 1, false);
INSERT INTO public.planet_moon VALUES (4, 2, false);
INSERT INTO public.planet_moon VALUES (4, 3, false);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 1, 'The Sun', 'G-type', 1);
INSERT INTO public.star VALUES (2, 1, 'Sirius', 'Main sequence white star', 71);
INSERT INTO public.star VALUES (3, 2, 'B2lab Supergiant', 'B-type', 13);
INSERT INTO public.star VALUES (4, 2, 'A01a Supergiant', 'A-type', 15);
INSERT INTO public.star VALUES (5, 1, 'Aldebaran', 'Red Giant', 44);
INSERT INTO public.star VALUES (6, 1, 'Rigel', 'Blue Supergiant', 78);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 22, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 13, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: galaxy galaxy_galaxy_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_galaxy_id_key UNIQUE (galaxy_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: moon moon_moon_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_moon_id_key UNIQUE (moon_id);


--
-- Name: planet_moon planet_moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_moon
    ADD CONSTRAINT planet_moon_pkey PRIMARY KEY (planet_id, moon_id);


--
-- Name: planet planet_planet_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_planet_id_key UNIQUE (planet_id);


--
-- Name: star star_star_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_star_id_key UNIQUE (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet_moon planet_moon_moon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_moon
    ADD CONSTRAINT planet_moon_moon_id_fkey FOREIGN KEY (moon_id) REFERENCES public.moon(moon_id);


--
-- Name: planet_moon planet_moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_moon
    ADD CONSTRAINT planet_moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

