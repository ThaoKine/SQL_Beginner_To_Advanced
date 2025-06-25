-- Temporary tables is like a scratchpad (giấy nháp) you create to store some data temporarily. 
-- ===========================
-- 🌟 TEMPORARY TABLE vs CTE 🌟
-- ===========================

-- 🔹 TEMPORARY TABLE:
-- A scratch table you can use and update multiple times during your session.

-- ✅ Key Features:
-- - Created with CREATE TEMPORARY TABLE
-- - Can be used in multiple queries
-- - Can be updated, indexed, and reused
-- - Automatically removed when the session ends

-- 🧠 Example:
## CREATE TEMPORARY TABLE temp_sales AS
## SELECT product_id, SUM(amount) AS total
## FROM sales
## GROUP BY product_id;

## SELECT * FROM temp_sales WHERE total > 1000;

-- 🔹 CTE (Common Table Expression):
-- A temporary result set used in a single query to make it more readable.

-- ✅ Key Features:
-- - Written using WITH
-- - Only works inside one query
-- - Cannot be updated or reused in another query
-- - Useful for breaking complex queries into steps

-- 🧠 Example:
## WITH temp_sales AS (
##  SELECT product_id, SUM(amount) AS total
##  FROM sales
##  GROUP BY product_id
)
## SELECT * FROM temp_sales WHERE total > 1000;

-- ✅ Quick Comparison:

-- | Feature             | Temporary Table        | CTE (WITH clause)        |
-- |---------------------|------------------------|---------------------------|
-- | Lifespan            | Whole session          | One query only            |
-- | Reusable?           | Yes                    | No                        |
-- | Can modify data?    | Yes (INSERT/UPDATE)    | No                        |
-- | Use Case            | Multi-step operations  | Clean single query        |

-- 🎯 Tip:
-- - Use CTE when the logic is short and needed only once.
-- - Use TEMPORARY TABLE when you need to reuse or manipulate the data.

-- SQL example (make a whole new data table):
DROP TEMPORARY TABLE IF EXISTS temp_table;
CREATE TABLE temp_table
	(employee_id VARCHAR(50), -- The employee_id column can store up to 50 characters.
	relationship_status VARCHAR(50),
    mood VARCHAR (100)
    );

-- FILLING OUT THE DATA
TRUNCATE TABLE temp_table;
INSERT INTO temp_table
VALUES (1, 'Single', "I'm done with life"),
	(2, 'Divorced', 'I love me so much'),
    (3, 'Married', 'I want to get a divorce'),
    (4, 'Single', 'I want to hold someone'),
    (5, 'Just broke-up', 'I want to be a rich aunt'),
    (6, "Haven't broken up but want to", 'I want to be single soon'),
    (7, 'Situationship', "Isn't this good enough for us?"),
    (8, 'Got silence treatment', "I'll be more silent than thin air"),
    (9, 'In love with men in books', 'Only imaginary men can satisfy me'),
    (10, 'Never have a lover', "I don't really care, I need money though"),
    (11, 'Talking to a cat', "At least they don’t ghost me"),
    (12, 'Emotionally unavailable', "Even I left myself on read")

;

select *
from temp_table
;