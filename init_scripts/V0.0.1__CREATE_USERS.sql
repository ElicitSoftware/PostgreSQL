-- No role created here is a superuser. dbowner holds what the schema owner needs beyond
-- owning its schemas: CREATE on the database, for the reporting schema each installed survey
-- gets (report_<slug>). elicit_owner is a member of it, below.
CREATE ROLE dbowner WITH
  NOLOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;

GRANT USAGE, CREATE ON SCHEMA public TO dbowner;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO dbowner;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO dbowner;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO dbowner;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE ON SEQUENCES TO dbowner;
GRANT CONNECT ON DATABASE Survey TO dbowner;
GRANT CREATE ON DATABASE Survey to dbowner;

CREATE ROLE dbuser WITH
  NOLOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;

GRANT USAGE ON SCHEMA public TO dbuser;
GRANT CONNECT ON DATABASE Survey TO dbuser;
GRANT USAGE ON SCHEMA public TO dbuser;

-- The schema owner: runs every module's migrations and Survey's reporting schema build. It
-- owns the survey and surveyreport schemas (V0.0.2) and what it creates in them, and needs
-- nothing a superuser has.
CREATE ROLE elicit_owner WITH
    LOGIN
    NOSUPERUSER
    INHERIT
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION
    ENCRYPTED PASSWORD 'SURVEYPW';

GRANT dbowner TO elicit_owner;

CREATE ROLE survey_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SURVEYPW';

-- I need to research this. I don't know if I want to give this much power to user.
-- In order to allow it to create tables. Maybe this function of the ETL Service belongs in the admin tool.
-- GRANT dbuser TO survey_user;
GRANT dbuser TO survey_user;

CREATE ROLE surveyadmin_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SAOWNERPW';

GRANT dbuser TO surveyadmin_user;

CREATE ROLE surveyreport_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SRUSERPW';

GRANT dbuser TO surveyreport_user;