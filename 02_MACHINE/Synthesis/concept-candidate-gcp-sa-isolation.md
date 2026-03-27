# 🛡️ Security Candidate: GCP Service Account Isolation
**Status:** Candidate | **Source:** GCP Flights Analytics Pipeline

## Definition
A security pattern where different stages of a data pipeline are assigned distinct, non-overlapping identities (Service Accounts) to limit the "blast radius" of a potential credential compromise.

## Implementation in Flights Pipeline
- **Ingestion SA (`flights-pipeline-sa`):** Permissions limited to writing to GCS Bronze and accessing the FR24 Secret.
- **Processing SA (`flights-dataproc-sa`):** Permissions limited to reading from Bronze, writing to Silver/Gold, and executing Dataproc jobs.
- **Deployment SA (`flights-cicd-sa`):** Permissions to manage infrastructure (IAM, GCS, BQ) but no direct access to live data.

## Strategic Value
If the Cloud Function (`ingestion-sa`) is compromised, the attacker cannot delete the Silver/Gold buckets or modify the BigQuery warehouse.
