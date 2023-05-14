  SELECT   {{ ref('dim_organization') }}.name organization
         , {{ ref('dim_organization') }}.id organization_id
         , {{ ref('dim_location') }}.name location_name
         , {{ ref('dim_location') }}.state state
         , {{ ref('fact_encounter') }}.class class
         , {{ ref('fact_encounter') }}.type_code type_code
         , {{ ref('fact_encounter') }}.type_display type_display
         , date_trunc('month', date ({{ ref('fact_encounter') }}.start)) date
         , avg({{ ref('fact_encounter') }}.duration) duration
         , count(*)
    FROM {{ ref('fact_encounter') }}
    JOIN {{ ref('dim_organization') }} on {{ ref('fact_encounter') }}.organization_synthea_id = {{ ref('dim_organization') }}.synthea_id
    JOIN {{ ref('dim_location') }}     on {{ ref('fact_encounter') }}.location_synthea_id = {{ ref('dim_location') }}.synthea_id
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8