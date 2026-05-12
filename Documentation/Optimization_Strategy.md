## Overview

Azure Synapse Dedicated SQL Pool was optimized using table distribution strategies, indexing choices, and medallion-layer design.

## ROUND_ROBIN Distribution

Used for:
- stg_healthcare_raw
- healthcare_cleaned
- wide_healthcare_admissions

Reason:
ROUND_ROBIN evenly distributes data across Synapse distributions without requiring a distribution key.

This is useful for:
- Raw ingestion
- Staging tables
- Transformation tables
- Balanced data loading

## REPLICATE Distribution

Used for:
- dim_patient
- dim_doctor
- dim_hospital
- dim_insurance
- dim_medical_condition
- dim_medication
- dim_date

Reason:
Dimension tables are smaller lookup tables.

REPLICATE copies the dimension data to all compute nodes, reducing data movement during joins with the large fact table.

## HASH Distribution

Used for:
- fact_patient_admission

Distribution key:
- patient_key

Reason:
The fact table is the largest analytical table and is frequently joined and aggregated.

HASH distribution helps distribute fact records based on patient_key and improves query performance for analytical workloads.

## CLUSTERED COLUMNSTORE INDEX

Used for:
- cleaned table
- wide table
- dimension tables
- fact table

Reason:
Columnstore indexes are optimized for analytical queries that scan, aggregate, and filter large datasets.

Benefits:
- Better compression
- Faster aggregation
- Improved Power BI query performance

## HEAP

Used for:
- stg_healthcare_raw
- rejected_healthcare_records

Reason:
These tables are mainly used for loading and auditing, not heavy analytics.

HEAP is simple and efficient for raw/error storage.

## Dedicated SQL Pool Optimization Summary

The project applies Synapse optimization by using:

- ROUND_ROBIN for staging and transformation layers
- REPLICATE for small dimensions
- HASH for the large fact table
- COLUMNSTORE for analytics
- HEAP for raw and rejected records
