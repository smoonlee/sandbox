targetScope = 'subscription'

// Imported Values from Pipeline
@description('Resource Group Name')
param location string

@description('Location Short Code')
@maxLength(4)
param locationShortCode string

@description('Customer Name')
param customerName string

@description('Environment Type')
@allowed([
  'dev'
  'acc'
  'prd'
])
@maxLength(3)
param environmentType string

// Tags
param tags object = {
  environment: environmentType
  deployedOn: utcNow('yyyy-MM-dd')
}

//
var resourceGroupName = 'rg-x-${customerName}-${environmentType}-${locationShortCode}'

param storageAccountName string

// Azure Verified Modules

module createResourceGroup 'br/public:avm/res/resources/resource-group:0.4.1' = {
  name: 'create-resource-group'
  params: {
    name: resourceGroupName
    location: location
    tags: tags
  }
}

module createStorageAccount 'br/public:avm/res/storage/storage-account:0.17.2' = {
  name: 'create-storage-account'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: storageAccountName
    location: location
    kind: 'StorageV2'
    skuName: environmentType == 'dev' ? 'Standard_LRS' : 'Standard_GRS'
    tags: tags
  }
  dependsOn: [
    createResourceGroup
  ]
}
