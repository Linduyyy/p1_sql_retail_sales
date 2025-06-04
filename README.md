# Retail Sales Analysisi SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis
**Level**: Beginner
**Databasee**: sql_project_p1_db

Thid project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involve setting up a retail sales database, performing exploratory data analysis (EDA), and answering spesific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer spesific business questions and derive insights from  the sales data.

## Objectives

### 1. Database Setup

- **Database Creation**: The project starts by creating a database name `sql_project_p1_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes column for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database sql_project_p1_db;

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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values  in the dataset and delete records with missing data.

```sql
select count(*) from retail_sales;
select count(ditinct customer_id) from retail_sales;
select distinct category from retail_sales;

select * from retail_sales
where 
	sale_date is null or sale_time is null or customer_id is null or
	gender is null or age is null or category is null or
  quantity is null or price_per_unit is null or cogs is null or total_sale is null;

delete from retail_sales
where
	sale_date is null or sale_time is null or customer_id is null or
	gender is null or age is null or category is null or
  quantity is null or price_per_unit is null or cogs is null or total_sale is null;
```

### 3. Data Analysis & Findings

The following SQL Queries were developed to answer spesific business questions:

1. **Retrieve sales made on a spesific date**:
   ```sql
   select * from retail_sales where sale_date = '2022-11-05';
   ```
   
2. **Filter transaction based on category and quantity sold**:
   ```sql 
   select * from retail_sales
   where category = 'clothing' and quantiy >= 3 and
         extract(month from sale_date) = 11 and
         extract(year from sale_date) = 2022;
   ```
   
3. **Calculate total sales per category**:
   ```sql
  select category, sum(total_sale) as net_sel, count(*) as total_orders
  from retail_sales
  group by 1 
  order by 2 desc;
   ```

4. **Find the average age of customers by category**:

