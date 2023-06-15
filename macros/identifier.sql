{% macro identifier_get_system(alias) -%}
  (SELECT system FROM {{ ref('seed_identifiers') }} WHERE alias = '{{alias}}' limit 1)
{%- endmacro %}

{% macro identifier(alias, resource=None) -%}
  (trim('"' FROM (jsonb_path_query_first({{aidbox.if_res(resource)}}, concat('$.identifier ?(@.system=="', {{aidbox.identifier_get_system(alias)}}, '").value')::jsonpath))::text))
{%- endmacro %}

{# TODO: use json path and specify identifier and resource type#}

{% macro identifier_from_uri(path, resource=None) -%}
  (substring ({{aidbox.if_res(resource)}}#>>'{ {{path}} }' FROM '.+\|(.+)$'))
{%- endmacro %}