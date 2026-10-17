with region as (select distinct region from {{ ref('int_unioned') }})

, final as (
    select
        {{ dbt_utils.generate_surrogate_key(['region']) }}  as region_skey,
        region                                              as region_name
    from region

)

select * from final

