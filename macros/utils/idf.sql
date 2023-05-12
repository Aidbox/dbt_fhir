{%- macro idf(alias, resource=None) -%}
    (select jsonb_path_query_first(resource, concat('$.identifier ?(@.system=="', system, '").value')::jsonpath)
     from {{ ref('seed_identifiers') }} where alias = '{{alias}}')
{%- endmacro -%}