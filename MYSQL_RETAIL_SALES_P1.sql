-- SQL RETAIL SALES ANALYSIS- P1

CREATE DATABASE SQL_PROJECT;
USE SQL_PROJECT;
    

-- creating table

CREATE TABLE RETAIL_SALES(
                         transaction_id	INT PRIMARY KEY,
					     sale_date	DATE,
                         sale_time	TIME,
                         customer_id	INT,
                         gender	VARCHAR(15),
                         age	INT,
                         category VARCHAR(15),
                         quantity INT,
						 price_per_unit	FLOAT,
                         cogs	FLOAT,
                         total_sale FLOAT
						 );

SELECT * FROM RETAIL_SALES
LIMIT 10;

SELECT COUNT(*)
FROM RETAIL_SALES;
 
-- data cleaning

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

--
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
      
-- data exploration

-- how many sales do we have?
SELECT COUNT(*) AS total_sale
FROM RETAIL_SALES;

SELECT DISTINCT category 
FROM RETAIL_SALES;


-- data analysis & business key problems & answers
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM RETAIL_SALES
WHERE sale_date ="2022-11-05";

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

SELECT *
FROM RETAIL_SALES
WHERE category = "Clothing"
      AND  
      quantity >=3
      AND 
      YEAR(sale_date) = 2022
      AND
      MONTH(sale_date) = 11;
      

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, 
       SUM(total_sale) AS net_sale
FROM RETAIL_SALES
GROUP BY category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT category, 
       ROUND(AVG(age),2)
FROM RETAIL_SALES
WHERE category ="Beauty"
GROUP BY category;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM RETAIL_SALES
WHERE total_sale >1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category,
	   gender, 
       COUNT(transaction_id)
FROM RETAIL_SALES
GROUP BY category, gender
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT YEAR(sale_date) AS year, 
       MONTH(sale_date) AS month, 
       AVG(total_sale)  AS avg_sale, 
	   RANK() OVER(
                   PARTITION BY YEAR(sale_date) 
                   ORDER BY AVG(total_sale) DESC
                   ) AS best_selling
FROM RETAIL_SALES
GROUP BY year, month; 

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id,
       SUM(total_sale) AS total_sale
FROM RETAIL_SALES
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category, COUNT(DISTINCT customer_id)
FROM RETAIL_SALES
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    CASE 
        WHEN HOUR(sale_time) <= 12 THEN 'MORNING'
        WHEN HOUR(sale_time) BETWEEN 13 AND 17 THEN 'AFTERNOON'
        ELSE 'EVENING'
    END AS SHIFT,
    COUNT(quantity) AS total_orders
FROM RETAIL_SALES
GROUP BY SHIFT;

-- Q.11 Find the maximum total sale for each category.

SELECT category, 
	   MAX(total_sale) AS max_total_sale
FROM RETAIL_SALES
GROUP BY category;

-- Q.12 Find the minimum age of a customer who purchased in each category.

SELECT category,
       MIN(age) AS youngest_customer
FROM RETAIL_SALES
GROUP BY category;

-- Q.13 Find the top 3 most expensive products sold (based on price_per_unit).

SELECT * 
FROM RETAIL_SALES
ORDER BY price_per_unit DESC
LIMIT 3;

-- Q.14 Find the total sales generated by customers under 30 years old.

SELECT SUM(total_sale) AS sales_under_30
FROM RETAIL_SALES
WHERE age <30;

-- Q.15 Find the average cogs (cost of goods sold) per category.

SELECT category,
       AVG(cogs) AS avg_cogs
FROM RETAIL_SALES
GROUP BY category;

-- Q.16 Find which gender spent more on “Clothing” overall.

SELECT gender,
       SUM(total_sale) AS clothing_sales
FROM RETAIL_SALES
WHERE category ="Clothing"
GROUP BY gender
ORDER BY clothing_sales DESC;

-- Q.17 Find the day with the highest number of transactions in 2022

SELECT sale_date,
       COUNT(*) AS highest_transaction
FROM RETAIL_SALES
WHERE YEAR(sale_date) = 2022
GROUP BY sale_date
ORDER BY highest_transaction DESC
LIMIT 1;

-- Q.18 Find the average order value per customers.

SELECT customer_id,
       AVG(total_sale) AS avg_order_value
FROM RETAIL_SALES
GROUP BY customer_id;

-- Q.19 Find the top 5 youngest customers with the highest total sales.
SELECT customer_id, 
       age, 
       SUM(total_sale) AS total_spent
FROM RETAIL_SALES
GROUP BY customer_id, age
ORDER BY total_spent DESC, age ASC
LIMIT 5;

-- Q.20 Find the total quantity of items sold in each category per month of each year.

SELECT category,
       YEAR(sale_date) AS year,
       MONTH(sale_date) AS month,
       SUM(quantity) AS total_quantity
FROM RETAIL_SALES
GROUP BY category, YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month, category;



       

