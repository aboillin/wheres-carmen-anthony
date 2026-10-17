with src as (select * from {{ ref('europe') }})

,final as (
    select
        'EUROPE'                          as region,
        cast(date_witness as date)        as date_witness,
        witness                           as witness,
        agent                             as agent,
        cast(date_filed as date)          as date_agent, --change to normalized name
        region_hq                         as city_agent, --change to normalized name
        country                           as country,
        city                              as city,
        cast(lat_ as double)              as latitude, --change to normalized name
        cast(long_ as double)             as longitude, --change to normalized name
        cast("armed?" as boolean)         as has_weapon, --change to normalized name
        cast("chapeau?" as boolean)       as has_hat, --change to normalized name
        cast("coat?" as boolean)          as has_jacket, --change to normalized name
        observed_action                   as behavior --change to normalized name
    from src
)

select * from final
