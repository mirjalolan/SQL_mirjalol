--1
/*Create a stored procedure that:

Creates a temp table #EmployeeBonus
Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
(BonusAmount = Salary * BonusPercentage / 100)
Then, selects all data from the temp table.*/
CREATE TABLE #EmployeeBonus (
    EmployeeID INT,
    FullName VARCHAR(100),
    Department VARCHAR(50),
    Bonus int
);

insert into #EmployeeBonus  
select emp.EmployeeID, concat(emp.firstname, ' ', emp.lastname)as fullname, emp.Department, 
case when emp.Department = 'Sales' then emp.Salary * 0.1
when emp.department = 'HR' then emp.Salary * 0.08
when emp.department = 'IT' then emp.Salary * 0.15
else 0
end as bonus
from Employees as emp

create proc bonussystem
as
begin
select* from #EmployeeBonus
end

--2
/*Create a stored procedure that:

Accepts a department name and an increase percentage as parameters
Update salary of all employees in the given department by the given percentage
Returns updated employees from that department.
*/

create proc autobonus2
@department varchar(50),
@bonusper int as
	begin
	update Employees
	set Salary = salary + Salary * @bonusper/100 where @department = Department 
	end


--3

/*Perform a MERGE operation that:

Updates ProductName and Price if ProductID matches
Inserts new products if ProductID does not exist
Deletes products from Products_Current if they are missing in Products_New
Return the final state of Products_Current after the MERGE.*/

MERGE INTO Products_Current as Target
USING Products_New as Source
on Target.productID=source.productID

--If employee exists, update their details

WHEN MATCHED and Target.price<>Source.price then
  Update set target.price=source.price

  --If emp does not exists insert records
when not matched then 
insert(productID, productname, price) values (source.productID, source.productname, source.price);

--4
/*Each node in the tree can be one of three types:

"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write a solution to report the type of each node in the tree.*/
SELECT 
    
    CASE 
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN c.id IS NULL THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM Tree t
LEFT JOIN Tree c ON t.id = c.p_id
GROUP BY CASE 
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN c.id IS NULL THEN 'Leaf'
        ELSE 'Inner'
    END

--5
CREATE TABLE  Signups (user_id INT, time_stamp DATETIME);
CREATE TABLE  Confirmations (user_id INT, time_stamp DATETIME, [action] varchar(20) check ([action] in ('confirmed', 'timeout') ));

INSERT INTO Signups (user_id, time_stamp) VALUES 
(3, '2020-03-21 10:16:13'),
(7, '2020-01-04 13:57:59'),
(2, '2020-07-29 23:09:44'),
(6, '2020-12-09 10:39:37');

INSERT INTO Confirmations (user_id, time_stamp, action) VALUES 
(3, '2021-01-06 03:30:46', 'timeout'),
(3, '2021-07-14 14:00:00', 'timeout'),
(7, '2021-06-12 11:57:29', 'confirmed'),
(7, '2021-06-13 12:58:28', 'confirmed'),
(7, '2021-06-14 13:59:27', 'confirmed'),
(2, '2021-01-22 00:00:00', 'confirmed'),
(2, '2021-02-28 23:59:59', 'timeout');

/*Find the confirmation rate for each user. If a user has no confirmation requests, the rate should be 0.*/

SELECT 
    user_id,
	COUNT(CASE WHEN action = 'confirmed' THEN 1 END) * 1.0 / COUNT(*) AS confirmation_rate
FROM Confirmations
GROUP BY user_id;

--6
--Find all employees who have the lowest salary using subqueries.
select * from employees_ where salary = (select min(salary) from employees_)

--7

/*Create a stored procedure called GetProductSalesSummary that:

Accepts a @ProductID input
Returns:
ProductName
Total Quantity Sold
Total Sales Amount (Quantity × Price)
First Sale Date
Last Sale Date
If the product has no sales, return NULL for quantity, total amount, first date, and last date, but still return the product name.*/
create proc GetProductSalesSummary 
@productID int as 
begin

select p.ProductName, sum(s.Quantity) as TotalQuantitySold, sum(s.Quantity) * p.price as TotalSalesAmount,
max(s.saledate) as LastSaleDate, min(s.saledate) as FirstSaleDate
 from Sales as s
inner join Products as p
on s.ProductID = p.ProductID
where p.productID = @productID
group by p.ProductName, p.Price
end
