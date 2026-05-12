SELECT
    c.medical_condition,
    COUNT(*) AS total_admissions,
    SUM(f.billing_amount) AS total_billing,
    AVG(f.length_of_stay_days) AS avg_length_of_stay
FROM fact_patient_admission f
JOIN dim_medical_condition c
    ON f.condition_key = c.condition_key
GROUP BY c.medical_condition
ORDER BY total_billing DESC;

SELECT
    h.hospital_name,
    COUNT(*) AS total_admissions,
    SUM(f.billing_amount) AS total_billing,
    AVG(f.length_of_stay_days) AS avg_length_of_stay
FROM fact_patient_admission f
JOIN dim_hospital h
    ON f.hospital_key = h.hospital_key
GROUP BY h.hospital_name
ORDER BY total_billing DESC;

SELECT
    i.insurance_provider,
    COUNT(*) AS total_admissions,
    SUM(f.billing_amount) AS total_billing
FROM fact_patient_admission f
JOIN dim_insurance i
    ON f.insurance_key = i.insurance_key
GROUP BY i.insurance_provider
ORDER BY total_billing DESC;
