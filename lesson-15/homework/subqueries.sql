--1
--Task: Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)
select * from employees where salary = (select min(salary) from employees)

--2
--Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)
select * from products where price > (select avg(price) from products)

--3
--Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. 
--Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)
 select * from employees15 as emp where department_id = (select d.id from departments as d where d.department_name = 'Sales' )

 --4
 --Task: Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)
select * from customers where customer_id not in (select ord.customer_id from orders as ord )

--5
--Task: Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)
select * from products15 as p1 where price = (select max(price)from products15 as p5 where p1.category_id=p5.category_id)

--6
--Task: Retrieve employees working in the department with the highest average salary. 
--Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)
select * from employees_ as emp2 where salary = (select max(salary) from employees_ as emp1 where emp1.department_id = emp2.department_id)

--7
--Task: Retrieve employees earning more than the average salary in their department. 
--Tables: employees (columns: id, name, salary, department_id)
select * from employees18 emp1 where salary > (select avg(salary) from employees18 as emp2 where emp1.department_id = emp2.department_id)

--8
--Task: Retrieve students who received the highest grade in each course. 
--Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)
select * from grades as g1 where grade = (select max(grade) from grades as g2 where g1.course_id = g2.course_id)

--9
--Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. 
--Tables: products (columns: id, product_name, price, category_id)
select p1.* from products17 as p1 where 3 = (select count(distinct price) from products17 as p2 where p1.category_id = p2.category_id and p2.price>
p1.price)

--10
--Task: Retrieve employees with salaries above the company average but below the maximum in their department. 
--Tables: employees (columns: id, name, salary, department_id)

select * from employees19 emp1 where salary > (select avg(salary) from employees19) and 
salary < (select max(salary) from employees19 as emp2 where emp1.department_id = emp2.department_id)
