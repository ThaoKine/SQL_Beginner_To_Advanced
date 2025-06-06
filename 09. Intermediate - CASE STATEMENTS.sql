-- CASE STATEMENTS = if-else 
-- CASE
--     WHEN condition1 THEN result1
--     WHEN condition2 THEN result2
--     ...
--     ELSE result_if_none_match (optional)
-- END
-- WHERE X BETWEEN #1 AND #2

-- SQL EXERCISE 1: sort out who's young, old, and on death's door
SELECT 
	first_name,
	last_name,
    gender,
    age,
    case 
		WHEN age <= 30 then 'young'
        WHEN age between 31 and 50 then 'old'
        ELSE "On Death's Door"
	end as 'label'
from employee_demographics;

-- SQL EXERCISE 2: the pony council sent out a memo of their bonus and pay increase for end of year.
-- we need to follow it and determine people's end of salary or the salary going into the new year 
-- and if they got a bonus, how much was it?
-- +++++++++++++++++++++++++++++++++++
-- CONDITIONS OF PAY INCREASE & BONUS
-- salary < 50,000 => 5% pay increase
-- salary > 50,000 => 7% pay increase
-- if they work in Finance department => 10% bonus
SELECT 
	sal.first_name, 
    sal.last_name, 
    sal.occupation, 
    sal.salary, 
    pd.department_name,
    CASE 
		WHEN salary < 50000 THEN salary*0.05
        WHEN salary > 50000 THEN salary*0.07
        ELSE 0
    END as pay_increase,
    CASE
		WHEN pd.department_name = 'Finance' THEN sal.salary*0.1
        ELSE 0
	END as bonus,
    sal.salary + CASE
		WHEN salary < 50000 THEN salary*0.05
        WHEN salary > 50000 THEN salary*0.07
        ELSE 0
	END
    + CASE
		WHEN department_name = 'Finance' THEN salary*0.1
        ELSE 0
	END AS total_payment
FROM 
	employee_salary as sal
INNER JOIN parks_departments as pd
	ON sal.dept_id = pd.department_id;

SELECT *
FROM parks_departments;

SELECT *
FROM employee_salary;
