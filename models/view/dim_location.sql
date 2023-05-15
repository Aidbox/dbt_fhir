SELECT id
       , {{ get('name') }}  name
       , {{ identifier('synthea', "resource->'managingOrganization'") }} organization_synthea_id
       , {{ identifier('synthea') }} synthea_id
       , {{ get('status') }}  status
       , {{ get('address,city') }} city
       , {{ get('address,state') }}  state
       , {{ get('address,country') }}  country
  FROM {{ ref('Location') }}