## Overview

Validation was performed to ensure data quality, completeness, and consistency across raw, cleaned, transformed, and final warehouse layers.

## Row Count Validation

Compared record counts across:

- stg_healthcare_raw
- healthcare_cleaned
- wide_healthcare_admissions
- fact_patient_admission

Expected result:
- cleaned_count <= raw_count
- wide_count = cleaned_count
- fact_count = cleaned_count

## Rejected Records Validation

Invalid records were stored in:

- rejected_healthcare_records

Rejected records include:
- Null patient name
- Null doctor
- Null hospital
- Negative billing amount
- Invalid age
- Admission date greater than discharge date

## Null Key Validation

Checked the fact table for missing foreign keys.

Columns validated:
- patient_key
- doctor_key
- hospital_key
- insurance_key
- condition_key
- medication_key

Expected result:
- No null foreign keys in the fact table.

## Billing Reconciliation

Compared total billing between raw and final fact table.

Tables compared:
- stg_healthcare_raw
- fact_patient_admission

Purpose:
- Ensures billing amounts were preserved after transformations.

## Relationship Validation

Validated fact-to-dimension joins by joining:

- fact_patient_admission
- dim_patient
- dim_doctor
- dim_hospital
- dim_insurance
- dim_medical_condition
- dim_medication

Purpose:
- Confirms that the star schema relationships are working correctly.

## Power BI Validation

Power BI dashboard was validated by checking:

- KPI cards load correctly
- Slicers work
- Charts respond to filters
- Billing totals are accurate
- Admission counts match Synapse SQL results
