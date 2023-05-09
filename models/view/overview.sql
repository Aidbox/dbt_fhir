  SELECT fm.*
         , reltuples as rowcounts
    from pg_class c 
    JOIN pg_catalog.pg_namespace n
      ON n.oid = c.relnamespace 
    JOIN {{ ref('fhir_modules') }} as fm
      ON lower(fm.rt) = c.relname
   WHERE relkind='r'
         AND nspname = 'public'
ORDER BY nspname
         , reltuples desc