-- SQL Retail Sales Analysis - p1

-- Cteate Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
             (
                transactions_id INT PRIMARY KEY,
				sale_date DATE,	
				sale_time TIME,	
				customer_id	INT,
				gender	VARCHAR(15),
				age	INT,
				category VARCHAR(15),	
				quantiy	INT,
				price_per_unit FLOAT,	
				cogs FLOAT,	
				total_sale FLOAT

			 );
SELECT * FROM retail_sales
LIMIT 10


SELECT 
     COUNT(*)
FROM retail_sales


SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE customer_id IS NULL

SELECT * FROM retail_sales
WHERE gender IS NULL
--DATA CLEANING
SELECT * FROM retail_sales
WHERE 
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL
     OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL


DELETE FROM retail_sales
WHERE
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL
     OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL

--DATA EXPLORATION

--HOW MANY SALES WE HAVE?
SELECT COUNT(*) as total_sale FROM retail_sales

--HOW MANY UNIQUE CUSTOMERS WE HAVE?
SELECT COUNT(DISTINCT customer_id) as total_sale From retail_sales

SELECT DISTINCT category From retail_sales

--DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS

--0.1 WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALE MADE ON '2022-11-05'

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

--0.2 WRITE A SQL QUERY IS RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUENTITY SOLD IS MORE THAN 10 IN THE MONYH OF NOV-2022
SELECT
     *
	FROM retail_sales
	WHERE
	category = 'Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4
--0.3 WRITE A SQL QUERY TO CALCULATE THE TATAL SALES (TOTAL_SALE) FOR EACH CATEGORY.

SELECT 
      category,
	  SUM(total_sale) as net_sale,
	  COUNT(*) as totel_orders
FROM retail_sales
GROUP BY 1

--0.4 WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMER WHO PURCHASED ITEMS FROM THE 'BEAUTY' CATEGORY.

SELECT
      ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

--0.5 WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE TOTAL_SALES IS GRATER THAN 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000

--0.6 WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS (TRANSACTION_ID) MADE BY EACH GENDER IN EACH CATEGORY.

SELECT
      category,
	  gender,
	  COUNT(*) as total_trans
FROM retail_sales
GROUP
     BY
	 category,
	 gender
ORDER BY 1

--0.7 WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND OUT BEST SELLING MONTH IN EACH YEAR.
SELECT
      year,
	  month,
	avg_sale
FROM
(
SELECT
      EXTRACT(YEAR FROM sale_date) as year,
	  EXTRACT(MONTH FROM sale_date) as month,
	  AVG(total_saLe) as avg_sale,
	  RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

-- ORDER BY 1, 3 DESC

--0.8 WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES.

SELECT
      customer_id,
	  SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--0.9 WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMER WHO PURCHASED ITEMS FROM EACH CATEGORY.

SELECT
      CATEGORY,
	  COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category


--WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS (EXAMPLE MORNING <=12, AFTERNOON BETWEEN 12 & 17, EVENING >17).

WITH hourly_sales
AS
(
SELECT *,
        CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift	
FROM retail_sales
)
SELECT
      shift,
	  COUNT(*) as total_orders
FROM hourly_sales
GROUP BY shift

--END OF PROJECT









