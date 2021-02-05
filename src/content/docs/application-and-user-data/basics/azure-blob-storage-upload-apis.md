---
title: Azure Blob Storage Upload API's
---

# Azure Blob Storage Upload API's

Customers typically use existing applications such as [AzCopy](http://aka.ms/azcopy), [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/), etc. or the Azure Storage SDK's when building custom apps to access the [Azure Storage API's](https://docs.microsoft.com/azure/storage/blobs/storage-blobs-introduction#about-blob-storage). However, a good understanding of the API's is critical when tuning your uploads for high performance. This document provides an overview of the different upload API's to help you compare the differences between them.

## Put Blob

- Source: You provide the bytes
- Size: Blob must be smaller than 256 MiB. (Limit increasing to 5 GiB, currently in preview)
- [Official Docs](https://docs.microsoft.com/rest/api/storageservices/put-blob)

## Put Blob From URL

- Source: Any object retrievable via a standard GET HTTP request on the given URL (e.g. public access or pre-signed URL) can be used. This includes any accessible object, inside or outside of Azure.
- Destination: A block blob
- Size: Blob must be smaller than 256 MiB. (Limit increasing to 5 GiB, currently in preview)
- Performance: Completes synchronously.
- Prefer this API when ingesting Block Blobs to a storage account from any external source. Choose this over Copy Blob from URL when you have larger objects, when you don't care about preserving the block list if the source is an Azure Blob, want to set HTTP Content Properties, or want to take advantage of advance features like [Encryption Scopes](https://docs.microsoft.com/azure/storage/blobs/encryption-scope-overview), or [Put to Tier](https://docs.microsoft.com/azure/storage/blobs/storage-blob-storage-tiers#blob-level-tiering), etc.
- [Official Docs](https://docs.microsoft.com/rest/api/storageservices/put-blob-from-url)

## Copy Blob

- Source: The source blob for a copy operation may be a block blob, an append blob, or a page blob, a snapshot, or a file in the Azure File service.
- Destination: The same object type as the source
- Size: Each blob must be smaller than 4.75 TiB. (Limit increasing to 190.7 TiB, currently in preview). More Info: [Maximum size of a block blob](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-blob-storage-limits)
- Performance: Completes asynchronously.
- [Official Docs](https://docs.microsoft.com/rest/api/storageservices/copy-blob)

## Copy Blob From URL

- Source: Any object retrievable via a standard GET HTTP request on the given URL (e.g. public access or pre-signed URL) can be used. This includes any accessible object, inside or outside of Azure.  If the object is an Azure source, it must be a block blob (i.e. Page Blobs are not supported).
- Destination: A block blob
- Size: Blob must be smaller than 256 MiB.
- Performance: Completes synchronously.
- Choose this over Put Blob from URL when compatibility with the Copy Blob API is required or when you want the committed block list to be preserved during the copy.
- [Official Docs](https://docs.microsoft.com/rest/api/storageservices/copy-blob-from-url)

## Put Block

- Source: You provide the bytes
- Size: Each block must be smaller than 100 MiB. (Limit increasing to 4 GiB, currently in preview). More Info: [Maximum size of a block in a block blob](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-blob-storage-limits)
- [Official Docs](https://docs.microsoft.com/rest/api/storageservices/put-block)

## Put Block From URL

- Source: Any object range retrievable via a standard GET HTTP request on the given URL (e.g. public access or pre-signed URL) can be used. This includes any accessible object, inside or outside of Azure.
- Size: Each block must be smaller than 100 MiB. (Limit increasing to 4 GiB, currently in preview). More Info: [Maximum size of a block in a block blob](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-blob-storage-limits)
- Performance: Completes synchronously.
- [Official Docs](https://docs.microsoft.com/rest/api/storageservices/put-block-from-url)

## Put Block List

- Called after all the blocks are written. This API commits a blob by specifying the list of block IDs that make up the blob.
- [Official Docs](https://docs.microsoft.com/rest/api/storageservices/put-block-list)
