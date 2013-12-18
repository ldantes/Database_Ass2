DROP TABLE Title_Genre_staging;
DROP TABLE Genre_staging;
DROP TABLE Character_appearences_staging;
DROP TABLE Character_staging;
DROP TABLE User_Rating_staging;
DROP TABLE Review_staging;
DROP TABLE Users_staging;
DROP TABLE Involvement_staging;
DROP TABLE Title_staging;
DROP TABLE Category_staging;
DROP TABLE Celebrity_staging;

drop  SEQUENCE STAGETITLE_SEQ;
drop SEQUENCE STAGEChar_SEQ;
drop SEQUENCE STAGECeleb_SEQ;
drop SEQUENCE STAGEuser_SEQ;
CREATE SEQUENCE STAGETITLE_SEQ MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;
CREATE SEQUENCE STAGEChar_SEQ MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;
CREATE SEQUENCE STAGECeleb_SEQ MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;
CREATE SEQUENCE STAGEuser_SEQ MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;





CREATE TABLE Celebrity_staging
(
  surrogateKey number PRIMARY KEY,
  databaseSource integer,
  Id number(10) ,
  Name varchar(50) not null,
  Date_of_Birth date not null,
  Height  number(4,2),
  star_sign varchar(15),
  Gender varchar2(1)
  
);
  drop index celeb_index_staging;
    CREATE INDEX celeb_index_staging
ON Celebrity_staging (name);

insert into Celebrity_staging select STAGECeleb_SEQ.nextval, 1,c.* from celebrity c;
insert into Celebrity_staging select STAGECeleb_SEQ.nextval, 2, c.Id, c.Name, c.Date_of_Birth ,c.Height * 3.28, c.star_sign, cast(to_char(c.gender) as varchar2(1)) from celebrity2 c;

update Celebrity_staging set gender='F' where gender='0';
update Celebrity_staging set gender='M' where gender='1';

select * from Celebrity_staging;

drop sequence Category_staging_SEQ;
CREATE SEQUENCE Category_staging_SEQ MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;
  
CREATE TABLE Category_staging
(
   surrogateKey number PRIMARY KEY,
   databaseSource integer,
   Category varchar(20) 
);
insert into Category_staging select Category_staging_SEQ.nextval, 1,c.category from Category c;
insert into Category_staging select Category_staging_SEQ.nextval, 2,c.category from Category2 c;


CREATE TABLE Title_staging
(
  surrogateKey number PRIMARY KEY,
  databaseSource integer,
  Id number(10) ,
  Name varchar(50) not null,
  Rating decimal(3,1) check (rating <= 10.00),
  Type varchar2(20) not null check (Type in ('TV Series','Tv Eisode','TV Mini-Series','Video', 'Short','Film','Tv Movie', 'Video Game' )),
  Certificate varchar(5) ,
  Duration number(3),
  Introduction varchar2(200),
  Storyline varchar2(500),
  Release_Date date
  
  );
  drop index Title_staging_index;
    CREATE INDEX Title_staging_index
ON Title_staging (name);
  
 insert into Title_staging select STAGETITLE_SEQ.nextval, 1, id,name,rating,type,certificate,duration,introduction,storyline,release_date from Title;
 insert into Title_staging select STAGETITLE_SEQ.nextval, 2, id,name,rating,type,certificate,duration,introduction,storyline,release_date from Title2;

--drop SEQUENCE Involvement_staging_SEQ;
--CREATE SEQUENCE Involvement_staging_SEQ MINVALUE 1 MAXVALUE
--  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ; 
--CREATE TABLE Involvement_staging
--(
--  surrogateKey number PRIMARY KEY,
--  databaseSource integer,
--  Celebrity_staging_Id number(10) ,
--  Title_staging_Id number(10),
--  Category integer,
-- CONSTRAINT Inv_Celeb_stageId FOREIGN KEY (Celebrity_staging_Id)
--        REFERENCES Celebrity_staging(surrogateKey),
--  CONSTRAINT Inv_Title_staging_Id FOREIGN KEY (Title_staging_Id)
--        REFERENCES Title_staging(surrogateKey),
--  CONSTRAINT Inv_Category_staging FOREIGN KEY (Category)
--        REFERENCES Category_staging(surrogateKey)
--);
--
--insert into Involvement_staging select Involvement_staging_SEQ.nextval,1, i.* from involvement i;


