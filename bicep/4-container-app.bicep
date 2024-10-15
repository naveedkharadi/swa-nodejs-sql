// container-app.bicep  
  
param location string = resourceGroup().location  
param containerImage string  
param keyVaultName string  
param sqlAdminUsernameSecretName string
param sqlAdminPasswordSecretName string
param dbServerSecretName string
param dbNameSecretName string
  
resource keyVault 'Microsoft.KeyVault/vaults@2021-04-01-preview' existing = {  
  name: keyVaultName  
}  
  
resource containerAppEnv 'Microsoft.App/managedEnvironments@2021-05-01' = {  
  name: 'my-container-env'  
  location: location  
  properties: {  
    appLogsConfiguration: {  
      destination: 'log-analytics'  
    }  
  }  
}  
  
// Retrieve secrets from Key Vault
var sqlAdminUsername = list('https://${keyVaultName}.vault.azure.net/secrets/${sqlAdminUsernameSecretName}', '2021-04-01').value
var sqlAdminPassword = list('https://${keyVaultName}.vault.azure.net/secrets/${sqlAdminPasswordSecretName}', '2021-04-01').value
var dbServer = list('https://${keyVaultName}.vault.azure.net/secrets/${dbServerSecretName}', '2021-04-01').value
var dbName = list('https://${keyVaultName}.vault.azure.net/secrets/${dbNameSecretName}', '2021-04-01').value

resource containerApp 'Microsoft.App/containerApps@2021-05-01' = {  
  name: 'my-container-app'  
  location: location  
  properties: {  
    managedEnvironmentId: containerAppEnv.id  
    configuration: {  
      ingress: {  
        external: true  
        targetPort: 3000  
      }  
      secrets: [  
        {  
          name: 'dbUser'  
          value: sqlAdminUsername  
        }  
        {  
          name: 'dbPassword'  
          value: sqlAdminPassword  
        }  
        {  
          name: 'dbServer'  
          value: dbServer  
        }  
        {  
          name: 'dbName'  
          value: dbName  
        }  
      ]  
      container: {  
        image: containerImage  
        name: 'employee-api'  
        env: [  
          {  
            name: 'DB_USER'  
            value: 'dbUser'  
          }  
          {  
            name: 'DB_PASSWORD'  
            value: 'dbPassword'  
          }  
          {  
            name: 'DB_SERVER'  
            value: 'dbServer'  
          }  
          {  
            name: 'DB_NAME'  
            value: 'dbName'  
          }  
        ]  
      }  
    }  
  }  
}
