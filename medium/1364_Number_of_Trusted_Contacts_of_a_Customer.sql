Table: Customers

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| customer_name | varchar |
| email         | varchar |
+---------------+---------+
customer_id is the primary key for this table.
Each row of this table contains the name and the email of a customer of an online shop.
 

Table: Contacts

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | id      |
| contact_name  | varchar |
| contact_email | varchar |
+---------------+---------+
(user_id, contact_email) is the primary key for this table.
Each row of this table contains the name and email of one contact of customer with user_id.
This table contains information about people each customer trust. The contact may or may not exist in the Customers table.
 

Table: Invoices

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| invoice_id   | int     |
| price        | int     |
| user_id      | int     |
+--------------+---------+
invoice_id is the primary key for this table.
Each row of this table indicates that user_id has an invoice with invoice_id and a price.
 

Write an SQL query to find the following for each invoice_id:

customer_name: The name of the customer the invoice is related to.
price: The price of the invoice.
contacts_cnt: The number of contacts related to the customer.
trusted_contacts_cnt: The number of contacts related to the customer and at the same time they are customers to the shop. (i.e their email exists in the Customers table.)
Return the result table ordered by invoice_id.

The query result format is in the following example.

 

Example 1:

Input: 
Customers table:
+-------------+---------------+--------------------+
| customer_id | customer_name | email              |
+-------------+---------------+--------------------+
insert into customers values(1,'Alice','alice@leetcode.com');
insert into customers values(2,'Bob ','bob@leetcode.com');
insert into customers values(1,'John','john@leetcode.com');
insert into customers values(6,'Alex ','alex@leetcode.com');
+-------------+---------------+--------------------+
Contacts table:
+-------------+--------------+--------------------+
| user_id     | contact_name | contact_email      |
+-------------+--------------+--------------------+
insert into contacts values(1,'Bob','bob@leetcode.com');
insert into contacts values(1,'John','john@leetcode.com');
insert into contacts values(1,'Jal','jal@leetcode.com');
insert into contacts values(2,'Omar','omar@leetcode.com');
insert into contacts values(2,'Meir','meir@leetcode.com');
insert into contacts values(6,'Alice','alice@leetcode.com');
+-------------+--------------+--------------------+
Invoices table:
+------------+-------+---------+
| invoice_id | price | user_id |
+------------+-------+---------+
insert into invoices values(77,100,1 );
insert into invoices values(88,200,1 );
insert into invoices values(99,300,2 );
insert into invoices values(66,400,2 );
insert into invoices values(55,500,13);
insert into invoices values(44,60 ,6 );
+------------+-------+---------+
Output: 
+------------+---------------+-------+--------------+----------------------+
| invoice_id | customer_name | price | contacts_cnt | trusted_contacts_cnt |
+------------+---------------+-------+--------------+----------------------+
| 44         | Alex          | 60    | 1            | 1                    |
| 55         | John          | 500   | 0            | 0                    |
| 66         | Bob           | 400   | 2            | 0                    |
| 77         | Alice         | 100   | 3            | 2                    |
| 88         | Alice         | 200   | 3            | 2                    |
| 99         | Bob           | 300   | 2            | 0                    |
+------------+---------------+-------+--------------+----------------------+
Explanation: 
Alice has three contacts, two of them are trusted contacts (Bob and John).
Bob has two contacts, none of them is a trusted contact.
Alex has one contact and it is a trusted contact (Alice).
John doesn't have any contacts.


solution:

create table customers_1364 (customer_id int, customer_name varchar(50),email varchar(50));


create table contacts (user_id int, contact_name varchar(50), contact_email varchar(50));

create table invoices (invoice_id int, price int, user_id int);


with t as (
    select c.customer_name,
        count(cn.contact_name) contacts_cnt,
        COALESCE(cn.user_id, c.customer_id) customer_id
    from customers c
        left join contacts cn on c.customer_id = cn.user_id
    group by c.customer_name,
        cn.user_id,
        customer_id
),
t2 as (
    select invoice_id,
        customer_name,
        price,
        contacts_cnt
    from t
        inner join invoices i on t.customer_id = i.user_id
),
t3 as (
    select c.customer_name customer_name,
        cn.contact_name contact_name,
        COALESCE(cn.user_id, c.customer_id) customer_id
    from customers c
        left join contacts cn on c.customer_id = cn.user_id
),
t4 as (
    select t3.customer_name,
        count(t3.contact_name) trusted_contacts_cnt
    from t3
        inner join customers c on t3.contact_name = c.customer_name
    group by t3.customer_name
)
select invoice_id,
    t2.customer_name,
    price,
    contacts_cnt,
    COALESCE(trusted_contacts_cnt, 0) trusted_contacts_cnt
from t2
    left join t4 on t2.customer_name = t4.customer_name
order by invoice_id
