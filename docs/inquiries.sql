-- 체험단 문의 표. Supabase SQL Editor에 붙여 넣고 Run (자동 생성이 안 될 때만)
create table if not exists public.inquiries (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  name text not null,
  contact text not null,
  store text not null,
  consent boolean not null default false,
  status text not null default '새 문의' check (status in ('새 문의', '연락함', '완료')),
  updated_at timestamptz
);

-- 유입 경로(UTM). 표가 이미 있어도 칸만 더해진다
alter table public.inquiries add column if not exists utm_source text;
alter table public.inquiries add column if not exists utm_medium text;
alter table public.inquiries add column if not exists utm_campaign text;
alter table public.inquiries add column if not exists utm_term text;
alter table public.inquiries add column if not exists utm_content text;
alter table public.inquiries add column if not exists landing_page text;
alter table public.inquiries add column if not exists referrer text;

alter table public.inquiries enable row level security;
revoke all on public.inquiries from anon, authenticated;
-- 정책은 만들지 않는다: 브라우저(공개 키)로는 접근 불가, 서버(/api)만 접근
