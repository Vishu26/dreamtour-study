#!/usr/bin/env bash
# Upload the study clips to a public Supabase Storage bucket named "study-videos".
# Needs: npm i -g supabase && supabase login. Usage: ./upload_videos.sh <project-ref>
set -euo pipefail
REF=${1:?usage: upload_videos.sh <project-ref>}
SRC=${2:-../humanstudy/videos}
supabase storage cp --experimental -r "$SRC" ss:///study-videos --project-ref "$REF"
echo "Uploaded $(ls "$SRC" | wc -l) clips. Make sure the bucket is public (Storage -> study-videos -> public)."
