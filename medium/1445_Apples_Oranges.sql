Table: Sales

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| sale_date     | date    |
| fruit         | enum    | 
| sold_num      | int     | 
+---------------+---------+
(sale_date, fruit) is the primary key for this table.
This table contains the sales of "apples" and "oranges" sold each day.
 

Write an SQL query to report the difference between the number of apples and oranges sold each day.

Return the result table ordered by sale_date.

The query result format is in the following example.

 

Example 1:

Input: 
Sales table:
+------------+------------+-------------+
| sale_date  | fruit      | sold_num    |
+------------+------------+-------------+
insert into sales values('2020-05-01','apples',10);
insert into sales values('2020-05-01','oranges',8 );
insert into sales values('2020-05-02','apples',15);
insert into sales values('2020-05-02','oranges',15);
insert into sales values('2020-05-03','apples',20);
insert into sales values('2020-05-03','oranges',0 );
insert into sales values('2020-05-04','apples',15);
insert into sales values('2020-05-04','oranges',16);
+------------+------------+-------------+
Output: 
+------------+--------------+
| sale_date  | diff         |
+------------+--------------+
| 2020-05-01 | 2            |
| 2020-05-02 | 0            |
| 2020-05-03 | 20           |
| 2020-05-04 | -1           |
+------------+--------------+
Explanation: 
Day 2020-05-01, 10 apples and 8 oranges were sold (Difference  10 - 8 = 2).
Day 2020-05-02, 15 apples and 15 oranges were sold (Difference 15 - 15 = 0).
Day 2020-05-03, 20 apples and 0 oranges were sold (Difference 20 - 0 = 20).
Day 2020-05-04, 15 apples and 16 oranges were sold (Difference 15 - 16 = -1).


solution : 

create table sales (sale_date date, fruit varchar(25), sold_num int);

with t as (select sale_date, fruit, sold_num,
lag(sold_num) over(partition by sale_date order by sale_Date, fruit) apples_sold_num from sales
)
select sale_date,apples_sold_num-sold_num diff from t
where apples_sold_num is not null
order by sale_date

pivot : 

SELECT  sale_date,
        apples-oranges AS  diff
FROM
(
SELECT  sale_date,    
        [apples],[oranges]
FROM Sales  
PIVOT(
   SUM(sold_num) FOR fruit IN([apples],[oranges])
) AS P 
) AS T 

solution 3: 
select s.sale_date, sum(CASE s.fruit WHEN 'oranges' THEN -s.sold_num ELSE s.sold_num END) as diff
from sales s
group by s.sale_date