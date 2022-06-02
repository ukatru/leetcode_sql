Table: Accounts

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key for this table.
This table contains the account id and the user name of each account.
 

Table: Logins

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| login_date    | date    |
+---------------+---------+
There is no primary key for this table, it may contain duplicates.
This table contains the account id of the user who logged in and the login date. A user may log in multiple times in the day.
 

Active users are those who logged in to their accounts for five or more consecutive days.

Write an SQL query to find the id and the name of active users.

Return the result table ordered by id.

The query result format is in the following example.

 

Example 1:

Input: 
Accounts table:
+----+----------+
| id | name     |
+----+----------+
insert into accounts values(1,'Winston');
insert into accounts values(7,'Jonathan');
| 7  | Jonathan |
+----+----------+
Logins table:
+----+------------+
| id | login_date |
+----+------------+
insert into logins values(7,'2020-05-30');
insert into logins values(1,'2020-05-30');
insert into logins values(7,'2020-05-31');
insert into logins values(7,'2020-06-01');
insert into logins values(7,'2020-06-02');
insert into logins values(7,'2020-06-02');
insert into logins values(7,'2020-06-03');
insert into logins values(1,'2020-06-07');
insert into logins values(7,'2020-06-10');
+----+------------+
Output: 
+----+----------+
| id | name     |
+----+----------+
| 7  | Jonathan |
+----+----------+
Explanation: 
User Winston with id = 1 logged in 2 times only in 2 different days, so, Winston is not an active user.
User Jonathan with id = 7 logged in 7 times in 6 different days, five of them were consecutive days, so, Jonathan is an active user.


solution : 

create table account (id int, name varchar(50));

create table logins (id int, login_date date);

SELECT DISTINCT tbl.id, a.name
FROM
(SELECT id, datediff(day,lag(login_date,4) over(partition by id order by login_date),login_date) as diff
FROM logins
GROUP BY id,login_date) as tbl
LEFT JOIN accounts as a
ON a.id = tbl.id
WHERE diff = 4