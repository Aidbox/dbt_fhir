 select id id 
        , {{ gender("resource") }}  as gender 
        , {{ age("resource") }}  as age    
        , {{ alive("resource") }} as alive
        , {{ race("resource" )}} as race
        , {{ ethnicity("resource" )}} as ethnicity
   from patient as p