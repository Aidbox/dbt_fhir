
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

       , {{ get('onset,dateTime')}}::date onset 
       , {{ get('abatement,dateTime')}}::date abatement
       , {{ get('recordedDate')}}::date recorded

       , {{ get('subject,id')}}::uuid patient_id
       , {{ get('encounter,id')}}::uuid encounter_id 

       , {{ codesystem_code('code', 'SNOMED CT-INT')}} code_code
       , {{ codesystem_display('code', 'SNOMED CT-INT')}} code_display 
       , {{ codesystem_code('category', 'condition-category')}} category_code
       , {{ codesystem_display('category', 'condition-category')}} category_display 
       , {{ codesystem_code('clinicalStatus', 'condition-clinical')}} clinical_status
       , {{ codesystem_code('verificationStatus', 'condition-verstatus')}} verification_status

  FROM {{ ref('Condition') }}

{% if is_incremental() %}
 WHERE ts > (select max(ts) from {{ this }})
{% endif %}

-- -------------------------------------------------------------------------------------------
--  {                                                                                        +
--      "onset": {                                                                           +
--          "dateTime": "2004-06-07T09:34:57+00:00"                                          +
--      },                                                                                   +
--      "abatement": {                                                                       +
--          "dateTime": "2005-06-13T10:04:36+00:00"                                          +
--      },                                                                                   +
--      "recordedDate": "2004-06-07T09:34:57+00:00",                                         +
--  }