-- One row per calendar day, covering every year present in the data
-- (reports run 1985-04-23 to 2022-06-29). Used twice by fact_sighting:
-- as the witness date and as the agent filing date (a role-playing dimension).
with days as (select cast(d as date) as date_day from generate_series(date '1985-01-01', date '2022-12-31', interval 1 day) as t(d))

select
    cast(strftime(date_day, '%Y%m%d') as integer) as date_skey,        -- e.g. 19850423
    date_day,
    year(date_day)                                as year,
    quarter(date_day)                             as quarter,
    month(date_day)                               as month_of_year,
    strftime(date_day, '%B')                      as month_name,
    day(date_day)                                 as day_of_month,
    isodow(date_day)                              as day_of_week,    -- ISO: 1 = Monday ... 7 = Sunday
    strftime(date_day, '%A')                      as day_name
from days
