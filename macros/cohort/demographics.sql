{%- macro age(resource=None) -%}
    DATE_PART('year', AGE(date({{ if_res(resource) }} #>>'{birthDate}')))
{%- endmacro %}

{%- macro gender(resource=None) -%}
    ({{ if_res(resource) }} #>>'{gender}' )
{%- endmacro %}

{%- macro alive(resource=None) -%}
    (COALESCE((({{ if_res(resource) }}#>>'{deceased, dateTime}')::timestamp > NOW()),
              (not(({{ if_res(resource) }}#>>'{deceased, boolean}')::boolean)),
              true))
{%- endmacro -%}

{%- macro race(resource=None) -%}
    {{ extension('us-race', 'extension.valueString', resource) }}
{%- endmacro -%}

{%- macro ethnicity(resource=None) -%}
    {{ extension('us-ethnicity', 'extension.valueString', resource) }}
{%- endmacro %}

{%- macro death(resource=None) -%}
    (COALESCE((({{ if_res(resource) }}#>>'{deceased, dateTime}')::timestamp < NOW()),
              (({{ if_res(resource) }}#>>'{deceased, boolean}')::boolean),
              false))
{%- endmacro -%}


