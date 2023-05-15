{%- macro if_res(resource=None) -%}
  {%- if resource -%}
    {{resource}}
  {%- else -%}
    "resource"
  {%- endif -%}
{%- endmacro -%}