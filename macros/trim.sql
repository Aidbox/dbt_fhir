{% macro trim(field) -%}
    trim('"' FROM {{ field }}::TEXT)
{%- endmacro %}