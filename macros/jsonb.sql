{% macro path(path,resource=none ) -%}
    ({{aidbox.if_res(resource)}}#>>'{ {{path}} }')
{%- endmacro %}

{% macro if_res(resource=None) -%}
  {%- if resource -%}
    {{resource}}
  {%- else -%}
    "resource"
  {%- endif -%}
{%- endmacro %}

{%- macro jsonpath_equal_fn (key, value=None) -%}
    {%- if value is string -%}
        @.{{key}} == "{{ value }}"
    {%- elif value is iterable -%}
        ( {% for v in value -%} @.{{key}} == "{{ v }}" {{"|| " if not loop.last }} {%- endfor %}) 
    {%- endif -%}
{%- endmacro -%}