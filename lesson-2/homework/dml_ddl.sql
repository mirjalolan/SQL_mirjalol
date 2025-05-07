

--Basic level
--1
create database Lesson2
go 
use Lesson2

--2
create table Employees (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))
insert into Employees (EmpID, name, salary) values
(156, 'Sardor', '156152.12'), (456, 'Jamshid', '456789.12'), (786, 'Mavlon', '789456.45')

select * from Employees

--3
update employees
set salary = '7000.00' where empID=156

--4
delete from employees where empID = 456

/*5
DELETE: Removes specific rows from a table based on a condition. 
TRUNCATE: Quickly removes all rows from a table 
DROP: Completely removes a table (or other database object) from the database, including its structure.*/

--6
alter table employees
alter column empID varchar (100)

--7
alter table employees
add  Department varchar(100)

--8
alter table employees
alter column salary float

--9
create table departments (DepartmentID INT PRIMARY KEY,   DepartmentName VARCHAR(50))
select * from departments

--10
truncate table departments

--Intermediate level

--1
insert into departments (DepartmentID, DepartmentName )
select 466, 'Human resource'union all
select 586, 'Accounting' union all
select 456, 'Operations' union all
select 789, 'Marketing' union all
select 896, 'IT' 

select * from departments


--2
UPDATE departments
SET Salary = 5500
WHERE DepartmentID = 466

UPDATE departments
SET Salary = 4200
WHERE DepartmentID = 586

UPDATE departments
SET Salary = 5800
WHERE DepartmentID = 456

UPDATE departments
SET Salary = 5000
WHERE DepartmentID = 789

UPDATE departments
SET Salary = 6400
WHERE DepartmentID = 896

update departments
set DepartmentName = 'Management' where salary > 5000
select * from departments

--3
truncate table departments

--4
alter table employees
drop column department
select * from Employees

--5
exec sp_rename 'Employees', 'StaffMembers'

--6
drop table departments

--Advanced level

--1 and 2
create table Products (ProductID int Primary Key, ProductName VARCHAR (100), Category VARCHAR (100), Price DECIMAL, 
CONSTRAINT price_check CHECK (price > 0))


--3
alter table Products
add  StockQuantity int default 50
select * from products

--4
exec sp_rename 'Products.Category', 'ProductCategory', 'Column'

--5
Insert into Products (ProductID, ProductName, ProductCategory, Price) values
(1, 'Laptop', 'Electronics', 999.99),
(2, 'Headphones', 'Electronics', 199.50),
(3, 'Coffee Mug', 'Kitchenware', 12.95),
(4, 'Desk Chair', 'Furniture', 249.99),
(5, 'Notebook', 'Stationery', 3.99)

select * from products

--6
select * into Products_backup from products
select * from products_backup

--7
exec sp_rename 'Products', 'Inventory'
select * from inventory

--8
alter table Inventory
drop constraint price_check

alter table Inventory
alter column Price float

--9
alter table Inventory
add ProductCode int identity (1000,5)

select * from inventory
