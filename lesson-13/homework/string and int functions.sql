--Easy part
--1
--You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.
select concat (EMPLOYEE_ID, '-', FIRST_NAME, ' ', LAST_NAME) from Employees

--2
--Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
update employees 
set PHONE_NUMBER =   replace (phone_number, '124','999') 

--3
/*
That displays the first name and the length of the first name for 
all employees whose name starts with the letters 'A', 'J' or 'M'. 
Give each column an appropriate label. Sort the results by the employees' first names.(Employees)
*/
select FIRST_NAME, len(FIRST_NAME)as lenght_first_name from Employees where FIRST_NAME like '[A]%' or
FIRST_NAME like '[J]%' or FIRST_NAME like '[M] %'
order by FIRST_NAME

--4
--Write an SQL query to find the total salary for each manager ID.(Employees table)
select MANAGER_ID, sum(SALARY) from Employees where manager_id is not null
 group by MANAGER_ID 

 --5
 --Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
select Year1,
case when max1<=max2 and max3 <= Max2 then Max2
when max2<=max1 and max3<=max1 then max1
else Max3
end as max_all
from TestMax

--6
--Find me odd numbered movies and description is not boring.(cinema)
select * from cinema where ID%2 = 1 and description <> 'boring'

--7
/*
You have to sort data based on the Id but Id with 0 should always be the last row. 
Now the question is can you do that with a single order by column.(SingleOrder)
*/
select *
from SingleOrder
order by case when id = 0 then 1
else 0
end

--8
/*
Write an SQL query to select the first non-null value from a set of columns. 
If the first column is null, move to the next, and so on. If all columns are null, return null.(person)
*/
select coalesce(ID,ssn,passportid,itin) from person

--Medium part
--1
--Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
select substring(fullname, 1, charindex(' ', FullName)-1) as first_name,
substring(fullname, charindex(' ', fullname, charindex(' ', fullname)+1)+1, len(fullname)) as last_name,
substring(fullname, charindex(' ', fullname), charindex(' ', fullname, charindex(' ', fullname)+1) 
- charindex(' ', fullname)) as middle_name from Students

--2
--For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)
select * from Orders as o1
inner join orders as o2
on o1.CustomerID = o2.CustomerID
where o1.DeliveryState = 'CA'
and o2.DeliveryState = 'TX'

--4
--Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.
select concat(first_name,' ',last_name)from Employees where
patindex('%a%a%a',concat(First_name,' ',Last_name))<>0 

--5
--The total number of employees in each department and the percentage of those employees 
--who have been with the company for more than 3 years(Employees)

select * from Employees where datediff(year, HIRE_DATE,getdate())> 3
select DEPARTMENT_ID, count(employee_ID)as count_emp from Employees group by DEPARTMENT_ID
select count(*) as total_emp, 
count(case when datediff(year, HIRE_DATE,getdate())> 3 then 1
end) as hire_3

from Employees

--6
--Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)
select max(MissionCount)as max_exp, min(missionCount) as min_exp, JobDescription,SpacemanID from Personal group by JobDescription,SpacemanID

--Hard part
--4
--Given the following dataset, find the students that share the same birthday.(Student Table)
select distinct s1.StudentName, s1.Birthday from Student as s1
inner join student as s2
on s1.Birthday = s2.Birthday
and s1.StudentName<>s2.StudentName


