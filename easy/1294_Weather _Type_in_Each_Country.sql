create table Countries (country_id int, country_name  varchar(50));

create table weather (country_id int, weather_state int, day date);

insert into countries values(2,'USA');
insert into countries values(3,'Australia');
insert into countries values(7,'Peru');
insert into countries values(5,'China');
insert into countries values(8,'Morocco');
insert into countries values(9,'Spain');


insert into weather values(2,15,'2019-11-01')
insert into weather values(2,12,'2019-10-28');
insert into weather values(2,12,'2019-10-27');
insert into weather values(3,-2,'2019-11-10');
insert into weather values(3,0,'2019-11-11');
insert into weather values(3,3,'2019-11-12');
insert into weather values(5,16,'2019-11-07');
insert into weather values(5,18,'2019-11-09');
insert into weather values(5,21,'2019-11-23');
insert into weather values(7,25,'2019-11-28');
insert into weather values(7,22,'2019-12-01');
insert into weather values(7,20,'2019-12-02');
insert into weather values(8,25,'2019-11-05');
insert into weather values(8,27,'2019-11-15');
insert into weather values(8,31,'2019-11-25');
insert into weather values(9,7,'2019-10-23');
insert into weather values(9,3,'2019-12-23');

select c.country_name,
    case
        when CAST(AVG(w.weather_state * 1.0) AS DECIMAL(10, 3)) >= 25 then 'Hot'
        when CAST(AVG(w.weather_state * 1.0) AS DECIMAL(10, 3)) <= 15 then 'Cold'
        else 'Warm'
    end weather_type
from countries c,
    weather w
where c.country_id = w.country_id
    and MONTH(day) = 11
group by c.country_name

--faster
select country_name, 
case when weather_type >= 25 then 'Hot' when  weather_type <= 15 then 'Cold'
else 'Warm' end 
weather_type from (
select c.country_name, 
CAST(AVG(w.weather_state*1.0) AS DECIMAL(10,3)) 
weather_type from countries c, weather w
where c.country_id = w.country_id
and MONTH(day) = 11
group by c.country_name)
a