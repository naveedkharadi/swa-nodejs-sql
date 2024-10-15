// secrets.bicep

param keyVaultName string
param sqlAdministratorLogin string
param sqlAdministratorLoginPassword string

resource keyVault 'Microsoft.KeyVault/vaults@2021-04-01-preview' existing = {
  name: keyVaultName
}

resource sqlAdminLoginSecret 'Microsoft.KeyVault/vaults/secrets@2021-04-01-preview' = {
  name: '${keyVault.name}/sqlAdministratorLogin'
  properties: {
    value: sqlAdministratorLogin
  }
  dependsOn: [
    keyVault
  ]
}

resource sqlAdminLoginPasswordSecret 'Microsoft.KeyVault/vaults/secrets@2021-04-01-preview' = {
  name: '${keyVault.name}/sqlAdministratorLoginPassword'
  properties: {
    value: sqlAdministratorLoginPassword
  }
  dependsOn: [
    keyVault
  ]
}
