Table: Customers

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
+---------------+---------+
customer_id is the primary key for this table.
This table contains information about the customers.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| order_date    | date    |
| customer_id   | int     |
| product_id    | int     |
+---------------+---------+
order_id is the primary key for this table.
This table contains information about the orders made by customer_id.
There will be no product ordered by the same user more than once in one day.
 

Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| product_name  | varchar |
| price         | int     |
+---------------+---------+
product_id is the primary key for this table.
This table contains information about the Products.
 

Write an SQL query to find the most recent order(s) of each product.

Return the result table ordered by product_name in ascending order and in case of a tie by the product_id in ascending order. If there still a tie, order them by order_id in ascending order.

The query result format is in the following example.

 

Example 1:

Input: 
Customers table:
+-------------+-----------+
| customer_id | name      |
+-------------+-----------+
| 1           | Winston   |
| 2           | Jonathan  |
| 3           | Annabelle |
| 4           | Marwan    |
| 5           | Khaled    |
+-------------+-----------+
Orders table:
+----------+------------+-------------+------------+
| order_id | order_date | customer_id | product_id |
+----------+------------+-------------+------------+
insert into orders_1549 values(1 ,'2020-07-31',1,1);
insert into orders_1549 values(2 ,'2020-07-30',2,2);
insert into orders_1549 values(3 ,'2020-08-29',3,3);
insert into orders_1549 values(4 ,'2020-07-29',4,1);
insert into orders_1549 values(5 ,'2020-06-10',1,2);
insert into orders_1549 values(6 ,'2020-08-01',2,1);
insert into orders_1549 values(7 ,'2020-08-01',3,1);
insert into orders_1549 values(8 ,'2020-08-03',1,2);
insert into orders_1549 values(9 ,'2020-08-07',2,3);
insert into orders_1549 values(10,'2020-07-15',1,2);
+----------+------------+-------------+------------+
Products table:
+------------+--------------+-------+
| product_id | product_name | price |
+------------+--------------+-------+
insert into products_1549 values(1,'keyboard',120);
insert into products_1549 values(2,'mouse',80 );
insert into products_1549 values(3,'screen',600);
insert into products_1549 values(4,'hard disk',450);
+------------+--------------+-------+
Output: 
+--------------+------------+----------+------------+
| product_name | product_id | order_id | order_date |
+--------------+------------+----------+------------+
| keyboard     | 1          | 6        | 2020-08-01 |
| keyboard     | 1          | 7        | 2020-08-01 |
| mouse        | 2          | 8        | 2020-08-03 |
| screen       | 3          | 3        | 2020-08-29 |
+--------------+------------+----------+------------+
Explanation: 
keyboard's most recent order is in 2020-08-01, it was ordered two times this day.
mouse's most recent order is in 2020-08-03, it was ordered only once this day.
screen's most recent order is in 2020-08-29, it was ordered only once this day.
The hard disk was never ordered and we do not include it in the result table.


solution : 

create table customers_1549(customer_id int, name varchar(50));

create table orders_1549 (order_id int, order_date date, customer_id int, product_id int);

create table products_1549 (product_id int, product_name varchar(50), price int);



select product_name,
    product_id,
    order_id,
    order_date
from (
        select product_name,
            o.product_id,
            order_id,
            order_date,
            rank() over(
                partition by o.product_id
                order by order_date desc
            ) rnk
        from products p
            inner join orders o on p.product_id = o.product_id
    ) a
where rnk = 1
order by product_name asc,
    product_id asc,
    order_id asc