select id,
       --jsonb_path_query_array(resource, '$.class ? (@.code == "EMER" && @.code == "AMB")') ,
       {{ coding("resource", '$.class', 
                    code=['AMB', 'EMER'],
                    system="http://terminology.hl7.org/CodeSystem/v3-ActCode") }}
from encounter
-- 119922aassAsssssaaaaaasssasssssaaaaaaa