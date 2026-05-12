CREATE TABLE stg_healthcare_raw
(Name VARCHAR(200),
    Age INT,
    Gender VARCHAR(20),
    Blood_Type VARCHAR(20),
    Medical_Condition VARCHAR(100),
    Date_of_Admission DATE,
    Doctor VARCHAR(200),
    Hospital VARCHAR(300),
    Insurance_Provider VARCHAR(100),
    Billing_Amount DECIMAL(18,2),
    Room_Number INT,
    Admission_Type VARCHAR(50),
    Discharge_Date DATE,
    Medication VARCHAR(100),
    Test_Results VARCHAR(50))
WITH
(DISTRIBUTION = ROUND_ROBIN,
    HEAP);
