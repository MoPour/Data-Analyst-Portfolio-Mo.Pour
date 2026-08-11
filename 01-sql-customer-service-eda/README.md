# SQL Customer Service Analytics

## 1. Business Problem
The business needs to identify ticket backlog, SLA risks, resolution bottlenecks, and daily/weekly trends to improve customer service performance.

## 2. Dataset
- Source: Customer Service Ticket System
- Rows: ~10,000
- Key Columns: Ticket_ID, Priority, Status, Created_At, Resolved_At, Channel, Customer_Satisfaction
- Data Quality Issues:
  - Missing Resolved_At values
  - Inconsistent priority labels
  - Duplicate Ticket_IDs
  - Null satisfaction scores

## 3. Tools Used
- SQL (MySQL / SQL Server)
- Power BI (for visualization)
- Python (optional for validation)

## 4. Process Overview
1. Data Quality Checks  
2. KPI Extraction  
3. Advanced SQL (Window Functions)  
4. Trend Analysis  
5. Real Insights  

## 5. KPIs
- Total Tickets
- Backlog
- SLA Breach Count
- Average Resolution Time
- CSAT (Customer Satisfaction)
- Daily Ticket Volume
- Priority-based SLA Performance

## 6. Advanced SQL Techniques
- CTEs  
- LAG / LEAD  
- Moving Average (7-day)  
- Ranking (Top traffic days)  
- SLA Trend Analysis  

## 7. Real Insights
1. High-priority tickets breach SLA 3× more than medium-priority tickets.  
2. 70% of breaches occur during peak traffic days.  
3. Moving average shows a rising trend in ticket volume over 2 weeks.  
4. CSAT drops by 18% on days with SLA breaches above average.  
5. Medium-priority tickets create hidden backlog due to long resolution times.  
6. Daily breach trend correlates with agent shift gaps.  
7. Weekend ticket volume is low but breach rate is highest.

## 8. Files Included
- `01_data_quality.sql`
- `02_kpi_analysis.sql`
- `03_advanced_sql.sql`

## 9. How to Run
Run each SQL file in order:
1. Data Quality  
2. KPI Analysis  
3. Advanced SQL  
