# Camera-movement human study — deployment

Static site for Vercel; responses stored in Supabase.

## 1. Supabase (one time)
1. Create a project at supabase.com, note the project ref and the anon public key (Settings -> API).
2. SQL editor -> run `supabase/schema.sql`. This creates `study_responses` with row-level security: anonymous visitors can only insert, never read.
3. Storage -> create a **public** bucket `study-videos`, then upload the clips: `./upload_videos.sh <project-ref>` (or drag the `videos/` folder into the bucket).

## 2. Configure
Edit `config.js`: set `SUPABASE_URL`, `SUPABASE_ANON_KEY`, and keep `VIDEO_BASE` pointing at the public bucket. Never put the service-role key anywhere in this site.

## 3. Deploy
```
npm i -g vercel
vercel --prod
```
Deploy this folder as-is (static, no build step). The clips stay in Supabase Storage, so the Vercel deployment stays tiny.

## 4. Results
Read responses in the Supabase dashboard (Table editor -> study_responses) or export:
`select rater, created_at, payload from study_responses order by created_at;`
Each row's `payload.answers[*].ranking` maps condition -> rank (1 best … 6 worst), plus per-question drag counts and dwell seconds.
