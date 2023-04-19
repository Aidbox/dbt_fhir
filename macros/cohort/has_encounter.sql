{% macro has_encounter(patient_id, reason=None, class=None, lookback=None) -%}
 EXISTS (
  SELECT e.id
    FROM encounter AS e
   WHERE e.resource#>>'{subject, id}' = {{ patient_id }} 
     AND e.resource#>>'{status}'  IN ('in-progress', 'finished')
)
{%- endmacro %}

{# 
- Reason for Visit
- Class
- Admission and Discharge Dates
- Discharge Disposition
 #}