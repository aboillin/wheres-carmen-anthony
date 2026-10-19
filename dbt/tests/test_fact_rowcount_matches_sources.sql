-- No report may be lost or duplicated on the way from the eight seeds to the fact table.
with expected as (
    select
        (select count(*) from {{ ref('europe') }})
      + (select count(*) from {{ ref('asia') }})
      + (select count(*) from {{ ref('africa') }})
      + (select count(*) from {{ ref('america') }})
      + (select count(*) from {{ ref('australia') }})
      + (select count(*) from {{ ref('atlantic') }})
      + (select count(*) from {{ ref('indian') }})
      + (select count(*) from {{ ref('pacific') }}) as n
)

,actual as (select count(*) as n from {{ ref('fact_sighting') }})

select e.n as expected_rows, a.n as actual_rows
from expected e, actual a
where e.n <> a.n
