Table: Customers

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| customer_name | varchar |
+---------------+---------+
customer_id is the primary key for this table.
Each row of this table contains the name and the id customer.
 

Write an SQL query to find the missing customer IDs. The missing IDs are ones that are not in the Customers table but are in the range between 1 and the maximum customer_id present in the table.

Notice that the maximum customer_id will not exceed 100.

Return the result table ordered by ids in ascending order.

The query result format is in the following example.

 

Example 1:

Input: 
Customers table:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 1           | Alice         |
| 4           | Bob           |
| 5           | Charlie       |
+-------------+---------------+
Output: 
+-----+
| ids |
+-----+
| 2   |
| 3   |
+-----+
Explanation: 
The maximum customer_id present in the table is 5, so in the range [1,5], IDs 2 and 3 are missing from the table.

Create table If Not Exists Customers_1613 (customer_id int, customer_name varchar(20))
Truncate table Customers_1613
insert into Customers_1613 (customer_id, customer_name) values ('1', 'Alice')
insert into Customers_1613 (customer_id, customer_name) values ('4', 'Bob')
insert into Customers_1613 (customer_id, customer_name) values ('5', 'Charlie')

=========================================================================


with max_id as (
    select MAX(customer_id) id from Customers_1613
)
, ids as (
            select 1 as id
                union all
            select id + 1 
                from ids
                where id < (select * from max_id)
            )

select id as ids from ids
except
select customer_id from Customers_1613
order by 1

oracle : 

with cte as (
    select level as ids
    from dual connect by level <= (
            select max(customer_id)
            from customers
        )
)
select ids as "ids"
from cte
where ids not in (
        select customer_id
        from Customers
    )
order by ids