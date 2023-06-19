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
- [FHIR models](#models---fhir-resources) - build in FHIR resources models
- [Utils](#macros) - provide set of useful macros for FHIR data types
- [Cohorts](#cohorts) - supported cohort analyses
- [Tests](#tests) - provide tests for FHIR data types

## Models - FHIR resources
This package provides models for all FHIR resources of version 4.0.1

Usage example:

```sql
  select   id 
         , {{ aidbox.age() }} age
         , {{ aidbox.identifier('ssn') }} ssn
         , {{ aidbox.identifier('mrn') }} mrn
         , {{ aidbox.gender() }} gender
         , {{ aidbox.race() }} race
    from {{ ref('aidbox', 'Patient')}}
```

## Macros
- [path(path, resource=None)]() - extract resource value by json path, equivalent of `#>>` operator
```sql
select {{ aidbox.path("name") }} as name
  from {{ ref('aidbox', 'Location')}}

-- Expand 

select ("resource"#>>'{ name }') as name
  from "db"."dbt_fhir"."Location"
```

- identifier
- extension
- codesystem_text
- codesystem_code
- codesystem_display
- trim
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
