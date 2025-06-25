-- STORED PROCEDURES = a set of SQL commands (like SELECT, INSERT, UPDATE, DELETE) 
-- that are saved in the database and can be reused.

-- BASIC SYNTAX:
CREATE PROCEDURE SelectAllCustomers
AS
SELECT * FROM Customers
;

-- EXAMPLE:

-- To Execute 

CREATE PROCEDURE large_salaries ()
select *
from employee_salary
where salary >= 5000;

CALL large_salaries (); -- TO execute the procedure
-- ================================================

-- WHY SHOULD WE USE DELIMITTER?

CREATE PROCEDURE large_salaries ()
select *
from employee_salary
where salary >= 5000; -- ' ; ' is the default delimiter to separate multiple statements.

-- HOWEVER, in stored procedure, there are a SET OF MULTIPLE COMMANDS like these:

CREATE PROCEDURE large_salaries2 ()
select *
from employee_salary
where salary >= 5000; -- the STORED PROCEDURE EXECUTION STOPS HERE, since ' ; ' signals the end of the execution. 
select * -- from here, the result is complete different. but what we want is the procedure will perform all. So this is where the Delimiter will come handy. 
from employee_salary
where salary >= 10000;

-- EXAMPLE OF DELIMITER 
##+++++++++++++++++++++
DELIMITER $$
CREATE PROCEDURE large_salaries3 ()
BEGIN
select *
from employee_salary
where salary >= 5000;  
select * 
from employee_salary
where salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries3 ();
-- ++++++++++++++++++++++
-- PARAMETERS
## imagine you're ordering a pizza. You tell the pizza place you want a pizza, but they need more information, right? Like what toppings you want.
## In SQL, a "parameter" is like a #blank space# or #a placeholder# in your instructions (your SQL query) where you can LATER FILL IN specific values.

-- Example (Conceptual): let's say you have a table of customers.
-- Without parameters: If you want to find the customer named "Alice", you might write:

SELECT * FROM Customers WHERE Name = 'Alice';

-- If you then want to find the customer named "Bob", you'd have to change the query:

SELECT * FROM Customers WHERE Name = 'Bob';

-- With parameters: You could write a query once that uses a parameter:

SELECT * FROM Customers WHERE Name = @CustomerName;

-- Here, @CustomerName is the parameter. 
-- Then, when you run the query, you tell the database what value to use for @CustomerName. 
-- So, you could run it with @CustomerName = 'Alice' 
-- and then run it again with @CustomerName = 'Bob' without changing the query itself.

-- EXAMPLE OF PARAMETER: 
DELIMITER $$
CREATE PROCEDURE large_salaries_parameterized(IN min_salary INT , IN very_large_salary INT) 
																							-- IN min_salary INT: IN = input, INT = integer
                                                                                           -- = min_salary are the integer input into this stored procedure
BEGIN
    -- Select employees with salary greater than or equal to min_salary
    SELECT *
    FROM employee_salary
    WHERE salary >= min_salary;

    -- Select employees with salary greater than or equal to very_large_salary
    SELECT *
    FROM employee_salary
    WHERE salary >= very_large_salary;
END $$

DELIMITER ;

-- Example Usage:
-- To call the procedure with min_salary = 5000 and very_large_salary = 10000:
CALL large_salaries_parameterized(5000, 10000);

-- To call the procedure with min_salary = 7000 and very_large_salary = 12000:
CALL large_salaries_parameterized(7000, 12000);

-- +++++++++++++++++ More Salary questions:
-- 1. What is the total salary cost for each department in a given year?
ALTER TABLE employee_salary ADD INDEX (dept_id); -- Index here is like the table of content in a book, you base on index to find the chapter and go straight to the chapter's page faster.

UPDATE employee_salary SET year = 2020 WHERE dept_id = 1;
UPDATE employee_salary SET year = 2021 WHERE dept_id = 2;
UPDATE employee_salary SET year = 2022 WHERE dept_id = 3;
UPDATE employee_salary SET year = 2023 WHERE dept_id = 4;
UPDATE employee_salary SET year = 2024 WHERE dept_id = 5;
UPDATE employee_salary SET year = 2025 WHERE dept_id = 6;

DROP PROCEDURE IF EXISTS total_sal_per_dp;
Delimiter $$
create procedure total_sal_per_dp(in given_year int)
begin 
	select dept_id, department_name, sum(salary)
    from employee_salary
    join parks_departments
		on employee_salary.dept_id = parks_departments.department_id
    where year = given_year 
    group by dept_id;
end $$
delimiter ;

call total_sal_per_dp(2022);


SHOW INDEX FROM employee_salary;
