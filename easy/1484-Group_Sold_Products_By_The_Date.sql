create table activities (sell_date date, product varchar(50));

Input: 
Activities table:
+------------+------------+
| sell_date  | product     |
+------------+------------+
| 2020-05-30 | Headphone  |
| 2020-06-01 | Pencil     |
| 2020-06-02 | Mask       |
| 2020-05-30 | Basketball |
| 2020-06-01 | Bible      |
| 2020-06-02 | Mask       |
| 2020-05-30 | T-Shirt    |
+------------+------------+
Output: 
+------------+----------+------------------------------+
| sell_date  | num_sold | products                     |
+------------+----------+------------------------------+
| 2020-05-30 | 3        | Basketball,Headphone,T-shirt |
| 2020-06-01 | 2        | Bible,Pencil                 |
| 2020-06-02 | 1        | Mask                         |
+------------+----------+------------------------------+



insert into activities values('2020-05-30','Headphone');
insert into activities values('2020-06-01','Pencil');
insert into activities values('2020-06-02','Mask');
insert into activities values('2020-05-30','Basketball');
insert into activities values('2020-06-01','Bible');
insert into activities values('2020-06-02','Mask');
insert into activities values('2020-05-30','T-Shirt');


Explanation: 
For 2020-05-30, Sold items were (Headphone, Basketball, T-shirt), we sort them lexicographically and separate them by a comma.
For 2020-06-01, Sold items were (Pencil, Bible), we sort them lexicographically and separate them by a comma.
For 2020-06-02, the Sold item is (Mask), we just return it.

solution :

with t1 as (
    select sell_date,
        count(*) num_sold
    from (
            select distinct sell_date,
                product
            from activities
        ) a
    group by sell_date
),
t2 as (
    select a.sell_date,
        STRING_AGG(product, ',') WITHIN GROUP (
            ORDER BY product
        ) AS products
    from (
            select distinct sell_date,
                product
            from activities
        ) a
        inner join t1 on a.sell_date = t1.sell_date
    group by a.sell_date
)
select t1.sell_date,
    t1.num_sold,
    t2.products
from t1
    inner join t2 on t1.sell_date = t2.sell_date


