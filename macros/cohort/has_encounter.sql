{% macro has_encounter(patient_id, 
                       class=None, classSystem=None, classDisplay=None,
                       reason=None, reasonSystem=None, reasonDisplay=None,
                       lookback=None) -%}
 EXISTS (
  SELECT e.id
    FROM encounter AS e
   WHERE e.resource#>>'{subject, id}' = {{ patient_id }} 
     AND e.resource#>>'{status}' IN ('in-progress', 'finished')
     {% if  (class or classSystem or classDisplay) -%}
        AND {{ coding("e.resource", '$.class', code=class, system=classSystem, display=classDisplay)}} is not null
     {%- endif %}
     {% if  (reason or reasonSystem or reasonDisplay) -%}
        AND {{ coding("e.resource", '$.reasonCode.coding', code=reason, system=reasonSystem, display=reasonDisplay)}} is not null
     {%- endif %}

)
{%- endmacro %}

{# 
- Admission date 
  period.start
- Discharge Dates
  period.end
- Discharge Disposition
hospitalization.dischargeDisposition.coding.code/system/display
 #}