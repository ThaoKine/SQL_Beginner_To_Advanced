-- having & where 
select gender, avg(age)
from employee_demographics
group by gender
where avg(age) > 40
;

## the SQL queries above DON'T WORK because 
## WHERE clause filters rows before aggregation happens, so AVG(age) is not available at that stage.
## WHY THOUGH?
## Because WHERE works on individual rows. For example:
## SELECT AVG(age)
## FROM employee_demographics
-- WHERE age > 20;
-- Here, SQL first reads all rows from employee_demographics.
-- Then WHERE age > 20 filters out rows where age is 20 or less.
-- Then AVG(age) is calculated only from the remaining rows.
-- If WHERE came after aggregation, it wouldn’t be able to filter the raw data 

-- SQL actually processes your query in the following logical order:
-- 1. FROM (including joins, subqueries, etc.)
-- 2. WHERE (filter INDIVIDUAL ROWS before grouping)
-- 3. GROUP BY (create groups)
-- 4. HAVING (filter groups AFTER Grouping — working on Grouped/aggregated data like AVG are available)
-- 5. SELECT (choose what to return)
-- 6. ORDER BY
-- 7. LIMIT

select gender, avg(age)
from employee_demographics
group by gender
HAVING avg(age) > 40
;
-- EXPLANATION:
-- No rows are filtered out first.
-- Groups are formed by gender.
-- Then only those gender groups with an average age > 40 are kept.

select occupation, avg(salary)
from employee_salary
where occupation like '%Manager%' -- this works because WHERE clause filter INDIVIDUAL rows on a NON-AGGREGATE COLUMN
group by occupation
having avg(salary) > 70000;

-- What BUSINESS QUESTION do these SQL queries actually answer?:
-- Which types of managers earn over $70,000 on average?
