-- Data quality audit, demo data only
-- No real employer or client data is used anywhere in this project.
-- Every customer, product, rep and amount below is invented for demonstration.
-- The audit checks a small sales orders table for the problems an analyst
-- would catch before the data reaches a report or a payout calculation.

DROP TABLE IF EXISTS reps;
DROP TABLE IF EXISTS sales_orders;

CREATE TABLE reps (
  rep_name TEXT
);

CREATE TABLE sales_orders (
  order_id TEXT,
  customer_name TEXT,
  product TEXT,
  quantity INTEGER,
  unit_price REAL,
  order_date TEXT,
  region TEXT,
  rep_name TEXT
);

INSERT INTO reps VALUES ('Alex Rivera');
INSERT INTO reps VALUES ('Sam Patel');
INSERT INTO reps VALUES ('Taylor Brooks');

INSERT INTO sales_orders VALUES ('O001', 'Harbor Books', 'Laptop Stand', 2, 40, '2026-01-05', 'North', 'Alex Rivera');
INSERT INTO sales_orders VALUES ('O002', 'Maple Cafe', 'Monitor', 1, 150, '2026-01-06', 'South', 'Sam Patel');
INSERT INTO sales_orders VALUES ('O003', 'River Yoga', 'Keyboard', 3, 30, '2026-01-07', 'East', 'Taylor Brooks');
INSERT INTO sales_orders VALUES ('O004', 'Harbor Books', 'Mouse', 5, 20, '2026-01-08', 'West', 'Alex Rivera');
INSERT INTO sales_orders VALUES ('O005', 'Cedar Bakery', 'Headset', 2, 60, '2026-01-09', 'North', 'Sam Patel');
INSERT INTO sales_orders VALUES ('O006', 'Maple Cafe', 'Laptop Stand', 1, 40, '2026-01-10', 'South', 'Taylor Brooks');
INSERT INTO sales_orders VALUES ('O007', 'River Yoga', 'Monitor', 2, 150, '2026-01-12', 'East', 'Alex Rivera');
INSERT INTO sales_orders VALUES ('O007', 'River Yoga', 'Monitor', 2, 150, '2026-01-12', 'East', 'Alex Rivera');
INSERT INTO sales_orders VALUES ('O008', 'Cedar Bakery', 'Keyboard', 4, 30, '2026-01-13', 'West', 'Sam Patel');
INSERT INTO sales_orders VALUES ('O009', 'Harbor Books', 'Mouse', 10, 20, '2026-01-14', 'North', 'Taylor Brooks');
INSERT INTO sales_orders VALUES ('O010', 'Maple Cafe', 'Headset', 1, 60, '2026-01-15', 'South', 'Alex Rivera');
INSERT INTO sales_orders VALUES ('O011', NULL, 'Monitor', 1, 150, '2026-01-16', 'East', 'Sam Patel');
INSERT INTO sales_orders VALUES ('O012', 'River Yoga', 'Laptop Stand', 2, 40, '2026-01-17', 'West', 'Taylor Brooks');
INSERT INTO sales_orders VALUES ('O013', 'Cedar Bakery', 'Keyboard', 2, 30, '2026-01-19', 'North', 'Alex Rivera');
INSERT INTO sales_orders VALUES ('O014', 'Harbor Books', 'Mouse', -2, 20, '2026-01-20', 'South', 'Sam Patel');
INSERT INTO sales_orders VALUES ('O015', 'Maple Cafe', 'Headset', 3, 60, '2026-01-21', 'East', 'Taylor Brooks');
INSERT INTO sales_orders VALUES ('O016', 'River Yoga', 'Monitor', 1, 0, '2026-01-22', 'West', 'Alex Rivera');
INSERT INTO sales_orders VALUES ('O017', 'Cedar Bakery', 'Laptop Stand', 1, 40, '2026-01-23', 'North', 'Sam Patel');
INSERT INTO sales_orders VALUES ('O018', 'Harbor Books', 'Keyboard', 1, 30, '2026-01-24', 'XX', 'Taylor Brooks');
INSERT INTO sales_orders VALUES ('O019', 'Maple Cafe', 'Mouse', 2, 20, '2026-13-05', 'South', 'Alex Rivera');
INSERT INTO sales_orders VALUES ('O020', 'River Yoga', 'Headset', 1, 60, '2026-01-26', 'East', 'Morgan Lee');

