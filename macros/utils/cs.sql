{%- macro cs_get_system(alias) -%}
  (SELECT system FROM {{ ref('seed_codesystems') }} WHERE alias = '{{alias}}' limit 1)
{%- endmacro -%}

{%- macro cs_code(path, alias, resource=None) -%}
  (trim('"' FROM (jsonb_path_query_first({{if_res(resource)}}, concat('$.{{path}}.coding ?(@.system=="', {{cs_get_system(alias)}}, '").code')::jsonpath))::text))
{%- endmacro -%}

{%- macro cs_display(path, alias, resource=None) -%}
  (trim('"' FROM (jsonb_path_query_first({{if_res(resource)}}, concat('$.{{path}}.coding ?(@.system=="', {{cs_get_system(alias)}}, '").display')::jsonpath))::text))
{%- endmacro -%}