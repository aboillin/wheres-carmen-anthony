-- AMERICA: already uses the common data dictionary names (except region_hq)
with src as (select * from {{ ref('america') }})

, final as (
    select
        'AMERICA'                         as region,
        cast(date_witness as date)        as date_witness,
        witness                           as witness,
        agent                             as agent,
        cast(date_agent as date)          as date_agent,
        region_hq                         as city_agent, --change to normalized name
        country                           as country,
        city                              as city,
        cast(latitude as double)          as latitude,
        cast(longitude as double)         as longitude,
        cast(has_weapon as boolean)       as has_weapon,
        cast(has_hat as boolean)          as has_hat,
        cast(has_jacket as boolean)       as has_jacket,
        behavior                          as behavior
    from src
)

select * from final