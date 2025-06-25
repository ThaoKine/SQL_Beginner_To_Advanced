-- ================================================
-- ✅ Summary: Triggers vs. Events in MySQL
-- ================================================

-- 🔄 TRIGGERS:
-- Triggers run AUTOMATICALLY when a specific action (or event)
-- (INSERT, UPDATE, DELETE) happens on a table.

-- 🔔 Syntax Example:
-- CREATE TRIGGER trigger_name
-- BEFORE/AFTER INSERT/UPDATE/DELETE ON table_name
-- FOR EACH ROW
-- BEGIN
--     -- your SQL code here
-- END;

-- 🧠 Use triggers for:
-- - Logging changes to a table
-- - Automatically updating related records
-- - Enforcing complex data rules

-- 🧱 Real-life analogy:
-- Like a motion sensor light – reacts when something happens.

-- 🧪 Example Use Case:
-- Automatically copy deleted employee info to archive table.

-- 🕓 EVENTS:
-- Events run AUTOMATICALLY at a SCHEDULED time or interval.

-- 🗓️ Syntax Example:
-- CREATE EVENT event_name
-- ON SCHEDULE EVERY 1 DAY
-- DO
-- BEGIN
--     -- your SQL code here
-- END;
-- ================================================

-- 🔄 EVENTS:
-- 🧠 Use events for:
-- - Scheduled cleanup tasks (e.g., delete old data)
-- - Running reports daily/weekly
-- - Updating records periodically

-- 📦 Real-life analogy:
-- Like an alarm or scheduled task – runs on time, not on action.

-- 🧪 Example Use Case:
-- Delete logs older than 30 days every night at midnight.

-- ⚠️ Reminder:
-- To use events in MySQL, make sure the event scheduler is ON:
-- SET GLOBAL event_scheduler = ON;

-- ================================================
-- EXAMPLE for TRIGGERS: "Ensure that whenever a new employee is added to the salary system, 
-- their basic demographic information is also recorded in the employee profile system without requiring duplicate manual input."
DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
	VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Kine', 'Vincenzo', 'Data Analyst', '1000000', NULL);

select *
from employee_salary;

select *
from employee_demographics;

-- EXAMPLE for EVENTS: EVENTS TAKE PLACE WHEN IT'S SCHEDULED
-- BUSINESS SCENARIO: parks_departments want to save money, so they want to retire ppl over 60 immediately 
-- and give them lifetime pay

select *
from employee_demographics;

delimiter $$
create event delete_retirees
on schedule every 30 second
do 
begin
	delete
	from employee_demographics
    where age >=60;
end $$
delimiter ;

-- if your event CAN NOT work
show variables like 'event%';  -- to check the value is on or off

-- business requirements: Keep a log every time an employee's salary is updated, 
-- including who made the change and when.

select *
from employee_salary;
-- create the log table 

	create table salary_change_log (
		log_id INT AUTO_INCREMENT PRIMARY KEY, -- It auto-increments with each new row (1,2,3..)
        employee_id int,
        old_salary int,
        new_salary decimal (10,0),
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP -- Automatically sets itself to the current date and time (e.g., '2025-06-13 14:30:00') when a row is inserted
        );

-- create the trigger:

DELIMITER $$
CREATE TRIGGER log_change
	AFTER UPDATE ON employee_salary
    FOR EACH ROW
BEGIN
	-- only log if the salary actually changed
    if old.salary <> new.salary then
		INSERT INTO salary_change_log (employee_id, old_salary, new_salary)
	VALUES (OLD.employee_id, OLD.salary, NEW.salary);
END IF;
END $$
DELIMITER ;

alter table employee_salary add primary key (employee_id); -- this is to avoid safe mode update error (if you don't know, please google it)
UPDATE employee_salary
SET salary = 95000.00 where employee_id = 1;
UPDATE employee_salary
SET salary = 71283.00 where employee_id = 3;
select *
from employee_salary;

select *
from  salary_change_log;