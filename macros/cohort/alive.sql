{% macro alive(resource) -%}
    (COALESCE((({{resource}}#>>'{deceased, dateTime}')::timestamp > NOW()),
              (not(({{resource}}#>>'{deceased, boolean}')::boolean)),
              true))
{%- endmacro %}