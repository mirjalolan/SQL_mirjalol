--Basic part
select top 5* from Employees

select distinct category from Products

select * from products where price > 100

select * from customers where firstname like 'A%'

select * from products order by price asc

select * from Employees where salary >= 60000 and DepartmentName = 'HR'

select isnull (null,'noemail@example.com') from Employees
select * from Employees

select * from Products where price between 50 and 100

select distinct Category, Productname from products

select distinct Category, Productname from products ORDER BY productname desc 

--Medium part
select top 10* from products order by price desc

select coalesce (firstName, lastname)  from Employees

select distinct category, price from Products

select * from employees where age in (30,40) or DepartmentName = 'marketing'

select * from employees order by salary desc offset 10 rows fetch next 10 rows only 

select * from Products where price <= 1000 and stockquantity > 50 order by StockQuantity asc 

select * from products where productname like '%e%'

select * from Employees where DepartmentName in ('HR', 'IT', 'finace')

select * from Customers order by City asc, PostalCode desc

--Hard part
select top (5) Saleamount from Sales order by saleAmount desc
select * from Employees

select FirstName + ' ' + lastName as fullname from Employees

select distinct category, productname, price from products where price < 50

select * from products where price < (select avg (price) * 0.1 from Products)

select * from Employees where age < 30 and Departmentname in ('HR', 'IT')

select *from customers where email like '%gmail.com'

select * from employees where salary > all (select salary from employees where DepartmentName = 'Sale')
select distinct departmentname from Employees
