# Aidbox FHIR DBT Package

This dbt package provides useful macros, build in models, and tests for work with [Aidbox FHIR platform](https://aidbox.app).
See [Sample project](https://github.com/Aidbox/dbt-sample-project) for additional details.

## Installation
```yml
packages:
  - git: "https://github.com/Aidbox/dbt.git"
    warn-unpinned: false
```

## Features
- FHIR models - build in FHIR resources models
- Utils - provide set of useful macros for FHIR data types
- Cohorts - supported cohort analyses
- Tests - provide tests for FHIR data types

## Models - FHIR resources
- list of fhir resource

## Macros
### General
- path
- identifier
- extension
- codesystem_text
- codesystem_code
- codesystem_display
- trim
### Cohorts

Based on https://build.fhir.org/ig/HL7/vulcan-rwd/patients.html

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
