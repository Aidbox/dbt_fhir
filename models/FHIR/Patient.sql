 select id id
        , resource#>>'{gender}' gender 
        , (resource#>>'{birthDate}')::date birthDate
   from patient
