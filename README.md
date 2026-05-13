# Healthcare Data Warehouse using Azure Synapse Analytics

This project implements an end-to-end healthcare data warehouse using Azure Data Factory, Azure Data Lake Storage Gen2, Azure Synapse Dedicated SQL Pool, Medallion Architecture, Star Schema modeling, data quality validation, and Power BI reporting.
## Architecture

```mermaid
flowchart TD
    A[Healthcare CSV Dataset] --> B[ADLS Gen2 Raw Container]
    B --> C[Azure Data Factory Copy Pipeline]
    C --> D[Bronze Layer: stg_healthcare_raw]
    D --> E[Silver Layer: healthcare_cleaned]
    E --> F[Silver Wide Table: wide_healthcare_admissions]
    F --> G[Gold Dimensions]
    F --> H[Gold Fact Table]
    G --> I[Power BI Dashboard]
    H --> I

    G --> G1[dim_patient]
    G --> G2[dim_doctor]
    G --> G3[dim_hospital]
    G --> G4[dim_insurance]
    G --> G5[dim_medical_condition]
    G --> G6[dim_medication]
    G --> G7[dim_date]

    H --> H1[fact_patient_admission]
