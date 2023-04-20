{% macro coding(resource, jsonpath, code=None, system=None, display=None) -%}
    jsonb_path_query_array({{resource}}, '{{ jsonpath }} ? (
        {{- jsonpath_equal_fn('system', system) -}}
        {{- " && " if (system and (code or display)) -}}
        {{- jsonpath_equal_fn('code', code) -}}
        {{- " && " if ((code or system) and display) -}}
        {{- jsonpath_equal_fn('display', display) -}} 
        )')
{%- endmacro %}}}:where