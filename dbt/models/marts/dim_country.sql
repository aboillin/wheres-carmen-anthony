with country as ((select distinct country from {{ ref('int_unioned') }}))

,final as (
    select
        {{ dbt_utils.generate_surrogate_key(['country']) }}     as country_skey,
        country                                                 as country_code
    from country

)

select * from final
