INSERT INTO users
VALUES      ( user_seq.NEXTVAL,
             'ldantes',
             '**********',
             SYSDATE,
             'ldantes@imdb.com',
             'Les',
             'Ducray',
             'M',
             '9-AUG-1990',
             'xxxx',
             'Ireland',
             'First pets name',
             'Goldie' );

INSERT INTO users
VALUES      ( user_seq.NEXTVAL,
             'samual',
             '**********',
             SYSDATE,
             'shar@imdb.com',
             'Sam',
             'Harrison',
             'F',
             '19-JUN-1987',
             'xxxx',
             'Ireland',
             'First pets name',
             'Spike' );

INSERT INTO users
VALUES      ( user_seq.NEXTVAL,
             'rat',
             '**********',
             SYSDATE,
             'rat@imdb.com',
             'Richard',
             'King',
             'M',
             '01-MAY-1996',
             'xxxx',
             'Ireland',
             'Mothers name',
             'Mary' );

INSERT INTO title
VALUES      ( title_seq.NEXTVAL,
             'Boardwalk Empire',
             NULL,
             'TV Series',
             'TVMA',
             60,
'Chronicles the life and times of Nucky Thompson, the undisputed ruler of Atlantic City.'
              ,
'Set in the Prohibition era of the 1920s Boardwalk Empire is the story of Enoch "Nucky" Thompson, the treasurer of Atlantic County, Atlantic City, New Jersey.'
              ,
SYSDATE );

INSERT INTO title
VALUES      ( title_seq.NEXTVAL,
             'The Wire',
             NULL,
             'TV Series',
             'TVMA',
             60,
'Baltimore drug scene, seen through the eyes of drug dealers, and law enforcement. '
              ,
'Set in Baltimore, this show centers around the city''s inner-city drug scene. It starts as mid-level drug dealer, D''Angelo Barksdale beats a murder rap. After a conversation with a judge, Det. James McNulty has been assigned to lead a joint homicide and narcotics team, in order to bring down drug kingpin Avon Barksdale. '
              ,
SYSDATE );

INSERT INTO celebrity
VALUES     (celeb_seq.NEXTVAL,
            'Bobby Cannavale',
            '3-MAY-1970',
            1.89,
            'Taurus',
            'M');

INSERT INTO celebrity
VALUES     (celeb_seq.NEXTVAL,
            'Michael K. Williams',
            '22-NOV-1966',
            1.8,
            'Sagittarius',
            'm');

INSERT INTO category
VALUES      ('actor');

INSERT INTO category
VALUES      ('producer');

INSERT INTO category
VALUES      ('self');

INSERT INTO category
VALUES      ('thanks');

INSERT INTO involvement
VALUES     (2,
            2,
            'actor');

INSERT INTO involvement
VALUES     (2,
            1,
            'actor');

INSERT INTO involvement
VALUES     (1,
            1,
            'actor');

INSERT INTO characters
VALUES      (char_seq.NEXTVAL,
             'Gyp Rosetti',
             'Ruthless villian');

INSERT INTO characters
VALUES      (char_seq.NEXTVAL,
             'Chalky White',
'Leader and primary caretaker of Atlantic County''s black population');

INSERT INTO characters
VALUES      (char_seq.NEXTVAL,
             'Omar Little',
             'Robbing Hood');

INSERT INTO character_appearences
VALUES      (1,
             1,
             1);

INSERT INTO character_appearences
VALUES      (2,
             1,
             2);

INSERT INTO character_appearences
VALUES      (3,
             2,
             2);

INSERT INTO genre
VALUES      ('drama');

INSERT INTO genre
VALUES      ('crime');

INSERT INTO genre
VALUES      ('thriller');

INSERT INTO genre
VALUES      ('history');

INSERT INTO title_genre
VALUES     (1,
            'drama');

INSERT INTO title_genre
VALUES     (1,
            'history');

INSERT INTO title_genre
VALUES     (1,
            'crime');

INSERT INTO title_genre
VALUES     (2,
            'drama');

INSERT INTO title_genre
VALUES     (2,
            'crime');

INSERT INTO title_genre
VALUES     (2,
            'thriller');

INSERT INTO user_rating
VALUES      (1,
             1,
             8,
             SYSDATE);

INSERT INTO user_rating
VALUES      (1,
             2,
             7,
             SYSDATE);

INSERT INTO user_rating
VALUES      (2,
             2,
             9,
             SYSDATE);

INSERT INTO user_rating
VALUES      (2,
             1,
             10,
             SYSDATE);

INSERT INTO user_rating
VALUES      (3,
             2,
             6,
             SYSDATE);

COMMIT;

INSERT INTO users2
VALUES      ( user_seq2.NEXTVAL,
             'matt90',
             '**********',
             SYSDATE,
             'matttt90@imdb.com',
             'matt',
             'Fan',
             1,
             '7-MAY-1990',
             'xxxx',
             'UK',
             'First pets name',
             'rat' );

INSERT INTO users2
VALUES      ( user_seq2.NEXTVAL,
             'Mohammed',
             '**********',
             SYSDATE,
             'mo@imdb.com',
             'Mohammed',
             'Mohammed',
             1,
             '16-SEP-1983',
             'xxxx',
             'Saudi',
             '',
             '' );

