-- Camera-movement study: one row per completed rating session.
create table if not exists public.study_responses (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  session text not null,
  rater text not null,
  payload jsonb not null
);
alter table public.study_responses enable row level security;
-- Anonymous raters may only INSERT. No select/update/delete: results are
-- readable only via the dashboard or the service role.
create policy "anon can submit" on public.study_responses
  for insert to anon with check (true);
