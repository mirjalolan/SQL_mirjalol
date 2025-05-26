--Easy part
--1
select emp.Name, emp.Salary, dep.DepartmentName from Employees as emp
inner join Departments as dep
on dep.DepartmentID = emp.DepartmentID
where emp.salary > 50000

--2
select c.FirstName,c.LastName,year(ord.OrderDate) from Customers as c
inner join orders as ord
on c.CustomerID = ord.CustomerID
where  year(ord.OrderDate) = '2023'

--3
select emp.Name, dep.DepartmentName from Employees as emp
left join Departments as dep
on emp.DepartmentID = emp.DepartmentID

--4
select s.SupplierName,p.ProductName from Products as p
left join Suppliers as s
on p.SupplierID = s.SupplierID

--5
select p.Amount,p.OrderID,p.PaymentDate,ord.OrderDate from Orders as ord
full join Payments as p
on ord.OrderID = p.OrderID

--6
select emp.Name as employee_name, man.Name as manager_name from Employees as emp
left join Employees as man
on emp.ManagerID = man.EmployeeID

--7
select s.Name,c.CourseName from Students as s
inner join Enrollments as e
on s.StudentID = e.StudentID
inner join Courses as c
on e.CourseID = c.CourseID
where c.CourseName = 'Math 101'

--8
select c.FirstName +  ' ' + c.LastName as full_name, ord.Quantity from Customers as c 
inner join orders as ord
on c.CustomerID = ord.CustomerID
where ord.Quantity>3

--9
select emp.Name, dep.DepartmentName from Employees as emp
inner join Departments as dep
on emp.DepartmentID = dep.DepartmentID
where dep.DepartmentName = 'Human Resources'


--Medium part
--10
select count(emp.EmployeeID) as employee_count, dep.DepartmentName from Employees as emp
inner join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentName
having count(emp.EmployeeID) > 5

--11
select p.ProductID,p.ProductName from Products as p
left join sales as s
on p.ProductID = s.ProductID
where s.ProductID is null

--12
select c.FirstName,c.LastName,sum(ord.Quantity)as totalOrders from Customers as c
inner join orders as ord
on c.CustomerID = ord.CustomerID
group by c.FirstName,c.LastName
having sum(ord.Quantity) >=1

--13
select emp.Name,dep.DepartmentName from Employees as emp
inner join Departments as dep
on dep.DepartmentID=emp.DepartmentID

--14
select emp1.name as employee1, emp2.Name as employee2,emp1.ManagerID from Employees as emp1
inner join Employees as emp2
on emp1.ManagerID=emp2.ManagerID and emp1.EmployeeID<emp2.EmployeeID

--15
select c.FirstName,c.LastName,ord.OrderID,ord.OrderDate from orders as ord
inner join customers as c
on ord.CustomerID=c.CustomerID
where year(ord.OrderDate) = '2022'

--16
select emp.Name,emp.Salary,dep.DepartmentName from Employees as emp
inner join departments as dep
on emp.DepartmentID=dep.DepartmentID
where dep.DepartmentName = 'Sales' and emp.Salary> 60000

--17
select o.OrderID,p.Amount,p.PaymentDate,o.OrderDate from Orders as o
inner join Payments as p
on o.OrderID = p.OrderID

--18
select p.ProductID,p.ProductName from Products as p
left join orders as o
on p.ProductID = o.ProductID
where o.ProductID is null

--Hard part
--19
SELECT 
    e.EmployeeID,
    e.Name,
    e.DepartmentID,
    e.Salary
FROM 
    Employees AS e
WHERE 
    e.Salary > (
        SELECT AVG(e2.Salary) FROM Employees AS e2 WHERe e2.DepartmentID = e.DepartmentID);

--20
select ord.OrderID,ord.OrderDate from Orders as ord
left join Payments as p
on ord.OrderID = p.OrderID
where year(ord.OrderDate)<'2020' and p.OrderID is null

--21
select p.ProductID,p.ProductName from Products as p
left join categories as c
on p.Category = c.CategoryID
where c.CategoryID is null

--22
--Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.

--23
select emp.Name,dep.DepartmentName from Employees as emp
inner join Departments as dep
on emp.DepartmentID = dep.DepartmentID
where dep.DepartmentName  like 'M%'

--24		
select s.SaleID,s.SaleAmount,p.ProductName from Products as p 
inner join sales as s
on p.ProductID = s.ProductID
where s.SaleAmount > 500

--25
select s.StudentID,s.Name from Students as s
left join Enrollments as e
on s.StudentID = e.StudentID
left join courses as c
on e.CourseID = c.CourseID
and c.CourseName = 'Math 101'
where c.CourseName is null

--26
select ord.OrderID,  ord.OrderDate, p.PaymentID from   Orders as ord
left join Payments as p
on ord.OrderID = p.OrderID
where p.OrderID is null

--27
select p.ProductID,p.ProductName,c.CategoryName from Products as p
inner join Categories as c
on p.Category = c.CategoryID
where c.CategoryName = 'Electronics' or c.CategoryName = 'Furniture'
