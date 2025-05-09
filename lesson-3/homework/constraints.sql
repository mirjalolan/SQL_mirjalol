create database homework3
go
use homework3

create table products3 (ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10,2))
insert into products3 (productID, ProductName, price) values
(1566, 'Coca-Cola', '123.15'), (4567, 'Pepsi', '799.23'), (7896, 'Fanta', '456.56')
select * from products3

alter table products3
add constraint productsName_BN unique (productname)

create table Categories (CategoryID int PRIMARY KEY identity(1,1), CategoryName varchar (50)  unique)


--when we use IDENTITY column we command SQL that every row should increase by some amount. For example, IDENTIY (1,2) means that row starts with 1 and increases by 2 row by row

create table employees (employeeID int, firstName varchar(50), lastName varchar(50), email varchar (50), salary int)
bulk insert employees from 'D:\SQL files\employees_.csv' with (rowterminator = '\n', fieldterminator = ',', firstrow = 2)


insert into Categories ( CategoryName) values
('SODA'), ('softDrink'), ( 'SodaDrink')

alter table products3
add category3 int constraint hk_category3 foreign key (Category3) references Categories(CategoryID)

select * from products3

alter table products3
add constraint gh_price check (price>0)

alter table products3
add Stock int not null default 0

create table customers3 (customerID int identity (100, 10), fullname varchar (50), age int, constraint gh_age check (age>0) )


insert into customers3 ( fullname, age) values
('James', 45)
select * from customers3
