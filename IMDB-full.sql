-- Original Two databases are Created and defined

DROP TABLE title_genre;

DROP TABLE genre;

DROP TABLE character_appearences;

DROP TABLE characters;

DROP TABLE user_rating;

DROP TABLE review;

DROP TABLE users;

DROP TABLE involvement;

DROP TABLE title;

DROP TABLE category;

DROP TABLE celebrity;

DROP TABLE title_genre2;

DROP TABLE genre2;

DROP TABLE character_appearences2;

DROP TABLE characters2;

DROP TABLE user_rating2;

DROP TABLE review2;

DROP TABLE users2;

DROP TABLE involvement2;

DROP TABLE title2;

DROP TABLE category2;

DROP TABLE celebrity2;

CREATE TABLE celebrity
  (
     id            NUMBER(10) PRIMARY KEY,
     name          VARCHAR(50) NOT NULL,
     date_of_birth DATE NOT NULL,
     height        NUMBER(4, 2),
     star_sign     VARCHAR(15),
     gender        CHAR NOT NULL CHECK (gender IN ('M', 'F', 'm', 'f'))
  );

DROP INDEX celeb_index;

CREATE INDEX celeb_index
  ON celebrity (name);

CREATE TABLE category
  (
     category VARCHAR(20) PRIMARY KEY
  );

CREATE TABLE title
  (
     id           NUMBER(10) PRIMARY KEY,
     name         VARCHAR(50) NOT NULL,
     rating       DECIMAL(3, 1) CHECK (rating <= 10.00),
     TYPE         VARCHAR2(20) NOT NULL CHECK (TYPE IN ('TV Series', 'Tv Eisode'
     ,
     'TV Mini-Series', 'Video',
     'Short', 'Film', 'Tv Movie', 'Video Game' )),
     certificate  VARCHAR(5),
     duration     NUMBER(3),
     introduction VARCHAR2(200),
     storyline    VARCHAR2(500),
     release_date DATE
  );

DROP INDEX title_index;

CREATE INDEX title_index
  ON title (name);

CREATE TABLE involvement
  (
     celebrity_id NUMBER(10),
     title_id     NUMBER(10),
     category     VARCHAR(30),
     PRIMARY KEY (celebrity_id, title_id, category),
     CONSTRAINT inv_celeb_id FOREIGN KEY (celebrity_id) REFERENCES celebrity(id)
     ,
     CONSTRAINT inv_title_id FOREIGN KEY (title_id) REFERENCES title(id),
     CONSTRAINT inv_category FOREIGN KEY (category) REFERENCES category(category
     )
  );

