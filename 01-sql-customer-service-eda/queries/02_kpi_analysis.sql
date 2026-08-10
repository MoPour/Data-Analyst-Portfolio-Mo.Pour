/* ============================================
   02 - KPI Analysis for Customer Service EDA
   Author: Mo Pour
   Description: KPI queries for backlog, SLA risk,
                resolution bottlenecks, and channel performance
   ============================================ */

-----------------------------------------------
-- 1. Ticket Backlog (Open + In Progress)

SELECT 
    COUNT(*) AS backlog_tickets
FROM ticket
WHERE status IN ('open', 'in_progress');

-----------------------------------------------
-- 2. SLA Risk (High Priority + Long Resolution Time)
SELECT 
    COUNT(*) AS sla_risk_tickets
FROM ticket
WHERE priority = 'high'
  AND time_to_resolution > 48;   -- 48 hours threshold

-----------------------------------------------
-- 3. Resolution Bottleneck (Avg Resolution by Priority)

SELECT 
    priority,
    AVG(time_to_resolution) AS avg_resolution_hours
FROM ticket
GROUP BY priority
ORDER BY avg_resolution_hours DESC;

-----------------------------------------------
-- 4. Average Resolution Time

SELECT 
    AVG(DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution)) AS avg_resolution_hours
FROM ticket
WHERE First_Response_Time IS NOT NULL
  AND Time_to_Resolution IS NOT NULL;

-----------------------------------------------
-- 5. SLA Compliance Rate

WITH sla AS (
    SELECT 
        Ticket_ID,
        CASE
            WHEN First_Response_Time IS NULL OR Time_to_Resolution IS NULL THEN 'Incomplete'
            WHEN DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution) > 48 THEN 'Breach'
            ELSE 'OK'
        END AS SLA_Flag
    FROM ticket
)
SELECT 
    (SUM(CASE WHEN SLA_Flag = 'OK' THEN 1 ELSE 0 END) * 1.0) /
    (SUM(CASE WHEN SLA_Flag IN ('OK','Breach') THEN 1 ELSE 0 END)) AS sla_compliance_rate
FROM sla;

-----------------------------------------------
-- 6. SLA Breach Count

WITH sla AS (
    SELECT 
        Ticket_ID,
        CASE
            WHEN First_Response_Time IS NULL OR Time_to_Resolution IS NULL THEN 'Incomplete'
            WHEN DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution) > 23 THEN 'Breach'
            ELSE 'OK'
        END AS SLA_Flag
    FROM ticket
)
SELECT COUNT(*) AS sla_breach_count
FROM sla
WHERE SLA_Flag = 'Breach';

------------------------------------------------
--7. Unresolved Tickets
SELECT COUNT(*) AS unresolved_tickets
FROM ticket
WHERE Time_to_Resolution IS NULL;
-----------------------------------------------
--8. First Response Time

SELECT 
    AVG(DATEDIFF(HOUR, Ticket_Created_Time, First_Response_Time)) AS avg_first_response_hours
FROM ticket
WHERE First_Response_Time IS NOT NULL;
----------------------------------------------------
--9. Priority Performance

WITH sla AS (
    SELECT 
        Ticket_Priority,
        DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution) AS resolution_hours,
        CASE
            WHEN First_Response_Time IS NULL OR Time_to_Resolution IS NULL THEN 'Incomplete'
            WHEN DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution) > 48 THEN 'Breach'
            ELSE 'OK'
        END AS SLA_Flag
    FROM ticket
)
SELECT 
    Ticket_Priority,
    AVG(resolution_hours) AS avg_resolution_hours,
    SUM(CASE WHEN SLA_Flag = 'Breach' THEN 1 ELSE 0 END) AS breach_count
FROM sla
GROUP BY Ticket_Priority;
----------------------------------------------------------
--10. CSAT by Priority & CSAT by Channel
SELECT 
    Ticket_Priority,
    AVG(Customer_Satisfaction) AS avg_csat
FROM ticket
GROUP BY Ticket_Priority;
-----

SELECT 
    Ticket_Channel,
    AVG(Customer_Satisfaction) AS avg_csat
FROM ticket
GROUP BY Ticket_Channel;







