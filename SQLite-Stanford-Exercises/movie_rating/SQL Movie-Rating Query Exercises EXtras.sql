________________________________________________________
"""
Qustion1: Find the names of all reviewers who rated Gone with the Wind.
"""
_______________________________________________________
SELECT distinct name
FROM Movie, Reviewer, Rating
WHERE Movie.mID = Rating.mid and Rating.rID = Reviewer.rID
	and title = 'Gone with the Wind'
________________________________________________________
"""
Question2: For any rating where the reviewer is the same as the director
of the movie, return the reviewer name, movie title, and number of stars.
"""
________________________________________________________
SELECT distinct name, title, stars
FROM Movie, Reviewer, Rating
WHERE Movie.mID = Rating.mid and Rating.rID = Reviewer.rID
	and Reviewer.name = Movie.director
________________________________________________________
"""
Question3: Return all reviewer names and movie names together in a single
list, alphabetized. (Sorting by the first name of the reviewer and first
word in the title is fine; no need for special processing on last names
or removing "The".)
"""
________________________________________________________
SELECT distinct title FROM Movie
Union
SELECT name FROM Reviewer
________________________________________________________
"""
Question4:Find the titles of all movies not reviewed by Chris Jackson.
"""
________________________________________________________
SELECT title
FROM Movie
EXCEPT
SELECT distinct title
FROM Movie, Reviewer, Rating
WHERE Movie.mID = Rating.mid
	and Rating.rID = Reviewer.rID
	and Reviewer.name = 'Chris Jackson'

#This works, also got familiar with the very useful except clause :)
________________________________________________________
"""
Question 5: For all pairs of reviewers such that both reviewers gave a
rating to the same movie, return the names of both reviewers.
Eliminate duplicates, don't pair reviewers with themselves, and include
each pair only once. For each pair, return the names in the pair in
alphabetical order.
"""
________________________________________________________

SELECT distinct v1.name, v2.name
FROM Rating as r1
	INNER JOIN Reviewer AS v1 ON r1.rID = v1.rID
	INNER JOIN Rating AS r2 ON r2.mID = r1.mID
	INNER JOIN reviewer AS v2 ON v2.rID = r2.rID
WHERE r1.rID <> r2.rID AND v1.name < v2.name

________________________________________________________
"""
Question 6: For each rating that is the lowest (fewest stars) currently
in the database, return the reviewer name, movie title, and number of stars.
"""
________________________________________________________
SELECT v1.name, m1.title, r1.stars
FROM Rating AS r1
	INNER JOIN Reviewer AS v1 ON v1.rID = r1.rID
	INNER JOIN Movie AS m1 on m1.mID = r1.mID
WHERE stars = (SELECT MIN(stars) FROM Rating)
________________________________________________________
"""
Question 7: List movie titles and average ratings, from highest-rated to
lowest-rated. If two or more movies have the same average rating, list
them in alphabetical order.
"""
________________________________________________________
SELECT title, avgstars.stars
FROM (SELECT mID, AVG(stars) AS stars
			FROM Rating
			GROUP BY mID) AS avgstars
			INNER JOIN Movie ON Movie.mID = avgstars.mID
ORDER BY avgstars.stars DESC, title
________________________________________________________
"""
Question 8: Find the names of all reviewers who have contributed three or
more ratings. (As an extra challenge, try writing the query without HAVING
or without COUNT.)
"""
________________________________________________________
SELECT name
FROM Reviewer as v1
	INNER JOIN Rating as r1 on r1.rID = v1.rID
GROUP BY r1.rID
HAVING count(stars) >=3
________________________________________________________
"""
Question 9: Some directors directed more than one movie. For all such directors,
return the titles of all movies directed by them, along with the director name.
Sort by director name, then movie title. (As an extra challenge, try writing
the query both with and without COUNT.)
"""
________________________________________________________
SELECT title, Movie.director
FROM (SELECT director
			FROM Movie
			GROUP BY director
			HAVING COUNT(director) >= 2) AS dircount
			INNER JOIN Movie ON Movie.director = dircount.director
ORDER BY Movie.director, title
________________________________________________________
"""
Question 10: Find the movie(s) with the highest average rating. Return the movie
title(s) and average rating. (Hint: This query is more difficult to write in
SQLite than other systems; you might think of it as finding the highest average
rating and then choosing the movie(s) with that average rating.)
"""
________________________________________________________
SELECT title, max(stars)
FROM (SELECT mID, AVG(stars) AS stars
			FROM Rating
			GROUP BY mID) AS avgstars
			INNER JOIN Movie ON avgstars.mID = Movie.mID

________________________________________________________
"""
Question 11: Find the movie(s) with the lowest average rating. Return the movie
title(s) and average rating. (Hint: This query may be more difficult to write
in SQLite than other systems; you might think of it as finding the lowest
average rating and then choosing the movie(s) with that average rating.)
"""
________________________________________________________

SELECT title, stars
FROM (SELECT mID, AVG(stars) AS stars
			FROM Rating
			GROUP BY mID) AS avgstars
			INNER JOIN Movie ON avgstars.mID = Movie.mID
WHERE avgstars.stars = (
												SELECT MIN(stars)
												FROM (SELECT mID, AVG(stars) AS stars
														FROM Rating
														GROUP BY mID)
												)
________________________________________________________
"""
Question 12:For each director, return the director's name together with the
title(s) of the movie(s) they directed that received the highest rating among
all of their movies, and the value of that rating. Ignore movies whose director
is NULL.
"""
________________________________________________________
SELECT Distinct director, title, MAX(stars)
FROM Movie
	INNER JOIN Rating AS R1 ON R1.mID = Movie.mID
WHERE Movie.director IS NOT NULL
GROUP BY director
ORDER by stars DESC
________________________________________________________
