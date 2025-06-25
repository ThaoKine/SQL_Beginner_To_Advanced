-- CTEs = Common Table Expressions
-- It's like: build your own temporary table with subquery within a main query and you NAME the table. 
-- this table is used just for the next query

-- WHY USE A CTE?
-- CTEs make your SQL:
-- 1. Easier to read
-- 2. Easier to debug
-- 3. Help you break down complex queries into steps

-- THE BASIC SYNTAX:
-- WITH cte_name AS (
--  SELECT column1, column2 -- DO NOT use SELECT *, you don’t know exactly what columns are in your CTE — especially after joins.
--  FROM some_table
--  WHERE condition or JOIN or whatever
-- )
-- SELECT *
-- FROM cte_name
-- WHERE another_condition;

-- CTEs are temporary and only exist during the query.
-- They do not change the database.
-- SQL EXAMPLE: 
with CTE_Example as (
Select 
gender, 
avg(salary) as average_salary,
max(salary) as max_salary,
min(salary) as min_salary,
count(salary) as count_salary
from employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
group by gender
)

select avg(average_salary)
from CTE_Example
;

-- BUSINESS QUESTION 1: What is the total salary and average age for each department? 
-- Version 1: use WINDOW FUNCTIONS
With Business_1 as (
	Select pd.department_name, 
    sum(sal.salary) over(partition by department_name) as total_salary,
    round(avg(dem.age) over (partition by department_name), 0) as average_age
	from employee_demographics as dem
	JOIN employee_salary as sal
		on dem.employee_id = sal.employee_id
	Join parks_departments as pd
		on sal.dept_id = pd.department_id)
select *
from Business_1
;
-- Version 2: use GROUP BY
With Business_1 as (
	Select pd.department_name, 
    sum(sal.salary) as total_salary,
    round(avg(dem.age), 0) as average_age
	from employee_demographics as dem
	JOIN employee_salary as sal
		on dem.employee_id = sal.employee_id
	Join parks_departments as pd
		on sal.dept_id = pd.department_id
	group by pd.department_name)
select *
From Business_1;

-- BUSINESS QUESTION 2: Find employees who have worked more than 10 years.
-- I want to add a new column about year_joined for each employee because the original table doesn't have it.

-- SYNTAX for adding a new column and manually filling the data:
-- ALTER TABLE employee_demographics
-- ADD year_joined INT; ## INT = Integer
-- UPDATE employee_demographics SET year_joined = 2019 WHERE department_id = 5;
-- NOTE: you shouldn't use 'Insert into' because: 
insert into employee_demographics (year_joined) -- this is wrong because it will insert a whole NEW ROW.
values
	(2019),
    (2008),
    (1999),
    (2003),
    (2000),
    (2020),
    (2010),
    (1987),
    (2001),
    (2021),
    (2023);
    
ALTER TABLE employee_demographics
ADD year_joined INT;
UPDATE employee_demographics SET year_joined = 2019 WHERE employee_id = 1;
UPDATE employee_demographics SET year_joined = 2008 WHERE employee_id = 2;
UPDATE employee_demographics SET year_joined = 1999 WHERE employee_id = 3;
UPDATE employee_demographics SET year_joined = 2003 WHERE employee_id = 4;
UPDATE employee_demographics SET year_joined = 2000 WHERE employee_id = 5;
UPDATE employee_demographics SET year_joined = 2020 WHERE employee_id = 6;
UPDATE employee_demographics SET year_joined = 2010 WHERE employee_id = 7;
UPDATE employee_demographics SET year_joined = 1987 WHERE employee_id = 8;
UPDATE employee_demographics SET year_joined = 2001 WHERE employee_id = 9;
UPDATE employee_demographics SET year_joined = 2021 WHERE employee_id = 10;
UPDATE employee_demographics SET year_joined = 2023 WHERE employee_id = 11;
UPDATE employee_demographics SET year_joined = 2006 WHERE employee_id = 12;

-- Now let's really answer the question: Find employees who have worked more than 10 years.
-- (using CTE)
with Business_2 as (
	select employee_id,
    first_name,
    last_name,
    age,
    gender,
    birth_date,
    year_joined,
    (2025-year_joined) as working_year
    from employee_demographics
    where (2025-year_joined) > 10
    order by working_year asc)
select *
from Business_2;

-- BUSINESS QUESTION 3: Who are the top 5 highest-paid employees in the Parks Department?
with Business_3 as(
	select sal.first_name,
	sal.last_name,
    sal.occupation,
    sal.salary,
    pd.department_name,
    rank () over (partition by department_name order by salary DESC) as salary_rank
from employee_salary as sal
join parks_departments as pd
	on sal.dept_id = pd.department_id)
select *
from business_3
where salary_rank <= 5
order by salary_rank ASC
group by department_name;

