---
title: Estimating Pricing for Azure Block Blob Deployments
---

# Estimating Pricing for Azure Block Blob Deployments

We have several tools to help you price Azure Block Blob Storage, however figuring out what questions you need to answer to produce an estimate can sometimes be overwhelming. To that end we have put together this simple template. You can use the template as-is or modify it to fit your workload. Once you have the template populated you will have some estimates you can input into the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to get a cost estimate.

> Note: The goal of this template is to give you a starting point to build an estimate. The template will provide some general estimations you can use to put into the pricing calculator. However, it makes many assumptions for simplicity. You can tweak the formulas in Excel to alter the assumptions to meet your requirements. It is not intended to be a replacement for a good architect.

[Click here to download the template](estimating-pricing-for-azure-block-blob-deployments.xlsx)

Helpful Links:

- [Azure Storage Blobs Pricing](https://azure.microsoft.com/pricing/details/storage/blobs/)
- [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/)
- [Plan and manage costs for Azure Blob storage](https://docs.microsoft.com/azure/storage/common/storage-plan-manage-costs)

How To use:

1. Fill in the following columns on the Inputs tab
   - **Workload** – this is the name of your workload, note you might need multiple rows if your workload requires deployments into different regions, durability, or tiers.
   - **Region** – this is the [Azure Region](https://azure.microsoft.com/global-infrastructure/geographies/) where your workload will be deployed (i.e., East US, West US, etc.)  
   - **Durability** – LRS, ZRS, GRS/RA-GRS, GZRS/RA-GZRS. Verify that the durability you select is available in your selected region. See [Durability and availability parameters](https://docs.microsoft.com/azure/storage/common/storage-redundancy?toc=/azure/storage/blobs/toc.json#durability-and-availability-parameters) and [Products available by region](https://azure.microsoft.com/global-infrastructure/services/).
   - **Tier** – Premium, Hot, Cool, Archive. See [Comparing block blob storage options](https://docs.microsoft.com/azure/storage/blobs/storage-blob-storage-tiers?tabs=azure-portal#comparing-block-blob-storage-options).
   - **GB’s Today**
   - **Average File Size** (in MB)
   - **New GB** (per month)
   - **GB’s Read** (per month)
   - **GB’s Deleted** (per month)
1. Update the Assumptions as needed
   - __Migration Estimate Tab__
     - **Write Operations** = GB/Block Size + 1 per file: the defaults for most of the SDKs are between 4 MB and 8 MB however they do have logic to alter this based on the file size you are moving, or you can override it to use a block size of your choice.
     - **List/Create Operations** = 1 per file: this can vary based on how you interact with your data.
     - **Read Operations** = 0, you might decide to read a percentage of your data to verify that the migration completed successfully.
     - **Other Operations** = 0
     - **Data Retrieval** = 0
     - **Data Write** = GB’s Today
     - **Geo-Replication Data Transfer** = GB’s Today if using a durability that requires replication
   - __Monthly Estimate Tab__
      - **Write Operations** = GB/Block Size + 1 per file: the defaults for most of the SDKs are between 4 MB and 8 MB however they do have logic to alter this based on the file size you are moving, or you can override it to use a block size of your choice.
      - **List/Create Operations** = 1 per file: this can vary based on how you interact with your data.
      - **Read Operations** = GB/Block Size
      - **Other Operations** = 1 per file: this can vary based on how you interact with your data.
      - **Data Retrieval** = GB’s Read
      - **Data Write** = New GB’s
      - **Geo-Replication Data Transfer** = New GB’s if using a durability that requires replication
   - __Future GB Estimate Tab__
      - Assumes a linear growth over time of GB’s start + GB’s added – GB’s removed
1. Input the results into the Azure Pricing Calculator
   - Open the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/)
   - For each defined workload, add a Storage account to the calculator and the estimates from the template
