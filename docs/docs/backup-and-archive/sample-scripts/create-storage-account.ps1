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
  Creates a storage account in Azure using PowerShell.

.DESCRIPTION
  Creates a brand new resource group and storage account, based upon input variables.

.PARAMETER 
  Required: resource group name, location, storage account name, storage account SKU, and storage account kind.
  SKU Types: Standard_LRS, Standard_GRS, Standard_RAGRS, Standard_ZRS, Premium_LRS, Premium_ZRS, Standard_GZRS, Standard_RAGZRS
  Storage Account Types: Storage, StorageV2, BlobStorage

.INPUTS
  None

.OUTPUTS
  None

.NOTES
  Version:        1.0
  Author:         Shannon Kuehn
  Creation Date:  2019.11.14
  Purpose/Change: Initial script development
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$rG,
    [Parameter(Mandatory=$true)]
    [string]$location,
    [Parameter(Mandatory=$true)]
    [string]$storAcctName,
    [Parameter(Mandatory=$true)]
    [string]$sku,
    [Parameter(Mandatory=$true)]
    [string]$kind
)

# Creates a brand new resource group based upon input variables.
New-AzResourceGroup -Name $rG -Location $location

# Creates a brand new storage account in the same resource group by using input variables. Reference the notes above for the right SKU and kind the script is looking for.
New-AzStorageAccount -ResourceGroupName $rG `
  -Name $storAcctName `
  -Location $location `
  -SkuName $sku `
  -Kind $kind 