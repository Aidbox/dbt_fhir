select   {{ age() }} age
       , {{ gender() }} gender
       , {{ alive() }} alive
       , {{ race() }} race
       , {{ ethnicity() }} ethnicity
       , {{ trim( "(jsonb_path_query_first(resource, '$.address.state'))")}} "state"
       , {{ trim( "(jsonb_path_query_first(resource, '$.address.country'))")}} country
from {{ ref('Patient') }}