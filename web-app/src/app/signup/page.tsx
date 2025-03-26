// src/app/signup/page.tsx
import { SignUpForm } from '@/app/components/auth/SignUpForm';

export default function SignUpPage() {
  return (
    <div className="min-h-screen bg-gray-50 py-12">
      <SignUpForm />
    </div>
  );
}