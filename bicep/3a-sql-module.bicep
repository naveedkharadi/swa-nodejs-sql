param sqlServerName string
param location string = resourceGroup().location
param adminLogin string
param keyVaultName string

@secure()
param adminPassword string

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' existing = {
  name: keyVaultName
}

resource sqlServer 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
    version: '12.0'
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-05-01-preview' = {
  name: 'my-sql-database'
  location: location
  parent: sqlServer
  properties: {
    sku: {
      name: 'Free'
    }
  }
}

resource firewallRule 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  name: 'AllowAllWindowsAzureIps'
  parent: sqlServer
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource sqlServerSecret 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  name: '${keyVault.name}/sqlServerName'
  properties: {
    value: sqlServer.name
  }
  dependsOn: [
    keyVault
  ]
}

resource sqlDatabaseSecret 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  name: '${keyVault.name}/sqlDatabaseName'
  properties: {
    value: sqlDatabase.name
  }
  dependsOn: [
    keyVault
  ]
}
