CAREPOINT HMS — Supabase authentication starter

IMPORTANT SCOPE
- This project adds real Supabase email/password authentication.
- Patient accounts can register; new accounts get the patient role automatically.
- Admin role is assigned manually by the project owner in Supabase SQL Editor.
- The current admin dashboard tables and patient portal details are still fictional sample data stored in browser localStorage. They are NOT yet connected to Supabase. Do not enter real patient/medical information. This is a learning project, not a production hospital system.

SETUP
1. Create a Supabase project at https://supabase.com/.
2. In Supabase Dashboard, open SQL Editor and run supabase-setup.sql.
3. Open Project Settings > API. Copy the Project URL and anon/publishable key.
4. Edit config.js and replace YOUR-PROJECT-REF and YOUR_SUPABASE_ANON_OR_PUBLISHABLE_KEY.
   Never use the service_role/secret key in frontend code.
5. In Supabase Authentication settings, configure the Site URL and Redirect URLs for local testing and your deployed URL.
6. Test locally using a local web server (VS Code Live Server is suitable); do not double-click index.html if browser module/CDN restrictions interfere.
7. Patient: select Patient Login, enter email/password, click Create patient account, confirm email if enabled, then sign in.
8. Admin: create a user in Supabase Dashboard > Authentication > Users. Copy its UUID and run the admin UPDATE statement at the bottom of supabase-setup.sql. Then use Admin Login.

GITHUB PUBLIC HOSTING
1. Create a GitHub repository and upload index.html, config.js, and supabase-setup.sql (README optional).
2. GitHub repository > Settings > Pages > Deploy from a branch > main > /(root) > Save.
3. Wait for GitHub Pages to publish. Your URL will look like https://YOUR-USERNAME.github.io/YOUR-REPOSITORY/.
4. Add that exact URL to Supabase Authentication > URL Configuration > Redirect URLs and set it as Site URL.
5. Reload your published site and test sign-in.

SECURITY NOTES
- The Supabase anon/publishable key is designed for browser use, but database security depends on correct RLS policies.
- Never expose a service_role/secret key.
- This starter only protects profile reads and authentication. It does not provide secure patient-record storage, appointments, billing, audit logs, consent, backups, or healthcare compliance. Do not use real patient data or use this for actual clinical operations.
