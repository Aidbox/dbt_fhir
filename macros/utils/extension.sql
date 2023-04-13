{% macro extension(resource, url, path) -%}
   jsonb_path_query_first({{resource}}, '$.extension ? (@.url == "{{url}}").{{path}}') 
{%- endmacro %}