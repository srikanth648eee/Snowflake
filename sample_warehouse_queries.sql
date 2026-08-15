-- =====================================================
-- sample_warehouse_queries.sql
-- Purpose: Practice file for Git/VS Code branching workflow
-- Use case: Basic Snowflake warehouse & query examples
-- =====================================================

-- 1. Check current warehouse, database, schema context
SELECT CURRENT_WAREHOUSE(), CURRENT_DATABASE(), CURRENT_SCHEMA();

-- 2. List all warehouses and their sizes
SHOW WAREHOUSES;

-- 3. Sample table creation (safe to run in a sandbox/dev schema)
CREATE OR REPLACE TABLE sample_orders143 (
    order_id     INT,
    customer_id  INT,
    order_date   DATE,
    amount       NUMBER(10,2),
    status       STRING
);

-- 4. Insert sample data
INSERT INTO sample_orders VALUES
    (1, 101, '2026-08-01', 250.00, 'COMPLETED'),
    (2, 102, '2026-08-02', 125.50, 'PENDING'),
    (3, 103, '2026-08-03', 89.99,  'COMPLETED'),
    (4, 101, '2026-08-05', 430.00, 'CANCELLED');

-- 5. Basic aggregation query
SELECT
    status,
    COUNT(*)          AS order_count,
    SUM(amount)        AS total_amount
FROM sample_orders
GROUP BY status
ORDER BY total_amount DESC;

-- 6. Example: warehouse credit usage (last 7 days)
-- Useful for cost monitoring conversations
SELECT
    warehouse_name,
    SUM(credits_used) AS total_credits
FROM snowflake.account_usage.warehouse_metering_history
WHERE start_time >= DATEADD(day, -7, CURRENT_TIMESTAMP())
GROUP BY warehouse_name
ORDER BY total_credits DESC;

-- =====================================================
-- Try this next (for branch practice):
-- Add a new query below, commit it on a new branch,
-- then merge it back into main.
-- =====================================================
