// src/config.js  
export const msalConfig = {  
    auth: {  
        clientId: process.env.REACT_APP_CLIENT_ID,  
        authority: process.env.REACT_APP_AUTHORITY,  
        redirectUri: process.env.REACT_APP_REDIRECT_URI,  
        knownAuthorities: [process.env.REACT_APP_KNOWN_AUTHORITIES],  
        postLogoutRedirectUri: process.env.REACT_APP_POST_LOGOUT_REDIRECT_URI,  
    },  
};  
  
export const appConfig = {  
    apiRootUrl: process.env.REACT_APP_API_ROOT_URL,  
    loginRequest: {  
        scopes: process.env.REACT_APP_SCOPES.split(' '),  
    },  
};  
