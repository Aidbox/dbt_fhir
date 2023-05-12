select   {{ get('status')}} status
       , {{ cs_code('type', 'SNOMED CT-INT')}} type_code
       , {{ cs_display('type', 'SNOMED CT-INT')}} type_display
       , {{ coding('class') }} class
       , {{ get('period,start') }} start
       , {{ get('period,end') }} end
       , {{ get('subject,id')}} patient_id
       , {{ idf('synthea') }} synthea_id
       , {{ get('period,end') }}::timestamp - {{ get('period,start') }}::timestamp duration
       , {{ idf_from_uri('location,0,location,uri')}} location_synthea_id
       , {{ idf_from_uri('serviceProvider,uri')}} organization_synthea_id
       , {{ idf_from_uri('participant,0,individual,uri')}} practitioner_npi
from {{ ref('Encounter') }}

-- {# TODO: use json path and specify identifier and resource type#}
--      "location": [                                                                                                            +
--          {                                                                                                                    +
--              "location": {                                                                                                    +
--                  "uri": "Location?identifier=https://github.com/synthetichealth/synthea|503cff77-399e-34bf-958e-24eb97922391",+
--                  "display": "HH HEALTH SYSTEM MARSHALL LLC"                                                                   +
--              }                                                                                                                +
--          }                                                                                                                    +
--      ],                                                                                                                       +
--      "participant": [                                                                                                         +
--          {                                                                                                                    +
--              "individual": {                                                                                                  +
--                  "uri": "Practitioner?identifier=http://hl7.org/fhir/sid/us-npi|9999983197",                                  +
--                  "display": "Dr. Anthony Schaden"                                                                             +
--              }                                                                                                                +
--          }                                                                                                                    +
--      ],                                                                                                                       +