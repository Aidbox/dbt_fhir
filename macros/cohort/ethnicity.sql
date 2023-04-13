{% macro ethnicity(resource) -%}
    {{ extension("resource", "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity", "extension.valueString")}}
{%- endmacro %}