-- Findings summary. Each row is one check and its result.
-- A clean row is a row with no issue at all.
-- The total amount for clean rows only is the amount a report can trust.
SELECT 'total_rows' AS check_name, COUNT(*) AS result FROM sales_orders
UNION ALL SELECT 'distinct_order_ids', COUNT(DISTINCT order_id) FROM sales_orders
UNION ALL SELECT 'duplicate_order_id_rows', COUNT(*) FROM sales_orders WHERE order_id IN (SELECT order_id FROM sales_orders GROUP BY order_id HAVING COUNT(*) > 1)
UNION ALL SELECT 'missing_customer_rows', COUNT(*) FROM sales_orders WHERE customer_name IS NULL OR TRIM(customer_name) = ''
UNION ALL SELECT 'quantity_not_positive_rows', COUNT(*) FROM sales_orders WHERE quantity <= 0
UNION ALL SELECT 'unit_price_not_positive_rows', COUNT(*) FROM sales_orders WHERE unit_price <= 0
UNION ALL SELECT 'invalid_region_rows', COUNT(*) FROM sales_orders WHERE region NOT IN ('North', 'South', 'East', 'West')
UNION ALL SELECT 'invalid_date_rows', COUNT(*) FROM sales_orders WHERE CAST(SUBSTR(order_date, 6, 2) AS INTEGER) NOT BETWEEN 1 AND 12 OR CAST(SUBSTR(order_date, 9, 2) AS INTEGER) NOT BETWEEN 1 AND 31
UNION ALL SELECT 'unmatched_rep_rows', COUNT(*) FROM sales_orders WHERE rep_name NOT IN (SELECT rep_name FROM reps)
UNION ALL SELECT 'rows_with_at_least_one_issue', COUNT(*) FROM sales_orders WHERE order_id IN (SELECT order_id FROM sales_orders GROUP BY order_id HAVING COUNT(*) > 1) OR customer_name IS NULL OR TRIM(customer_name) = '' OR quantity <= 0 OR unit_price <= 0 OR region NOT IN ('North', 'South', 'East', 'West') OR CAST(SUBSTR(order_date, 6, 2) AS INTEGER) NOT BETWEEN 1 AND 12 OR CAST(SUBSTR(order_date, 9, 2) AS INTEGER) NOT BETWEEN 1 AND 31 OR rep_name NOT IN (SELECT rep_name FROM reps)
UNION ALL SELECT 'clean_rows', COUNT(*) FROM sales_orders WHERE order_id NOT IN (SELECT order_id FROM sales_orders GROUP BY order_id HAVING COUNT(*) > 1) AND customer_name IS NOT NULL AND TRIM(customer_name) <> '' AND quantity > 0 AND unit_price > 0 AND region IN ('North', 'South', 'East', 'West') AND CAST(SUBSTR(order_date, 6, 2) AS INTEGER) BETWEEN 1 AND 12 AND CAST(SUBSTR(order_date, 9, 2) AS INTEGER) BETWEEN 1 AND 31 AND rep_name IN (SELECT rep_name FROM reps)
UNION ALL SELECT 'total_amount_all_rows', CAST(SUM(quantity * unit_price) AS INTEGER) FROM sales_orders
UNION ALL SELECT 'total_amount_clean_rows_only', CAST(SUM(quantity * unit_price) AS INTEGER) FROM sales_orders WHERE order_id NOT IN (SELECT order_id FROM sales_orders GROUP BY order_id HAVING COUNT(*) > 1) AND customer_name IS NOT NULL AND TRIM(customer_name) <> '' AND quantity > 0 AND unit_price > 0 AND region IN ('North', 'South', 'East', 'West') AND CAST(SUBSTR(order_date, 6, 2) AS INTEGER) BETWEEN 1 AND 12 AND CAST(SUBSTR(order_date, 9, 2) AS INTEGER) BETWEEN 1 AND 31 AND rep_name IN (SELECT rep_name FROM reps);

-- Flagged rows. Run this second query to see every row with an issue.
SELECT
  order_id,
  customer_name,
  product,
  quantity,
  unit_price,
  order_date,
  region,
  rep_name
FROM sales_orders
WHERE order_id IN (SELECT order_id FROM sales_orders GROUP BY order_id HAVING COUNT(*) > 1)
  OR customer_name IS NULL OR TRIM(customer_name) = ''
  OR quantity <= 0
  OR unit_price <= 0
  OR region NOT IN ('North', 'South', 'East', 'West')
  OR CAST(SUBSTR(order_date, 6, 2) AS INTEGER) NOT BETWEEN 1 AND 12
  OR CAST(SUBSTR(order_date, 9, 2) AS INTEGER) NOT BETWEEN 1 AND 31
  OR rep_name NOT IN (SELECT rep_name FROM reps)
ORDER BY order_id;
