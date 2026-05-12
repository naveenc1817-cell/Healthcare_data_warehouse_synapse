IF OBJECT_ID('dim_patient') IS NOT NULL DROP TABLE dim_patient;
GO
IF OBJECT_ID('dim_doctor') IS NOT NULL DROP TABLE dim_doctor;
GO
IF OBJECT_ID('dim_hospital') IS NOT NULL DROP TABLE dim_hospital;
GO
IF OBJECT_ID('dim_insurance') IS NOT NULL DROP TABLE dim_insurance;
GO
IF OBJECT_ID('dim_medical_condition') IS NOT NULL DROP TABLE dim_medical_condition;
GO
IF OBJECT_ID('dim_medication') IS NOT NULL DROP TABLE dim_medication;
GO
IF OBJECT_ID('dim_date') IS NOT NULL DROP TABLE dim_date;
GO

CREATE TABLE dim_patient
WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX)
AS
SELECT
    ROW_NUMBER() OVER (ORDER BY patient_name, patient_age, gender, blood_type) AS patient_key,
    patient_name,
    patient_age,
    gender,
    blood_type
FROM
(SELECT DISTINCT patient_name, patient_age, gender, blood_type
    FROM wide_healthcare_admissions) x;
GO

CREATE TABLE dim_doctor
WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX)
AS
SELECT
    ROW_NUMBER() OVER (ORDER BY doctor_name) AS doctor_key,
    doctor_name
FROM
(SELECT DISTINCT doctor_name
    FROM wide_healthcare_admissions) x;
GO

CREATE TABLE dim_hospital
WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX)
AS
SELECT
    ROW_NUMBER() OVER (ORDER BY hospital_name) AS hospital_key,
    hospital_name
FROM
(SELECT DISTINCT hospital_name
    FROM wide_healthcare_admissions) x;
GO

CREATE TABLE dim_insurance
WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX)
AS
SELECT
    ROW_NUMBER() OVER (ORDER BY insurance_provider) AS insurance_key,
    insurance_provider
FROM
(SELECT DISTINCT insurance_provider
    FROM wide_healthcare_admissions) x;
GO

CREATE TABLE dim_medical_condition
WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX)
AS
SELECT
    ROW_NUMBER() OVER (ORDER BY medical_condition) AS condition_key,
    medical_condition
FROM
(SELECT DISTINCT medical_condition
    FROM wide_healthcare_admissions) x;
GO

CREATE TABLE dim_medication
WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX)
AS
SELECT
    ROW_NUMBER() OVER (ORDER BY medication_name) AS medication_key,
    medication_name
FROM
(SELECT DISTINCT medication_name
    FROM wide_healthcare_admissions) x;
GO

CREATE TABLE dim_date
WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX)
AS
SELECT
    ROW_NUMBER() OVER (ORDER BY full_date) AS date_key,
    full_date,
    DATEPART(YEAR, full_date) AS year,
    DATEPART(MONTH, full_date) AS month,
    DATEPART(DAY, full_date) AS day,
    DATEPART(QUARTER, full_date) AS quarter
FROM
(SELECT DISTINCT admission_date AS full_date
    FROM wide_healthcare_admissions

    UNION

    SELECT DISTINCT discharge_date AS full_date
    FROM wide_healthcare_admissions) x;
GO
