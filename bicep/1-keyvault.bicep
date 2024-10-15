// keyvault.bicep  
  
param location string = resourceGroup().location  
param keyVaultName string  
  
resource keyVault 'Microsoft.KeyVault/vaults@2021-04-01-preview' = {  
  name: keyVaultName  
  location: location  
  properties: {  
    sku: {  
      family: 'A'  
      name: 'standard'  
    }  
    tenantId: subscription().tenantId  
    accessPolicies: []  
    enableSoftDelete: true  
    enablePurgeProtection: true  
  }  
}  

