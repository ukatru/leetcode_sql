Table: Student

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
+-------------+---------+
There is no primary key for this table. It may contain duplicate rows.
Each row of this table indicates the name of a student and the continent they came from.
 

A school has students from Asia, Europe, and America.

Write an SQL query to pivot the continent column in the Student table so that each name is sorted alphabetically and displayed underneath its corresponding continent. The output headers should be America, Asia, and Europe, respectively.

The test cases are generated so that the student number from America is not less than either Asia or Europe.

The query result format is in the following example.

 

Example 1:

Input: 
Student table:
+--------+-----------+
| name   | continent |
+--------+-----------+
| Jane   | America   |
| Pascal | Europe    |
| Xi     | Asia      |
| Jack   | America   |
+--------+-----------+
Output: 
+---------+------+--------+
| America | Asia | Europe |
+---------+------+--------+
| Jack    | Xi   | Pascal |
| Jane    | null | null   |
+---------+------+--------+
 

Follow up: If it is unknown which continent has the most students, could you write a query to generate the student report?

solution:

Create table  Student (name varchar(50), continent varchar(7))
Truncate table Student
insert into Student (name, continent) values ('Jane', 'America')
insert into Student (name, continent) values ('Pascal', 'Europe')
insert into Student (name, continent) values ('Xi', 'Asia')
insert into Student (name, continent) values ('Jack', 'America')


with america as (
    select ROW_NUMBER() over(
            order by name
        ) rownum,
        name as america
    from student
    where continent = 'America'
),
europe as (
    select ROW_NUMBER() over(
            order by name
        ) rownum,
        name as europe
    from student
    where continent = 'Europe'
),
asia as (
    select ROW_NUMBER() over(
            order by name
        ) rownum,
        name as asia
    from student
    where continent = 'Asia'
)
select a.america America,
    asia Asia,
    Europe
from america a
    left join europe e on a.rownum = e.rownum
    left join asia ae on a.rownum = ae.rownum