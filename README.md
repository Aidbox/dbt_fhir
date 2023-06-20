# Aidbox FHIR DBT package

This dbt package provides useful macros, build in models, and tests for work with [Aidbox FHIR platform](https://aidbox.app). Only PostgreSQL datasource supported.

See [Sample project](https://github.com/Aidbox/dbt-sample-project) for deep dive into analytics on FHIR.

## Installation
```yml
packages:
  - git: "Aidbox/dbt_fhir"
    version: 0.1.0
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
###  [path(path, resource=None)](macros/jsonb.sql) 
Extract resource value by json path, equivalent of `#>>` operator
- `path` - comma separated path of the value like `"name, 0, given, 0"`
- `resource` - optional resource column

```sql
select {{ aidbox.path("name, 0, given, 0") }} as name
  from {{ ref('aidbox', 'Location')}}

-- Expand 

select ("resource"#>>'{ name, 0, given, 0 }') as name
  from "db"."dbt_fhir"."Location"
```

###  [identifier(alias, resource=None)](macros/identifier.sql)
Extract identifier value for given identifier system alias
- `alias` - human readable  identifier alias from `seed_identifiers` seed
- `resource` - optional resource column

>  Require `seed_identifiers` seed with columns `alias` and `system`
>
>__seed/seed_identifiers.csv__
>```csv
>alias,system
>npi,http://hl7.org/fhir/sid/us-npi
>ssn,http://hl7.org/fhir/sid/us-ssn
>mrn,http://hospital.smarthealthit.org
>```

```sql
  SELECT id
         , {{ aidbox.identifier('ssn') }} ssn
         , {{ aidbox.identifier('mrn') }} mrn
    FROM {{ ref('aidbox', 'Patient') }}

-- Expand 

  SELECT   id
         , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.identifier ?(@.system=="', (SELECT system FROM "db"."dbt"."seed_identifiers" WHERE alias = 'ssn' limit 1), '").value')::jsonpath))::text)) ssn
         , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.identifier ?(@.system=="', (SELECT system FROM "db"."dbt"."seed_identifiers" WHERE alias = 'mrn' limit 1), '").value')::jsonpath))::text)) mrn
    FROM "db"."dbt_fhir"."Patient" 

```
### [extension(alias, jpath, resource=None)](macros/extension.sql)
Extract extension value for given extension alias
- `alias` - human readable identifier alias from `seed_extension` seed
- `jpath` - path of extension value inside extension  in jsonpath format
- `resource` - optional resource column

>  Require `seed_extension` seed with columns `alias` and `url`
>
>__seed/seed_extension.csv__
>```csv
>alias,url
>us-race,http://hl7.org/fhir/us/core/StructureDefinition/us-core-race
>us-ethnicity,http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity
>us-birthsex,http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex
>```

```sql
select  {{ aidbox.extension('us-race', 'extension.valueString') }}
  from {{ ref('aidbox', 'Patient')}}

-- Expand 

select  (trim('"' FROM (jsonb_path_query_first("resource", concat('$.extension ? (@.url == "', (SELECT url FROM "db"."dbt"."seed_extension" WHERE alias = 'us-race' limit 1), '").extension.valueString')::jsonpath))::TEXT))
from "db"."dbt_fhir"."Patient"
```
###  [codesystem_code(path,  resource=None)](macros/codesystem.sql)
Extract codesystem code for given system alias
- `jpath` - path in jsonpath format
- `alias` - human readable alias value from `seed_codesystems` seed
- `resource` - optional resource column

>  Require `seed_codesystems` seed with columns `alias` and `system`
>
>__seed/seed_codesystems.csv__
>```csv
>alias,system
>organization-type,http://terminology.hl7.org/CodeSystem/organization-type
>SNOMED CT-INT,http://snomed.info/sct
>ActCode,http://terminology.hl7.org/CodeSystem/v3-ActCode
>language,urn:ietf:bcp:47
>MaritalStatus,http://terminology.hl7.org/CodeSystem/v3-MaritalStatus
>loinc,http://loinc.org
>```

```sql
SELECT id
       , {{ aidbox.codesystem_code('type', 'organization-type')}} type_code
  FROM {{ ref('aidbox', 'Organization') }}

-- Expand 

SELECT id
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.type.coding ?(@.system=="', (SELECT system FROM "db"."dbt"."seed_codesystems" WHERE alias = 'organization-type' limit 1), '").code')::jsonpath))::text)) type_code
  FROM "db"."dbt_fhir"."Organization"
```
### [codesystem_display(jpath, alias, resource=None)](macros/codesystem.sql)
Extract codesystem display for given system alias
- `jpath` - path in jsonpath format
- `alias` - human readable alias value from `seed_codesystems` seed
- `resource` - optional resource column

>  Require `seed_codesystems` seed with columns `alias` and `system`

```sql
SELECT id
       , {{ aidbox.codesystem_display('type', 'organization-type')}} type_display
  FROM {{ ref('aidbox', 'Organization') }}

-- Expand 

SELECT id
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.type.coding ?(@.system=="', (SELECT system FROM "db"."dbt"."seed_codesystems" WHERE alias = 'organization-type' limit 1), '").display')::jsonpath))::text)) type_display
  FROM "db"."dbt_fhir"."Organization"
```

### [trim(expr)](macros/text.sql)
Remove surrounded `".."` of string
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

### Demographics
- [age(resource=None)](macros/cohort/demographics.sql) - Get Patient age
- [gender(resource=None)](macros/cohort/demographics.sql) - Get Patient Gender
- [alive(resource=None)](macros/cohort/demographics.sql) - Get Patient alive status
- [death(resource=None)](macros/cohort/demographics.sql) - Get Patient death status
- [race(resource=None)](macros/cohort/demographics.sql) - Get Patient US core IG race
- [ethnicity(resource=None)](macros/cohort/demographics.sql) - Get Patient US core IG ethnicity

> `resource` argument is optional. If not passed,  `resource` expression will be used.
>
> You can directly specify resource column, for example, in JOIN statements

__Example:__
```sql
  SELECT   id
         , {{ aidbox.age() }} age
         , {{ aidbox.identifier('ssn') }} ssn
         , {{ aidbox.identifier('mrn') }} mrn
         , {{ aidbox.gender() }} gender
         , {{ aidbox.alive() }} alive
         , {{ aidbox.race() }} race
         , {{ aidbox.ethnicity() }} ethnicity
         , {{ aidbox.extension('us-birthsex', 'valueCode') }} birthsex
         , {{ aidbox.path('birthDate') }}::date birthdate
         , extract('YEAR' from {{ aidbox.path('birthDate') }}::date) birth_year
         , {{ aidbox.path('deceased,dateTime') }}::date deceased 
         , extract('YEAR' from {{ aidbox.path('deceased,dateTime') }}::date) deceased_year
         , {{ aidbox.path('address,0,state') }} state 
         , {{ aidbox.codesystem_code('maritalStatus', 'MaritalStatus') }} ms_code
         , {{ aidbox.codesystem_display('maritalStatus', 'MaritalStatus') }} ms_display
         , {{ aidbox.codesystem_code('communication.language', 'language') }} language_code
         , {{ aidbox.codesystem_display('communication.language', 'language') }} language_display
    FROM {{ ref('aidbox', 'Patient') }}
```

### Diagnosis
- Work in progress...

### LabTests
- Work in progress...

### Medications
- Work in progress...

### Procedures
- Work in progress...

### Visits
- Work in progress...

## Tests

- [fhir_base64Binary](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#base64Binary))
- [fhir_canonical](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#canonical)) 
- [fhir_code](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#code))
- [fhir_date](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#date))
- [fhir_dateTime](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#dateTime))
- [fhir_id ](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#id))
- [fhir_instant](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#instant))
- [fhir_oid](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#oid))
- [fhir_string](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#string))
- [fhir_time](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#time))
- [fhir_uri](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#uri))
- [fhir_url](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#url))
- [fhir_uuid](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#uuid))
- [fhir_markdown](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#markdown))
- [fhir_boolean](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#boolean))
- [fhir_decimal](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#decimal))
- [fhir_positiveInt](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#positiveInt))
- [fhir_unsignedInt](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#unsignedInt))
- [fhir_integer](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#integer))
- [fhir_integer64](macros/tests/test.sql) - ([doc](https://build.fhir.org/datatypes.html#integer64))


__Example:__
```yml
version: 2
models:
  - name: Location
    columns: 
    - name: "id"
      tests:
      - aidbox.fhir_id
  - name: Observation
    columns: 
    - name: "resource#>>'{ issued }'"
      tests:
      - aidbox.fhir_date
    - name: "resource#>>'{ effective,dateTime }'"
      tests:
      - aidbox.fhir_date
```

__Run tests__
```bash
# Run all tests
dbt test --store-failures

# Test specific model
dbt test --store-failures --select Location
```


***
Powered by [Health Samurai](http://www.health-samurai.io) | [Aidbox](http://www.health-samurai.io/aidbox) | [Fhirbase](http://www.health-samurai.io/fhirbase)
