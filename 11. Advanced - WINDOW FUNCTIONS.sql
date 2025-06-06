-- Finally welcome to the real deal: Advanced levels
-- WINDOW FUNCTIONS perform a calculation across a group of rows 
-- but still shows one answer per row.

-- Most Common Window Functions (Explained Simply)
-- | Function              | What It Does                            | Example in Real Life                           |
-- | --------------------- | --------------------------------------- | ---------------------------------------------- |
-- | **`ROW_NUMBER()`**    | Assigns a unique number to each row.    | Number students from 1 to 10 in a class.       |
-- | **`RANK()`**          | Gives ranks, skipping numbers for ties. | If two students are tied for 1st, next is 3rd. |
-- | **`DENSE_RANK()`**    | Like `RANK()`, but no gaps in numbers.  | If two are tied for 1st, next is 2nd.          |
-- | **`NTILE(n)`**        | Splits rows into `n` equal groups.      | Divide customers into 4 spending quartiles.    |
-- | **`LAG()`**           | Looks at a previous row’s value.        | See last month's sales for comparison.         |
-- | **`LEAD()`**          | Looks at a future row’s value.          | See next month's planned revenue.              |
-- | **`FIRST_VALUE()`**   | Gets the first value in the window.     | What was the first sale of the month?          |
-- | **`LAST_VALUE()`**    | Gets the last value in the window.      | What was the most recent sale in the month?    |
-- | **`SUM()`**           | Adds values across the window.          | Running total of sales.                        |
-- | **`AVG()`**           | Average of values across the window.    | Average score within each department.          |
-- | **`COUNT()`**         | Counts rows in the window.              | How many products per category.                |
-- | **`MIN()` / `MAX()`** | Finds smallest/largest in the window.   | Minimum salary in the team.                    |

-- What’s OVER() and PARTITION BY?
-- | Clause                     | What It Means                                                                   |
-- | -------------------------- | ------------------------------------------------------------------------------- |
-- | `OVER()`                   | Defines how the window looks. You **must** use this with window functions.      |
-- | `PARTITION BY`             | Like a **GROUP BY**, but keeps each row. It restarts the window for each group. |
-- | `ORDER BY` inside `OVER()` | Tells SQL the order of rows in the window (important for ranking, lag/lead).    |


-- DIFFERENCE BTW GROUP BY & WINDOW FUNCTIONS
-- | Feature                 | `GROUP BY`                    | Window Functions (`OVER()`)                                |
-- | ----------------------- | ----------------------------- | ---------------------------------------------------------- |
-- | ❓ What it does         | **Combines** rows into groups | **Keeps** all original rows, but add another collumn                               |
-- | 🔢 Output rows          | Fewer rows (one per group)    | Same number of rows as original                             |
-- | 🧾 Shows original data? | ❌ No, only summary per group  | ✅ Yes, plus the calculated value                          |
-- | 🧠 Purpose              | Get one result **per group**  | Get one result **per row**, while still looking at a group  |

-- GROUP BY EXAMPLE:
Select gender, avg(salary) as average_salary
from employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
group by gender;

-- WINDOW FUNCTION EXAMPLE with OVER():
Select gender, avg(salary) over () as overall_avg_salary -- over () = average salary over everything
from employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
;

-- WINDOW FUNCTION EXAMPLE with PARTITION BY:
Select gender, avg(salary) over (partition by gender) as overall_avg_salary_by_gender -- one average for each gender, shown on every row of that gender.
from employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
;

-- EXERCISES
-- BUSINESS QUESTION 1: Who is the highest-paid employee in each department?

select 
	dem.employee_id,
    dem.first_name,
    dem.last_name,
    dem.gender,
    dem.age,
    sal.occupation,
    sal.salary,
    pd.department_name,
    rank() over(partition by department_name order by salary desc) as salary_rank_in_department
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
join parks_departments as pd
	on sal.dept_id = pd.department_id
;

-- BUSINESS QUESTION 2: What is the rank of each department based on total salary?
select 
pd.department_name, 
sum(sal.salary) as total_salary,
rank() over (partition by sum(salary) order by sum(salary) desc) as dept_rank
from 
		employee_salary as sal
join parks_departments as pd
	on sal.dept_id = pd.department_id
group by pd.department_name; -- create one row per department. Like 1 row per group

-- BUSINESS QUESTION 3: What is the average salary per department, displayed next to each employee?
select *,
avg(salary) over(partition by dept_id) as avg_dept_sal
from employee_salary
;
-- BUSINESS QUESTION 4: Who is the second highest paid employee in the company?

select *,
rank() over(order by salary) as salary_rank
from employee_salary
where salary_rank = 2
;
-- wrong because  You cannot use a column alias (salary_rank) 
-- in the WHERE clause of the same SELECT because WHERE is evaluated before SELECT (although WHERE IS PUT AT LAST).

-- THE CORRECT ONE:
SELECT *
FROM (
	SELECT *,
    RANK () OVER (ORDER BY employee_salary.salary DESC) as salary_rank
    FROM employee_salary) as ranked_salaries -- you must name this derrived table (i.e. a subquery used in the FROM clause) because SQL requires it
	WHERE salary_rank = 2;									-- — without an alias, SQL doesn’t know how to refer to the resulting table.


-- BUSINESS QUESTION 5: What is the percentage of each employee's salary compared to the total company salary?

SELECT *,
concat(salary*100/sum(salary), "%") over() as salary_% -- since concat is not a window function => NO GO WITH OVER()
From employee_salary
;

-- THE CORRECT ONE:
SELECT *,
concat(ROUND(salary*100/sum(salary) over(), 2), "%")  as 'salary_%'
From employee_salary
;