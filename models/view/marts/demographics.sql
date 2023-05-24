  SELECT   op.year_date as year
         , p.gender
         , p.race
         , p.state
         , p.language_display
         , p.ms_display
         , count(p.id) filter (where p.birth_year    = extract('YEAR' from op.year_date)) as birth
         , count(p.id) filter (where p.deceased_year = extract('YEAR' from op.year_date)) as deceased 
         , (SELECT count(pp.id) 
              FROM {{ ref('dim_patient') }} pp 
             WHERE pp.birthDate < (op.year_date + interval '1 YEAR')
                   AND (pp.deceased is null OR pp.deceased > op.year_date)
                   AND pp.race = p.race AND pp.gender = p.gender AND pp.state = p.state
                   AND pp.ms_display = p.ms_display AND pp.language_display = p.language_display) population
    FROM {{ ref('fact_observable_period') }} as op
    JOIN {{ ref('dim_patient') }} as p
      ON p.birth_year = op.year OR p.deceased_year = op.year
GROUP BY 1, 2, 3, 4, 5, 6