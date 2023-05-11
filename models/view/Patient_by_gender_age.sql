select   {{ age() }} age
       , {{ gender() }} gender
       , {{ alive() }} alive
       , {{ race() }} race
       , {{ ethnicity() }} ethnicity
       , {{ trim( "(jsonb_path_query_first(resource, '$.address.state'))")}} "state"
       , count(*)
from {{ ref('Patient') }}
group by 1, 2, 3, 4, 5, 6