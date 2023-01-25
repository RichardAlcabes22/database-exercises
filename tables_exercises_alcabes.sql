-- #1 Done

-- #2 Done

-- #3
USE employees;

-- #4 
SHOW TABLES;

-- #5 int/date/varchar(14 and 16)/enumeration('M','F')
DESCRIBE employees;

-- #6 Which tables contain numeric type columns?
DESCRIBE departments; -- no numeric attributes
DESCRIBE dept_emp; -- emp_no INT/ 
DESCRIBE dept_manager; --  emp_no INT/ 
DESCRIBE employees;  -- emp_no INT/ 
DESCRIBE salaries; -- emp_no INT/ salary INT/ 
DESCRIBE titles; -- emp_no INT/ 

-- #7 Which tables contain string type?
DESCRIBE departments; -- dept_no CHAR/ dept_name VARCHAR
DESCRIBE dept_emp; -- dept_no CHAR
DESCRIBE dept_manager; --  dept_no CHAR
DESCRIBE employees;  -- first_name VARCHAR(14)/ last_name VARCHAR(16)
DESCRIBE salaries; -- no string attributes
DESCRIBE titles; -- title VARCHAR(50)

-- #8 Which contain date type?
DESCRIBE departments; -- from_date DATE/ to_date DATE
DESCRIBE dept_emp; -- from_date DATE/ to_date DATE
DESCRIBE dept_manager; --  birth_date DATE/ hire_date DATE
DESCRIBE employees;  -- no date sttributes
DESCRIBE salaries; -- from_date DATE/ to_date DATE
DESCRIBE titles; -- from_date DATE/ to_date DATE

-- #9 What is the relationship between the employees and departments tables?
/*      Two distinct tables within the employees database.  There does not appear to be any foreign key relation between the two tables, as of yet. 
      Cardinality has not yet been established either.
*/

-- #10 show the scripting used to create the dept_manager table:
SHOW CREATE TABLE dept_manager;