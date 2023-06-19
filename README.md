# Aidbox FHIR DBT Package

This dbt package provides useful macros, build in models, and tests for work with [Aidbox FHIR platform](https://aidbox.app).

See [Sample project](https://github.com/Aidbox/dbt-sample-project) for deep dive into analytics on FHIR.

## Installation
```yml
packages:
  - git: "https://github.com/Aidbox/dbt.git"
    warn-unpinned: false
```

## Features
- [FHIR models](#fhir-resources-models) - build in FHIR resources models
- [Utils](#macros) - provide set of useful macros for FHIR data types
- [Cohorts](#cohorts) - supported cohort analyses
- [Tests](#tests) - provide tests for FHIR data types

## FHIR resources models
This package provides models for [all FHIR resources](models/FHIR) of version 4.0.1

Usage example: count of Patients

```sql
  select count(*) 
    from {{ ref('aidbox', 'Patient')}}

-- Expand

  select count(*) 
    from "db"."dbt_fhir"."Patient"
```

## Macros
- [path(path, resource=None)](macros/jsonb.sql) - extract resource value by json path, equivalent of `#>>` operator
```sql
select {{ aidbox.path("name, 0, given, 0") }} as name
  from {{ ref('aidbox', 'Location')}}

-- Expand 

select ("resource"#>>'{ name, 0, given, 0 }') as name
  from "db"."dbt_fhir"."Location"
```

- [identifier(alias, resource=None)](macros/identifier.sql) - extract identifier value for given identifier system alias

```sql
select 
  from {{ ref('aidbox', 'Patient')}}

-- Expand 

select 
  from "db"."dbt_fhir"."Patient"
```
- [extension(alias, jpath, resource=None)](macros/extension.sql) - extract extension value for given extension alias

```sql
select 
  from {{ ref('aidbox', 'Patient')}}

-- Expand 

select 
  from "db"."dbt_fhir"."Patient"
```
- [codesystem_code(path,  resource=None)](macros/codesystem.sql) - extract codesystem code for given system alias
  - `jpath` - path in jsonpath format
  - `alias` - alias value from `seed_codesystems` seed
  - `resource` - optional resource column

>  Require `seed_codesystems` seed with columns `alias` and `system`

```sql
SELECT id
       , {{ aidbox.codesystem_code('type', 'organization-type')}} type_code
  FROM {{ ref('aidbox', 'Organization') }}

-- Expand 

SELECT id
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.type.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'organization-type' limit 1), '").code')::jsonpath))::text)) type_code
  FROM "db"."dbt_fhir"."Organization"
```
- [codesystem_display(jpath, alias, resource=None)](macros/codesystem.sql) - extract codesystem display for given system alias
  - `jpath` - path in jsonpath format
  - `alias` - alias value from `seed_codesystems` seed
  - `resource` - optional resource column

>  Require `seed_codesystems` seed with columns `alias` and `system`

```sql
SELECT id
       , {{ aidbox.codesystem_display('type', 'organization-type')}} type_display
  FROM {{ ref('aidbox', 'Organization') }}

-- Expand 

SELECT id
       , ts
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.type.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'organization-type' limit 1), '").code')::jsonpath))::text)) type_code
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.type.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'organization-type' limit 1), '").display')::jsonpath))::text)) type_display
  FROM "db"."dbt_fhir"."Organization"
```
- [trim(expr)](macros/text.sql) - remove surrounded `"` of string
  - `expr` - sql expression

```sql
select {{ aidbox.trim('s') }} 
  from (select '"Hello"') t(s)

-- Expand 

select trim('"' FROM ( s ) ::TEXT) 
  from (select '"Hello"') t(s)
```
## Cohorts

Based on [Vulcan RWD](https://build.fhir.org/ig/HL7/vulcan-rwd/patients.html)

__Demographics__
- age
- gender
- alive
- death
- race
- ethnicity

__Diagnosis__
- todo

__LabTests__
- todo

__Medications__
- todo

__Procedures__
- todo

__Visits__
- todo

## Tests
- fhir_date
- fhir_uuid


***
Powered by [Health Samurai](http://www.health-samurai.io) | [Aidbox](http://www.health-samurai.io/aidbox) | [Fhirbase](http://www.health-samurai.io/fhirbase)
