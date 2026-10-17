-- Q(a), full distribution: for each calendar month (all years pooled, based on the
-- date the witness saw her), the sightings falling in each agency region.
with f as (select * from {{ ref('fact_sighting') }})
,d as (select * from {{ ref('dim_date') }})
,ag as (select * from {{ ref('dim_agency') }})
,r as (select * from {{ ref('dim_region') }})

,counts as (
    select
        d.month_of_year       as month_num,
        d.month_name          as month_name,
        r.region_name,
        count(*)              as sightings
    from f
        inner join d  on d.date_skey    = f.witness_date_skey
        inner join ag on ag.agency_skey = f.agency_skey
        inner join r  on r.region_skey  = ag.region_skey
    group by 1, 2, 3
)

select
    month_num,
    month_name,
    region_name,
    sightings
from counts
order by month_num
