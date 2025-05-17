--Easy part
select min(price) from products7

select max(salary) from Employees7

select count(*) from Customers7

select  count(distinct Category) from Products7

select sum(saleamount) from sales where SaleID=7

select avg(age) from Employees7

select departmentName, count(EmployeeID)  from Employees7 group by departmentname

select category, min(price) as min_price, max(price) as max_price from Products7 group by Category

select customerID, sum(SaleAmount)as sum_sales from Sales group by CustomerID

select DepartmentName, count(EmployeeID) as employee_count from Employees7 group by DepartmentName having count(EmployeeID) > 5

--Medium part
select productID, sum(SaleAmount) as sum_sales, avg(SaleAmount)as average_sales from Sales group by productid

select count(EmployeeID) as HR_COUNT from Employees7 where departmentname = 'HR'

select DepartmentName, max(Salary) as max_salary, min(Salary)as min_salary from Employees7 group by DepartmentName

select DepartmentName, avg(Salary) as average_salary from Employees7 group by DepartmentName

select DepartmentName, avg(Salary) as average_salary, count(EmployeeID) as employee_count from Employees7 group by DepartmentName

select category, avg(price) as average_price from Products7 group by category having avg(Price) > 400

select saledate, count(SaleID) as sale_count from Sales group by SaleDate

select CustomerID, count(Quantity)as sale_count from orders group by CustomerID having count(Quantity) >= 3

select DepartmentName, avg(salary) as average_salary from Employees7 group by DepartmentName having avg(Salary) > 60000

--Hard part
select category, avg(Price) from Products7 group by Category having avg(price) > 150

select customerID, sum(totalamount)as sale_amount from Orders group by CustomerID having sum(TotalAmount) > 1500
select * from Orders

select DepartmentName, sum(Salary)as total_salary, avg(salary)as average_salary from Employees7 group by DepartmentName having avg(salary)> 65000

select CustomerID, sum(TotalAmount)as total_sale, min(TotalAmount)as min_sale from Orders group by CustomerID having sum(TotalAmount) > 50

select month(orderdate)as order_month,count(orderID)as count_order, sum(TotalAmount)as total_sale, count(distinct ProductID)as count_product from Orders group by month(orderdate) having count(orderID) >= 2

select year(OrderDate)as order_year, min(OrderID)as min_count, max(OrderID)as max_count from Orders group by year(orderDate)
