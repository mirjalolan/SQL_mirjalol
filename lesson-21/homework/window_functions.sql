
--1
--Write a query to assign a row number to each sale based on the SaleDate.
select *, 
row_number() over(order by saledate desc)as rnk
from ProductSales

--2
--Write a query to rank products based on the total quantity sold. 
--give the same rank for the same amounts without skipping numbers.
select *,
dense_rank() over( order by quantity)
from ProductSales

--3
--Write a query to identify the top sale for each customer based on the SaleAmount.
;with cte as(select *,
dense_rank()over (partition by customerID order by saleamount desc)as rnk
from ProductSales)
select * from cte where rnk=1

--4
--Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.
select *,
lead(SaleAmount)over( order by saledate)as rnk
from ProductSales

--5
--Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.
select *,
lag(SaleAmount)over( order by saledate)as rnk
from ProductSales

--6
--Write a query to identify sales amounts that are greater than the previous sale's amount
;with cte as (select *,
lag(SaleAmount)over( order by saledate)as rnk
from ProductSales)
select * from cte where SaleAmount>rnk

--7
--Write a query to calculate the difference in sale amount from the previous sale for every product
;with cte as (select *,
lag(SaleAmount)over( order by saledate)as rnk
from ProductSales)
select *, SaleAmount-rnk as diff from cte

--8
--Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
;with cte as (select *,
lead(SaleAmount)over( order by saledate)as rnk
from ProductSales)
select round(((rnk-SaleAmount)/SaleAmount*100),2) as percent_change from cte
where rnk is not null

--9
--Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
;with cte as (select *,
lag(SaleAmount)over(partition by productname order by saledate)as rnk
from ProductSales)
select *,
case when rnk is null or rnk =0 then 0
else SaleAmount /rnk
end as ratio
from cte

--10
--Write a query to calculate the difference in sale amount from the very first sale of that product.
;with cte as (select *,
first_value(SaleAmount)over(partition by productname order by saledate)as first_sale
from ProductSales)
select *, saleamount - first_sale as dif from cte

--11
--Write a query to find sales that have been increasing continuously for a product 
--(i.e., each sale amount is greater than the previous sale amount for that product).
;with cte as(select *,
lag(SaleAmount)over(partition by productname order by saledate)as rnk
from ProductSales)
select *,
case when SaleAmount>rnk then 1
else 0
end as stat
from cte

--12
--Write a query to calculate a "closing balance"(running total) for sales amounts 
--which adds the current sale amount to a running total of previous sales.
select *,
sum(SaleAmount)over (order by saledate)as running_total
from ProductSales

--13
--Write a query to calculate the moving average of sales amounts over the last 3 sales.
select *,
avg(saleamount) over(order by saledate rows between 2 preceding and current row )as moving_average from ProductSales

--14
--Write a query to show the difference between each sale amount and the average sale amount.
select *, SaleAmount-avg(SaleAmount)over() as dif from ProductSales

--15
--Find Employees Who Have the Same Salary Rank
select *,
DENSE_RANK()over(order by salary desc)as rnk
from Employees1

--16
--Identify the Top 2 Highest Salaries in Each Department
;with cte as(select *,
DENSE_RANK()over(partition by department order by salary desc)as rnk
from Employees1)
select * from cte where rnk between 1 and 2

--17
--Find the Lowest-Paid Employee in Each Department
;with cte as(select *,
DENSE_RANK()over(partition by department order by salary )as rnk
from Employees1)
select * from cte where rnk=1

--18
--Calculate the Running Total of Salaries in Each Department
select *,
sum(Salary) over(partition by department order by employeeid)
from Employees1

--19
--Find the Total Salary of Each Department Without GROUP BY
select *,
sum(salary) over(partition by department)
from Employees1

--20
--Calculate the Average Salary in Each Department Without GROUP BY
select *,
avg(Salary) over(partition by department)
from Employees1

--21
--Find the Difference Between an Employee’s Salary and Their Department’s Average
;with cte as(select *,
avg(Salary) over(partition by department)as avg_salary
from Employees1)
select *, Salary-avg_salary as diff from cte

--22
--Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
select *,
avg(salary) over(order by employeeID rows between 1 preceding and 1 following)as moving_avg
from Employees1

--23
--Find the Sum of Salaries for the Last 3 Hired Employees
;with cte as(select *,
DENSE_RANK() over(order by hiredate desc)as hr_date
from Employees1)
select sum(Salary) from cte where hr_date <=3
