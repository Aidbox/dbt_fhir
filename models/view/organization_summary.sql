select {{ trim( "(jsonb_path_query_first(resource, '$.address.state'))")}} "state"
       , count(*)
from {{ ref('Organization') }}       
group by 1