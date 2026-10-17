-- Witnesses, keyed on name (the only identifier the reports carry).
with witness as (select distinct witness from {{ ref('int_unioned') }})

,final as (
    select
        {{ dbt_utils.generate_surrogate_key(['witness']) }}     as witness_skey,
        witness                                                 as witness_name
    from witness
)


select * from final
