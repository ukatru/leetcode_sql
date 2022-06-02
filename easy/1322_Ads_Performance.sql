create table ads(ad_id int, user_id int,action VARCHAR(15) not null 
check (action IN('Clicked', 'Viewed', 'Ignored')))

insert into ads values(1,1,'Clicked');
insert into ads values(2,2,'Clicked');
insert into ads values(3,3,'Viewed');
insert into ads values(5,5,'Ignored');
insert into ads values(1,7,'Ignored');
insert into ads values(2,7,'Viewed');
insert into ads values(3,5,'Clicked');
insert into ads values(1,4,'Viewed');
insert into ads values(2,11,'Viewed');
insert into ads values(1,2,'Clicked');

with t1 as (
    select ad_id,
        action,
        count(*) as n_count
    from ads
    group by ad_id,
        action
),
t2 as (
    select ad_id,
        max(
            case
                when action = 'Clicked' then n_count
                else 0
            end
        ) clicked_count,
        max(
            case
                when action = 'Viewed' then n_count
                else 0
            end
        ) viewed_count,
        max(
            case
                when action = 'Ignored' then n_count
                else 0
            end
        ) ignored_count
    from t1
    group by ad_id
)
select ad_id,
case
        when clicked_count > 0 then cast(
            clicked_count * 100.00 /(clicked_count + viewed_count) as decimal(10, 2)
        )
        else 0
    end ctr
from t2
order by ctr desc,
    ad_id asc