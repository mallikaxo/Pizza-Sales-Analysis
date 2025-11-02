-- ==========================================================
-- 🍕 PIZZA SALES ANALYTICS PROJECT (SQL + TABLEAU)
-- ==========================================================
-- Description:
-- This project performs end-to-end sales analysis using SQL.
-- The dataset contains detailed pizza order records including
-- order date, time, size, category, and total sales amount.
--
-- Objective:
-- - Clean and transform raw sales data
-- - Derive KPIs such as revenue, total orders, average order value
-- - Analyze pizza popularity, category performance, and sales trends
-- - Build insights for Tableau dashboard visualization
-- ==========================================================


-- ================================================
-- STEP 1: Disable SQL Safe Mode (for MySQL updates)
-- ================================================
SET SQL_SAFE_UPDATES = 0;


-- ================================================
-- STEP 2: Data Preview
-- ================================================
SELECT *
FROM pizzasales;


-- ================================================
-- STEP 3: Convert 'order_date' column to proper DATE format
-- ================================================
UPDATE pizzasales
SET order_date = STR_TO_DATE(order_date, '%d/%m/%Y');

ALTER TABLE pizzasales
MODIFY COLUMN order_date DATE;


-- ==================================================
-- STEP 4: Basic Insights and KPI Calculations
-- ==================================================

-- 🔹 Popular Pizza Types (by quantity sold and revenue)
SELECT 
	pizza_category,
    pizza_name,
    SUM(quantity) AS total_pizzas_sold,
    SUM(total_price) AS revenue_by_pizza
FROM pizzasales
GROUP BY pizza_category, pizza_name
ORDER BY total_pizzas_sold DESC;


-- 🔹 Average Order Value (AOV)
SELECT 
    ROUND(AVG(total_price), 2) AS average_order_value
FROM pizzasales;


-- 🔹 Overall Sales KPIs
-- Shows total orders, pizzas sold, total revenue, and average pizzas per order
SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_pizza_sold,
    ROUND(SUM(total_price), 2) AS total_revenue,
    ROUND(SUM(quantity)/COUNT(DISTINCT(order_id)), 2) AS average_pizza_per_order
FROM pizzasales;


-- ==================================================
-- STEP 5: Category and Size Performance Analysis
-- ==================================================

-- 🔹 Revenue Breakdown by Pizza Category
SELECT 
    pizza_category,
    ROUND(SUM(total_price), 2) AS total_revenue,
    ROUND(SUM(total_price) / (SELECT SUM(total_price) FROM pizzasales) * 100, 2) AS pct_of_total
FROM pizzasales
GROUP BY pizza_category
ORDER BY total_revenue DESC;


-- 🔹 Performance by Pizza Size
SELECT 
    pizza_size,
    SUM(quantity) AS total_sold,
    ROUND(SUM(total_price), 2) AS revenue
FROM pizzasales
GROUP BY pizza_size
ORDER BY revenue DESC;


-- ==================================================
-- STEP 6: Time-based Trend Analysis
-- ==================================================

-- 🔹 Daily Revenue Trend
SELECT 
    order_date,
    SUM(total_price) AS daily_revenue
FROM pizzasales
GROUP BY order_date
ORDER BY order_date;


-- 🔹 Hourly Sales Trend (to identify peak business hours)
SELECT 
    HOUR(order_time) AS order_hour,
    SUM(total_price) AS revenue
FROM pizzasales
GROUP BY order_hour
ORDER BY revenue DESC;


-- 🔹 Weekly Pattern (Weekday vs Weekend Performance)
SELECT 
    DAYNAME(order_date) AS day_of_week,
    SUM(total_price) AS total_revenue,
    SUM(quantity) AS total_pizzas_sold
FROM pizzasales
GROUP BY day_of_week
ORDER BY FIELD(day_of_week, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');


-- ==================================================
-- STEP 7: Product-Level Performance
-- ==================================================

-- 🔹 Top 10 Best-Selling Pizzas by Revenue
SELECT 
    pizza_name,
    SUM(quantity) AS total_sold,
    SUM(total_price) AS revenue
FROM pizzasales
GROUP BY pizza_name
ORDER BY revenue DESC
LIMIT 10;


-- 🔹 Least Performing Pizzas
SELECT 
    pizza_name,
    SUM(quantity) AS total_sold,
    SUM(total_price) AS revenue
FROM pizzasales
GROUP BY pizza_name
ORDER BY revenue ASC
LIMIT 10;


-- 🔹 Rank Pizzas by Total Revenue within Each Category
SELECT 
    pizza_category,
    pizza_name,
    SUM(total_price) AS revenue,
    RANK() OVER (PARTITION BY pizza_category ORDER BY SUM(total_price) DESC) AS rank_in_category
FROM pizzasales
GROUP BY pizza_category, pizza_name;


-- ==================================================
-- STEP 8: Time-Series and Growth Analysis
-- ==================================================

-- 🔹 Running Total Revenue Over Time
SELECT 
    order_date,
    SUM(total_price) AS daily_revenue,
    SUM(SUM(total_price)) OVER (ORDER BY order_date) AS running_total
FROM pizzasales
GROUP BY order_date
ORDER BY order_date;


-- 🔹 Monthly Revenue and Growth %
WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_price) AS revenue,
        COUNT(DISTINCT order_id) AS orders
    FROM pizzasales
    GROUP BY month
)
SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND((revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month) * 100, 2) AS growth_pct
FROM monthly_sales;


-- 🔹 Monthly Category Revenue Share
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    pizza_category,
    ROUND(SUM(total_price), 2) AS monthly_revenue,
    ROUND(SUM(total_price) / SUM(SUM(total_price)) OVER (PARTITION BY DATE_FORMAT(order_date, '%Y-%m')) * 100, 2) AS pct_share
FROM pizzasales
GROUP BY month, pizza_category
ORDER BY month, pct_share DESC;


-- ==================================================
-- STEP 9: Advanced Analytical Insights
-- ==================================================

-- 🔹 Best-Selling Pizza in Each Category (by Revenue)
WITH category_sales AS (
    SELECT 
        pizza_category,
        pizza_name,
        SUM(total_price) AS total_revenue,
        RANK() OVER (PARTITION BY pizza_category ORDER BY SUM(total_price) DESC) AS rnk
    FROM pizzasales
    GROUP BY pizza_category, pizza_name
)
SELECT *
FROM category_sales
WHERE rnk = 1;


-- 🔹 Order Value Segmentation
-- Categorize orders as 'Low', 'Medium', or 'High' based on total spend
SELECT 
    order_id,
    SUM(total_price) AS order_value,
    CASE
        WHEN SUM(total_price) < 15 THEN 'Low Value'
        WHEN SUM(total_price) BETWEEN 15 AND 30 THEN 'Medium Value'
        ELSE 'High Value'
    END AS order_segment
FROM pizzasales
GROUP BY order_id
ORDER BY order_value DESC;

-- ==================================================
-- ==================================================
