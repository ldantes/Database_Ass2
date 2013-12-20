DROP TABLE fact_table;

DROP TABLE dim_user;

CREATE TABLE dim_user
  (
     sk                   INTEGER PRIMARY KEY,
     public_id            VARCHAR(24),
     password             VARCHAR(64) NOT NULL,
     date_joined          DATE NOT NULL,
     email_address        VARCHAR2(62) NOT NULL,
     first_name           VARCHAR2(32) NOT NULL,
     surname              VARCHAR2(32) NOT NULL,
     gender               CHAR NOT NULL CHECK (gender IN ('M', 'F', 'm', 'f')),
     date_of_birth        DATE NOT NULL,
     zip                  VARCHAR(5) NOT NULL,
     country_of_residence VARCHAR2(50) NOT NULL,
     security_question    VARCHAR(32),
     security_answer      VARCHAR(32)
  );

INSERT INTO dim_user
SELECT sk,
       public_id,
       password,
       date_joined,
       email_address,
       first_name,
       surname,
       gender,
       date_of_birth,
       zip,
       country_of_residence,
       security_question,
       security_answer
FROM   stage_user;

SELECT *
FROM   dim_user;

DROP TABLE dim_title;

CREATE TABLE dim_title
  (
     sk           INTEGER PRIMARY KEY,
     title_name   VARCHAR(50),
     rating       DECIMAL(3, 1) CHECK (rating <= 10.00),
     TYPE         VARCHAR2(20),
     certificate  VARCHAR(5),
     duration     NUMBER(3),
     introduction VARCHAR2(200),
     storyline    VARCHAR2(500),
     release_date DATE
  );

INSERT INTO dim_title
SELECT sk,
       title_name,
       rating,
       TYPE,
       certificate,
       duration,
       introduction,
       storyline,
       release_date
FROM   stage_title;

SELECT *
FROM   dim_title;

DROP TABLE dim_country;

CREATE TABLE dim_country
  (
     country_sk   INTEGER PRIMARY KEY,
     country_name VARCHAR2(50)
  );

INSERT INTO dim_country
SELECT country_sk,
       country_name
FROM   country_stage;

SELECT *
FROM   dim_country;

DROP TABLE dim_age;

CREATE TABLE dim_age
  (
     age_sk INTEGER PRIMARY KEY,
     age    NUMBER(3)
  );

INSERT INTO dim_age
SELECT age_sk,
       age
FROM   age_stage;

SELECT *
FROM   dim_age;

DROP TABLE dim_date_added;

CREATE TABLE dim_date_added
  (
     date_added_sk INTEGER PRIMARY KEY,
     monthyear     VARCHAR(6)
  );

INSERT INTO dim_date_added
SELECT date_added_sk,
       monthyear
FROM   stage_date_added;

SELECT *
FROM   dim_date_added;

CREATE TABLE fact_table
  (
     user_sk       INTEGER,
     title_sk      INTEGER,
     age_sk        INTEGER,
     country_sk    INTEGER,
     date_added_sk INTEGER,
     score         NUMBER(4, 2),
     PRIMARY KEY (user_sk, title_sk, age_sk, country_sk, date_added_sk, score),
     CONSTRAINT fact_user FOREIGN KEY (user_sk) REFERENCES dim_user(sk),
     CONSTRAINT fact_title FOREIGN KEY (title_sk) REFERENCES dim_title(sk),
     CONSTRAINT fact_age FOREIGN KEY (age_sk) REFERENCES dim_age(age_sk),
     CONSTRAINT fact_country FOREIGN KEY (country_sk) REFERENCES dim_country(
     country_sk),
     CONSTRAINT fact_date_added FOREIGN KEY (date_added_sk) REFERENCES
     dim_date_added(date_added_sk)
  );

INSERT INTO fact_table
SELECT user_sk,
       title_sk,
       age_sk,
       country_sk,
       date_added_sk,
       score
FROM   fact_stage;

SELECT *
FROM   fact_table;

commit;
--Sample Queies--
--select average score of users aged 18-25
SELECT SUM(score) / Count(*) average
FROM   fact_table f,
       dim_age a
WHERE  a.age <= 25
       AND a.age >= 18
       AND f.age_sk = a.age_sk; 
