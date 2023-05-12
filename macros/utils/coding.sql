{%- macro coding(path, alias=None, resource=None) -%}
{%- if alias -%}
  (SELECT trim('"' FROM (jsonb_path_query_first({{ if_res(resource) }}, concat('$.{{path}} ?(@.system=="', system, '").code')::jsonpath)::text))
     FROM {{ ref('seed_codesystems') }} 
    WHERE alias = '{{alias}}') 
{%- else -%}
   ({{ if_res(resource) }}#>>'{ {{path}},code }')
{%- endif -%}
{%- endmacro -%}