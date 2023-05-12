{%- macro idf_get_system(alias) -%}
  (SELECT system FROM {{ ref('seed_identifiers') }} WHERE alias = '{{alias}}' limit 1)
{%- endmacro -%}

{%- macro idf(alias, resource=None) -%}
  (trim('"' FROM (jsonb_path_query_first({{if_res(resource)}}, concat('$.identifier ?(@.system=="', {{idf_get_system(alias)}}, '").value')::jsonpath))::text))
{%- endmacro -%}

{# TODO: use json path and specify identifier and resource type#}
{% macro idf_from_uri(path, resource=None) %}
  (substring ({{if_res(resource)}}#>>'{ {{path}} }' FROM '.+\|(.+)$'))
{% endmacro %}