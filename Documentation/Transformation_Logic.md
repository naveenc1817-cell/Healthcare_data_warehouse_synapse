## Overview

The transformation process converts raw healthcare CSV data into cleaned, standardized, analytics-ready warehouse tables.

## Bronze Layer

Table:
- stg_healthcare_raw

Purpose:
- Stores raw ingested CSV data from ADLS Gen2.

## Silver Layer

Tables:
- healthcare_cleaned
- wide_healthcare_admissions

## Transformations Applied

### 1. Data Cleaning

Records were filtered to remove invalid data.

Rules:
- Patient name cannot be null
- Doctor cannot be null
- Hospital cannot be null
- Billing amount must be greater than or equal to zero
- Age must be between 0 and 120
- Admission date must be less than or equal to discharge date

### 2. Text Standardization

Used `TRIM()` to remove leading and trailing spaces from text fields.

Examples:
- patient_name
- doctor_name
- hospital_name
- insurance_provider
- medication_name

### 3. Column Renaming

Raw column names were converted into business-friendly names.

Examples:
- Name → patient_name
- Age → patient_age
- Doctor → doctor_name
- Hospital → hospital_name

### 4. Data Type Conversion

Used `CAST()` to convert fields into appropriate data types.

Examples:
- Billing amount converted to DECIMAL(18,2)
- Admission and discharge dates converted to DATE

### 5. Derived Columns

Created new business fields:

#### length_of_stay_days
Calculated using `DATEDIFF()` between admission date and discharge date.

#### age_group
Created using `CASE` logic:
- Child
- Young Adult
- Adult
- Senior

#### billing_category
Created using `CASE` logic:
- Low Cost
- Medium Cost
- High Cost

## Gold Layer

Tables:
- dimension tables
- fact_patient_admission

## Gold Transformations

- Used `SELECT DISTINCT` to remove duplicates from dimensions.
- Used `ROW_NUMBER()` to generate surrogate keys.
- Used joins to connect dimension keys into the fact table.
- Created an analytics-ready star schema for Power BI reporting.
