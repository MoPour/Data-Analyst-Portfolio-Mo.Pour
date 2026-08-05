-- 01_data_quality.sql
-- Customer Service SQL EDA
-- Purpose: Check data quality, missing values, duplicates, and basic profiling

-- Total records
SELECT COUNT(*) AS total_records
FROM tickets;

-- Preview records
SELECT *
FROM tickets
LIMIT 10;

-- Missing values check
SELECT
    SUM(CASE WHEN ticket_id IS NULL THEN 1 ELSE 0 END) AS missing_ticket_id,
    SUM(CASE WHEN ticket_status IS NULL THEN 1 ELSE 0 END) AS missing_ticket_status,
    SUM(CASE WHEN ticket_priority IS NULL THEN 1 ELSE 0 END) AS missing_ticket_priority
FROM tickets;

-- Duplicate ticket check
SELECT
    ticket_id,
    COUNT(*) AS duplicate_count
FROM tickets
GROUP BY ticket_id
HAVING COUNT(*) > 1;
