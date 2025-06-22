--1
--Find customers who purchased at least one item in March 2024 using EXISTS
select CustomerName from #Sales as q2 where exists (select Quantity  from #Sales as q1 
where q1.CustomerName = q2.CustomerName and q1.Quantity >= 1 and month(q1.SaleDate)=03 )

--2
--Find the product with the highest total sales revenue using a subquery.
;with cte as
(select product, sum(Quantity)as total_quantity, sum(Quantity)*Price as total_revenue from #Sales group by Product, Price )
select Product, total_revenue from cte where total_revenue = (select min(total_revenue) from cte)

--3
--Find the second highest sale amount using a subquery
;with cte as
(select Product, sum(Quantity)*Price as total_revenue from #Sales  group by Product,Price)
select top 1 product, total_revenue from cte where total_revenue < (select max(total_revenue) from cte)
order by total_revenue desc

--4
--Find the total quantity of products sold per month using a subquery
select sum(Quantity) as qnt_per_month, MONTH(SaleDate)as months from #Sales group by MONTH(SaleDate);

select distinct month(SaleDate)as month, 
(select sum(Quantity)  from #Sales as s1 where month(s1.SaleDate) =month (s2.SaleDate))as qnt_per_month
from #Sales as s2

--5
--Find customers who bought same products as another customer using EXISTS
select distinct CustomerName, Product from #Sales as s1 where 
exists (select CustomerName,Product from #Sales as s2 where s1.Product=s2.Product and s1.CustomerName <> s2.CustomerName)

--6
-- Return how many fruits does each person have in individual fruit level
select name,
sum(case when fruit = 'Apple' then 1 else 0 end)as 'Apple',
sum(case when fruit = 'Banana' then 1 else 0 end) as 'Banana' ,
sum(case when fruit = 'Orange' then 1 else 0 end) as 'Orange' 
from fruits
group by name 

--7
--Return older people in the family with younger ones
;with cte as (
    select ParentId, ChildID
    from Family
    union ALL
    select f.ParentId, ft.ChildID
    from Family f
    join cte ft ON f.ChildID = ft.ParentId)
select distinct ParentId as OlderPerson, ChildID as YoungerPerson
from cte;

--8
--Write an SQL statement given the following requirements. For every customer that had a delivery to California, 
--provide a result set of the customer orders that were delivered to Texas
select * from #Orders where DeliveryState = 'TX' and CustomerID in 
(select distinct CustomerID from #Orders where DeliveryState = 'CA')

--9
-- Insert the names of residents if they are missing
select *, 
case when charindex('name=', address)=0 then stuff(address,charindex('age=',address),0,  concat('name=',fullname,' ') )
else address 
end as stat
from #residents

--10
--Write a query to return the route to reach from Tashkent to Khorezm. 
--The result should include the cheapest and the most expensive routes
select * from #Routes


--11. Rank products based on their order of insertion.
select r2.id,r2.vals, (select count(*) from #RankingPuzzle as r1 where r1.ID <= r2.ID) from #RankingPuzzle as r2 order by r2.ID

--12
--Find employees whose sales were higher than the average sales in their department
select emp1.EmployeeID, emp1.SalesAmount, emp1.Department
from #EmployeeSales as emp1
where emp1.SalesAmount<(select avg(emp2.SalesAmount) from #EmployeeSales as emp2 where emp1.Department=emp2.Department)

--13
--Find employees who had the highest sales in any given month using EXISTS
select emp1.EmployeeID, emp1.SalesAmount,emp1.SalesMonth from #EmployeeSales as emp1 where  
exists (select 1 from #EmployeeSales as emp2 where emp1.EmployeeID = emp2.EmployeeID and 
emp1.SalesAmount < emp2.SalesAmount and emp1.SalesMonth = emp2.SalesMonth)

--14
--Find employees who made sales in every month using NOT EXISTS
SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT SalesMonth, SalesYear
        FROM #EmployeeSales
    ) AS all_months
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales es
        WHERE es.EmployeeName = e.EmployeeName
          AND es.SalesMonth = all_months.SalesMonth
          AND es.SalesYear = all_months.SalesYear
    )
);

--15
--Retrieve the names of products that are more expensive than the average price of all products.
select * from Products where price > (select avg(price) from Products)

--16
--Find the products that have a stock count lower than the highest stock count
select * from Products20 where stock < (select max (stock) from products20)

--17
--Get the names of products that belong to the same category as 'Laptop'.
select name, category from products20 where category = (select category from products20 where name='Laptop')

--18
--Retrieve products whose price is greater than the lowest price in the Electronics category.
select * from Products20 where category = 'Electronics' and price > (select min(price) from products20 where category = 'Electronics')

--19
--Find the products that have a higher price than the average price of their respective category.
select * from products20 as p1 where price > (select avg(price) from products20 as p2 where p1.category = p2.category)

--20
--Find the products that have been ordered at least once.
select productID, count(OrderID) from Orders group by ProductID having count(orderID)>=1

--21
--Retrieve the names of products that have been ordered more than the average quantity ordered.
select pro.Name from Orders as ord
inner join Products02 as pro
on pro.ProductID = ord.ProductID
where ord.Quantity > (select avg(Quantity) from Orders)

--22
--Find the products that have never been ordered.
select * from Orders as ord
left join Products02 as pro
on ord.ProductID = pro.ProductID
where ord.ProductID is null

--23
--Retrieve the product with the highest total quantity ordered.
select top 1 pro.Name, sum(ord.Quantity)as total_qnt_ordered from Orders as ord
inner join Products02 as pro
on ord.ProductID = pro.ProductID
group by pro.name
order by total_qnt_ordered desc
