{%- macro get(path,resource=None ) -%}
    (resource#>>'{ {{path}} }')
{%- endmacro -%}