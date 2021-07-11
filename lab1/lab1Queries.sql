SELECT snum
FROM Student
WHERE sname LIKE "M%";

SELECT cname
FROM Class
WHERE room='R12';

SELECT fname
FROM Faculty
WHERE deptid=20;

SELECT s.sname
FROM Student s, Enroll e
WHERE s.snum=e.snum AND e.cname='Database Systems';

SELECT s.sname
FROM Student s, Enroll e, Class c, Faculty f
WHERE s.snum=e.snum AND e.cname=c.cname AND c.fid=f.fid AND f.fname='I. Teach';

SELECT cname
FROM Class
WHERE room='R128' OR meets_at LIKE 'MWF%';

SELECT c.cname
FROM Class c, Faculty f
WHERE c.fid=f.fid AND f.fname='Elizabeth Taylor';

SELECT c.cname, c.room, c.meets_at
FROM Class c, Student s, Enroll e
WHERE s.sname='Joseph Thompson' AND s.snum=e.snum AND c.cname=e.cname;

SELECT f.fname
FROM Faculty f, Class c
WHERE f.fid=c.fid AND c.room='R128';

SELECT c1.cname,c2.cname
FROM Class c1, Class c2
WHERE c1.meets_at IS NOT NULL
  AND c1.meets_at=c2.meets_at AND c1.cname < c2.cname;

SELECT MAX(age)
FROM Student s, Enroll e, Class c, Faculty f
WHERE s.major='History'
  OR (s.snum=e.snum AND e.cname=c.cname AND c.fid=f.fid AND f.fname='I. Teach');

SELECT c.cname
FROM Class c
WHERE c.room='R128'
UNION
SELECT e.cname
FROM Enroll e
GROUP BY e.cname
HAVING COUNT(e.cname)>=5;

--13 coincidentally good
/*
SELECT s.sname
FROM Student s, Enroll e, Class c1, Class c2
WHERE c1.meets_at IS NOT NULL AND c1.meets_at=c2.meets_at AND c1.cname<c2.cname
  AND s.snum=e.snum AND e.cname=c2.cname;
*/

--13 bad
/*
SELECT s.sname
FROM Student s
JOIN Enroll e, Class c
ON s.snum=e.snum
WHERE e.cname=(SELECT c1.cname,c2.cname
FROM Class c1, Class c2
WHERE c1.meets_at IS NOT NULL
  AND c1.meets_at=c2.meets_at AND c1.cname < c2.cname)
*/
  
--13 bad
/*
SELECT s.sname
FROM Student s, Enroll e, Class c1, Class c2
WHERE AND s.snum=e.snum AND e.cname IN
c1.meets_at IS NOT NULL AND c1.meets_at=c2.meets_at
*/

--13 bad
/*
SELECT s.sname
FROM Student s, Enroll e
WHERE s.snum=e.snum AND e.cname=(
SELECT c1.cname
FROM Class c1, Class c2
WHERE c1.meets_at IS NOT NULL AND c1.meets_at=c2.meets_at AND c1.cname<c2.cname)
UNION
SELECT s.sname
FROM Student s, Enroll e
WHERE s.snum=e.snum AND e.cname=(
SELECT c2.cname
FROM Class c1, Class c2
WHERE c1.meets_at IS NOT NULL AND c1.meets_at=c2.meets_at AND c1.cname<c2.cname);
*/

--13
SELECT s.sname
FROM Student s, Enroll e, Class c1, Class c2
WHERE c1.meets_at IS NOT NULL AND c1.meets_at=c2.meets_at AND c1.cname<c2.cname
  AND s.snum=e.snum AND e.cname=c1.cname
INTERSECT
SELECT s.sname
FROM Student s, Enroll e, Class c1, Class c2
WHERE c1.meets_at IS NOT NULL AND c1.meets_at=c2.meets_at AND c1.cname<c2.cname
  AND s.snum=e.snum AND e.cname=c2.cname;

SELECT DISTINCT f.fname
FROM Class c, Enroll e, Faculty f
WHERE c.fid=f.fid AND c.cname IN (
SELECT e.cname
FROM Enroll e
GROUP BY e.cname
HAVING COUNT(e.cname)<5);

SELECT level, AVG(age)
FROM Student
GROUP BY level;

SELECT level, AVG(age)
FROM Student
WHERE level<>'JR'
GROUP BY level;

SELECT f.fname, COUNT(c.fid)
FROM Faculty f, Class c
WHERE f.fid=c.fid AND c.room='R128'
GROUP BY f.fname;

--18
SELECT sname
FROM Student
WHERE snum IN (
	SELECT snum
	FROM(
		SELECT snum, count(snum) AS courseLoad
		FROM Enroll e
		GROUP BY snum
	)
	WHERE courseLoad=(
		SELECT MAX(courseLoad) 
		FROM(
			SELECT snum, count(snum) AS courseLoad
			FROM Enroll e
			GROUP BY snum
		)
	)
);

--19
SELECT s.sname
FROM Student s
EXCEPT
SELECT s.sname
FROM Student s
JOIN Enroll e
ON s.snum=e.snum;