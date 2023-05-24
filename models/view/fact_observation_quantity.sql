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
       , ({{ get('issued')}}::timestamp) issued
       , ({{ get('effective,dateTime')}}::timestamp) effective
       , {{ get('subject,id')}}::uuid patient_id
       , {{ get('encounter,id')}}::uuid encounter_id 
       , {{ codesystem_code('code', 'loinc')}} code
       , {{ codesystem_display('code', 'loinc')}} code_display
       , {{ codesystem_code('category', 'observation-category')}} category
       , {{ get('value,Quantity,unit')}} unit
       , {{ get('value,Quantity,value')}} value 
  FROM {{ ref('Observation') }}
 WHERE {{ get('value,Quantity')}} is not null

{% if is_incremental() %}
   AND ts > (select max(ts) from {{ this }})
{% endif %}

-- TODO:
--  + value.Quantity
--  - value.CodeableConcept
--  - component