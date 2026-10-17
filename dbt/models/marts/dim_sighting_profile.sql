-- Junk dimension: the three low-cardinality yes/no observations about the perpetrator
-- (armed? hat? jacket?) collapsed into one small table of every possible combination.
-- 2 x 2 x 2 = 8 rows, built as a full cross join (not just the combinations seen in the
-- data) so the keys never change when the data does.
with flags as (select unnest([false, true]) as flag)

,final as (
    select
        {{ dbt_utils.generate_surrogate_key(['w.flag', 'h.flag', 'j.flag']) }}  as sighting_profile_skey,
        w.flag                                                                  as has_weapon,
        h.flag                                                                  as has_hat,
        j.flag                                                                  as has_jacket,
        concat_ws(', ',
            case when w.flag then 'armed'      else 'unarmed'      end,
            case when h.flag then 'hat'        else 'no hat'       end,
            case when j.flag then 'jacket'     else 'no jacket'    end
    )                                                                           as profile_description
    from flags w
    cross join flags h
    cross join flags j

)

select * from final
