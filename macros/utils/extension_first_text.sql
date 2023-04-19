{% macro extension_first_text(resource, url, path) -%}
    ( jsonb_path_query_first({{resource}}, '$.extension ? (@.url == "{{url}}").{{path}}') )::TEXT
{%- endmacro %}