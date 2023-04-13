{% macro death(resource) -%}
    (COALESCE((({{resource}}#>>'{deceased, dateTime}')::timestamp < NOW()),
              (({{resource}}#>>'{deceased, boolean}')::boolean),
              false))
{%- endmacro %}