Table: Signups

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the primary key for this table.
Each row contains information about the signup time for the user with ID user_id.
 

Table: Confirmations

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key for this table.
user_id is a foreign key with a reference to the Signups table.
action is an ENUM of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').
 

Write an SQL query to find the IDs of the users that requested a confirmation message twice within a 24-hour window. Two messages exactly 24 hours apart are considered to be within the window. The action does not affect the answer, only the request time.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Signups table:
+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
insert into signups values(3,'2020-03-21 10:16:13');
insert into signups values(7,'2020-01-04 13:57:59');
insert into signups values(2,'2020-07-29 23:09:44');
insert into signups values(6,'2020-12-09 10:39:37');
+---------+---------------------+
Confirmations table:
+---------+---------------------+-----------+
| user_id | time_stamp          | action    |
+---------+---------------------+-----------+
insert into confirmations values(3,'2021-01-06 03:30:46','timeout');
insert into confirmations values(3,'2021-01-06 03:37:45','timeout');
insert into confirmations values(7,'2021-06-12 11:57:29','confirmed');
insert into confirmations values(7,'2021-06-13 11:57:30','confirmed');
insert into confirmations values(2,'2021-01-22 00:00:00','confirmed');
insert into confirmations values(2,'2021-01-23 00:00:00','timeout');
insert into confirmations values(6,'2021-10-23 14:14:14','confirmed');
insert into confirmations values(6,'2021-10-24 14:14:13','timeout');
+---------+---------------------+-----------+
Output: 
+---------+
| user_id |
+---------+
| 2       |
| 3       |
| 6       |
+---------+
Explanation: 
User 2 requested two messages within exactly 24 hours of each other, so we include them.
User 3 requested two messages within 6 minutes and 59 seconds of each other, so we include them.
User 6 requested two messages within 23 hours, 59 minutes, and 59 seconds of each other, so we include them.
User 7 requested two messages within 24 hours and 1 second of each other, so we exclude them from the answer.


solution:

create table signups (user_id int, time_stamp datetime);

create table confirmations(user_id int, time_stamp datetime, action varchar(15));


select distinct user_id from (select user_id,time_stamp, 
lag(time_stamp) over(partition by user_id order by time_stamp desc) start_timestamp
from confirmations) a
where start_timestamp is not null
and datediff(SECOND, time_stamp,start_timestamp) <= 86400

select distinct c1.user_id from Confirmations c1 
               join Confirmations c2 on c1.user_id = c2.user_id
               and datediff(second, c1.time_stamp, c2.time_stamp) * 1.0 / 3600 <= 24
               and datediff(second, c1.time_stamp, c2.time_stamp) > 0 