with unioned as (
    select * from {{ ref('stg_europe') }}
    union all select * from {{ ref('stg_asia') }}
    union all select * from {{ ref('stg_africa') }}
    union all select * from {{ ref('stg_america') }}
    union all select * from {{ ref('stg_australia') }}
    union all select * from {{ ref('stg_atlantic') }}
    union all select * from {{ ref('stg_indian') }}
    union all select * from {{ ref('stg_pacific') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['region',
                                        'date_witness',
                                        'witness',
                                        'agent',
                                        'date_agent',
                                        'city_agent',
                                        'country',
                                        'city',
                                        'latitude',
                                        'longitude',
                                        'has_weapon',
                                        'has_hat',
                                        'has_jacket',
                                        'behavior']) }} as sighting_id,
    *
from unioned