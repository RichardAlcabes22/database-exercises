
/*
SHOW DATABASES;
SELECT *
FROM titles
LIMIT 20;
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
 */ 
 
-- 1. use employees
USE employees;

-- 2. list each dept along with CURRENT dept manager
SELECT d.dept_name, CONCAT(e.first_name,' ',e.last_name) AS Dept_Mgr
FROM departments AS d
  JOIN dept_manager as dm
  ON d.dept_no = dm.dept_no
    JOIN employees as e
    ON dm.emp_no = e.emp_no
WHERE dm.to_date > CURDATE()
GROUP BY d.dept_name,dm.emp_no;

-- 3. Name all departments currently managed by women
SELECT d.dept_name, CONCAT(e.first_name,' ',e.last_name) AS Dept_Mgr
FROM departments AS d
  JOIN dept_manager as dm
  ON d.dept_no = dm.dept_no
    JOIN employees as e
    ON dm.emp_no = e.emp_no
WHERE dm.to_date > CURDATE()
  AND e.gender = 'F'
GROUP BY d.dept_name,dm.emp_no;
   
-- 4. title of employees in Customer Service dept
/*
SELECT * 
FROM titles;
SELECT *
FROM dept_emp;
*/
SELECT t.title, COUNT(t.title)
FROM titles AS t
  JOIN dept_emp AS de
  ON t.emp_no = de.emp_no
    JOIN departments AS d
    ON de.dept_no = d.dept_no
WHERE t.to_date > CURDATE()
  AND de.to_date > CURDATE()
  AND d.dept_name LIKE 'Cust%'
GROUP BY t.title
ORDER BY t.title;

-- 5. current salary of all current managers use #2 QUERY !!!!!!!
/*
SELECT *
FROM salaries
LIMIT 10;
*/
SELECT d.dept_name, CONCAT(e.first_name,' ',e.last_name) AS Dept_Mgr, s.salary as Salary
FROM departments AS d
  JOIN dept_manager as dm
  ON d.dept_no = dm.dept_no
    JOIN employees as e
    ON dm.emp_no = e.emp_no
      JOIN salaries AS s
      ON e.emp_no = s.emp_no
WHERE dm.to_date > CURDATE()
  AND s.to_date > CURDATE()
;

-- 6. Find number current emp in each dept
SELECT d.dept_no,d.dept_name, COUNT(de.emp_no)
FROM departments as d
  JOIN dept_emp as de
  ON d.dept_no = de.dept_no
WHERE de.to_date > CURDATE()
GROUP BY dept_no
ORDER BY dept_no;

-- 7. Find dept with highest CURRENT avg sal
SELECT d.dept_name, ROUND(AVG(s.salary),2) AS AVG_Sal
FROM departments AS d
  JOIN dept_emp AS de
  ON d.dept_no = de.dept_no
    JOIN salaries AS s
    ON de.emp_no = s.emp_no
WHERE de.to_date > CURDATE()
  AND s.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY AVG_Sal DESC
LIMIT 1;

-- 8. Find CURRENT highest paid emp in Marketing dept
SELECT e.first_name, e.last_name-- , s.salary
FROM employees AS e
  JOIN dept_emp AS de
  ON e.emp_no = de.emp_no
    JOIN departments AS d
    ON de.dept_no = d.dept_no
      JOIN salaries AS s
      ON e.emp_no = s.emp_no
WHERE d.dept_name LIKE 'Mark%'
  AND de.to_date > CURDATE()
  AND s.to_date > CURDATE()
ORDER BY s.salary DESC
LIMIT 1;

-- 9. Manager with largest salary
SELECT e.first_name, e.last_name AS Dept_Mgr, s.salary as Salary,d.dept_name
FROM departments AS d
  JOIN dept_manager as dm
  ON d.dept_no = dm.dept_no
    JOIN employees as e
    ON dm.emp_no = e.emp_no
      JOIN salaries AS s
      ON e.emp_no = s.emp_no
WHERE dm.to_date > CURDATE()
  AND s.to_date > CURDATE()
ORDER BY Salary DESC
LIMIT 1;

-- 10. AVG salary for each department
SELECT d.dept_name, ROUND(AVG(s.salary)) AS AVG_Sal
FROM departments AS d
  JOIN dept_emp AS de
  ON d.dept_no = de.dept_no
    JOIN salaries AS s
    ON de.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY AVG_Sal DESC;

