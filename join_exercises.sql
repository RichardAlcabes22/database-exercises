SHOW DATABASES;
-- 1. select all records from users and roles tables
USE join_example_db;
SHOW TABLES;
SELECT *
FROM users;
SELECT *
FROM roles;
-- 2. use join/ left join/ right join
SELECT users.name,roles.name
FROM users 
  JOIN roles
  ON users.role_id = roles.id;
  
SELECT users.name, roles.name
FROM users
  LEFT JOIN roles
  ON users.role_id = roles.id;
  
SELECT users.name, roles.name
FROM users
  RIGHT JOIN roles
  ON users.role_id = roles.id;
  
-- 3. use count and list roles with number of users

SELECT roles.name, COUNT(users.name)
FROM roles
  LEFT JOIN users
  ON roles.id = users.role_id
  GROUP BY roles.name;
  
-- 1. use employees
USE employees;

-- 2. list each dept along with CURRENT dept manager
SELECT * 
FROM departments;
SELECT * 
FROM dept_manager;
SELECT * 
FROM employees
LIMIT 10;

SELECT departments.dept_name as Dept_Name,
       CONCAT(employees.first_name,' ',employees.last_name) as Dept_Manager 
 FROM departments
   JOIN dept_manager
   ON  departments.dept_no = dept_manager.dept_no
     JOIN employees
     ON dept_manager.emp_no = employees.emp_no
 WHERE dept_manager.to_date LIKE '9999%';

-- 3. Name all departments currently managed by women
SELECT departments.dept_name as Dept_Name,
       CONCAT(employees.first_name,' ',employees.last_name) as Dept_Manager 
 FROM departments
   JOIN dept_manager
   ON  departments.dept_no = dept_manager.dept_no
     JOIN employees
     ON dept_manager.emp_no = employees.emp_no
 WHERE dept_manager.to_date LIKE '9999%'
   AND employees.gender = 'F';
   
-- 4. title of employees in Customer Service dept
/*
SELECT * 
FROM titles;
SELECT *
FROM dept_emp;
*/
SELECT titles.title, COUNT(*)
FROM departments
  JOIN dept_emp
  ON departments.dept_no = dept_emp.dept_no
    JOIN titles
    ON dept_emp.emp_no = titles.emp_no
WHERE departments.dept_no = 'd009'
  AND dept_emp.to_date LIKE '9999%'
  AND titles.to_date LIKE '9999%'
GROUP BY titles.title;

-- 5. current salary of all current managers use #2 QUERY !!!!!!!
/*
SELECT *
FROM salaries
LIMIT 10;
*/
SELECT departments.dept_name as Dept_Name,
       CONCAT(employees.first_name,' ',employees.last_name) as Dept_Manager, 
       salaries.salary
 FROM departments
   JOIN dept_manager
   ON  departments.dept_no = dept_manager.dept_no
     JOIN employees
     ON dept_manager.emp_no = employees.emp_no
       JOIN salaries
       ON employees.emp_no = salaries.emp_no
 WHERE dept_manager.to_date LIKE '9999%'
   AND salaries.to_date LIKE '9999%';
   
-- 6. Find number current emp in each dept
SELECT de.dept_no, d.dept_name, COUNT(de.emp_no)
FROM dept_emp as de
  JOIN departments as d
  ON de.dept_no = d.dept_no
WHERE de.to_date LIKE '9999%'
GROUP BY de.dept_no;

-- 7. Find dept with highest CURRENT avg sal
SELECT de.dept_no, d.dept_name, COUNT(de.emp_no), ROUND(AVG(s.salary),2) as AVG_Salary
FROM dept_emp as de
  JOIN departments as d
  ON de.dept_no = d.dept_no
    JOIN salaries as s
    ON de.emp_no = s.emp_no
WHERE de.to_date LIKE '9999%'
  AND s.to_date LIKE '9999%'
GROUP BY de.dept_no
ORDER BY AVG_Salary DESC
LIMIT 1;

-- 8. Find CURRENT highest paid emp in Marketing dept
SELECT MAX(s.salary)
FROM dept_emp as de
	JOIN departments as d
	ON de.dept_no = d.dept_no
		JOIN salaries as s
		ON de.emp_no = s.emp_no
			JOIN employees as e
			ON de.emp_no = e.emp_no
WHERE de.to_date LIKE '9999%'
  AND d.dept_name LIKE 'Mark%'
;


SELECT e.first_name, e.last_name
FROM salaries as s
	JOIN employees as e
    ON s.emp_no = e.emp_no
WHERE salary = (SELECT MAX(s.salary)
				FROM dept_emp as de
					JOIN departments as d
					ON de.dept_no = d.dept_no
						JOIN salaries as s
						ON de.emp_no = s.emp_no
							JOIN employees as e
							ON de.emp_no = e.emp_no
				WHERE de.to_date LIKE '9999%'
				  AND d.dept_name LIKE 'Mark%'

				);

-- 9. Manager with largest salary
SELECT dm.emp_no,e.first_name,e.last_name,s.salary,d.dept_name
FROM dept_manager as dm
	JOIN employees as e
	ON dm.emp_no = e.emp_no
		JOIN departments as d
        ON dm.dept_no = d.dept_no
			JOIN salaries as s
            ON dm.emp_no = s.emp_no
WHERE dm.to_date LIKE '9999%'
  AND s.to_date LIKE '9999%'
ORDER BY s.salary DESC
LIMIT 1  
;

-- 10. AVG salary for each department
SELECT de.dept_no, d.dept_name, ROUND(AVG(s.salary)) as AVG_Salary
FROM dept_emp as de
  JOIN departments as d
  ON de.dept_no = d.dept_no
    JOIN salaries as s
    ON de.emp_no = s.emp_no
-- WHERE de.to_date LIKE '9999%'
  -- AND s.to_date LIKE '9999%'
GROUP BY de.dept_no
ORDER BY AVG_Salary DESC
;

-- 11. List all CURRENT emps, their depts, and their managers
SELECT e.emp_no,e.first_name, e.last_name, d.dept_name, dm.emp_no, e2.first_name, e2.last_name
FROM employees as e
  JOIN dept_emp as de
  ON e.emp_no = de.emp_no
    JOIN departments as d
    ON de.dept_no = d.dept_no
      JOIN dept_manager as dm
      ON de.dept_no = dm.dept_no
        JOIN employees as e2
        ON dm.emp_no = e2.emp_no
WHERE de.to_date LIKE '9999%'
  AND dm.to_date LIKE '9999%'
ORDER BY e.emp_no
LIMIT 20;

-- 12. Highest Paid CURRENT?? emp for each dept
SELECT de.dept_no, d.dept_name, MAX(s.salary) as MAX_Salary
FROM dept_emp as de
  JOIN departments as d
  ON de.dept_no = d.dept_no
    JOIN salaries as s
    ON de.emp_no = s.emp_no
      JOIN employees as e
      ON s.emp_no = e.emp_no
WHERE de.to_date LIKE '9999%'
  AND s.to_date LIKE '9999%'
GROUP BY de.dept_no
;
-- 
