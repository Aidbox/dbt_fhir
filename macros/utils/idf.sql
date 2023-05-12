{%- macro idf(alias, resource=None) -%}
    (SELECT trim('"' FROM (jsonb_path_query_first({{ resource if resource else "resource" }}, concat('$.identifier ?(@.system=="', system, '").value')::jsonpath)::text))
       FROM {{ ref('seed_identifiers') }} 
      WHERE alias = '{{alias}}')
{%- endmacro -%}