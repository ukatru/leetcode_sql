Table: Calls

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| from_id     | int     |
| to_id       | int     |
| duration    | int     |
+-------------+---------+
This table does not have a primary key, it may contain duplicates.
This table contains the duration of a phone call between from_id and to_id.
from_id != to_id
 

Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Calls table:
+---------+-------+----------+
| from_id | to_id | duration |
+---------+-------+----------+
| 1       | 2     | 59       |
| 2       | 1     | 11       |
| 1       | 3     | 20       |
| 3       | 4     | 100      |
| 3       | 4     | 200      |
| 3       | 4     | 200      |
| 4       | 3     | 499      |
+---------+-------+----------+
Output: 
+---------+---------+------------+----------------+
| person1 | person2 | call_count | total_duration |
+---------+---------+------------+----------------+
| 1       | 2       | 2          | 70             |
| 1       | 3       | 1          | 20             |
| 3       | 4       | 4          | 999            |
+---------+---------+------------+----------------+
Explanation: 
Users 1 and 2 had 2 calls and the total duration is 70 (59 + 11).
Users 1 and 3 had 1 call and the total duration is 20.
Users 3 and 4 had 4 calls and the total duration is 999 (100 + 200 + 200 + 499).


# =====================================================================


insert into loginfo values(14, 3, '2021-2-26 01:29:48', '2021-2-26 03:35:08');
insert into loginfo values(8, 1, '2021-2-1 02:26:03', '2021-2-1 10:23:23');
insert into loginfo values(12, 3, '2021-2-25 10:27:35', '2021-2-25 18:52:44');
insert into loginfo values(10, 7, '2021-2-24 10:45:38', '2021-2-24 23:04:45');
insert into loginfo values(10, 8, '2021-2-8 01:51:20', '2021-2-8 07:29:09' );
insert into loginfo values(6, 2, '2021-2-27 12:03:49', '2021-2-27 23:49:56'); 
insert into loginfo values(14, 5, '2021-2-15 01:07:47', '2021-2-15 04:40:51'); 
insert into loginfo values(3, 1, '2021-2-19 03:17:17', '2021-2-19 23:31:48'); 
insert into loginfo values(4, 9, '2021-2-26 08:34:57', '2021-2-26 21:57:07');
insert into loginfo values(10, 1, '2021-2-5 05:59:29', '2021-2-5 12:55:35'); 
insert into loginfo values(3, 9, '2021-2-28 12:57:20', '2021-2-28 15:36:19'); 
insert into loginfo values(11, 3, '2021-2-8 07:06:58', '2021-2-8 22:11:29'); 
insert into loginfo values(8, 5, '2021-2-9 16:29:23', '2021-2-9 16:45:23'); 
insert into loginfo values(6, 2, '2021-2-17 09:31:44', '2021-2-17 23:44:53'); 
insert into loginfo values(2, 6, '2021-2-23 00:42:08', '2021-2-23 01:31:04'); 
insert into loginfo values(1, 2, '2021-2-9 16:15:55', '2021-2-9 22:52:15'); 
insert into loginfo values(3, 7, '2021-2-17 12:51:28', '2021-2-17 21:59:16'); 
insert into loginfo values(14, 3, '2021-2-26 11:44:50', '2021-2-26 12:32:35'); 
insert into loginfo values(14, 2, '2021-2-10 05:16:15', '2021-2-10 13:39:02');
insert into loginfo values(3, 5, '2021-2-11 04:12:00', '2021-2-11 13:48:26'); 
insert into loginfo values(4, 7, '2021-2-18 00:45:22', '2021-2-18 03:25:51');
insert into loginfo values(1, 3, '2021-2-6 11:42:36', '2021-2-6 16:26:37'); 
insert into loginfo values(10, 7, '2021-2-3 01:22:31', '2021-2-3 20:20:18'); 
insert into loginfo values(8, 4, '2021-2-22 17:21:12', '2021-2-22 19:02:42'); 
insert into loginfo values(3, 4, '2021-2-12 10:52:13', '2021-2-12 20:32:36'); 
insert into loginfo values(5, 8, '2021-2-10 09:16:14', '2021-2-10 10:20:51'); 
insert into loginfo values(12, 3, '2021-2-4 09:26:12', '2021-2-4 12:45:08'); 
insert into loginfo values(8, 1, '2021-2-6 00:31:59', '2021-2-6 19:13:24');


SELECT t.account_id,t.ip_address,t.login,t1.login,t1.logout
FROM LogInfo t 
join LogInfo t1
on t.account_id = t1.account_id
and t.ip_address != t1.ip_address