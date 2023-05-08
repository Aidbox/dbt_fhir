{% macro gender(resource=None) -%}
{%- if resource %}
    ({{ resource }} #>>'{gender}')
{%- else %}
    (resource #>>'{gender}')
{%- endif %}
{%- endmacro %}}}