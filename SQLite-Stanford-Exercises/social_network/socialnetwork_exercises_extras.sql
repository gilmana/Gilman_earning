________________________________________________________
"""
Qustion1: For every situation where student A likes student B, but student B
likes a different student C, return the names and grades of A, B, and C.
"""
_______________________________________________________
SELECT H1.name, H1.grade, H2.name,H2.grade, H3.name,H3.grade
FROM Likes AS L1
	INNER JOIN Likes AS L2 ON L1.ID2 = L2.ID1
	INNER JOIN Highschooler AS H1 ON L1.ID1 = H1.ID
	INNER JOIN Highschooler AS H2 ON L1.ID2 = H2.ID
	INNER JOIN Highschooler AS H3 ON L2.ID2 = H3.ID
WHERE L1.ID1 <> L2.ID2
________________________________________________________
"""
Qustion2:Find those students for whom all of their friends are in different
grades from themselves. Return the students' names and grades.
"""
_______________________________________________________
SELECT DISTINCT H.name, H.grade
FROM Friend
	INNER JOIN Highschooler AS H ON H.ID = Friend.ID1
WHERE ID1 NOT IN
	(
		SELECT ID1
		FROM Friend
			INNER JOIN Highschooler AS H1 ON H1.ID = Friend.ID1
			INNER JOIN Highschooler AS H2 ON H2.ID = Friend.ID2
		WHERE H1.grade = H2.grade
	)
_______________________________________________________
"""
Qustion3:What is the average number of friends per student?
(Your result should be just one number.)
"""
_______________________________________________________
SELECT AVG(counts)
FROM
	(
	SELECT COUNT(ID2) AS counts
	FROM Highschooler AS H
		INNER JOIN Friend AS F ON F.ID1 = H.ID
	GROUP BY H.ID
	)
_______________________________________________________
"""
Qustion4:Find the number of students who are either friends with Cassandra or
are friends of friends of Cassandra. Do not count Cassandra, even though
technically she is a friend of a friend.
"""
_______________________________________________________
SELECT Ca_Fr.ID1 + Ca_Fr_Fr.ID1
FROM
 -- Cassandras friends
	(
	SELECT COUNT(ID1) AS ID1
	FROM Friend
		INNER JOIN Highschooler AS H ON H.ID = Friend.ID1
		WHERE H.name = 'Cassandra'
	) AS Ca_Fr
,
--cassandras friends of friends
	(
	SELECT COUNT(F1.ID1) AS ID1
	FROM Friend AS F1
		INNER JOIN Friend as F2 ON F1.ID2 = F2.ID1
		INNER JOIN Highschooler AS H1 ON H1.ID = F1.ID1
		INNER JOIN Highschooler AS H2 ON H2.ID = F2.ID2
	WHERE H1.name = 'Cassandra'
		AND H2.name <> 'Cassandra'
	) AS Ca_Fr_Fr
_______________________________________________________
"""
Qustion5:Find the name and grade of the student(s) with the greatest number of
friends.
"""
_______________________________________________________
SELECT H1.name, H1.grade
FROM
	(
	SELECT ID1, COUNT(ID2) AS ID2
	FROM Friend
	GROUP BY ID1
	) AS Fr_cnt
	INNER JOIN Highschooler AS H1 ON H1.ID = Fr_cnt.ID1
WHERE ID2 IN
	(
	SELECT MAX(ID2)
	FROM
		(
		SELECT ID1, COUNT(ID2) AS ID2
		FROM Friend
		GROUP BY ID1
		)
	)
_______________________________________________________
