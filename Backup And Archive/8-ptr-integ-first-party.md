Partner Integration and First Party  
-----------------------------------

Microsoft works closely with backup partners to broaden the backup narrative for enterprises and mutually deliver solutions on Azure. In addition, Microsoft has a first party native solution that customers can choose to deploy as well.

<a id="azurebkup">***Azure Backup***</a>  

[Azure Backup](https://azure.microsoft.com/en-us/services/backup/) is Microsoft’s native, first party backup. The Azure service covers [several different backup scenarios](https://docs.microsoft.com/en-us/azure/backup/backup-overview#what-backup-scenarios-are-supported) and offers flexibility of backing up Azure VMs, on-premises servers, files, and various Microsoft specific workloads like SharePoint or SQL. Across the supported backup scenarios, Azure Backup coordinates with the Volume Shadow Copy Service (VSS) to take app-consistent snapshots on Windows servers and a VSS-like generic framework that ensures application consistent VM backups for Linux applications running on any Linux distribution. 

<a id="cohesity">***Cohesity Cloud Edition***</a>  

Cohesity delivers a web-scale platform that consolidates all secondary storage and data services onto one unified, efficient solution using Azure by extending the data to take advantage of scalability and cost-effectiveness. Cohesity supports long-term retention in Azure by archiving backup data directly. Backup data is deduped and compressed, along with indexed for fast retrieval and search, both back to on-premises and from the cloud. Cohesity also supports storage tiering in Azure by utilizing policy-based thresholds to move cold data. Customers can leverage Azure Blob Storage as another tier of data and then tier data back to an on-premises cluster. Cohesity CloudEdition can be deployed in Azure to backup applications running on customer premises. This deployment method eliminates the need to deploy backup software and target storage on-premises, and instead sends all backup data straight to Azure. For more information, head [here](https://www.cohesity.com/).

<a id="commvault">***Commvault***</a>

Customers can take advantage of the deep partnership between CommVault and Microsoft by mitigating risks and realizing improved control over data by using native backup support with Azure. Through CommVault’s end-to-end approach, customers can extend on-premises backup solutions to Azure for a hybrid configuration and/or lean on cloud only based backups for a wide-ranging solution that will meet any needs driven by business units or decision makers. The management plane will organize any given backup estate into a single platform that employs centralized policies to assure data governance. Customers will also have comprehensive data backup, recovery, management, and eDiscovery capabilities to maximize the use of Azure. CommVault integrates with Azure Virtual Machines, Azure SQL Databases, and Azure Blob Storage (Hot and Cool). Additionally, data management can be enabled for Exchange, SharePoint, SQL, Active Directory and Office 365. Instructions for setup are in the following locations:  

  * [Vitual Machines](http://documentation.commvault.com/commvault/v11/article?p=31252.htm)  
  * [Azure SQL Databases](https://documentation.commvault.com/commvault/v11_sp8/article?p=products/sql/c_sql_azr_bckp.htm)  
  * [Azure Blob Storage](http://documentation.commvault.com/commvault/v11/article?p=30063.htm)  

<a id="ibm">***IBM Spectrum Plus***</a>

IBM Spectrum Plus is a modern data protection solution that provides near-instant recovery, replication, reuse, and self-service for virtual machines, databases, and applications in hybrid or multicloud environments. The agentless architecture, combined with the virtual appliance setup in Azure, make the solution easy to maintain. IBM Spectrum Plus integrates with object storage APIs on Azure to provide low-cost, long-term data retention and disaster recovery for all supported workloads. The policies support data offloading, therefore, a single data protection policy can govern data backup, replication, and offload. Secure long-term data storage can be achieved by using IBM Cloud Object Storage immutable object storage features, such as retention enabled buckets (WORM). Instructions for setup are located [here](https://www.ibm.com/support/knowledgecenter/en/SSEQVQ_8.1.2/srv.common/r_techchg_srv_azure_812.html).

<a id="rubrik">***Rubrik Cloud Data Management***</a>  

Protect cloud-native applications by writing to Azure’s Blob Storage services. Customers can take application-consistent snapshots for cloud instances of Windows or Linux VMs, Microsoft Exchange, SharePoint, SQL Server, Active Directory, and Oracle RDBMS. Enterprises can maximize storage efficiency with global deduplication that scales inline with the cloud-based cluster. Rubrik supports SLA policies for VMs, applications, and databases by selecting the desired snapshot capture frequency, retention duration, and desired location. Automate custom lifecycle management workflows with a rich suite of RESTful APIs to quickly move local data to the cloud and intelligently manage cloud data to business needs. Instantly search for files across all snapshots with suggested search results. Deliver rapid recoveries for files, folders, file sets, application, and database instances in the cloud. Additionally, Rubrik delivers real-time platform insights on data management, compliance, and capacity planning across the entire cloud environment with actionable insights from data visualization. For more information, head [here](https://www.rubrik.com/).

<a id="veeam">***Veeam Cloud Connect***</a>  

Veeam enables businesses to act as a disaster recover (DR) service provider by delivering off-site backup and replication services. With Veeam Cloud Connect, moving backups off-site to Azure is simple and seamless. Microsoft Azure customers can instantly provision enterprise cloud backup repositories and automatically move on-premises Veeam powered backup archives to Azure. Using this powerful combination of Microsoft and Veeam provides enterprise customers with cost-effective Azure storage plus the granular file-level recovery capabilities of Veeam.

Key Highlights:  

1) Easily deploy Veeam-powered backups to Azure. Customers can provision a trial version of Veeam Cloud Connect directly from the Microsoft Azure Marketplace within a short period of time.  
2) Quickly copy off-site backups to Azure. Veeam’s modern backup architecture makes it easy to transfer enterprise backups to Azure with forever-forward, incremental backups, as well as (grandfather-father-son) retention policies and built-in job copy functions.

Instructions for setup are located [here](https://helpcenter.veeam.com/docs/backup/hyperv/adding_azure_object_storage.html?ver=95u4).

<a id="veritas">***Veritas Cloud Point***</a>

Veritas helps organizations accelerate data center transformation to Azure by providing tooling to ensure control over a corporation’s backup estate. Veritas provides a single management console across private clouds, Azure, and other public cloud vendors. The product also ensures automated discovery and backup with no need to install agents. Veritas delivers application-consistent snapshots for a wide range of applications and offers granular search + recovery down to the individual file level. For regulated firms, customers can maintain and control Personally Identifiable Information. As an extra level of protection, enterprises can enable replication to other regions for added disaster recovery readiness. Instructions for setup are located [here](https://www.veritas.com/content/support/en_US/doc/58500769-127471507-0/v118626392-127471507).
