IF OBJECT_ID('rejected_healthcare_records') IS NOT NULL
DROP TABLE rejected_healthcare_records;
GO

CREATE TABLE rejected_healthcare_records
WITH
(DISTRIBUTION = ROUND_ROBIN,
    HEAP)
AS
SELECT *
FROM stg_healthcare_raw
WHERE
    Name IS NULL
    OR Doctor IS NULL
    OR Hospital IS NULL
    OR Billing_Amount < 0
    OR Age NOT BETWEEN 0 AND 120
    OR Date_of_Admission > Discharge_Date;
