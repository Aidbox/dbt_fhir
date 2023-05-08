{%- macro ethnicity(resource=None) -%}
{%- if resource %}
    {{ trim(extension_first_text(resource, "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity", "extension.valueString"))}}
{%- else %}
    {{ trim(extension_first_text("resource", "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity", "extension.valueString"))}}
{%- endif %}

{%- endmacro %}