CREATE TABLE users
  (
     id                   NUMBER(10) PRIMARY KEY,
     public_id            VARCHAR(24) UNIQUE,
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

CREATE TABLE review
  (
     user_id  NUMBER(10),
     title_id NUMBER(10),
     score    NUMBER(2),
     review   VARCHAR(500),
     PRIMARY KEY(user_id, title_id),
     CONSTRAINT rev_user_id FOREIGN KEY (user_id) REFERENCES users(id),
     CONSTRAINT rev_title_id FOREIGN KEY (title_id) REFERENCES title(id)
  );

DROP INDEX rev_title_index;

CREATE INDEX rev_title_index
  ON review (title_id);

DROP INDEX rev_user_index;

CREATE INDEX rev_user_index
  ON review (user_id);

CREATE TABLE user_rating
  (
     user_id    NUMBER(10),
     title_id   NUMBER(10),
     score      NUMBER(2) CHECK (score <= 10),
     date_added DATE,
     PRIMARY KEY(user_id, title_id),
     CONSTRAINT ur_user_id FOREIGN KEY (user_id) REFERENCES users(id),
     CONSTRAINT ur_title_id FOREIGN KEY (title_id) REFERENCES title(id)
  );

CREATE TABLE characters
  (
     id             NUMBER(10),
     character_name VARCHAR(50) NOT NULL,
     biography      VARCHAR(200),
     PRIMARY KEY (id)
  );

DROP INDEX char_index;

CREATE INDEX char_index
  ON characters (character_name);

CREATE TABLE character_appearences
  (
     character_id NUMBER(10),
     title_id     NUMBER(10),
     celebrity_id NUMBER(10),
     PRIMARY KEY (character_id, title_id),
     CONSTRAINT appear_char_id FOREIGN KEY (character_id) REFERENCES characters(
     id),
     CONSTRAINT appear_celeb_id FOREIGN KEY (celebrity_id) REFERENCES celebrity(
     id),
     CONSTRAINT appear_title_id FOREIGN KEY (title_id) REFERENCES title(id)
  );

DROP INDEX ca_title_index;

CREATE INDEX ca_title_index
  ON character_appearences (title_id);

DROP INDEX ca_celeb_index;

CREATE INDEX ca_celeb_index
  ON character_appearences (celebrity_id);

DROP INDEX ca_char_index;

CREATE INDEX ca_char_index
  ON character_appearences (character_id);

CREATE TABLE genre
  (
     genre VARCHAR(20) PRIMARY KEY
  );

CREATE TABLE title_genre
  (
     title_id NUMBER(10),
     genre    VARCHAR(20),
     PRIMARY KEY (title_id, genre),
     CONSTRAINT title_genre FOREIGN KEY (genre) REFERENCES genre(genre),
     CONSTRAINT genre_title FOREIGN KEY (title_id) REFERENCES title(id)
  );

CREATE TABLE celebrity2
  (
     id            NUMBER(10) PRIMARY KEY,
     name          VARCHAR(50) NOT NULL,
     date_of_birth DATE NOT NULL,
     height        NUMBER(4, 2),
     star_sign     VARCHAR(15),
     gender        INTEGER
  );

DROP INDEX celeb_index2;

CREATE INDEX celeb_index2
  ON celebrity2 (name);

CREATE TABLE category2
  (
     category VARCHAR(20) PRIMARY KEY
  );

CREATE TABLE title2
  (
     id           NUMBER(10) PRIMARY KEY,
     name         VARCHAR(50) NOT NULL,
     rating       NUMBER(4) CHECK (rating <= 100),
     TYPE         VARCHAR2(20) NOT NULL CHECK (TYPE IN ('TV Series', 'Tv Eisode'
     ,
     'TV Mini-Series', 'Video',
     'Short', 'Film', 'Tv Movie', 'Video Game' )),
     certificate  VARCHAR(5),
     duration     NUMBER(3),
     introduction VARCHAR2(200),
     storyline    VARCHAR2(500),
     release_date DATE
  );

DROP INDEX title_index2;

CREATE INDEX title_index2
  ON title2 (name);

CREATE TABLE involvement2
  (
     celebrity_id NUMBER(10),
     title_id     NUMBER(10),
     category     VARCHAR(30),
     PRIMARY KEY (celebrity_id, title_id, category),
     CONSTRAINT inv_celeb_id2 FOREIGN KEY (celebrity_id) REFERENCES celebrity2(
     id),
     CONSTRAINT inv_title_id2 FOREIGN KEY (title_id) REFERENCES title2(id),
     CONSTRAINT inv_category2 FOREIGN KEY (category) REFERENCES category(
     category)
  );

CREATE TABLE users2
  (
     id                   NUMBER(10) PRIMARY KEY,
     public_id            VARCHAR(24) UNIQUE,
     password             VARCHAR(64) NOT NULL,
     date_joined          DATE NOT NULL,
     email_address        VARCHAR2(62) NOT NULL,
     first_name           VARCHAR2(32) NOT NULL,
     surname              VARCHAR2(32) NOT NULL,
     gender               INTEGER CHECK (gender IN (1, 0)),
     date_of_birth        DATE NOT NULL,
     zip                  VARCHAR(5) NOT NULL,
     country_of_residence VARCHAR2(50) NOT NULL,
     security_question    VARCHAR(32),
     security_answer      VARCHAR(32)
  );

CREATE TABLE review2
  (
     user_id  NUMBER(10),
     title_id NUMBER(10),
     score    NUMBER(2),
     review   VARCHAR(500),
     PRIMARY KEY(user_id, title_id),
     CONSTRAINT rev_user_id2 FOREIGN KEY (user_id) REFERENCES users2(id),
     CONSTRAINT rev_title_id2 FOREIGN KEY (title_id) REFERENCES title2(id)
  );

DROP INDEX rev_title_index2;

CREATE INDEX rev_title_index2
  ON review2 (title_id);

DROP INDEX rev_user_index2;

CREATE INDEX rev_user_index2
  ON review2 (user_id);

CREATE TABLE user_rating2
  (
     user_id    NUMBER(10),
     title_id   NUMBER(10),
     score      NUMBER(4),
     date_added DATE,
     PRIMARY KEY(user_id, title_id),
     CONSTRAINT ur_user_id2 FOREIGN KEY (user_id) REFERENCES users2(id),
     CONSTRAINT ur_title_id2 FOREIGN KEY (title_id) REFERENCES title2(id)
  );

CREATE TABLE characters2
  (
     id             NUMBER(10),
     character_name VARCHAR(50) NOT NULL,
     biography      VARCHAR(200),
     PRIMARY KEY (id)
  );

DROP INDEX char_index2;

CREATE INDEX char_index2
  ON characters2 (character_name);

CREATE TABLE character_appearences2
  (
     character_id NUMBER(10),
     title_id     NUMBER(10),
     celebrity_id NUMBER(10),
     PRIMARY KEY (character_id, title_id),
     CONSTRAINT appear_char_id2 FOREIGN KEY (character_id) REFERENCES
     characters2(id),
     CONSTRAINT appear_celeb_id2 FOREIGN KEY (celebrity_id) REFERENCES
     celebrity2(id),
     CONSTRAINT appear_title_id2 FOREIGN KEY (title_id) REFERENCES title2(id)
  );

DROP INDEX ca_title_index2;

CREATE INDEX ca_title_index2
  ON character_appearences2 (title_id);

DROP INDEX ca_celeb_index2;

CREATE INDEX ca_celeb_index2
  ON character_appearences2 (celebrity_id);

DROP INDEX ca_char_index2;

CREATE INDEX ca_char_index2
  ON character_appearences2 (character_id);

CREATE TABLE genre2
  (
     genre VARCHAR(20) PRIMARY KEY
  );

CREATE TABLE title_genre2
  (
     title_id NUMBER(10),
     genre    VARCHAR(20),
     PRIMARY KEY (title_id, genre),
     CONSTRAINT title_genre2 FOREIGN KEY (genre) REFERENCES genre2(genre),
     CONSTRAINT genre_title2 FOREIGN KEY (title_id) REFERENCES title2(id)
  );

--create sequences 
DROP SEQUENCE title_seq;

DROP SEQUENCE char_seq;

DROP SEQUENCE celeb_seq;

DROP SEQUENCE user_seq;

CREATE SEQUENCE title_seq
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

CREATE SEQUENCE char_seq
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

CREATE SEQUENCE celeb_seq
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

CREATE SEQUENCE user_seq
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

--create sequences 
DROP SEQUENCE title_seq2;

DROP SEQUENCE char_seq2;

DROP SEQUENCE celeb_seq2;

DROP SEQUENCE user_seq2;

CREATE SEQUENCE title_seq2
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

CREATE SEQUENCE char_seq2
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

CREATE SEQUENCE celeb_seq2
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

CREATE SEQUENCE user_seq2
  MINVALUE 1
  MAXVALUE 999999
  INCREMENT BY 1
  START WITH 1
  CACHE 20;

CREATE OR replace TRIGGER title_rating_update_ai
  AFTER INSERT OR UPDATE ON user_rating
DECLARE
BEGIN
    UPDATE title t
    SET    rating = (SELECT SUM(score) / Count(*)
                     FROM   user_rating ur
                     WHERE  t.id = ur.title_id
                     GROUP  BY 1);
END;

/
--
CREATE OR replace TRIGGER title_rating_update2_ai
  AFTER INSERT OR UPDATE ON user_rating2
DECLARE
BEGIN
    UPDATE title2 t
    SET    rating = (SELECT SUM(score) / Count(*)
                     FROM   user_rating2 ur
                     WHERE  t.id = ur.title_id
                     GROUP  BY 1);
END; 
/
commit;

-- Insert into both tables
-----------------------
------------------------
-------------------------
INSERT INTO users
VALUES      ( user_seq.NEXTVAL,
             'ldantes',
             '**********',
             SYSDATE,
             'ldantes@imdb.com',
             'Les',
             'Ducray',
             'M',
             '9-AUG-1990',
             'xxxx',
             'Ireland',
             'First pets name',
             'Goldie' );

INSERT INTO users
VALUES      ( user_seq.NEXTVAL,
             'samual',
             '**********',
             SYSDATE,
             'shar@imdb.com',
             'Sam',
             'Harrison',
             'F',
             '19-JUN-1987',
             'xxxx',
             'Ireland',
             'First pets name',
             'Spike' );

INSERT INTO users
VALUES      ( user_seq.NEXTVAL,
             'rat',
             '**********',
             SYSDATE,
             'rat@imdb.com',
             'Richard',
             'King',
             'M',
             '01-MAY-1996',
             'xxxx',
             'Ireland',
             'Mothers name',
             'Mary' );

INSERT INTO title
VALUES      ( title_seq.NEXTVAL,
             'Boardwalk Empire',
             NULL,
             'TV Series',
             'TVMA',
             60,
'Chronicles the life and times of Nucky Thompson, the undisputed ruler of Atlantic City.'
              ,
'Set in the Prohibition era of the 1920s Boardwalk Empire is the story of Enoch "Nucky" Thompson, the treasurer of Atlantic County, Atlantic City, New Jersey.'
              ,
SYSDATE );

INSERT INTO title
VALUES      ( title_seq.NEXTVAL,
             'The Wire',
             NULL,
             'TV Series',
             'TVMA',
             60,
'Baltimore drug scene, seen through the eyes of drug dealers, and law enforcement. '
              ,
'Set in Baltimore, this show centers around the city''s inner-city drug scene. It starts as mid-level drug dealer, D''Angelo Barksdale beats a murder rap. After a conversation with a judge, Det. James McNulty has been assigned to lead a joint homicide and narcotics team, in order to bring down drug kingpin Avon Barksdale. '
              ,
SYSDATE );

INSERT INTO celebrity
VALUES     (celeb_seq.NEXTVAL,
            'Bobby Cannavale',
            '3-MAY-1970',
            1.89,
            'Taurus',
            'M');

INSERT INTO celebrity
VALUES     (celeb_seq.NEXTVAL,
            'Michael K. Williams',
            '22-NOV-1966',
            1.8,
            'Sagittarius',
            'm');

INSERT INTO category
VALUES      ('actor');

INSERT INTO category
VALUES      ('producer');

INSERT INTO category
VALUES      ('self');

INSERT INTO category
VALUES      ('thanks');

INSERT INTO involvement
VALUES     (2,
            2,
            'actor');

INSERT INTO involvement
VALUES     (2,
            1,
            'actor');

INSERT INTO involvement
VALUES     (1,
            1,
            'actor');

INSERT INTO characters
VALUES      (char_seq.NEXTVAL,
             'Gyp Rosetti',
             'Ruthless villian');

INSERT INTO characters
VALUES      (char_seq.NEXTVAL,
             'Chalky White',
'Leader and primary caretaker of Atlantic County''s black population');

INSERT INTO characters
VALUES      (char_seq.NEXTVAL,
             'Omar Little',
             'Robbing Hood');

INSERT INTO character_appearences
VALUES      (1,
             1,
             1);

INSERT INTO character_appearences
VALUES      (2,
             1,
             2);

INSERT INTO character_appearences
VALUES      (3,
             2,
             2);

INSERT INTO genre
VALUES      ('drama');

INSERT INTO genre
VALUES      ('crime');

INSERT INTO genre
VALUES      ('thriller');

INSERT INTO genre
VALUES      ('history');

INSERT INTO title_genre
VALUES     (1,
            'drama');

INSERT INTO title_genre
VALUES     (1,
            'history');

INSERT INTO title_genre
VALUES     (1,
            'crime');

INSERT INTO title_genre
VALUES     (2,
            'drama');

INSERT INTO title_genre
VALUES     (2,
            'crime');

INSERT INTO title_genre
VALUES     (2,
            'thriller');

INSERT INTO user_rating
VALUES      (1,
             1,
             8,
             '01-JAN-2007');

INSERT INTO user_rating
VALUES      (1,
             2,
             7,
             '05-AUG-2007');

INSERT INTO user_rating
VALUES      (2,
             2,
             9,
             '06-AUG-2004');

INSERT INTO user_rating
VALUES      (2,
             1,
             10,
             '01-SEP-2009');

INSERT INTO user_rating
VALUES      (3,
             2,
             6,
             SYSDATE);

COMMIT;

INSERT INTO users2
VALUES      ( user_seq2.NEXTVAL,
             'matt90',
             '**********',
             SYSDATE,
             'matttt90@imdb.com',
             'matt',
             'Fan',
             1,
             '7-MAY-1990',
             'xxxx',
             'UK',
             'First pets name',
             'rat' );

INSERT INTO users2
VALUES      ( user_seq2.NEXTVAL,
             'Mohammed',
             '**********',
             SYSDATE,
             'mo@imdb.com',
             'Mohammed',
             'Mohammed',
             1,
             '16-SEP-1983',
             'xxxx',
             'Saudi',
             '',
             '' );

INSERT INTO users2
VALUES      ( user_seq2.NEXTVAL,
             'Jzzz89',
             '**********',
             SYSDATE,
             'jesssi@imdb.com',
             'Jess',
             'Smith',
             0,
             '17-JAN-1990',
             'xxxx',
             'Ireland',
             'Mothers name',
             'Mary' );

INSERT INTO title2
VALUES      ( title_seq2.NEXTVAL,
             'Sons of Anarchy',
             NULL,
             'TV Series',
             'TVMA',
             45,
'A man in his early 30s struggles to find a balance in his life between being a new dad and his involvement in a motorcycle club.'
              ,
'Sons of Anarchy, aka SAMCRO, is a motorcycle club that operates both illegal and legal businesses in the small town of Charming.'
              ,
'3-SEP-2008' );

INSERT INTO title2
VALUES      ( title_seq2.NEXTVAL,
             'Gladiator',
             NULL,
             'Film',
             'R',
             155,
'When a Roman general is betrayed and his family murdered by an emperor''s corrupt son, he comes to Rome as a gladiator to seek revenge. '
              ,
'Maximus is a powerful Roman general, loved by the people and the aging Emperor, Marcus Aurelius. Before his death, the Emperor chooses Maximus to be his heir over his own son, Commodus, and a power struggle leaves Maximus and his family condemned to death.'
              ,
'5-MAY-2000' );

INSERT INTO title2
VALUES      ( title_seq2.NEXTVAL,
             'Orphan Black',
             NULL,
             'TV Series',
             'MA',
             60,
'A streetwise hustler is pulled into a compelling conspiracy after witnessing the suicide of a girl who looks just like her.'
              ,
'Orphan Black follows outsider, orphan and street-wise chameleon Sarah.',
'30-MAR-13' );

SELECT *
FROM   title2;

INSERT INTO celebrity2
VALUES     (celeb_seq2.NEXTVAL,
            'Tommy Flanagan',
            '3-JULY-65',
            6,
            'Cancer',
            1);

INSERT INTO celebrity2
VALUES     (celeb_seq2.NEXTVAL,
            'Katey Sagal',
            '19-JAN-54',
            5.9,
            'Capricorn',
            0);

INSERT INTO celebrity2
VALUES     (celeb_seq2.NEXTVAL,
            'Tatiana Maslany',
            '22-SEP-85',
            5.4,
            'Virgo',
            0);

SELECT *
FROM   celebrity2;

INSERT INTO category2
VALUES      ('actor');

INSERT INTO category2
VALUES      ('producer');

INSERT INTO category2
VALUES      ('self');

INSERT INTO category2
VALUES      ('thanks');

INSERT INTO involvement2
VALUES     (1,
            1,
            'actor');

INSERT INTO involvement2
VALUES     (1,
            2,
            'actor');

INSERT INTO involvement2
VALUES     (2,
            1,
            'actor');

INSERT INTO involvement2
VALUES     (3,
            3,
            'actor');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Filip ''Chibs'' Telford',
'Chibs is usually in the thick of whatever craziness the club is involved in, as a dutiful soldier.'
);

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Gemma Teller Morrow',
             'Gemma Teller has been connected to SAMCRO all her adult life');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Sarah Manning',
             'Clone');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Cosima Niehaus',
             'Clone');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Alison Hendrix',
             'Clone');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Beth Childs',
             'Clone');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Katja',
             'Clone');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Cicero',
             'Cicero is the servant of General Maximus of the Roman army.');

