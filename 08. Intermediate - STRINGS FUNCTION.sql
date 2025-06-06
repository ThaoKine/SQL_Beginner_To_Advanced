-- STRING FUNCTIONS

-- | Function                    | What it does                                      | Example                                 | Result                      |
-- | --------------------------- | ------------------------------------------------- | --------------------------------------- | --------------------------- |
-- | `LOWER()`                   | Makes all letters **lowercase**                   | `LOWER('HELLO')`                        | `'hello'`                   |
-- | `UPPER()`                   | Makes all letters **uppercase**                   | `UPPER('hi there')`                     | `'HI THERE'`                |
-- | `LENGTH()`                  | Counts the **number of characters**               | `LENGTH('abcde')`                       | `5`                         | speaking more about how LENGTH FUNCTION is used IRL: to check typos, check texts fit the system, and clean up.
-- | `LEFT()`                    | Gets a few letters from the **start** of the text | `LEFT('HELLO', 2)`                      | `'HE'`                      |
-- | `RIGHT()`                   | Gets letters from the **end** of the text         | `RIGHT('HELLO', 3)`                     | `'LLO'`                     |
-- | `SUBSTRING()` or `SUBSTR()` | Pulls a piece from the **middle**                 | `SUBSTRING('HELLO', 2, 3)`              | `'ELL'`                     |
-- | `CONCAT()`                  | **Joins** two or more strings together            | `CONCAT('Hi', ' ', 'there')`            | `'Hi there'`                |
-- | `TRIM()`                    | Removes **spaces** from start and end             | `TRIM('  hello  ')`                     | `'hello'`                   | RTRIM = TRIM THE RIGHT, LTRIM = TRIM THE LEFT
-- | `REPLACE()`                 | **Replaces** part of a string with something else | `REPLACE('ice cream', 'cream', 'cube')` | `'ice cube'`                |
-- | `INSTR()`                   | Finds **where** a word or letter starts           | `INSTR('hello', 'l')`                   | `3` (position of first `l`) |
-- | `REVERSE()`                 | Flips the string **backward**                     | `REVERSE('abc')`                        | `'cba'`                     |
-- | `LOCATE()`                  | Finds the position of a substring in a string     | `LOCATE('world', 'Hello world')`        | `7`                         |

-- LENGTH FUNCTION
SELECT length('SKYFALL');

SELECT first_name, length(first_name) as length
FROM employee_demographics
ORDER BY length;

-- UPPER FUNCTION
SELECT first_name, upper (first_name) 
FROM employee_demographics;

-- TRIM FUNCTION
select trim('    hello '); -- remember, it only removes the space at the start and the end, not in between words.

-- LEFT, RIGHT, SUBSTRING
SELECT first_name,
substring(first_name,3, 2),
left(first_name, 4),
right(first_name, 4) 
birth_date,
substring(birth_date, 6, 2) as birth_month
FROM employee_demographics;

-- ---
-- REPLACE FUNCTIONS
SELECT first_name,
replace(first_name, 'e', 'a')
FROM employee_demographics;
-- ----------------------------------------------------
-- LOCATE FUNCTIONS
SELECT locate('x','Alexander'); -- locate the position of x in Alexander

SELECT first_name,
LOCATE ('AN', first_name)
FROM employee_demographics;

-- CONCAT FUNCTIONS
select first_name, last_name,
concat( first_name, ' ', last_name) as full_name
from employee_demographics;
