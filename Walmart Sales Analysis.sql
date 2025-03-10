CREATE DATABASE IF NOT EXISTS salesDataWalmart;

USE salesDataWalmart;

CREATE TABLE IF NOT EXISTS sales(
	invoice_ID VARCHAR(50) PRIMARY KEY,
    branch VARCHAR(30) NOT NULL, 
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL, 
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6,4) NOT NULL,				-- VALUED ADDED TAX
    total DECIMAL(12, 4) NOT NULL,
	date DATETIME NOT NULL,
    time TIME NOT NULL,
	payment_method VARCHAR(20) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL, 					-- Cost of the Goods Sold
	gross_margin_percentage FLOAT(11, 9) NOT NULL,
    gross_income DECIMAL(12,4) NOT NULL,
    rating FLOAT(2,1)
);

SELECT * FROM sales;


														-- FEATURE ENGINEER 

														-- Time of DAY

SELECT time,
	(CASE 
		WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "MORNING"
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "AFTERNOON"
        ELSE "EVENING"
        END
    ) AS Time_OF_Day
 FROM sales; -- would select only time column 

ALTER TABLE sales 
ADD COLUMN Time_Of_Day VARCHAR(20) NOT NULL;

SET SQL_SAFE_UPDATES = 0;

UPDATE sales
SET Time_Of_Day = (
	CASE 
			WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "MORNING"
			WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "AFTERNOON"
			ELSE "EVENING" 
	END
);

									-- Day Name
SELECT 
	date,
	DAYNAME(date) AS Day_Name
FROM sales;

ALTER TABLE sales
ADD COLUMN Day_Name VARCHAR(20);

UPDATE sales			
SET Day_Name = DAYNAME(date);

									-- Month_Name
SELECT 
	date, 
	MONTHNAME(date)
FROM sales;

ALTER TABLE sales
ADD COLUMN Month_Name VARCHAR(20);

UPDATE sales
SET Month_Name = MONTHNAME(date); 

										-- BUSINESS QUESTIONS
-- Generic Questions
-- 1) How many unique cities does the data have ?

SELECT 
	DISTINCT city
FROM sales;

-- which Branch is present in those city ?

SELECT 
	DISTINCT city, branch
FROM sales;

-- PRODUCT BASED QUESTIONS
-- How many unquie product line does the Data have ?

SELECT COUNT(DISTINCT product_line) AS Distinct_Products
FROM sales;

-- What is the most common payment method ?

SELECT DISTINCT payment_method, COUNT(payment_method) AS COUNT
FROM sales
GROUP BY payment_method
ORDER BY COUNT DESC
LIMIT 1;

-- What is the most selling product line 

SELECT DISTINCT product_line, COUNT(product_line) AS Count_Pdt_Line
FROM sales
GROUP BY product_line
ORDER BY Count_Pdt_Line DESC
LIMIT 1; -- Limits the topmost data as set to 1, so it gives the most sold prodcut. If we want the entire list we can remove the LIMIT statement.

-- What is the total revenue by Month ?

SELECT DISTINCT Month_Name AS RESPECTIVE_MONTH, SUM(total) AS Total_Revenue
FROM sales
GROUP BY Month_Name
ORDER BY Total_Revenue DESC; 

-- What month has a largest COGS ?

SELECT DISTINCT Month_Name, SUM(cogs) AS Cost_Of_Goods
FROM sales
GROUP BY Month_Name
ORDER BY Cost_Of_Goods DESC;

-- What product line had a largest revenue ?

SELECT product_line, SUM(total) AS total_Revenue
FROM sales
GROUP BY product_line
ORDER BY total_Revenue DESC;

-- What is the city with largest revenue ?

SELECT city, SUM(total) AS total_Revenue
FROM sales
GROUP BY city
ORDER BY total_Revenue DESC;

-- What product line had a largest VAT (Valued Added Tax)?

SELECT product_line, AVG(VAT) AS avg_Tax
FROM sales
GROUP BY product_line
ORDER BY avg_Tax DESC;

-- Which branch sold more products than average product sold ?

SELECT branch, SUM(quantity) AS Qnt
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common Product line by Gender ?

SELECT gender, product_line, COUNT(gender) AS total_count 
FROM sales
GROUP BY gender, product_line
ORDER BY gender DESC;

-- What is the avg rating of each product ?

SELECT product_line ,ROUND(AVG(rating), 2) AS AVG_Rating  -- We have used ROUND(A, B) Function where A is the Data to be rounded off and B is the no of decimal place to which the Data to be rounded.
FROM sales
GROUP BY product_line
ORDER BY AVG_Rating DESC;


												-- SALES QUESTIONS 

