 select p.id id 
        , {{ gender("p.resource") }}  as gender 
        , {{ age("p.resource") }}  as age    
        , {{ alive("p.resource") }} as alive
        , {{ race("p.resource" )}} as race
        , {{ ethnicity("p.resource" )}} as ethnicity     
   from patient as p
   where {{ has_encounter("p.id", 
                          class=['AMB', 'EMER', 'AMI'], classSystem='snomed', classDisplay='foo',
                          reason='74400008', reasonDisplay='Appendicitis',
                          admissionDate='2020-01-01',
                          dischargeDate='2020-01-01',
                          admissionLookBack='2 year',
                          dischargeLookBack='2 year'
                          ) }}