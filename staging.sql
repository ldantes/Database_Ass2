-- Staging --
DROP SEQUENCE stageuser_seq;

CREATE SEQUENCE stageuser_seq
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

DROP TABLE stage_user;

CREATE TABLE stage_user
  (
     sk                   NUMBER PRIMARY KEY,
     databasesource       INTEGER,
     id                   NUMBER(10),
     public_id            VARCHAR(24),
     password             VARCHAR(64) NOT NULL,
     date_joined          DATE NOT NULL,
     email_address        VARCHAR2(62) NOT NULL,
     first_name           VARCHAR2(32) NOT NULL,
     surname              VARCHAR2(32) NOT NULL,
     gender               CHAR NOT NULL,
     date_of_birth        DATE NOT NULL,
     zip                  VARCHAR(5) NOT NULL,
     country_of_residence VARCHAR2(50) NOT NULL,
     security_question    VARCHAR(32),
     security_answer      VARCHAR(32)
  );

INSERT INTO stage_user
SELECT stageuser_seq.NEXTVAL,
       1,
       u.id,
       u.public_id,
       u.password,
       u.date_joined,
       u.email_address,
       u.first_name,
       u.surname,
       u.gender,
       u.date_of_birth,
       u.zip,
       u.country_of_residence,
       u.security_question,
       u.security_answer
FROM   users u
WHERE  u.id NOT IN (SELECT id
                    FROM   stage_user
                    WHERE  databasesource = 1);

INSERT INTO stage_user
SELECT stageuser_seq.NEXTVAL,
       2,
       u.id,
       u.public_id,
       u.password,
       u.date_joined,
       u.email_address,
       u.first_name,
       u.surname,
       Cast(To_char(u.gender) AS CHAR(1)),
       u.date_of_birth,
       u.zip,
       u.country_of_residence,
       u.security_question,
       u.security_answer
FROM   users2 u
WHERE  u.id NOT IN (SELECT id
                    FROM   stage_user
                    WHERE  databasesource = 2);

SELECT *
FROM   stage_user;

UPDATE stage_user
SET    gender = 'F'
WHERE  gender = '0';

UPDATE stage_user
SET    gender = 'M'
WHERE  gender = '1';

UPDATE stage_user
SET    gender = 'F'
WHERE  gender = 'f';

UPDATE stage_user
SET    gender = 'M'
WHERE  gender = 'm';

DROP SEQUENCE stagetitle_seq;

CREATE SEQUENCE stagetitle_seq
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

DROP TABLE stage_title;

CREATE TABLE stage_title
  (
     sk             NUMBER PRIMARY KEY,
     databasesource INTEGER,
     title_id       NUMBER(10),
     title_name     VARCHAR(50),
     rating         NUMBER(4),
     TYPE           VARCHAR2(20),
     certificate    VARCHAR(5),
     duration       NUMBER(3),
     introduction   VARCHAR2(200),
     storyline      VARCHAR2(500),
     release_date   DATE
  );

INSERT INTO stage_title
SELECT stagetitle_seq.NEXTVAL,
       1,
       t.id,
       t.name,
       t.rating,
       t.TYPE,
       t.certificate,
       t.duration,
       t.introduction,
       t.storyline,
       t.release_date
FROM   title t
WHERE  t.id NOT IN (SELECT title_id
                    FROM   stage_title
                    WHERE  databasesource = 1);

INSERT INTO stage_title
SELECT stagetitle_seq.NEXTVAL,
       2,
       t.id,
       t.name,
       t.rating / 10,
       t.TYPE,
       t.certificate,
       t.duration,
       t.introduction,
       t.storyline,
       t.release_date
FROM   title2 t
WHERE  t.id NOT IN (SELECT title_id
                    FROM   stage_title
                    WHERE  databasesource = 2);

DROP TABLE celebrity_staging;

CREATE TABLE celebrity_staging
  (
     surrogatekey   NUMBER PRIMARY KEY,
     databasesource INTEGER,
     id             NUMBER(10),
     name           VARCHAR(50) NOT NULL,
     date_of_birth  DATE NOT NULL,
     height         NUMBER(4, 2),
     star_sign      VARCHAR(15),
     gender         VARCHAR2(1)
  );

DROP SEQUENCE stage_user_rating_seq;

CREATE SEQUENCE stage_user_rating_seq
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

DROP TABLE stage_user_rating;

CREATE TABLE stage_user_rating
  (
     sk         INTEGER PRIMARY KEY,
     dbsource   INTEGER,
     user_id    NUMBER(10),
     title_id   NUMBER(10),
     score      NUMBER(2) CHECK (score <= 10),
     date_added DATE
  );

INSERT INTO stage_user_rating
SELECT stage_user_rating_seq.NEXTVAL,
       1,
       u.*
FROM   user_rating u;

