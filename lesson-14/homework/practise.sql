--Esay part
--1
--Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
select ltrim(substring(name, 1, charindex(',', name)-1 )) as first_name,
substring(name,charindex(',', name)+1, len(name) ) as second_name
from TestMultipleColumns

--2
--Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
select * from testpercent where strs like '%[%]%'

--3
--In this puzzle you will have to split a string based on dot(.).(Splitter)
select substring(vals, 1, charindex('.', vals)-1),
substring(vals, charindex('.', vals)+1, len(vals))
from splitter

--4
--Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
select translate('1234ABC123456XYZ1234567890ADS', '0123456789', 'xxxxxxxxxx')

--5
--Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
select ID, vals from testdots where len(vals)-len(replace(vals, '.', '')) > 2

--6
--Write a SQL query to count the spaces present in the string.(CountSpaces)
select len(texts) - len(replace(texts, ' ', '')) from countspaces

--7
--write a SQL query that finds out employees who earn more than their managers.(Employee)
select emp2.* from employee as emp1
inner join employee as emp2 
on emp1.id=emp2.managerID
where emp2.salary>emp1.salary

--8
/*Find the employees who have been with the company for more than 10 years, but less than 15 years.
Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service 
(calculated as the number of years between the current date and the hire date).(Employees)*/
select Employee_ID, First_Name, Last_Name, Hire_Date, datediff(year, hire_date,getdate()) as years_of_service from employees 
where datediff(year, hire_date,getdate()) > 10 and datediff(year, hire_date, getdate())<15


--Medium part
--3
--Write an SQL query that reports the first login date for each player.(Activity)
select player_ID,min(event_date) from activity group by player_ID

--4
--Your task is to return the third item from that list.(fruits)
select value as third from fruits
cross apply string_split(fruit_list, '.',1) 
where ordinal = 3
