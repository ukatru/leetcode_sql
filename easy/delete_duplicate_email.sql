--create table person (id int, email varchar(100));
select *
from person;
truncate table person;
insert into person
values(1, 'john@example.com');
insert into person
values(2, 'bob@example.com');
insert into person
values(3, 'john@example.com');
select min(id),
    email
from person
group by email;
delete from person
where id not in (
        select id
        from (
                select min(id) as id
                from person
                group by email
            ) a
    )