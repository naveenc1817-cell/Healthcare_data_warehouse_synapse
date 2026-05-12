IF OBJECT_ID('wide_healthcare_admissions') IS NOT NULL
DROP TABLE wide_healthcare_admissions;
GO

CREATE TABLE wide_healthcare_admissions
WITH
(DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX)
AS
SELECT
    TRIM(Name) AS patient_name,
    Age AS patient_age,
    TRIM(Gender) AS gender,
    TRIM(Blood_Type) AS blood_type,
    TRIM(Medical_Condition) AS medical_condition,
    CAST(Date_of_Admission AS DATE) AS admission_date,
    CAST(Discharge_Date AS DATE) AS discharge_date,
    DATEDIFF(DAY, Date_of_Admission, Discharge_Date) AS length_of_stay_days,
    TRIM(Doctor) AS doctor_name,
    TRIM(Hospital) AS hospital_name,
    TRIM(Insurance_Provider) AS insurance_provider,
    CAST(Billing_Amount AS DECIMAL(18,2)) AS billing_amount,
    Room_Number AS room_number,
    TRIM(Admission_Type) AS admission_type,
    TRIM(Medication) AS medication_name,
    TRIM(Test_Results) AS test_results,
    CASE 
        WHEN Age < 18 THEN 'Child'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young Adult'
        WHEN Age BETWEEN 36 AND 60 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group,
    CASE
        WHEN Billing_Amount >= 40000 THEN 'High Cost'
        WHEN Billing_Amount BETWEEN 20000 AND 39999 THEN 'Medium Cost'
        ELSE 'Low Cost'
    END AS billing_category
FROM healthcare_cleaned;
