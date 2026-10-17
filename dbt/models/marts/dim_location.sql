-- A sighting location: a city (with its coordinates) inside a country.
with locations as (select distinct country, city, latitude, longitude from {{ ref('int_unioned') }})

,country as (select * from {{ ref('dim_country') }})

,final as (
    select
        {{ dbt_utils.generate_surrogate_key(['l.country', 'l.city', 'l.latitude', 'l.longitude']) }} as location_skey,
        c.country_skey,
        l.city,
        l.latitude,
        l.longitude
    from locations l
        inner join country c on c.country_code = l.country
)

select * from final

