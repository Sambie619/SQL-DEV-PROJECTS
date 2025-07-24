CREATE TABLE staging_supermarket_sales (
    invoice_id TEXT,
    branch TEXT,
    city TEXT,
    customer_type TEXT,
    gender TEXT,
    product_line TEXT,
    unit_price REAL,
    quantity INTEGER,
    tax_5 REAL,
    total REAL,
    date TEXT,
    time TEXT,
    payment TEXT,
    cogs REAL,
    gross_margin_percentage REAL,
    gross_income REAL,
    rating REAL
);

select * from staging_supermarket_sales;


-- 2. Find rows with missing critical values (null or empty string)
SELECT *
FROM staging_supermarket_sales
WHERE
    invoice_id IS NULL OR TRIM(invoice_id) = ''
    OR date IS NULL OR TRIM(date) = ''
    OR time IS NULL OR TRIM(time) = ''
    OR customer_type IS NULL OR TRIM(customer_type) = ''
    OR product_line IS NULL OR TRIM(product_line) = ''
    OR unit_price IS NULL
    OR quantity IS NULL
    OR total IS NULL;

-- 3. Explore unique date and time formats
SELECT DISTINCT date FROM staging_supermarket_sales ORDER BY date;
SELECT DISTINCT time FROM staging_supermarket_sales ORDER BY time;

-- 4. Confirm any values if NULL
SELECT date, time
FROM staging_supermarket_sales
WHERE date IS NULL OR time IS NULL;

-- 5. Create the sales (production) table
CREATE TABLE sales (
    invoice_id TEXT PRIMARY KEY,
    branch TEXT,
    city TEXT,
    customer_type TEXT,
    gender TEXT,
    product_line TEXT,
    unit_price REAL,
    quantity INTEGER,
    tax_5 REAL,
    total REAL,
    sale_date date,
    sale_time time,
    payment TEXT,
    cogs REAL,
    gross_margin_percent REAL,
    gross_income REAL,
    rating REAL
);


-- 6. Insert cleaned values into sales (use 'std_' columns)
INSERT INTO sales (
    invoice_id, branch, city, customer_type, gender, product_line,
    unit_price, quantity, tax_5, total, sale_date, sale_time,
    payment, cogs, gross_margin_percent, gross_income, rating
)
SELECT
    invoice_id, branch, city, customer_type, gender, product_line,
    unit_price, quantity, tax_5, total,date,time,
    payment, cogs, gross_margin_percentage, gross_income, rating
FROM
    staging_supermarket_sales
WHERE date IS NOT NULL AND time IS NOT NULL;

-- 7. Create the ETL audit log table
CREATE TABLE etl_audit_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    load_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    table_loaded TEXT,
    records_inserted INTEGER,
    status TEXT,
    message TEXT
);  

-- 8. Audit trigger: After insert on sales, add log row (1 row per sale)
CREATE TRIGGER trg_sales_insert_log
AFTER INSERT ON sales
BEGIN
    INSERT INTO etl_audit_log (
        table_loaded,
        records_inserted,
        status,
        message
    ) VALUES (
        'sales',
        1,
        'success',
        'Inserted sale with invoice_id: ' || NEW.invoice_id
    );
END;


-- 9. Cleanup trigger: After insert on sales, remove the corresponding row from staging
CREATE TRIGGER trg_sales_cleanup_staging
AFTER INSERT ON sales
BEGIN
    DELETE FROM staging_supermarket_sales WHERE invoice_id = NEW.invoice_id;
END;


-- 14. Test insert new staging row
INSERT INTO staging_supermarket_sales (
    -- 14. Test insert new staging row
INSERT INTO staging_supermarket_sales (
    invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, tax_5, total,
    date, time, payment, cogs, gross_margin_percent, gross_income, rating, std_date, std_time
) VALUES (
    'TST-0001', 'A', 'CityX', 'Member', 'Male', 'Beverages', 10.00, 2, 1.0, 21.00,
    '07-21-2025', '2:30:00 PM', 'Cash', 20.00, 5.0, 1.00, 8.5, '2025-07-21', '14:30:00'
);, branch, city, customer_type, gender, product_line, unit_price, quantity, tax_5, total,
    date, time, payment, cogs, gross_margin_percentage, gross_income, rating, date,time
) VALUES (
    'TST-0001', 'A', 'CityX', 'Member', 'Male', 'Beverages', 10.00, 2, 1.0, 21.00,
    '07-21-2025', '2:30:00 PM', 'Cash', 20.00, 5.0, 1.00, 8.5, '2025-07-21', '14:30:00'
);


SELECT  * from staging_supermarket_sales where invoice_id ='TST-0001';


-- Move the row to sales (use std_date/std_time) - triggers will handle log and cleanup
--after execution we should see the respective row in sales (it added in audit logg),and the row is removed/cleaned up from staging table!!!
INSERT INTO sales (
    invoice_id, branch, city, customer_type, gender, product_line,
    unit_price, quantity, tax_5, total, sale_date, sale_time,
    payment, cogs, gross_margin_percent, gross_income, rating
)
SELECT
    invoice_id, branch, city, customer_type, gender, product_line,
    unit_price, quantity, tax_5, total, date, time,
    payment, cogs, gross_margin_percentage, gross_income, rating
FROM staging_supermarket_sales
WHERE invoice_id = 'TST-0001';



-- Confirm triggers: Staging row deleted?
SELECT * FROM staging_supermarket_sales WHERE invoice_id = 'TST-0001';
-- Confirm triggers: Audit log row present?
SELECT * FROM etl_audit_log ORDER BY id DESC LIMIT 5;
-- Confirm in Production?
SELECT * FROM sales WHERE invoice_id = 'TST-0001';













