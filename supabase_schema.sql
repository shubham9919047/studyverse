-- STUDYVERSE starter schema for Supabase PostgreSQL
-- Review with a qualified developer before production. Enable RLS and test every policy.
create extension if not exists pgcrypto;

create type public.member_role as enum ('student','moderator','admin');
create type public.exam_track as enum ('school','jee','neet','nda','cuet','upsc','other');

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null check (char_length(display_name) between 1 and 40),
  class_level text,
  track public.exam_track not null default 'school',
  preferred_language text not null default 'both' check (preferred_language in ('hi','en','both')),
  role public.member_role not null default 'student',
  created_at timestamptz not null default now()
);

create table public.questions (
  id uuid primary key default gen_random_uuid(),
  track public.exam_track not null,
  class_level text,
  subject text not null,
  topic text not null,
  question_text text not null,
  options jsonb not null,
  correct_option integer not null,
  explanation text,
  source_label text,
  source_url text,
  year integer,
  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  check (jsonb_typeof(options) = 'array'),
  check (correct_option >= 0)
);

create table public.attempts (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.profiles(id) on delete cascade,
  question_id uuid not null references public.questions(id),
  selected_option integer,
  is_correct boolean not null,
  time_spent_seconds integer not null default 0 check (time_spent_seconds >= 0),
  created_at timestamptz not null default now()
);

create table public.study_rooms (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  track public.exam_track not null,
  class_level text,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table public.room_members (
  room_id uuid references public.study_rooms(id) on delete cascade,
  student_id uuid references public.profiles(id) on delete cascade,
  joined_at timestamptz not null default now(),
  primary key(room_id, student_id)
);

create table public.room_messages (
  id uuid primary key default gen_random_uuid(),
  room_id uuid not null references public.study_rooms(id) on delete cascade,
  sender_id uuid not null references public.profiles(id) on delete cascade,
  body text not null check (char_length(body) between 1 and 1500),
  moderation_status text not null default 'pending'
    check (moderation_status in ('pending','approved','rejected')),
  created_at timestamptz not null default now()
);

create table public.exam_notices (
  id uuid primary key default gen_random_uuid(),
  exam_name text not null,
  notice_title text not null,
  event_type text not null,
  event_date date,
  official_source_url text not null,
  verified_at timestamptz,
  verified_by uuid references public.profiles(id),
  is_published boolean not null default false,
  created_at timestamptz not null default now()
);

-- RLS is enabled by default in the production checklist below; policies must be
-- added and tested for each table before any public deployment.
alter table public.profiles enable row level security;
alter table public.questions enable row level security;
alter table public.attempts enable row level security;
alter table public.study_rooms enable row level security;
alter table public.room_members enable row level security;
alter table public.room_messages enable row level security;
alter table public.exam_notices enable row level security;

-- Intentionally no permissive policies are included. Add least-privilege policies
-- after deciding the exact age/consent, room-membership and moderation model.
