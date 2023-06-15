{% macro codesystem_get_system(alias) -%}
  (SELECT system FROM {{ ref('seed_codesystems') }} WHERE alias = '{{alias}}' limit 1)
{%- endmacro %}

{% macro codesystem_text(jpath,  resource=None) -%}
  (trim('"' FROM (jsonb_path_query_first({{aidbox.if_res(resource)}}, '$.{{jpath}}.text'))::text))
{%- endmacro %}

{% macro codesystem_code(jpath, alias, resource=None) -%}
  (trim('"' FROM (jsonb_path_query_first({{aidbox.if_res(resource)}}, concat('$.{{jpath}}.coding ?(@.system=="', {{aidbox.codesystem_get_system(alias)}}, '").code')::jsonpath))::text))
{%- endmacro %}

{% macro codesystem_display(jpath, alias, resource=None) -%}
  (trim('"' FROM (jsonb_path_query_first({{aidbox.if_res(resource)}}, concat('$.{{jpath}}.coding ?(@.system=="', {{aidbox.codesystem_get_system(alias)}}, '").display')::jsonpath))::text))
{%- endmacro %}