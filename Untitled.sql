-- Staging --
DROP
  SEQUENCE STAGEuser_SEQ;
CREATE SEQUENCE STAGEuser_SEQ MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1
  START WITH 1 CACHE 20 ;
 
  DROP
    TABLE Stage_User;
  CREATE
    TABLE Stage_User
    (
      sk             NUMBER PRIMARY KEY,
      databaseSource INTEGER,
      id             NUMBER(10),
      public_id      VARCHAR(24),
      Password       VARCHAR(64) NOT NULL,
      Date_Joined DATE NOT NULL,
      email_address VARCHAR2(62) NOT NULL ,
      First_Name    VARCHAR2(32)NOT NULL,
      Surname       VARCHAR2(32) NOT NULL,
      Gender        CHAR NOT NULL ,
      Date_of_birth DATE NOT NULL ,
      ZIP                  VARCHAR(5) NOT NULL,
      Country_of_Residence VARCHAR2(50) NOT NULL ,
      Security_Question    VARCHAR(32),
      Security_Answer      VARCHAR(32)
    );
  INSERT
  INTO
    Stage_User
  SELECT
    STAGEuser_SEQ.nextval,
    1,
    u.id ,
    u.public_id ,
    u.password ,
    u.date_joined ,
    u.email_address ,
    u.first_name,
    u.surname,
    u.gender,
    u.date_of_birth,
    u.zip,
    u.Country_of_Residence,
    u.security_question,
    u.security_answer
  FROM
    users u
  WHERE
    u.id NOT IN
    (
      SELECT
        id
      FROM
        Stage_user
      WHERE
        databaseSource =1
    );
  INSERT
  INTO
    Stage_User
  SELECT
    STAGEuser_SEQ.nextval,
    2,
    u.id ,
    u.public_id ,
    u.password ,
    u.date_joined ,
    u.email_address ,
    u.first_name,
    u.surname,
    CAST(TO_CHAR(u.gender) AS CHAR(1)),
    u.date_of_birth,
    u.zip,
    u.Country_of_Residence,
    u.security_question,
    u.security_answer
  FROM
    users2 u
  WHERE
    u.id NOT IN
    (
      SELECT
        id
      FROM
        Stage_user
      WHERE
        databaseSource =2
    ) ;
  SELECT
    *
  FROM
    Stage_User;
  UPDATE
    Stage_User
  SET
    gender='F'
  WHERE
    gender='0';
  UPDATE
    Stage_User
  SET
    gender='M'
  WHERE
    gender='1';
    
    
DROP SEQUENCE STAGETITLE_SEQ ;
CREATE SEQUENCE STAGETITLE_SEQ MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1
  START WITH 1 CACHE 20 ;  
  DROP
    TABLE Stage_Title;
  CREATE
    TABLE Stage_Title
    (
      sk             NUMBER PRIMARY KEY,
      databaseSource INTEGER,
      title_Id       NUMBER(10) ,
      title_Name     VARCHAR(50),
      Rating         DECIMAL(3,1) CHECK (rating <= 10.00),
      Type           VARCHAR2(20),
      Certificate    VARCHAR(5) ,
      Duration       NUMBER(3),
      Introduction   VARCHAR2(200),
      Storyline      VARCHAR2(500),
      Release_Date DATE
    );
  INSERT
  INTO
    Stage_Title
  SELECT
    STAGETITLE_SEQ.nextval,
    1,
    t.id ,
    t.name ,
    t.rating,
    t.type,
    t.certificate,
    t.duration,
    t.introduction,
    t.storyline,
    t.release_date
  FROM
    Title t
  WHERE
    t.id NOT IN
    (
      SELECT
        title_id
      FROM
        Stage_title
      WHERE
        databaseSource =1
    );
  INSERT
  INTO
    Stage_Title
  SELECT
    STAGETITLE_SEQ.nextval,
    2,
    t.id ,
    t.name ,
    t.rating,
    t.type,
    t.certificate,
    t.duration,
    t.introduction,
    t.storyline,
    t.release_date
  FROM
    Title2 t
  WHERE
    t.id NOT IN
    (
      SELECT
        title_id
      FROM
        Stage_title
      WHERE
        databaseSource =2
    );
  DROP
    TABLE Celebrity_staging;
  CREATE
    TABLE Celebrity_staging
    (
      surrogateKey   NUMBER PRIMARY KEY,
      databaseSource INTEGER,
      Id             NUMBER(10) ,
      Name           VARCHAR(50) NOT NULL,
      Date_of_Birth DATE NOT NULL,
      Height    NUMBER(4,2),
      star_sign VARCHAR(15),
      Gender    VARCHAR2(1)
    );
  DROP
    SEQUENCE Stage_User_Rating_SEQ;
CREATE SEQUENCE Stage_User_Rating_SEQ MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1
  START WITH 1 CACHE 20 ;
  DROP
    TABLE Stage_User_Rating;
  CREATE
    TABLE Stage_User_Rating
    (
      sk       INTEGER PRIMARY KEY,
      dbsource INTEGER,
      User_Id  NUMBER(10),
      Title_Id NUMBER(10),
      Score    NUMBER(2) CHECK (Score <= 10),
      date_added DATE
    );
  INSERT
  INTO
    Stage_User_Rating
  SELECT
    Stage_User_Rating_SEQ.nextval,
    1,
    u.*
  FROM
    user_rating u;
  INSERT
  INTO
    Stage_User_Rating
  SELECT
    Stage_User_Rating_SEQ.nextval,
    2,
    u.*
  FROM
    user_rating2 u;


  DROP
    sequence country_seq;
