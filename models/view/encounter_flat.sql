select   {{ get('status')}} status
       , {{ get('subject,id')}} patient_id
       , {{ get('period,start') }} start
       , {{ get('period,end') }} end
       , {{ get('type,0,coding,0,code') }} type
       , {{ get('type,0,coding,0,display') }} type_display
       , {{ get('class,code') }} class
       , {{ get('period,end') }}::timestamp - {{ get('period,start') }}::timestamp duration
from {{ ref('Encounter') }}