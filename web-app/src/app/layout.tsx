// pages/_app.tsx or app/layout.tsx
import { AuthProvider } from '@/app/components/auth/AuthProvider';
import './globals.css'


export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        <AuthProvider>
          {children}
        </AuthProvider>
      </body>
    </html>
  );
}