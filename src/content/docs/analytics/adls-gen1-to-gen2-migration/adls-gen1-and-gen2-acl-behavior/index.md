---
title: Gen1 and Gen2 ACL Behavior Analysis
---

# Gen1 and Gen2 ACL Behavior Analysis

## Overview

Azure Data Lake Storage is Microsoft's optimized storage solution for big data analytics workloads. ADLS Gen2 is the combination of the current ADLS Gen1 and Blob storage.  
Azure Data Lake Storage Gen2 is built on Azure Blob storage and provides a set of capabilities dedicated to big data analytics. Data Lake Storage Gen2 combines features from Azure Data Lake Storage Gen1, such as file system semantics, directory, and file level security and low cost scalability, tiered storage, high availability/disaster recovery capabilities from Azure Blob storage. Azure Data Lake Storage Gen1 implements an access control model that derives from HDFS, which in turn derives from the POSIX access control model. Azure Data Lake Storage Gen2 implements an access control model that supports both Azure role-based access control (Azure RBAC) and POSIX-like access control lists (ACLs).

This article summarizes the behavioral differences of the access control models for Data Lake Storage Gen1 and Gen2.

## Prerequisites

- **Active Azure Subscription**
- **Azure Data Lake Storage Gen1 and Gen2**
- **Azure Key Vault**. Required keys and secrets to be configured here.
- **Service principal** with read, write and execute permission to the resource group, key vault, data lake store Gen1 and data lake store Gen2. To learn more, see [create service principal account](https://docs.microsoft.com/azure/active-directory/develop/howto-create-service-principal-portal) and to provide SPN access to Gen1 refer to [SPN access to Gen1](https://docs.microsoft.com/azure/data-lake-store/data-lake-store-service-to-service-authenticate-using-active-directory)
- **Java Development Kit (JDK 7 or higher, using Java version 1.7 or higher)** for Filesystem operations on Azure Data Lake Storage Gen1 and Gen2

## ACL Behavior in ADLS Gen1 and Gen2

### Account Root Permissions

Check GetFileStatus and GetAclStatus APIs with or without permissions on root Account path

- **GEN1 Behavior**: Permission required on Account root- RX(minimum) or  RWX , to get an account root content view
- **GEN2 Behavior**: A user with or without permissions on container root can view account root content

### OID-UPN Conversion

Check the identity inputs for UPN format APIs  (Eg:GetAclStatus, Liststatus ,GetFileStatus) and OID format APIs (Eg:SetAcl, ModifyAclEntries, RemoveAclEntries)

- **GEN1 Behavior**: OID <-> UPN conversion is supported for Users, Service principals and groups
    > Note: For groups, as there is no UPN, conversion is done to Display name property
- **GEN2 Behavior**: Supports only User OID-UPN conversion.
    > Note:  For service principal or group ,as UPN or Display Name is not unique, the derived OID could end up being an unintended identity

### RBAC User Role Significance

RBAC roles and access control

- **GEN1 Behavior**: All users in RBAC Owner role are superusers. All other users (non-superusers),need to have permission that abides by File Folder ACL. Refer [here](https://docs.microsoft.com/azure/data-lake-store/data-lake-store-access-control) for more details
- **GEN2 Behavior**: All users in ‘RBAC -Storage blob data owner’ role are superusers. All other users can be provided different roles(contributor, reader etc.) that govern their read, write and delete permissions, this takes precedence to the ACLs sent on individual file or folder. Refer [here](https://docs.microsoft.com/azure/data-lake-store/data-lake-store-access-control) for more details

### Store Default Permission

Check if default permission is considered during file and directory creation

- **GEN1 Behavior**: Permissions for an item(file/directory) cannot be inherited from the parent items. Refer [here](https://docs.microsoft.com/azure/data-lake-store/data-lake-store-access-control)
- **GEN2 Behavior**: Permissions are only inherited if default permissions have been set on the parent items before the child items have been created. Refer [here](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-access-control)

### User Provided Permission on File/Directory Creation

Create a file/directory with explicit permission

- **GEN1 Behavior**: File/Directory is created, and the final permission will be same as the user provided permission
- **GEN2 Behavior**: File/Directory is created, and the final permission will be computed as [user provided permission ^ umask (currently 027 in code)]

### Set Permission with No Permission Provided

Set permission Api is called with permission = null/space and permission parameter not present

- **GEN1 Behavior**: A default value of 770 is set for both file and directory
- **GEN2 Behavior**: Gen2 will return bad request as permission parameter is mandatory

### Nested File or Directory Creation For Non-Owner User

Check if wx permission on parent is copied to nested file/directory when non-owner creates it. (i.e. dir1 exists and user desires to create dir2/dir3/a.txt or dir2/dir3/dir4)

- **GEN1 Behavior**: Adds wx permissions for owner in the sub directory
- **GEN2 Behavior**: Doesn't add wx permissions in the sub directory

### Umask Support

Permissions of file/directory can be controlled by applying UMASK on it.

- **GEN1 Behavior**: Client needs to apply umask on the permission on new file/directory before sending the request to server.
    > Note: Server doesn't provide explicit support in accepting umask as an input
- **GEN2 Behavior**: Clients can provide umask as request query params during file and directory creations. If client does not pass umask parameter, default umask 027 will be applied on file/directory

## References

- [ACL in ADLS Gen2](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-access-control)
- [ACL in ADLS Gen1](https://docs.microsoft.com/azure/data-lake-store/data-lake-store-access-control)
- [Securing data stored in Azure Data Lake Storage Gen1](https://docs.microsoft.com/azure/data-lake-store/data-lake-store-secure-data)
