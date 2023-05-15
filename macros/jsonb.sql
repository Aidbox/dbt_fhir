{%- macro get(path,resource=None ) -%}
    ({{if_res(resource)}}#>>'{ {{path}} }')
{%- endmacro -%}