SELECT *
FROM dirty_cafe_sales;

CREATE TABLE cafe_sales
LIKE dirty_cafe_sales;

INSERT INTO cafe_sales
SELECT *
FROM dirty_cafe_sales;

SELECT *
FROM cafe_sales;

ALTER TABLE cafe_sales
RENAME COLUMN `Transaction ID` TO transaction_id,
RENAME COLUMN `Price Per Unit` TO price_per_unit,
RENAME COLUMN `Total Spent` TO total_spent,
RENAME COLUMN `Payment Method` TO payment_method,
RENAME COLUMN `Transaction Date` TO transaction_date;

UPDATE cafe_sales
SET price_per_unit = REPLACE(price_per_unit, '$', '');

UPDATE cafe_sales
SET total_spent = REPLACE(total_spent, '$', '');

SELECT *
FROM cafe_sales;

SELECT DISTINCT item
FROM cafe_sales;

UPDATE cafe_sales
SET item = NULL
WHERE item IN ('ERROR', 'UNKNOWN', '');

UPDATE cafe_sales
SET quantity = NULL
WHERE quantity IN ('ERROR', 'UNKNOWN', '');

UPDATE cafe_sales
SET price_per_unit = NULL
WHERE price_per_unit IN ('ERROR', 'UNKNOWN', '');

UPDATE cafe_sales
SET total_spent = NULL
WHERE total_spent IN ('ERROR', 'UNKNOWN', '');

UPDATE cafe_sales
SET payment_method = NULL
WHERE payment_method IN ('ERROR', 'UNKNOWN', '');

UPDATE cafe_sales
SET location = NULL
WHERE location IN ('ERROR', 'UNKNOWN', '');

UPDATE cafe_sales
SET transaction_date = NULL
WHERE transaction_date IN ('ERROR', 'UNKNOWN', '');

UPDATE cafe_sales
SET total_spent = quantity * price_per_unit
WHERE total_spent IS NULL
	AND quantity IS NOT NULL
    AND price_per_unit IS NOT NULL;
    
UPDATE cafe_sales
SET price_per_unit = quantity / total_spent
WHERE price_per_unit IS NULL
	AND quantity IS NOT NULL
    AND total_spent IS NOT NULL;
    
UPDATE cafe_sales
SET transaction_date = STR_TO_DATE(transaction_date, '%m/%d/%Y');

UPDATE cafe_sales
SET payment_method = 'Unspecified'
WHERE payment_method IS NULL;

UPDATE cafe_sales
SET location = 'Unknown'
WHERE location IS NULL;

DELETE
FROM cafe_sales
WHERE item IS NULL;

DELETE
FROM cafe_sales
WHERE price_per_unit IS NULL
	AND total_spent IS NULL;

ALTER TABLE cafe_sales
MODIFY COLUMN price_per_unit DECIMAL(10,2);

ALTER TABLE cafe_sales
MODIFY COLUMN total_spent DECIMAL(10,2);

ALTER TABLE cafe_sales
MODIFY COLUMN quantity INT;

ALTER TABLE cafe_sales
MODIFY COLUMN transaction_date DATE;

SELECT COUNT(*) AS row_to_delete
FROM cafe_sales
WHERE item IS NULL;

SELECT *
FROM cafe_sales;