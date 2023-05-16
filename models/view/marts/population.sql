with year_min as (
    select extract('YEAR' from (select min(birthdate) from {{ ref('dim_patient') }})::date) y
), year_max as ( 
    select extract('YEAR' from (select max(birthdate) from {{ ref('dim_patient') }})::date) y
)
select *
from generate_series((select to_date(y::text, 'YYYY') from year_min), (select to_date(y::text, 'YYYY') from year_max), '1 year') as year
     , lateral(
        select count(p.birthDate)
          from {{ ref('dim_patient') }} p
         where p.birthDate <= year
               AND (p.deceased is null OR p.deceased > year)
     ) population

--join {{ ref('dim_patient') }} on