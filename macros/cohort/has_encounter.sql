{% macro has_encounter(
  patient_id, 
  class=None, classSystem=None, classDisplay=None,
  reason=None, reasonSystem=None, reasonDisplay=None,
  discharge=None, dischargeSystem=None, dischargeDisplay=None,
  admissionDate=None, admissionLookBack=None,
  dischargeDate=None, dischargeLookBack=None
) -%}
 EXISTS (
  SELECT e.id
    FROM encounter AS e
   WHERE e.resource#>>'{subject, id}' = {{ patient_id }} 
     AND e.resource#>>'{status}' IN ('in-progress', 'finished')
     AND date(e.resource#>>'{period,start}') <= NOW() 
    {%- if admissionDate %} 
     AND date(e.resource#>>'{period,start}') >= '{{ admissionDate }}'
    {%- endif %}
    {%- if admissionLookBack %} 
     AND date(e.resource#>>'{period,start}') >= (NOW() - INTERVAL '{{ admissionLookBack }}')
    {%- endif %}
    {%- if dischargeDate %} 
     AND date(e.resource#>>'{period,end}') >= '{{ dischargeDate }}'
    {%- endif %}       
    {%- if dischargeLookBack %} 
     AND date(e.resource#>>'{period,end}') >= (NOW() - INTERVAL '{{ dischargeLookBack }}')
    {%- endif %}
     {% if  (class or classSystem or classDisplay) -%}
        AND {{ coding("e.resource", '$.class', code=class, system=classSystem, display=classDisplay)}} is not null
     {%- endif %}
     {% if  (reason or reasonSystem or reasonDisplay) -%}
        AND {{ coding("e.resource", '$.reasonCode.coding', code=reason, system=reasonSystem, display=reasonDisplay)}} is not null
     {%- endif %}
     {% if  (discharge or dischargeSystem or dischargeDisplay) -%}
        AND {{ coding("e.resource", '$.hospitalization.dischargeDisposition.coding', code=discharge, system=dischargeSystem, display=dischargeDisplay)}} is not null
     {%- endif %}

)
{%- endmacro %}

{# 
- Admission date 
  period.start
- Discharge Dates
  period.end
 #}