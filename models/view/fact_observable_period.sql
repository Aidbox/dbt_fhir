WITH year_min AS (
    select extract('YEAR' from (select min(birthDate) from {{ ref('dim_patient') }})::date) y
), year_max AS ( 
    select extract('YEAR' from (select max(birthDate) from {{ ref('dim_patient') }})::date) y
)
  SELECT   to_date(y::text, 'YYYY') as year_date
         , y as year
    FROM generate_series((select y from year_min), (select y from year_max), 1) as y