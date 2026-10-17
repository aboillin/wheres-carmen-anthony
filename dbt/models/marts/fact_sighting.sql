-- Grain: one row per field-agent report of a Carmen Sandiego sighting.
-- Only keys, dates and the three observed attributes live here; everything
-- descriptive is resolved through the dimension tables.
with sighting as (select * from {{ ref('int_unioned') }})

,region as (select * from {{ ref('dim_region') }})

,agency as (select * from {{ ref('dim_agency') }})

,agent as (select * from {{ ref('dim_agent') }})

,witness as (select * from {{ ref('dim_witness') }})

,behavior as (select * from {{ ref('dim_behavior') }})

,country as (select * from {{ ref('dim_country') }})

,location as (select * from {{ ref('dim_location') }})

,sighting_profile as (select * from {{ ref('dim_sighting_profile') }})

,final as (
        select
        s.sighting_id as sighting_skey,
        cast(strftime(s.date_witness, '%Y%m%d') as integer) as witness_date_skey,   -- FK to dim_date: day the witness saw her
        cast(strftime(s.date_agent,   '%Y%m%d') as integer) as agent_date_skey,     -- FK to dim_date: day the agent filed
        w.witness_skey,
        a.agent_skey,
        ag.agency_skey,
        l.location_skey,
        b.behavior_skey,
        p.sighting_profile_skey
    from sighting s
        inner join region r on r.region_name   = s.region
        inner join agency ag on ag.region_skey    = r.region_skey and ag.hq_city = s.city_agent
        inner join agent a on a.agent_name    = s.agent
        inner join witness w on w.witness_name  = s.witness
        inner join behavior b on b.behavior_name = s.behavior
        inner join sighting_profile p on p.has_weapon    = s.has_weapon
                                    and p.has_hat       = s.has_hat
                                    and p.has_jacket    = s.has_jacket
        inner join country c  on c.country_code  = s.country
        inner join location l on l.country_skey    = c.country_skey
                                and l.city          = s.city
                                and l.latitude      = s.latitude
                                and l.longitude     = s.longitude
)

select * from final