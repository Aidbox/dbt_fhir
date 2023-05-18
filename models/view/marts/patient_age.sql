  SELECT   age
         , count(id)
    FROM {{ ref('dim_patient') }}
   WHERE alive
         AND age is not null
GROUP BY 1
