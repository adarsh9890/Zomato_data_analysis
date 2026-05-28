# Zomato Delivery & Operations Analytics Pipeline

An end-to-end data analytics project leveraging Python for data cleaning, MySQL for advanced relational query optimization, and Power BI to build an interactive business intelligence canvas mapping food delivery operations, customer behavior, and financial performance.

---

## Business Case Overview & Objectives
In the on-demand food delivery sector, optimizing logistics, monitoring revenue leaks due to cancellations, and understanding promotional ROI are critical to maintaining profit margins. This project builds a complete analytics workflow to evaluate vendor performance, isolate operational bottlenecks, and track consumer purchasing habits.

### Core Business Questions Solved:
1. Financial Performance: Tracking net restaurant revenue metrics directly after calculating promotional markdown impacts.
2. Logistics Optimization: Identifying delivery time bottlenecks across cuisines and benchmarking logistics partners natively within individual cities.
3. Operational Risk Management: Isolating vendor order cancellation rates to maintain high platform service levels.
4. Marketing & Growth Tracking: Evaluating discount impacts on customer satisfaction ratings and calculating new customer acquisition velocities over a rolling 30-day window.

---

## Technology Stack
* Data Preprocessing & Pre-staging: Python (Pandas, NumPy)
* Relational Query Optimization: MySQL Server (CTEs, Window Functions, Conditional Aggregations, Date-Time Functions)
* Business Intelligence Canvas: Power BI Desktop

---

## Data Preprocessing & Structural Engineering (Python)
Before relational ingestion, the raw operational dataset was systematically refined within Zomato_data_analysis.ipynb to guarantee strict data hygiene:
* Missing Value Allocation: Handled structural data gaps across restaurant attributes and delivery records.
* Schema Standardization: Cleaned formatting variations, stripped invalid symbol characters from pricing metrics, and resolved inconsistent text fields.
* Target Schema Construction: Formatted structural metrics like ratings, time tracking fields, and pricing into appropriate data types for optimized analytical computation.
* Pipeline Output: Staged and exported the structured records to clean_dataset.csv for high-performance database loading.

---

## Strategic SQL Database Analytics (MySQL)
The production script inside zomato_analysis.sql processes raw order streams into high-value business insights:

* Net Revenue Auditing: Programmatically computed absolute net financial intakes across vendors by evaluating pricing variables against promotional markdowns.
* Logistics Performance Partitioning: Engineered an analytical matrix using Common Table Expressions (CTEs) and ranking window functions (ROW_NUMBER OVER) to isolate and track the top 3 fastest delivery partners partitioned by individual delivery cities.
* Platform Health & Cancellation Rates: Developed a conditional aggregation query to identify operational friction points by calculating percentage-based cancellation thresholds for every merchant.
* Promotional Rating Multipliers: Built a dual-CTE script comparing average customer sentiment across order cohorts to isolate the top 5 merchants whose ratings expanded the most when discounts were applied versus baseline non-discount orders.
* Temporal Demand & Peak Hour Mapping: Cross-joined transactional values against the global average order baseline to locate the precise hourly operational windows generating the highest volume of premium high-value orders.
* Customer Growth Velocity: Monitored platform acquisition trends using date manipulation parameters (DATE_SUB, CURDATE) to track the top 10 restaurants acquiring the highest volume of first-time user conversions within a rolling 30-day operational horizon.

---

## Executive Analytics Dashboard (Power BI)
The visualization layer connects directly to the cleaned operational data, creating a centralized dashboard monitoring live metrics.

<img width="1163" height="644" alt="image" src="https://github.com/user-attachments/assets/be41bc2f-587d-488f-aeb2-7a0cadd8f450" />

### Core Analysis Focus Areas:
* Logistical Efficiency Canvas: Tracks average delivery cycles across different cuisine styles and city vectors.
* Financial Performance Indicators: Monitored tracking of gross values, total customer savings from promotions, and average order values (AOV) broken down by day of the week.
* Consumer Demand Diagnostics: Visualizes high-volume food menu items, peak ordering hours, and regional merchant density maps.

---

## Project Structure
* zomato_dataset.csv: Raw, unrefined source transactional data resource.
* clean_dataset.csv: The structured, processed dataset exported after Python preprocessing.
* Zomato_data_analysis.ipynb: Jupyter notebook covering data cleaning, profiling, and structural preparation.
* zomato_analysis.sql: Production SQL querying suite covering multi-tier segmentations and complex window functions.
* Zomato_data_analysis.pbix: Interactive, enterprise-level business intelligence canvas file.

---

## Deployment & Execution Instructions
1. Pipeline Initialization: Run the Python script within Zomato_data_analysis.ipynb to process the source layer and structure the data.
2. Database Analytical Processing: Load clean_dataset.csv into your database manager and execute the queries inside zomato_analysis.sql to generate the analytical logic metrics.
3. Visualization Interface: Launch the Zomato_data_analysis.pbix file via Power BI Desktop to interact with the production visualization canvas.
