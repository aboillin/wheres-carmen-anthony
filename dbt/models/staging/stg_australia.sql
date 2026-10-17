with src as (select * from {{ ref('australia') }})

,final as (
    select
        'AUSTRALIA'                       as region,
        cast(witnessed as date)           as date_witness, --change to normalized name
        observer                          as witness, --change to normalized name
        field_chap                        as agent, --change to normalized name
        cast(reported as date)            as date_agent, --change to normalized name
        interpol_spot                     as city_agent, --change to normalized name
        nation                            as country, --change to normalized name
        place                             as city, --change to normalized name
        cast(lat as double)               as latitude, --change to normalized name
        cast(long as double)              as longitude, --change to normalized name
        cast(has_weapon as boolean)       as has_weapon,
        cast(has_hat as boolean)          as has_hat,
        cast(has_jacket as boolean)       as has_jacket,
        state_of_mind                     as behavior --change to normalized name
    from src

)

select * from final