SELECT *
FROM   characters2;

INSERT INTO character_appearences2
VALUES      (1,
             1,
             1);

INSERT INTO character_appearences2
VALUES      (2,
             1,
             2);

INSERT INTO character_appearences2
VALUES      (3,
             3,
             3);

INSERT INTO character_appearences2
VALUES      (4,
             3,
             3);

INSERT INTO character_appearences2
VALUES      (5,
             3,
             3);

INSERT INTO character_appearences2
VALUES      (6,
             3,
             3);

INSERT INTO character_appearences2
VALUES      (7,
             3,
             3);

INSERT INTO character_appearences2
VALUES      (8,
             2,
             1);

SELECT *
FROM   character_appearences2;

INSERT INTO genre2
VALUES      ('drama');

INSERT INTO genre2
VALUES      ('crime');

INSERT INTO genre2
VALUES      ('thriller');

INSERT INTO genre2
VALUES      ('history');

INSERT INTO title_genre2
VALUES     (1,
            'drama');

INSERT INTO title_genre2
VALUES     (1,
            'crime');

INSERT INTO title_genre2
VALUES     (2,
            'history');

INSERT INTO title_genre2
VALUES     (2,
            'drama');

INSERT INTO title_genre2
VALUES     (3,
            'drama');

INSERT INTO title_genre2
VALUES     (3,
            'thriller');