-- Number of sales made in each time of the day per weekday ?

SELECT Time_Of_Day, COUNT(*) AS Total_Sales
FROM sales 
WHERE Day_Name = "MONDAY"
GROUP BY time_of_day;

-- Which of the customer type brings the most revenue ?

SELECT customer_type, SUM(total) AS Total_Revenue
FROM sales
GROUP BY customer_Type
ORDER BY Total_Revenue DESC;

-- Which city has the largest Tax Percent/ VALUED ADDED TAX(VAT) ?

SELECT city, AVG(VAT) Avg_Tax
FROM sales
GROUP BY city
ORDER BY Avg_Tax DESC;

									-- Customer Based Questions

-- How many unique customer types does the data have ?

SELECT DISTINCT Customer_Type 
FROM sales;

SELECT COUNT(DISTINCT Customer_Type) AS Unique_Customer_Type
FROM sales;

-- How many unique payment_method does the data have ?

SELECT DISTINCT Payment_Method
FROM sales;

SELECT COUNT(DISTINCT Payment_Method) AS Unique_Method
FROM sales;

-- What is the most common Customer type ? OR Which Customer type Buys the Most ?

SELECT DISTINCT Customer_Type, COUNT(Customer_Type) AS No_of_Customer
FROM sales
GROUP BY Customer_Type
ORDER BY No_of_Customer DESC
LIMIT 1;

-- What is the Gender of Most Customer ?

SELECT Gender, COUNT(Gender) AS Customer_Count 
FROM sales
GROUP BY GENDER
ORDER BY Customer_Count DESC;

-- What is the Gender distribution per branch ?

-- The Below 3 blocks are to find the gender distributions Dynamically.
SELECT Gender, COUNT(Gender) AS Gender_Cnt
FROM sales
WHERE Branch = "A"
GROUP BY Gender;

SELECT Gender, COUNT(Gender) AS Gender_Cnt
FROM sales
WHERE Branch = "B"
GROUP BY Gender;

SELECT Gender, COUNT(Gender) AS Gender_Cnt
FROM sales
WHERE Branch = "C"
GROUP BY Gender;

-- This Query groups both the Branch and the Gender along with the GENDER COUNT.
SELECT Branch, Gender, COUNT(Gender) AS Gender_Cnt
FROM sales
GROUP BY Branch, Gender;

-- Which time of the day do customers give the most ratings ?

SELECT Time_Of_Day, AVG(Rating) AS Avg_Rating 
FROM sales
GROUP BY Time_of_Day
ORDER BY Avg_Rating DESC;

-- Which time of the day do customers give the most ratings per branch ?

SELECT Branch, Time_of_Day, ROUND(AVG(Rating),3) AS Avg_Rating
FROM sales
GROUP BY Branch, Time_of_Day
ORDER BY Avg_Rating DESC;

-- To make the process Dynamic i.e to select it for each branch seperately.

SELECT Time_of_Day, ROUND(AVG(Rating),3) AS Avg_Rating
FROM Sales
WHERE Branch = "A"
GROUP BY Time_of_Day
ORDER BY Avg_Rating DESC;

SELECT Time_of_Day, ROUND(AVG(Rating),3) AS Avg_Rating
FROM Sales
WHERE Branch = "B"
GROUP BY Time_of_Day
ORDER BY Avg_Rating DESC;

SELECT Time_of_Day, ROUND(AVG(Rating),3) AS Avg_Rating
FROM Sales
WHERE Branch = "C"
GROUP BY Time_of_Day
ORDER BY Avg_Rating DESC;

-- Which day of the week has the best avg ratings ?

SELECT Day_Name, AVG(Rating) AS Avg_Rating
FROM sales
GROUP BY Day_Name
ORDER BY Avg_Rating DESC;

-- Which day of the week has the best avg ratings per branch ?

SELECT Branch, Day_Name, AVG(Rating) AS Avg_Rating
FROM sales
GROUP BY Branch, Day_Name
ORDER BY Avg_Rating DESC;

-- To make the process Dynamic.

SELECT Day_Name, AVG(Rating) AS Avg_Rating
FROM sales
WHERE Branch = "A"
GROUP BY Day_Name
ORDER BY Avg_Rating DESC;

SELECT Day_Name, AVG(Rating) AS Avg_Rating
FROM sales
WHERE Branch = "B"
GROUP BY Day_Name
ORDER BY Avg_Rating DESC;

SELECT Day_Name, AVG(Rating) AS Avg_Rating
FROM sales
WHERE Branch = "C"
GROUP BY Day_Name
ORDER BY Avg_Rating DESC;
