-- Migration: Initial schema for 10xCards flashcard app
-- Purpose: Create tables for flashcards, generations, and error logs with RLS and triggers
-- Created: 2025-04-27T18:44:18Z (UTC)
--
-- This migration creates the following tables:
--   - flashcards
--   - generations
--   - generation_error_logs
-- It also sets up indices, triggers, and Row-Level Security (RLS) policies according to the project requirements.

-- TABLE: generations
create table if not exists generations (
    id bigserial primary key,
    user_id uuid not null references auth.users(id),
    model varchar not null,
    generated_count integer not null,
    accepted_unedited_count integer,
    accepted_edited_count integer,
    source_text_hash varchar not null,
    source_text_length integer not null check (source_text_length between 1000 and 10000),
    generation_duration integer not null,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- Indices for generations
create index if not exists idx_generations_user_id on generations(user_id);

-- Enable Row Level Security
alter table generations enable row level security;

-- RLS Policies for generations
create policy generations_select_authenticated on generations
  for select to authenticated
  using (user_id = auth.uid());

create policy generations_insert_authenticated on generations
  for insert to authenticated
  with check (user_id = auth.uid());

create policy generations_update_authenticated on generations
  for update to authenticated
  using (user_id = auth.uid());

create policy generations_delete_authenticated on generations
  for delete to authenticated
  using (user_id = auth.uid());

-- TABLE: flashcards
create table if not exists flashcards (
    id bigserial primary key,
    front varchar(200) not null,
    back varchar(500) not null,
    source varchar not null check (source in ('ai-full', 'ai-edited', 'manual')),
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    generation_id bigint references generations(id) on delete set null,
    user_id uuid not null references auth.users(id)
);

-- Trigger: update updated_at on record update
create or replace function update_flashcard_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists set_flashcard_updated_at on flashcards;
create trigger set_flashcard_updated_at
before update on flashcards
for each row
execute procedure update_flashcard_updated_at();

-- Indices for flashcards
create index if not exists idx_flashcards_user_id on flashcards(user_id);
create index if not exists idx_flashcards_generation_id on flashcards(generation_id);

-- Enable Row Level Security
alter table flashcards enable row level security;

-- RLS Policies for flashcards
-- Only allow access to records where user_id matches auth.uid()
create policy flashcards_select_authenticated on flashcards
  for select to authenticated
  using (user_id = auth.uid());

create policy flashcards_insert_authenticated on flashcards
  for insert to authenticated
  with check (user_id = auth.uid());

create policy flashcards_update_authenticated on flashcards
  for update to authenticated
  using (user_id = auth.uid());

create policy flashcards_delete_authenticated on flashcards
  for delete to authenticated
  using (user_id = auth.uid());

-- TABLE: generation_error_logs
create table if not exists generation_error_logs (
    id bigserial primary key,
    user_id uuid not null references auth.users(id),
    model varchar not null,
    source_text_hash varchar not null,
    source_text_length integer not null check (source_text_length between 1000 and 10000),
    error_code varchar(100) not null,
    error_message text not null,
    created_at timestamptz not null default now()
);

-- Indices for generation_error_logs
create index if not exists idx_generation_error_logs_user_id on generation_error_logs(user_id);

-- Enable Row Level Security
alter table generation_error_logs enable row level security;

-- RLS Policies for generation_error_logs
create policy error_logs_select_authenticated on generation_error_logs
  for select to authenticated
  using (user_id = auth.uid());

create policy error_logs_insert_authenticated on generation_error_logs
  for insert to authenticated
  with check (user_id = auth.uid());

create policy error_logs_update_authenticated on generation_error_logs
  for update to authenticated
  using (user_id = auth.uid());

create policy error_logs_delete_authenticated on generation_error_logs
  for delete to authenticated
  using (user_id = auth.uid());

-- End of migration
