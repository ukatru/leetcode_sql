Table: Spending

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| spend_date  | date    |
| platform    | enum    | 
| amount      | int     |
+-------------+---------+
The table logs the history of the spending of users that make purchases from an online shopping website that has a desktop and a mobile application.
(user_id, spend_date, platform) is the primary key of this table.
The platform column is an ENUM type of ('desktop', 'mobile').
 

Write an SQL query to find the total number of users and the total amount spent using the mobile only, the desktop only, and both mobile and desktop together for each date.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Spending table:
+---------+------------+----------+--------+
| user_id | spend_date | platform | amount |
+---------+------------+----------+--------+
| 1       | 2019-07-01 | mobile   | 100    |
| 1       | 2019-07-01 | desktop  | 100    |
| 2       | 2019-07-01 | mobile   | 100    |
| 2       | 2019-07-02 | mobile   | 100    |
| 3       | 2019-07-01 | desktop  | 100    |
| 3       | 2019-07-02 | desktop  | 100    |
+---------+------------+----------+--------+
Output: 
+------------+----------+--------------+-------------+
| spend_date | platform | total_amount | total_users |
+------------+----------+--------------+-------------+
| 2019-07-01 | desktop  | 100          | 1           |
| 2019-07-01 | mobile   | 100          | 1           |
| 2019-07-01 | both     | 200          | 1           |
| 2019-07-02 | desktop  | 100          | 1           |
| 2019-07-02 | mobile   | 100          | 1           |
| 2019-07-02 | both     | 0            | 0           |
+------------+----------+--------------+-------------+ 
Explanation: 
On 2019-07-01, user 1 purchased using both desktop and mobile, user 2 purchased using mobile only and user 3 purchased using desktop only.
On 2019-07-02, user 2 purchased using mobile only, user 3 purchased using desktop only and no one purchased using both platforms.


solution :

Create table Spending (user_id int, spend_date date, platform varchar(10), amount int)
Truncate table Spending
insert into Spending (user_id, spend_date, platform, amount) values ('1', '2019-07-01', 'mobile', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('1', '2019-07-01', 'desktop', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('2', '2019-07-01', 'mobile', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('2', '2019-07-02', 'mobile', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('3', '2019-07-01', 'desktop', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('3', '2019-07-02', 'desktop', '100')


solution:

with data as(
select user_id, spend_date, 
    case when mob_amt>0 and desk_amt >0 then 'both' 
    when mob_amt>0 and desk_amt=0 then 'mobile'
    when mob_amt=0 and desk_amt>0 then 'desktop' end as platform, 
    mob_amt+desk_amt as amount from(
        select user_id, spend_date, 
            sum(case when platform='mobile' then amount else 0 end) as mob_amt, 
            sum(case when platform='desktop' then amount else 0 end) as desk_amt
        from spending group by user_id, spend_date)a
),
-- Create full data set for all 3 platforms for each of the date so it can be joined with above raw data to identify which date is not having any transaction for any of the platform
ttl_events as(
    select distinct spend_date, 'desktop' platform from Spending
    union
    select distinct spend_date, 'mobile' platform from Spending
    union
    select distinct spend_date, 'both' platform from Spending
)
select t.spend_date, t.platform, isnull(sum(amount),0) as total_amount, count(user_id) as total_users
from ttl_events t left join data d on t.spend_date=d.spend_date and d.platform=t.platform
group by t.spend_date, t.platform