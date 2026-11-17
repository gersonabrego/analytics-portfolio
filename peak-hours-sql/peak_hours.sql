-- Peak Hours Sales Analysis
-- Business question. Which hours of the day drive the most sales, and how should staffing follow the demand.
-- Data. UCI Online Retail, public data, Dec 2010 to Dec 2011. Load it into a table named online_retail.
-- Cleaning. Cancelled orders are removed, returns are removed, and rows with no price are removed.
-- Note. InvoiceDate is stored as text, so the hour is pulled from the time part of the value.
-- Note. Quantity and UnitPrice are cast to numbers, so the script works whether the import stores them as text or as numbers.

CREATE VIEW IF NOT EXISTS hourly_sales AS
WITH base AS (
    SELECT
        InvoiceNo,
        substr(InvoiceDate, instr(InvoiceDate, ' ') + 1) AS time_part,
        CAST(Quantity AS REAL) AS qty,
        CAST(UnitPrice AS REAL) AS price
    FROM online_retail
    WHERE InvoiceNo NOT LIKE 'C%'
      AND CAST(Quantity AS REAL) > 0
      AND CAST(UnitPrice AS REAL) > 0
      AND InvoiceDate IS NOT NULL
),
cleaned AS (
    SELECT
        InvoiceNo,
        CAST(substr(time_part, 1, instr(time_part, ':') - 1) AS INTEGER) AS hour_of_day,
        qty * price AS line_sales
    FROM base
)
SELECT
    hour_of_day,
    COUNT(DISTINCT InvoiceNo) AS orders,
    ROUND(SUM(line_sales), 2) AS total_sales
FROM cleaned
GROUP BY hour_of_day;

-- Query 1. Sales and order count by hour, ranked from busiest to quietest.
SELECT
    h.hour_of_day,
    h.orders,
    h.total_sales,
    ROUND(100.0 * h.total_sales / t.grand_total, 2) AS share_of_sales_pct
FROM hourly_sales h
CROSS JOIN (SELECT SUM(total_sales) AS grand_total FROM hourly_sales) t
ORDER BY h.total_sales DESC;

-- Query 2. The three busiest hours together, and their share of all sales.
SELECT
    COUNT(*) AS top_hours,
    ROUND(SUM(total_sales), 2) AS top_hours_sales,
    ROUND(100.0 * SUM(total_sales) / (SELECT SUM(total_sales) FROM hourly_sales), 2) AS share_of_sales_pct
FROM (
    SELECT total_sales
    FROM hourly_sales
    ORDER BY total_sales DESC
    LIMIT 3
);
