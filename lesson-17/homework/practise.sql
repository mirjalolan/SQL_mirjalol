--1
-- You must provide a report of all distributors and their sales by region. 
--If a distributor did not have any sales for a region, rovide a zero-dollar value for that day.
--Assume there is at least one sale for each region

select D.Distributor, isnull(RS.Sales,0) as total_sales,R.Region from (select distinct region from RegionSales) as R
cross join 
(select distinct distributor from RegionSales) as D
left join
RegionSales as RS
on r.Region = RS.Region and RS.Distributor = D.Distributor

--2
-- Find managers with at least five direct reports
select man.name from Employee as emp
inner join Employee as man
on emp.managerId = man.id
group by man.name
having count(man.id)>=5

--3
-- Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
select * from Products
select p.product_name,sales.total_sales from (select product_id, sum(unit)as total_sales from Orders 
where month(order_date)=2 and year(order_date)=2020 group by product_id  having sum(unit)>=100)as sales
inner join Products as p
on p.product_id = sales.product_id


--4
--Write an SQL statement that returns the vendor from which each customer has placed the most orders
;with cte as
(select *,(select sum(count)  from orders as ord2 where ord1.CustomerID=ord2.CustomerID and ord1.Vendor=ord2.Vendor)as total_orders 
from Orders as ord1)
select distinct CustomerID,vendor from cte where total_orders = (select max(total_orders) from cte as cte1 where cte1.CustomerID=cte.CustomerID)

--5
--You will be given a number as a variable called @Check_Prime check if this number is prime then return 
--'This number is prime' else eturn 'This number is not prime'
declare @Check_Prime INT = 91;
declare @checker int=1

--6
--Write an SQL query to return the number of locations,in which location most signals sent, 
--and total number of signal for each device from the given table.
;with cte as
(select *, (select count(locations)  from device as d where d.Device_id=DV.device_id and d.Locations=DV.Locations )as cnt_locations
from Device as DV)
select distinct cte.Locations, cte.Device_id, ds.dist_loc, ds.total_locs from cte
inner join 
(select count(distinct locations) as dist_loc,count(locations)as total_locs, Device_id from Device group by Device_id) as ds
on ds.Device_id=cte.Device_id
where cte.cnt_locations = (select max(cnt_locations)from cte as cte1 where cte1.Device_id=cte.Device_id)

--7
--Write a SQL to find all Employees who earn more than the average salary in their corresponding department. 
--Return EmpID, EmpName,Salary in your output
select EmpName,EmpID,Salary from Employee where salary >= (select avg(salary)from Employee as emp1 where emp1.DeptID=Employee.DeptID)

--8
/*You are part of an office lottery pool where you keep a table of the winning lottery numbers along 
with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10.
If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.*/
; with cte as (select TicketID, count(*) as winning_pairs from Tickets as t
inner join WinningNumbers as w
on w.Number=t.Number
group by TicketID)
select *,
case when winning_pairs=3 then 100
when winning_pairs=2 then 10
else 0
end as win
from cte


--9
CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);
/*The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website 
which has a desktop and a mobile devices.
Write an SQL query to find the total number of users and the total amount spent using mobile only, 
desktop only and both mobile and desktop together for each date.*/
select Spend_date, sum(Amount)as total_sale from Spending group by Spend_date
select * from Spending

--10
DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);
select * from Grouped
