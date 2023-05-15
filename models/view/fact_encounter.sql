SELECT id
       , {{ get('status')}} status
       , {{ codesystem_code('type', 'SNOMED CT-INT')}} type_code
       , {{ codesystem_display('type', 'SNOMED CT-INT')}} type_display
       , {{ get('class,code') }} class
       , {{ get('period,start') }} start
       , {{ get('period,end') }} end
       , {{ get('subject,id')}} patient_id
       , {{ identifier('synthea') }} synthea_id
       , {{ get('period,end') }}::timestamp - {{ get('period,start') }}::timestamp duration
       , {{ identifier_from_uri('location,0,location,uri')}} location_synthea_id
       , {{ identifier_from_uri('serviceProvider,uri')}} organization_synthea_id
       , {{ identifier_from_uri('participant,0,individual,uri')}} practitioner_npi
  FROM {{ ref('Encounter') }}