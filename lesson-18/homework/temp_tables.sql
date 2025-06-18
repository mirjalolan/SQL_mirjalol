CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Samsung Galaxy S23', 'Electronics', 899.99),
(2, 'Apple iPhone 14', 'Electronics', 999.99),
(3, 'Sony WH-1000XM5 Headphones', 'Electronics', 349.99),
(4, 'Dell XPS 13 Laptop', 'Electronics', 1249.99),
(5, 'Organic Eggs (12 pack)', 'Groceries', 3.49),
(6, 'Whole Milk (1 gallon)', 'Groceries', 2.99),
(7, 'Alpen Cereal (500g)', 'Groceries', 4.75),
(8, 'Extra Virgin Olive Oil (1L)', 'Groceries', 8.99),
(9, 'Mens Cotton T-Shirt', 'Clothing', 12.99),
(10, 'Womens Jeans - Blue', 'Clothing', 39.99),
(11, 'Unisex Hoodie - Grey', 'Clothing', 29.99),
(12, 'Running Shoes - Black', 'Clothing', 59.95),
(13, 'Ceramic Dinner Plate Set (6 pcs)', 'Home & Kitchen', 24.99),
(14, 'Electric Kettle - 1.7L', 'Home & Kitchen', 34.90),
(15, 'Non-stick Frying Pan - 28cm', 'Home & Kitchen', 18.50),
(16, 'Atomic Habits - James Clear', 'Books', 15.20),
(17, 'Deep Work - Cal Newport', 'Books', 14.35),
(18, 'Rich Dad Poor Dad - Robert Kiyosaki', 'Books', 11.99),
(19, 'LEGO City Police Set', 'Toys', 49.99),
(20, 'Rubiks Cube 3x3', 'Toys', 7.99);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate)
VALUES
(1, 1, 2, '2025-04-01'),
(2, 1, 1, '2025-04-05'),
(3, 2, 1, '2025-04-10'),
(4, 2, 2, '2025-04-15'),
(5, 3, 3, '2025-04-18'),
(6, 3, 1, '2025-04-20'),
(7, 4, 2, '2025-04-21'),
(8, 5, 10, '2025-04-22'),
(9, 6, 5, '2025-04-01'),
(10, 6, 3, '2025-04-11'),
(11, 10, 2, '2025-04-08'),
(12, 12, 1, '2025-04-12'),
(13, 12, 3, '2025-04-14'),
(14, 19, 2, '2025-04-05'),
(15, 20, 4, '2025-04-19'),
(16, 1, 1, '2025-03-15'),
(17, 2, 1, '2025-03-10'),
(18, 5, 5, '2025-02-20'),
(19, 6, 6, '2025-01-18'),
(20, 10, 1, '2024-12-25'),
(21, 1, 1, '2024-04-20');

--1
--Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.
--Return: ProductID, TotalQuantity, TotalRevenue
create table #MonthlySales (productID int, TotalQuantity int, TotoalRevenue int)
select * from #MonthlySales

--2
--Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
--Return: ProductID, ProductName, Category, TotalQuantitySold
create view vw_ProductSalesSummary as
select p.ProductID, p.ProductName, p.Category,p.price, sum(s.Quantity)as TotalQuantitySold from Products as p
inner join Sales as s
on p.ProductID = s.ProductID
group by p.ProductID, p.ProductName, p.Category,p.Price
select * from vw_ProductSalesSummary
--3
--Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
--Return: total revenue for the given product ID

create view vw_ProductSalesSummary1 as
select p.ProductID, p.ProductName, p.Category,p.price, sum(s.Quantity)as TotalQuantitySold from Products as p
inner join Sales as s
on p.ProductID = s.ProductID
group by p.ProductID, p.ProductName, p.Category,p.Price

create function fn_GetTotalRevenueForProduct (@productID int)
returns int as 
	begin
	declare @revenue int
	select @revenue = sum(TotalQuantitySold * Price) from vw_ProductSalesSummary1
	where @productID = ProductID
	return @revenue
	end

--4
--Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
--Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.

create view vw_ProductSalesSummary2 as
select p.ProductID, p.ProductName, p.Category,p.price,p.price*sum(s.quantity)as TotalRevenue, 
sum(s.Quantity)as TotalQuantitySold from Products as p
inner join Sales as s
on p.ProductID = s.ProductID
group by p.ProductID, p.ProductName, p.Category,p.Price

create function fn_GetSalesByCategory(@Category VARCHAR(50))
returns table as 
return
(select  ProductName,TotalQuantitySold,TotalRevenue from vw_ProductSalesSummary2 where @category = Category)

--5
--You have to create a function that get one argument as input from user and the function should 
--return 'Yes' if the input number is a prime number and 'No' otherwise.
create function check_prime (@primenum int)
returns varchar(50) as 
begin
declare @int int=30
declare @inc int = 2
declare @checker int = 1

while @int>@inc
	begin
		if @int%@inc = 0 
		begin
		
		set @checker = 0
		break
		end
		
		else 
		begin
		set @inc = @inc + 1
		end

	end
return case when @checker = 0 then 'NO' else 'Yes'
end

--6
--Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:
--@Start INT
--@End INT
create function fn_GetNumbersBetween (@start int, @end int)
returns @result table (number int) as
	begin
	declare @checker int = @start
	while @checker<=@end
		begin
		insert  into @result (number)
		values (@checker)
		set @checker = @checker + 1
		end
		return
	end

--7
-- Create the table
CREATE TABLE employee (
    id INT,
    salary INT
);

-- Insert the data
INSERT INTO employee (id, salary) VALUES
(1, 100),
(2, 200),
(3, 300);

--Write a SQL query to return the Nth highest distinct salary from the Employee table. 
--If there are fewer than N distinct salaries, return NULL.
create function getNthHighestSalary (@rank int)
returns int as
	begin
	declare @N int
	select @N = salary from (select distinct top(@rank) salary from employee order by salary desc) as ord 
	return @N
	
	end

--8
--Write a SQL query to find the person who has the most friends.
--Return: Their id, The total number of friends they have
-- Create the table
CREATE TABLE Friendships (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

-- Insert the data
INSERT INTO Friendships (requester_id, accepter_id, accept_date) VALUES
(1, 2, '2016-06-03'),
(1, 3, '2016-06-08'),
(2, 3, '2016-06-08'),
(3, 4, '2016-06-09');

SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM Friendships
    UNION ALL
    SELECT accepter_id AS id FROM Friendships
) AS AllFriends
GROUP BY id
ORDER BY num DESC;

--9
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers (customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);

/*Create a view called vw_CustomerOrderSummary that returns a summary of customer orders. The view must contain the following columns:

Column Name | Description
customer_id | Unique identifier of the customer
name | Full name of the customer
total_orders | Total number of orders placed by the customer
total_amount | Cumulative amount spent across all orders
last_order_date | Date of the most recent order placed by the customer*/
create view vw_CustomerOrderSummary as

select ord.customer_id, s.name, count(ord.order_id)as total_orders, sum(ord.amount)as total_amount, max(ord.order_date) as last_order_date from Orders as ord
inner join customers as s
on s.customer_ID = ord.customer_ID
group by ord.customer_id, s.name

--10
--
