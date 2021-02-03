---
title: Azure blob storage data management and retention
---

# Azure blob storage data management and retention

When you store your data in blob storage, there are a number of policies which govern how your data is managed and retained in the event of deletion. Data management is strictly governed and Microsoft&reg; is committed to ensuring that your data remains your data, without exception. When you delete your data - either through an API or due to a subscription being removed - there are varying policies which dictate the length of time for which your data may be retained in the event you would need to recover it.

A good place to start with understanding how your data is protected in Azure is [Azure customer data protection](https://docs.microsoft.com/azure/security/fundamentals/protection-customer-data). This article provides details on data protection, customer data ownership, records management, and electronic discovery (e-discovery).

The definitive source for understanding how your data is managed and retained in Azure and other Microsoft&reg; services is the Online Service Terms (OST). When you subscribe to an Online Service through a Microsoft Volume Licensing program, the terms for how you can use the service are defined in the Volume Licensing Online Services Terms (OST) document and program agreement. There are also additional data processing and security terms which you should become familiar with that are defined in the Microsoft Online Services Data Protection Addendum (DPA). The DPA is an addendum to the OST. Links to the current OST and DPA in multiple languages are available on the [Licensing Terms](https://www.microsoft.com/licensing/product-licensing/products?rtc=1) page. You can also find links to [archived editions of the OST](https://www.microsoftvolumelicensing.com/DocumentSearch.aspx?Mode=3&DocumentTypeId=46&ShowArchived=true) and [archived editions of the DPA](https://www.microsoftvolumelicensing.com/DocumentSearch.aspx?Mode=3&DocumentTypeId=67) if you would like to understand how these terms have evolved over time.

**Quick links:**

- Microsoft Online Services Terms ([English](https://www.microsoftvolumelicensing.com/DocumentSearch.aspx?Mode=3&DocumentTypeId=46))
- Online Services DPA ([English](https://www.microsoftvolumelicensing.com/DocumentSearch.aspx?Mode=3&DocumentTypeId=67))

The whitepaper [Protecting Data in Microsoft Azure](https://go.microsoft.com/fwlink/p/?LinkID=2114156&clcid=0x409&culture=en-us&country=US) includes several statements which can help you understand what happens when you issue a delete request through the storage APIs (for example [Delete Blob](https://docs.microsoft.com/rest/api/storageservices/delete-blob)):

> Where appropriate, confidentiality should persist beyond the useful lifecycle of data. The Azure Storage subsystem makes customer data unavailable once delete operations are performed. All storage operations including delete are designed to be instantly consistent. Successful execution of a delete operation removes all references to the associated data item and it cannot be accessed via the Azure storage APIs. Also, Azure Storage interfaces do not permit the reading of uninitialized data, thus mitigating the same or another customer from reading deleted data before it is overwritten. All copies of deleted data are then garbage-collected. The physical bits are overwritten when the associated storage block is reused for storing other data, as is typical with standard computer hard drives.

If you are interested in a deeper dive on the Azure storage subsystem, the whitepaper [Windows Azure Storage: A Highly Available Cloud Storage Service with Strong Consistency](https://sigops.org/s/conferences/sosp/2011/current/2011-Cascais/printable/11-calder.pdf) details the architecture of the system and includes details on garbage collection. There is also a [video](https://www.youtube.com/watch?v=QnYdbQO0yj4) and [presentation](https://sigops.org/sosp/sosp11/current/2011-Cascais/11-calder.pptx) which provide a condensed view of the whitepaper.

The destruction of physical media is addressed in the [Microsoft Trust Center](https://www.microsoft.com/trust-center/privacy):

> If a disk drive used for storage suffers a hardware failure, it is securely erased or destroyed before Microsoft returns it to the manufacturer for replacement or repair. The data on the drive is completely overwritten to ensure the data cannot be recovered by any means.
>
> When such devices are decommissioned, they are purged or destroyed according to [NIST 800-88 Guidelines for Media Sanitation](https://go.microsoft.com/fwlink/p/?linkid=2114410).

## Encryption

Encryption of customer data is also addressed in public documentation, including additional controls that you can implement such as customer-managed encryption keys. [Azure Storage encryption for data at rest](https://docs.microsoft.com/azure/storage/common/storage-service-encryption) states:

> Data in Azure Storage is encrypted and decrypted transparently using 256-bit [AES encryption](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard), one of the strongest block ciphers available, and is FIPS 140-2 compliant. Azure Storage encryption is similar to BitLocker encryption on Windows.
>
> Azure Storage encryption is enabled for all storage accounts, including both Resource Manager and classic storage accounts. Azure Storage encryption cannot be disabled. Because your data is secured by default, you don't need to modify your code or applications to take advantage of Azure Storage encryption.
>
> Data in a storage account is encrypted regardless of performance tier (standard or premium), access tier (hot or cool), or deployment model (Azure Resource Manager or classic). All blobs in the archive tier are also encrypted. All Azure Storage redundancy options support encryption, and all data in both the primary and secondary regions is encrypted when geo-replication is enabled. All Azure Storage resources are encrypted, including blobs, disks, files, queues, and tables. All object metadata is also encrypted. There is no additional cost for Azure Storage encryption.

Data can also be encrypted with a [customer-managed key](https://docs.microsoft.com/azure/storage/common/customer-managed-keys-overview) when used in combination with Azure Key Vault. [Revocation of a customer-managed key](https://docs.microsoft.com/azure/storage/common/customer-managed-keys-overview#revoke-access-to-customer-managed-keys) can be performed at any time and upon revocation client calls to the Storage APIs will fail for operations including the retrieval of blobs, updates to existing blobs.

## Prevent accidental deletion

There are also customer controls available which allow you to manage the lifecycle of your data and prevent the accidental deletion of critical information, including [soft delete for blobs](https://docs.microsoft.com/azure/storage/blobs/soft-delete-blob-overview) and [containers](https://docs.microsoft.com/azure/storage/blobs/soft-delete-container-overview). It is also possible to implement [resource locks](https://docs.microsoft.com/azure/azure-resource-manager/management/lock-resources) to prevent the accidental deletion of your storage account and the resource group it resides in. Finally, you can also recover a deleted storage account in some cases within 14 day by [utilizing storage account recovery](https://docs.microsoft.com/azure/storage/common/storage-account-recover).

## References

- [Azure customer data protection](https://docs.microsoft.com/azure/security/fundamentals/protection-customer-data)
- [Microsoft Licensing Terms](https://www.microsoft.com/licensing/product-licensing/products?rtc=1)
- Microsoft Online Services Terms ([English](https://www.microsoftvolumelicensing.com/DocumentSearch.aspx?Mode=3&DocumentTypeId=46))
- Online Services DPA ([English](https://www.microsoftvolumelicensing.com/DocumentSearch.aspx?Mode=3&DocumentTypeId=67))
- [Windows Azure Storage: A Highly Available Cloud Storage Service with Strong Consistency](https://sigops.org/s/conferences/sosp/2011/current/2011-Cascais/printable/11-calder.pdf)
- [Microsoft Trust Center](https://www.microsoft.com/trust-center/privacy)
- [NIST 800-88 Guidelines for Media Sanitation](https://go.microsoft.com/fwlink/p/?linkid=2114410)
- [Azure Storage encryption for data at rest](https://docs.microsoft.com/azure/storage/common/storage-service-encryption)
- [Customer-managed keys for Azure Storage encryption](https://docs.microsoft.com/azure/storage/common/customer-managed-keys-overview)
- [Microsoft Azure Data Security (Data Cleansing and Leakage)](https://docs.microsoft.com/en-us/archive/blogs/walterm/microsoft-azure-data-security-data-cleansing-and-leakage)
- [Soft delete for blobs](https://docs.microsoft.com/en-us/azure/storage/blobs/soft-delete-blob-overview)
- [Soft delete for containers](https://docs.microsoft.com/azure/storage/blobs/soft-delete-container-overview)
- [Lock resources to prevent unexpected changes](https://docs.microsoft.com/azure/azure-resource-manager/management/lock-resources)
- [Recover a deleted storage account](https://docs.microsoft.com/azure/storage/common/storage-account-recover)
