-- Dimensional model --
drop SEQUENCE STAGEuser_SEQ;
CREATE SEQUENCE STAGEuser_SEQ MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

drop SEQUENCE STAGETITLE_SEQ ; 
CREATE SEQUENCE STAGETITLE_SEQ MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;  

drop TABLE Stage_User;
CREATE TABLE Stage_User
(
  surrogateKey number PRIMARY KEY,
  databaseSource integer,
  id number(10),
  public_id varchar(24) unique,
  Password varchar(64) not null,
  Date_Joined date not null,
  email_address varchar2(62) not null ,
  First_Name varchar2(32)not null,
  Surname varchar2(32) not null,
  Gender char not null check (Gender in ('M','F','m','f')),
  Date_of_birth date not null ,
  ZIP varchar(5) not null,
  Country_of_Residence varchar2(50) not null  ,
  Security_Question varchar(32),
  Security_Answer varchar(32)
  
);
insert into Stage_User select STAGEuser_SEQ.nextval,1, u.* from users u;
insert into Stage_User select STAGEuser_SEQ.nextval,2, u.* from users2 u;



drop TABLE Stage_Title;
CREATE TABLE Stage_Title
(

  surrogateKey number PRIMARY KEY,
  databaseSource integer,
  title_Id number(10) ,
  title_Name varchar(50),
  Rating decimal(3,1) check (rating <= 10.00),
  Type varchar2(20),
  Certificate varchar(5) ,
  Duration number(3),
  Introduction varchar2(200),
  Storyline varchar2(500),
  Release_Date date,
  Genre varchar(20),
  Category varchar(20) ,
  celeb_Id number(10) ,
  celeb_Name varchar(50) ,
  Date_of_Birth date ,
  Height  number(4,2),
  star_sign varchar(15),
  Gender varchar2(1),
  character_Id number(10),
  Character_Name varchar(50),
  Biography varchar(200)
  
  );
  
  INSERT
INTO
  Stage_Title
SELECT
  STAGETITLE_SEQ.nextval,
  1,
  t.id , t.name , t.rating, t.type, t.certificate, t.duration,t.introduction, t.storyline, t.release_date,
  g.genre,
  cat.category,
  c.id,c.name,c.date_of_birth,c.height,c.star_sign,c.gender,
  cha.id , cha.character_name , cha.biography
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
  t.id         = i.title_id
AND i.category = cat.category
AND t.id       = tg.title_id
AND tg.genre   = g.genre
and i.celebrity_id = c.id
and ca.character_id = cha.id
and ca.celebrity_id = c.id;


 INSERT
INTO
  Stage_Title
SELECT
  STAGETITLE_SEQ.nextval,
  1,
  t.id , t.name , t.rating, t.type, t.certificate, t.duration,t.introduction, t.storyline, t.release_date,
  g.genre,
  cat.category,
  c.id,c.name,c.date_of_birth,c.height,c.star_sign,cast(to_char(c.gender) as varchar2(1)),
  cha.id , cha.character_name , cha.biography
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
  t.id         = i.title_id
AND i.category = cat.category
AND t.id       = tg.title_id
AND tg.genre   = g.genre
and i.celebrity_id = c.id
and ca.character_id = cha.id
and ca.celebrity_id = c.id;

update Stage_Title set gender='F' where gender='0';
update Stage_Title set gender='M' where gender='1';
update Stage_Title set gender='F' where gender='f';
update Stage_Title set gender='M' where gender='m';

select * from Stage_Title;