INSERT INTO users2
VALUES      ( user_seq2.NEXTVAL,
             'Jzzz89',
             '**********',
             SYSDATE,
             'jesssi@imdb.com',
             'Jess',
             'Smith',
             0,
             '17-JAN-1990',
             'xxxx',
             'Ireland',
             'Mothers name',
             'Mary' );

INSERT INTO title2
VALUES      ( title_seq2.NEXTVAL,
             'Sons of Anarchy',
             NULL,
             'TV Series',
             'TVMA',
             45,
'A man in his early 30s struggles to find a balance in his life between being a new dad and his involvement in a motorcycle club.'
              ,
'Sons of Anarchy, aka SAMCRO, is a motorcycle club that operates both illegal and legal businesses in the small town of Charming.'
              ,
'3-SEP-2008' );

INSERT INTO title2
VALUES      ( title_seq2.NEXTVAL,
             'Gladiator',
             NULL,
             'Film',
             'R',
             155,
'When a Roman general is betrayed and his family murdered by an emperor''s corrupt son, he comes to Rome as a gladiator to seek revenge. '
              ,
'Maximus is a powerful Roman general, loved by the people and the aging Emperor, Marcus Aurelius. Before his death, the Emperor chooses Maximus to be his heir over his own son, Commodus, and a power struggle leaves Maximus and his family condemned to death.'
              ,
'5-MAY-2000' );

INSERT INTO title2
VALUES      ( title_seq2.NEXTVAL,
             'Orphan Black',
             NULL,
             'TV Series',
             'MA',
             60,
'A streetwise hustler is pulled into a compelling conspiracy after witnessing the suicide of a girl who looks just like her.'
              ,
'Orphan Black follows outsider, orphan and street-wise chameleon Sarah.',
'30-MAR-13' );

SELECT *
FROM   title2;

INSERT INTO celebrity2
VALUES     (celeb_seq2.NEXTVAL,
            'Tommy Flanagan',
            '3-JULY-65',
            6,
            'Cancer',
            1);

INSERT INTO celebrity2
VALUES     (celeb_seq2.NEXTVAL,
            'Katey Sagal',
            '19-JAN-54',
            5.9,
            'Capricorn',
            0);

INSERT INTO celebrity2
VALUES     (celeb_seq2.NEXTVAL,
            'Tatiana Maslany',
            '22-SEP-85',
            5.4,
            'Virgo',
            0);

SELECT *
FROM   celebrity2;

INSERT INTO category2
VALUES      ('actor');

INSERT INTO category2
VALUES      ('producer');

INSERT INTO category2
VALUES      ('self');

INSERT INTO category2
VALUES      ('thanks');

INSERT INTO involvement2
VALUES     (1,
            1,
            'actor');

INSERT INTO involvement2
VALUES     (1,
            2,
            'actor');

INSERT INTO involvement2
VALUES     (2,
            1,
            'actor');

INSERT INTO involvement2
VALUES     (3,
            3,
            'actor');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Filip ''Chibs'' Telford',
'Chibs is usually in the thick of whatever craziness the club is involved in, as a dutiful soldier.'
);

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Gemma Teller Morrow',
             'Gemma Teller has been connected to SAMCRO all her adult life');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Sarah Manning',
             'Clone');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Cosima Niehaus',
             'Clone');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Alison Hendrix',
             'Clone');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Beth Childs',
             'Clone');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Katja',
             'Clone');

INSERT INTO characters2
VALUES      (char_seq2.NEXTVAL,
             'Cicero',
             'Cicero is the servant of General Maximus of the Roman army.');

SELECT *
FROM   characters2;

INSERT INTO character_appearences2
VALUES      (1,
             1,
             1);

INSERT INTO character_appearences2
VALUES      (2,
             1,
             2);

INSERT INTO character_appearences2
VALUES      (3,
             3,
             3);

INSERT INTO character_appearences2
VALUES      (4,
             3,
             3);

INSERT INTO character_appearences2
VALUES      (5,
             3,
             3);

INSERT INTO character_appearences2
VALUES      (6,
             3,
             3);

INSERT INTO character_appearences2
VALUES      (7,
             3,
             3);

INSERT INTO character_appearences2
VALUES      (8,
             2,
             1);

SELECT *
FROM   character_appearences2;

INSERT INTO genre2
VALUES      ('drama');

INSERT INTO genre2
VALUES      ('crime');

INSERT INTO genre2
VALUES      ('thriller');

INSERT INTO genre2
VALUES      ('history');

INSERT INTO title_genre2
VALUES     (1,
            'drama');

INSERT INTO title_genre2
VALUES     (1,
            'crime');

INSERT INTO title_genre2
VALUES     (2,
            'history');

INSERT INTO title_genre2
VALUES     (2,
            'drama');

INSERT INTO title_genre2
VALUES     (3,
            'drama');

INSERT INTO title_genre2
VALUES     (3,
            'thriller');

INSERT INTO user_rating2
VALUES      (1,
             1,
             80,
             SYSDATE);

INSERT INTO user_rating2
VALUES      (1,
             2,
             70,
             SYSDATE);

INSERT INTO user_rating2
VALUES      (2,
             2,
             90,
             SYSDATE);

INSERT INTO user_rating2
VALUES      (2,
             1,
             100,
             SYSDATE);

INSERT INTO user_rating2
VALUES      (3,
             2,
             60,
             SYSDATE);

COMMIT; 
