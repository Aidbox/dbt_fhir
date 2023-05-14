select  id id
       , {{ get('name') }} name
       , {{ get('active') }} active
       , {{ get('address,0,city') }}  city
       , {{ get('address,0,state') }}  state
       , {{ get('address,0,country') }}  country
       , {{ idf('synthea') }} synthea_id
       , {{ cs_code('type', 'organization-type')}} type_code
       , {{ cs_display('type', 'organization-type')}} type_display
from {{ ref('Organization') }}