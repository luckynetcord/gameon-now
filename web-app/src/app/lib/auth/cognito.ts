// lib/auth/cognito.ts
import { Amplify } from 'aws-amplify';

Amplify.configure({
  Auth: {
    Cognito: {
      userPoolId: 'your-user-pool-id',
      userPoolClientId: 'your-client-id',
      signUpVerificationMethod: 'code',
    }
  }
});