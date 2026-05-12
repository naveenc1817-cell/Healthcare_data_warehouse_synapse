IF OBJECT_ID('fact_patient_admission') IS NOT NULL
DROP TABLE fact_patient_admission;
GO

CREATE TABLE fact_patient_admission
WITH
(DISTRIBUTION = HASH(patient_key),
    CLUSTERED COLUMNSTORE INDEX)
AS
SELECT
    ROW_NUMBER() OVER (ORDER BY w.patient_name, w.admission_date) AS admission_fact_key,
    p.patient_key,
    d.doctor_key,
    h.hospital_key,
    i.insurance_key,
    c.condition_key,
    m.medication_key,
    ad.date_key AS admission_date_key,
    dd.date_key AS discharge_date_key,
    w.room_number,
    w.admission_type,
    w.test_results,
    w.billing_amount,
    w.length_of_stay_days,
    w.age_group,
    w.billing_category
FROM wide_healthcare_admissions w
JOIN dim_patient p
    ON w.patient_name = p.patient_name
   AND w.patient_age = p.patient_age
   AND w.gender = p.gender
   AND w.blood_type = p.blood_type
JOIN dim_doctor d
    ON w.doctor_name = d.doctor_name
JOIN dim_hospital h
    ON w.hospital_name = h.hospital_name
JOIN dim_insurance i
    ON w.insurance_provider = i.insurance_provider
JOIN dim_medical_condition c
    ON w.medical_condition = c.medical_condition
JOIN dim_medication m
    ON w.medication_name = m.medication_name
JOIN dim_date ad
    ON w.admission_date = ad.full_date
JOIN dim_date dd
    ON w.discharge_date = dd.full_date;
