/* ============================================
   02 - KPI Analysis for Customer Service EDA
   Author: Mo Pour
   Description: KPI queries for backlog, SLA risk,
                resolution bottlenecks, and channel performance
   ============================================ */

-----------------------------------------------
-- 1. Ticket Backlog (Open + In Progress)
-----------------------------------------------
SELECT 
    COUNT(*) AS backlog_tickets
FROM tickets
WHERE status IN ('open', 'in_progress');

-----------------------------------------------
-- 2. SLA Risk (High Priority + Long Resolution Time)
-----------------------------------------------
SELECT 
    COUNT(*) AS sla_risk_tickets
FROM tickets
WHERE priority = 'high'
  AND time_to_resolution > 48;   -- 48 hours threshold

-----------------------------------------------
-- 3. Resolution Bottleneck (Avg Resolution by Priority)
-----------------------------------------------
SELECT 
    priority,
    AVG(time_to_resolution) AS avg_resolution_hours
FROM tickets
GROUP BY priority
ORDER BY avg_resolution_hours DESC;

-----------------------------------------------
-- 4. First Response Performance
-----------------------------------------------
SELECT 
    AVG(first_response_time) AS avg_first_response_hours
FROM tickets;

-----------------------------------------------
-- 5. Channel Performance (Volume + Avg Resolution)
-----------------------------------------------
SELECT 
    channel,
    COUNT(*) AS ticket_volume,
    AVG(time_to_resolution) AS avg_resolution_hours
FROM tickets
GROUP BY channel
ORDER BY ticket_volume DESC;

-----------------------------------------------
-- 6. CSAT by Priority
-----------------------------------------------
SELECT 
    priority,
    AVG(csat) AS avg_csat
FROM tickets
GROUP BY priority
ORDER BY avg_csat DESC;
