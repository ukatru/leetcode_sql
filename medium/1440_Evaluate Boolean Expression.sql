Table Variables:

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| name          | varchar |
| value         | int     |
+---------------+---------+
name is the primary key for this table.
This table contains the stored variables and their values.
 

Table Expressions:

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| left_operand  | varchar |
| operator      | enum    |
| right_operand | varchar |
+---------------+---------+
(left_operand, operator, right_operand) is the primary key for this table.
This table contains a boolean expression that should be evaluated.
operator is an enum that takes one of the values ('<', '>', '=')
The values of left_operand and right_operand are guaranteed to be in the Variables table.
 

Write an SQL query to evaluate the boolean expressions in Expressions table.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Variables table:
+------+-------+
| name | value |
+------+-------+
insert into variables values(x,66);
insert into variables values(y,77);
+------+-------+
Expressions table:
+--------------+----------+---------------+
| left_operand | operator | right_operand |
+--------------+----------+---------------+
insert into expressions values('x','>','y');
insert into expressions values('x','<','y');
insert into expressions values('x','=','y');
insert into expressions values('y','>','x');
insert into expressions values('y','<','x');
insert into expressions values('x','=','x');
+--------------+----------+---------------+
Output: 
+--------------+----------+---------------+-------+
| left_operand | operator | right_operand | value |
+--------------+----------+---------------+-------+
| x            | >        | y             | false |
| x            | <        | y             | true  |
| x            | =        | y             | false |
| y            | >        | x             | true  |
| y            | <        | x             | false |
| x            | =        | x             | true  |
+--------------+----------+---------------+-------+
Explanation: 
As shown, you need to find the value of each boolean expression in the table using the variables table.


solution :

create table variables(name varchar(1), value int);

create table expressions (left_operand  varchar(1), operator varchar(2), right_operand varchar(1));

with t as (
    select value as left_operand,
        left_operand as left_operand_orig,
        operator,
        right_operand as right_operand_orig,
        right_operand
    from expressions e
        inner join variables v on v.name = e.left_operand
),
t1 as (
    select left_operand,
        left_operand_orig,
        operator,
        value as right_operand,
        right_operand_orig
    from t
        inner join variables v on t.right_operand = v.name
)
select left_operand_orig as left_operand,
    operator,
    right_operand_orig as right_operand,
    case
        when operator = '='
        and left_operand = right_operand then 'true'
        when operator = '>'
        and left_operand > right_operand then 'true'
        when operator = '<'
        and left_operand < right_operand then 'true'
        else 'false'
    end value
from t1