SELECT * 
FROM parks_and_recreation.employee_demographics;
# Where clause filters ROW data, Select filters COLUMN data
SELECT * 
FROM parks_and_recreation.employee_salary
WHERE first_name = 'Leslie'; ## return the EXACT MATCH

SELECT * 
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000;

SELECT * 
FROM parks_and_recreation.employee_salary
WHERE salary < 50000;

SELECT * 
FROM parks_and_recreation.employee_demographics
where gender = 'Female';

# != means NOT EQUAL TO
SELECT * 
FROM parks_and_recreation.employee_demographics
where gender != 'Female';

-- AND, OR, NOT -- LOGICAL OPERATORS

SELECT * 
FROM parks_and_recreation.employee_demographics
where birth_date > '1985-01-01' and gender != 'Female';

SELECT * 
FROM parks_and_recreation.employee_demographics
where birth_date > '1985-01-01' 
or not gender = 'Female';

SELECT * 
FROM parks_and_recreation.employee_demographics
where (first_name = 'Leslie' and age = 44) or age > 55;

-- With parentheses (), I can put a whole conditional in it and outside of it is ANOTHER ONE. 
-- In this case, If one's name is Leslie and age is 44, then MySQL will return 1 row. OR ELSE, anyone's age is over 55 will be returned.

-- LIKE STATEMENT
## % and _

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'Jer%'; ## LIKE Jer% = Jer and anything goes AFTER Jer

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE '%y'; ## LIKE %y = anything goes BEFORE y

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE '%r%'; 

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'A__'; ## A__ means value starts with A + 2 characters (no more or less)
## so underscore is to limit the number of the character

 SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'A__%'; -- 'A__%' means start with A + 2 characters + anything goes AFTER that