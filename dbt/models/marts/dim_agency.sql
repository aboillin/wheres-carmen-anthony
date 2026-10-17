-- One Interpol agency HQ per (region, HQ city); each agency belongs to exactly one region.
with agencies as (select distinct region, city_agent from {{ ref('int_unioned') }})

,region as (select * from {{ ref('dim_region') }})

,final as (
    select
        {{ dbt_utils.generate_surrogate_key(['a.region', 'a.city_agent']) }}    as agency_skey,
        r.region_skey,
        a.city_agent                                                            as hq_city
    from agencies a
        inner join region r on r.region_name = a.region
)

select * from final