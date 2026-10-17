-- Q(c): the three most frequently observed behaviors (ties at rank 3 would all be returned).
with f as (select * from {{ ref('fact_sighting') }})
, b as (select * from {{ ref('dim_behavior') }})

,counts as (
    select
        b.behavior_name,
        count(*) as sightings
    from f
        inner join b on b.behavior_skey = f.behavior_skey
    group by 1
)

,ranked as (
    select
        behavior_name,
        sightings,
        sightings * 1.0 / sum(sightings) over () as share_of_sightings,
        rank() over (order by sightings desc)    as behavior_rank
    from counts
)

select * from ranked
where behavior_rank <= 3
order by behavior_rank, behavior_name
