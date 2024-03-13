create database emp_sales;
select * from employee;
use emp_sales;
desc employee;
alter table employee modify column  employee_id int primary key;
select * from sales;
alter table sales modify column sale_id int primary key;
alter table sales add foreign key(employee_id) references employee(employee_id);
desc sales;

-- Task 01
-- A. Retrieve the names and salaries of all employees, along with the average salary in their respective
-- departments.
select name,department,salary,avg(salary) over(partition by department) from employee;

-- B. Calculate the total sales amount for each employee, including those who have not made any sales.
-- Display their names and total sales amount.
select e.employee_id,name,sum(sale_amount) from employee e left join sales s on e.employee_id=s.employee_id group by employee_id,name;

-- C. Rank employees within each department based on their salary in descending order. The ranking should
-- reset for each department.if two employees have the highest salary, they will both be assigned the rank
-- 1, and the next distinct salary will be assigned the rank 3 (skipping 2)
select employee_id,name,salary,rank() over(partition by department order by salary desc) from employee;

-- Rank employees within each department based on their salary in descending order. The ranking should
-- reset for each department.if two employees have the highest salary, they will both be assigned the rank
-- 1, and the next distinct salary will be assigned the rank 2."
select employee_id,name,salary,dense_rank() over(partition by department order by salary desc) from employee;
