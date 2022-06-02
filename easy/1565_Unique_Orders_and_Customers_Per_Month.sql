Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| order_date    | date    |
| customer_id   | int     |
| invoice       | int     |
+---------------+---------+
order_id is the primary key for this table.
This table contains information about the orders made by customer_id.
 

Write an SQL query to find the number of unique orders and the number of unique customers with invoices > $20 for each different month.

Return the result table sorted in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Orders table:
+----------+------------+-------------+------------+
| order_id | order_date | customer_id | invoice    |
+----------+------------+-------------+------------+
insert into orders_1565 values(1,'2020-09-15',1,30);
insert into orders_1565 values(2,'2020-09-17',2,90);
insert into orders_1565 values(3,'2020-10-06',3,20);
insert into orders_1565 values(4,'2020-10-20',3,21);
insert into orders_1565 values(5,'2020-11-10',1,10);
insert into orders_1565 values(6,'2020-11-21',2,15);
insert into orders_1565 values(7,'2020-12-01',4,55);
insert into orders_1565 values(8,'2020-12-03',4,77);
insert into orders_1565 values(9,'2021-01-07',3,31);
insert into orders_1565 values(1,'2021-01-15',2,20);
+----------+------------+-------------+------------+
Output: 
+---------+-------------+----------------+
| month   | order_count | customer_count |
+---------+-------------+----------------+
| 2020-09 | 2           | 2              |
| 2020-10 | 1           | 1              |
| 2020-12 | 2           | 1              |
| 2021-01 | 1           | 1              |
+---------+-------------+----------------+
Explanation: 
In September 2020 we have two orders from 2 different customers with invoices > $20.
In October 2020 we have two orders from 1 customer, and only one of the two orders has invoice > $20.
In November 2020 we have two orders from 2 different customers but invoices < $20, so we don't include that month.
In December 2020 we have two orders from 1 customer both with invoices > $20.
In January 2021 we have two orders from 2 different customers, but only one of them with invoice > $20.


######################
create table orders_1565(order_id int, order_date date, customer_id int, invoice int);

with t1 as (
    select distinct customer_id,
        format(order_date, 'yyyy-MM') order_date
    from orders_1565
    where invoice > 20
),
t2 as (
    select count(customer_id) customer_count,
        order_date
    from t1
    group by order_date
),
t3 as (
    select count(order_id) order_count,
        month
    from (
            select order_id,
                format(order_date, 'yyyy-MM') month,
                customer_id
            from orders_1565
            where invoice > 20
        ) a
    group by month
)
select month,
    order_count,
    customer_count
from t3
    inner join t2 on t3.month = t2.order_date

###################################################

select distinct left(order_date, 7) as month,
    count(left(order_date, 7)) as order_count,
    count(distinct customer_id) as customer_count
from orders
where invoice > 20
group by left(order_date, 7)

