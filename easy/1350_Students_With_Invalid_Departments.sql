create table departments (id int, name varchar(50));

create table students_1350 (id int, name varchar(50), department_id int);

insert into departments values(1 ,'Electrical Engineering');
insert into departments values(7 ,'Computer Engineering')''
insert into departments values(13,'Bussiness Administration');

insert into students_1350 values(23,'Alice',1);
insert into students_1350 values(1,'Bob',7);
insert into students_1350 values(5,'Jennifer',13);
insert into students_1350 values(2,'John',14);
insert into students_1350 values(4,'Jasmine',77);
insert into students_1350 values(3,'Steve',74);
insert into students_1350 values(6,'Luis',1);
insert into students_1350 values(8,'Jonathan',7);
insert into students_1350 values(7,'Daiana',33);
insert into students_1350 values(11,'Madelynn',1);

select * from students_1350 where department_id not in (select id from departments)

