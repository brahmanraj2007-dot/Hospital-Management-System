-- CarePoint HMS: Supabase SQL setup
-- Run this in Supabase Dashboard > SQL Editor.
-- This creates basic user profiles and a role field. It does NOT create a production medical-record system.

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  full_name text,
  role text not null default 'patient' check (role in ('patient','admin')),
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

-- A signed-in user can read only their own profile. Role assignment is NOT allowed from the browser.
drop policy if exists "Users can read own profile" on public.profiles;
create policy "Users can read own profile" on public.profiles
  for select to authenticated using (auth.uid() = id);

-- Automatically create a patient profile when a new auth user signs up.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.profiles (id, email, full_name, role)
  values (new.id, new.email, coalesce(new.raw_user_meta_data ->> 'full_name', ''), 'patient');
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();

-- ADMIN SETUP:
-- 1) Create the admin user through Supabase Dashboard > Authentication > Users.
-- 2) Copy that user's UUID.
-- 3) Run this statement after replacing the UUID. Never allow public sign-up to choose admin role.
-- update public.profiles set role = 'admin' where id = 'PASTE-ADMIN-USER-UUID-HERE';

-- Keep public signup disabled for admin creation. Patient self-signup is enabled in the app.
