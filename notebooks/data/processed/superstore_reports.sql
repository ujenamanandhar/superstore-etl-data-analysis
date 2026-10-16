-- Superstore ETL and Data Analysis Project
-- Schema and eight analytical SQL reports
-- Run the CREATE TABLE statements on an empty database.


PRAGMA foreign_keys = ON;

CREATE TABLE customers (
    customer_id TEXT PRIMARY KEY,
    customer_name TEXT NOT NULL,
    segment TEXT
);

CREATE TABLE products (
    product_id TEXT PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT,
    sub_category TEXT
);

CREATE TABLE orders (
    order_id TEXT PRIMARY KEY,
    customer_id TEXT NOT NULL,
    order_date TEXT NOT NULL,
    ship_date TEXT,
    ship_mode TEXT,
    country TEXT,
    city TEXT,
    state TEXT,
    postal_code INTEGER,
    region TEXT,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INTEGER PRIMARY KEY,
    order_id TEXT NOT NULL,
    product_id TEXT NOT NULL,
    sales REAL NOT NULL,
    quantity INTEGER NOT NULL,
    discount REAL,
    profit REAL,
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


-- ANALYTICAL REPORT QUERIES

-- 01 Sales By Category
SELECT p.category,
           ROUND(SUM(od.sales), 2) AS total_sales
    FROM order_details od
    JOIN products p ON od.product_id = p.product_id
    WHERE p.category IS NOT NULL
    GROUP BY p.category
    ORDER BY total_sales DESC;

-- 02 Monthly Sales
SELECT strftime('%Y-%m', o.order_date) AS order_month,
               ROUND(SUM(od.sales), 2) AS total_sales
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        GROUP BY order_month
        ORDER BY order_month;

-- 03 Top 10 Customers
SELECT c.customer_id,
               c.customer_name,
               ROUND(SUM(od.sales), 2) AS total_sales
        FROM customers c
        JOIN orders o ON c.customer_id = o.customer_id
        JOIN order_details od ON o.order_id = od.order_id
        GROUP BY c.customer_id, c.customer_name
        ORDER BY total_sales DESC
        LIMIT 10;

-- 04 Top 10 Products
SELECT p.product_id,
               p.product_name,
               ROUND(SUM(od.sales), 2) AS total_sales,
               ROUND(SUM(od.profit), 2) AS total_profit
        FROM products p
        JOIN order_details od ON p.product_id = od.product_id
        GROUP BY p.product_id, p.product_name
        ORDER BY total_sales DESC
        LIMIT 10;

-- 05 Sales By Region
SELECT o.region,
               ROUND(SUM(od.sales), 2) AS total_sales,
               ROUND(SUM(od.profit), 2) AS total_profit
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        GROUP BY o.region
        ORDER BY total_sales DESC;

-- 06 Average Order Value
SELECT ROUND(AVG(order_total), 2) AS average_order_value
        FROM (
            SELECT order_id, SUM(sales) AS order_total
            FROM order_details
            GROUP BY order_id
        );

-- 07 Products Above Average Sales
SELECT p.product_id,
               p.product_name,
               ROUND(SUM(od.sales), 2) AS total_sales
        FROM products p
        JOIN order_details od ON p.product_id = od.product_id
        GROUP BY p.product_id, p.product_name
        HAVING SUM(od.sales) > (
            SELECT AVG(product_sales)
            FROM (
                SELECT SUM(sales) AS product_sales
                FROM order_details
                GROUP BY product_id
            )
        )
        ORDER BY total_sales DESC;

-- 08 Profit Classification
SELECT p.category,
               CASE
                   WHEN SUM(od.profit) > 0 THEN 'Profitable'
                   WHEN SUM(od.profit) < 0 THEN 'Loss'
                   ELSE 'Break-even'
               END AS profit_status,
               ROUND(SUM(od.profit), 2) AS total_profit
        FROM products p
        JOIN order_details od ON p.product_id = od.product_id
        GROUP BY p.category
        ORDER BY total_profit DESC;
