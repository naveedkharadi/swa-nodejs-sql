param location string = resourceGroup().location
param keyVaultName string
// param sqlAdminUsernameSecretName string
// param sqlAdminPasswordSecretName string
param sqlAdminUsername string
@secure()
param sqlAdminPassword string

resource keyVault 'Microsoft.KeyVault/vaults@2024-04-01-preview' existing = {
  name: keyVaultName
}

// resource kv 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
//   name: kvName
//   scope: resourceGroup(subscriptionId, kvResourceGroup )
// }

// Retrieve secrets from Key Vault
// var sqlAdminUsernameSecret = reference(resourceId('Microsoft.KeyVault/vaults/secrets', keyVaultName, sqlAdminUsernameSecretName), '2024-04-01-preview')
// var sqlAdminPasswordSecret = reference(resourceId('Microsoft.KeyVault/vaults/secrets', keyVaultName, sqlAdminPasswordSecretName), '2024-04-01-preview')
var randomString = substring(uniqueString(resourceGroup().id, 'randomString'), 0, 6)

module sql './3a-sql-module.bicep' = {
  name: 'deploySQL'
  params: {
    sqlServerName: 'my-sql-server-${randomString}'
    adminLogin: sqlAdminUsername
    adminPassword: sqlAdminPassword
    location: location
    keyVaultName: keyVault.name
    //adminPassword: keyVault.getSecret('sqlAdministratorLoginPassword')
  }
}

// // Output a debug string
// output debugMessage string = 'Debug: Script is running and fetched the secret successfully.'
// output sqlAdminPassword string = sqlAdminPasswordSecret.secretUri
// resource sqlServer 'Microsoft.Sql/servers@2021-05-01-preview' = {
//   name: 'my-sql-server'
//   location: location
//   properties: {
//     administratorLogin: sqlAdminUsernameSecret.secretUri
//     administratorLoginPassword: sqlAdminPasswordSecret.secretUri
//   }
// }

