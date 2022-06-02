create table users(id int, name varchar(50));

create table Rides(id int, user_id int, distance int);


insert into users values(1 ,'Alice');
insert into users values(2 ,'Bob')
insert into users values(3 ,'Alex')
insert into users values(4 ,'Donald';
insert into users values(7 ,'Lee')
insert into users values(13,'Jonatha');
insert into users values(19,'Elvis');

--Rides table:

insert into rides values(1,1 ,120);
insert into rides values(2,2 ,317);
insert into rides values(3,3 ,222);
insert into rides values(4,7 ,100);
insert into rides values(5,13,312);
insert into rides values(6,19,50);
insert into rides values(7,7 ,120);
insert into rides values(8,19,400);
insert into rides values(9,7 ,230);

select name, coalesce(sum(distance),0) travelled_distance  from users u left join rides r
on u.id = r.user_id
group by name
order by travelled_distance desc, name asc