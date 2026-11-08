create database project;
use project;
select * from zepto_v2;
select count(*) from zepto_v2;

select * from zepto_v2
limit 15;


# null values 

select * from zepto_v2
where name is null
or
category is null
or
mrp is null
or 
discountPercent is null 
or
availableQuantity is null 
or
discountedSellingPrice is null
or
weightInGms is null
or
outOfStock is null
or
quantity is null;

-- diferent product categories 
select distinct category
from zepto_v2
order by category;

-- products in stock vs out of stock 

select outOfstock, count(name)
from zepto_v2
group by outOfstock;

-- product names present multiple times 

select name, count(category) as "number of cate"
from zepto_v2
group by name 
having count(cate) > 1
order by count(cate) desc;

-- data cleaning 

-- products with price = 0

select * from zepto_v2
where mrp <= 0;

delete from zepto_v2 
where mrp =0;

-- convert paisa to rupees
 
 update zepto_v2
 set mrp =mrp/100.0,
 discountedSellingPrice =discountedSellingPrice/100.0;
 
 select mrp,discountedSellingPrice 
 from zepto_v2;
 
 select * from zepto_v2;
 
 -- bussiness Insight quries
  
-- 1. find the top 10 best value products based on the discounted percent 
 
select distinct name, mrp, discountPercent
from zepto_v2
order by discountPercent DESC
limit 5;

-- 2.what are the product with high mrp but out of stock

select distinct name, mrp
from zepto_v2
where outOfStock =True and mrp > 300
order by mrp desc;
 
 -- 3.calculate estimated revenue from each category 
 
 select category,
 sum(discountedSellingPrice * availableQuantity) as total_revenue
 from zepto_v2
 group by category 
 order by total_revenue;
 
 
 -- 4.find the products where mrp is greater than 500 and discount is less than 10%
 
 select distinct name, mrp, discountPercent
 from zepto_v2
 where mrp > 500 and discountPercent < 10
 order by mrp desc, discountPercent desc;
 
 
 
 
 -- 5. Identify the top 5 categories offering the highest average discount percentage
SELECT category, 
ROUND(AVG(discountPercent), 2) AS avg_discount 
FROM zepto_v2 
GROUP BY category 
ORDER BY avg_discount DESC 
LIMIT 5;

 
 
 
 
 
 
 
 