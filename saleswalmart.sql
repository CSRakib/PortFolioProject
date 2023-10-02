 create database if not exists saleswalmart;


create table if not exists sales(
   invoice_id varchar(30) not null primary key,
   branch varchar(5) not null,
   city varchar(30) not null,
   customer_type varchar(30) not null,
   gender varchar(10) not null,
   product_line varchar(100) not null,
   unit_price decimal(10,2) not null,
   quantity int not null,
   vat float(6,4) not null,
   total decimal(12,4) not null,
   date datetime not null,
   time Time not null,
   payment_method varchar(15) not null,
   cogs decimal (10,2) not null,
   gross_margin_pct float (11,9),
   gross_income decimal (12,4),
   rating float (2,1)
);

select * from sales;

-- -----------------------
-- Feature Engineering ---
-- (time of day)
select
 time,
 (case
   when `time` between  "00.00.00" and "12.00.00" then "Morning"
   when `time` between  "12.01.00" and "16.00.00" then "AfterNoon"
   else "Evening" end
 )as  time_of_date
 from sales;

Alter table sales Add column time_of_day varchar(20);

UPDATE sales 
SET time_of_day = (
    CASE 
        WHEN `time` BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN `time` BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
);


-- day
select date,dayname(date) as day_name from sales;

Alter table sales add column day_name varchar(20) ;

UPDATE sales 
SET day_name = dayname(date);


-- months
select date,monthname(date) as month_name from sales;

Alter table sales add column month_name varchar(20) ;

UPDATE sales 
SET month_name = monthname(date);

-------------- ----------------------------
-- genetic qstn 1 ---
-- how many unique city does the data have ---

select distinct city from sales;

-- genetic qstn 1 ---
-- in which city is each branch--

select distinct city, branch from sales;

---------------------
-- product --
-- qstn 1 ---
-- how many unique product line does the data have --
select count(distinct product_line) from sales;

 -- most selling product line the data have --
select 
 product_line,
 count(product_line) 
 as cnt from sales 
 group by product_line
 order by cnt desc;

-- what is the most common payment method --
SELECT payment_method,count(payment_method) AS payment_count
FROM sales
GROUP BY payment_method
order by payment_count desc;

-- what is the total revenue by month --

select month_name as month ,
sum(total) as total_revenue
from sales
group by month_name
order by total_revenue desc
;

-- what month has the largest cogs --
select
   month_name as month,
   sum(cogs) as cogs
   from sales
   group by month_name
   order by cogs desc;

-- what product line had largest revenue --
select product_line ,
  count(total) as total
  from sales
  group by product_line
  order by total desc;
  
  -- what is the city with largest revenue --
  select city,
  count(total) as total from sales
    group by city
    order by total desc;
    
    -- what product line has the largest vat --
    select product_line,
  count(vat) as vat from sales
    group by product_line
    order by vat desc;
    
    -- fetch each product line and add a column to those product line showing  "good","Bad" good is better then average salary
    
    
    -- which branch sold more products then average product
    select 
       branch,
      sum(quantity) as qty
from sales
      group by branch
	  having sum(quantity)>(select avg(quantity) from sales);

-- what is the most common product line by gender
select 
  gender,
  product_line,
  count(gender) as total_cnt
from sales
group by gender,product_line
order by total_cnt desc;

-- what is the avg rating of each product line
select
  round(avg(rating),2) as avg_rating,
  product_line
from sales
group by product_line
order by avg_rating desc;

-- sales --
-- -----------
-- number of sales made in each time of the day per weekday
select 
    time_of_day,
	count(*) As total_sales
from sales
where day_name="sunday"
group by time_of_day
 order by total_sales desc ;
 
 -- which of the cutomer types brings the most revenue --
  select 
    customer_type,
    sum(total) as total_rev
from sales
group by customer_type
order by total_rev desc;

-- which city has the largest tex percent/Vat(value added tex)? --
select 
  city,
  avg(vat) as vat
from sales
group by city
order by vat desc;

-- which customers type pays the most in vat? --

select 
  customer_type,
  avg(vat) as vat
from sales
group by customer_type
order by vat desc;

