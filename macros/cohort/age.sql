{% macro age(resource=None) -%}
{%- if resource %}
    DATE_PART('year', AGE(date({{ resource }} #>>'{birthDate}')))
{%- else %}
    DATE_PART('year', AGE(date("resource" #>>'{birthDate}')))
{%- endif %}
{%- endmacro %}