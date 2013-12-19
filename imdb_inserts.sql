INSERT
INTO
  users VALUES
  (
     user_seq.nextval,
    'ldantes',
    '**********',
    sysdate,
    'ldantes@imdb.com',
    'Les',
    'Ducray',
    'M',
    '9-AUG-1990',
    'xxxx',
    'Ireland',
    'First pets name',
    'Goldie'
  );
  

INSERT
INTO
  users VALUES
  (
    user_seq.nextval,
    'samual',
    '**********',
    sysdate,
    'shar@imdb.com',
    'Sam',
    'Harrison',
    'F',
    '19-JUN-1987',
    'xxxx',
    'Ireland',
    'First pets name',
    'Spike'
  );
  
  INSERT
INTO
  users VALUES
  (
    user_seq.nextval,
    'rat',
    '**********',
    sysdate,
    'rat@imdb.com',
    'Richard',
    'King',
    'M',
    '01-MAY-1996',
    'xxxx',
    'Ireland',
    'Mothers name',
    'Mary'
  );
  
 insert into Title values
(
  title_seq.nextval,
  'Boardwalk Empire',
  null,
  'TV Series',
  'TVMA' ,
  60,
  'Chronicles the life and times of Nucky Thompson, the undisputed ruler of Atlantic City.',
  'Set in the Prohibition era of the 1920s Boardwalk Empire is the story of Enoch "Nucky" Thompson, the treasurer of Atlantic County, Atlantic City, New Jersey.',
  sysdate
  
  );

  
   insert into Title values
(
  title_seq.nextval,
  'The Wire',
  null,
  'TV Series',
  'TVMA' ,
  60,
  'Baltimore drug scene, seen through the eyes of drug dealers, and law enforcement. ',
  'Set in Baltimore, this show centers around the city''s inner-city drug scene. It starts as mid-level drug dealer, D''Angelo Barksdale beats a murder rap. After a conversation with a judge, Det. James McNulty has been assigned to lead a joint homicide and narcotics team, in order to bring down drug kingpin Avon Barksdale. ',
  sysdate
  
  );
  
  insert into celebrity values(celeb_seq.nextval,'Bobby Cannavale','3-MAY-1970',1.89,'Taurus','M');
  insert into celebrity values(celeb_seq.nextval,'Michael K. Williams','22-NOV-1966',1.8,'Sagittarius','m');
 
  insert into category values ('actor');
  insert into category values ('producer');
  insert into category values ('self');
  insert into category values ('thanks');
  
  insert into involvement values(2,2,'actor');
  insert into involvement values(2,1,'actor');
  insert into involvement values(1,1,'actor');
 
  insert into characters values (char_seq.nextval, 'Gyp Rosetti', 'Ruthless villian');
  insert into characters values (char_seq.nextval, 'Chalky White', 'Leader and primary caretaker of Atlantic County''s black population');
  insert into characters values (char_seq.nextval, 'Omar Little', 'Robbing Hood');
  
  insert into character_appearences values (1,1,1);
  insert into character_appearences values (2,1,2);
  insert into character_appearences values (3,2,2);
  
  
  insert into genre values ('drama');
  insert into genre values ('crime');
  insert into genre values ('thriller');
  insert into genre values ('history');
  
  insert into title_genre values(1,'drama');
  insert into title_genre values(1,'history');
  insert into title_genre values(1,'crime');
  insert into title_genre values(2,'drama');
  insert into title_genre values(2,'crime');
  insert into title_genre values(2,'thriller');
  
  insert into user_rating values (1,1,8,sysdate);
  insert into user_rating values (1,2,7,sysdate);
  insert into user_rating values (2,2,9,sysdate);
  insert into user_rating values (2,1,10,sysdate);
  insert into user_rating values (3,2,6,sysdate);
  

  commit;
 
 
 INSERT
INTO
  users2 VALUES
  (
     user_seq2.nextval,
    'matt90',
    '**********',
    sysdate,
    'matttt90@imdb.com',
    'matt',
    'Fan',
    'M',
    '7-MAY-1990',
    'xxxx',
    'UK',
    'First pets name',
    'rat'
  );
  

INSERT
INTO
  users2 VALUES
  (
    user_seq2.nextval,
    'Mohammed',
    '**********',
    sysdate,
    'mo@imdb.com',
    'Mohammed',
    'Mohammed',
    'M',
    '16-SEP-1983',
    'xxxx',
    'Saudi',
    '',
    ''
  );
  
  INSERT
