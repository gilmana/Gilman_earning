________________________________________________________
"""
Question 1:Find the titles of all movies directed by Steven Spielberg.
"""
________________________________________________________
SELECT title
FROM Movie
WHERE director = "Steven Spielberg"
________________________________________________________
"""
Question 2:Find all years that have a movie that received a rating of 4 or 5,
and sort them in increasing order.
"""
________________________________________________________
SELECT distinct year
FROM movie
  INNER JOIN Rating ON Movie.mID = Rating.mID
WHERE stars IN (4,5)
ORDER BY year
________________________________________________________
"""
Question 3:Find the titles of all movies that have no ratings.
"""
________________________________________________________
SELECT title
FROM Movie
  LEFT OUTER JOIN Rating ON Movie.mID = Rating.mID
WHERE Rating.mID IS NULL
________________________________________________________
"""
Question 4:Some reviewers didn't provide a date with their rating. Find the
names of all reviewers who have ratings with a NULL value for the date.
"""
________________________________________________________
SELECT name
FROM Reviewer
  INNER JOIN Rating ON Reviewer.rID = Rating.rID
WHERE Rating.ratingDate IS NULL
________________________________________________________
"""
Question 5:Write a query to return the ratings data in a more readable format:
reviewer name, movie title, stars, and ratingDate. Also, sort the data, first
by reviewer name, then by movie title, and lastly by number of stars.
"""
________________________________________________________
SELECT name, title, stars, ratingDate
FROM Movie
  NATURAL JOIN Reviewer
  NATURAL JOIN Rating
ORDER BY name, title, stars
________________________________________________________
"""
Question 6:For all cases where the same reviewer rated the same movie
twice and gave it a higher rating the second time, return the reviewer's
name and the title of the movie.
"""
________________________________________________________
SELECT name, title
    FROM Reviewer AS v
        INNER JOIN Rating AS t1 ON v.rID = t1.rID
        INNER JOIN Rating AS t2 ON v.rID = t2.rID
        INNER JOIN Movie AS m ON t1.mID = m.mID AND t2.mID = m.mID
    WHERE t2.ratingDate > t1.ratingDate
        AND t2.stars  > t1.stars
________________________________________________________
"""
Question 7:For each movie that has at least one rating, find the highest number
of stars that movie received. Return the movie title and number of stars. Sort
by movie title.
"""
________________________________________________________
SELECT title, MAX(stars)
FROM Rating
  INNER JOIN Movie ON Rating.mID = Movie.mID
GROUP BY title
________________________________________________________
"""
Question 8:For each movie, return the title and the 'rating spread', that is,
the difference between highest and lowest ratings given to that movie. Sort by
rating spread from highest to lowest, then by movie title.
"""
________________________________________________________
