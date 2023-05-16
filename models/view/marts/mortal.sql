  SELECT   op.year_date as year
         , p.gender
         , p.race
         , p.state
         , count(p.id) filter (where p.birth_year    = extract('YEAR' from op.year_date)) as birth
         , count(p.id) filter (where p.deceased_year = extract('YEAR' from op.year_date))  as deceased 
         , (SELECT count(pp.id) 
              FROM {{ ref('dim_patient') }} pp 
             WHERE pp.birthDate < (op.year_date + interval '1 YEAR')
                   AND (pp.deceased is null OR pp.deceased > op.year_date)
                   AND pp.race = p.race AND pp.gender = p.gender AND pp.state = p.state) population
    FROM {{ ref('fact_observable_period') }} as op
    JOIN {{ ref('dim_patient') }} as p
      ON p.birth_year = op.year OR p.deceased_year = op.year
   --WHERE op.year > 2022
GROUP BY 1, 2, 3, 4