create table students (student_id int,
student_name varchar(50));

create table subjects (subject_name varchar(50));

create table examinations (student_id int,
subject_name varchar(50));

insert into students values(1,'Alice');
insert into students values(2,'Bob');
insert into students values(13,'John');
insert into students values(6,'Alex');

select * from students;

insert into subjects values('Math');
insert into subjects values('Physics');
insert into subjects values('Programming');

select * from subjects;

insert into examinations values(1, 'Math');
insert into examinations values(1, 'Physics');
insert into examinations values(1, 'Programming');
insert into examinations values(2, 'Programming');
insert into examinations values(1, 'Physics');
insert into examinations values(1, 'Math');
insert into examinations values(13, 'Math');
insert into examinations values(13, 'Programming');
insert into examinations values(13, 'Physics');
insert into examinations values(2, 'Math');
insert into examinations values(1, 'Math');

select * from examinations;

select * from students;


with cte_students as (
    select s.student_id,
        s.student_name,
        se.subject_name
    from students s,
        subjects se
),
cte_students2 as (
    select student_id,
        subject_name,
        count(*) as attended_exams
    from examinations
    group by student_id,
        subject_name
)
select t1.student_id,
    t1.student_name,
    t1.subject_name,
    COALESCE(t2.attended_exams, 0) as attended_exams
from cte_students t1
    left join cte_students2 t2 on t1.student_id = t2.student_id
    and t1.subject_name = t2.subject_name
order by 1,
    3