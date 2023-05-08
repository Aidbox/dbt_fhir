{%- macro race(resource=None) %}
{%- if resource %}
    {{ trim(extension_first_text(resource, "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race", "extension.valueString")) }}
{%- else %}
    {{ trim(extension_first_text("resource", "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race", "extension.valueString")) }}
{%- endif %}
{%- endmacro %}