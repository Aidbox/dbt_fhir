{% macro age(resource) -%}
    (DATE_PART('year', AGE(({{ resource }} #>>'{birthDate}')::timestamp)))
{%- endmacro %}