{% macro gender(resource) -%}
    ({{ resource }} #>>'{gender}')
{%- endmacro %}}}