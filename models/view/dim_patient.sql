  SELECT id
         , {{ age() }} age
         , {{ identifier('synthea') }} synthea_id
         , {{ identifier('ssn') }} ssn
         , {{ identifier('mrn') }} mrn
         , {{ gender() }} gender
         , {{ alive() }} alive
         , {{ race() }} race
         , {{ ethnicity() }} ethnicity
         , {{ extension('us-birthsex', 'valueCode') }} birthsex
         , {{ get('birthDate') }} birthdate
         , {{ get('address,0,state') }} state 
         , {{ codesystem_code('maritalStatus', 'MaritalStatus') }} ms_code
         , {{ codesystem_display('maritalStatus', 'MaritalStatus') }} ms_display
         , {{ codesystem_code('communication.language', 'language') }} language_code
         , {{ codesystem_display('communication.language', 'language') }} language_display
    FROM {{ ref('Patient') }}

-- TODO: Full human name