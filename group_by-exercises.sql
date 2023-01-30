USE employees;
-- 1. created
-- 2. find unique titles using DISTINCT - 7 DISTINCT Titles
-- USE employees;
SELECT DISTINCT title
FROM titles; -- 7 distinct titles

-- 3. find unique last_names start AND end with 'E' uing GROUP BY - 5 unique last names 'e%e'
SELECT last_name
 FROM employees
 WHERE UPPER(last_name) LIKE 'E%E'
 GROUP BY last_name;
 
 -- 4. find all unique combos of first and last names of 'e%e' last_name employees
 SELECT first_name, last_name-- , COUNT(*)
  FROM employees
  WHERE UPPER(last_name) LIKE 'E%E'
  GROUP BY first_name,last_name;
  
  -- 5. find unique last names with 'q' but not 'qu' - Chleq/Lindqvist/Qiwen
SELECT DISTINCT last_name
  FROM employees 
  WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
  -- Chleq/Lindqvist/Qiwen

-- 6. count # of employees with each last_name
SELECT DISTINCT last_name, COUNT(*)
  FROM employees 
  WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
  GROUP BY last_name;
  
  -- 7. employees with first name 'Irena' 'Vidya' 'Maya' find # of each name/gender combo
SELECT first_name, gender, COUNT(*)
 FROM employees
 WHERE first_name IN ('Irena','Vidya','Maya')
 GROUP BY first_name, gender;
 
 -- 8. from username generator, count # of employees with each DISTINCT username
 SELECT CONCAT(LOWER(SUBSTR(first_name,1,1)),
		LOWER(SUBSTR(last_name,1,4)),
		'_',
		SUBSTR(birth_date,6,2),
		SUBSTR(birth_date,3,2)
		) as username, COUNT(*)
FROM employees
GROUP BY username
-- ORDER BY COUNT(*) DESC
;
 -- 9. duplicate usernames from #8 ??  greatest number of duplicates ?? 
SELECT CONCAT(LOWER(SUBSTR(first_name,1,1)),
		      LOWER(SUBSTR(last_name,1,4)),
		      '_',
		      SUBSTR(birth_date,6,2),
		      SUBSTR(birth_date,3,2)
		) as username, COUNT(*)
FROM employees
GROUP BY username
ORDER BY COUNT(*) DESC
;
-- BONUS: total count of duplicate usernames -- 13251 dups
SELECT CONCAT(LOWER(SUBSTR(first_name,1,1)),
		      LOWER(SUBSTR(last_name,1,4)),
		      '_',
		      SUBSTR(birth_date,6,2),
		      SUBSTR(birth_date,3,2)
		) as username, COUNT(*)
FROM employees
GROUP BY username
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC
;
-- 13251 dups

-- BONUS: MORE PRACTICE
 
 -- historic avg salary for each employee
 SELECT emp_no, ROUND(AVG(salary),2)
 FROM salaries
 GROUP BY emp_no;
 
 -- count of emps in each dept

 SELECT dept_no, COUNT(emp_no)
 FROM dept_emp
 GROUP BY dept_no;
 
 -- count of distinct salaries of each employee
 SELECT emp_no, COUNT(salary)
 FROM salaries
 GROUP BY emp_no;
 
 -- Max salary for each employee
 SELECT emp_no, MAX(salary)
 FROM salaries
 GROUP BY emp_no;
 
 -- MIN salary for each emp
 SELECT emp_no, MIN(salary)
 FROM salaries
 GROUP BY emp_no;
 
 -- STD of salaries by employee 
SELECT emp_no, ROUND(STD(salary),2)
 FROM salaries
 GROUP BY emp_no;

-- MAX salary for employees w/ MAX > 150k
 SELECT emp_no, MAX(salary)
 FROM salaries
 GROUP BY emp_no
 HAVING (MAX(salary)) > 150000;
 
 -- AVG salary for employees w/ avg BETWEEN 80k and 90 kill
 SELECT emp_no, ROUND(AVG(salary))
 FROM salaries
 GROUP BY emp_no
 HAVING (AVG(salary)) BETWEEN 80000 AND 90000;
