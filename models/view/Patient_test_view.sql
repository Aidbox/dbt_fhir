select 
      date(resource#>>'{birthDate}') as birthDate,
      {{ age() }} as age,
      resource#>>'{name,0,family}' as family,
      trim('"' FROM (jsonb_path_query_first(resource, '$.address.state') )::TEXT) "state"
from patient