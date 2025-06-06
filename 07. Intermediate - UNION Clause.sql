-- UNIONS combine the results of two or more SELECT statements (it will returns the COMBINED ROWS)
-- — like stacking one query's results on top of another.
-- RULES for UNION to work:
-- 1. The number of columns in each SELECT must be the same (or else, the columns will get mixed).
-- 2. The data types of those columns must be compatible (e.g., text with text, number with number).
-- 3. The column names are taken from the first SELECT.
-- 4. By default, UNION removes duplicate rows. (If you want to keep duplicates, use UNION ALL.)

SELECT employee_id, first_name, last_name 
FROM employee_demographics
UNION -- By default, it removes all duplicates
SELECT employee_id, first_name, last_name 
FROM employee_salary
ORDER BY employee_id asc
;

SELECT employee_id, first_name, last_name 
FROM employee_demographics
UNION ALL -- it returns everything, including duplicates
SELECT employee_id, first_name, last_name 
FROM employee_salary
ORDER BY employee_id asc
;
-- ++++++++++++++++++++++++++++++++++++++++
-- Business question: HR department wants to size down the company, so they want to know
-- old employees (>40), and high-paid employees so that they can reduce their salary
-- SQL queries

SELECT first_name, last_name, 'Old Man' as Label
FROM employee_demographics
where AGE > 40 AND GENDER = 'Male'
UNION
SELECT first_name, last_name, 'Old Lady' as Label
FROM employee_demographics
where AGE > 40 AND GENDER = 'Female'
UNION
SELECT first_name, last_name, 'Highly-paid employee' as Label
FROM employee_salary
where salary > 70000
order by first_name, last_name
;
