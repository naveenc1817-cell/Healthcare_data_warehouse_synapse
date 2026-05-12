SELECT COUNT(*) AS raw_count
FROM stg_healthcare_raw;

SELECT COUNT(*) AS cleaned_count
FROM healthcare_cleaned;

SELECT COUNT(*) AS wide_count
FROM wide_healthcare_admissions;

SELECT COUNT(*) AS fact_count
FROM fact_patient_admission;

SELECT COUNT(*) AS rejected_count
FROM rejected_healthcare_records;

SELECT *
FROM fact_patient_admission
WHERE
    patient_key IS NULL
    OR doctor_key IS NULL
    OR hospital_key IS NULL
    OR insurance_key IS NULL
    OR condition_key IS NULL
    OR medication_key IS NULL;

SELECT
    SUM(Billing_Amount) AS raw_total_billing
FROM stg_healthcare_raw;

SELECT
    SUM(billing_amount) AS fact_total_billing
FROM fact_patient_admission;
