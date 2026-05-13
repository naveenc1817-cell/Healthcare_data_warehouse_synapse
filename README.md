# Healthcare Data Warehouse using Azure Synapse Analytics

## Project Overview

This project implements an end-to-end healthcare data warehouse solution using Azure cloud technologies including Azure Data Factory (ADF), Azure Data Lake Storage Gen2 (ADLS Gen2), Azure Synapse Dedicated SQL Pool, and Power BI.

The solution follows Medallion Architecture (Bronze, Silver, Gold) to ingest, clean, transform, validate, model, optimize, and visualize healthcare admission data for analytical reporting.

The project demonstrates enterprise-level healthcare data engineering concepts including dimensional modeling, data quality validation, Synapse optimization strategies, rejected record handling, and Power BI dashboard development.

---

# Business Problem

Healthcare organizations generate large volumes of patient admission data across hospitals, doctors, insurance providers, medications, and medical conditions.

The business requires:

- Centralized healthcare analytics
- Billing analysis
- Patient admission insights
- Hospital performance reporting
- Insurance provider reporting
- Medical condition analysis
- Data quality validation
- Scalable reporting architecture

This project builds a cloud-based healthcare analytics platform capable of supporting reporting and business intelligence workloads.

---

# Architecture

```mermaid
flowchart TD

    A[Healthcare CSV Dataset] --> B[ADLS Gen2 Raw Container]

    B --> C[Azure Data Factory Pipeline]

    C --> D[Bronze Layer: stg_healthcare_raw]

    D --> E[Silver Layer: healthcare_cleaned]

    E --> F[Silver Wide Layer: wide_healthcare_admissions]

    F --> G[Gold Dimension Tables]

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
