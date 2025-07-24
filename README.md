# 🛠️ SQL ETL Pipeline Simulation

This project demonstrates a simple yet powerful **ETL (Extract, Transform, Load) pipeline simulation** using SQL. The process simulates real-world ETL workflows: data is staged, cleaned, moved to a production table, logged, and the staging table is automatically cleaned — all within **SQLite (or MySQL)** using **triggers**.

---

## 📁 File Included

- `etl_pipeline_simulation.sql` – Complete SQL script including:
  - Table creation (staging, production, audit log)
  - Data cleaning queries
  - Triggers for audit logging and cleanup
  - Sample test inserts for demonstration

---

## 🧩 Project Workflow

### 1. **Staging Table**: `staging_supermarket_sales`
- Raw data is inserted here.
- May contain NULLs, unclean date/time formats, or unnecessary records.

### 2. **Data Cleaning**
- Query filters out rows with:
  - Missing invoice ID, date, time, or product line
  - NULLs in `unit_price`, `quantity`, or `total`
- Distinct date/time values are explored for consistency.

### 3. **Production Table**: `sales`
- Only cleaned records are inserted here.
- Dates and times are converted to proper SQL `DATE` and `TIME` types.
- A `PRIMARY KEY` constraint ensures no duplicate sales.

### 4. **Audit Log Table**: `etl_audit_log`
- Automatically logs every insert into the `sales` table.
- Captures:
  - Timestamp
  - Table name
  - Record count
  - Status
  - Message with `invoice_id`

### 5. **Triggers**
- `trg_sales_insert_log`: Logs every row inserted into `sales`.
- `trg_sales_cleanup_staging`: Automatically deletes the same row from `staging_supermarket_sales`.

### 6. **Test Case**
- Inserts a dummy row into `staging`.
- Transfers it to `sales`, then:
  - Logs entry to `etl_audit_log`
  - Deletes it from `staging`

---

## 📸 Screenshots (Attach in repo)

> There is  a `/screenshots/` folder in this repository and  the below files are added in it:

|     Screenshot                  |          Description               |
|---------------------------------|------------------------------------|
| `production_table_view.png`     |  Snapshot after insert into `sales` |
| `testauditlogtrigger.png`         | Log entries showing trigger audit logs |
| `testcleanuptrigger.png`           | Confirmation that staging row is deleted after transfer |

---

## 📂 Folder Structure
sql-etl-pipeline-simulation/
│
├── etl_pipeline_simulation.sql
├── README.md
└── screenshots/
├── testcleanuptrigger.png
├── testauditlogtrigger.png
|---production_table_view.png
├── datasets/
└── initial_dataset.csv,staging_table.csv,sales_production_table.csv
