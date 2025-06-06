select *
From parks_and_recreation.employee_demographics;

select first_name, last_name, birth_date, age, (age*10)*2 + 10
From parks_and_recreation.employee_demographics;

select distinct gender
From parks_and_recreation.employee_demographics;
