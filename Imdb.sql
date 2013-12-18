
DROP TABLE Title_Genre;
DROP TABLE Genre;
DROP TABLE Character_appearences;
DROP TABLE Characters;
DROP TABLE User_Rating;
DROP TABLE Review;
DROP TABLE Users;
DROP TABLE Involvement;
DROP TABLE Title;
DROP TABLE Category;
DROP TABLE Celebrity;
DROP TABLE Title_Genre2;
DROP TABLE Genre2;
DROP TABLE Character_appearences2;
DROP TABLE Characters2;
DROP TABLE User_Rating2;
DROP TABLE Review2;
DROP TABLE Users2;
DROP TABLE Involvement2;
DROP TABLE Title2;
DROP TABLE Category2;
DROP TABLE Celebrity2;

CREATE TABLE Celebrity
(
  Id number(10) PRIMARY KEY,
  Name varchar(50) not null,
  Date_of_Birth date not null,
  Height  number(4,2),
  star_sign varchar(15),
  Gender char not null check (Gender in ('M','F','m','f'))
);
  drop index celeb_index;
    CREATE INDEX celeb_index
ON Celebrity (name);

CREATE TABLE Category
(
   Category varchar(20) primary key
);

CREATE TABLE Title
(
  Id number(10) PRIMARY KEY,
  Name varchar(50) not null,
  Rating decimal(3,1) check (rating <= 10.00),
  Type varchar2(20) not null check (Type in ('TV Series','Tv Eisode','TV Mini-Series','Video', 'Short','Film','Tv Movie', 'Video Game' )),
  Certificate varchar(5) ,
  Duration number(3),
  Introduction varchar2(200),
  Storyline varchar2(500),
  Release_Date date
  
  );
  drop index title_index;
    CREATE INDEX title_index
ON title (name);
  
CREATE TABLE Involvement
(
  Celebrity_Id number(10) ,
  Title_Id number(10),
  Category varchar(30),
  
  primary key (celebrity_id, title_id, category),
  CONSTRAINT Inv_Celeb_Id FOREIGN KEY (Celebrity_Id)
        REFERENCES celebrity(id),
  CONSTRAINT Inv_Title_Id FOREIGN KEY (Title_Id)
        REFERENCES title(id),
  CONSTRAINT Inv_Category FOREIGN KEY (Category)
        REFERENCES category(category)
);



