select {{ trim( "(jsonb_path_query_first(resource, '$.address.state'))")}} "state"
       , count(*)
from {{ ref('Practitioner') }}
group by 1