CREATE TABLE Users_staging
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

insert into Users_staging select STAGEuser_SEQ.nextval,1, u.* from users u;
insert into Users_staging select STAGEuser_SEQ.nextval,2, u.* from users2 u;

select * from Users_staging;

--CREATE TABLE Review_staging
--(
--  surrogateKey number PRIMARY KEY,
--  databaseSource integer,
--  User_Id number(10),
--  Title_staging_Id number(10),
--  Score number(1),
--  Review_staging varchar(500),
--  
--   CONSTRAINT Rev_User_stageId FOREIGN KEY (User_Id)
--        REFERENCES Users_staging(surrogateKey),
--   CONSTRAINT Rev_Title_staging_Id FOREIGN KEY (Title_staging_Id)
--        REFERENCES Title_staging(surrogateKey)
--);
--drop index Rev_Title_staging_index;
--    CREATE INDEX Rev_Title_staging_index
--ON Review_staging (Title_staging_Id);
--
--drop index Rev_user_index;
--    CREATE INDEX Rev_user_stageindex
--ON Review_staging (User_Id);

--CREATE TABLE User_Rating_staging
--(
--  surrogateKey number PRIMARY KEY,
--  databaseSource integer,
--  User_Id number(10),
--  Title_staging_Id number(10),
--  Score number(2) check (Score <= 10),
--  date_added date,
-- 
--   CONSTRAINT UR_User_stageId FOREIGN KEY (User_Id)
--        REFERENCES Users_staging(surrogateKey),
--   CONSTRAINT UR_Title_staging_Id FOREIGN KEY (Title_staging_Id)
--        REFERENCES Title_staging(surrogateKey)
--);

CREATE TABLE Character_staging
(
  surrogateKey number PRIMARY KEY,
  databaseSource integer,
  Id number(10),
  Character_Name varchar(50)  NOT NULL,
  Biography varchar(200)
 
);
drop index char_stageindex;
    CREATE INDEX char_stageindex
ON Character_staging (Character_Name);

insert into Character_staging select STAGEChar_SEQ.nextval, 1, c.* from characters c;
insert into Character_staging select STAGEChar_SEQ.nextval, 2, c.* from characters2 c;

select * from Character_staging;

--CREATE TABLE Character_appearences_staging
--(
--  surrogateKey number PRIMARY KEY,
--  databaseSource integer,
--  Character_id  number(10),
--  Title_staging_Id number(10),
--  Celebrity_staging_Id number(10),
-- 
--  
--   CONSTRAINT Appear_Char_stageId FOREIGN KEY (Character_Id)
--        REFERENCES Character_staging(surrogateKey),
--   CONSTRAINT Appear_Celeb_stageId FOREIGN KEY (Celebrity_staging_Id)
--        REFERENCES Celebrity_staging(surrogateKey),
--   CONSTRAINT appear_Title_staging_Id FOREIGN KEY (Title_staging_Id)
--        REFERENCES Title_staging(surrogateKey)
--  
--);

drop index CA_Title_staging_index;
    CREATE INDEX CA_Title_staging_index
ON Character_appearences_staging (Title_staging_Id);

drop index CA_celeb_stageindex;
    CREATE INDEX CA_celeb_stageindex
ON Character_appearences_staging (Celebrity_staging_Id);

drop index CA_char_stageindex;
    CREATE INDEX CA_char_stageindex
ON Character_appearences_staging (Character_id);

CREATE TABLE Genre_staging
(
--  surrogateKey number PRIMARY KEY,
--  databaseSource integer,
  Genre varchar(20)
  
);
insert into Genre_staging select genre from genre;
insert into Genre_staging select genre from genre2;

select * from genre_staging;

--CREATE TABLE Title_Genre_staging
--(
--  surrogateKey number PRIMARY KEY,
--  databaseSource integer,
--  Title_staging_Id number(10),
--  Genre_staging integer,
-- 
--   CONSTRAINT Title_Genre_staging FOREIGN KEY (Genre_staging)
--        REFERENCES Genre_staging(surrogateKey),
--   CONSTRAINT Genre_Title_staging FOREIGN KEY (Title_staging_Id)
--        REFERENCES Title_staging(surrogateKey)
--  
--);