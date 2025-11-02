# 🍕 Pizza Sales Analytics Dashboard  

**Technologies:** SQL (MySQL) | Tableau | Excel  

## 📘 Overview  
This project performs an **end-to-end sales analysis** for a pizza company using SQL for data preparation and Tableau for visualization.  
It uncovers key business insights about sales performance, growth trends, customer behavior, and product popularity.

---

## 🎯 Objectives
- Clean and preprocess raw order data using SQL  
- Generate key performance metrics (KPIs):  
  - **Total Revenue, Total Orders, Average Order Value (AOV), Total Pizzas Sold**  
- Analyze trends by **pizza category**, **size**, **day of week**, and **hour of day**  
- Visualize growth patterns and category performance using Tableau  
- Build interactive **Sales** and **Growth Dashboards**  

---

## 🧩 Dataset Description
Each record in the dataset represents an order with the following key columns:

| Column Name | Description |
|--------------|-------------|
| `order_id` | Unique order identifier |
| `order_date` | Date of order (DD/MM/YYYY) |
| `order_time` | Time of order |
| `pizza_name` | Name of the pizza |
| `pizza_category` | Pizza type (Classic, Supreme, Veggie, Chicken, etc.) |
| `pizza_size` | Pizza size (S, M, L, XL, XXL) |
| `quantity` | Number of pizzas sold |
| `unit_price` | Price per pizza |
| `total_price` | Total amount (quantity × unit price) |

---

## ⚙️ SQL Workflow Summary

### 1️⃣ Data Preparation
- Converted `order_date` from string to `DATE` format  
- Verified data consistency and removed nulls  
- Disabled `SQL_SAFE_UPDATES` for column transformations

### 2️⃣ KPI Calculations
- **Total Revenue**, **Total Orders**, **Total Pizza Sold**, **Average Pizza per Order**  
- Identified **Average Order Value (AOV)**

### 3️⃣ Performance Insights
- **Top & Bottom 10 Pizzas** by sales and revenue  
- **Category and Size Breakdown** by revenue and percentage of total  
- **Revenue Share** per category across months  

### 4️⃣ Time-based Trends
- **Daily, Weekly, Monthly** sales trends  
- **Hourly performance** to identify peak business hours  
- **Cumulative growth tracking**

### 5️⃣ Advanced Analysis
- Ranked pizzas within each category using SQL **RANK()** function  
- Segmented orders into **Low**, **Medium**, and **High Value**  

---

## 📊 Tableau Dashboards

### 🔴 Sales Dashboard  
*(File: `salesdash.png`)*  
**Focus:** Product-level and category-level sales performance  

**Key Visuals:**
- **Hourly Pizza Category Sales:** Peak sales hours per category  
- **Category Sales Percentage (Bubble Chart):** Share of total revenue by pizza type  
- **Total Pizza Sale vs. Total Orders (Bar Chart):** Correlation between demand and order volume  
- **Weekly Sales Trend (Area Chart):** Seasonal sales performance  
- **Pizza Sale by Size (Bar Chart):** Demand distribution by size  
- **Pizza Sale throughout the Year (Color-coded Bar Chart):** Annual revenue variation  


---

### 🟢 Growth Dashboard  
*(File: `growthdash.png`)*  
**Focus:** Temporal and revenue growth patterns  

**Key Visuals:**
- **Sales Growth Over Time (Line Chart):** Daily cumulative sales trend  
- **Quantity vs. Revenue (Scatter Plot):** Correlation analysis  
- **AOV Over Months (Bar Chart):** Seasonal changes in average order value  
- **Cumulative Revenue Growth (Area Chart):** Progressive revenue addition  
- **Weekday Purchase Patterns (Vertical Bars):** Daily behavior patterns  
- **Daily Orders (Treemap):** Distribution of orders across days  

---

## 📈 KPIs Shown
| KPI | Description |
|------|--------------|
| 💰 **Total Revenue** | Total sales across all orders |
| 🍕 **Total Pizzas Sold** | Sum of all pizzas sold |
| 🧾 **Total Orders** | Count of distinct order IDs |
| 💵 **Avg Order Value (AOV)** | Average spend per order |
| 📦 **Avg Pizza per Order** | Mean quantity per order |

---

## 🧠 Key Insights
- **Classic pizzas** generate the highest revenue share (~27%)  
- **Weekends** show stronger sales volume  
- **L and M sizes** dominate both revenue and quantity  
- Sales **peak between 12-1 PM and 6–9 PM** daily  
- **Q2 months (April-June)** show accelerated revenue growth  with total revenue of $211k
- **Average Order Value ($38.31)** suggests strong mid-range pricing strategy  

---

## 📂 Files Included
- [pizza_sales.csv](pizza_sales.csv) — Dataset  
- [pizza_sales_analysis.sql](pizza_sales_analysis.sql) — SQL queries for analysis  
- [salesdash.png](salesdash.png) — Tableau Sales Dashboard  
- [growthdash.png](growthdash.png) — Tableau Growth Dashboard  
- [pizzadashboard.twbx](pizzadashboard.twbx) — Tableau packaged workbook  
- [README.md](README.md) — Project documentation  

---

## 🏁 Conclusion
This project demonstrates the integration of **SQL analytics** with **Tableau storytelling** for data-driven decision-making.  
It provides end-to-end insights into customer behavior, revenue optimization, and operational growth trends — ideal for managerial reporting or portfolio presentation.