INTO
  users2 VALUES
  (
    user_seq2.nextval,
    'Jzzz89',
    '**********',
    sysdate,
    'jesssi@imdb.com',
    'Jess',
    'Smith',
    'F',
    '17-JAN-1990',
    'xxxx',
    'Ireland',
    'Mothers name',
    'Mary'
  );
  
 insert into Title2 values
(
  title_seq2.nextval,
  'Sons of Anarchy',
  null,
  'TV Series',
  'TVMA' ,
  45,
  'A man in his early 30s struggles to find a balance in his life between being a new dad and his involvement in a motorcycle club.',
  'Sons of Anarchy, aka SAMCRO, is a motorcycle club that operates both illegal and legal businesses in the small town of Charming.',
  '3-SEP-2008'
  
  );

  
   insert into Title2 values
(
  title_seq2.nextval,
  'Gladiator',
  null,
  'Film',
  'R' ,
  155,
  'When a Roman general is betrayed and his family murdered by an emperor''s corrupt son, he comes to Rome as a gladiator to seek revenge. ',
  'Maximus is a powerful Roman general, loved by the people and the aging Emperor, Marcus Aurelius. Before his death, the Emperor chooses Maximus to be his heir over his own son, Commodus, and a power struggle leaves Maximus and his family condemned to death.',
  '5-MAY-2000'
  
  );
  
   insert into Title2 values
(
  title_seq2.nextval,
  'Orphan Black',
  null,
  'TV Series',
  'MA' ,
  60,
  'A streetwise hustler is pulled into a compelling conspiracy after witnessing the suicide of a girl who looks just like her.',
  'Orphan Black follows outsider, orphan and street-wise chameleon Sarah.',
  '30-MAR-13'
  
  );
  
  select * from title2;
  insert into celebrity2 values(celeb_seq2.nextval,'Tommy Flanagan','3-JULY-65',6,'Cancer',1);
  insert into celebrity2 values(celeb_seq2.nextval,'Katey Sagal','19-JAN-54',5.9,'Capricorn',0);
  insert into celebrity2 values(celeb_seq2.nextval,'Tatiana Maslany','22-SEP-85',5.4,'Virgo',0);
 
  select * from celebrity2;
  insert into category2 values ('actor');
  insert into category2 values ('producer');
  insert into category2 values ('self');
  insert into category2 values ('thanks');
  
  insert into involvement2 values(1,1,'actor');
  insert into involvement2 values(1,2,'actor');
  insert into involvement2 values(2,1,'actor');
  insert into involvement2 values(3,3,'actor');
 
  insert into characters2 values (char_seq2.nextval, 'Filip ''Chibs'' Telford', 'Chibs is usually in the thick of whatever craziness the club is involved in, as a dutiful soldier.');
  insert into characters2 values (char_seq2.nextval, 'Gemma Teller Morrow', 'Gemma Teller has been connected to SAMCRO all her adult life');
  insert into characters2 values (char_seq2.nextval, 'Sarah Manning', 'Clone');
  insert into characters2 values (char_seq2.nextval, 'Cosima Niehaus', 'Clone');
  insert into characters2 values (char_seq2.nextval, 'Alison Hendrix', 'Clone');
  insert into characters2 values (char_seq2.nextval, 'Beth Childs', 'Clone');
  insert into characters2 values (char_seq2.nextval, 'Katja', 'Clone');
  insert into characters2 values (char_seq2.nextval, 'Cicero', 'Cicero is the servant of General Maximus of the Roman army.');
  
  select * from characters2;
  
  insert into character_appearences2 values (1,1,1);
  insert into character_appearences2 values (2,1,2);
  insert into character_appearences2 values (3,3,3);
  insert into character_appearences2 values (4,3,3);
  insert into character_appearences2 values (5,3,3);
  insert into character_appearences2 values (6,3,3);
  insert into character_appearences2 values (7,3,3);
  insert into character_appearences2 values (8,2,1);
  
  select * from character_appearences2;
  
  insert into genre2 values ('drama');
  insert into genre2 values ('crime');
  insert into genre2 values ('thriller');
  insert into genre2 values ('history');
  
  insert into title_genre2 values(1,'drama');
  insert into title_genre2 values(1,'crime');
  insert into title_genre2 values(2,'history');
  insert into title_genre2 values(2,'drama');
  insert into title_genre2 values(3,'drama');
  insert into title_genre2 values(3,'thriller');
  
  insert into user_rating2 values (1,1,8,sysdate);
  insert into user_rating2 values (1,2,7,sysdate);
  insert into user_rating2 values (2,2,9,sysdate);
  insert into user_rating2 values (2,1,10,sysdate);
  insert into user_rating2 values (3,2,6,sysdate);
  

  commit; 
  