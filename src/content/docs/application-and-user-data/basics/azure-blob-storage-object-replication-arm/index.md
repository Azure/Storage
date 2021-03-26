---
title: Azure Blob Storage - Setup Object Replication with ARM Templates
---

# Azure Blob Storage - Setup Object Replication with ARM Templates

Object replication asynchronously copies block blobs between a source storage account and a destination account.

You can find a good overview of the service [here](https://docs.microsoft.com/azure/storage/blobs/object-replication-overview), and instructions on how to deploy it via the portal [here](https://docs.microsoft.com/azure/storage/blobs/object-replication-configure).

Here we are going to focus on deploying Object Replication with ARM. You will see we are doing this in 3 steps with three templates orchestrated with some CLI code. This needs to be done in separate steps to 1) allow time for the Change Feed and Versioning features to be provisioned before creating the destination object replication endpoint and 2) to allow us to query the policy and rule information from the destination endpoint to pass into the creation of the source object replication endpoint.

## Variable and Resource Group Setup

- In this sample we are using the same container name for source and destination this is not required
- In this sample we are using the same region for source and destination this is not required
- In this sample we are using the same durability (i.e. LRS) for source and destination this is not required

``` bash
RG="<resource group name>"
LOCATION="<region name i.e. westus>"
SRCACCT="<name of source storage account>"
DESTACCT="<name of destination storage account>"
CONTAINER="<name of container>"

az group create --name $RG --location $LOCATION 
```

## Create the source & destination storage accounts

Get the ARM template [here](step01.json)

- Make sure that your accounts have Change Feed and Versioning features enabled

``` bash
az deployment group create \
    --name TestDeployment \
    --resource-group $RG  \
    --template-file step01.json \
    --parameters "storageNameSrc=$SRCACCT" \
        "storageNameDest=$DESTACCT" \
        "containerName=$CONTAINER"
```

## Create the destination Object Replication endpoint

Get the ARM template [here](step02.json)

- You might need to wait a bit for the features you enabled in the last step to turn on before doing this

``` bash
az deployment group create \
    --name TestDeployment \
    --resource-group $RG  \
    --template-file step02.json \
    --parameters "storageNameSrc=$SRCACCT" \
        "storageNameDest=$DESTACCT" \
        "containerName=$CONTAINER"
```

## Create the source Object Replication endpoint

Get the ARM template [here](step03.json)

> NOTE: Here I am just pulling the first policy and rule, since I only have 1, if you have more than 1 you will need to change the --query

``` bash
POLICY=$(az storage account or-policy list --account-name $DESTACCT --query '[0].policyId' --output tsv)
RULE=$(az storage account or-policy list --account-name $DESTACCT --query '[0].rules[0].ruleId' --output tsv)

az deployment group create \
    --name TestDeployment \
    --resource-group $RG  \
    --template-file step03.json \
    --parameters "storageNameSrc=$SRCACCT" \
        "storageNameDest=$DESTACCT" \
        "containerName=$CONTAINER" \
        "policyId=$POLICY" \
        "ruleId=$RULE" 
```
