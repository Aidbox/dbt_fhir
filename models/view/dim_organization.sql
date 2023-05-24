{{
     config(
          materialized='incremental',
          unique_key='id'
    )
}}

SELECT id
       , ts
       , {{ get('name') }} name
       , {{ get('active') }} active
       , {{ get('address,0,city') }}  city
       , {{ get('address,0,state') }}  state
       , {{ get('address,0,country') }}  country
       , {{ identifier('synthea') }} synthea_id
       , {{ codesystem_code('type', 'organization-type')}} type_code
       , {{ codesystem_display('type', 'organization-type')}} type_display
  FROM {{ ref('Organization') }}

{% if is_incremental() %}
  where ts > (select max(ts) from {{ this }})
{% endif %}