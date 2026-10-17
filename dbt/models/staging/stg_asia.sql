-- ASIA: mixed English / Chinese headers (报道 = report, 纬度 = latitude, 经度 = longitude)
with src as (select * from {{ ref('asia') }})

,final as (
    select
        'ASIA'                            as region,
        cast(sighting as date)            as date_witness, --change to normalized name
        citizen                           as witness, --change to normalized name
        officer                           as agent,
        cast("报道" as date)               as date_agent,--change to normalized name
        city_interpol                     as city_agent,--change to normalized name
        nation                            as country,--change to normalized name
        city                              as city,
        cast("纬度" as double)             as latitude,--change to normalized name
        cast("经度" as double)             as longitude,--change to normalized name
        cast(has_weapon as boolean)       as has_weapon,
        cast(has_hat as boolean)          as has_hat,
        cast(has_jacket as boolean)       as has_jacket,
        behavior                          as behavior
    from src

)

select * from final
