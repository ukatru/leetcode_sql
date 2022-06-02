Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key for this table.
Each row contains information about the monthly income for one bank account.
 

Write an SQL query to report the number of bank accounts of each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, then report 0.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Accounts table:
+------------+--------+
| account_id | income |
+------------+--------+
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |
+------------+--------+
Output: 
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |
+----------------+----------------+
Explanation: 
Low Salary: Account 2.
Average Salary: No accounts.
High Salary: Accounts 3, 6, and 8.

solution : 

Create table  Accounts_1907 (account_id int, income int)
Truncate table Accounts_1907
insert into Accounts_1907 (account_id, income) values ('3', '108939')
insert into Accounts_1907 (account_id, income) values ('2', '12747')
insert into Accounts_1907 (account_id, income) values ('8', '87709')
insert into Accounts_1907 (account_id, income) values ('6', '91796')


with t1 as (
    select 'High Salary' category
    union
    select 'Low Salary' category
    union
    select 'Average Salary' category
),
t2 as (
    select category,
        count(category) accounts_count
    from (
            select account_id,
                income,
case
                    when income < 20000 then 'Low Salary'
                    when income between 20000 and 50000 then 'Average Salary'
                    when income > 50000 then 'High Salary'
                    else ''
                end category
            from Accounts
        ) b
    group by category
)
select t1.category,
    COALESCE(accounts_count, 0) accounts_count
from t1
    left join t2 on t1.category = t2.category


SELECT
	'Low Salary' AS category, SUM(CASE WHEN income < 20000 THEN  1 ELSE 0 END) AS accounts_count FROM Accounts
UNION ALL
SELECT
	'Average Salary' AS category, SUM(CASE WHEN income >= 20000 AND income <= 50000 THEN 1 ELSE 0 END) AS accounts_count FROM Accounts
UNION ALL
SELECT
	'High Salary' AS category, SUM(CASE WHEN income > 50000 THEN 1 ELSE 0 END) AS accounts_count FROM Accounts

