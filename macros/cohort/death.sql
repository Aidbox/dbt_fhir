{% macro death(resource) -%}
{%- if resource %}
    (COALESCE((({{resource}}#>>'{deceased, dateTime}')::timestamp < NOW()),
              (({{resource}}#>>'{deceased, boolean}')::boolean),
              false))
{%- else %}
    (COALESCE(((resource#>>'{deceased, dateTime}')::timestamp < NOW()),
              ((resource#>>'{deceased, boolean}')::boolean),
              false))
{%- endif %}
{%- endmacro %}