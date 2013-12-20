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
commit;
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
SET    country = (SELECT country_of_residence
                  FROM   stage_user
                  WHERE  fact_stage.user_sk = stage_user.sk);

UPDATE fact_stage
SET    date_added_sk = (SELECT date_added_sk
                        FROM   stage_date_added
                        WHERE  stage_date_added.monthyear =
                               ( To_char(fact_stage.date_added, 'mmyyyy') ));

SELECT *
FROM   stage_date_added;
commit;
UPDATE fact_stage
SET    user_sk = (SELECT DISTINCT stage_user.sk
                  FROM   stage_user
                  WHERE  ( stage_user.id = fact_stage.user_id
                           AND stage_user.databasesource = fact_stage.sourcedb )
                 );

SELECT *
FROM   country_stage;

UPDATE fact_stage
SET    country_sk = (SELECT country_sk
                     FROM   country_stage
                     WHERE  fact_stage.country = country_stage.country_name);

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

SELECT *
FROM   fact_table
ORDER  BY score,
          user_sk; 
commit;