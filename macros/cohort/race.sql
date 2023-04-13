{% macro race(resource) -%}
    {{ extension("resource", "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race", "extension.valueString")}}
{%- endmacro %}