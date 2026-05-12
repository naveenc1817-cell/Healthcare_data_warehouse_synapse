IF OBJECT_ID('healthcare_cleaned') IS NOT NULL
DROP TABLE healthcare_cleaned;
GO

CREATE TABLE healthcare_cleaned
WITH
(DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX)
AS
SELECT
    TRIM(Name) AS Name,
    Age,
    Gender,
    Blood_Type,
    Medical_Condition,
    Date_of_Admission,
    Doctor,
    Hospital,
    Insurance_Provider,
    Billing_Amount,
    Room_Number,
    Admission_Type,
    Discharge_Date,
    Medication,
    Test_Results
FROM stg_healthcare_raw
WHERE
    Name IS NOT NULL
    AND Doctor IS NOT NULL
    AND Hospital IS NOT NULL
    AND Billing_Amount >= 0
    AND Age BETWEEN 0 AND 120
    AND Date_of_Admission <= Discharge_Date;
