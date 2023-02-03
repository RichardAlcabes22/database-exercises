USE employees;
SELECT * FROM departments LIMIT 20;
SELECT * FROM dept_emp LIMIT 20;
SELECT * FROM dept_manager LIMIT 20;
SELECT * FROM employees LIMIT 20;
SELECT * FROM salaries LIMIT 20;
SELECT * FROM titles LIMIT 20;

USE sakila;
SELECT database();  -- get in oneil_2101 DB in order to CREATE temp tables
-- CREATE permissions do not exist in any other DB
DROP TABLE employees_with_departments;
-- 1. CREATE temp table in oneil_2101 DB
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT first_name, last_name, dept_name
FROM employees.employees
	JOIN employees.dept_emp de
    USING(emp_no)
		JOIN employees.departments 
        USING(dept_no)
WHERE de.to_date > CURDATE()
;
DESCRIBE employees_with_departments;

-- 1a. add column 'full_name'
ALTER TABLE employees_with_departments
	ADD full_name VARCHAR(40)	NOT NULL;
    
-- 1b. populate full_name column with values

UPDATE employees_with_departments
	SET full_name = CONCAT(first_name,' ',last_name);
    
SELECT * FROM employees_with_departments LIMIT 100;

-- 1c. DROP COLUMNS first_name and last_name

ALTER TABLE employees_with_departments
DROP COLUMN first_name, 
DROP COLUMN last_name;

-- 1d.  Another way-- CREATE the TABLE and define the data types for each column...populate each column with data...then ADD full_name and then populate it ...then DELETE 
-- first_name and last_name

-- 2. CREATE a temp table based on sakila.payment...transform amount from decimal(5,2) to integer
DROP TABLE sak_amount;
DESCRIBE sakila.payment;
SELECT COUNT(*) FROM sakila.payment;

-- Two ways to accomplish this:
-- First way is to: convert 'amount' from Decimal(5,2) to INT -- first convert to decimal (6,2) then mulitply by 100, then convert to INT

CREATE TEMPORARY TABLE sak_amount AS 
	SELECT *
    FROM sakila.payment;

DESCRIBE sak_amount;
SELECT * FROM sak_amount LIMIT 100;

ALTER TABLE sak_amount
MODIFY COLUMN amount DECIMAL(6,2) NOT NULL;

UPDATE sak_amount
SET	amount = amount * 100;

ALTER TABLE sak_amount
MODIFY COLUMN amount INT UNSIGNED NOT NULL;

-- 2nd way (not recommended) ADD new column with desired data type...complete the math...drop the old column.alter
-- minor issue is that new column is now the final column in table...may or may not be an issue.

ALTER TABLE sak_amount
ADD cents INT UNSIGNED NOT NULL;

UPDATE sak_amount
SET cents = amount * 100;

ALTER TABLE sak_amount
DROP COLUMN amount;


-- 3.  Compare current AVG(sal) in EACH Dept to overall current AVG(sal).  Use Z Score.  What is best dept to work for? the worst?
USE oneil_2101;
DROP TABLE currsal;
CREATE TEMPORARY TABLE currsal AS
	SELECT d.dept_name, ROUND(AVG(salary)) AS dept_avg
	FROM employees.departments d
		JOIN employees.dept_emp de
		ON d.dept_no = de.dept_no
			JOIN employees.salaries s
			ON de.emp_no = s.emp_no
WHERE s.to_date > CURDATE()
GROUP BY d.dept_name
;

DESCRIBE currsal;
SELECT * FROM currsal;
-- I want to recast AVG company sal as INT
ALTER TABLE currsal
MODIFY COLUMN dept_avg INT SIGNED NOT NULL;

-- Now ADD Comp AVG
ALTER TABLE currsal
ADD company_avg INT SIGNED NOT NULL;

-- now populate company_avg

UPDATE currsal
SET company_avg = (SELECT AVG(salary)
					FROM employees.salaries
					WHERE to_date > CURDATE()
					)
;
-- check it
DESCRIBE currsal;
SELECT * FROM currsal;

-- now ADD a Z Score column

ALTER TABLE currsal
ADD z_score DECIMAL(10,2) SIGNED NOT NULL;

-- finally populate the Z-Scores
UPDATE currsal
SET z_score = ABS(dept_avg - company_avg) / (SELECT STDDEV(employees.salaries.salary) FROM employees.salaries)
;
-- OF NOTE: the above Z-scores ran, but 'Data Truncated' at particular rows...
