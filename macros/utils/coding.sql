{% macro coding(resource, jsonpath, code=None, system=None, display=None) -%}
    jsonb_path_query_array({{resource}}, '{{ jsonpath }} ? (
        {{- jsonpath_equal_fn('system', system) -}}
        {{- " && " if (system and (code or display)) -}}
        {{- jsonpath_equal_fn('code', code) -}}
        {{- " && " if ((code or system) and display) -}}
        {{- jsonpath_equal_fn('display', display) -}} 
        )')
{%- endmacro %}}}

{%- macro coding_code(alias, path, resource=None) -%}
     (SELECT trim('"' FROM (jsonb_path_query_first({{ resource if resource else "resource" }}, concat('$.{{path}}.coding ?(@.system=="', system, '").code')::jsonpath)::text))
       FROM {{ ref('seed_codesystems') }} 
      WHERE alias = '{{alias}}') 
{%- endmacro -%}

{%- macro coding_display(alias, path, resource=None) -%}
     (SELECT trim('"' FROM (jsonb_path_query_first({{ resource if resource else "resource" }}, concat('$.{{path}}.coding ?(@.system=="', system, '").display')::jsonpath)::text))
       FROM {{ ref('seed_codesystems') }} 
      WHERE alias = '{{alias}}') 
{%- endmacro -%}