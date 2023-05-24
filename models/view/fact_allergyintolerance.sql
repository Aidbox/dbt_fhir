
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
       , {{ get('type')}} type
       , {{ get('criticality')}} criticality
       , {{ get('patient,id')}}::uuid patient_id
       , {{ get('recordedDate')}}::date recorded
       , COALESCE({{ codesystem_code('code', 'SNOMED CT-INT')}}, 
                  {{ codesystem_code('code', 'rxnorm')}})  code_code
       , COALESCE({{ codesystem_display('code', 'SNOMED CT-INT')}}, 
                  {{ codesystem_display('code', 'rxnorm')}})  code_display
       , {{ codesystem_code('clinicalStatus', 'allergyintolerance-clinical')}} clinical_status
       , {{ codesystem_code('verificationStatus', 'allergyintolerance-verstatus')}} verification_status

  FROM {{ ref('AllergyIntolerance') }}

{% if is_incremental() %}
 WHERE ts > (select max(ts) from {{ this }})
{% endif %}

--  {                                                                                                +
--      "category": [                                                                                +
--          "environment"                                                                            +
--      ],                                                                                           +

--      "reaction": [                                                                                +
--          {                                                                                        +
--              "manifestation": [                                                                   +
--                  {                                                                                +
--                      "text": "Allergic skin rash",                                                +
--                      "coding": [                                                                  +
--                          {                                                                        +
--                              "code": "21626009",                                                  +
--                              "system": "http://snomed.info/sct",                                  +
--                              "display": "Allergic skin rash"                                      +
--                          }                                                                        +
--                      ]                                                                            +
--                  }                                                                                +
--              ]                                                                                    +
--          },                                                                                       +
--          {                                                                                        +
--              "manifestation": [                                                                   +
--                  {                                                                                +
--                      "text": "Sneezing",                                                          +
--                      "coding": [                                                                  +
--                          {                                                                        +
--                              "code": "76067001",                                                  +
--                              "system": "http://snomed.info/sct",                                  +
--                              "display": "Sneezing"                                                +
--                          }                                                                        +
--                      ]                                                                            +
--                  }                                                                                +
--              ]                                                                                    +
--          }                                                                                        +
--      ],                                                                                           +
--  }