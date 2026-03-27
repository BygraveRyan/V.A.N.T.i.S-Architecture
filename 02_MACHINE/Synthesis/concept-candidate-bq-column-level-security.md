# 🛡️ Security Candidate: BigQuery Column-Level Security (CLS)
**Status:** Candidate | **Source:** GCP Flights Analytics Pipeline

## Definition
A security mechanism that allows data owners to restrict access to specific columns within a table based on user roles and sensitivity tags (Policy Tags), rather than granting access to the entire table.

## Application to Aviation Data
- **Target Field:** `tail_number` (Aircraft Identification).
- **Sensitivity:** High (can be used to track specific aircraft movements).
- **Mechanism:**
    1. Define a **Taxonomy** in Dataplex (e.g., "PII-Masking").
    2. Create a **Policy Tag** (e.g., "Sensitive-Aircraft-ID").
    3. Attach the tag to the `tail_number` column in the BQ DDL.
    4. Grant the `Data Catalog Fine-grained Reader` role only to authorized analysts.

## Result
Unauthorized users seeing the table will see `NULL` or an access error for that specific column, while still being able to query non-sensitive fields like `flight_date` or `delay_minutes`.
