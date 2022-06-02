create table products (product_id int,product_name varchar(50), product_category varchar(50))

create table orders (product_id int, order_date date, unit int)

insert into products values(1,'Leetcode Solutions', 'Book');
insert into products values(2,'Jewels of Stringology', 'Book');
insert into products values(3,'Hp', 'Laptop');
insert into products values(4,'Lenovo', 'Laptop');
insert into products values(5,'Leetcode Kit', 'T-shirt');

----------
insert into orders values(1,'2020-02-05',60);
insert into orders values(1,'2020-02-10',70);
insert into orders values(2,'2020-01-18',30);
insert into orders values(2,'2020-02-11',80);
insert into orders values(3,'2020-02-17',2 );
insert into orders values(3,'2020-02-24',3 );
insert into orders values(4,'2020-03-01',20);
insert into orders values(4,'2020-03-04',30);
insert into orders values(4,'2020-03-04',60);
insert into orders values(5,'2020-02-25',50);
insert into orders values(5,'2020-02-27',50);
insert into orders values(5,'2020-03-01',50);

select product_name,
    unit
from products p
    inner join (
        select product_id,
            sum(unit) unit
        from orders
        where MONTH(order_date) = 2
        group by product_id
        having sum(unit) >= 100
    ) o on p.product_id = o.product_id