INSERT INTO user_rating2
VALUES      (1,
             1,
             80,
             SYSDATE);

INSERT INTO user_rating2
VALUES      (1,
             2,
             70,
             SYSDATE);

INSERT INTO user_rating2
VALUES      (2,
             2,
             90,
             '21-JUN-2012');

INSERT INTO user_rating2
VALUES      (2,
             1,
             100,
             '23-JUL-2013');

INSERT INTO user_rating2
VALUES      (3,
             2,
             60,
             SYSDATE);

COMMIT; 

-- Implement the staging of the required tables
-- Staging --
-----------------------
------------------------
-------------------------

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

-- Load into Dimensions
-----------------------
------------------------
-------------------------

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


-- Second ETL
-----------------------
------------------------
-------------------------
-- ETL 2 and beyond--
-- inset new values into original DBs and update staging tables
INSERT INTO title
VALUES      ( title_seq.NEXTVAL,
             'Bronson',
             NULL,
             'Film',
             'R',
             92,
'A young man who was sentenced to 7 years in prison for robbing a post office ends up spending 30 years in solitary confinement.'
              ,
'In 1974, a hot-headed 19 year old named Michael Peterson decided he wanted to make a name for himself and so, with a homemade sawn-off shotgun and a head full of dreams he attempted to rob a post office.'
              ,
'13-MAR-2009' );

