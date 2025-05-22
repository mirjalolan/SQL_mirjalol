
--Medium part 4 and 5
create database SchoolDB
use SchoolDB
create table Students (StudentID int, name varchar(50), age int )
select * from Students



--Hard part 7.

--7. DQL
select * from Students

--DML
insert into Students (StudentID, name, age) values
(002, 'Mirjalol', 20), (003,'Sardor', 25), (005,'Asror',22)
update Students set age = 30 where age = '20'
delete students where name = 'Mirjalol'
select * from Students

--DDL
alter table Students add school_name varchar(50)
select * from Students




/*Easy part:

1. Data - Raw facts and figures without context (e.g., names, numbers, dates).
Database - An organized collection of data stored and accessed electronically.
Relational Database - A type of database that stores data in tables with relationships between them
Table - A structure inside a database that organizes data into rows (records) and columns (fields)

2. Storing and Managing Data
Strong Security 
Reliable Transactions 
Backup and Recovery
High Availability and Replication
 
3. Windows Authentication - Using Windows user accounts to access SQL Server. It's more secure.
SQL Server Authentication - Using a separate username and password set up in SQL Server. 

Medium part:

6. SQL Server - A software that stores and manages databases and it runs and processes SQL commands.Developed by Microsoft
SSMS (SQL Server Management Studio) - A tool used to connect to and manage SQL Server. Lets you run SQL queries and manage databases with a user-friendly interface.
SQL (Structured Query Language) - A language used to interact with databases.

Hard part
8. insert into Students (StudentID, name, age) values
(002, 'Mirjalol', 20), (003,'Sardor', 25), (005,'Asror',22)
9. 
- Press right click button on 'Databases' and choose 'Restore database'
- Choose 'Device' and press '...' button in right there
- Then press 'ADD'
