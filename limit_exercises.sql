-- 1. Created/Named

-- 2. find unique titles
SELECT DISTINCT title
 FROM titles;
 -- list first 10 distinct last name sorted DESC 
 SELECT DISTINCT last_name
  FROM employees
  ORDER BY last_name DESC
  LIMIT 10;
  
  -- 3. employees hired in 90's and born on Xmas
  SELECT *
  FROM employees
  WHERE (YEAR(hire_date) BETWEEN 1990 AND 1999)
   AND  (MONTH(birth_date) = 12 AND 
         DAY(birth_date) = 25);
-- first 5 hired in 90's and born on Xmas
SELECT *
  FROM employees
  WHERE (YEAR(hire_date) BETWEEN 1990 AND 1999)
   AND  (MONTH(birth_date) = 12 
		  AND DAY(birth_date) = 25)
ORDER BY hire_date
LIMIT 5;
-- employee names are (in order of hire): Cappello, A., Mandell, U., Schreiter, B., Kushner, B., and Stroustrup, P.

-- 4. Now return the 10th batch of 5 results -- 0 5 10 15 20    25 30 35 40 45
SELECT *
  FROM employees
  WHERE (YEAR(hire_date) BETWEEN 1990 AND 1999)
   AND  (MONTH(birth_date) = 12 
		  AND DAY(birth_date) = 25)
ORDER BY hire_date
LIMIT 5 OFFSET 45;
-- Page 10: Narwekar, Farrow, Karcich, Lubachevsky, Fontan
-- the relationship is (Page# - 1) * (Number of Entries per Page). in this case: (10 - 1) * 5