CREATE TABLE MyTag
(
  my_tag_id   int(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
  user_id     int(10) UNSIGNED NOT NULL,
  movie_id    int(10) UNSIGNED NOT NULL,
  tag         varchar(128) NOT NULL,
  time_tagged int(11) NOT NULL
);

LOAD DATA LOCAL INFILE '~/Downloads/tags.csv' 
INTO TABLE MyTag                       
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r'           
IGNORE 1 LINES                  
(user_id, movie_id, tag, time_tagged); 

SELECT COUNT(*) FROM MyTag;

USE Shared;
SHOW TABLES;

DESCRIBE Rating;
SELECT MIN(rating) FROM Rating;
SELECT COUNT(rating) FROM Rating;
SELECT SUM(rating) FROM Rating;

DESCRIBE Movie;
SELECT AVG(rating)
FROM Movie
JOIN Rating
ON Movie.movie_id = Rating.movie_id
WHERE title = 'GoldenEye';

SELECT MIN(year_released)
FROM Movie;


SELECT movie_id, AVG(rating) FROM Rating GROUP BY movie_id;
SELECT user_id, COUNT(rating) FROM Rating GROUP BY user_id;
SELECT user_id, AVG(rating) FROM Rating GROUP BY user_id;

SELECT COUNT(*)
FROM Rating
WHERE rating <
(SELECT AVG(rating) FROM Rating);

SELECT AVG(rating)
FROM Rating
WHERE rating <
(SELECT AVG(rating) FROM Rating);


SELECT AVG(rating) FROM Rating;

SELECT movie_id, rating
FROM Rating
WHERE rating < 3.49136;

SELECT AVG(SubRatingTable.rating) FROM
(
  SELECT movie_id, rating
  FROM Shared.Rating
  WHERE rating >= 2
) AS SubRatingTable;

SELECT count(*)
  FROM Shared.Rating
  WHERE rating >= 2;
  
  
Use Shared;
SHOW TABLES;
 
DESCRIBE Movie;
 
DESCRIBE Tag;
 
DESCRIBE Rating;

SELECT * FROM Rating;

SELECT title, rating 
FROM Movie
INNER JOIN Rating
On Rating.movie_id = Movie.movie_id
WHERE Movie.title = 'Pulp Fiction'
;

SELECT count(*)
FROM Movie
INNER JOIN Rating
On Rating.movie_id = Movie.movie_id
WHERE Movie.title = 'Pulp Fiction'
;

SELECT Movie.title, Movie.year_released FROM Movie;
SELECT TempMovie.title, TempMovie.year_released FROM Movie AS TempMovie;
 
SELECT * FROM TempMovie;

SELECT PulpFictionTable.title, AVG(PulpFictionTable.rating)
FROM
(
  SELECT title, rating FROM Movie
  INNER JOIN Rating
  On Rating.movie_id = Movie.movie_id
  WHERE Movie.title = 'Pulp Fiction'
) AS PulpFictionTable -- This is our alias for the joined table
;

SELECT CitizenKane.title, AVG(CitizenKane.rating)
FROM
(
  SELECT title, rating FROM Movie
  INNER JOIN Rating
  On Rating.movie_id = Movie.movie_id
  WHERE Movie.title = 'Citizen Kane'
) AS CitizenKane -- This is our alias for the joined table
;

SELECT * FROM Movie
INNER JOIN Rating
On Rating.movie_id = Movie.movie_id
GROUP BY Rating.movie_id
;

SELECT * FROM Movie
INNER JOIN Rating
ON Movie.movie_id = Rating.movie_id
ORDER BY Movie.movie_id DESC -- we're sorting it backwards, since our addition is at the last row
LIMIT 100;

SELECT * FROM Movie
LEFT OUTER JOIN Rating
ON Movie.movie_id = Rating.movie_id
ORDER BY Movie.movie_id DESC -- we're sorting it backwards, since our addition is at the last row
LIMIT 100;