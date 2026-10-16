# End-to-End ETL and Data Analysis Pipeline
## Superstore Dataset

### 1. Introduction
This project builds an end-to-end ETL and data analysis pipeline using the Superstore dataset. Python and Pandas are used to explore, clean, transform, and analyze the data. SQLite is used to store the processed data in related tables, and SQL queries are used to produce business reports.

### 2. Project Objectives
- Explore and understand the dataset.
- Identify and address data-quality issues.
- Create useful calculated columns and analysis tables.
- Build a relational database with primary and foreign keys.
- Load data into the database and validate it.
- Answer business questions using Python and SQL.
- Present findings through analysis, charts, and reports.

### 3. Dataset and Extraction
The project uses the Superstore sales dataset obtained for this assignment from Kaggle. It contains order, customer, product, sales, discount, quantity, and profit information. The original dataset contains 9,994 rows and 21 columns. The raw source data is retained separately from the processed files.

### 4. Exploratory Data Analysis
The notebook examines the dataset's dimensions, column names, data types, descriptive statistics, unique values, and data quality. It also explores sales and profit by category, region, sub-category, customer, and month.

### 5. Data Cleaning and Transformation
The notebook converts order and shipping dates to datetime values, checks missing values and duplicate rows, cleans whitespace in product names, and creates the Shipping Days, Order Year, Order Month, and Order Month Name columns. It also creates separate customer, product, order, and order-detail DataFrames for database loading.

The product table uses one record per Product ID to meet the primary-key requirement. Where a Product ID has more than one descriptive record, the first record is retained in the product table. The original order-detail records are retained. This is a database-normalization choice and a limitation to document if product descriptions conflict.

### 6. Database Design and ETL
The SQLite database is saved at `data/processed/superstore.db`. It contains four related tables: customers, products, orders, and order_details. Primary keys identify records, and foreign keys connect orders to customers and order details to orders and products. Python loads the prepared DataFrames into these tables.

### 7. Data Validation
The database validation cell checks database integrity, foreign-key relationships, table row counts, and sales and profit totals. The validation results should be reviewed before final submission.

Verified order-detail rows: 9,994

Database total sales: $2,297,200.86

Database total profit: $286,397.02

### 8. Analytical Findings
- Technology generated the highest profit among the product categories in the notebook's category analysis.
- The West region recorded the highest sales in the notebook's regional analysis.
- Copiers generated the highest total profit among sub-categories.
- Phones recorded the highest total sales among sub-categories.
- Tables had the largest total loss among sub-categories.
- November 2017 recorded the highest monthly sales in the notebook's monthly analysis, at approximately $118,447.82.
- Sean Miller was the highest-sales customer in the notebook's customer analysis, with total sales of approximately $25,043.05.
- The average order value calculated from the order-detail records was $458.61.

### 9. SQL Reports
Eight SQL reports are included:
1. Sales by product category.
2. Monthly sales trends.
3. Top 10 customers by sales.
4. Top 10 products by sales.
5. Sales and profit by region.
6. Average order value.
7. Products above average total sales.
8. Profit classification by category using CASE.

The queries demonstrate JOIN, WHERE, GROUP BY, HAVING, ORDER BY, aggregate functions, a subquery, and CASE. The query results are exported as CSV files.

### 10. Project Deliverables
- Jupyter notebook containing extraction, exploration, cleaning, transformation, analysis, and database loading.
- Original raw dataset.
- Processed customer, product, order, and order-detail CSV files.
- SQLite database.
- SQL schema and analytical queries.
- Entity Relationship Diagram (ERD).
- Eight SQL report CSV files.
- This project report.

### 11. Challenges and Limitations
The project required checks for duplicate product identifiers because a relational product table requires each Product ID to be unique. One descriptive record per Product ID was retained for the database, while the original order-detail rows were preserved. The database checks and total reconciliation help verify that the loaded order details remain complete.

### 12. Conclusion
This project demonstrates a complete workflow from raw sales data to data cleaning, transformation, relational database loading, SQL reporting, and business insights. The results help identify profitable categories, strong sales regions, customer contributions, and sub-category performance. Database validation and the saved project files make the work easier to review and reproduce.
