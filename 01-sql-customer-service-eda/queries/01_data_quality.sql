-- 01_data_quality.sql
-- Customer Service SQL EDA
-- Purpose: Check data quality, missing values, duplicates, and basic profiling

-- Record Count
SELECT COUNT(*) AS total_records
FROM ticket;

-- Preview records
SELECT *
FROM ticket
LIMIT 10;

-- Missing values check
SELECT
    SUM(CASE WHEN ticket_id IS NULL THEN 1 ELSE 0 END) AS missing_ticket_id,
    SUM(CASE WHEN ticket_status IS NULL THEN 1 ELSE 0 END) AS missing_ticket_status,
    SUM(CASE WHEN ticket_priority IS NULL THEN 1 ELSE 0 END) AS missing_ticket_priority,
    SUM(CASE WHEN ticket_priority IS NULL THEN 1 ELSE 0 END) AS missing_ticket_priority,
    sum(Case When Customer_Satisfaction_Rating is null Then 1 Else 0 End) As NULL_Customer_Satisfaction_Rating,
    sum(Case When Resolution is null Then 1 Else 0 End) As NULL_Resolution,
    sum(Case When Time_to_Resolution is null Then 1 Else 0 End) As NULL_Time_to_Resolution,
    sum(Case When First_Response_Time is null Then 1 Else 0 End) As NULL_First_Response_Time
    FROM ticket;

-- Duplicate ticket check
SELECT
    ticket_id,
    COUNT(*) AS duplicate_count
FROM ticket
GROUP BY ticket_id
HAVING COUNT(*) > 1;

--Empty String Profilling
SELECT 
    SUM(CASE WHEN Ticket_Channel = '' THEN 1 ELSE 0 END) AS empty_channel,
    SUM(CASE WHEN Ticket_Priority = '' THEN 1 ELSE 0 END) AS empty_priority,
    SUM(CASE WHEN Ticket_Status = '' THEN 1 ELSE 0 END) AS empty_status
FROM ticket;
--Invalid Category Detection/ Data consistency

SELECT DISTINCT Ticket_Channel
FROM ticket;

SELECT DISTINCT Ticket_Priority
FROM ticket;

SELECT DISTINCT Ticket_Status
FROM ticket;
--Date Range Profilling

SELECT 
    MIN(First_Response_Time) AS min_first_response,
    MAX(First_Response_Time) AS max_first_response,
    MIN(Time_to_Resolution) AS min_resolution,
    MAX(Time_to_Resolution) AS max_resolution
FROM ticket;


























