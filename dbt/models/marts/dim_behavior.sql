with behavior as (select distinct behavior from {{ ref('int_unioned') }})

,final as (
    select
        {{ dbt_utils.generate_surrogate_key(['behavior']) }}    as behavior_skey,
        behavior                                                as behavior_name
    from behavior
)

select * from final