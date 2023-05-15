{%- macro extension_get_system(alias) -%}
  (SELECT url FROM {{ ref('seed_extension') }} WHERE alias = '{{alias}}' limit 1)
{%- endmacro -%}

{%- macro extension(alias, jpath, resource=None) -%}
   (trim('"' FROM (jsonb_path_query_first({{ if_res(resource) }}, concat('$.extension ? (@.url == "', {{ extension_get_system(alias) }}, '").{{jpath}}')::jsonpath))::TEXT))
{%- endmacro -%}

{# TODO: nested extension #}