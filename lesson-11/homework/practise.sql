--Easy part
--1
select ord.OrderID, c.FirstName,c.LastName,ord. OrderDate from Customers as c
inner join  Orders as ord
on c.CustomerID = ord.CustomerID
where year(ord.OrderDate)>2022

--2
select emp.name as employeeName,dep.DepartmentName from Employees as emp
inner join Departments as dep
on emp.DepartmentID=dep.DepartmentID
where dep.DepartmentName='Sales' or dep.DepartmentName = 'Marketing'

--3
select dep.departmentname, max(emp.Salary) as MaxSalary from Departments as dep
inner join Employees as emp
on emp.DepartmentID=dep.DepartmentID
group by dep.DepartmentName

--4
select concat(c.FirstName, ' ' , c.LastName) as CustomerName, ord.OrderID, ord.OrderDate from Customers as c
inner join Orders as ord
on c.CustomerID=ord.CustomerID
where c.Country = 'USA' and year(ord.OrderDate) = 2023

--5
select sum(ord.Quantity) as TotalOrders,concat(c.FirstName,' ', c.LastName) as CustomerName from orders as ord
inner join Customers as c
on ord.CustomerID = c.CustomerID
group by concat(c.FirstName,' ', c.LastName)

--6
select p.ProductName, s.SupplierName from Products as p
inner join Suppliers as s
on p.SupplierID=s.SupplierID
where s.SupplierName = 'Gadget supplies' or s.SupplierName = 'Clothing Mart'

--7
select max(ord.OrderDate) as MostRecentOrderDate, concat(c.FirstName,' ', c.LastName) as CustomerName from Customers as c
left join Orders as ord
on c.CustomerID = ord.CustomerID 
group by concat(c.FirstName,' ', c.LastName) 


--Medium part
--8
select concat(c.FirstName,' ', c.LastName) as CustomerName, sum(ord.TotalAmount)as OrderTotal from Orders as ord
inner join Customers as c
on ord.CustomerID = c.CustomerID 
group by concat(c.FirstName,' ', c.LastName)
Having sum(ord.TotalAmount) > 500

--9
select p.ProductName, s.SaleDate, s.SaleAmount from Products as p
inner join Sales as s
on p.ProductID = s.ProductID
where year(s.SaleDate) = 2022 or s.SaleAmount > 400

--10
select p.ProductName, sum(s.SaleAmount) as TotalSalesAmount from Sales as s
inner join Products as p
on p.ProductID = s.ProductID
group by p.ProductName

--11
select emp.Name, dep.DepartmentName, emp.Salary from Employees as emp
inner join Departments as dep
on emp.DepartmentID = dep.DepartmentID
where dep.DepartmentName = 'HR' and emp.Salary > 60000

--12
select p.ProductName, s.SaleDate, p.StockQuantity from Products as p
inner join Sales as s
on p.ProductID = s.ProductID
where year(s.SaleDate) = 2023 and p.StockQuantity > 100

--13
select emp.Name,dep.DepartmentName, emp.HireDate from Employees as emp
inner join Departments as dep
on emp.DepartmentID = dep.DepartmentID
where dep.DepartmentName = 'Sales' or year(emp.HireDate) > 2020

--Hard part
--14
select concat(c.FirstName,' ', c.LastName)as CustomerName, ord.OrderID, c.Address, ord.OrderDate from Customers as c
inner join Orders as ord
on c.CustomerID = ord.CustomerID
where c.Address like '[0-9][0-9][0-9][0-9]%' and c.Country = 'USA'

--15
select p.ProductName,c.CategoryName, s.SaleAmount from Sales as s
inner join Products as p
on p.ProductID = s.ProductID
inner join Categories as c
on c.CategoryID = p.Category
where c.CategoryName = 'Electronics' or s.SaleAmount > 350


--16
select c.CategoryName, count(p.ProductID) as ProductCount from Products as p
inner join Categories as c
on p.Category = c.CategoryID
group by c.CategoryName


--17
select concat(c.FirstName, ' ', c.LastName) as CustomerName, c.City,ord.OrderID,sum(ord.TotalAmount) as Amount from Customers as c
inner join Orders as ord
on c.CustomerID = ord.CustomerID
group by concat(c.FirstName, ' ', c.LastName), c.City, ord.OrderID
having c.City = 'Los Angeles' and sum(ord.TotalAmount)> 300


--18
select emp.Name, dep.DepartmentName from Employees as emp
inner join Departments as dep
on emp.DepartmentID = dep.DepartmentID
where dep.DepartmentName = 'Finance' or dep.departmentName = 'HR' or emp.name like '%[a,e,o,i,u]%[a,e,o,i,u]%[a,e,o,i,u]%[a,e,o,i,u]%'

--19
select emp.Name, dep.DepartmentName,emp.Salary from Employees as emp
inner join Departments as dep
on emp.DepartmentID = dep.DepartmentID
where dep.DepartmentName = 'Sales' or dep.DepartmentName = 'Marketing' and emp.Salary > 60000

