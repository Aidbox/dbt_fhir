{%- macro test_fhir_date(column_name, model) -%}
    select id 
      from {{model}}  
     where {{column_name}} NOT SIMILAR TO  '([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)(-(0[1-9]|1[0-2])(-(0[1-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)(\.[0-9]{1,9})?)?)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)?)?)?'
{%- endmacro -%}

{%- macro test_fhir_uuid(column_name, model) -%}
    select id 
      from {{model}}  
     where {{column_name}} NOT SIMILAR TO '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'
{%- endmacro -%}