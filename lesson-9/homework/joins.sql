--Easy part

--1
select s.SupplierName,p.ProductName from Suppliers as s 
cross join Products as p

--2
select d.DepartmentName, e.Name from Departments as d
cross join Employees as e

--3
select s.SupplierName, p.ProductName from Suppliers as s 
inner join Products as p
on s.SupplierID = p.SupplierID

--4
select o.OrderID, c.FirstName, c.LastName from Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID

--5
select s.name,c.CourseName from Students as s
cross join Courses c

--6
select o.OrderID,p.ProductName from Products as p 
inner join Orders as o
on o.ProductID = p.ProductID

--7
select e.Name, d.DepartmentName from Departments as d
inner join Employees as e
on e.DepartmentID = d.DepartmentID

--8
select e.CourseID,s.Name from Enrollments as e
inner join Students as s 
on e.StudentID = s.StudentID

--9
select p.PaymentID, o.TotalAmount from Payments as p
inner join Orders as o
on p.OrderID=o.OrderID

--10
select o.OrderID,p.Price from orders as o 
inner join Products as p
on p.ProductID =  o.ProductID
where p.price > 100

--Medium part

--11
select * from Employees as e 
cross join  Departments as d
where e.EmployeeID <> d.DepartmentID

--12
]select o.OrderID,p.ProductName from Orders as o
inner join Products as p
on o.ProductID = p.ProductID
where o.Quantity>p.StockQuantity

--13
select c.FirstName,c.LastName, s.productid,s.SaleAmount from Sales as s
inner join Customers as c
on s.CustomerID = c.CustomerID
where s.SaleAmount>=500

--14
select s.Name,c.CourseName from Courses as c
inner join Enrollments as e
on c.CourseID = e.CourseID
inner join students as s
on e.StudentID = s.StudentID

--15
select s.SupplierName,p.ProductName from Products as p
inner join Suppliers as s 
on p.SupplierID = s.SupplierID
where s.SupplierName like '%tech%'

--16
select *,p.* from Orders as o
inner join Payments as p
on o.OrderID = p.OrderID
where o.TotalAmount>p.Amount

--17
select d.DepartmentName,e.Name from Employees as e
inner join Departments as d
on d.DepartmentID = e.DepartmentID

--18
select p.ProductName, c.CategoryName from Products as p
inner join Categories as c
on p.Category=c.CategoryID
where c.CategoryName = 'Electronics' or c.CategoryName = 'Furniture'

--19
select * from sales as s
inner join Customers as c
on s.CustomerID = c.CustomerID
where c.country = 'USA'

--20
--Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
select sum(o.TotalAmount), c.FirstName, c.LastName from orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID
where c.Country = 'Germany' 
group by c.FirstName, c.LastName, o.TotalAmount
having sum(o.TotalAmount) > 100

--Hard part

--21
--Using Employees table List all pairs of employees from different departments.
select e.Name, d.DepartmentName from Employees as e
inner join Departments as d
on e.DepartmentID < d.DepartmentID
where e.DepartmentID <> d.DepartmentID

--22
--Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
select py.PaymentID, py.PaymentMethod, pr.ProductName,pr.Price,o.Quantity from Payments as py
inner join orders as o
on py.OrderID = o.OrderID
inner join Products as pr
on o.ProductID = pr.ProductID
where py.Amount <> o.Quantity * pr.Price 

--23
--Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
select s.Name, s.age,s.Major from Students as s 
left join Enrollments as e
on s.StudentID = e.StudentID
where e.CourseID is null

--24
--Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
select emp.Name as employee_name, emp.Salary as emp_salary, emp.EmployeeID,man.Name as manager_name,man.Salary as man_salary, man.ManagerID from Employees as emp
inner join Employees as man
on emp.EmployeeID = man.ManagerID
where man.salary<emp.Salary


--25
--Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.

select c.FirstName,c.LastName,o.OrderID from Customers as c
inner join orders as o
on o.CustomerID = c.CustomerID
left join Payments as p
on p.OrderID = o.OrderID
where p.OrderID is null
