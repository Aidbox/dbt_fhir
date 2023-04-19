select id
       , resource#>>'{birthDate}'
       , resource#>>'{name, 0, given}'
       , {{ Patient_s("resource", 
                      birthDate="1960-01-01", 
                      name="Salva") }}
from patient 
where {{ Patient_s("resource", birthDate="1960-01-01", name="Salva") }}









