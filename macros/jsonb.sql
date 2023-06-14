{%- macro get(path,resource=None ) -%}
    ({{aidbox.if_res(resource)}}#>>'{ {{path}} }')
{%- endmacro -%}