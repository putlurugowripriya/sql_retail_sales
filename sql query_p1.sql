 CREATE DATABASE sql_project_p2;
 DROP TABLE IF EXISTS retail_sales;
 CREATE TABLE retail_sales
              (
                    transactions_id INT PRIMARY KEY,
                    sale_date DATE,
                    sale_time TIME,
                    customer_id INT,
                    gender VARCHAR(15),
                    age INT,
                    category VARCHAR(15),
                    quantiy INT,
                    price_per_unit FLOAT,
                    cogs FLOAT,
                    total_sales FLOAT
    
              );
select * from retail_sales
LIMIT 10
select count(*) from retail_sales
select * from retail_sales
WHERE transactions_id IS NULL
select * from retail_sales
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
	age IS NULL 
	OR 
	category IS NULL
	OR 
	quantiy IS NULL
	OR 
	price_per_unit IS NULL
	OR 
	cogs IS NuLL
	OR 
	total_sales IS NULL
select count(*) as total_sales from retail_sales
select count(distinct customer_id) as total_sales from retail_sales
select distinct category from retail_sales

-- sql query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales
where sale_date='2022-11-05'
--write a sql query to calculate the total_sales(total_sale) for each category
select category,
SUM(total_sales) as net_sale,
count(*) as total_orders
from retail_sales
GROUP BY 1
--write a SQL query to find the average age of customers who purchased items from thr 'Beauty category'
select ROUND(AVG(age),2) as avg_age
from retail_sales 
where category ='Beauty'
--write a sql query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where total_sales>1000
--write a sql query to find total number of transactions made by each gender in each category.
select category,gender,
count(*) as total_trans 
from retail_sales
GROUP BY 
category,gender
--write a sql query to calculate the average sale for each month ,find out best selling month each year
select year,month,avg_sale
from
(
select 
extract(Year from sale_date) as year,
extract(month from sale_date) as month,
AVG(total_sales) as avg_sale,
Rank() over(partition by extract (year from sale_date) order by avg(total_sales) DESC) as rank
from retail_sales
group by 1,2
) as t1 
where rank=1

--write a sql query to create shift and number of orders(example moring<12,afternoon between 12&17,evening >17 )
with hourly_sale
as
(
select *,
case
when extract(hour from sale_time)<12 then'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
END as shift 
from retail_sales
)
select 
shift,count(*) as total_orders
from hourly_sale
group by shift

