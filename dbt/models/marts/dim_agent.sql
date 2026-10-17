-- Field agents, keyed on name (the only identifier the reports carry).
with agent as (select distinct agent from {{ ref('int_unioned') }})

,final as (
    select
        {{ dbt_utils.generate_surrogate_key(['agent']) }}   as agent_skey,
        agent                                               as agent_name
    from agent
)

select * from final