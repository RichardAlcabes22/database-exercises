SHOW DATABASES;
USE employees;
SHOW TABLES;
DESCRIBE titles;
-- SELECT * FROM titles LIMIT 20;

-- 1. Find all CURRENT emps w/ same hire date as emp 101010-must use subquery
SELECT emp_no, hire_date
FROM employees e
  JOIN dept_emp de
  USING(emp_no) 
WHERE hire_date = 
			(
			SELECT hire_date
			FROM employees
			WHERE emp_no = 101010
			)
  AND de.to_date > CURDATE()
;

-- 2. Find all titles held by CURRENT emps w/ first_name 'Aamod'
SELECT title, t.emp_no,t.to_date
FROM titles t
WHERE t.emp_no IN
			(
			SELECT emp_no
			FROM employees
			WHERE first_name = 'Aamod'
			)  
  AND t.to_date > CURDATE()
;
/*

SELECT emp_no
			FROM employees
			WHERE first_name = 'Aamod';
*/
-- 3.  # peeps in employee table no longer working for company?

/* inner query
SELECT s.emp_no,MAX(s.to_date) as maxdate
FROM salaries s
GROUP BY s.emp_no;
*/

SELECT COUNT(final.emp_no)
FROM    (SELECT s.emp_no,MAX(s.to_date) as maxdate
		 FROM salaries s
		 GROUP BY s.emp_no
		) AS final
WHERE maxdate <= CURDATE();
-- 240,124 employees no longer work for the company 59,900

-- 4. Find all CURRENT managers that are female use a subquery

/*Inner query 
SELECT d.dept_name, CONCAT(e.first_name,' ',e.last_name) AS Dept_Mgr, e.gender
FROM departments AS d
  JOIN dept_manager as dm
  ON d.dept_no = dm.dept_no
    JOIN employees as e
    ON dm.emp_no = e.emp_no
WHERE dm.to_date > CURDATE()
GROUP BY d.dept_name,dm.emp_no;
*/

SELECT mgrlist.Dept_Mgr
FROM	(	SELECT d.dept_name, CONCAT(e.first_name,' ',e.last_name) AS Dept_Mgr, e.gender
			FROM departments AS d
			  JOIN dept_manager as dm
			  ON d.dept_no = dm.dept_no
				JOIN employees as e
				ON dm.emp_no = e.emp_no
			WHERE dm.to_date > CURDATE()
			GROUP BY d.dept_name,dm.emp_no
		) AS mgrlist
WHERE mgrlist.gender = 'F';

-- 5. find all emps CURRENT salary > overall, HISTORICAL avg

-- inner query historical overall AVG(sal)
-- SELECT AVG(salary)
-- FROM salaries;

SELECT emp_no -- 154543 total employees
FROM salaries
WHERE salary > (SELECT AVG(salary)
				FROM salaries)
  AND to_date > CURDATE()
;

-- 6. CURRENT salaries within 1 SD of CURRENT highest salary

-- COUNT of all current salaries, MAX, STD
SELECT COUNT(salary), MAX(salary), ROUND(STD(salary))
FROM salaries
WHERE to_date > CURDATE(); -- 240,124  158,220 17,310

-- MAX - 1SD = 140,910
SELECT MAX(salary) - ROUND(STD(salary)) AS max_1sd
FROM salaries
WHERE to_date > CURDATE();

SELECT COUNT(salary)
FROM salaries
WHERE to_date > CURDATE()
  AND salary > 
			(SELECT MAX(salary) - ROUND(STD(salary)) AS max_1sd
			 FROM salaries
			 WHERE to_date > CURDATE()
             )
; -- 83 CURRENT salaries are within 1 SD of MAX CURRENT salary