INSERT INTO stage_user_rating
SELECT stage_user_rating_seq.NEXTVAL,
       2,
       u.user_id,
       u.title_id,
       u.score / 10,
       u.date_added
FROM   user_rating2 u;

DROP SEQUENCE country_seq;

CREATE SEQUENCE country_seq
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

DROP TABLE country_stage;

CREATE TABLE country_stage
  (
     country_sk   NUMBER PRIMARY KEY,
     sourcedb     INTEGER,
     country_name VARCHAR2(50)
  );

INSERT INTO country_stage
SELECT country_seq.NEXTVAL,
       1,
       country_of_residence
FROM   (SELECT DISTINCT country_of_residence
        FROM   users);

INSERT INTO country_stage
SELECT country_seq.NEXTVAL,
       2,
       country_of_residence
FROM   (SELECT DISTINCT country_of_residence
        FROM   users2
        WHERE  country_of_residence NOT IN (SELECT country_name
                                            FROM   country_stage));

SELECT *
FROM   country_stage;

DROP SEQUENCE age_seq;

CREATE SEQUENCE age_seq
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

DROP TABLE age_stage;

CREATE TABLE age_stage
  (
     age_sk NUMBER PRIMARY KEY,
     age    NUMBER(3)
  );

SELECT *
FROM   age_stage;

INSERT INTO age_stage
SELECT age_seq.NEXTVAL,
       age
FROM   (SELECT DISTINCT Trunc(( To_number(To_char(r.date_added, 'yyyymmdd'))
                                       - To_number(
                                       To_char(u.date_of_birth, 'yyyymmdd')) ) /
                                                      10000) AS age
        FROM   stage_user u,
               stage_user_rating r
        WHERE  u.id = r.user_id
               AND u.databasesource = r.dbsource);

DROP SEQUENCE date_added_seq;

CREATE SEQUENCE date_added_seq
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

DROP TABLE stage_date_added;

CREATE TABLE stage_date_added
  (
     date_added_sk NUMBER PRIMARY KEY,
     monthyear     VARCHAR(6)
  );

INSERT INTO stage_date_added
SELECT date_added_seq.NEXTVAL,
       ( To_char(date_added, 'mmyyyy') )
FROM   (SELECT DISTINCT r.date_added
        FROM   stage_user_rating r);

SELECT *
FROM   stage_date_added;

DROP TABLE fact_stage;

CREATE TABLE fact_stage
  (
     user_sk       INTEGER,
     title_sk      INTEGER,
     age_sk        INTEGER,
     country_sk    INTEGER,
     date_added_sk VARCHAR2(6),
     user_id       INTEGER,
     age           INTEGER,
     country       VARCHAR(30),
     date_added    DATE,
     title_id      INTEGER,
     score         NUMBER(4, 2),
     sourcedb      INTEGER
  );

INSERT INTO fact_stage
            (user_id,
             title_id,
             score,
             date_added,
             sourcedb)
SELECT user_id,
       title_id,
       score,
       date_added,
       dbsource
FROM   stage_user_rating;

UPDATE fact_stage
SET    user_sk = (SELECT stage_user.sk
                  FROM   stage_user
                  WHERE  ( stage_user.id = fact_stage.user_id
                           AND stage_user.databasesource = fact_stage.sourcedb )
                 );

UPDATE fact_stage
SET    title_sk = (SELECT stage_title.sk
                   FROM   stage_title
                   WHERE  ( stage_title.title_id = fact_stage.title_id
                            AND stage_title.databasesource = fact_stage.sourcedb
                          ));

UPDATE fact_stage f
SET    age = (SELECT Trunc(( To_number(To_char(f.date_added, 'yyyymmdd'))
                             - To_number(
                                    To_char(u.date_of_birth, 'yyyymmdd'))
                                        ) /
                                                10000)
              FROM   stage_user u
              WHERE  ( u.id = f.user_id
                       AND u.databasesource = f.sourcedb ));

UPDATE fact_stage
SET    age_sk = (SELECT age_sk
                 FROM   age_stage
                 WHERE  age_stage.age = fact_stage.age);

UPDATE fact_stage
SET    country = (SELECT country_of_residence
                  FROM   stage_user
                  WHERE  fact_stage.user_sk = stage_user.sk);

UPDATE fact_stage
SET    country_sk = (SELECT country_sk
                     FROM   country_stage
                     WHERE  fact_stage.country = country_stage.country_name);

UPDATE fact_stage
SET    date_added_sk = (SELECT DISTINCT date_added_sk
                        FROM   stage_date_added
                        WHERE  stage_date_added.monthyear =
                               ( To_char(fact_stage.date_added, 'mmyyyy') ));

SELECT *
FROM   fact_stage;

SELECT *
FROM   age_stage;

SELECT *
FROM   stage_user;

SELECT *
FROM   stage_title; 


commit;