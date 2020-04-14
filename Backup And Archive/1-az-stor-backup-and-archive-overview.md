<a id="overview">Azure Storage as a Backup Target Overview</a>
-----------------------------

Cloud adoption has grown in recent years, most notably in enterprises. As enterprises embark upon a cloud adoption journey, typically the journey starts small. Many customers find themselves in an experimentation mode for a set period, where the business tries to understand how a chosen cloud vendor works. During this experimentation phase, it becomes important to both build and learn quickly from successes and failures. Often, enterprises ask if Microsoft has a framework to follow as a “getting started with Azure” exercise. Microsoft now holds a meaningful approach to enterprise digital transformations by way of the [Cloud Adoption Framework](https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/) \(CAF\)\. We also provide a step-by-step Setup Guide for those new to Azure to help you get up and running quickly and securely - [Azure Setup Guide](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/)\. If you would like additional assistance building your first 

In working with customers as they onboard to Azure, a good first workload becomes cloud-based backups as a data protection strategy. Even those with experience operating a Cloud Deployment will continue to benefit by protecting their remaining on-premises applications with cloud-based copies. Backups in general provide an extra insurance policy in terms of business continuity and disaster recovery. Backups also lend additional assistance in protection against cyber-attacks, human errors, natural disasters, etc. However historically, backups required a variety LTO tapes and tape libraries, large disk arrays for disk-based backup, third party software/maintenance costs, and possibly an investment of WAN accelerators as backups moved to a separate co-lo. Cloud computing changes all these traditional approaches for data protection, backup, and archive. Data can be stored in the cloud versus locally, on a shared drive, or on  backup tapes. Additionally, cloud-based backups can augment or replace existing on-premises solutions. Typically moving backups to the cloud reduces overall backup costs. The key is to build out and document enterprise wide recovery point objectives (RPOs) and recovery time objectives (RTOs) in a way where the right backup tool or solution is selected, based upon business need. RPO is the age of data that must be recovered from backup storage or a disaster recovery software solution for normal operations to resume if a computer, system, or network goes down as a result of a failure or disaster. RTO is the maximum tolerable length of time that systems can be down after a failure or a disaster occurs. Even though cloud adoption and migration can simplify certain tasks and responsibilities, the same considerations should be brought to the cloud related to durability, redundancy, and resiliency. 

This documentation series is aimed at helping customers through the process of assessing infrastructure requirements, choosing the right Azure Storage solution, securing the Azure Storage resources, and integrating common backup and archival solutions with Microsoft Azure.

Content Outline
----------------------------

1 - [Networking](./2-az-stor-networking.md)
2 - [Choosing an Azure Storage tier and creating your first account](./3-az-stor-acct-setup-opts)
3 - [Controlling Access to you Azure Storage](4-az-stor-access-mgmt.md)
4 - [Additional Storage Security](5-az-stor-acct-security.md)
5 - [Protecting against accidental or malicious deletion](6-az-stor-arch-comp-softdelete.md)
6 - [Managing Costs](7-az-stor-data-prot-cost-mgmt.md)
7 - [Integrating Backup and Archive products](8-ptr-integ-first-party.md)

Partner Integration
----------------------------

Know the Azure basics? Want to jump right to "How-To" add Azure Storage resources to your existing or shiny new solution? Then these documents are for you!

Commvault
Cohesity Data Platform
Commvault
Dell Isilon CloudPool
Dell Cloudboost
Dell Data Domain CloudTier
IBM Spectrum Protect
Nasuni
NetApp Cloud Tiering
NetApp Cloud Volumes ONTAP
NetApp StorageGRID
Nutanix
Qumulo
Rubrik Cloud Data Management
Scality
Veeam 
Veritas NetBackup
Veritas Backup Exec
