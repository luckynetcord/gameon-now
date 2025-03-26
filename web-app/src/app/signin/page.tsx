// src/app/signin/page.tsx
import { SignInForm } from '@/app/components/auth/SignInForm';

export default function SignInPage() {
  return (
    <div className="min-h-screen bg-gray-50 py-12">
      <SignInForm />
    </div>
  );
}