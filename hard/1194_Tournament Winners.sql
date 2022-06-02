Table: players_1194

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| player_id   | int   |
| group_id    | int   |
+-------------+-------+
player_id is the primary key of this table.
Each row of this table indicates the group of each player.
Table: matches_1194

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| match_id      | int     |
| first_player  | int     |
| second_player | int     | 
| first_score   | int     |
| second_score  | int     |
+---------------+---------+
match_id is the primary key of this table.
Each row is a record of a match, first_player and second_player contain the player_id of each match.
first_score and second_score contain the number of points of the first_player and second_player respectively.
You may assume that, in each match, players_1194 belong to the same group.
 

The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, the lowest player_id wins.

Write an SQL query to find the winner in each group.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
players_1194 table:
+-----------+------------+
| player_id | group_id   |
+-----------+------------+
| 15        | 1          |
| 25        | 1          |
| 30        | 1          |
| 45        | 1          |
| 10        | 2          |
| 35        | 2          |
| 50        | 2          |
| 20        | 3          |
| 40        | 3          |
+-----------+------------+
matches_1194 table:
+------------+--------------+---------------+-------------+--------------+
| match_id   | first_player | second_player | first_score | second_score |
+------------+--------------+---------------+-------------+--------------+
| 1          | 15           | 45            | 3           | 0            |
| 2          | 30           | 25            | 1           | 2            |
| 3          | 30           | 15            | 2           | 0            |
| 4          | 40           | 20            | 5           | 2            |
| 5          | 35           | 50            | 1           | 1            |
+------------+--------------+---------------+-------------+--------------+
Output: 
+-----------+------------+
| group_id  | player_id  |
+-----------+------------+ 
| 1         | 15         |
| 2         | 35         |
| 3         | 40         |
+-----------+------------+

solution:



Create table  players_1194 (player_id int, group_id int)
Create table  matches_1194 (match_id int, first_player int, second_player int, first_score int, second_score int)
Truncate table players_1194
insert into players_1194 (player_id, group_id) values ('10', '2')
insert into players_1194 (player_id, group_id) values ('15', '1')
insert into players_1194 (player_id, group_id) values ('20', '3')
insert into players_1194 (player_id, group_id) values ('25', '1')
insert into players_1194 (player_id, group_id) values ('30', '1')
insert into players_1194 (player_id, group_id) values ('35', '2')
insert into players_1194 (player_id, group_id) values ('40', '3')
insert into players_1194 (player_id, group_id) values ('45', '1')
insert into players_1194 (player_id, group_id) values ('50', '2')
Truncate table matches_1194
insert into matches_1194 (match_id, first_player, second_player, first_score, second_score) values ('1', '15', '45', '3', '0')
insert into matches_1194 (match_id, first_player, second_player, first_score, second_score) values ('2', '30', '25', '1', '2')
insert into matches_1194 (match_id, first_player, second_player, first_score, second_score) values ('3', '30', '15', '2', '0')
insert into matches_1194 (match_id, first_player, second_player, first_score, second_score) values ('4', '40', '20', '5', '2')
insert into matches_1194 (match_id, first_player, second_player, first_score, second_score) values ('5', '35', '50', '1', '1')

with a as (
          SELECT first_player player_id, first_score score from Matches
          union all
          SELECT second_player player_id, second_score score from Matches
    )
    
,b as (
    select  group_id, 
            p.player_id,
            dense_rank() over (partition by group_id order by sum(ISNULL(a.score,0)) desc , p.player_id) rn
            from Players p 
            inner join a on p.player_id = a.player_id 
            group by group_id,p.player_id
)
      select group_id, player_id from b
      where rn = 1


with t as (select match_id,first_player player,first_score score from matches
union all
select match_id,second_player player,second_score score from matches),
t1 as (select group_id,t.player,sum(t.score) score from players p inner join t 
on t.player = p.player_id
group by group_id,t.player),
t2 as (
select player as player_id,group_id,dense_rank() over(partition by group_id order by score desc) rnk,score from t1)
select group_id, min(player_id) player_id from t2
where rnk = 1
group by group_id