CREATE TABLE Users
(
  id number(10) primary key,
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

CREATE TABLE Review
(
  User_Id number(10),
  Title_Id number(10),
  Score number(1),
  Review varchar(500),
  primary key(user_id,title_Id),
   CONSTRAINT Rev_User_Id FOREIGN KEY (User_Id)
        REFERENCES users(id),
   CONSTRAINT Rev_Title_Id FOREIGN KEY (Title_Id)
        REFERENCES Title(id)
);
drop index Rev_title_index;
    CREATE INDEX Rev_title_index
ON review (Title_Id);

drop index Rev_user_index;
    CREATE INDEX Rev_user_index
ON review (User_Id);

CREATE TABLE User_Rating
(
  User_Id number(10),
  Title_Id number(10),
  Score number(2) check (Score <= 10),
  date_added date,
  primary key(user_id,title_Id),  
   CONSTRAINT UR_User_Id FOREIGN KEY (User_Id)
        REFERENCES users(id),
   CONSTRAINT UR_Title_Id FOREIGN KEY (Title_Id)
        REFERENCES Title(id)
);

CREATE TABLE Characters
(
  Id number(10),
  Character_Name varchar(50)  NOT NULL,
  Biography varchar(200),
  PRIMARY KEY (Id)
);
drop index char_index;
    CREATE INDEX char_index
ON Characters (Character_Name);

CREATE TABLE Character_appearences
(
  Character_id  number(10),
  Title_Id number(10),
  Celebrity_Id number(10),
  PRIMARY KEY (character_Id,Title_id),
  
   CONSTRAINT Appear_Char_Id FOREIGN KEY (Character_Id)
        REFERENCES Characters(id),
   CONSTRAINT Appear_Celeb_Id FOREIGN KEY (Celebrity_Id)
        REFERENCES celebrity(id),
   CONSTRAINT appear_Title_Id FOREIGN KEY (Title_Id)
        REFERENCES Title(id)
  
);

drop index CA_title_index;
    CREATE INDEX CA_title_index
ON Character_appearences (Title_Id);

drop index CA_celeb_index;
    CREATE INDEX CA_celeb_index
ON Character_appearences (Celebrity_Id);

drop index CA_char_index;
    CREATE INDEX CA_char_index
ON Character_appearences (Character_id);

CREATE TABLE Genre
(
  Genre varchar(20) primary key
  
);

CREATE TABLE Title_Genre
(
  Title_Id number(10),
  Genre varchar(20),
  primary key (title_id, genre),
   CONSTRAINT Title_Genre FOREIGN KEY (Genre)
        REFERENCES Genre(Genre),
   CONSTRAINT Genre_Title FOREIGN KEY (Title_Id)
        REFERENCES Title(id)
  
);


CREATE TABLE Celebrity2
(
  Id number(10) PRIMARY KEY,
  Name varchar(50) not null,
  Date_of_Birth date not null,
  Height  number(4,2),
  star_sign varchar(15),
  gender integer
);
  drop index celeb_index2;
    CREATE INDEX celeb_index2
ON Celebrity2 (name);

CREATE TABLE Category2
(
   Category varchar(20) primary key
);

CREATE TABLE Title2
(
  Id number(10) PRIMARY KEY,
  Name varchar(50) not null,
  Rating decimal(3,1) check (rating <= 10.00),
  Type varchar2(20) not null check (Type in ('TV Series','Tv Eisode','TV Mini-Series','Video', 'Short','Film','Tv Movie', 'Video Game' )),
  Certificate varchar(5) ,
  Duration number(3),
  Introduction varchar2(200),
  Storyline varchar2(500),
  Release_Date date
  
  );
  drop index title_index2;
    CREATE INDEX title_index2
ON title2 (name);
  
CREATE TABLE Involvement2
(
  Celebrity_Id number(10) ,
  Title_Id number(10),
  Category varchar(30),
  
  primary key (celebrity_id, title_id, category),
  CONSTRAINT Inv_Celeb_Id2 FOREIGN KEY (Celebrity_Id)
        REFERENCES celebrity2(id),
  CONSTRAINT Inv_Title_Id2 FOREIGN KEY (Title_Id)
        REFERENCES title2(id),
  CONSTRAINT Inv_Category2 FOREIGN KEY (Category)
        REFERENCES category(category)
);



CREATE TABLE Users2
(
  id number(10) primary key,
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

CREATE TABLE Review2
(
  User_Id number(10),
  Title_Id number(10),
  Score number(1),
  Review varchar(500),
  primary key(user_id,title_Id),
   CONSTRAINT Rev_User_Id2 FOREIGN KEY (User_Id)
        REFERENCES users2(id),
   CONSTRAINT Rev_Title_Id2 FOREIGN KEY (Title_Id)
        REFERENCES Title2(id)
);
drop index Rev_title_index2;
    CREATE INDEX Rev_title_index2
ON review2 (Title_Id);

drop index Rev_user_index2;
    CREATE INDEX Rev_user_index2
ON review2 (User_Id);

CREATE TABLE User_Rating2
(
  User_Id number(10),
  Title_Id number(10),
  Score number(2) check (Score <= 10),
  date_added date,
  primary key(user_id,title_Id),  
   CONSTRAINT UR_User_Id2 FOREIGN KEY (User_Id)
        REFERENCES users2(id),
   CONSTRAINT UR_Title_Id2 FOREIGN KEY (Title_Id)
        REFERENCES Title2(id)
);

CREATE TABLE Characters2
(
  Id number(10),
  Character_Name varchar(50)  NOT NULL,
  Biography varchar(200),
  PRIMARY KEY (Id)
);
drop index char_index2;
    CREATE INDEX char_index2
ON Characters2 (Character_Name);

CREATE TABLE Character_appearences2
(
  Character_id  number(10),
  Title_Id number(10),
  Celebrity_Id number(10),
  PRIMARY KEY (character_Id,Title_id),
  
   CONSTRAINT Appear_Char_Id2 FOREIGN KEY (Character_Id)
        REFERENCES Characters2(id),
   CONSTRAINT Appear_Celeb_Id2 FOREIGN KEY (Celebrity_Id)
        REFERENCES celebrity2(id),
   CONSTRAINT appear_Title_Id2 FOREIGN KEY (Title_Id)
        REFERENCES Title2(id)
  
);

drop index CA_title_index2;
    CREATE INDEX CA_title_index2
ON Character_appearences2 (Title_Id);

drop index CA_celeb_index2;
    CREATE INDEX CA_celeb_index2
ON Character_appearences2 (Celebrity_Id);

drop index CA_char_index2;
    CREATE INDEX CA_char_index2
ON Character_appearences2 (Character_id);

CREATE TABLE Genre2
(
  Genre varchar(20) primary key
  
);

CREATE TABLE Title_Genre2
(
  Title_Id number(10),
  Genre varchar(20),
  primary key (title_id, genre),
   CONSTRAINT Title_Genre2 FOREIGN KEY (Genre)
        REFERENCES Genre2(Genre),
   CONSTRAINT Genre_Title2 FOREIGN KEY (Title_Id)
        REFERENCES Title2(id)
  
);


--create sequences 
drop  SEQUENCE TITLE_SEQ;
drop SEQUENCE Char_SEQ;
drop SEQUENCE Celeb_SEQ;
drop SEQUENCE user_SEQ;
CREATE SEQUENCE TITLE_SEQ MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;
CREATE SEQUENCE Char_SEQ MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;
CREATE SEQUENCE Celeb_SEQ MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;
CREATE SEQUENCE user_SEQ MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;
  
  
--create sequences 
drop  SEQUENCE TITLE_SEQ2;
drop SEQUENCE Char_SEQ2;
drop SEQUENCE Celeb_SEQ2;
drop SEQUENCE user_SEQ2;
CREATE SEQUENCE TITLE_SEQ2 MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;
CREATE SEQUENCE Char_SEQ2 MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;
CREATE SEQUENCE Celeb_SEQ2 MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;
CREATE SEQUENCE user_SEQ2 MINVALUE 1 MAXVALUE
  999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;  