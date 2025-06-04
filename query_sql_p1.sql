-- sql retail sales analys - p1

-- 1. create table -
create table retail_sales
		(
			transactions_id int,
			sale_date date,
			sale_time time,
			customer_id int,
			gender varchar(15),
			age int,
			category varchar(15),
			quantiy int,
			price_per_unit int,
			cogs float,
			total_sale float
		);
        
        show tables;
        
select*from retail_sales;
        
select 
	count(*)
from retail_sales;

select * from retail_sales
where 
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantity is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null;

select * from retail_sales
where price_per_unit is null
or cogs is null
or total_sale is null;


-- data exploration

-- how many customer we have?
select count(customer_id) as total_cust from retail_sales;
select distinct(category) from retail_sales;

-- Data analys & business key problems answer
-- 1. write a sql query to retrieve all columns for sales made on 2022-11-05
-- 2. write a sql query to retrieve all transactions where the category is 'clothing' and the month of nov-2022
-- 3. write a sql query to calculate the total sales (total_sale) for each category
-- 4. write a sql query to find the average age of customers who [urchased items for the 'beauty' category
-- 5. write a sql query to find all transactions where the total_sale is greater then 1000
-- 6. write a sql query to find total_number of transaction (transaction_id) made by each gender in each category
-- 7. write a sql query to calculate the avg sale for each month. find out best selling month in each year.
-- 8. write a sql query to find the top 5 customers based on the highest total_sales
-- 9. write a sql query to find the number of unique customer who purchased items for each category
-- 10. write a sql query to create each shift and number of orders (ex : morning <= 12, afternoon between 12 & 17, evening >17)


-- 1. write a sql query to retrieve all columns for sales made on 2022-11-05
select * 
from retail_sales
where sale_date = '2022-11-05';

-- 2. write a sql query to retrieve all transactions where the category is 'clothing' and quantity sold more than 10 at the month of nov-2022
select * 
from retail_sales
where 
	category = 'clothing'
	and 
    month(sale_date) = 11
    and
    year(sale_date) = 2022
    and
    quantiy >= 3;
    
-- 3. write a sql query to calculate the total sales (total_sale) for each category
select 
	category, 
    sum(total_sale) as net_sel,
    count(*) as total_orders
from retail_sales
group by 1 
order by 2 desc;

-- 4. write a sql query to find the average age of customers who purchased items for the 'beauty' category
select
	avg(cast(age as decimal (10,1))) as avg_age
from retail_sales
where category = 'Beauty';

-- 5. write a sql query to find all transactions where the total_sale is greater then 1000
select 
	category,
    quantiy,
    total_sale
from retail_sales
where total_sale > 1000;

-- 6. write a sql query to find total_number of transaction (transaction_id) made by each gender in each category
select 
	gender,
    category,
    count(*) as total_transaction
from retail_sales
group by 1,2
order by 3 desc;

-- 7. write a sql query to calculate the avg sale for each month. find out best selling month in each year.
select 
	year,
    month,
    avg_sale
from
(
	select
		extract(year from sale_date) as year,
		extract(month from sale_date) as month,
		round(avg(total_sale),2) as avg_sale,
		rank() over(partition by extract(year from sale_date) order by round(avg(total_sale),2) desc) as ranking
	from retail_sales
	group by 1,2) as t1
where ranking = 1;
-- order by 1,3 desc;

-- 8. write a sql query to find the top 5 customers based on the highest total_sales
select 
	customer_id,
    sum(total_sale) as total_sale
from retail_sales
group by 1
order by 2 desc
limit 5;

-- 9. write a sql query to find the number of unique customer who purchased items for each category
select 
	category,
    count(distinct customer_id) as cust
from retail_sales
group by 1;

-- 10. write a sql query to create each shift and number of orders (ex : morning <= 12, afternoon between 12 & 17, evening >17)
with hourly_time
as
(
select *,
	case
	when extract(hour from sale_time) <= 12 then "morning"
    WHEN extract(hour from sale_time) BETWEEN 13 AND 17 THEN 'afternoon'
    when extract(hour from sale_time) > 17 then 'evening'
	ELSE 'outside_range'
    END AS time_period
from retail_sales)
select 
		time_period,
        category,
        count(*) as total_orders
from hourly_time
group by 1,2
order by 3 desc;