create table npv (id int, year int, npv int);

create table queries(id int, year int);

--NPV table:

insert into npv values(1,2018,100);
insert into npv values(7,2020,30 );
insert into npv values(13,2019,40 );
insert into npv values(1,2019,113);
insert into npv values(2,2008,121);
insert into npv values(3,2009,12 );
insert into npv values(11,2020,99 );
insert into npv values(7,2019,0  );

--Queries table:

insert into queries values(1 ,2019);
insert into queries values(2 ,2008);
insert into queries values(3 ,2009);
insert into queries values(7 ,2018);
insert into queries values(7 ,2019);
insert into queries values(7 ,2020);
insert into queries values(13,2019);

select q.id,q."year",COALESCE(n.npv,0) npv from queries q left join npv n
on q.id = n.id
and q."year" = n."year"