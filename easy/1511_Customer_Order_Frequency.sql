Table: Customers

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| country       | varchar |
+---------------+---------+
customer_id is the primary key for this table.
This table contains information about the customers in the company.
 

Table: Product

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| description   | varchar |
| price         | int     |
+---------------+---------+
product_id is the primary key for this table.
This table contains information on the products in the company.
price is the product cost.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| customer_id   | int     |
| product_id    | int     |
| order_date    | date    |
| quantity      | int     |
+---------------+---------+
order_id is the primary key for this table.
This table contains information on customer orders.
customer_id is the id of the customer who bought "quantity" products with id "product_id".
Order_date is the date in format ('YYYY-MM-DD') when the order was shipped.
 

Write an SQL query to report the customer_id and customer_name of customers who have spent at least $100 in each month of June and July 2020.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Customers table:
+--------------+-----------+-------------+
| customer_id  | name      | country     |
+--------------+-----------+-------------+
insert into customers values(1,'Winston','USA');   
insert into customers values(2,'Jonathan','Peru');  
insert into customers values(3,'Moustafa','Egypt');
+--------------+-----------+-------------+
Product table:
+--------------+-------------+-------------+
| product_id   | description | price       |
+--------------+-------------+-------------+
insert into product values(10,'LC Phone',300);
insert into product values(20,'LC T-Shirt',10);
insert into product values(30,'LC Book',45);
insert into product values(40,'LC Keychain',2  );
+--------------+-------------+-------------+
Orders table:
+--------------+-------------+-------------+-------------+-----------+
| order_id     | customer_id | product_id  | order_date  | quantity  |
+--------------+-------------+-------------+-------------+-----------+
insert into orders_1511 values(1,1,10,'2020-06-10',1 );
insert into orders_1511 values(2,1,20,'2020-07-01',1 );
insert into orders_1511 values(3,1,30,'2020-07-08',2 );
insert into orders_1511 values(4,2,10,'2020-06-15',2 );
insert into orders_1511 values(5,2,40,'2020-07-01',10);
insert into orders_1511 values(6,3,20,'2020-06-24',2 );
insert into orders_1511 values(7,3,30,'2020-06-25',2 );
insert into orders_1511 values(9,3,30,'2020-05-08',3 );
+--------------+-------------+-------------+-------------+-----------+
Output: 
+--------------+------------+
| customer_id  | name       |  
+--------------+------------+
| 1            | Winston    |
+--------------+------------+
Explanation: 
Winston spent $300 (300 * 1) in June and $100 ( 10 * 1 + 45 * 2) in July 2020.
Jonathan spent $600 (300 * 2) in June and $20 ( 2 * 10) in July 2020.
Moustafa spent $110 (10 * 2 + 45 * 2) in June and $0 in July 2020.


solution :

create table customer(customer_id int,name varchar(50), country varchar(50));

create table product(product_id int,description varchar(50), price int);

create table orders_1511 (order_id int, customer_id int, product_id int,order_date date, quantity int)


with t as (
    select customer_id,
        name,
        order_month,
        sum(total_price) total_price
    from (
            select c.customer_id,
                name,
                o.product_id,
                order_date,
                quantity,
                p.price,
(quantity * price) as total_price,
                format(order_date, 'yyyyMM') order_month
            from customers c
                inner join orders o on c.customer_id = o.customer_id
                inner join product p on o.product_id = p.product_id
            where format(order_date, 'yyyyMM') in('202006', '202007')
        ) a
    group by customer_id,
        name,
        order_month
    having sum(total_price) >= 100
)
select customer_id,
    name
from t
group by customer_id,
    name
having count(*) = 2