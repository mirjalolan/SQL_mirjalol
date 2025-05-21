--Basic part

select Category, count( productname) as count_pro from Products group by category

select avg(Price)as avg_price from Products where category = 'Electronics'

select firstname,lastname from Customers where city like 'L%'

select productname from products where productname like '%er'

select CustomerID from Customers where country like '%A'

select max(price)as max_price from products

select *,
case when StockQuantity<30 then 'Low stock'
else 'Sufficient'
end as status
from products
order by case when StockQuantity<30 then 'Low stock'
else 'Sufficient'
end

select country, count(CustomerID) as number_of_customers from customers group by country  order by number_of_customers

select min(quantity) as min_sales, max(Quantity) as max_sales from orders

--Medium part
select CustomerID from orders where orderdate between '2023-01-01' and '2023-02-01'
except
select  customerID from Invoices 

select ProductName from Products
union all
select ProductName from Products_Discounted

select productname from Products
union
select productname from Products_Discounted

select year(OrderDate), avg(TotalAmount) from orders group by year(OrderDate)

select productname,
case when price < 100 then 'Low'
when price between 100 and 500 then 'Mid'
when price > 500 then 'High'
else Null
end as Price_group
from Products

select district_id, [2012],[2013] into Population_Each_Year from city_population
pivot (
sum(population)for year in([2012],[2013]) 
) as pivoted_table

select ProductID, sum(SaleAmount) from Sales group by ProductID

select ProductName from products where productname like '%oo%'

select year, [Bektemir], [Chilonzor], [Yakkasaroy] into  Population_Each_City from city_population
pivot(
sum(population) for district_name in ([Bektemir], [Chilonzor], [Yakkasaroy]) 
) as pivoted_table
select * from Population_Each_City


--Hard part
select top 3 customerID, sum(TotalAmount)as total_spent from Invoices  group by CustomerID order by total_spent desc

select district_id, population, year from Population_Each_Year
unpivot (
population for year in ([2012],[2013])
) as unpivoted_table

select p.productname, count (s.saleid) as sales_count from products as p
left join 
sales as s on p.productID = s.ProductID
group by p.productname
order by sales_count desc

select  year, districtname, population from Population_Each_City
unpivot (
population for districtname in ([Chilonzor], [Yakkasaroy], [Bektemir])
) as unpivoted_table

