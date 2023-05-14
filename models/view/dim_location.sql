select    {{ get('name') }}  name
        , {{ get('status') }}  status
        , {{ idf('synthea') }} synthea_id
        , {{ get('address,city') }} city
        , {{ get('address,state') }}  state
        , {{ get('address,country') }}  country
        , {{ idf('synthea', "resource->'managingOrganization'") }} organization_synthea_id
from {{ ref('Location') }}