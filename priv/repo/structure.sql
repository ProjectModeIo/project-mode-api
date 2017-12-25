--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: interests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE interests (
    id bigint NOT NULL,
    name character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: interests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE interests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: interests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE interests_id_seq OWNED BY interests.id;


--
-- Name: projectcategories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE projectcategories (
    id bigint NOT NULL,
    project_id bigint,
    interest_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: projectcategories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projectcategories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projectcategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projectcategories_id_seq OWNED BY projectcategories.id;


--
-- Name: projectroles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE projectroles (
    id bigint NOT NULL,
    project_id bigint,
    role_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: projectroles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projectroles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projectroles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projectroles_id_seq OWNED BY projectroles.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE projects (
    id bigint NOT NULL,
    title character varying(255),
    description character varying(255),
    user_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: projectstacks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE projectstacks (
    id bigint NOT NULL,
    project_id bigint,
    skill_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: projectstacks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projectstacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projectstacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projectstacks_id_seq OWNED BY projectstacks.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE roles (
    id bigint NOT NULL,
    type character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


--
-- Name: skills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE skills (
    id bigint NOT NULL,
    name character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE skills_id_seq OWNED BY skills.id;


--
-- Name: teammembers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teammembers (
    id bigint NOT NULL,
    team_id bigint,
    user_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: teammembers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teammembers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teammembers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teammembers_id_seq OWNED BY teammembers.id;


--
-- Name: teamprojects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teamprojects (
    id bigint NOT NULL,
    team_id bigint,
    project_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: teamprojects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teamprojects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teamprojects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teamprojects_id_seq OWNED BY teamprojects.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teams (
    id bigint NOT NULL,
    name character varying(255),
    user_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;


--
-- Name: userinterests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE userinterests (
    id bigint NOT NULL,
    user_id bigint,
    interest_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: userinterests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE userinterests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: userinterests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE userinterests_id_seq OWNED BY userinterests.id;


--
-- Name: userroles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE userroles (
    id bigint NOT NULL,
    user_id bigint,
    role_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: userroles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE userroles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: userroles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE userroles_id_seq OWNED BY userroles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id bigint NOT NULL,
    email character varying(255),
    firstname character varying(255),
    lastname character varying(255),
    tagline character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    password_hash character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: userskills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE userskills (
    id bigint NOT NULL,
    user_id bigint,
    skill_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: userskills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE userskills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: userskills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE userskills_id_seq OWNED BY userskills.id;


--
-- Name: watchedprojects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE watchedprojects (
    id bigint NOT NULL,
    interestlevel integer,
    user_id bigint,
    project_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: watchedprojects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE watchedprojects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: watchedprojects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE watchedprojects_id_seq OWNED BY watchedprojects.id;


--
-- Name: interests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY interests ALTER COLUMN id SET DEFAULT nextval('interests_id_seq'::regclass);


--
-- Name: projectcategories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectcategories ALTER COLUMN id SET DEFAULT nextval('projectcategories_id_seq'::regclass);


--
-- Name: projectroles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectroles ALTER COLUMN id SET DEFAULT nextval('projectroles_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: projectstacks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectstacks ALTER COLUMN id SET DEFAULT nextval('projectstacks_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: skills id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY skills ALTER COLUMN id SET DEFAULT nextval('skills_id_seq'::regclass);


--
-- Name: teammembers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teammembers ALTER COLUMN id SET DEFAULT nextval('teammembers_id_seq'::regclass);


--
-- Name: teamprojects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teamprojects ALTER COLUMN id SET DEFAULT nextval('teamprojects_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Name: userinterests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY userinterests ALTER COLUMN id SET DEFAULT nextval('userinterests_id_seq'::regclass);


--
-- Name: userroles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY userroles ALTER COLUMN id SET DEFAULT nextval('userroles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: userskills id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY userskills ALTER COLUMN id SET DEFAULT nextval('userskills_id_seq'::regclass);


--
-- Name: watchedprojects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY watchedprojects ALTER COLUMN id SET DEFAULT nextval('watchedprojects_id_seq'::regclass);


--
-- Name: interests interests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY interests
    ADD CONSTRAINT interests_pkey PRIMARY KEY (id);


--
-- Name: projectcategories projectcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectcategories
    ADD CONSTRAINT projectcategories_pkey PRIMARY KEY (id);


--
-- Name: projectroles projectroles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectroles
    ADD CONSTRAINT projectroles_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: projectstacks projectstacks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectstacks
    ADD CONSTRAINT projectstacks_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- Name: teammembers teammembers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teammembers
    ADD CONSTRAINT teammembers_pkey PRIMARY KEY (id);


--
-- Name: teamprojects teamprojects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teamprojects
    ADD CONSTRAINT teamprojects_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: userinterests userinterests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY userinterests
    ADD CONSTRAINT userinterests_pkey PRIMARY KEY (id);


--
-- Name: userroles userroles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY userroles
    ADD CONSTRAINT userroles_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: userskills userskills_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY userskills
    ADD CONSTRAINT userskills_pkey PRIMARY KEY (id);


--
-- Name: watchedprojects watchedprojects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY watchedprojects
    ADD CONSTRAINT watchedprojects_pkey PRIMARY KEY (id);


--
-- Name: projectcategories_interest_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX projectcategories_interest_id_index ON projectcategories USING btree (interest_id);


--
-- Name: projectcategories_project_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX projectcategories_project_id_index ON projectcategories USING btree (project_id);


--
-- Name: projectroles_project_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX projectroles_project_id_index ON projectroles USING btree (project_id);


--
-- Name: projectroles_role_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX projectroles_role_id_index ON projectroles USING btree (role_id);


--
-- Name: projects_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX projects_user_id_index ON projects USING btree (user_id);


--
-- Name: projectstacks_project_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX projectstacks_project_id_index ON projectstacks USING btree (project_id);


--
-- Name: projectstacks_skill_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX projectstacks_skill_id_index ON projectstacks USING btree (skill_id);


--
-- Name: teammembers_team_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX teammembers_team_id_index ON teammembers USING btree (team_id);


--
-- Name: teammembers_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX teammembers_user_id_index ON teammembers USING btree (user_id);


--
-- Name: teamprojects_project_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX teamprojects_project_id_index ON teamprojects USING btree (project_id);


--
-- Name: teamprojects_team_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX teamprojects_team_id_index ON teamprojects USING btree (team_id);


--
-- Name: teams_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX teams_user_id_index ON teams USING btree (user_id);


--
-- Name: userinterests_interest_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX userinterests_interest_id_index ON userinterests USING btree (interest_id);


--
-- Name: userinterests_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX userinterests_user_id_index ON userinterests USING btree (user_id);


--
-- Name: userroles_role_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX userroles_role_id_index ON userroles USING btree (role_id);


--
-- Name: userroles_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX userroles_user_id_index ON userroles USING btree (user_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_index ON users USING btree (email);


--
-- Name: userskills_skill_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX userskills_skill_id_index ON userskills USING btree (skill_id);


--
-- Name: userskills_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX userskills_user_id_index ON userskills USING btree (user_id);


--
-- Name: watchedprojects_project_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX watchedprojects_project_id_index ON watchedprojects USING btree (project_id);


--
-- Name: watchedprojects_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX watchedprojects_user_id_index ON watchedprojects USING btree (user_id);


--
-- Name: projectcategories projectcategories_interest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectcategories
    ADD CONSTRAINT projectcategories_interest_id_fkey FOREIGN KEY (interest_id) REFERENCES interests(id);


--
-- Name: projectcategories projectcategories_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectcategories
    ADD CONSTRAINT projectcategories_project_id_fkey FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: projectroles projectroles_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectroles
    ADD CONSTRAINT projectroles_project_id_fkey FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: projectroles projectroles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectroles
    ADD CONSTRAINT projectroles_role_id_fkey FOREIGN KEY (role_id) REFERENCES roles(id);


--
-- Name: projects projects_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: projectstacks projectstacks_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectstacks
    ADD CONSTRAINT projectstacks_project_id_fkey FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: projectstacks projectstacks_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectstacks
    ADD CONSTRAINT projectstacks_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES skills(id);


--
-- Name: teammembers teammembers_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teammembers
    ADD CONSTRAINT teammembers_team_id_fkey FOREIGN KEY (team_id) REFERENCES teams(id);


--
-- Name: teammembers teammembers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teammembers
    ADD CONSTRAINT teammembers_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: teamprojects teamprojects_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teamprojects
    ADD CONSTRAINT teamprojects_project_id_fkey FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: teamprojects teamprojects_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teamprojects
    ADD CONSTRAINT teamprojects_team_id_fkey FOREIGN KEY (team_id) REFERENCES teams(id);


--
-- Name: teams teams_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: userinterests userinterests_interest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY userinterests
    ADD CONSTRAINT userinterests_interest_id_fkey FOREIGN KEY (interest_id) REFERENCES interests(id);


--
-- Name: userinterests userinterests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY userinterests
    ADD CONSTRAINT userinterests_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: userroles userroles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY userroles
    ADD CONSTRAINT userroles_role_id_fkey FOREIGN KEY (role_id) REFERENCES roles(id);


--
-- Name: userroles userroles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY userroles
    ADD CONSTRAINT userroles_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: userskills userskills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY userskills
    ADD CONSTRAINT userskills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES skills(id);


--
-- Name: userskills userskills_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY userskills
    ADD CONSTRAINT userskills_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: watchedprojects watchedprojects_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY watchedprojects
    ADD CONSTRAINT watchedprojects_project_id_fkey FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: watchedprojects watchedprojects_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY watchedprojects
    ADD CONSTRAINT watchedprojects_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

INSERT INTO "schema_migrations" (version) VALUES (20171222231316), (20171222231357), (20171222231514), (20171222231610), (20171222231642), (20171222231703), (20171222231737), (20171222231800), (20171222231840), (20171222231918), (20171222231938), (20171222232017), (20171222232054), (20171222232132), (20171222232226), (20171223023122);

