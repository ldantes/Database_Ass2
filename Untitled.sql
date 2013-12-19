-- Dimensional model --
DROP
  SEQUENCE STAGEuser_SEQ;
CREATE SEQUENCE STAGEuser_SEQ MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1
  START WITH 1 CACHE 20 ;
  DROP
    SEQUENCE STAGETITLE_SEQ ;
CREATE SEQUENCE STAGETITLE_SEQ MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1
  START WITH 1 CACHE 20 ;
  DROP
    TABLE Stage_User;
  CREATE
    TABLE Stage_User
    (
      sk   NUMBER PRIMARY KEY,
      databaseSource INTEGER,
      id             NUMBER(10),
      public_id      VARCHAR(24),
      Password       VARCHAR(64) NOT NULL,
      Date_Joined DATE NOT NULL,
      email_address VARCHAR2(62) NOT NULL ,
      First_Name    VARCHAR2(32)NOT NULL,
      Surname       VARCHAR2(32) NOT NULL,
      Gender        CHAR NOT NULL CHECK (Gender IN ('M','F','m','f')),
      Date_of_birth DATE NOT NULL ,
      ZIP VARCHAR(5) NOT NULL,
      -- Country_of_Residence varchar2(50) not null  ,
      Security_Question VARCHAR(32),
      Security_Answer   VARCHAR(32),
      Title_rated_id    NUMBER(10),
      score             NUMBER(4,2),
      date_of_rating DATE
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
    u.security_question,
    u.security_answer,
    r.title_id,
    r.score,
    r.date_added
  FROM
    users u ,
    user_rating r
  WHERE
    u.id = r.user_id;
    
    
    
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
    u.gender,
    u.date_of_birth,
    u.zip,
    u.security_question,
    u.security_answer,
    r.title_id,
    r.score,
    r.date_added
  FROM
    users2 u ,
    user_rating2 r
  WHERE
    u.id = r.user_id;   
    
    
select * from Stage_User;


   drop TABLE Stage_Title;
  CREATE
    TABLE Stage_Title
    (
      sk   NUMBER PRIMARY KEY,
      databaseSource INTEGER,
      title_Id       NUMBER(10) ,
      title_Name     VARCHAR(50),
      Rating         DECIMAL(3,1) CHECK (rating <= 10.00),
      Type           VARCHAR2(20),
      Certificate    VARCHAR(5) ,
      Duration       NUMBER(3),
      Introduction   VARCHAR2(200),
      Storyline      VARCHAR2(500),
      Release_Date DATE,
      Genre      VARCHAR(20),
      Category   VARCHAR(20) ,
      celeb_Id   NUMBER(10) ,
      celeb_Name VARCHAR(50) ,
      Date_of_Birth DATE ,
      Height         NUMBER(4,2),
      star_sign      VARCHAR(15),
      Gender         VARCHAR2(1),
      character_Id   NUMBER(10),
      Character_Name VARCHAR(50),
      Biography      VARCHAR(200)
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
    t.release_date,
    g.genre,
    cat.category,
    c.id,
    c.name,
    c.date_of_birth,
    c.height,
    c.star_sign,
    c.gender,
    cha.id ,
    cha.character_name ,
    cha.biography
  FROM
    Title t,
    involvement i,
    celebrity c,
    character_appearences ca,
    genre g,
    title_genre tg,
    category cat,
    CHARACTERs cha
  WHERE
    t.id              = i.title_id
  AND i.category      = cat.category
  AND t.id            = tg.title_id
  AND tg.genre        = g.genre
  AND i.celebrity_id  = c.id
  AND ca.character_id = cha.id
  AND ca.celebrity_id = c.id;
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
    t.release_date,
    g.genre,
    cat.category,
    c.id,
    c.name,
    c.date_of_birth,
    c.height,
    c.star_sign,
    CAST(TO_CHAR(c.gender) AS VARCHAR2(1)),
    cha.id ,
    cha.character_name ,
    cha.biography
  FROM
    Title2 t,
    involvement2 i,
    celebrity2 c,
    character_appearences2 ca,
    genre2 g,
    title_genre2 tg,
    category2 cat,
    CHARACTERs2 cha
  WHERE
    t.id              = i.title_id
  AND i.category      = cat.category
  AND t.id            = tg.title_id
  AND tg.genre        = g.genre
  AND i.celebrity_id  = c.id
  AND ca.character_id = cha.id
  AND ca.celebrity_id = c.id
  AND ca.title_id     = t.id;
  UPDATE
    Stage_Title
  SET
    gender='F'
  WHERE
    gender='0';
  UPDATE
    Stage_Title
  SET
    gender='M'
  WHERE
    gender='1';
  UPDATE
    Stage_Title
  SET
    gender='F'
  WHERE
    gender='f';
  UPDATE
    Stage_Title
  SET
    gender='M'
  WHERE
    gender='m';
  SELECT
    *
  FROM
    Stage_Title;
  
  
drop sequence country_seq;    
create sequence country_seq MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1
  START WITH 1 CACHE 20 ;  
drop table country_stage;
Create table country_stage(
country_sk NUMBER PRIMARY KEY,
sourceDB integer,
country_name varchar2(50)
);

insert into country_stage select country_seq.nextval,1,country_of_residence from (select distinct country_of_residence from users);
insert into country_stage select country_seq.nextval,2,country_of_residence from (select distinct country_of_residence from users2 where country_of_residence not in (select country_name from country_stage))  ;

select * from country_stage;


drop sequence age_seq;    
create sequence age_seq MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1
  START WITH 1 CACHE 20 ;  
drop table age_stage;
Create table age_stage(
age_sk NUMBER PRIMARY KEY,
age number(3)
);

select * from age_stage;
insert into age_stage 
select age_seq.nextval , age
from (select distinct trunc((to_number(to_char(date_of_rating,'yyyymmdd'))
      -to_number(to_char(date_of_birth,'yyyymmdd'))
      )/10000) as age from stage_user);
       
drop table fact_stage;       
Create table fact_stage(
user_sk integer,
title_sk integer,
age_sk integer,
country_sk integer,
user_id integer,
title_id integer,
score number(4,2),
sourcedb integer
);

insert into fact_stage(user_id,title_id,score, sourcedb) select user_id , title_id , score ,1 from user_rating;
insert into fact_stage(user_id,title_id,score, sourcedb) select user_id , title_id , score ,2 from user_rating2;

update fact_stage set user_sk = (select stage_user.sk from stage_user where (stage_user.id = fact_stage.user_id and stage_user.title_rated_id = fact_stage.title_id and stage_user.databasesource = fact_stage.sourcedb));

update fact_stage set title_sk = 

--update fact_stage set age_sk = (select age_sk from age_stage where age = (select distinct trunc((to_number(to_char(date_of_rating,'yyyymmdd'))
--      -to_number(to_char(date_of_birth,'yyyymmdd'))
--      )/10000) as age from stage_user)) where ;

--update fact_stage set user_sk = (select sk from stage_user) where user_id = (select id from stage_user) and title_id=1 ;
--(select distinct su.id from stage_user su, fact_stage fs where fs.title_id = su.title_rated_id and su.id = fs.user_id and su.databasesource = fs.sourcedb and fs.sourcedb =1  );
----update fact_stage set user_sk = (select su.sk from stage_user su) where (select su.sk from stage_user su) in
---- (select su.sk from stage_user su, fact_stage fs where fs.title_id = su.title_rated_id and su.id = fs.user_id and su.databasesource = fs.sourcedb and fs.sourcedb =1  )
---- and  user_id  = (select user_id from fact_stage);

select * from fact_stage;
select * from stage_user;