INSERT INTO title2
VALUES      ( title_seq.NEXTVAL,
             'Mesrine',
             NULL,
             'Film',
             'R',
             133,
             'The story of notorious French gangster Jacques Mesrine.',
'The story of Jacques Mesrine, France''s public enemy No. 1 during the 1970s. After nearly two decades of legendary criminal feats.'
              ,
'28-AUG-2009' );

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
       t.rating,
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

SELECT *
FROM   stage_title;

INSERT INTO users
VALUES      ( user_seq.NEXTVAL,
             'kitty',
             '**********',
             SYSDATE,
             'kiddy67@imdb.com',
             'Kit',
             'Walker',
             'F',
             '9-SEP-1967',
             'xxxx',
             'America',
             'First pets name',
             'Woofi' );

INSERT INTO users2
VALUES      ( user_seq.NEXTVAL,
             'sally',
             '**********',
             SYSDATE,
             'sally@imdb.com',
             'sally',
             'Walker',
             0,
             '9-SEP-1967',
             'xxxx',
             'Germany',
             'First pets name',
             'Woofi' );

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
       u.gender,
       u.date_of_birth,
       u.zip,
       u.country_of_residence,
       u.security_question,
       u.security_answer
FROM   users2 u
WHERE  u.id NOT IN (SELECT id
                    FROM   stage_user
                    WHERE  databasesource = 2);

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

