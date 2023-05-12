select   {{ get('name') }} name
       , {{ get('active') }} active
       , {{ get('address,0,city') }}  city
       , {{ get('address,0,state') }}  state
       , {{ get('address,0,country') }}  country
       , {{ idf('synthea') }} synthea_id
       , {{ coding_code('organization-type', 'type')}} type_code
       , {{ coding_display('organization-type', 'type')}} type_display
from {{ ref('Organization') }}