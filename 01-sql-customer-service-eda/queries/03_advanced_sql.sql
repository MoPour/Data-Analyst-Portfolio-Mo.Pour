--1. Creating Duration Column with CTE
WITH duration_cte AS (
    SELECT 
        Ticket_ID,
        First_Response_Time,
        Time_to_Resolution,
        CASE 
            WHEN First_Response_Time IS NULL OR Time_to_Resolution IS NULL 
                THEN NULL
            ELSE DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution)
        END AS Duration_Hours
    FROM ticket
)
SELECT *
FROM duration_cte;
-------------------------------------------------
--2. Creating SLA_FLAG WITH CTE

WITH sla_cte AS (
    SELECT 
        Ticket_ID,
        CASE
            WHEN First_Response_Time IS NULL OR Time_to_Resolution IS NULL THEN 'Incomplete'
            WHEN DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution) > 48 THEN 'Breach'
            ELSE 'OK'
        END AS SLA_Flag
    FROM ticket
)
SELECT *
FROM sla_cte;
--------------------------------------------------------
--3.Finding LAG IN RESPONSE (WindowFunction)
SELECT 
    Ticket_ID,
    Ticket_Channel,
    First_Response_Time,
    LAG(First_Response_Time) OVER (PARTITION BY Ticket_Channel ORDER BY First_Response_Time) AS previous_response
FROM ticket;
----------------------------------------------------------
--4.Channel Ranking
SELECT 
    Ticket_Channel,
    AVG(DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution)) AS avg_resolution,
    RANK() OVER (ORDER BY AVG(DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution))) AS resolution_rank
FROM ticket
GROUP BY Ticket_Channel;
---------------------------------------------------------
--5.Resolution Time Moving Average
WITH duration_cte AS (
    SELECT 
        Ticket_ID,
        Ticket_Created_Time,
        DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution) AS resolution_hours
    FROM ticket
)
SELECT 
    Ticket_ID,
    Ticket_Created_Time,
    resolution_hours,
    AVG(resolution_hours) OVER (
        ORDER BY Ticket_Created_Time 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7
FROM duration_cte;
---------------------------------------------------------
--6.Tend Analysis

SELECT 
    CAST(Ticket_Created_Time AS DATE) AS ticket_date,
    COUNT(*) AS daily_volume
FROM ticket
GROUP BY CAST(Ticket_Created_Time AS DATE)
ORDER BY ticket_date;







