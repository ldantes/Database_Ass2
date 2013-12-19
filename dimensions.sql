drop table fact_table;
DROP TABLE Dim_User;
CREATE TABLE Dim_User
    (
      sk   integer PRIMARY KEY,
      public_id      VARCHAR(24),
      Password       VARCHAR(64) NOT NULL,
      Date_Joined DATE NOT NULL,
      email_address VARCHAR2(62) NOT NULL ,
      First_Name    VARCHAR2(32)NOT NULL,
      Surname       VARCHAR2(32) NOT NULL,
      Gender        CHAR NOT NULL CHECK (Gender IN ('M','F','m','f')),
      Date_of_birth DATE NOT NULL ,
      ZIP VARCHAR(5) NOT NULL,
      Country_of_Residence varchar2(50) not null  ,
      Security_Question VARCHAR(32),
      Security_Answer   VARCHAR(32)
            
    );
    
insert into Dim_User select sk, public_id,Password, Date_Joined,email_address,  First_name, surname, gender ,Date_of_birth, ZIP , Country_of_Residence , Security_Question ,Security_Answer from stage_user;
select * from dim_user;   

drop TABLE Dim_Title;
CREATE TABLE Dim_Title
    (
      sk   integer PRIMARY KEY,
      title_Name     VARCHAR(50),
      Rating         DECIMAL(3,1) CHECK (rating <= 10.00),
      Type           VARCHAR2(20),
      Certificate    VARCHAR(5) ,
      Duration       NUMBER(3),
      Introduction   VARCHAR2(200),
      Storyline      VARCHAR2(500),
      Release_Date DATE
    );

insert into dim_title select sk, title_name, rating, type, certificate, duration ,introduction, storyline, release_date from stage_title;
select * from dim_title; 

drop table Dim_country;
Create table Dim_country (
country_sk integer PRIMARY KEY,
country_name varchar2(50)
);

insert into dim_country select country_sk, country_name from country_stage;
select * from dim_country;

drop table Dim_age;
Create table Dim_age(
age_sk integer PRIMARY KEY,
age number(3)
);

insert into dim_age select age_sk, age from age_stage;
select * from dim_age;


drop table Dim_date_added;
Create table Dim_date_added(
date_added_sk integer PRIMARY KEY,
monthyear varchar(6)
);  

insert into dim_date_added select date_added_sk, monthyear from stage_date_added;
select * from dim_date_added;


create table fact_table(
user_sk integer,
title_sk integer,
age_sk integer,
country_sk integer,
date_added_sk integer,
score number(4,2),

CONSTRAINT fact_user FOREIGN KEY (user_sk)
        REFERENCES dim_user(sk),
CONSTRAINT fact_title FOREIGN KEY (title_sk)
        REFERENCES dim_title(sk),
CONSTRAINT fact_age FOREIGN KEY (age_sk)
        REFERENCES dim_age(age_sk),
CONSTRAINT fact_country FOREIGN KEY (country_sk)
        REFERENCES dim_country(country_sk),
CONSTRAINT fact_date_added FOREIGN KEY (date_added_sk)
        REFERENCES dim_date_added(date_added_sk)
);

insert into fact_table select user_sk,title_sk ,age_sk, country_sk, date_added_sk, score from fact_stage;
select * from fact_table ;

--Sample Queies--
--select average score of users aged 18-25
select sum(score)/count(*) average from fact_table f, dim_age a where a.age <= 25 and a.age >=18 and f.age_sk = a.age_sk;

    