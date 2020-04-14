<a id="accountsetup">Account Setup</a>
-----------------------------

All Azure cloud-based backups require a storage account to act as an endpoint in the cloud. Setting up a General-Purpose v2 storage account can be achieved via 1 of the following methods:

1) [Azure Portal](https://docs.microsoft.com/en-us/azure/storage/common/storage-quickstart-create-account?tabs=azure-portal)
2) [PowerShell](https://docs.microsoft.com/en-us/azure/storage/common/storage-quickstart-create-account?tabs=azure-powershell)
3) [Azure CLI](https://docs.microsoft.com/en-us/azure/storage/common/storage-quickstart-create-account?tabs=azure-cli)
4) [Azure Resource Manager Template](https://docs.microsoft.com/en-us/azure/storage/common/storage-quickstart-create-account?tabs=template)  

Azure Blob Storage Options
--------------------------

By building out a backup strategy using Azure, customers make use of [Azure Blob Storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)\. Azure Blob storage is Microsoft's object storage solution. Blob storage is optimized for storing massive amounts of unstructured data, which is data that does not adhere to any data model or definition. Additionally, Azure Storage is durable, highly available, secure, and scalable. Microsoft’s platform offers up flexibility to select the right storage for the right workload in order to provide resiliency and protection. For a deeper and more comprehensive overview of the platform, please refer to documentation on data redundancy (which highlights all SKUs inside Azure Blob Storage) and the types of storage accounts (which covers the various supported storage account types). 

As enterprises select a strategy for backup storage, there are a few different options related to backup targets in Azure. All data in a storage account is replicated to ensure durability and high availability. Azure Blob Storage copies data based upon a replication scheme to safeguard from planned and unplanned events, including transient hardware failures, network or power outages, and/or massive natural disasters. Customers can choose to replicate data within the same data center, across availability zones, across geographically separated regions. 

As a quick reference, Azure backup storage falls into the following redundancy patterns, with each redundancy option being a separate SKU to select upon storage account creation:

1)	[Locally Redundant Storage](https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy-lrs) \(LRS\) – Provides object durability by replicating data to a storage cluster within 1 datacenter region. LRS is the lowest-cost replication SKU and offers the least durability compared to other SKUs. If a datacenter disaster occurs in a region, all replicas may be lost or unrecoverable.
<br>Backup Storage SKU - Standard Locally Redundant Storage
2)	[Zone Redundant Storage](https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy-zrs) \(ZRS\)  – Replicates data synchronously across three storage clusters in a single region. Each storage cluster is physically separated from others and is in its own [Azure Availability Zone](https://docs.microsoft.com/en-us/azure/availability-zones/az-overview). Each availability zone – and the ZRS cluster within the zone – is autonomous and includes separate utilities + networking features. A write request to a ZRS storage account returns successfully only after the data is written to all replicas across the three clusters.
<br>Backup Storage SKU - Standard Zone Redundant Storage
3)	[Geo Redundant Storage](https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy-grs) \(GRS\) – Replicates data asynchronously to a secondary region that is hundreds of miles away from the primary region.  
Backup Storage SKU - Standard Geo Redundant Storage – In addition to asynchronous replication, data is only available if Microsoft initiates a failover from the primary to secondary region.
4) [Geo Zone Redundant Storage](https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy-gzrs) \(GZRS\) - Data in a GZRS storage account is replicated across three [Azure Availability Zones](https://docs.microsoft.com/en-us/azure/availability-zones/az-overview) in the primary region and is also replicated to a secondary geographic region for protection from regional disasters.  
Backup Storage SKU - Standard Geo Zone Redundant Storage
5) [Read Only Geo Redundant Storage](https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy-grs?toc=%2fazure%2fstorage%2fblobs%2ftoc.json#read-access-geo-redundant-storage) \(RA-GRS\) - Maximizes availability of a single storage account by providing read-only access to data in teh secondary location, in addition to geo-replication across two regions.  
Backup Storage SKU - Standard Read Only Geo Redundant Storage
6) [Read Only Geo Zone Redundant Storage](https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy-gzrs?toc=%2fazure%2fstorage%2fblobs%2ftoc.json#use-ra-gzrs-for-high-availability) \(RA-GZRS\) - When enabled, data can be read from the secondary endpoint as well as from the primary endpoint for a given storage account. Applications should read from and write to the primary endpoint, but switch to using the secondary endpoint in the event the primary region becomes unavailable.  
Backup Storage SKU - Standard Read Only Geo Zone Redundant Storage

Lastly, there are 2 different tiers of Azure Blob Storage for backups to provide a more comprehensive data tiering strategy:

1) [Cool Tier](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers#cool-access-tier)  
2) [Archive Tier](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers#archive-access-tier)

Most customers look at cool and archive as the cost-efficient tiers for data protection and archive. The other tier not covered is the hot tier for storage. Typically hot access tiers have higher storage costs than cool and archive, but lowest access cost. Please refer to the following [documentation](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers) for a deeper analysis on each tier for Azure Blob Storage.

Azure holds a few caveats related to storage tiering in Azure for backups:
1)	For tiering, all storage account kinds must be GPv2.
2)	Only the cool access tiers can be set at the account level and inferred for all objects underneath the storage account level. 
3)	The archive access tier is not available at the account level, only the individual blob level.
4)	Cool and archive tiers can be set at the blob level.
5)	Data in the cool access tier can tolerate slightly lower availability, but still require high durability, retrieval latency, and throughput characteristics like hot data. 
6)	For cool data, a slightly lower availability service-level agreement (SLA) and higher access costs compared to hot data are acceptable trade-offs for lower storage costs.
7)	Archive storage stores data offline and offers the lowest storage costs but also the highest data retrieval and access costs.
