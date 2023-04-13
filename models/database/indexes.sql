 select *
   from pg_indexes
        , pg_relation_size(indexname::regclass) size
  where schemaname = 'public'