SELECT *
FROM   stage_user;

INSERT INTO user_rating
VALUES      (1,
             3,
             9,
             SYSDATE);

INSERT INTO user_rating
VALUES      (2,
             3,
             8,
             SYSDATE);

INSERT INTO user_rating2
VALUES      (3,
             4,
             90,
             SYSDATE);

INSERT INTO user_rating2
VALUES      (2,
             4,
             100,
             SYSDATE);

INSERT INTO user_rating
VALUES      (4,
             3,
             10,
             SYSDATE);

INSERT INTO stage_user_rating
SELECT stage_user_rating_seq.NEXTVAL,
       1,
       u.*
FROM   user_rating u
WHERE  NOT EXISTS (SELECT *
                   FROM   stage_user_rating r
                   WHERE  u.user_id = r.user_id
                          AND u.title_id = r.title_id
                          AND u.score = r.score);

INSERT INTO stage_user_rating
SELECT stage_user_rating_seq.NEXTVAL,
       2,
       u.user_id,
       u.title_id,
       u.score / 10,
       u.date_added
FROM   user_rating2 u
WHERE  NOT EXISTS (SELECT *
                   FROM   stage_user_rating r
                   WHERE  u.user_id = r.user_id
                          AND u.title_id = r.title_id
                          AND u.score = r.score);

