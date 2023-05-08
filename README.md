# Aidbox FHIR DBT Package

## Docs
...

## Dashboard
...

## Quik Start
- Install Aidbox
- Load Synthea data
- Install DBT
- Configure connection
- Run dbt
- BI TBD: Superset/PowerBI 

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
