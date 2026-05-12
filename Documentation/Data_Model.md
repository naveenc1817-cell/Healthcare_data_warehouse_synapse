## Overview

The Gold layer uses a star schema designed for healthcare admission analytics.

The model contains one central fact table and multiple dimension tables.

## Fact Table

### fact_patient_admission

This table stores patient admission events and measurable values.

Measures:
- billing_amount
- length_of_stay_days

Foreign keys:
- patient_key
- doctor_key
- hospital_key
- insurance_key
- condition_key
- medication_key
- admission_date_key
- discharge_date_key

## Dimension Tables

### dim_patient
Stores patient demographic details.

Columns:
- patient_key
- patient_name
- patient_age
- gender
- blood_type

### dim_doctor
Stores doctor details.

### dim_hospital
Stores hospital details.

### dim_insurance
Stores insurance provider details.

### dim_medical_condition
Stores medical condition details.

### dim_medication
Stores medication details.

### dim_date
Supports date-based reporting for admission and discharge dates.

## Star Schema

fact_patient_admission connects to all dimension tables using surrogate keys.

This design improves reporting performance and allows Power BI users to analyze admissions, billing, hospitals, insurance providers, medical conditions, and patient demographics.
