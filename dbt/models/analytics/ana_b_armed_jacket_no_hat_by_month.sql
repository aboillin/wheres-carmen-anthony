-- Q(b): P(armed AND jacket AND NOT hat) per calendar month, plus an all-months row,
-- alongside the marginal probabilities of each trait for context.
-- The three flags now live in the junk dimension dim_sighting_profile.
with f as (select * from {{ ref('fact_sighting') }})
, d as (select * from {{ ref('dim_date') }})
, p as (select * from {{ ref('dim_sighting_profile') }})

,by_month as (
    select
        d.month_of_year as month_num,
        d.month_name    as month_name,
        count(*)                                                                  as sightings,
        count(*) filter (where p.has_weapon and p.has_jacket and not p.has_hat)   as armed_jacket_no_hat,
        count(*) filter (where p.has_weapon)                                      as armed,
        count(*) filter (where p.has_jacket)                                      as jacket,
        count(*) filter (where not p.has_hat)                                     as no_hat
    from f
        inner join d on d.date_skey = f.witness_date_skey
        inner join p on p.sighting_profile_skey = f.sighting_profile_skey
    group by 1, 2
)

,overall as (
    select
        null::integer as month_num,
        'All months'  as month_name,
        sum(sightings) as sightings,
        sum(armed_jacket_no_hat) as armed_jacket_no_hat,
        sum(armed) as armed,
        sum(jacket) as jacket,
        sum(no_hat) as no_hat
    from by_month
)

,combined as (
    select * from by_month
    union all
    select * from overall
)

select
    month_num,
    month_name,
    sightings,
    armed_jacket_no_hat,
    armed_jacket_no_hat * 1.0 / sightings as probability_armed_jacket_no_hat,
    armed   * 1.0 / sightings             as probability_armed,
    jacket  * 1.0 / sightings             as probability_jacket,
    no_hat  * 1.0 / sightings             as probability_no_hat
from combined
order by month_num nulls last
