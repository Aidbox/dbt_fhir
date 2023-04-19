{% macro race(resource) -%}
    {{ extension_first_text("resource", "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race", "extension.valueString") }}
{%- endmacro %}