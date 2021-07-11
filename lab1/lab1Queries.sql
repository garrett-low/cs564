-- 1
SELECT snum
FROM Student
WHERE sname LIKE "M%";

-- 2
SELECT cname
FROM Class
WHERE room='R12';

-- 3
SELECT fname
FROM Faculty
WHERE deptid=20;

-- 4
SELECT s.sname
FROM Student s, Enroll e
WHERE s.snum=e.snum 
  AND s.level='JR'
  AND e.cname='Database Systems';

-- 5
SELECT s.sname
FROM Student s, Enroll e, Class c, Faculty f
WHERE s.snum=e.snum 
  AND e.cname=c.cname 
  AND c.fid=f.fid
  AND s.level='JR'
  AND f.fname='I. Teach';

-- 6
SELECT cname
FROM Class
WHERE room='R128' OR meets_at LIKE 'MWF%';

-- 7
SELECT c.cname
FROM Class c, Faculty f
WHERE c.fid=f.fid 
  AND f.fname='Elizabeth Taylor';

-- 8
SELECT c.cname, c.room, c.meets_at
FROM Class c, Student s, Enroll e
WHERE s.sname='Joseph Thompson'
  AND s.snum=e.snum 
  AND c.cname=e.cname;

-- 9
SELECT f.fname
FROM Faculty f, Class c
WHERE f.fid=c.fid AND c.room='R128';

-- 10
SELECT c1.cname,c2.cname
FROM Class c1, Class c2
WHERE c1.meets_at IS NOT NULL
  AND c1.meets_at=c2.meets_at 
  AND c1.cname < c2.cname;

-- 11
SELECT MAX(age)
FROM Student s, Enroll e, Class c, Faculty f
WHERE s.major='History'
  OR (
    s.snum=e.snum 
    AND e.cname=c.cname 
    AND c.fid=f.fid 
    AND f.fname='I. Teach');

-- 12
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
WHERE c1.meets_at IS NOT NULL 
  AND c1.meets_at=c2.meets_at 
  AND c1.cname<c2.cname
  AND s.snum=e.snum 
  AND e.cname=c1.cname
INTERSECT
SELECT s.sname
FROM Student s, Enroll e, Class c1, Class c2
WHERE c1.meets_at IS NOT NULL
  AND c1.meets_at=c2.meets_at 
  AND c1.cname<c2.cname
  AND s.snum=e.snum
  AND e.cname=c2.cname;

-- 14
SELECT fname
FROM Faculty
WHERE fid IN (
	SELECT c.fid
	FROM Enroll e, Class c
	WHERE e.cname=c.cname
	GROUP BY c.fid
	HAVING COUNT(e.cname)<5
);

-- 15
SELECT level, AVG(age)
FROM Student
GROUP BY level;

-- 16
SELECT level, AVG(age)
FROM Student
WHERE level<>'JR'
GROUP BY level;

-- 17
SELECT f.fname, COUNT(c.fid)
FROM Faculty f, Class c
WHERE f.fid IN (
  SELECT f.fid
  FROM Faculty f, Class c
  WHERE f.fid=c.fid 
    AND c.room='R128'
)
AND f.fid=c.fid
GROUP BY f.fname;

-- 18
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
			SELECT count(snum) AS courseLoad
			FROM Enroll e
			GROUP BY snum
		)
	)
);

-- 19
SELECT s.sname
FROM Student s
EXCEPT
SELECT s.sname
FROM Student s
JOIN Enroll e
ON s.snum=e.snum;

-- 20
SELECT age, level
FROM (
  SELECT level, age, MAX(ageCount)
  FROM (
    SELECT level, age, COUNT(age) as ageCount
    FROM Student
    GROUP BY level, age
  )
 GROUP BY age
)
ORDER BY age DESC;

--21
SELECT AVG(s.age)
FROM Student s, Enroll e, Class c, Faculty f
WHERE s.snum = e.snum
  AND e.cname = c.cname
  AND c.fid = f.fid
  AND f.fname = 'I. Teach';