SELECT *
FROM   stage_user_rating;

INSERT INTO country_stage
SELECT country_seq.NEXTVAL,
       1,
       country_of_residence
FROM   (SELECT DISTINCT country_of_residence
        FROM   users)
WHERE  country_of_residence NOT IN (SELECT country_name
                                    FROM   country_stage);

INSERT INTO country_stage
SELECT country_seq.NEXTVAL,
       2,
       country_of_residence
FROM   (SELECT DISTINCT country_of_residence
        FROM   users2)
WHERE  country_of_residence NOT IN (SELECT country_name
                                    FROM   country_stage);

SELECT *
FROM   country_stage;

INSERT INTO age_stage
SELECT age_seq.NEXTVAL,
       age
FROM   (SELECT DISTINCT Trunc(
       ( To_number(To_char(r.date_added, 'yyyymmdd'))
         - To_number(
               To_char(u.date_of_birth, 'yyyymmdd')) ) / 10000)
       AS age
        FROM   stage_user u,
               stage_user_rating r
        WHERE  u.id = r.user_id
               AND u.databasesource = r.dbsource)
WHERE  age NOT IN (SELECT age
                   FROM   age_stage);

SELECT *
FROM   stage_date_added;

INSERT INTO stage_date_added
SELECT date_added_seq.NEXTVAL,
       ( To_char(date_added, 'mmyyyy') )
FROM  (SELECT DISTINCT r.date_added
       FROM   stage_user_rating r)
