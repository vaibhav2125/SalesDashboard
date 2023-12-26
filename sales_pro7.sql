                           /*Project Name : Product Sales Analysis */

      /* Title : This project aimed to extract, analyze, and visualize insights from a comprehensive superstore sales dataset */


use supermart_db;
select distinct count(*) - count(*) from customers;
select distinct count(*) - count(*) from products;
select distinct count(*) - count(*) from sales;


alter table customers
add column `Age_group` varchar(50) not null;

update customers
set `Age_group` = case
when `Age` < 30 then "Young"
when `Age` >= 30 and `Age` <= 45 then "Middle Age"
when `Age` > 45 and `Age` <= 60 then "Senior"
else "Old"
end;

                             
  -- -------------------------------      KPI     -------------------------------------
                             
                             -- Total Revenue
                             
select round(sum(`Sales`),2) as Total_Revenue
from sales;


                              -- Total orders
                              
select count(`Order Id`) as countID
from sales;


                               -- Total Profit
                               
select round(sum(`Profit`),2) as Total_profit
from sales;


                               -- Average Revenue
                               
select round(avg(`sales`),2) as Average_revenue
from sales;


                                -- Average Profit
                                
select round(avg(`Profit`),2) as average_profit
from sales;

-- ----------------------------------------------------------------------------------------------------------------


                                 -- 1) Revenue, orders, profit by ship mode
								
select `Ship Mode`, round(sum(`Sales`),2) as Total_revenue, round(count(`Order ID`),2) as Total_orders,
round(sum(`Profit`),2) as Total_profit
from sales
group by `Ship Mode`
order by Total_revenue desc;


                                 -- 2) revenue, orders, profit by category
                                 
select p.`category`, round(sum(s.`sales`),2) as Total_revenue, round(count(s.`Order ID`),2) as Total_orders,
round(sum(s.`Profit`),2) as Total_profit
from products p join sales s
on p.`product ID` = s.`Product ID`
group by p.`category`
order by Total_revenue desc;


                                 -- 3)  revenue, orders, profit by sub_category
                                 
select p.`Sub-category`, round(sum(s.`sales`),2) as Total_revenue, round(count(s.`Order ID`),2) as Total_orders,
round(sum(s.`Profit`),2) as Total_profit, round((sum(s.`Sales`) * 100) / sum(sum(s.`Sales`)) over(),0) as percent
from products p join sales s
on p.`product ID` = s.`Product ID`
group by p.`Sub-category`
order by Total_revenue desc;


                                    -- 4) revenue, orders, profit by region
                                 
select c.`region`, round(sum(s.`sales`),2) as Total_revenue, round(count(s.`Order ID`),2) as Total_orders,
round(sum(s.`Profit`),2) as Total_profit
from customers c join sales s
on c.`customer ID` = s.`customer ID`
group by c.`region`
order by Total_revenue desc;


                                    -- 5) revenue, orders, profit by state
                                 
select c.`state`, round(sum(s.`sales`),2) as Total_revenue, round(count(s.`Order ID`),2) as Total_orders,
round(sum(s.`Profit`),2) as Total_profit
from customers c join sales s
on c.`customer ID` = s.`customer ID`
group by c.`state`
order by Total_revenue desc;



							           -- 6) revenue, orders, profit by city
                                 
select c.`city`, round(sum(s.`sales`),2) as Total_revenue, round(count(s.`Order ID`),2) as Total_orders,
round(sum(s.`Profit`),2) as Total_profit
from customers c join sales s
on c.`customer ID` = s.`customer ID`
group by c.`city`
order by Total_revenue desc;


							          -- 7) revenue, orders, profit by Segment
                                 
select c.`Segment`, round(sum(s.`sales`),2) as Total_revenue, round(count(s.`Order ID`),2) as Total_orders,
round(sum(s.`Profit`),2) as Total_profit
from customers c join sales s
on c.`customer ID` = s.`customer ID`
group by c.`Segment`
order by Total_revenue desc;


                                      -- 8) revenue, orders, profit by Age_group
                                      
select c.`Age_group`, round(sum(s.`sales`),2) as Total_revenue, round(count(s.`Order ID`),2) as Total_orders,
round(sum(s.`Profit`),2) as Total_profit
from customers c join sales s
on c.`customer ID` = s.`customer ID`
group by c.`Age_group`
order by Total_revenue desc;


									   -- 8) sales by year
                                       
select year(`Order Date`) as Year, round(sum(`Sales`),2) as Revenue
from sales
group by Year
Order by Year;


                                        -- 9) Monthly sales
                                        
select monthname(`Order Date`) as Month_name,  round(sum(`Sales`),2) as Revenue
from sales
group by Month_name;


                                       -- 10) MTD, QTD, YTD Sales analysis
                                       
select `Order Date`,
`Sales` as revenue,
sum(`Sales`) over(partition by Year(`Order Date`) order by `Order Date`) as YTD,
sum(`Sales`) over(partition by month(`Order Date`) order by `Order Date`) as MTD,
sum(`Sales`) over(partition by quarter(`Order Date`) order by `Order Date`) as QTD
from sales;


                                              -- sales vs orders
                                              
select monthname(`Order Date`) as Month_name, 
year(`Order Date`) as year,
round(sum(`Sales`),2) as Sales, 
count(`Order ID`) as Orders
from sales
group by Month_name, Month(`Order Date`), year
order by Month(`Order Date`), year;


                                 -- YTD sales analysis
                                 
select round(sum(`Sales`),2) as revenue_of_2017_year
from sales
where year(`Order Date`) = 2017
order by month(`Order Date`);


                                    -- MTD sales analysis
                                    
select round(sum(`Sales`),2) as revenue_of_december2017
from sales
where year(`Order Date`) = 2017 and month(`Order Date`) = 12
group by monthname(`Order Date`), month(`Order Date`)
order by month(`Order Date`);


                                      -- QTD sales analysis
                                    
select sum(sum(`Sales`)) over() as revenue_of_oct_nov_dec2017
from sales
where year(`Order Date`) = 2017 and month(`Order Date`) in(10, 11, 12)
group by monthname(`Order Date`), month(`Order Date`)
order by month(`Order Date`)
limit 1;


