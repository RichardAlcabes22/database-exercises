-- #1 File created/named

-- #2 
USE albums_db;

-- #3
DESCRIBE albums; 
-- a. # of rows? - 31
SELECT COUNT(*)
FROM albums;
-- b. unique artists - 23
SELECT COUNT(DISTINCT artist)
 FROM albums;
-- c. primary key? - 'id'
DESCRIBE albums;
-- d. oldest release date? - 2011
SELECT MAX(release_date) 
 FROM albums;
 
-- #4 
-- a. all album names by Pink Floyd - Dark Side of the Moon/The Wall
SELECT name 
 FROM albums 
 WHERE artist = 'Pink Floyd';

-- b. Release year of Sgt Pepper's Lonely Hearts Club Band - 1967
SELECT release_date
 FROM albums 
 WHERE name =  'Sgt. Pepper\'s Lonely Hearts Club Band';
 
-- c. Genre for Nevermind -- grunge, alt rock
SELECT genre
 FROM albums 
 WHERE name = 'Nevermind';
 
-- d.  albums released in 1990s
 SELECT name
  FROM albums 
  WHERE release_date BETWEEN 1990 and 1999;
  
-- e. albums with < 20m certified sales
  SELECT name
   FROM albums 
   WHERE sales < 20.0;
   
-- f. albums with genre 'Rock'.  The following queries do not return HArd Rock or Progressive Rock because the queries are specifying 4 CHAR string "Rock" or 5 CHAR string "Rock,"
-- ONLY ROCK:
SELECT name 
 FROM albums 
 WHERE genre = 'Rock';
-- ROCK as one element in a list of genres in which ROCK is listed first in list:
SELECT name 
 FROM albums 
 WHERE genre LIKE 'Rock,%';
 
-- 5. Done