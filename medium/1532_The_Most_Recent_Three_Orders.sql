Table: Customers

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
+---------------+---------+
customer_id is the primary key for this table.
This table contains information about customers.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| order_date    | date    |
| customer_id   | int     |
| cost          | int     |
+---------------+---------+
order_id is the primary key for this table.
This table contains information about the orders made by customer_id.
Each customer has one order per day.
 

Write an SQL query to find the most recent three orders of each user. If a user ordered less than three orders, return all of their orders.

Return the result table ordered by customer_name in ascending order and in case of a tie by the customer_id in ascending order. If there is still a tie, order them by order_date in descending order.

The query result format is in the following example.

 

Example 1:

Input: 
Customers table:
+-------------+-----------+
| customer_id | name      |
+-------------+-----------+
insert into customers_1532 values(1,'Winston');
insert into customers_1532 values(2,'Jonathan');
insert into customers_1532 values(3,'Annabelle');
insert into customers_1532 values(4,'Marwan');
insert into customers_1532 values(5,'Khaled');
+-------------+-----------+
Orders table:
+----------+------------+-------------+------+
| order_id | order_date | customer_id | cost |
+----------+------------+-------------+------+
insert into orders_1532 values(1,'2020-07-31',1,30  );
insert into orders_1532 values(2,'2020-07-30',2,40  );
insert into orders_1532 values(3,'2020-07-31',3,70  );
insert into orders_1532 values(4,'2020-07-29',4,100 );
insert into orders_1532 values(5,'2020-06-10',1,1010);
insert into orders_1532 values(6,'2020-08-01',2,102 );
insert into orders_1532 values(7,'2020-08-01',3,111 );
insert into orders_1532 values(8,'2020-08-03',1,99  );
insert into orders_1532 values(9,'2020-08-07',2,32  );
insert into orders_1532 values(1,'2020-07-15',1,2   );
+----------+------------+-------------+------+
Output: 
+---------------+-------------+----------+------------+
| customer_name | customer_id | order_id | order_date |
+---------------+-------------+----------+------------+
| Annabelle     | 3           | 7        | 2020-08-01 |
| Annabelle     | 3           | 3        | 2020-07-31 |
| Jonathan      | 2           | 9        | 2020-08-07 |
| Jonathan      | 2           | 6        | 2020-08-01 |
| Jonathan      | 2           | 2        | 2020-07-30 |
| Marwan        | 4           | 4        | 2020-07-29 |
| Winston       | 1           | 8        | 2020-08-03 |
| Winston       | 1           | 1        | 2020-07-31 |
| Winston       | 1           | 10       | 2020-07-15 |
+---------------+-------------+----------+------------+
Explanation: 
Winston has 4 orders, we discard the order of "2020-06-10" because it is the oldest order.
Annabelle has only 2 orders, we return them.
Jonathan has exactly 3 orders.
Marwan ordered only one time.
We sort the result table by customer_name in ascending order, by customer_id in ascending order, and by order_date in descending order in case of a tie.


solution : 

create table customers_1532(customer_id int, name varchar(50));

create table orders_1532 (order_id int, order_date date, customer_id int, cost int);

select customer_name,
    customer_id,
    order_id,
    order_date
from (
        select c.name customer_name,
            c.customer_id,
            o.order_id,
            o.order_date,
            rank() over(
                partition by c.customer_id
                order by order_date desc
            ) rnk
        from customers c
            inner join orders o on c.customer_id = o.customer_id
    ) a
where rnk <= 3
order by customer_name asc,
    customer_id asc,
    order_date desc