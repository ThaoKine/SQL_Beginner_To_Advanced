-- LIMIT & ALIASING
-- Business question: what are the three oldest employees?
select *
from employee_demographics
order by  age desc
limit 3, 1 
-- 3 is the offset (i.e., skip the first 3 rows),
-- 1 is the count (i.e., return 1 row after skipping 3 rows).
;

-- Aliasing = giving temporary name
-- business question: what gender with the average age over 40?
select gender, avg(age) as avg_age
from employee_demographics
group by gender
having avg_age > 40;