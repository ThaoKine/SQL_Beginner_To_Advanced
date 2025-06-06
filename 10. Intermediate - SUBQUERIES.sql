-- Subqueries = a query inside another query
-- Think of it like this: 
-- A subquery answers a smaller question first — so the main query can use that answer.
-- Subqueries usually in WHERE, FROM, SELECT CLAUSES.
-- BUSINESS QUESTION: “Who are the employees working in department 1?”
SELECT *
FROM employee_demographics
WHERE employee_id IN -- Use IN when you're checking if a value matches any value in a list or subquery
					(SELECT employee_id 
						FROM employee_salary
						WHERE dept_id = 1)
;
-- MY OWN EXERCISES:
-- BUSINESS QUESTION: Which employees are older than the average age of all employees?

select *
from employee_demographics
where age > avg(age); -- this is wrong because The WHERE clause filters individual rows before any aggregation (like AVG()) happens.

-- The correct one:
select *
from employee_demographics
where age > (select avg(age)
				from employee_demographics);
-- BUSINESS QUESTION: Who are the youngest employees within each department? (this is freaking hard, boohoo, but please keep going)
SELECT 
	dem.employee_id,
    dem.first_name,
    dem.last_name,
    dem.age,
    sal.occupation,
    pd.department_name    
from
	employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
inner join parks_departments as pd
	on sal.dept_id = pd.department_id
where dem.age = (
	select min(age)
	from employee_demographics as dem2 -- you must give it a different aliasing, or else,  SQL wouldn't know whether you're referring to the outer employee or the one inside the subquery
		inner join employee_salary as sal2
			on dem2.employee_id = sal2.employee_id
		where sal2.dept_id = sal.dept_id -- correlated part of the subquery. It says “Only look at employees (dem2) who are in the same department as the current employee (sal.dept_id) from the outer query.”
)
order by age;
                    
-- BUSINESS QUESTION: List employees whose age is above the average age of their department.

select 
dem.employee_id,
dem.first_name,
dem.last_name,
dem.gender,
dem.age,
sal.occupation,
sal.salary,
pd.department_name 
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
inner join parks_departments as pd
	on sal.dept_id = pd.department_id
where age > (
	select avg(age)
    from employee_demographics as dem2
    inner join employee_salary as sal2 
		on dem2.employee_id=sal2.employee_id -- Looks at all other employees
        where sal2.dept_id = sal.dept_id) -- Filters them by  this queries, so only same-department people are included.
order by age;
-- BUSINESS QUESTION: Which employees earn the highest salary in their department?
select *
from employee_salary as sal
inner join parks_departments as pd
	on sal.dept_id = pd.department_id
where salary = (
	select max(salary) -- you must put max inside the brackets because WHERE does not work with aggregation.
    from employee_salary as sal2
    inner join parks_departments as pd2
		on sal2.dept_id = pd2.department_id
        where sal2.dept_id = sal.dept_id)
;
-- BUSINESS QUESTION: Which departments have employees with a salary below the department average?.
select *
from employee_salary as sal
where salary < (
	select avg(salary)
    from employee_salary as sal2
    inner join parks_departments as pd
		on sal2.dept_id = pd.department_id
	where sal2.dept_id = sal.dept_id
)
order by salary asc
;


select * 
from employee_demographics;

select *
from employee_salary;

select * 
from parks_departments;