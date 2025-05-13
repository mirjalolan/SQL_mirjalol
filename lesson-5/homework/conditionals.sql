--Basic part
select productname as name from Products5 
select * from Products5

select * from customers5 as client

select productname from Products5
union 
select productname from products_discounted

select * from products5 
intersect 
select * from Products_Discounted

select distinct firstname, lastname, country from Customers5
select * from Customers5

select *,
case when price > 1000 then 'High'
else 'low' end as Degree
from Products5

select iif (stockquantity > 100, 'Yes', 'No') from Products_Discounted
select * from Products_Discounted

--Medium part
select * from Products5
except
select * from Products_Discounted

select iif(price > 1000, 'Expensive', 'Affordable') from Products5

select * from Employees5 where age < 25 or salary > 60000

update Employees5
set Salary = salary * 0.1 where DepartmentName = 'HR' or EmployeeID = 5
select * from Employees5

--Hard part
select *,
case when saleamount > 500 then 'Top Tier'
when saleamount > 200 then 'Mid tier'
else 'Low tier' 
end as status 
from sales5

select customerID from orders
except
select customerID from sales5

select customerID, quantity,
case when quantity = 1 then '3%'
when quantity between 2 and 3 then '5%'
else '7%' 
end as discount_percentage
from Orders
