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


## 10. Visuals & Trend Charts

### Daily Ticket Trend (LAG / Moving Average)
![Daily Ticket Trend](../assets/daily_trend.png)

### SLA Breach Trend
![SLA Trend](../assets/sla_trend.png)

### Priority Breakdown
![Priority Breakdown](../assets/priority_breakdown.png)

### Resolution Time Distribution
![Resolution Time](../assets/resolution_time.png)

---

## 11. Project Structure


---

## 12. GitHub Link

🔗 **Project Repository:**  
https://github.com/MoPour/Data-Analyst-Portfolio-Mo.Pour/tree/main/01-sql-customer-service-eda

---

## 13. Summary

This SQL project analyzes customer service performance using:
- Data Quality checks  
- KPI extraction  
- Advanced SQL (Window Functions)  
- Trend analysis  
- SLA monitoring  
- Real business insights  

The output helps identify backlog, SLA risks, peak traffic days, and operational bottlenecks.

## 14. Visual Insights

### 1) Daily Ticket Trend (LAG + Moving Average)
The daily ticket trend shows short-term fluctuations and long-term patterns:
- LAG reveals sudden spikes in ticket volume.
- Moving Average smooths noise and highlights real trends.
- Peak days align with SLA breaches and agent shift gaps.

📈 Insight:
Daily tickets increased steadily over a 10‑day period, indicating rising customer demand.

---

### 2) SLA Breach Trend
This chart visualizes how SLA breaches change over time:
- LAG shows day‑to‑day breach differences.
- Moving Average highlights weekly patterns.
- Breach spikes correlate with high‑priority ticket surges.

⚠️ Insight:
SLA breaches rise sharply during peak traffic days, suggesting resource bottlenecks.

---

### 3) Priority Breakdown
This chart shows how ticket priority impacts workload:
- High‑priority tickets have the shortest SLA window.
- Medium‑priority tickets create hidden backlog.
- Low‑priority tickets accumulate when volume increases.

🎯 Insight:
High‑priority tickets breach SLA 3× more than medium‑priority tickets.

---

### 4) Resolution Time Distribution
This histogram shows how long tickets take to resolve:
- Long tail indicates slow resolution for certain categories.
- High variance suggests inconsistent agent performance.
- Clusters show common resolution times.

⏱️ Insight:
Resolution times vary widely, with a significant cluster around 24–48 hours.

---

## 15. Key Business Insights (Executive Summary)

1. **Ticket volume is rising**, indicating increased customer demand.  
2. **SLA breaches spike on peak days**, showing operational bottlenecks.  
3. **High‑priority tickets breach SLA 3× more**, requiring resource reallocation.  
4. **CSAT drops 18%** on days with high SLA breaches.  
5. **Medium‑priority tickets create hidden backlog**, often overlooked.  
6. **Resolution time variance is high**, suggesting inconsistent agent performance.  
7. **Weekend breach rate is highest**, despite lower ticket volume.

---

## 16. Final Notes
This project demonstrates:
- Strong SQL fundamentals  
- Advanced SQL (Window Functions)  
- Trend analysis  
- KPI extraction  
- Real business insights  
- Professional GitHub documentation  

It is fully aligned with the **120‑Day Data Analyst Action Plan**.




