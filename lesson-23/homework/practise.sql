--1
--In this puzzle you have to extract the month from the dt column and then append zero single digit month if any. 
select *, 
case when month(dt)<'10' then '0' + cast(month(dt) as varchar)
else cast(month(dt)as varchar)
end as monnth_extraction
from dates

--2
-- In this puzzle you have to find out the unique Ids present in the table. 
--You also have to find out the SUM of Max values of vals columns for each Id and RId. 
;with cte as 
(select id, rID, max(Vals)as max_vals from MyTabel group by id, rID)
select rid, count(distinct ID), sum(max_vals) from cte group by rID

--3
-- In this puzzle you have to get records with at least 6 characters and maximum 10 characters. 
select * from TestFixLengths where len(Vals) between 6 and 10

--4
--In this puzzle you have to find the maximum value for each Id and then get the Item for that Id and Maximum value
;with cte as 
(select *, max(Vals)over(partition by id)as max_val  from TestMaximum) 
select distinct ID,Item,max_val from cte where vals = max_val

--5
--In this puzzle you have to first find the maximum value for each Id and DetailedNumber, and then Sum the data using Id only
;with cte as
(select DetailedNumber, max(Vals)as max_val, id from SumOfMax group by id,DetailedNumber)
select ID, sum(max_val)as sum_max_val from cte group by id

--6
-- In this puzzle you have to find difference between a and b column between each row and 
--if the difference is not equal to 0 then show the difference i.e. a – b otherwise 0. 
--Now you need to replace this zero with blank
select *, replace (a-b, 0, '') as output_zero from TheZeroPuzzle


--7
--What is the total revenue generated from all sales?
select sum ( QuantitySold*UnitPrice) as total_revenue from Sales

--8
--What is the average unit price of products?
select avg(UnitPrice)as avg_price from sales

--9
--How many sales transactions were recorded?
select count(*)as transaction_cnt from Sales

--10
--What is the highest number of units sold in a single transaction?
select max(QuantitySold)as max_qnt_sold from Sales

--11
--How many products were sold in each category?
select Category,
sum(QuantitySold) as sum_qnt
from Sales
group by Category

--12
--What is the total revenue for each region?
select Region, sum(QuantitySold*UnitPrice)as total_revenue from Sales group by region

--13
--Which product generated the highest total revenue?
select top 1 Product, sum(QuantitySold*UnitPrice)as qnt from Sales group by Product order by qnt desc

--14
--Compute the running total of revenue ordered by sale date.
select *,
sum(QuantitySold*UnitPrice) over(order by saledate)as running_total
from Sales

--15
--How much does each category contribute to total sales revenue?
select *, sum(QuantitySold*UnitPrice)over(partition by category )as qnt_per_cate from Sales


--17
--Show all sales along with the corresponding customer names
select * from Customers as c
inner join Sales as s
on c.CustomerID = s.CustomerID

--18
--List customers who have not made any purchases
select CustomerID from Customers where CustomerID not in (select CustomerID from Sales)

--19
--Compute total revenue generated from each customer
select Customers.CustomerID, Customers.CustomerName,revenue_per.total_revenue from customers
inner join
(select CustomerID,
sum(QuantitySold*UnitPrice)as total_revenue
from Sales
group by CustomerID) as revenue_per
on revenue_per.CustomerID = Customers.CustomerID

--20
--Find the customer who has contributed the most revenue
select c.CustomerName,reve_qnt.total_revenue from Customers as c
inner join
(select top 1 CustomerID, sum(QuantitySold*UnitPrice)as total_revenue from Sales group by CustomerID
order by total_revenue desc) as reve_qnt
on c.CustomerID = reve_qnt.CustomerID

--21
--Calculate the total sales per customer
select c.CustomerName, q.qnt from Customers as c
inner join (select CustomerID,sum(QuantitySold)as qnt from Sales group by CustomerID) as q
on c.CustomerID = q.CustomerID


--22
--List all products that have been sold at least once
select * from Products as p
inner join Sales as s
on p.ProductName = s.Product

--23
--Find the most expensive product in the Products table
select top 1 productname, max(sellingprice)as expensive from Products group by ProductName order by expensive desc

--24
--Find all products where the selling price is higher than the average selling price in their category
select * from Products as p2 where SellingPrice > (select avg(SellingPrice) from Products as p1 where p1.Category=p2.Category)
