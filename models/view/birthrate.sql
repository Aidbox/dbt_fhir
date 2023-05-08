with birth as (
    select extract('YEAR' from date(resource#>>'{birthDate}')) as "year"
       , count(*) as birth
    from patient
    group by 1
), death as (
    select extract('YEAR' from date(resource#>>'{deceased,dateTime}')) as "year"
           , count(*) as death
    from patient
    group by 1
)
select birth.*, death.death
from birth, death
where birth.year = death.year