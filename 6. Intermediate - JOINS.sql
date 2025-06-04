-- JOINS (inner joins, outer joins, self joins) 
-- are used to COMBINE 2 or MORE TABLES having a COLLUMN in common

-- INNER JOIN returns ONLY the ROWS THAT MATCH in both tables
-- in other words, INNER JOINS = “Give me what both tables have in common.”
select *
from employee_demographics
INNER JOIN employee_salary
	## ON employee_id = employee_id -- this would make it hard to know which column employee_id from which table;
	## so make sure to put the clarify with tables.
    ON employee_demographics.employee_id = employee_salary.employee_id
    ;
-- shorten the code with alias
-- QUESTION: what are the age and occupation based on employee id? (given 2 tables: employee_demographics & employee_salary)
select dem.employee_id, age, occupation
from employee_demographics as dem
INNER JOIN employee_salary as sal
	on dem.employee_id = sal.employee_id;
-- -------------------------------------------------------

-- OUTER JOINS Returns all rows from both tables, and fills in NULLs where there’s no match.
-- in other words, OUTER JOINS = “Give me everything, even if there's no match”
-- TYPES of OUTER JOINS: 
-- LEFT JOINS: Get all rows from the left table, and matched rows from the right. Fill in NULLs if no match.
-- EXAMPLE BELOW:
select *
from employee_demographics as dem -- dem is our left table
left join employee_salary as sal -- sal is our right table
	on dem.employee_id = sal.employee_id
;
-- REMEMBER: LEFT JOIN just return EVERYTHING from the LEFT TABLE
-- -------------------------------------------------------

-- RIGHT JOINS: Get all rows from the right table, and matched rows from the left. Fill in NULLs if no match.
-- EXAMPLE BELOW:
select *
from employee_demographics as dem -- dem is our left table
right join employee_salary as sal -- sal is our right table
	on dem.employee_id = sal.employee_id;

-- EXPLANATION about the result: Employee ID 2 is in employee_salary (right), 
-- but not in employee_demographics (left)
-- So you still see the salary, but the name is NULL
-- SO that's how RIGHT JOIN will return everything on the right table, and fill NULL on which values don't match
-- -------------------------------------------------------

-- SELF JOIN: A table is joined to itself 
-- WHY?— useful when you want to compare rows within the same table.
-- In other words, SELF JOIN = “Match rows from the same table based on some relationship.”
-- EXAMPLE BELOW: 
-- SCENARIO: HR Deparment wants to pair up employees for a mentorship program.
-- 			Each employee will be mentored by the next person on the list (by employee_id)
-- 			Employee with ID 1 gets mentored by employee 2
-- SQL QUERIES
	select 
		sal1.employee_id as mentee_id, 
		sal1.first_name as mentee_first_name,
        sal1.last_name as mentee_last_name,
		sal2.employee_id as mentor_id, 
		sal2.first_name as mentor_first_name,
        sal2.last_name as mentor_last_name
    from employee_salary as sal1
    join employee_salary as sal2
		on sal1.employee_id + 1 = sal2.employee_id
        ;
-- -------------------------------------------------------

-- joining multiple tables together
-- Question: “Which employees are currently working, and what are their roles, salaries, and departments?"
-- SQL queries:

select dem.employee_id, dem.first_name, dem.last_name, sal.occupation, pd.department_name, sal.salary
from employee_demographics as dem
INNER JOIN employee_salary as sal
    ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments as pd
	on pd.department_id = sal.dept_id
;