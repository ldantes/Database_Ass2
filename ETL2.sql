-- ETL 2 and beyond--
-- inset new values into original DBs and update staging tables
insert into Title values
(
  title_seq.nextval,
  'Bronson',
  null,
  'Film',
  'R' ,
  92,
  'A young man who was sentenced to 7 years in prison for robbing a post office ends up spending 30 years in solitary confinement.',
  'In 1974, a hot-headed 19 year old named Michael Peterson decided he wanted to make a name for himself and so, with a homemade sawn-off shotgun and a head full of dreams he attempted to rob a post office.',
  '13-MAR-2009'
  
  );
  
     insert into Title2 values
(
  title_seq.nextval,
  'Mesrine',
  null,
  'Film',
  'R' ,
  133,
  'The story of notorious French gangster Jacques Mesrine.',
  'The story of Jacques Mesrine, France''s public enemy No. 1 during the 1970s. After nearly two decades of legendary criminal feats.',
  '28-AUG-2009'
  
  );  


INSERT INTO  Stage_Title
SELECT STAGETITLE_SEQ.nextval, 1,  t.id ,  t.name , t.rating, t.type,  t.certificate, t.duration, t.introduction, t.storyline, t.release_date
 FROM Title t where t.id not in (select title_id from Stage_title where databaseSource =1); 
 
INSERT INTO  Stage_Title
SELECT STAGETITLE_SEQ.nextval, 2,  t.id ,  t.name , t.rating, t.type,  t.certificate, t.duration, t.introduction, t.storyline, t.release_date
 FROM Title2 t where t.id not in (select title_id from Stage_title where databaseSource =2);  

select * from Stage_Title;

INSERT
INTO
  users VALUES
  (
     user_seq.nextval,
    'kitty',
    '**********',
    sysdate,
    'kiddy67@imdb.com',
    'Kit',
    'Walker',
    'F',
    '9-SEP-1967',
    'xxxx',
    'America',
    'First pets name',
    'Woofi'
  );
  
INSERT
INTO
  users2 VALUES
  (
     user_seq.nextval,
    'sally',
    '**********',
    sysdate,
    'sally@imdb.com',
    'sally',
    'Walker',
    0,
    '9-SEP-1967',
    'xxxx',
    'Germany',
    'First pets name',
    'Woofi'
  );  

INSERT INTO Stage_User
SELECT STAGEuser_SEQ.nextval, 1, u.id ,u.public_id ,u.password ,u.date_joined , u.email_address , u.first_name, u.surname, u.gender,  u.date_of_birth, u.zip, u.Country_of_Residence,  u.security_question,  u.security_answer
FROM users u where u.id not in (select id from Stage_user where databaseSource =1);

INSERT INTO Stage_User
SELECT STAGEuser_SEQ.nextval, 1, u.id ,u.public_id ,u.password ,u.date_joined , u.email_address , u.first_name, u.surname, u.gender,  u.date_of_birth, u.zip, u.Country_of_Residence,  u.security_question,  u.security_answer
FROM users u where u.id not in (select id from Stage_user where databaseSource =2);

select * from stage_user;

insert into user_rating values (1,3,9,sysdate);
insert into user_rating values (2,3,8,sysdate);
insert into user_rating2 values (3,4,9,sysdate);
insert into user_rating2 values (2,4,10,sysdate);
insert into user_rating values (4,3,10,sysdate);

INSERT INTO Stage_User_Rating SELECT Stage_User_Rating_SEQ.nextval,  1,  u.* FROM  user_rating u where not exists (select * from stage_user_rating r where u.user_id = r.user_id and u.Title_id = r.Title_id and u.score= r.score);
INSERT INTO Stage_User_Rating SELECT Stage_User_Rating_SEQ.nextval,  2,  u.* FROM  user_rating2 u where not exists (select * from stage_user_rating r where u.user_id = r.user_id and u.Title_id = r.Title_id and u.score= r.score);

select * from Stage_User_Rating;

insert INTO country_stage SELECT country_seq.nextval,  1, country_of_residence  FROM  (select distinct country_of_residence from users) where country_of_residence not in (select country_name from country_stage);
insert INTO country_stage SELECT country_seq.nextval,  2, country_of_residence  FROM  (select distinct country_of_residence from users2) where country_of_residence not in (select country_name from country_stage);

select * from country_stage;

INSERT INTO age_stage SELECT  age_seq.nextval ,  age 
FROM (  SELECT DISTINCT TRUNC((to_number(TO_CHAR(r.date_added,'yyyymmdd')) -to_number(TO_CHAR( u.date_of_birth,'yyyymmdd')))/10000) AS age
         FROM
        stage_user u ,
        stage_user_rating r
      WHERE
        u.id               = r.user_id
      AND u.databasesource = r.dbsource
    ) where age not in (select age from age_stage);
    
    
-- Update Dimension Tables

insert into Dim_User select sk, public_id,Password, Date_Joined,email_address,  First_name, surname, gender ,
Date_of_birth, ZIP , Country_of_Residence , Security_Question ,Security_Answer 
from stage_user 
where sk not in (select sk from dim_user);

select * from dim_user ;

insert into dim_title select sk, title_name, rating, type, 
certificate, duration ,introduction, storyline, release_date 
from Stage_Title where sk 
not in (select sk from dim_title);

select * from dim_title ; 

insert into dim_country select country_sk, country_name from country_stage
where country_sk not in (select country_sk from dim_country);
select * from dim_country ;

insert into dim_age select age_sk, age from age_stage
where age_sk not in (select age_sk from dim_age);


    
   


