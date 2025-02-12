using '../main.bicep'

param environmentType = 'acc'

param customerName = 'contoso'
param location = 'westeurope'
param locationShortCode = 'weu'

param storageAccountName = 'st${customerName}${environmentType}${locationShortCode}'
