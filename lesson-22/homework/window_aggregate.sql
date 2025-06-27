
--1
--Compute Running Total Sales per Customer
select *,
sum(total_amount)over(partition by customer_id order by order_date)
from sales_data

--2
--Count the Number of Orders per Product Category
select *,
count(quantity_sold)over(partition by product_category)
from sales_data

--3
--Find the Maximum Total Amount per Product Category
select *,
sum(total_amount)over(partition by product_category)
from sales_data

--4
--Find the Minimum Price of Products per Product Category
select *,
min(unit_price)over(partition by product_category)
from sales_data 

--5
--Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)
select *,
avg(unit_price)over(order by order_date rows between 1 preceding and 1 following)
from sales_data 

--6
--Find the Total Sales per Region
select *,
sum(total_amount)over(partition by region)
from sales_data 

--7
--Compute the Rank of Customers Based on Their Total Purchase Amount
select *,
DENSE_RANK()over( order by total_amount desc)
from sales_data

--8
--Calculate the Difference Between Current and Previous Sale Amount per Customer
;with cte as (select *,
lag(total_amount,1,0) over(partition by customer_id order by order_date desc)as prev_sales
from sales_data)
select *, total_amount - prev_sales as diff from cte

--9
--Find the Top 3 Most Expensive Products in Each Category
select *,
max(unit_price)over(partition by product_category)
from sales_data

--10
--Compute the Cumulative Sum of Sales Per Region by Order Date
select *,
sum(total_amount)over(partition by region order by order_date)
from sales_data

--11
--Compute Cumulative Revenue per Product Category
select *,
sum(total_amount)over(partition by product_category order by order_date)
from sales_data 

--12

select *,
sum(ID)over(order by ID)
from NewTable

--13
CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);
--Sum of Previous Values to Current Value
select *,
sum(value)over(order by value)
from OneColumn

--14
--Find customers who have purchased items from more than one product_category
;with cte as (select *,
count( product_category)over(partition by customer_id)as cnt
from sales_data)
select * from cte where cnt>1

--15
--Find Customers with Above-Average Spending in Their Region
;with cte as (select *,
avg(total_amount)over(partition by region) average_sales
from sales_data)
select customer_id,region,total_amount,average_sales from cte where total_amount>average_sales

--16
--Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same spending, they should receive the same rank.
select *,
DENSE_RANK()over(partition by region order by total_amount desc)
from sales_data

--17
--Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.
select *,
sum(total_amount) over (partition by customer_id order by order_date)
from sales_data

--18
--Calculate the sales growth rate (growth_rate) for each month compared to the previous month.
;with cte as (select *,
lag(total_amount) over(order by order_date)as prev_sales
from sales_data)
select *, concat (cast(round((total_amount-prev_sales)*100/prev_sales, 1,2) as float), '%') as growth_rate from cte

--19
--Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)
;with cte as (select *,
lag(total_amount) over(partition by customer_id order by order_date)as prev_sales
from sales_data)
select * from cte where total_amount>prev_sales

--20
--Identify Products that prices are above the average product price
;with cte as (select *,
avg(unit_price)over() as total_avg
from sales_data)
select * from cte where unit_price<total_avg

--21
--In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. 
--The challenge here is to do this in a single select. For more details please see the sample input and expected output.
select *,
case when row_number() over(partition by grp order by (select null)) = 1 then
sum(val1+Val2)over(partition by grp)
else NULL
end as stat
from MyData

--22
--Here you have to sum up the value of the cost column based on the values of Id.
--For Quantity if values are different then we have to add those values.Please go through the sample input and expected output for details.
;with cte as (select *,
sum(cost) over(partition by ID)as total1,
sum(Quantity)over (partition by ID) as total2
from TheSumPuzzle)
select distinct ID,total1,total2 from cte

--23
--From following set of integers, write an SQL statement to determine the expected outputs
WITH AllSeats AS (

    SELECT TOP (
        (SELECT MAX(SeatNumber) FROM Seats)
    ) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS SeatNumber
    FROM master.dbo.spt_values
),
MissingSeats AS (

    SELECT SeatNumber
    FROM AllSeats
    WHERE SeatNumber NOT IN (SELECT SeatNumber FROM Seats)
),
GroupedGaps AS (

    SELECT SeatNumber,
           SeatNumber - ROW_NUMBER() OVER (ORDER BY SeatNumber) AS grp
    FROM MissingSeats
)

SELECT MIN(SeatNumber) AS [Gap Start],
       MAX(SeatNumber) AS [Gap End]
FROM GroupedGaps
GROUP BY grp
ORDER BY [Gap Start];

