-- 1. Created/Copied
/*
DESCRIBE employees;
-- 1. Done
USE employees;

-- 2. Find current/previous employees with first names 'Irena' 'Vidya' 'Maya' 709 TOTAL RECORDS
SELECT *
 FROM employees
 WHERE first_name IN ('Irena','Vidya','Maya');
 
	/* SELECT COUNT(*)
	   FROM employees
	   WHERE first_name IN ('Irena','Vidya','Maya'); 
       -- 709 Total records
	*/

-- 3.  Similar to Q2, but use OR instead of IN -- 709 Total records
/*
SELECT *
 FROM employees
 WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
*/
	 /* SELECT COUNT(*)
		 FROM employees
		 WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya'; 
         -- 709 Total records
	*/

-- 4. Find all current employees as in Q3 using OR who also are Male - 441 total records
/*
SELECT *
 FROM employees
 WHERE (first_name = 'Irena' 
	OR first_name = 'Vidya' 
	OR first_name = 'Maya'
    ) 
    AND gender = 'M';
 
	/* SELECT COUNT(*)
		 FROM employees
		 WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'M';
	*/
-- 441 total records

-- 5. Employees with last_name starts with 'E' - 7330 Total records
/*
SELECT *
 FROM employees
 WHERE last_name LIKE 'E%';
 
	 /* SELECT COUNT(*)
	 FROM employees
	 WHERE last_name LIKE 'E%'; -- 7330 Total Records
	 */
 
 -- 6. employees with last_name starts with OR ends with 'E' - 30723 Total records begin or end with 'E' - 24292 of which end with 'E'
/*
SELECT COUNT(*)
 FROM employees
 WHERE last_name LIKE 'E%' OR last_name LIKE '%E';
 
	 /* SELECT COUNT(*)
	 FROM employees
	 WHERE UPPER(last_name) LIKE 'E%' OR UPPER(last_name) LIKE '%E';
	 */
	 -- 30723 total records begin or end with 'E'
	 /* SELECT COUNT(*)
	 FROM employees
	 WHERE UPPER(last_name) LIKE '%E' AND UPPER(last_name) NOT LIKE 'E%';
	 */
	 -- 23393 total records which end with 'E'
 
 -- 7. employees with last_name starts and ends with 'E' - 899 total records start AND end with 'E'
/*
 SELECT *
 FROM employees
 WHERE UPPER(last_name) LIKE 'E%E';
 
	/* SELECT COUNT(*)
	 FROM employees
	 WHERE UPPER(last_name) LIKE 'E%E';
	 */
	 -- 899 total records
	 /* SELECT COUNT(*)
	 FROM employees
	 WHERE UPPER(last_name) LIKE '%E';
	 */
	 -- 24929 total records 
 
 -- 8. employees hired in 90's -- 135214 total records
/*
 SELECT *
  FROM employees
  WHERE YEAR(hire_date) BETWEEN 1990 AND 1999;
  
	 /*  SELECT COUNT(*)
	  FROM employees
	  WHERE YEAR(hire_date) BETWEEN 1990 AND 1999;
	  */
	 -- 135214 total records
 
-- 9. employees born on Christmas - 842 total records
/*
SELECT *
  FROM employees
  WHERE MONTH(birth_date) = 12 AND DAY(birth_date) = 25;
  -- 842 total records
  
-- 10. employees hired in 90's and born on Christmas -- 362 total records
SELECT *
  FROM employees
  WHERE (YEAR(hire_date) BETWEEN 1990 AND 1999)
   AND  (MONTH(birth_date) = 12 
		  AND DAY(birth_date) = 25);
-- 362 total reocrds

-- 11. employees with 'q' in last_name - 1873 records
SELECT *
 FROM employees 
 WHERE last_name LIKE '%q%';
 
	 /*SELECT COUNT(*)
	 FROM employees 
	 WHERE last_name LIKE '%q%';
	 */
	 -- 1873 total records
 
 -- 12. employees with 'q', but not 'qu' in last_name - 547 total records
/*
 SELECT *
  FROM employees 
  WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
-- 547 total records
*/
USE employees;
SELECT * FROM employees;
DESCRIBE employees;
------------------------------------------------------------------------
-- 2. first name Irena, Vidya, Maya order by first_name
SELECT *
 FROM employees
 WHERE first_name IN ('Irena','Vidya','Maya')
 ORDER BY first_name;
 -- Irena Reutenauer was result #1 and Last result was Vidya Simmen
 
 -- 3. first name Irena, Vidya, Maya order by first_name then by last_name
SELECT *
 FROM employees
 WHERE first_name IN ('Irena','Vidya','Maya')
 ORDER BY first_name, last_name;
 -- first row of results was Irena Acton and last person in table is Vidya Zweizig
 
 -- 4. first name Irena, Vidya, Maya order by last_name then by first_name
SELECT *
 FROM employees
 WHERE first_name IN ('Irena','Vidya','Maya')
 ORDER BY last_name, first_name;
 -- First person is Irena Acton and last person is Maya Zyda
 
 -- 5. employees with last name start and end with 'E', sorted by emp_no
 SELECT *
 FROM employees
 WHERE last_name LIKE 'E%e'
 ORDER BY emp_no;
 -- 899 employees returned first emp is 10021 Ramzi Erde and last emp is 499648 Tadahiro Erde
 
 -- 6. employees with last name start and end with 'E', sorted by hire_date newest -> oldest
  SELECT *
 FROM employees
 WHERE last_name LIKE 'E%e'
 ORDER BY hire_date DESC;
 -- 899 employees returned newest emp Teiji Eldridge and oldest emp Sergi Erde
 
 -- 7. employeees hired in 90's and born on Xmas, sorted by hire_date oldest employee on top
 
 SELECT *
  FROM employees
  WHERE (YEAR(hire_date) BETWEEN 1990 AND 1999)
   AND  (MONTH(birth_date) = 12 
		  AND DAY(birth_date) = 25)
  ORDER BY birth_date, hire_date DESC;
-- 362 employees returned first in list is Khun Bernini and last in list is Douadi Pettis
