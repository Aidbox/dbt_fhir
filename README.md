# Aidbox FHIR DBT Package

# Features
- FHIR centric
  - utils
  - cohorts
  - fhir datatypes tests
  - incremental ??? ....
  - SQL on fhir ??
  - unnesting ?
- Parallel optimized
- DB tune configuration


## Framework
3 layers
- RAW fhir date
 (here is dbt project with fhir helpers)
- Flat usable views (dimensional/star model)
- Aggregate your date (OLAP cube)

- Flat your data - star model
  - List facts and dimentions
- Create pre aggregated views (cubes)
- Use BI

## Generic dbt project instructions
package info
install package

## Quick start
- Run aidbox ...
- Load synthea data ...
- Sample project ...
- Connect to aidbox database

## Analytics framework ...
- Flat dimentional model ...
- Build CUBE`s data marts ...
- Use cube data mart on BI ...


## Dashboard
...

## Macros

### Cohorts

Based on https://build.fhir.org/ig/HL7/vulcan-rwd/patients.html

__Patient Demographics__
- Birthdate
  - `age`
- Gender
  - `gender`
- Death Indicator
  - `alive`
  - `death`
- Race / Ethnicity (US-CORE)
  - `race`
  - `ethnicity`

__Visit__
`has_encounter`
- Class
  `class=None, classSystem=None, classDisplay=None`
- Reason for Visit
  `reason=None, reasonSystem=None, reasonDisplay=None`
- Discharge Disposition
  `discharge=None, dischargeSystem=None, dischargeDisplay=None`
- Admission Date
  `adminssionDate=None, admissionLookBack=None`
- Discharge Date
  `dischargeDate=None, dischargeLookBack=None`

__Diagnosis__
- Diagnosis Code
- Date
- Confirmation Flag
- Diagnosis Type

__Lab Test__
- Test Code
- Date
- Value
- Interpretation (high, low, abnormal)

__Procedure__
- Procedure Code
- Date
- Outcome

__Medication__
- Drug Code
- Administration Dates
- Order Dates

## Helpers
- `extension`
- race
- has_observation ?? criteria ?
- has_encounter
- has_condition
- identifier
- full_name
- normalize_ref 
- geo (fips)
