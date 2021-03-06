Table: Contests

+--------------+------+
| Column Name  | Type |
+--------------+------+
| contest_id   | int  |
| gold_medal   | int  |
| silver_medal | int  |
| bronze_medal | int  |
+--------------+------+
contest_id is the primary key for this table.
This table contains the LeetCode contest ID and the user IDs of the gold, silver, and bronze medalists.
It is guaranteed that any consecutive contests have consecutive IDs and that no ID is skipped.
 

Table: Users

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| mail        | varchar |
| name        | varchar |
+-------------+---------+
user_id is the primary key for this table.
This table contains information about the users.
 

Write an SQL query to report the name and the mail of all interview candidates. A user is an interview candidate if at least one of these two conditions is true:

The user won any medal in three or more consecutive contests.
The user won the gold medal in three or more different contests (not necessarily consecutive).
Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Contests table:
+------------+------------+--------------+--------------+
| contest_id | gold_medal | silver_medal | bronze_medal |
+------------+------------+--------------+--------------+
| 190        | 1          | 5            | 2            |
| 191        | 2          | 3            | 5            |
| 192        | 5          | 2            | 3            |
| 193        | 1          | 3            | 5            |
| 194        | 4          | 5            | 2            |
| 195        | 4          | 2            | 1            |
| 196        | 1          | 5            | 2            |
+------------+------------+--------------+--------------+
Users table:
+---------+--------------------+-------+
| user_id | mail               | name  |
+---------+--------------------+-------+
| 1       | sarah@leetcode.com | Sarah |
| 2       | bob@leetcode.com   | Bob   |
| 3       | alice@leetcode.com | Alice |
| 4       | hercy@leetcode.com | Hercy |
| 5       | quarz@leetcode.com | Quarz |
+---------+--------------------+-------+
Output: 
+-------+--------------------+
| name  | mail               |
+-------+--------------------+
| Sarah | sarah@leetcode.com |
| Bob   | bob@leetcode.com   |
| Alice | alice@leetcode.com |
| Quarz | quarz@leetcode.com |
+-------+--------------------+
Explanation: 
Sarah won 3 gold medals (190, 193, and 196), so we include her in the result table.
Bob won a medal in 3 consecutive contests (190, 191, and 192), so we include him in the result table.
    - Note that he also won a medal in 3 other consecutive contests (194, 195, and 196).
Alice won a medal in 3 consecutive contests (191, 192, and 193), so we include her in the result table.
Quarz won a medal in 5 consecutive contests (190, 191, 192, 193, and 194), so we include them in the result table.
 

Follow up:

What if the first condition changed to be "any medal in n or more consecutive contests"? How would you change your solution to get the interview candidates? Imagine that n is the parameter of a stored procedure.
Some users may not participate in every contest but still perform well in the ones they do. How would you change your solution to only consider contests where the user was a participant? Suppose the registered users for each contest are given in another table.



solution :

Create table  Contests (contest_id int, gold_medal int, silver_medal int, bronze_medal int)
Create table  Users_1811 (user_id int, mail varchar(50), name varchar(30))
Truncate table Contests
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('190', '1', '5', '2')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('191', '2', '3', '5')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('192', '5', '2', '3')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('193', '1', '3', '5')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('194', '4', '5', '2')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('195', '4', '2', '1')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('196', '1', '5', '2')
Truncate table Users_1811
insert into Users_1811 (user_id, mail, name) values ('1', 'sarah@leetcode.com', 'Sarah')
insert into Users_1811 (user_id, mail, name) values ('2', 'bob@leetcode.com', 'Bob')
insert into Users_1811 (user_id, mail, name) values ('3', 'alice@leetcode.com', 'Alice')
insert into Users_1811 (user_id, mail, name) values ('4', 'hercy@leetcode.com', 'Hercy')
insert into Users_1811 (user_id, mail, name) values ('5', 'quarz@leetcode.com', 'Quarz')


with t1 as (
    select home_team_id,
        count(home_team_id) matches_played,
        sum(home_team_goals) goal_for
    from (
            select home_team_id,
                home_team_goals
            from matches
            union all
            select away_team_id,
                away_team_goals
            from matches
        ) a
    group by home_team_id
),
t2 as (
    select home_team_id,
        sum(away_team_goals) goal_against
    from (
            select home_team_id,
                away_team_goals
            from Matches
            union all
            select away_team_id,
                home_team_goals
            from matches
        ) b
    group by home_team_id
),
t3 as (
    select home_team_id,
        sum(points) points
    from (
            select home_team_id,
                case
                    when home_team_goals > away_team_goals then 3
                    when home_team_goals = away_team_goals then 1
                    else 0
                end points
            from matches
            union all
            select away_team_id,
                case
                    when away_team_goals > home_team_goals then 3
                    when away_team_goals = home_team_goals then 1
                    else 0
                end points
            from matches
        ) c
    group by home_team_id
)
select team_name,
    matches_played,
    points,
    goal_for,
    goal_against,
    goal_for - goal_against goal_diff
from t1
    inner join t2 on t1.home_team_id = t2.home_team_id
    inner join t3 on t1.home_team_id = t3.home_team_id
    inner join teams t on t.team_id = t1.home_team_id
order by points desc,
    goal_diff desc


with ids as (select distinct id from (select contest_id, id, contest_id + row_number() over(partition by id order by contest_id desc) rn from 
(select contest_id, gold_medal id
from Contests 
union 
select contest_id, silver_medal id
from Contests 
union 
select contest_id, bronze_medal id
from Contests ) as c) as sub_t
group by id, rn
having count(distinct contest_id) > 2

union

select gold_medal id
from Contests 
group by gold_medal
having count(distinct contest_id) > 2
             )


select distinct name,mail from ids join Users on Users.user_id = ids.id