WHERE  ( To_char(date_added, 'mmyyyy') ) NOT IN(SELECT monthyear
                                                FROM   stage_date_added);

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
FROM   stage_user_rating s
WHERE  NOT EXISTS (SELECT *
                   FROM   fact_stage f
                   WHERE  f.user_id = s.user_id
                          AND f.title_id = s. title_id
                          AND f.score = s.score
                          AND f.date_added = s.date_added
                          AND f.sourcedb = s.dbsource);

UPDATE fact_stage
SET    title_sk = (SELECT DISTINCT stage_title.sk
                   FROM   stage_title
                   WHERE ( stage_title.title_id = fact_stage.title_id
                           AND stage_title.databasesource = fact_stage.sourcedb
                         ));

UPDATE fact_stage f
SET    age = (SELECT DISTINCT Trunc((
                                           To_number(
                                           To_char(f.date_added, 'yyyymmdd'))
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
SET    user_sk = (SELECT DISTINCT stage_user.sk
                  FROM   stage_user
                  WHERE  ( stage_user.id = fact_stage.user_id
                           AND stage_user.databasesource = fact_stage.sourcedb )
                 );

SELECT *
FROM   country_stage;

commit;


                     
UPDATE fact_stage
SET    date_added_sk = (SELECT date_added_sk
                        FROM   stage_date_added
                        WHERE  stage_date_added.monthyear =
                               ( To_char(fact_stage.date_added, 'mmyyyy') ));
UPDATE fact_stage
SET    country = (SELECT country_of_residence
                  FROM   stage_user
                  WHERE  fact_stage.user_sk = stage_user.sk);
                               
UPDATE fact_stage
SET    country_sk = (SELECT country_sk
                     FROM   country_stage
                     WHERE  fact_stage.country = country_stage.country_name);

SELECT *
FROM   stage_date_added;

SELECT *
FROM   fact_stage
ORDER  BY score,
          user_sk;

-- Update Dimension Tables
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
FROM   stage_user
WHERE  sk NOT IN (SELECT sk
                  FROM   dim_user);

SELECT *
FROM   dim_user;

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
FROM   stage_title
WHERE  sk NOT IN (SELECT sk
                  FROM   dim_title);

SELECT *
FROM   dim_title;

INSERT INTO dim_country
SELECT country_sk,
       country_name
FROM   country_stage
WHERE  country_sk NOT IN (SELECT country_sk
                          FROM   dim_country);

SELECT *
FROM   dim_country;

INSERT INTO dim_age
SELECT age_sk,
       age
FROM   age_stage
WHERE  age_sk NOT IN (SELECT age_sk
                      FROM   dim_age);
  

SELECT *
FROM   dim_age;

INSERT INTO dim_date_added
SELECT date_added_sk,
       monthyear
FROM   stage_date_added where date_added_sk not in (select date_added_sk from dim_date_added);                     

commit;
select * from dim_date_added;

INSERT INTO fact_table
SELECT user_sk,
       title_sk,
       age_sk,
       country_sk,
       date_added_sk,
       score
FROM   fact_stage s
WHERE  NOT EXISTS (SELECT user_sk,
                          title_sk,
                          age_sk,
                          country_sk,
                          date_added_sk,
                          score
                   FROM   fact_table t
                   WHERE  s.user_sk = t.user_sk
                          AND s.title_sk = t.title_sk
                          AND t.age_sk = s.age_sk
                          AND t.country_sk = s.country_sk
                          AND t.date_added_sk = s.date_added_sk
                          AND t.score = s.score);

commit;

SELECT *
FROM   fact_table
ORDER  BY score,
          user_sk; 
select * from fact_stage;

--Sample Queies--
--select average score of users aged 18-25
SELECT cast(SUM(score) / Count(*) as number(4,2)) average
FROM   fact_table f,
       dim_age a
WHERE  a.age <= 25
       AND a.age >= 18
       AND f.age_sk = a.age_sk; 
       
-- Queries by month
select count(*), d.monthyear from fact_table u , dim_date_added d
where d.date_added_sk = u.date_added_sk
group by d.monthyear ;

       

          
          
