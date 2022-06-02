Table: Products

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| store       | enum    |
| price       | int     |
+-------------+---------+
(product_id, store) is the primary key for this table.
store is an ENUM of type ('store1', 'store2', 'store3') where each represents the store this product is available at.
price is the price of the product at this store.
 

Write an SQL query to find the price of each product in each store.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Products table:
+-------------+--------+-------+
| product_id  | store  | price |
+-------------+--------+-------+
insert into products_1777 values(0,'store1',95 );
insert into products_1777 values(0,'store3',105);
insert into products_1777 values(0,'store2',100);
insert into products_1777 values(1,'store1',70 );
insert into products_1777 values(1,'store3',80 );
+-------------+--------+-------+
Output: 
+-------------+--------+--------+--------+
| product_id  | store1 | store2 | store3 |
+-------------+--------+--------+--------+
| 0           | 95     | 100    | 105    |
| 1           | 70     | null   | 80     |
+-------------+--------+--------+--------+
Explanation: 
Product 0 price's are 95 for store1, 100 for store2 and, 105 for store3.
Product 1 price's are 70 for store1, 80 for store3 and, it's not sold in store2.

solution :

create table Products_1777(product_id int, store varchar(10),price int);

select product_id,
    sum(
        case
            when store = 'store1' then price
            else null
        end
    ) store1,
    sum(
        case
            when store = 'store2' then price
            else null
        end
    ) store2,
    sum(
        case
            when store = 'store3' then price
            else null
        end
    ) store3
from products
group by product_id

select product_id, [store1], [store2], [store3]
from (select product_id, store, price
from products) as sourcetable
pivot
(max(price) for store in ([store1], [store2], [store3])) as pv