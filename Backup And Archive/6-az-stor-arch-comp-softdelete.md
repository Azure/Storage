Azure Storage Archive and Compliance
------------------------------------

At the intersection of data protection and archive comes another topic more and more customers must account for within their cloud vendor: compliance. Immutable storage for Azure Blob storage enables customers to store critical data objects in a WORM (Write Once, Read Many) state. Using WORM, data remains in an unmodifiable state for a specified interval of time, usually as required by governmental regulations, secure document retention, or a legal hold. Blob objects can be created and read, but not modified or deleted for the duration of the specified amount of time. 

Immutable storage supports [time-based retention](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-immutable-storage#time-based-retention) ([time-based retention supported values](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-immutable-storage#time-based-retention-1)), [legal holds](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-immutable-storage#legal-holds) ([legal hold supported values](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-immutable-storage#legal-hold)), all blob tiers, container level configuration, and audit logging. Time-based retention and legal holds are the actual policies related to immutable storage. When a policy is applied to a storage container, all existing blobs move into an immutable WORM state in less than 30 seconds. All new blobs uploaded to that container will also move into an immutable state. After all blobs move into an immutable state, the immutable policy is confirmed, and all overwrite or delete operations for existing and new objects are not allowed.
Container and Account deletion are also not allowed if there are any blobs protected by an immutable policy. The Delete Container operation will fail if at least one blob exists with a locked time-based retention policy or a legal hold. The storage account deletion will fail if there is at least one WORM container with a legal hold or a blob with an active retention interval. 

Customers can set up immutable storage by using 1 of the following methods:  

1)	[Azure Portal](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-immutable-storage#azure-portal)    
2)	[Azure CLI](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-immutable-storage#azure-cli)    
3)	[PowerShell](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-immutable-storage#sample-powershell-code)  

Soft Delete
-----------

[Soft delete](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-soft-delete) for Azure Storage blobs enables customers the ability to save and recover data where blobs or blob snapshots may have been deleted. Turning this feature on allows customers to protect data when it is erroneously modified or deleted by an application or other storage account user. With soft delete, if data is overwritten, a soft deleted snapshot is generated to save the state of the overwritten data. Soft deleted objects are invisible unless explicitly listed. Enterprises have the capacity of specifying the amount of time soft deleted data is recoverable before being permanently deleted.
