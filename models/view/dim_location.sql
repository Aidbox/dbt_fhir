select    {{ get('name') }}  name
        , {{ get('status') }}  status
        , {{ idf('synthea') }} synthea_id
from {{ ref('Location') }}

--      "identifier": [                                                           +
--          {                                                                     +
--              "value": "75c8f301-c405-3beb-864b-1083e1edf413",                  +
--              "system": "https://github.com/synthetichealth/synthea"            +
--          }                                                                     +
--      ],                                                                        +
--      "address": {                                                              +
--          "city": "LOS ANGELES",                                                +
--          "line": [                                                             +
--              "1110 N WESTERN AVE"                                              +
--          ],                                                                    +
--          "state": "CA",                                                        +
--          "country": "US",                                                      +
--          "postalCode": "900291087"                                             +
--      },                                                                        +
--      "telecom": [                                                              +
--          {                                                                     +
--              "value": "3234636881",                                            +
--              "system": "phone"                                                 +
--          }                                                                     +
--      ],                                                                        +
--      "position": {                                                             +
--          "latitude": 34.0536909,                                               +
--          "longitude": -118.242766                                              +
--      },                                                                        +
--      "managingOrganization": {                                                 +
--          "display": "HOLLYWOOD CROSS MEDICAL CLINIC",                          +
--          "identifier": {                                                       +
--              "value": "17260c93-fcaf-3ccf-815b-0ddb786f5f6d",                  +
--              "system": "https://github.com/synthetichealth/synthea"            +
--          }                                                                     +
--      }                                                                         +
--  }