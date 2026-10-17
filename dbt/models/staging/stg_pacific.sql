with src as (select * from {{ ref('pacific') }})

,final as (
    select
        'PACIFIC'                         as region,
        cast(sight_on as date)            as date_witness, --change to normalized name
        sighter                           as witness, --change to normalized name
        filer                             as agent, --change to normalized name
        cast(file_on as date)             as date_agent, --change to normalized name
        report_office                     as city_agent, --change to normalized name
        nation                            as country, --change to normalized name
        town                              as city, --change to normalized name
        cast(lat as double)               as latitude, --change to normalized name
        cast(long as double)              as longitude, --change to normalized name
        cast(has_weapon as boolean)       as has_weapon,
        cast(has_hat as boolean)          as has_hat,
        cast(has_jacket as boolean)       as has_jacket,
        behavior                          as behavior
    from src

)

select * from final
