-- Q(d): per calendar month, P(behavior is one of her three most frequent behaviors from Q(c)).
with f as (select * from {{ ref('fact_sighting') }})
,d as (select * from {{ ref('dim_date') }})
,b as (select * from {{ ref('dim_behavior') }})
,t as (select * from {{ ref('ana_c_top3_behaviors') }})

select
    d.month_of_year                                            as month_num,
    d.month_name                                               as month_name,
    count(*)                                                   as sightings,
    count(*) filter (where t.behavior_name is not null)        as top3_behavior_sightings,
    count(*) filter (where t.behavior_name is not null) * 1.0 / count(*) as probability_top3_behavior
from f
    inner join d on d.date_skey     = f.witness_date_skey
    inner join b on b.behavior_skey = f.behavior_skey
    left join t on t.behavior_name  = b.behavior_name
group by 1, 2
order by 1
