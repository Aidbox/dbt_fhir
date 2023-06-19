{% macro trim(expr) -%}
    trim('"' FROM ( {{ expr }} ) ::TEXT)
{%- endmacro %}