-- Q(a): the single most likely agency region per calendar month.
with rp as (select * from {{ ref('ana_a_region_probability_by_month') }})

,month_rnk as (
    select
        *,
        rank() over (partition by month_num order by sightings desc) as rnk
    from rp
)

select
    month_name,
    region_name as most_likely_region,
    sightings
from month_rnk
where rnk = 1
order by month_num
