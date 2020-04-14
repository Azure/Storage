Azure Storage Access Management
-------------------------------

<a id="perms">***Permissions, Access, Authorization***</a>

Support for different authentication flows is based upon 3rd party backup partner implementations. If selecting a 3rd party for Azure based backups, please consult referenced documentation inside this article or contact the vendor specifically for detailed configuration/buildout.

Permissions, access, and authorization in Azure allow for granular control over deployed resources. The recommended strategy for authorization to Azure Blob Storage accounts is to lean on [Azure Active Directory](https://docs.microsoft.com/en-us/azure/storage/common/storage-auth-aad). Related to access, the recommended approach is to grant [RBAC access using Azure Active Directory](https://docs.microsoft.com/en-us/azure/storage/common/storage-auth-aad-rbac-portal). Azure Blob Storage holds a few built-in roles that work well for different types of access permissions related to backup workloads. Enterprises can adopt these roles by examining and following the links below:

<a id="builtin">***Built-In Roles***</a>
1) [Storage Account Contributor](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#storage-account-contributor)
2) [Storage Account Key Operatior Service Role](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#storage-account-key-operator-service-role)

<a id="howtoassign">***How-To Assign***</a>

1) [Azure Portal](https://docs.microsoft.com/en-us/azure/role-based-access-control/quickstart-assign-role-user-portal)
2) [ARM Template](https://docs.microsoft.com/en-us/azure/role-based-access-control/tutorial-role-assignments-user-template)
3) [PowerShell - Group](https://docs.microsoft.com/en-us/azure/role-based-access-control/tutorial-role-assignments-group-powershell)
4) [PowerShell - User](https://docs.microsoft.com/en-us/azure/role-based-access-control/tutorial-role-assignments-user-powershell)

<a id="custom">***Custom RBAC Roles***</a>

If these roles do not hold the right levels of access or enterprises want to mix a number of different built-in roles together for a more comprehensive set of access permissions, there is capacity to lean on custom RBAC roles for user or group assignment. Custom RBAC roles typically mean an enterprise will take a built-in role and tweak it to match needs of business units, groups, or individual users.

Examples of how to configure can be found in the following documentation:
1)	[PowerShell](https://docs.microsoft.com/en-us/azure/role-based-access-control/tutorial-custom-role-powershell)
2)	[Azure CLI](https://docs.microsoft.com/en-us/azure/role-based-access-control/tutorial-custom-role-cli)

<a id="accesskeys">***Access Keys***</a>

Upon storage account creation, Azure generates two 512-bit storage account [access keys](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-manage#access-keys). The keys can be used to authorize access to the newly created storage account via Shared Key. These keys should be regularly rotated without interruption to applications requiring these access keys. The storage account key is like a root password for any given storage account. Microsoft recommends avoiding distributing the key, saving it anywhere in plaintext that is accessible to others, etc. 

<a id="sas">***Shared Access Signature***</a>

A shared access signature (SAS) provides secure delegated access to resources in a given storage account without compromising the security of stored data. With a SAS, customers hold granular control over how any given user or client can access data. Enterprises control what resources the user or client may access, what permissions are allowed on each resource, how long the SAS is valid, etc.

A shared access signature is a signed URI that points to one or more storage resources and includes a token that contains a special set of query parameters. The token indicates how resources may be accessed by the user. One of the query parameters (the signature) is constructed from the SAS parameters and signed with the key that was used to create the SAS. This signature is used by Azure Storage to authorize access to the storage resource.

<a id="sassignature">***SAS Signature***</a>

Signing a SAS can be done in one of two ways:

1) With a user delegation key that was created using Azure Active Directory (Azure AD) credentials. A user delegation SAS is signed with the user delegation key. To obtain the user delegation key and create the SAS, an Azure AD security principal must be assigned a role-based access control (RBAC) role that includes the Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey action. 

2) With the storage account key. Both a service SAS and an account SAS are signed with the storage account key. To create a SAS that is signed with the account key, an application must have access to the account key.

<a id="sastoken">***SAS Token***</a>

The SAS token is a string that is generated on the client side, for example by using one of the Azure Storage client libraries. The SAS token is not tracked by Azure Storage in any way. Customers can create an unlimited number of SAS tokens on the client side. After a SAS is created, customers can distribute the token to client applications that require access to resources in a storage account.

When a client application provides a SAS URI to Azure Storage as part of a request, the service checks the SAS parameters and signature to verify if it is valid for authorizing the request. If the service verifies the signature is valid, then the request is authorized. Otherwise, the request is declined with error code 403 (Forbidden).

<a id="serviceprincipal">***Service Principals***</a>

As enterprises select the right backup solution, there may be a need to create a [Service Principal](https://docs.microsoft.com/en-us/powershell/azure/create-azure-service-principal-azureps?view=azps-2.7.0) in Azure Active Directory. An Azure service principal is an identity created for use with applications, hosted services, and automated tools which access Azure resources. Access is restricted by assigning roles to the service principal, giving customers control over which resources can be accessed and at what level. For security purposes, Microsoft recommends using service principals with automated tooling rather than allowing user identities. Please refer to the following [documentation](https://docs.microsoft.com/en-us/azure-stack/operator/azure-stack-create-service-principals?view=azs-1908#manage-an-azure-ad-service-principal) on how to set up a service principal.

<a id="managedid">***Managed Identities***</a>

Much like Service Principals, certain backup solutions may allow the use of a [Managed Identity](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview). This feature provides Azureresources with an automatically managed identity in Azure AD for a more secure way of accessing workloads. By design, no credentials are known to any Azure administrator. For a tutorial on how to set this up, please refer to the following [documentation](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/tutorial-windows-vm-access-arm). Note, this only works when VM is running in Azure.
