# 🛒 Walmart Sales Data Analysis using SQL

## 📌 Project Overview

This project analyzes Walmart sales transaction data to uncover business insights related to product performance, customer behavior, branch efficiency, and revenue trends using SQL.

The objective is to simulate a real-world retail business analysis scenario where raw transactional data is transformed into actionable business insights through data cleaning, feature engineering, and exploratory data analysis.

This project demonstrates practical SQL skills required for Data Analyst roles, including:

* Database design
* Data cleaning
* Feature engineering
* Exploratory Data Analysis (EDA)
* Business query solving
* Revenue and profitability analysis

---

## 🎯 Business Problem

Retail businesses generate large volumes of transactional data daily.
The challenge is converting raw sales records into meaningful insights that answer critical business questions such as:

* Which branch performs best?
* Which products generate the highest revenue?
* What customer segment contributes most to sales?
* Which payment methods dominate?
* When do customers purchase the most?

This analysis helps understand operational efficiency and customer purchase patterns.

---

## 🛠️ Tools & Technologies Used

* SQL (MySQL)
* MySQL Workbench
* GitHub
* Kaggle Dataset

---

## 📂 Dataset Information

Dataset source: Kaggle Walmart Sales Dataset

The dataset contains:

* 1000 sales records
* 3 Walmart branches
* 3 cities
* 17 columns

### Main Features

| Column         | Description                   |
| -------------- | ----------------------------- |
| invoice_id     | Unique transaction identifier |
| branch         | Branch code                   |
| city           | Branch city                   |
| customer_type  | Member / Normal customer      |
| gender         | Customer gender               |
| product_line   | Product category              |
| unit_price     | Price per unit                |
| quantity       | Quantity sold                 |
| VAT            | Value Added Tax               |
| total          | Total transaction value       |
| date           | Transaction date              |
| time           | Transaction time              |
| payment_method | Payment mode                  |
| cogs           | Cost of goods sold            |
| gross_income   | Profit generated              |
| rating         | Customer rating               |

---

## ⚙️ Project Workflow

### 1️⃣ Database Creation

* Created relational database schema
* Defined proper data types
* Applied primary key constraints
* Ensured non-null integrity

### 2️⃣ Feature Engineering

Generated additional analytical columns:

* `Time_Of_Day`
* `Day_Name`
* `Month_Name`

These columns helped identify:

* Peak shopping hours
* Best performing weekdays
* Monthly revenue trends

### 3️⃣ Exploratory Data Analysis (EDA)

Business-driven SQL queries were used to extract insights from the sales data.

---

## 📊 Key Business Questions Solved

### Product Analysis

* Number of unique product lines
* Most selling product line
* Highest revenue generating product line
* Product line with highest VAT contribution
* Average product ratings

### Sales Analysis

* Revenue by month
* Highest COGS month
* Best revenue generating city
* Branch selling above average quantity
* Sales trend by time of day

### Customer Analysis

* Most common customer type
* Gender distribution
* Preferred payment method
* Rating trends by branch
* Best rated weekday

---

## 📈 Key Insights Generated

* Certain product lines consistently generate higher revenue.
* Customer buying behavior changes significantly by time of day.
* Member customers contribute more revenue than normal customers.
* Some branches outperform others in both volume and ratings.
* Payment preferences reveal dominant customer transaction habits.

---

## 💡 Sample SQL Queries

### Feature Engineering Example

```sql
UPDATE sales
SET Time_Of_Day = (
    CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'MORNING'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'AFTERNOON'
        ELSE 'EVENING'
    END
);
```

### Revenue Analysis Example

```sql
SELECT Month_Name, SUM(total) AS Total_Revenue
FROM sales
GROUP BY Month_Name
ORDER BY Total_Revenue DESC;
```

### Customer Revenue Analysis

```sql
SELECT customer_type, SUM(total) AS Total_Revenue
FROM sales
GROUP BY customer_type
ORDER BY Total_Revenue DESC;
```

---

## 📐 Revenue Logic Used

### Cost of Goods Sold

`COGS = Unit Price × Quantity`

### VAT

`VAT = 5% × COGS`

### Total Revenue

`Total = COGS + VAT`

### Gross Profit

`Gross Income = Total - COGS`

### Gross Margin %

`Gross Margin = Gross Income / Total Revenue`

---

## 🚀 Why This Project Matters

This project demonstrates the ability to:

* Think like a business analyst
* Write analytical SQL queries
* Derive insights from raw transactional data
* Present findings professionally

This is directly relevant for:

* Data Analyst Internships
* SQL Analyst Roles
* Business Intelligence Entry-Level Positions

---

## 📌 Repository Structure

```text
├── Walmart_Sales_SQL.sql
├── README.md
├── dataset.csv
```

---

## 🔗 Future Improvements

* Build Power BI dashboard using same dataset
* Add SQL window functions
* Create KPI dashboard
* Extend analysis using Python

---

## 👨‍💻 Author

**S Harikesh**

Aspiring Data Analyst | SQL | Python | Power BI | Data Storytelling

---

## ⭐ If you found this project useful, consider starring the repository.
