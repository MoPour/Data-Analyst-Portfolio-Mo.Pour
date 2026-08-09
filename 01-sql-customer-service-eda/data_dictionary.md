# Data Dictionary – Customer Service Tickets

| Column Name           | Data Type   | Description                                      | Notes / Quality Issues                     |
|-----------------------|-------------|--------------------------------------------------|---------------------------------------------|
| ticket_id             | INT         | Unique identifier for each ticket                | Potential duplicates detected               |
| status                | VARCHAR     | Current status (open, closed, in_progress)       | Some inconsistent values                    |
| priority              | VARCHAR     | Ticket urgency level (low, medium, high)         | Missing values found                        |
| channel               | VARCHAR     | Source of ticket (email, phone, chat)            | Missing values found                        |
| created_at            | DATETIME    | Ticket creation timestamp                         | Some invalid date formats                   |
| first_response_time   | FLOAT       | Hours until first response                        | No major issues                             |
| time_to_resolution    | FLOAT       | Total hours to resolve the ticket                 | Outliers detected                            |
| csat                  | FLOAT       | Customer satisfaction score                       | No major issues                             |
