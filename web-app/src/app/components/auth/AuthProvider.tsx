'use client';

import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { 
  signIn, 
  signOut, 
  signUp, 
  resetPassword, 
  confirmResetPassword, 
  getCurrentUser 
} from 'aws-amplify/auth';
import type { 
  SignInOutput,
  SignUpOutput,
  ResetPasswordOutput,
  AuthUser
} from 'aws-amplify/auth';

interface AuthContextType {
  user: AuthUser | null;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<SignInOutput>;
  signOut: () => Promise<void>;
  signUp: (email: string, password: string, attributes: object) => Promise<SignUpOutput>;
  forgotPassword: (email: string) => Promise<ResetPasswordOutput>;
  resetPassword: (email: string, code: string, newPassword: string) => Promise<void>;
}

export const AuthContext = createContext<AuthContextType | null>(null);

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}

interface AuthProviderProps {
  children: ReactNode;
}

export function AuthProvider({ children }: AuthProviderProps) {
  const [user, setUser] = useState<AuthUser | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    checkUser();
  }, []);

  async function checkUser() {
    try {
      const user = await getCurrentUser();
      setUser(user);
    } catch (error) {
      setUser(null);
    }
    setLoading(false);
  }

  async function handleSignIn(email: string, password: string) {
    try {
      const signInOutput = await signIn({ 
        username: email, 
        password,
      });
      
      if (signInOutput.isSignedIn) {
        const user = await getCurrentUser();
        setUser(user);
      }
      return signInOutput;
    } catch (error) {
      throw error;
    }
  }

  async function handleSignUp(email: string, password: string, attributes: object) {
    try {
      return await signUp({
        username: email,
        password,
        options: {
          userAttributes: {
            email,
            ...attributes
          }
        }
      });
    } catch (error) {
      throw error;
    }
  }

  async function handleSignOut() {
    try {
      await signOut();
      setUser(null);
    } catch (error) {
      throw error;
    }
  }

  async function handleForgotPassword(email: string) {
    try {
      return await resetPassword({ username: email });
    } catch (error) {
      throw error;
    }
  }

  async function handleResetPassword(email: string, code: string, newPassword: string) {
    try {
      await confirmResetPassword({
        username: email,
        confirmationCode: code,
        newPassword
      });
    } catch (error) {
      throw error;
    }
  }

  const value: AuthContextType = {
    user,
    loading,
    signIn: handleSignIn,
    signOut: handleSignOut,
    signUp: handleSignUp,
    forgotPassword: handleForgotPassword,
    resetPassword: handleResetPassword
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
}