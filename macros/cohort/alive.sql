{% macro alive(resource=None) -%}
{%- if resource %}
    (COALESCE((({{resource}}#>>'{deceased, dateTime}')::timestamp > NOW()),
              (not(({{resource}}#>>'{deceased, boolean}')::boolean)),
              true))
{%- else %}
    (COALESCE(((resource#>>'{deceased, dateTime}')::timestamp > NOW()),
              (not((resource#>>'{deceased, boolean}')::boolean)),
              true))
{%- endif %}
{%- endmacro %}