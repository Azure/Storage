Data Protection and Cost Management Strategies Using Azure
----------------------------------------------------------

Typically, enterprises are selecting cloud-based backup due to cloud being an inexpensive alternative related to total cost of ownership (TCO). Firms are no longer spending money on capex costs for duplicative infrastructure at a co-lo, or on multiple tape libraries and tape kinds. In most backup to cloud scenarios, the backup data is already online and does not require a lengthy amount of time to restore. Using Azure, enterprises will not select certain Azure Storage SKUs for data protection based upon cost and need.

<a id="augment">***Augment Existing or Replace On-Premises Backup Solution***</a>  

Within the traditional backup space, customers want to be protected in the event of any system failure or catastrophic event. Prior to Azure, this would mean maintaining disk-based backups on-site, off-site, and placing backups on tape. By introducing Azure into the mix, a customer could think through a scenario where they maintain a production backup copy on-site, a tape-based backup on-site, a production copy off-site, and an Azure based backup on a GRS storage account, sitting in the Cool or Archive Tier. Depending upon the scenario, customers could even consider the off-site backup to really reside in Azure versus a separate site.

<a id="archiverehydration">***Archive Storage Rehydration***</a>  

By leaning on [Archive Storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers), customers can use an inexpensive SKU to help alleviate any duplicative costs by maintaining additional hardware or corresponding infrastructure. Additionally, archive is the lowest cost storage option in Azure.

While a blob is in the archive access tier, it’s considered offline and cannot be read or modified. Metadata surrounding the blob data is only available with online tiers as well. The only way to restore data from Archive Blob Storage is to change the tier to hot or cool. This process is known as [rehydration](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-rehydration) and can take hours to complete. Larger blob sizes are typically more optimal related to rehydration performance. Rehydrating several small blobs concurrently may add additional time. 

There are [two priorities](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-rehydration#rehydrate-an-archived-blob-to-an-online-tier) for retrieval from Archive Blob Storage: Standard and High. Standard priority is the default option for archive. Priority requires that each request will be processed in the order it was received and may take up to 15 hours. High priority will be prioritized over Standard requests and may finish in under 1 hour. High priority may take longer than 1 hour, depending upon blob size and current demand. High priority requests are guaranteed to be prioritized over Standard priority requests. High priority also increases cost related to storage consumption in azure.

Another way to retrieve blobs from archive is to [copy an archived blob to an online tier](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-rehydration#rehydrate-an-archived-blob-to-an-online-tier). Enterprises can choose a [Copy Blob](https://docs.microsoft.com/rest/api/storageservices/copy-blob) operation, which will leave the original blob in an unmodified state in archive, while being able to work on the new blob in the online tier. Archive blobs can only be copied to online destination tiers. Copying a blob from Archive takes time, but the rehydrate priority property can be switched from Standard to High when using the copy process.  Behind the scenes, the Copy Blob operation temporarily rehydrates the archive source blob to create a new online blob in the destination tier. This new blob is not available until the temporary rehydration from archive is complete and the data is written to the new blob.

<a id="lifecycle">***Azure Blob Storage Lifecycle Management***</a>  

Another strategy related to data protection surrounds using [Azure Blob Storage lifecycle management](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-lifecycle-management-concepts). By selecting a GPv2 storage account, Blob storage accounts, or Premium Block Blob storage accounts, customers can delve deep into building out a lifecycle management policy that fits the needs of each specific business (and sometimes business unit). Customers can transition blobs to cooler tiers (i.e. cool to archive) as a cost savings benefit. Leaning on a lifecycle management policy, customers are also able to delete blobs at the end of a retention period or lifecycle. Rules can be run once a day at the storage account level to allow for automatic tiering based upon specific rulesets. Azure’s archive storage stores data offline and offers low storage costs, but the highest data rehydrate and access costs.

When a blob is moved to a cooler tier, the operation is billed as a write operation to the destination tier, where the write operation charges of the destination tier apply. When a blob is moved to a warmer tier, the operation is billed as a read from the source tier, where the read operation and data retrieval charges of the source tier apply.

For a comparison and breakdown of block blob storage options, please refer to the following chart:

|             | Cool Tier   | Archive Tier |
| ----------- | ----------- | -----------  |
| Availability | 99%         | Offline      |
| Usage Charges | Lower storage costs, higher access and transaction costs | Lowest storage costs, highest access and transaction costs |
| Minimum Object Size | N/A | N/A |
| Minimum Storage Duration | 30 days | 180 days |
| Latency (Time to First Byte) | Milliseconds | Hours |

The chart breakdown is altered from the following [link](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers#comparing-block-blob-storage-options). Microsoft maintains a deeper detailed  comparison of block blob storage options, so customers have a better understanding of storage performance as it relates to each storage account tier.

Setting up Azure Blob Tiering can be completed using any of the following methods:  
  *	[Azure Portal](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-lifecycle-management-concepts?tabs=azure-portal#add-or-remove-a-policy)   
  *	[Azure PowerShell](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-lifecycle-management-concepts?tabs=azure-powershell#add-or-remove-a-policy)    
  *	[Azure CLI](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-lifecycle-management-concepts?tabs=template#add-or-remove-a-policy)    
  *	[REST APIs](https://docs.microsoft.com/en-us/rest/api/storagerp/managementpolicies)    

As a best practice, companies can make use of Azure Storage to augment an existing on-premises backup solution or replace the on-premises backup solution with an Azure based solution. The flexibility customers hold related to backup buildout, configuration, blob tiering, and cost optimization should make Azure an easy landing ground for future workloads. Making use of Azure Archive Storage offers customers an inexpensive alternative to maintaining duplicate infrastructure, co-lo space, backup tapes, and WAN optimizers. Paying extra for priority retrieval would be on an as-needed basis and if high priority turned out not to be necessary, standard priority will get backups restored in approximately 15 hours.
