create table sessions (session_id int, duration int);

Sessions table:
+-------------+---------------+
| session_id  | duration      |
+-------------+---------------+
insert into sessions values(1,30  );
insert into sessions values(2,199 );
insert into sessions values(3,299 );
insert into sessions values(4,580 );
insert into sessions values(5,1000);
+-------------+---------------+

select bin, count(*) total from (select case when duration < 300 then '[0-5>'
when duration >= 300 and duration <= 599 then '[5-10>'
when duration >= 600 and  duration <= 899  then '[10-15>'
else '15 or more ' end as bin, session_id
from sessions) a
group by bin

select  sum(case when duration < 300 then 1 end),
sum(case when duration >= 300 and duration <= 599 then 1  end),
sum(case when duration >= 600 and  duration <= 899  then 1 end),
sum(case when duration >= 900  then  1 end)
from sessions
group by session_id

with a as (select sum(case when duration* 1.0/ 60 < 5 then 1 end)  as bin1,
sum(case when duration * 1.0/ 60 >= 5 and duration * 1.0/ 60 < 10 then 1 end) as bin2,
sum(case when duration * 1.0/ 60 >= 10 and duration * 1.0/ 60 < 15 then 1 end)  as bin3,
sum(case when duration * 1.0/ 60  >= 15 then 1 end) as bin4
from Sessions)


select '[0-5>' as BIN, ISNULL(bin1,0) as TOTAL from a 
union all
select '[5-10>', ISNULL(bin2,0) from a 
union all
select '[10-15>', ISNULL(bin3,0) from a
union all
select '15 or more', ISNULL(bin4,0) from a

select case when duration* 1.0/ 60 < 5 then 1 end  as bin1,
case when duration * 1.0/ 60 >= 5 and duration * 1.0/ 60 < 10 then 1 end as bin2,
case when duration * 1.0/ 60 >= 10 and duration * 1.0/ 60 < 15 then 1 end  as bin3,
case when duration * 1.0/ 60  >= 15 then 1 end as bin4
from Sessions