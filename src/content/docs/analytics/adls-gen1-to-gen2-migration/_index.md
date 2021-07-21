---
title: Azure Data Lake Storage Gen1 to Gen2 Migration Sample
---

# Azure Data Lake Storage Gen1 to Gen2 Migration Sample

Welcome to the documentation on migration from Gen1 to Gen2. Please review the [Gen1-Gen2 Migration Approach guide](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-migrate-gen1-to-gen2) to understand the patterns and approach. You can choose one of these patterns, combine them together, or design a custom pattern of your own.

> NOTE: On July 14 2021 we released a Limited preview of a feature to Migrate your Azure Data Lake Storage from Gen1 to Gen2 using the Azure Portal. Check it out [here](https://azure.microsoft.com/updates/limited-preview-migrate-your-azure-data-lake-storage-from-gen1-to-gen2-using-the-azure-portal/)

## Migration Patterns

You will find here the resources to help with below patterns:

### Incremental copy pattern using Azure data factory

Refer [Incremental copy pattern guide](./incremental) to know more and get started.

### Bi-directional sync pattern using WANdisco Fusion

Refer [Bi-directional sync pattern guide](./bi-directional) to know more and get started.

### Lift and Shift pattern using Azure data factory

Refer [Lift and Shift pattern guide](./lift-and-shift) to know more and get started.

### Dual Pipeline pattern

Refer [Dual pipeline pattern guide](./dual-pipeline) to know more and get started.

## How to migrate the workloads and Applications post data migration

Refer [here](./application-update) for more details on the steps to update the workloads and application post migration.

## Security

### Gen1 and Gen2 ACL behavior and differences

[Gen1 and Gen2 ACL behavior and differences](./adls-gen1-and-gen2-acl-behavior) - This article summarizes the behavioral differences of the access control models for Data Lake Storage Gen1 and Gen2.

- Azure Data Lake Storage Gen1 implements an access control model that derives from HDFS, which in turn derives from the POSIX access control model.
- Azure Data Lake Storage Gen2 implements an access control model that supports both Azure role-based access control (Azure RBAC) and POSIX-like access control lists (ACLs).

## Utilities

Utilities that can be used during the Gen1 to Gen2 Migration process.

### Ageing Analysis

Refer [Ageing Analysis](./utilities/ageing-analysis) to know more and get started.

## References

- [Azure Data Lake Storage migration from Gen1 to Gen2](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-migrate-gen1-to-gen2)
- [Why WANdisco fusion](https://docs.wandisco.com/bigdata/wdfusion/adls/)
