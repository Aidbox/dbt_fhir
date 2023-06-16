{% macro age(resource=None) -%}
    DATE_PART('year', AGE(date({{ aidbox.if_res(resource) }} #>>'{birthDate}')))
{%- endmacro %}

{%- macro gender(resource=None) -%}
    ({{ aidbox.if_res(resource) }} #>>'{gender}' )
{%- endmacro %}

{%- macro alive(resource=None) -%}
    (COALESCE((({{ aidbox.if_res(resource) }}#>>'{deceased, dateTime}')::timestamp > NOW()),
              (not(({{ aidbox.if_res(resource) }}#>>'{deceased, boolean}')::boolean)),
              true))
{%- endmacro -%}

{% macro race(resource=None) -%}
    {{ aidbox.extension('us-race', 'extension.valueString', resource) }}
{%- endmacro %}

{% macro ethnicity(resource=None) -%}
    {{ aidbox.extension('us-ethnicity', 'extension.valueString', resource) }}
{%- endmacro %}

{% macro death(resource=None) -%}
    (COALESCE((({{ aidbox.if_res(resource) }}#>>'{deceased, dateTime}')::timestamp < NOW()),
              (({{ aidbox.if_res(resource) }}#>>'{deceased, boolean}')::boolean),
              false))
{%- endmacro %}


