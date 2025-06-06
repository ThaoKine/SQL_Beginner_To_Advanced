select *
from employee_demographics;

## Group by = combine rows that have the same values

select first_name
from employee_demographics
GROUP BY gender; 
-- here, it will not return any results because GROUP BY will only combines rows.
-- Meanwhile, the first name column doesn't have any match in terms of values.

select occupation
from employee_salary
group by occupation; 

## why we CAN'T SELECT FIRST_NAME COLLUMN?
## Imagine this table:

-- first_name	occupation
-- Alice	    Engineer
-- Bob	        Engineer
-- Charlie	    Manager

-- If we GROUP BY occupation, then:

-- All "Engineer" rows are grouped into one.

-- All "Manager" rows are grouped into one.

-- But then... which first_name should it show for "Engineer"? Alice or Bob? SQL doesn’t know. That’s why you can’t just select first_name without an aggregate function.
## GROUP BY multiple columns =  SQL will group the rows by the UNIQUE MATCHES of those columns.

select occupation, salary
from employee_salary
group by occupation, salary; 
-- 2 ROWS with Office Manager with different salary: 50,000 and 60,000 turn up.
-- This is because they have different salary, if the table has the same salary, then, it would be just 1 line.

select gender, avg(age), max(age), min(age), count(age) ## it will turn up 5 collumns,
from employee_demographics
GROUP BY gender;

-- ORDER BY = ORDER THE RESULT in Ascending (ASC) (A-Z) or Descending (DESC) (Z-A) order
select *
from employee_demographics
order by gender , age DESC 
## Use ORDER BY gender, age if you want to group by gender and then sort ages inside each group.
## Use ORDER BY age, gender if you want to see a list sorted by age, regardless of gender. 
