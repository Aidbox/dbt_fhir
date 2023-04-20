{% macro ethnicity(resource) -%}
    {{ extension_first_text(resource, "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity", "extension.valueString")}}
{%- endmacro %}