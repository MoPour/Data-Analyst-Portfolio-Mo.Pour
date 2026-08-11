---------------------------------------------------------
-- 1. Base CTE: Duration + SLA Flag
---------------------------------------------------------

WITH ticket_cte AS (
    SELECT
        Ticket_ID,
        Ticket_Channel,
        Ticket_Priority,
        Ticket_Status,
        Date_of_Purchase,
        First_Response_Time,
        Time_to_Resolution,

        -- Duration in Hours
        CASE 
            WHEN First_Response_Time IS NULL OR Time_to_Resolution IS NULL 
                THEN NULL
            ELSE DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution)
        END AS Duration_Hours,

        -- SLA Flag based on Priority
        CASE
            WHEN First_Response_Time IS NULL OR Time_to_Resolution IS NULL THEN 'Incomplete'
            WHEN Ticket_Priority = 'High'   AND DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution) > 24 THEN 'Breach'
            WHEN Ticket_Priority = 'Medium' AND DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution) > 48 THEN 'Breach'
            WHEN Ticket_Priority = 'Low'    AND DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution) > 72 THEN 'Breach'
            ELSE 'OK'
        END AS SLA_Flag
    FROM ticket
)

SELECT *
FROM ticket_cte;
---------------------------------------------------------
-- 2. LAG: Previous Response Time per Channel
---------------------------------------------------------

SELECT 
    Ticket_ID,
    Ticket_Channel,
    First_Response_Time,
    LAG(First_Response_Time) OVER (
        PARTITION BY Ticket_Channel 
        ORDER BY First_Response_Time
    ) AS Previous_Response
FROM ticket;
---------------------------------------------------------
-- 3. Channel Ranking by Average Resolution Time
---------------------------------------------------------

SELECT 
    Ticket_Channel,
    AVG(DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution)) AS Avg_Resolution_Hours,
    RANK() OVER (ORDER BY AVG(DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution))) AS Resolution_Rank
FROM ticket
GROUP BY Ticket_Channel;
---------------------------------------------------------
-- 4. Moving Average (7-Day) for Resolution Time
---------------------------------------------------------

WITH duration_cte AS (
    SELECT 
        Ticket_ID,
        Date_of_Purchase,
        DATEDIFF(HOUR, First_Response_Time, Time_to_Resolution) AS Resolution_Hours
    FROM ticket
)

SELECT 
    Ticket_ID,
    Date_of_Purchase,
    Resolution_Hours,
    AVG(Resolution_Hours) OVER (
        ORDER BY Date_of_Purchase
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS Moving_Avg_7_Days
FROM duration_cte
ORDER BY Date_of_Purchase;
---------------------------------------------------------
-- 5. Trend Analysis: Daily Ticket Volume + LAG + Moving Average
---------------------------------------------------------

WITH daily_volume AS (
    SELECT 
        Date_of_Purchase,
        COUNT(*) AS Daily_Tickets
    FROM ticket
    GROUP BY Date_of_Purchase
)

SELECT
    Date_of_Purchase,
    Daily_Tickets,
    LAG(Daily_Tickets) OVER (ORDER BY Date_of_Purchase) AS Previous_Day,
    Daily_Tickets - LAG(Daily_Tickets) OVER (ORDER BY Date_of_Purchase) AS Day_Change,
    AVG(Daily_Tickets) OVER (
        ORDER BY Date_of_Purchase
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS Moving_Avg_7_Days
FROM daily_volume
ORDER BY Date_of_Purchase;
---------------------------------------------------------
-- 6. SLA Trend Analysis
---------------------------------------------------------

WITH sla_trend AS (
    SELECT
        Date_of_Purchase,
        SUM(CASE WHEN SLA_Flag = 'Breach' THEN 1 ELSE 0 END) AS Breach_Count
    FROM ticket_cte
    GROUP BY Date_of_Purchase
)

SELECT
    Date_of_Purchase,
    Breach_Count,
    LAG(Breach_Count) OVER (ORDER BY Date_of_Purchase) AS Previous_Breach,
    Breach_Count - LAG(Breach_Count) OVER (ORDER BY Date_of_Purchase) AS Breach_Change,
    AVG(Breach_Count) OVER (
        ORDER BY Date_of_Purchase
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS Breach_Moving_Avg_7_Days
FROM sla_trend
ORDER BY Date_of_Purchase;
