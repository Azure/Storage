---
title: Azure Partner Backup Documentation
titleSuffix: Azure Blob Storage Docs
description: Partner Documentation for Commvault
keywords: commvault, backup, partner
author: Dave Toronto
ms.date: 04/14/2020
ms.topic: article
ms.service: Storage
ms.subservice: 
---

# Microsoft Partner Documentation for Commvault 

## Support Matrix

| GPv2<br>Storage | Cool<br>Tier | Archive<br>Tier | WORM<br>Support | Restore<br>on-premises | Backup<br>Azure VM's | Backup<br>Azure Files | Backup<br>Azure Blob |
|--------|--------|--------|--------|--------|--------|--------|--------|
| 11.5 | 11.5 | 11.10  | 11.12 | 11.5 | 11.5 | 11.6 | 11.6 |

## Links to Marketplace Offerings
Commvault marketplace links:

- [Azure Marketplace Offerings](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/commvault.commvault?tab=Overview)

## Links to relevant documentation
Specific pages covering Azure considerations, best practices and steps to implement

- [Cloud Feature Support for Azure](https://documentation.commvault.com/commvault/v11/article?p=109795_1.htm)
- [Commvault for Azure](https://www.commvault.com/supported-technologies/microsoft/azure)
- [Commvault for Azure Stack](https://www.commvault.com/supported-technologies/microsoft/azurestack)
- [Protecting SAP Hanna in Azure](https://azure.microsoft.com/en-us/resources/protecting-sap-hana-in-azure/)
- [Moving Apps and Databases to Azure](https://www.commvault.com/resources/go-ahead-move-your-most-important-applications-and-databases-to-azure)
- [Solution brief: Rapid data migration for Azure Stack](https://www.commvault.com/resources/solution-brief-rapid-data-migration-for-azure)
- [Commvault for Azure Datasheet](https://www.commvault.com/resources/solution-brief-rapid-data-migration-for-azure)


## Reference Architecture for On-Premises -to-Azure and In-Azure deployments
- [Architecture Guide for Azure](https://www.commvault.com/resources/public-cloud-architecture-guide-for-microsoft-azure-v11-sp16)

## Implementation Guide

1.	After Commvault installs on in your Commvault VM, open the Commcell Console. From Start, select **Commvault > Commvault Commcell Console.**
2.	Configure your backup repositories to use storage external to the Azure Stack Hub in the Commvault Commcell Console. In the CommCell Browser, select Storage Resources > Storage Pools. Right-click and select **Add Storage Pool.** Select **Cloud.**
3.	Add the name of the Storage Pool. Select **Next.**
4.	Select Create > Cloud Storage.
5.	Select your cloud service provider. In this procedure, we will use a second Azure Stack Hub in a different location. Select Microsoft Azure Storage.
6.	Select your Commvault VM as your MediaAgent.
7.	Enter your access information for your storage account. You can find instruction on setting up an Azure Storage account here. Access information:
o	Service host: Get the name of the URL from the Blob container properties in your resource. For example, my URL was https://backuptest.blob.westus.stackpoc.com/mybackups and I used, blob.westus.stackpoc.com in Service host.
o	Account Name: Use the Storage account name. You can find this in the Access Keys blade in the storage resource.
o	Access Key: Get the access key from the Access Keys blade in the storage resource.
o	Container: The name of the container. In this case, mybackups.
o	Storage Class: Leave as User container's default storage class.
8.	Select the VMs or Physical Servers to protect and attach a backup policy.
9.	Configure your backup schedule to match your RPO requirements for Recovery.
10.	Perform the first backup that tiers to Azure.

- [Protecting VM's in Azure with Commvault](https://documentation.commvault.com/commvault/v11/article?p=31252.htm)
- [Cloud Feature Support for Azure](https://documentation.commvault.com/commvault/v11/article?p=109795_1.htm)
- [Configuration and Management of Storage Tiers](https://documentation.commvault.com/commvault/v11/article?p=95147.htm)
- [Network and Storage Guidance](https://www.commvault.com/resources/public-cloud-architecture-guide-for-microsoft-azure-v11-sp16)

## Monitoring the Deployment going forward
- [Configuring Settings for a Dashboard Alert](https://documentation.commvault.com/commvault/v11/article?p=100514_3.htm)
- [Dashboards](https://documentation.commvault.com/commvault/v11/article?p=95306_1.htm)
- [Reports Overview](https://documentation.commvault.com/commvault/v11/article?p=37684_1.htm)

## Partner Videos and Links
- [Demonstration – VMware to Azure data migration](https://www.commvault.com/resources/demonstration-vmware-to-azure-migrations-with-commvault)
- [Protect and Recover Your SAP® Workloads in Azure](https://www.youtube.com/watch?v=4ZGGE53mGVI)
- [Demonstration - Office 365 Data Protection with Commvault](https://www.youtube.com/watch?v=dl3nvAacxZU)
- [theCube at Commvault GO 2019](https://www.youtube.com/watch?v=mzVWi2N6RpA)
- [Keys to Fast and Secure Azure Migration](https://www.youtube.com/watch?v=FacUiOtMBiI)

## How to Open Support Case
https://www.commvault.com/support<br>
https://ma.commvault.com/support<br>
Toll Free: +1 877-780-3077<br>
support@commvault.com<br>


## Next steps

[Get Started](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/commvault.commvault?tab=Overview)
