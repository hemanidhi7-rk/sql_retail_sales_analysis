# Retail Sales Analysis – SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `SQL_PROJECT`

This project demonstrates my SQL skills in data exploration, cleaning, and business analysis. The dataset represents retail sales transactions, and the goal is to use SQL queries to extract insights such as sales trends, customer behavior, and category performance.

The project is designed to reflect real-world data analyst tasks — creating and managing a database, performing exploratory data analysis (EDA), and solving business questions using SQL.


## Objectives

1. **Database Setup**: Create and populate a retail sales database.
2. **Data Cleaning**: Identify and remove null or incomplete records.
3. **Exploratory Data Analysis (EDA)**: Understand dataset patterns (customers, categories, trends).
4. **Business Queries**: Answer business-related questions to extract actionable insights.


## Project Structure

### 1. Database Setup
- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE SQL_PROJECT;
USE SQL_PROJECT;

CREATE TABLE RETAIL_SALES(
                         transaction_id INT PRIMARY KEY,
		                 sale_date DATE,
                         sale_time TIME,
                         customer_id	INT,
                         gender	VARCHAR(15),
                         age	INT,
                         category VARCHAR(15),
                         quantity INT,
			             price_per_unit	FLOAT,
                         cogs	FLOAT,
                         total_sale FLOAT
			 );
	```

### 2. Data Exploration & Cleaning
- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

``` sql
SELECT COUNT(*) AS total_sale
FROM RETAIL_SALES;

SELECT DISTINCT category 
FROM RETAIL_SALES;

SELECT *
FROM RETAIL_SALES
WHERE 
     transaction_id IS NULL
     OR
     sale_date	IS NULL
     OR
     sale_time IS NULL
     OR
     customer_id	IS NULL
     OR
     gender IS NULL
     OR
     age IS NULL
     OR
     category IS NULL
     OR 
     quantity	IS NULL
     OR
     price_per_unit IS NULL
     OR
     cogs IS NULL
     OR
     total_sale IS NULL;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM RETAIL_SALES
WHERE 
      transaction_id IS NULL
      OR
      sale_date	IS NULL
	  OR
      sale_time IS NULL
      OR
      customer_id	IS NULL
      OR
      gender IS NULL
      OR
      age IS NULL
	  OR
      category IS NULL
      OR 
      quantity	IS NULL
      OR
      price_per_unit IS NULL
      OR
      cogs IS NULL
      OR
      total_sale IS NULL;
```

### 3. Analysis & Insights

 **SQL queries were written to answer**:
        -Daily sales reports
        -High-value transactions
        -Sales by category and gender
        -Monthly trends and top-selling months
        -Top 5 customers
        -Unique customers per category
        -Sales by shifts (Morning, Afternoon, Evening)

### Example Queries

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05'**

``` sql
SELECT * FROM RETAIL_SALES
WHERE sale_date ="2022-11-05";
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**

``` sql
SELECT *
FROM RETAIL_SALES
WHERE category = "Clothing"
      AND  
      quantity >=3
      AND 
      YEAR(sale_date) = 2022
      AND
      MONTH(sale_date) = 11;
```

3.**Write a SQL query to calculate the total sales (total_sale) for each category.**

``` sql
SELECT category, 
       SUM(total_sale) AS net_sale
FROM RETAIL_SALES
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**

``` sql
SELECT category, 
       ROUND(AVG(age),2)
FROM RETAIL_SALES
WHERE category ="Beauty"
GROUP BY category;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**

``` sql
SELECT *
FROM RETAIL_SALES
WHERE total_sale >1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**

``` sql
SELECT category,
	   gender, 
       COUNT(transaction_id)
FROM RETAIL_SALES
GROUP BY category, gender
ORDER BY 1;
```

7.**Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**

``` sql
SELECT YEAR(sale_date) AS year, 
       MONTH(sale_date) AS month, 
       AVG(total_sale)  AS avg_sale, 
       RANK() OVER(
                   PARTITION BY YEAR(sale_date) 
                   ORDER BY AVG(total_sale) DESC
                   ) AS best_selling
FROM RETAIL_SALES
GROUP BY year, month; 
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales.**

