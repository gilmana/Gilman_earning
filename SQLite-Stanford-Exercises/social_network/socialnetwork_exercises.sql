________________________________________________________
"""
Qustion1: Find the names of all students who are friends with someone named
Gabriel.
"""
_______________________________________________________

SELECT name
FROM
		(
		SELECT DISTINCT ID2 as ID2
		FROM Friend
		INNER JOIN Highschooler ON Highschooler.ID = Friend.ID1
		WHERE Highschooler.name = 'Gabriel'
		)	AS gabefriends
		INNER JOIN Highschooler ON Highschooler.ID = gabefriends.ID2


###More elegent solution.
SELECT h2.name
FROM Friend
	INNER JOIN Highschooler AS h1 ON h1.ID = Friend.ID1
	INNER JOIN Highschooler AS h2 ON h2.ID = Friend.ID2
WHERE h1.name = "Gabriel"
_______________________________________________________
"""
Qustion2:For every student who likes someone 2 or more grades younger than
themselves,return that student's name and grade, and the name and grade of
the student they like.
"""
_______________________________________________________
SELECT h1.name, h1.grade, h2.name, h2.grade
FROM Likes
	INNER JOIN Highschooler AS h1 ON h1.ID = Likes.ID1
	INNER JOIN Highschooler AS h2 ON h2.ID = Likes.ID2
GROUP BY Likes.ID1
HAVING (h1.grade - h2.grade)>= 2

###More correct solution
SELECT h1.name, h1.grade, h2.name, h2.grade
FROM Likes
	INNER JOIN Highschooler AS h1 ON h1.ID = Likes.ID1
	INNER JOIN Highschooler AS h2 ON h2.ID = Likes.ID2
WHERE (h1.grade - h2.grade)>= 2
_______________________________________________________
"""
Qustion3:For every pair of students who both like each other, return the name
and grade of both students. Include each pair only once, with the two names in
alphabetical order.
"""
_______________________________________________________
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Likes as L1
	INNER JOIN Likes AS L2 ON L1.ID1 = L2.ID2
	INNER JOIN Highschooler AS H1 ON H1.ID = L1.ID1
	INNER JOIN Highschooler AS H2 ON H2.ID = L2.ID1
WHERE L1.ID2 = L2.ID1
AND L1.ID1 < L2.ID1
_______________________________________________________
"""
Qustion4:Find all students who do not appear in the Likes table (as a student
who likes or is liked) and return their names and grades. Sort by grade, then
by name within each grade.
"""
_______________________________________________________
SELECT name, grade
FROM Highschooler
	LEFT OUTER JOIN Likes AS L1 on Highschooler.ID = L1.ID1
	LEFT OUTER JOIN Likes AS L2 on Highschooler.ID = L2.ID2
WHERE L1.ID1 IS NULL
	AND L2.ID2 IS NULL
_______________________________________________________
"""
Qustion5: For every situation where student A likes student B, but we have no
information about whom B likes (that is, B does not appear as an ID1 in the
Likes table), return A and B's names and grades.
"""
_______________________________________________________
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Likes
 	INNER JOIN Highschooler AS H1 ON H1.ID = Likes.ID1
	INNER JOIN Highschooler AS H2 ON H2.ID = Likes.ID2
WHERE Likes.ID2 NOT IN (SELECT ID1 FROM Likes)
_______________________________________________________
"""
Qustion6:Find names and grades of students who only have friends in the same
grade. Return the result sorted by grade, then by name within each grade.
"""
_______________________________________________________

SELECT H1.name, H1.grade
FROM Friend
INNER JOIN Highschooler AS H1 ON H1.ID = Friend.ID1
INNER JOIN Highschooler AS H2 ON H2.ID = Friend.ID2
EXCEPT
SELECT H1.name, H1.grade
FROM Friend
INNER JOIN Highschooler AS H1 ON H1.ID = Friend.ID1
INNER JOIN Highschooler AS H2 ON H2.ID = Friend.ID2
WHERE H1.grade <> H2.grade
ORDER BY H1.grade, H1.name

#Try the same thing using OUTER JOIN
SELECT distinct H1.name, H1.grade
FROM Friend
	INNER JOIN Highschooler AS H1 ON H1.ID = Friend.ID1
	INNER JOIN Highschooler AS H2 ON H2.ID = Friend.ID2
	LEFT OUTER JOIN
		(
		SELECT Friend.ID1 as ID1
		FROM Friend
		INNER JOIN Highschooler AS H1 ON H1.ID = Friend.ID1
		INNER JOIN Highschooler AS H2 ON H2.ID = Friend.ID2
		WHERE H1.grade <> H2.grade
		) AS remove_friends
		ON Friend.ID1 = remove_friends.ID1
WHERE remove_friends.ID1 IS NULL
ORDER BY H1.grade, H1.name
_______________________________________________________
"""
Qustion7:For each student A who likes a student B where the two are not friends,
find if they have a friend C in common (who can introduce them!). For all such
trios, return the name and grade of A, B, and C.
"""
_______________________________________________________

SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
FROM Likes
	INNER JOIN Friend ON Friend.ID1 = Likes.ID1
	INNER JOIN Friend AS F2 ON F2.ID1 = Likes.ID2

	LEFT OUTER JOIN
		(
		SELECT Likes.ID1 AS ID1
		FROM Likes
			INNER JOIN Friend ON Likes.ID1 = Friend.ID1
		WHERE Likes.ID2 = Friend.ID2
		) AS Remove
		ON Likes.ID1 = Remove.ID1

	INNER JOIN Highschooler AS H1 ON H1.ID = Likes.ID1
	INNER JOIN HIghschooler AS H2 ON H2.ID = Likes.ID2
	INNER JOIN Highschooler AS H3 ON H3.ID = Friend.ID2

WHERE Remove.ID1 is NULL AND Friend.ID2 = F2.ID2
_______________________________________________________
"""
Qustion8:Find the difference between the number of students in the school and
the number of different first names.
"""
_______________________________________________________
SELECT n1 - n2
FROM
	(SELECT COUNT(name) as n1
 	FROM Highschooler)
		,
	(SELECT COUNT(distinct name) as n2
	FROM Highschooler)
_______________________________________________________
"""
Qustion9:Find the name and grade of all students who are liked by more than
one other student.
"""
_______________________________________________________
SELECT H.name, H.grade
FROM
		(
			SELECT ID2, COUNT(ID2) as counts
			FROM Likes
			GROUP BY ID2
		)	AS Keep
			INNER JOIN Highschooler AS H ON H.ID = Keep.ID2
WHERE counts >= 2
_______________________________________________________
