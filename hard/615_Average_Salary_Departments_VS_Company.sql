Table: Salary

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| employee_id | int  |
| amount      | int  |
| pay_date    | date |
+-------------+------+
id is the primary key column for this table.
Each row of this table indicates the salary of an employee in one month.
employee_id is a foreign key from the Employee table.
 

Table: Employee

+---------------+------+
| Column Name   | Type |
+---------------+------+
| employee_id   | int  |
| department_id | int  |
+---------------+------+
employee_id is the primary key column for this table.
Each row of this table indicates the department of an employee.
 

Write an SQL query to report the comparison result (higher/lower/same) of the average salary of employees in a department to the company's average salary.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Salary table:
+----+-------------+--------+------------+
| id | employee_id | amount | pay_date   |
+----+-------------+--------+------------+
| 1  | 1           | 9000   | 2017/03/31 |
| 2  | 2           | 6000   | 2017/03/31 |
| 3  | 3           | 10000  | 2017/03/31 |
| 4  | 1           | 7000   | 2017/02/28 |
| 5  | 2           | 6000   | 2017/02/28 |
| 6  | 3           | 8000   | 2017/02/28 |
+----+-------------+--------+------------+
Employee table:
+-------------+---------------+
| employee_id | department_id |
+-------------+---------------+
| 1           | 1             |
| 2           | 2             |
| 3           | 2             |
+-------------+---------------+
Output: 
+-----------+---------------+------------+
| pay_month | department_id | comparison |
+-----------+---------------+------------+
| 2017-02   | 1             | same       |
| 2017-03   | 1             | higher     |
| 2017-02   | 2             | same       |
| 2017-03   | 2             | lower      |
+-----------+---------------+------------+
Explanation: 
In March, the company's average salary is (9000+6000+10000)/3 = 8333.33...
The average salary for department '1' is 9000, which is the salary of employee_id '1' since there is only one employee in this department. So the comparison result is 'higher' since 9000 > 8333.33 obviously.
The average salary of department '2' is (6000 + 10000)/2 = 8000, which is the average of employee_id '2' and '3'. So the comparison result is 'lower' since 8000 < 8333.33.

With he same formula for the average salary comparison in February, the result is 'same' since both the department '1' and '2' have the same average salary with the company, which is 7000.

solution:

Create table Salary (id int, employee_id int, amount int, pay_date date)
Create table Employee (employee_id int, department_id int)
Truncate table Salary
insert into Salary (id, employee_id, amount, pay_date) values ('1', '1', '9000', '2017/03/31')
insert into Salary (id, employee_id, amount, pay_date) values ('2', '2', '6000', '2017/03/31')
insert into Salary (id, employee_id, amount, pay_date) values ('3', '3', '10000', '2017/03/31')
insert into Salary (id, employee_id, amount, pay_date) values ('4', '1', '7000', '2017/02/28')
insert into Salary (id, employee_id, amount, pay_date) values ('5', '2', '6000', '2017/02/28')
insert into Salary (id, employee_id, amount, pay_date) values ('6', '3', '8000', '2017/02/28')
Truncate table Employee
insert into Employee (employee_id, department_id) values ('1', '1')
insert into Employee (employee_id, department_id) values ('2', '2')
insert into Employee (employee_id, department_id) values ('3', '2')


with t1 as (select avg(s.amount) company_salary,left(s.pay_date ,7) pay_month  from employee e inner join salary s
on e.employee_id = s.employee_id
group by 
left(s.pay_date ,7)
),
t2 as (
select avg(s.amount) department_salary,e.department_id,left(s.pay_date ,7) pay_month  from employee e inner join salary s
on e.employee_id = s.employee_id
group by 
e.department_id,left(s.pay_date ,7)
)
select t2.pay_month,t2.department_id,case when t2.department_salary > t1.company_salary then 'higher' 
when t2.department_salary = t1.company_salary then 'same'
when t2.department_salary < t1.company_salary then 'lower' 
else 'NA' end as comparison 
from t2 inner join t1
on t2.pay_month = t1.pay_month