``` sql
SELECT customer_id,
       SUM(total_sale) AS total_sale
FROM RETAIL_SALES
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

9.**Write a SQL query to find the number of unique customers who purchased items from each category.**

``` sql
SELECT category, COUNT(DISTINCT customer_id)
FROM RETAIL_SALES
GROUP BY category;
```

10.**Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)**

``` sql
SELECT 
    CASE 
        WHEN HOUR(sale_time) <= 12 THEN 'MORNING'
        WHEN HOUR(sale_time) BETWEEN 13 AND 17 THEN 'AFTERNOON'
        ELSE 'EVENING'
    END AS SHIFT,
    COUNT(quantity) AS total_orders
FROM RETAIL_SALES
GROUP BY SHIFT;
```

11.**Find the maximum total sale for each category.**

``` sql
SELECT category, 
	   MAX(total_sale) AS max_total_sale
FROM RETAIL_SALES
GROUP BY category;
```

12.**Find the minimum age of a customer who purchased in each category.**

``` sql
SELECT category,
       MIN(age) AS youngest_customer
FROM RETAIL_SALES
GROUP BY category;
```

13.**Find the top 3 most expensive products sold (based on price_per_unit).**

``` sql
SELECT * 
FROM RETAIL_SALES
ORDER BY price_per_unit DESC
LIMIT 3;
```

14.**Find the total sales generated by customers under 30 years old.**

``` sql
SELECT SUM(total_sale) AS sales_under_30
FROM RETAIL_SALES
WHERE age <30;
```

15.**Find the average cogs (cost of goods sold) per category.**

``` sql
SELECT category,
       AVG(cogs) AS avg_cogs
FROM RETAIL_SALES
GROUP BY category;
```

16.**Find which gender spent more on “Clothing” overall.**

``` sql
SELECT gender,
       SUM(total_sale) AS clothing_sales
FROM RETAIL_SALES
WHERE category ="Clothing"
GROUP BY gender
ORDER BY clothing_sales DESC;
```

17.**Find the day with the highest number of transactions in 2022.**

``` sql
SELECT sale_date,
       COUNT(*) AS highest_transaction
FROM RETAIL_SALES
WHERE YEAR(sale_date) = 2022
GROUP BY sale_date
ORDER BY highest_transaction DESC
LIMIT 1;
```

18.**Find the average order value per customers.**

``` sql
SELECT customer_id,
       AVG(total_sale) AS avg_order_value
FROM RETAIL_SALES
GROUP BY customer_id;
```

19.** Find the top 5 youngest customers with the highest total sales.**

``` sql
SELECT customer_id, 
       age, 
       SUM(total_sale) AS total_spent
FROM RETAIL_SALES
GROUP BY customer_id, age
ORDER BY total_spent DESC, age ASC
LIMIT 5;
```

20.**Find the total quantity of items sold in each category per month of each year.**

```sql
SELECT category,
       YEAR(sale_date) AS year,
       MONTH(sale_date) AS month,
       SUM(quantity) AS total_quantity
FROM RETAIL_SALES
GROUP BY category, YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month, category;
```

## Key Findings

--**Customer Demographics**: Sales are distributed across varied age groups and genders.
--**High-Value Transactions**: Many sales crossed 1000, showing premium buyers.
--**Sales Trends**: Certain months show higher sales, indicating seasonality.
--**Top Customers**: A small group of repeat buyers contributes disproportionately to revenue.
--**Shift Analysis**: Sales peak in specific shifts, useful for staffing and offers.

## Reports

--**Sales Summary** – Total sales, category performance, and customer distribution.
--**Trend Analysis** – Monthly and seasonal patterns.
--**Customer Insights** – Top spenders and unique customer counts per category.

## Conclusion

This project demonstrates SQL skills across database creation, cleaning, and real-world analysis. The insights highlight customer behavior, category performance, and sales trends — helping businesses make data-driven decisions.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run database_setup.sql to create the database and table. Insert the dataset provided in the data/ folder.
3. **Run the Queries**: Use analysis_queries.sql to execute the SQL queries and reproduce insights.

## Author
Hemanidhi R.K

Industrial & Production Engineer | Aspiring Data Analyst  
Passionate about SQL, Data Analytics & Business Insights  
