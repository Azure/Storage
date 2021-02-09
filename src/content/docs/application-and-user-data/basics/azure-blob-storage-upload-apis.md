---
title: Azure Blob Storage Upload API's
---

# Azure Blob Storage Upload API's

Customers typically use existing applications such as [AzCopy](http://aka.ms/azcopy), [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/), etc. or the Azure Storage SDK's when building custom apps to access the [Azure Storage API's](https://docs.microsoft.com/azure/storage/blobs/storage-blobs-introduction#about-blob-storage). However, a good understanding of the API's is critical when tuning your uploads for high performance. This document provides an overview of the different upload API's to help you compare the differences between them.

> NOTE: There are some nuances with how the APIs are used based on what version of the API you are using. See the API documentation for full details.

## Put Blob

- **Source**: You provide the bytes
- **Size**: Blob must be smaller than 256 MiB. (Limit increasing to 5 GiB, currently in preview)
- **Official Docs**: [here](https://docs.microsoft.com/rest/api/storageservices/put-blob)
- **.NET SDK Methods**: [Upload](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blockblobclient.upload?view=azure-dotnet) & [UploadAsync](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blockblobclient.uploadasync?view=azure-dotnet). NOTE: Upload/UploadAsync will default to using PutBlob if the file to upload is small, however will use PutBlock/PutBlockList for larger uploads.

## Put Blob From URL

- **Source**: Any object retrievable via a standard GET HTTP request on the given URL (e.g. public access or pre-signed URL) can be used. This includes any accessible object, inside or outside of Azure.
- **Destination**: A block blob
- **Size**: Blob must be smaller than 256 MiB. (Limit increasing to 5 GiB, currently in preview)
- **Performance**: Completes synchronously.
- Prefer this API when ingesting Block Blobs to a storage account from any external source. Choose this over Copy Blob from URL when you have larger objects, when you don't care about preserving the block list if the source is an Azure Blob, want to set HTTP Content Properties, or want to take advantage of advance features like [Encryption Scopes](https://docs.microsoft.com/azure/storage/blobs/encryption-scope-overview), or [Put to Tier](https://docs.microsoft.com/azure/storage/blobs/storage-blob-storage-tiers#blob-level-tiering), etc.
- **Official Docs**: [here](https://docs.microsoft.com/rest/api/storageservices/put-blob-from-url)
- **.NET SDK Methods**: [SyncUploadFromUri](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blockblobclient.syncuploadfromuri?view=azure-dotnet) & [SyncUploadFromUriAsync](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blockblobclient.syncuploadfromuriasync?view=azure-dotnet)

## Copy Blob

- **Source**: The source blob for a copy operation may be a block blob, an append blob, or a page blob, a snapshot, or a file in the Azure File service.
- **Destination**: The same object type as the source
- **Size**: Each blob must be smaller than 4.75 TiB. (Limit increasing to 190.7 TiB, currently in preview). More Info: [Maximum size of a block blob](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-blob-storage-limits)
- **Performance**: Completes asynchronously.
- **Official Docs**: [here](https://docs.microsoft.com/rest/api/storageservices/copy-blob)
- **.NET SDK Methods**: [StartCopyFromUri](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blobbaseclient.startcopyfromuri?view=azure-dotnet) & [StartCopyFromUriAsync](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blobbaseclient.startcopyfromuriasync?view=azure-dotnet)

## Copy Blob From URL

- **Source**: Any object retrievable via a standard GET HTTP request on the given URL (e.g. public access or pre-signed URL) can be used. This includes any accessible object, inside or outside of Azure.  If the object is an Azure source, it must be a block blob (i.e. Page Blobs are not supported).
- **Destination**: A block blob
- **Size**: Blob must be smaller than 256 MiB.
- **Performance**: Completes synchronously.
- Choose this over Put Blob from URL when compatibility with the Copy Blob API is required or when you want the committed block list to be preserved during the copy.
- **Official Docs**: [here](https://docs.microsoft.com/rest/api/storageservices/copy-blob-from-url)
- **.NET SDK Methods**: [SyncCopyFromUri](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blobbaseclient.synccopyfromuri?view=azure-dotnet) & [SyncCopyFromUriAsync](https://docs.microsoft.com/en-us/dotnet/api/azure.storage.blobs.specialized.blobbaseclient.synccopyfromuriasync?view=azure-dotnet)

## Put Block

- **Source**: You provide the bytes
- **Size**: Each block must be smaller than 100 MiB. (Limit increasing to 4 GiB, currently in preview). More Info: [Maximum size of a block in a block blob](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-blob-storage-limits)
- **Official Docs**: [here](https://docs.microsoft.com/rest/api/storageservices/put-block)
- **.NET SDK Methods**: [StageBlock](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blockblobclient.stageblock?view=azure-dotnet) & [StageBlockAsync](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blockblobclient.stageblockasync?view=azure-dotnet)

## Put Block From URL

- **Source**: Any object range retrievable via a standard GET HTTP request on the given URL (e.g. public access or pre-signed URL) can be used. This includes any accessible object, inside or outside of Azure.
- **Size**: Each block must be smaller than 100 MiB. (Limit increasing to 4 GiB, currently in preview). More Info: [Maximum size of a block in a block blob](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-blob-storage-limits)
- **Performance**: Completes synchronously.
- **Official Docs**: [here](https://docs.microsoft.com/rest/api/storageservices/put-block-from-url)
- **.NET SDK Methods**: [StageBlockFromUri](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blockblobclient.stageblockfromuri?view=azure-dotnet) & [StageBlockFromUriAsync](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blockblobclient.stageblockfromuriasync?view=azure-dotnet)

## Put Block List

- Called after all the blocks are written. This API commits a blob by specifying the list of block IDs that make up the blob.
- **Official Docs**: [here](https://docs.microsoft.com/rest/api/storageservices/put-block-list)
- **.NET SDK Methods**: [CommitBlockList](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blockblobclient.commitblocklist?view=azure-dotnet) & [CommitBlockListAsync](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blockblobclient.commitblocklistasync?view=azure-dotnet)
