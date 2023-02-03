USE employees;
SELECT * FROM departments LIMIT 20;
SELECT * FROM dept_emp LIMIT 20;
SELECT * FROM dept_manager LIMIT 20;
SELECT * FROM employees LIMIT 20;
SELECT * FROM salaries LIMIT 20;
SELECT * FROM titles LIMIT 20;

-- 1. employees dept_no, hire_date, end_date, is_current (1 or 0)

SELECT e.emp_no, hire_date, MAX(to_date),
		IF(MAX(to_date) > CURDATE(),1,0)
FROM employees e
	JOIN salaries s
    ON e.emp_no = s.emp_no
GROUP BY e.emp_no
-- LIMIT 100
;

-- 2. ALL emp names, 'alpha_group' A-H / I-Q / R-Z based on 1st LETTER of last_name

SELECT first_name, last_name,SUBSTR(last_name,1,1) AS Init,

	CASE
		WHEN SUBSTR(last_name,1,1)  IN ('A','B','C','D','E','F','G','H') 	THEN 'A-H'
        WHEN SUBSTR(last_name,1,1)  IN ('I','J','K','L','M','N','O','P','Q') 	THEN 'I-Q'
        WHEN SUBSTR(last_name,1,1)  IN ('R','S','T','U','V','W','X','Y','Z') 	THEN 'R-Z'
        ELSE 'Non-Latin Char'
    
    END AS Surname_Group
    
FROM employees
LIMIT 100
;

-- 3. COUNT ALL employees born in each decade

SELECT COUNT(*),

	CASE
		WHEN YEAR(birth_date)  BETWEEN 1950 AND 1959	THEN '50s'
        WHEN YEAR(birth_date)  BETWEEN 1960 AND 1969	THEN '60s'
        WHEN YEAR(birth_date)  BETWEEN 1970 AND 1979	THEN '70s'
        ELSE 'UNK'
    
    END AS Decade_Group
    
FROM employees
GROUP BY Decade_Group
;
/*
SELECT birth_date -- 1952 - 1965
FROM employees
ORDER BY birth_date 
;
*/

 -- 4. CURRENT AVG salary for each dept group: R-D SAles-MArketing, Prod-QM, Fin-HR, CS
 
 -- find CURRENT AVG(sal)
 SELECT AVG(salary)
 FROM salaries
 WHERE to_date > CURDATE();
 
 --  AVG salary for each dept
 
 SELECT dept_name, AVG(salary)
 FROM departments d
	JOIN dept_emp de
    ON d.dept_no = de.dept_no
		JOIN salaries s
        ON de.emp_no = s.emp_no
WHERE s.to_date > CURDATE()
GROUP BY dept_name
 ;
 
 -- allocate each dept into dept_grouping then calculate AVG(sal)
 
 SELECT  
	CASE
		WHEN d.dept_name IN ('Research','Development')			THEN 'R&D'
		WHEN d.dept_name IN ('Sales','Marketing')				THEN 'Sales & Marketing'
		WHEN d.dept_name IN ('Production','Quality Management')	THEN 'Prod & QM'
        WHEN d.dept_name IN ('Finance','Human Resources')		THEN 'Finanace & HR'
        ELSE d.dept_name
    END as Dept_Group,
    ROUND(AVG(salary)) AS Group_AVG
 FROM departments d
	JOIN dept_emp de
    ON d.dept_no = de.dept_no
		JOIN salaries s
        ON de.emp_no = s.emp_no
WHERE s.to_date > CURDATE()
GROUP BY Dept_Group
 ;