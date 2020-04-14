<a id="storagesecurity">Azure Storage Account Security</a>
----------------------------------------------------------

Azure Storage provides a comprehensive set of security capabilities, which enables customers to secure backup blobs. 

<a id="encryption">***Encryption***</a>

Encryption protects data and helps enterprises meet organizational security and/or compliance requirements. Azure Storage automatically encrypts all data being persisted in the cloud. Data in Azure Storage is encrypted and decrypted transparently using [256-bit AES encryption](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard) (one of the strongest block ciphers available) and is also FIPS 140-2 compliant. 

<a id="encryptionmethods">***Encryption Methods***</a>  

- [Encryption in Transit](https://docs.microsoft.com/en-us/azure/security/fundamentals/storage-overview#encryption-in-transit) – Provides a way of encrypting data while it is being transmitted across networks. 
	- [Transport-Level Encryption](https://docs.microsoft.com/en-us/azure/storage/common/storage-security-guide#transport-level-encryption--using-https) – Enforcing HTTPS as the preferred protocol for data transfer.  
	- [Client-Side Encryption (CSE)](https://docs.microsoft.com/en-us/azure/storage/common/storage-security-guide#using-client-side-encryption-to-secure-data-that-you-send-to-storage) – Encrypting data before being transferred into Azure Storage. Whenever data needs retrieval, the data is decrypted after being received on the client side. 
- [Encryption at Rest](https://docs.microsoft.com/en-us/azure/security/fundamentals/storage-overview#encryption-at-rest) – Provides a way of encrypting unstructured data stored in storage accounts.  
	- [Storage Service Encryption (SSE)](https://docs.microsoft.com/en-us/azure/storage/common/storage-security-guide#encryption-at-rest) – Azure Storage encryption is enabled for all new and existing storage accounts, plus it cannot be disabled. Storage accounts are encrypted regardless of performance tier, redundancy option, and all copies of a storage account are fully encrypted. Additionally, all Azure Storage resources are encrypted (blobs, disks, files, queues, and tables) and all object metadata is encrypted. Encryption does not affect Azure Storage performance and there is no additional cost for Azure Storage encryption.  
	- [Client Side Encryption (CSE)](https://docs.microsoft.com/en-us/azure/storage/common/storage-security-guide#encryption-at-rest) – As mentioned above, client side encryption is important before data transfers and while it is at rest. CSE involves Encrypting data before being transferred into Azure Storage. Whenever data needs retrieval, the data is decrypted after being received on the client side.  
	- [Customer Managed Keys](https://docs.microsoft.com/en-us/azure/storage/common/storage-encryption-keys-portal) – Azure Storage supports encryption at rest with either Microsoft-managed keys or customer-managed keys. Customer-managed keys enable flexibility to create, rotate, disable, and revoke access controls. Customers use Azure Key Vault to manage and audit keys, plus monitor usage. The storage account and corresponding Key Vault must be in the same region but can be in different subscriptions.  

<a id="azstorfirewall">***Azure Storage Firewalls***</a>

Azure Storage provides a layered security model. By using this model, customers can secure storage accounts, so access is limited to a specific subset of networks. When network rules are configured, only backup applications requesting data over the specified set of networks can access a storage account. Customers can limit access to storage accounts by requests originating from specified IP addresses, IP ranges, or from a list of subnets in Azure Virtual Networks. To get started, please refer to the following [documentation](https://docs.microsoft.com/en-us/azure/storage/common/storage-network-security#grant-access-from-a-virtual-network). 

<a id="serviceendpoints">***Service Endpoints***</a>  

By using [Service Endpoints](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-service-endpoints-overview), customers can extend their virtual network private address space in Azure (along with the identity of the VNet) to Azure services over a direct connection. Endpoints allow an ability to secure critical Azure service resources to only the virtual networks in Azure.  

*Key Benefits:*

1) Improved Security for Azure Resources - Service endpoints provide the ability of security Azure service resources to a specific virtual network by extending the VNet identity in Azure to the service. Once service endpoints are enabled within the virtual network, customers are able to secure Azure resources to a given VNet by adding a virtual network rule to deployed resources. By implementing the rule, this removes public internet access to resources, only allowing traffic from the VNet.  

2) Optimal Routing - Service Endpoints always take service traffic directly from a VNet to the service on the Microsoft Azure backbone network, removing the need for a [User Defined Route (UDR)](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview). Keeping traffic on the Azure backbone network allows customers the ability to audit and monitor outbound internet traffic originating from a VNet in Azure without impacting service traffic.  

3) Simple Set-Up - Customers do not need reserved public IP addresses in VNets to secure Azure resources through IP firewall. There are no NAT or gateway devices required to set up Service Endpoints. Service endpoints are configured through a simple click on a subnet and there are no additional overhead in maintaining the endpoints.

Service Endpoints have some [limitations](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-service-endpoints-overview#limitations) to take into consideration for deployment. Additionally, there is no additional charge for using Service Endpoints and there is no limit on the total number of Service Endpoints in a virtual network.  

<a id="serviceendpointpolicy">***Virtual Network Service Endpoint Policies***</a>  

Virtual Network Service Endpoint policies provide customers an ability to filter virtual network to Azure services, allowing only specific Azure service resources over Service Endpoints. The policies provide granular access control for virtual network traffic to Azure services (which includes Azure Storage).  

*Key Benefits:*  

1) Improved Security for Azure Resources - [Azure service tags for network security groups](https://aka.ms/servicetags) allow customers to restrict virtual network outbound traffic to specific Azure services. With Service Endpoint Policies, customers can now restrict virtual network outbound access to only specific Azure resources. Having this capacity provides even more granular security control for protecting data accessed within any given VNet.  

2) Scalable, Highly Available Policies to Filter Azure Service Traffic - Endpoint policies provide horizontally scalable, highly available solution to filter Azure service traffic from virtual networks over Service Endpoints. No additional overhead is required to maintain central network appliances for this type of traffic within a VNet.

<a id="privatelink">***Azure Private Link***</a>

[Azure Private Link](https://docs.microsoft.com/en-us/azure/private-link/private-link-overview) enables access to Azure PaaS services over a [private endpoint](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview) inside a virtual network (which includes Azure Storage). Traffic beteween a VNet and the Azure service traverses ove rthe Microsoft backbone network, eliminating exposure from the public internet.  

*Key Benefits:*  

1) Privately Access Services on the Azure Platform - Customers can connect a virtual network to services running in Azure privately, without needing a public IP address at the source or destination. The Private Link platform will handle connectivity between any consumer and services over the Azure backbone network.  

2) On-Premises and Peered Networks - Access services running in Azure from on-premises over ExpressRoute private peering or VPN tunnels and peered virtual networks using Private Endpoints. There is no need to set up [Microsoft Peering](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-circuit-peerings#microsoftpeering) or traverse the internet to reach an Azure service. This ability provides a secure way to migrate workloads to Azure.

3) Protection Against Data Exfiltration - With Azure Private Link, the private endpoint in the VNet is mapped to a specific instance of the PaaS resource as opposed to the entire service. By using the private endpoint, consumers can only connect to the specific resource and not to any other resource in the workload or service.  

4) Global Reach - Connect privately to services running in other regions. The consumer's virtual network could be in region A and it connect to services behind Private Link in region B.  

<a id="generalsecurity">***General Storage Account Security***</a>

To read more about Storage Account security in Azure, please refer to the following [documentation](https://docs.microsoft.com/en-us/azure/storage/common/storage-security-guide). Reading through this documentation will provide a broader and deeper understanding of how to implement security for an entire data estate in Azure.
