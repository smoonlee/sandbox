using '../main.bicep'

param environmentType = 'dev'

param customerName = 'bwcdevops'
param location = 'westeurope'
param locationShortCode = 'weu'


param storageAccountName = 'st${customerName}${environmentType}${locationShortCode}'
