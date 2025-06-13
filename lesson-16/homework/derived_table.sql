--Easy part
--1
--Create a numbers table using a recursive query from 1 to 1000.
;with cte as(
select 1 as num 
union all
select num+1 as num from cte
where num<1000
)
select * from cte
option (maxrecursion 1000)

--2
--Write a query to find the total sales per employee using a derived table.(Sales, Employees)
select emp.FirstName,emp.LastName,total_sales_per_emp.total_sales from  
(select EmployeeID, sum(SalesAmount)as total_sales from sales group by EmployeeID) as total_sales_per_emp
inner join Employees as emp 
on emp.EmployeeID = total_sales_per_emp.EmployeeID

--3
--Create a CTE to find the average salary of employees.(Employees)
;with cte as(select EmployeeID, avg(Salary)as avg_salary from Employees group by EmployeeID) 
select EmployeeID, avg_salary from cte

--4
--Write a query using a derived table to find the highest sales for each product.(Sales, Products)
select p.ProductName,max_sales.highest_sale from(select ProductID, max(SalesAmount)as highest_sale from sales group by ProductID)as max_sales
inner join Products as p
on p.ProductID = max_sales.ProductID

--5
--Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
;with cte as (
select 1 as num 
union all
select num*2 as num from cte
where num<1000000
)
select * from cte 
option(maxrecursion 32767)

--6
--Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
;with cte as (
select emp.FirstName,emp.LastName, count(sales.SalesID)as cnt_sales from Sales 
inner join employees as emp
on emp.employeeID = sales.employeeID
group by emp.FirstName,emp.LastName
)
select * from cte 
where cnt_sales>5

--7
--Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
;with cte as (select p.ProductName, sum(SalesAmount)as total_sales from Sales 
inner join Products as p
on p.ProductID = sales.ProductID
group by p.ProductName)
select * from cte
where total_sales>500

--8
--Create a CTE to find employees with salaries above the average salary.(Employees)
;with cte as (select FirstName,LastName,Salary from employees where salary > (select avg(salary) from Employees))
select * from cte

--Medium part
--1
--Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
select * from (select top 5 emp.FirstName,emp.lastname, count(SalesID)as cnt_sales from sales 
inner join employees as emp
on emp.EmployeeID = sales.EmployeeID
group by emp.FirstName,emp.lastname)as cnt_orders

--2
--Write a query using a derived table to find the sales per product category.(Sales, Products)
select * from (select p.CategoryID, sum(SalesAmount)as total_sales from sales
inner join products as p
on p.ProductID = sales.ProductID
group by p.CategoryID)as total_sales_pro

--3
--Write a script to return the factorial of each value next to it.(Numbers1)
;with cte as(
select number,1 as num from Numbers1 
union all
select num*num from Numbers1
)

--4
--This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
declare @string varchar(100)='Example'
;with cte as(select 1 as checker, substring(@string, 1,1)as letter
union all
select checker+1, substring (@string,checker+1,1 ) from cte
where checker<len(@string))
select * from cte

--5
--Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
select month(saledate),SalesAmount from Sales 

--6
--Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
select * from(select ((month(saledate)-1)/2)+1 as quarter_sales, sum(SalesAmount)as total_sale from sales 
inner join Employees as e
on e.EmployeeID = sales.EmployeeID
group by((month(saledate)-1)/2)+1)as sale_per_quarter
where total_sale>45000

--Hard part
--1
--This script uses recursion to calculate Fibonacci numbers

--2
--Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
select * from FindSameCharacters where len(replace (vals, left(vals,1),'')) = 0 and len(Vals)>1

--3
--Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.
--(Example:n=5 | 1, 12, 123, 1234, 12345)
declare @int int = 5
;with cte as (
select 1 as num,cast('1' as varchar) as checker
union all
select num+1, CAST(checker + CAST(num + 1 AS VARCHAR) AS VARCHAR(MAX)) from cte
where num<@int
)
select * from cte
