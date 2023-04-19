{% macro Patient_s(resource, 
                   birthDate=None,
                   name=None
                   ) -%}
(TRUE
{%- if birthDate %}
    AND ({{ resource }} #>>'{birthDate}')::date > '{{ birthDate }}'
{% endif -%}
{%- if name %}
    AND ({{ resource }} #>>'{name}')::text ilike '%{{ name }}%'
{% endif -%}
)
{%- endmacro %}}}