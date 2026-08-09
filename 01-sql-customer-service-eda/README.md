# 01 - Customer Service SQL EDA

## Business Problem
The business needs to identify ticket backlog, SLA risks, and resolution bottlenecks to improve customer satisfaction and operational efficiency.

## Dataset
Source: Customer Support Ticket Dataset  
Key Columns: ticket_id, status, priority, channel, created_at, first_response_time, time_to_resolution, csat  
Data Quality Notes: Missing values in priority & channel, inconsistent date formats, potential duplicate ticket IDs.

## Tools Used
- SQL Server
- SSMS

## Process
1. Data import into SQL Server  
2. Data Quality Checks (null, duplicate, data types, date range, record count)  
3. Profiling & validation  
4. KPI preparation for next phase  

## Data Quality Summary
- **Nulls:** Priority & Channel contain missing values  
- **Duplicates:** Duplicate ticket_id records detected  
- **Date Issues:** Some created_at values fail TRY_CONVERT  
- **Range:** Dataset spans from [min_date] to [max_date]  
- **Record Count:** [X] total records  

## Initial Insights
- Missing priority values create SLA classification risks  
- Channel distribution suggests operational bottlenecks  
- Resolution time varies significantly across priority levels  

## Folder Structure
## Project Files
- `queries/01_data_quality.sql` – Data quality and profiling checks
- `queries/02_kpi_analysis.sql` – KPI calculations (backlog, SLA risk, resolution performance)
- `data_dictionary.md` – Column definitions and data quality notes

