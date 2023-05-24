{% macro has_encounter(
  patient_id, 
  class=None,         classSystem=None,     classDisplay=None,
  reason=None,        reasonSystem=None,    reasonDisplay=None,
  discharge=None,     dischargeSystem=None, dischargeDisplay=None,
  admissionDate=None, admissionLookBack=None,
  dischargeDate=None, dischargeLookBack=None
) -%}
 EXISTS (
  SELECT e.id
    FROM {{ ref('Encounter') }} AS e
   WHERE e.resource#>>'{subject, id}' = {{ patient_id }} 
     AND e.resource#>>'{status}' IN ('in-progress', 'finished')
     AND date(e.resource#>>'{period,start}') <= NOW() 
     {%- if class -%}
      AND {{ get('class,code', "e.resource") }} = '{{class}}'
     {%- endif -%}
)
{%- endmacro %}