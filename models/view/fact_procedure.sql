{{
     config(
          materialized='incremental',
          unique_key='id',
          indexes=[{'columns': ['id']},
                   {'columns': ['ts']}]
    )
}}

SELECT   id::uuid
       , ts
       , {{ get('status')}} status
       , {{ get('subject,id')}}::uuid patient_id
       , {{ get('encounter,id')}}::uuid encounter_id 
       , {{ get('performed,Period,start')}}::date start 
       , {{ identifier_from_uri('location,uri')}} location_synthea_id
       , {{ codesystem_code('code', 'SNOMED CT-INT')}} type_code
       , {{ codesystem_display('code', 'SNOMED CT-INT')}} type_display
       , {{ get('performed,Period,end') }}::timestamp - {{ get('performed,Period,start') }}::timestamp duration
  FROM {{ ref('Procedure') }}

{% if is_incremental() %}
 WHERE ts > (select max(ts) from {{ this }})
{% endif %}