// static-web-app.bicep  
  
param location string = resourceGroup().location  
  
resource staticWebApp 'Microsoft.Web/staticSites@2021-02-01' = {  
  name: 'my-static-web-app'  
  location: location  
  properties: {  
    repositoryUrl: 'https://github.com/your-repo/your-app'  
    branch: 'main'  
    buildProperties: {  
      appLocation: '/'  
    }  
  }  
}  
