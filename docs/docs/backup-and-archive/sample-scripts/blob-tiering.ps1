<#
© 2019 Microsoft Corporation. 
All rights reserved. Sample scripts/code provided herein are not supported under any Microsoft standard support program 
or service. The sample scripts/code are provided AS IS without warranty of any kind. Microsoft disclaims all implied 
warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose. 
The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. In no event 
shall Microsoft, its authors, or anyone else involved in the creation, production, or delivery of the scripts be liable for 
any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of 
business information, or other pecuniary loss) arising out of the use of or inability to use the sample scripts or 
documentation, even if Microsoft has been advised of the possibility of such damages.

.SYNOPSIS
  Sets up blob tiering using PowerShell.

.DESCRIPTION
  Creates action and filter objects to apply blob tiering to block blobs matching a certain criteria. 

.PARAMETER 
  Required: resource group name, storage account name, prefix - any of the action parameter responses can be made into a variable.

.INPUTS
  None

.OUTPUTS
  None

.NOTES
  Version:        1.0
  Author:         Shannon Kuehn
  Creation Date:  2019.11.19
  Purpose/Change: Initial script development
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$rG,
    [Parameter(Mandatory=$true)]
    [string]$storAcctName,
    [Parameter(Mandatory=$true)]
    [string]$prefix
)

#Creates a new action object. Any of the parameter responses can be made into a variable and tweaked for script usage.
$action = Add-AzStorageAccountManagementPolicyAction -BaseBlobAction Delete -daysAfterModificationGreaterThan 2555
$action = Add-AzStorageAccountManagementPolicyAction -InputObject $action -BaseBlobAction TierToArchive -daysAfterModificationGreaterThan 90
$action = Add-AzStorageAccountManagementPolicyAction -InputObject $action -BaseBlobAction TierToCool -daysAfterModificationGreaterThan 30
$action = Add-AzStorageAccountManagementPolicyAction -InputObject $action -SnapshotAction Delete -daysAfterCreationGreaterThan 90

# Create a new filter object
# PowerShell automatically sets BlobType as “blockblob."
$filter = New-AzStorageAccountManagementPolicyFilter -PrefixMatch $prefix

#Create a new rule object
#PowerShell automatically sets Type as “Lifecycle” because it is the only available option currently.
$rule1 = New-AzStorageAccountManagementPolicyRule -Name Purge -Action $action -Filter $filter

#Set the policy
Set-AzStorageAccountManagementPolicy -ResourceGroupName $rgname -StorageAccountName $accountName -Rule $rule1
