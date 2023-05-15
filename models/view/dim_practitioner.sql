SELECT id
       , {{ identifier('npi')}} npi
       , {{ get('active') }} active
       , {{ get('gender') }} gender
       , {{ get('address,0,state') }} state
       , {{ get('address,0,country') }} country
       , {{ get('address,0,city') }} city
  FROM {{ ref('Practitioner') }}