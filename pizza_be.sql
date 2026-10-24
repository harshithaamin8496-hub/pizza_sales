use pizzadb;

select * from pizza_sales;

-- filter data based on pizza size M
select * from pizza_sales where pizza_size = 'M';


-- kpi requirements

--total revenue
select sum(total_price) as Total_Revenue from pizza_sales;

--average price per order
select sum(total_price) / count(distinct order_id) as Average_Order from pizza_sales;

--total pizza sold(total sales)
select sum(quantity) as Total_sales from pizza_sales;

--total orders
select count(distinct order_id) as Total_orders from pizza_sales;

--Average Pizzas Per Order 
select sum(quantity) / count(distinct order_id) as Average_pizza_per_order from pizza_sales;


-- CAST() -- is used to convert a value from one data type to another data type.
-- syntax--CAST(value AS data_type)

-- example
SELECT CAST(100 AS DECIMAL(10,2)); -- answer is 100.00


select cast(sum(quantity) / count(distinct order_id) as decimal(10,2)) 
as Average_pizza_per_order from pizza_sales;

select cast(sum(total_price) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as average_price_per_order from pizza_sales;

select cast(cast(sum(total_price) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as average_price_per_order from pizza_sales;

select cast(sum(total_price)/count(distinct order_id) as decimal(10,3)) 
as average_price_per_order from pizza_sales;


-- Business Analysis

-- find the quantity sold in each pizza category
select pizza_category, sum(quantity) as Total_quantity
from pizza_sales
group by pizza_category;

-- find the revenue in each pizza category
select pizza_category, sum(total_price) as Total_price
from pizza_sales
group by pizza_category;

-- daily trends on orders
select datename(dw,order_date) as order_day, count(distinct order_id)
as total_orders from pizza_sales 
group by datename(dw,order_date)
order by total_orders desc;

-- monthly orders
select datename(month,order_date) as order_month, count(distinct order_id) 
as total_orders from pizza_sales 
group by datename(month,order_date)
order by total_orders desc;

-- hourly orders
select DATEPART(hour,order_time) as order_hour, count(distinct order_id) 
as total_orders
from pizza_sales
group by DATEPART(hour,order_time)
order by total_orders desc;

-- total pizzas sold by pizza name
select pizza_name, sum(quantity) as total_sales 
from pizza_sales
group by pizza_name
order by pizza_name;

-- top 3 months based on orders
select top 3 datename(month,order_date) as month_name, 
count(distinct order_id) as total_orders 
from pizza_sales 
group by datename(month,order_date) 
order by total_orders desc;



-- task
-- bottom 3 months based on orders
-- top 5 pizza names based on sales
-- top 5 pizza names based on revenue
-- percentage of orders by quantity
-- total orders by pizza size
-- top 5 best selling pizza by revenue


-- date related queries
-- Extract year
SELECT order_date,YEAR(order_date) AS order_year
FROM pizza_sales;

-- make permanent column
alter table pizza_sales
add order_year int;

UPDATE pizza_sales
SET order_year = YEAR(order_date);


-- all date value extraction
SELECT order_date,
       YEAR(order_date) AS order_year,
       MONTH(order_date) AS month_number,
       DATENAME(MONTH, order_date) AS month_name,
       DAY(order_date) AS day_number,
       DATENAME(WEEKDAY, order_date) AS day_name
FROM pizza_sales;


-- one import difference
-- DATEPART() → returns a number
-- SELECT DATEPART(MONTH, order_date)----result -> 1,2,3,4,...

-- DATENAME() → returns a name
-- SELECT DATENAME(MONTH, order_date)----result -> January,February,..