CREATE sequence country_seq MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1
  START WITH 1 CACHE 20 ;
  DROP
    TABLE country_stage;
  CREATE
    TABLE country_stage
    (
      country_sk   NUMBER PRIMARY KEY,
      sourceDB     INTEGER,
      country_name VARCHAR2(50)
    );
  INSERT
  INTO
    country_stage
  SELECT
    country_seq.nextval,
    1,
    country_of_residence
  FROM
    (
      SELECT DISTINCT
        country_of_residence
      FROM
        users
    );
  INSERT
  INTO
    country_stage
  SELECT
    country_seq.nextval,
    2,
    country_of_residence
  FROM
    (
      SELECT DISTINCT
        country_of_residence
      FROM
        users2
      WHERE
        country_of_residence NOT IN
        (
          SELECT
            country_name
          FROM
            country_stage
        )
    ) ;
  SELECT
    *
  FROM
    country_stage;
  DROP
    sequence age_seq;
CREATE sequence age_seq MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 1
  CACHE 20 ;
  DROP
    TABLE age_stage;
  CREATE
    TABLE age_stage
    (
      age_sk NUMBER PRIMARY KEY,
      age    NUMBER(3)
    );
  SELECT
    *
  FROM
    age_stage;
  INSERT
  INTO
    age_stage
  SELECT
    age_seq.nextval ,
    age
  FROM
    (
      SELECT DISTINCT
        TRUNC((to_number(TO_CHAR(r.date_added,'yyyymmdd')) -to_number(TO_CHAR(
        u.date_of_birth,'yyyymmdd')) )                     /10000) AS age
      FROM
        stage_user u ,
        stage_user_rating r
      WHERE
        u.id               = r.user_id
      AND u.databasesource = r.dbsource
    );
  DROP
    sequence date_added_seq;
CREATE sequence date_added_seq MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1
  START WITH 1 CACHE 20 ;
  DROP
    TABLE stage_date_added;
  CREATE
    TABLE stage_date_added
    (
      date_added_sk NUMBER PRIMARY KEY,
      monthyear     VARCHAR(6)
    );
  INSERT
  INTO
    stage_date_added
  SELECT
    date_added_seq.nextval,
    (TO_CHAR(date_added,'mmyyyy'))
  FROM
    (
      SELECT DISTINCT
        r.date_added
      FROM
        Stage_User_Rating r
    );
  SELECT
    *
  FROM
    stage_date_added;
  DROP
    TABLE fact_stage;
  CREATE
    TABLE fact_stage
    (
      user_sk       INTEGER,
      title_sk      INTEGER,
      age_sk        INTEGER,
      country_sk    INTEGER,
      date_added_sk VARCHAR2(6),
      user_id       INTEGER,
      age           INTEGER,
      country       VARCHAR(30),
      date_added DATE,
      title_id INTEGER,
      score    NUMBER(4,2),
      sourcedb INTEGER
    );
  INSERT
  INTO
    fact_stage
    (
      user_id,
      title_id,
      score,
      date_added,
      sourcedb
    )
  SELECT
    user_id ,
    title_id ,
    score ,
    date_added,
    dbsource
  FROM
    stage_user_rating;
  UPDATE
    fact_stage
  SET
    user_sk =
    (
      SELECT
        stage_user.sk
      FROM
        stage_user
      WHERE
        (
          stage_user.id               = fact_stage.user_id
        AND stage_user.databasesource = fact_stage.sourcedb
        )
    );
  UPDATE
    fact_stage
  SET
    title_sk =
    (
      SELECT
        stage_title.sk
      FROM
        stage_title
      WHERE
        (
          stage_title.title_id         = fact_stage.title_id
        AND stage_title.databasesource = fact_stage.sourcedb
        )
    );
  UPDATE
    fact_stage f
  SET
    age =
    (
      SELECT
        TRUNC((to_number(TO_CHAR(f.date_added,'yyyymmdd')) -to_number(TO_CHAR(
        u.date_of_birth,'yyyymmdd')) )                     /10000)
      FROM
        stage_user u
      WHERE
        (
          u.id               = f.user_id
        AND u.databasesource = f.sourcedb
        )
    );
  UPDATE
    fact_stage
  SET
    age_sk =
    (
      SELECT
        age_sk
      FROM
        age_stage
      WHERE
        age_stage.age = fact_stage.age
    );
  UPDATE
    fact_stage
  SET
    country =
    (
      SELECT
        country_of_residence
      FROM
        stage_user
      WHERE
        fact_stage.user_sk = stage_user.sk
    );
  UPDATE
    fact_stage
  SET
    country_sk =
    (
      SELECT
        country_sk
      FROM
        country_stage
      WHERE
        fact_stage.country = country_stage.country_name
    );
  UPDATE
    fact_stage
  SET
    date_added_sk =
    (
      SELECT
        date_added_sk
      FROM
        stage_date_added
      WHERE
        stage_date_added.monthyear = (TO_CHAR(fact_stage.date_added,'mmyyyy'))
    );
  SELECT
    *
  FROM
    fact_stage;
  SELECT
    *
  FROM
    age_stage;
  SELECT
    *
  FROM
    stage_user;
  SELECT
    *
  FROM
    stage_title;