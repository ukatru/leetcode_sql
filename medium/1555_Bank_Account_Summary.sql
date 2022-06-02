Table: Users

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| user_id      | int     |
| user_name    | varchar |
| credit       | int     |
+--------------+---------+
user_id is the primary key for this table.
Each row of this table contains the current credit information for each user.
 

Table: Transactions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| trans_id      | int     |
| paid_by       | int     |
| paid_to       | int     |
| amount        | int     |
| transacted_on | date    |
+---------------+---------+
trans_id is the primary key for this table.
Each row of this table contains information about the transaction in the bank.
User with id (paid_by) transfer money to user with id (paid_to).
 

Leetcode Bank (LCB) helps its coders in making virtual payments. Our bank records all transactions in the table Transaction, we want to find out the current balance of all users and check whether they have breached their credit limit (If their current credit is less than 0).

Write an SQL query to report.

user_id,
user_name,
credit, current balance after performing transactions, and
credit_limit_breached, check credit_limit ("Yes" or "No")
Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Users table:
+------------+--------------+-------------+
| user_id    | user_name    | credit      |
+------------+--------------+-------------+
insert into users_1555 values(1,'Moustafa',100  );
insert into users_1555 values(2,'Jonathan',200  );
insert into users_1555 values(3,'Winston',10000);
insert into users_1555 values(4,'Luis',800  ); 
+------------+--------------+-------------+
Transactions table:
+------------+------------+------------+----------+---------------+
| trans_id   | paid_by    | paid_to    | amount   | transacted_on |
+------------+------------+------------+----------+---------------+
insert into transactions values(1,1,3,400,'2020-08-01');
insert into transactions values(2,3,2,500,'2020-08-02');
insert into transactions values(3,2,1,200,'2020-08-03');
+------------+------------+------------+----------+---------------+
Output: 
+------------+------------+------------+-----------------------+
| user_id    | user_name  | credit     | credit_limit_breached |
+------------+------------+------------+-----------------------+
| 1          | Moustafa   | -100       | Yes                   | 
| 2          | Jonathan   | 500        | No                    |
| 3          | Winston    | 9900       | No                    |
| 4          | Luis       | 800        | No                    |
+------------+------------+------------+-----------------------+
Explanation: 
Moustafa paid $400 on "2020-08-01" and received $200 on "2020-08-03", credit (100 -400 +200) = -$100
Jonathan received $500 on "2020-08-02" and paid $200 on "2020-08-08", credit (200 +500 -200) = $500
Winston received $400 on "2020-08-01" and paid $500 on "2020-08-03", credit (10000 +400 -500) = $9990
Luis did not received any transfer, credit = $800

solution: 

create table users_1555 (user_id int, user_name varchar(50), credit int);

create table transactions (trans_id int, paid_by int, paid_to int, amount int, transacted_on date);

{"headers": {"Users": ["user_id", "user_name", "credit"], "Transactions": ["trans_id", "paid_by", "paid_to", "amount", "transacted_on"]}, 
"rows": {"Users": 
insert into users_1555 values(1, 'Winston', 100);
insert into users_1555 values(2, 'Moustafa', 600);
insert into users_1555 values(3, 'Jonathan', 800);
insert into users_1555 values(4, 'Maria', 100);
"Transactions": 
insert into transactions values(1,2,4,1000,'2020-08-28');
insert into transactions values(2,3,2,600, '2020-08-06');
insert into transactions values(3,2,4,800, '2020-08-15'); 
insert into transactions values(4,1,3,800, '2020-09-02');
insert into transactions values(5,3,4,100, '2020-08-02');
insert into transactions values(6,3,4,500, '2020-08-08');
insert into transactions values(7,3,4,800, '2020-09-17');


with t1 as (
    select paid_by,
        sum(COALESCE(amount, 0)) * -1 outgoing_amount
    from users u
        inner join transactions t on u.user_id = t.paid_by
    group by paid_by
),
t2 as (
    select paid_to,
        sum(COALESCE(amount, 0)) as incoming_amount
    from users u
        inner join transactions t on u.user_id = t.paid_to
    group by paid_to
)
select user_id,
    user_name,
    credit + COALESCE(outgoing_amount, 0) + COALESCE(incoming_amount, 0) credit,
    case
        when credit + COALESCE(outgoing_amount, 0) + COALESCE(incoming_amount, 0) < 0 then 'Yes'
        else 'No'
    end credit_limit_breached
from users u
    left join t1 on t1.paid_by = u.user_id
    left join t2 on t2.paid_to = u.user_id