select    id id
        , {{ idf('npi')}} npi
        , {{ get('active') }} active
        , {{ get('gender') }} gender
        , {{ get('address,0,state') }} state
        , {{ get('address,0,country') }} country
        , {{ get('address,0,city') }} city
from {{ ref('Practitioner') }}