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