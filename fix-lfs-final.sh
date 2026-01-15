#!/bin/bash

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

if ! command -v git-lfs >/dev/null 2>&1; then
    printf '%s\n' "Error: git-lfs is not installed." >&2
    printf '%s\n' "Install it, then rerun this script." >&2
    exit 1
fi

git lfs install --force
git lfs track "*.apk"
git add .gitattributes

base_ref="origin/main"
if git rev-parse --verify "$base_ref" >/dev/null 2>&1; then
    git reset --soft "$base_ref"
else
    git reset --soft HEAD~1
fi

apk_files=(
    "common/product/app/YouTube/com.google.android.youtube.apk"
    "common/product/app/YTMusic/com.google.android.apps.youtube.music.apk"
    "common/product/etc/rv/YTPatched.apk"
    "common/product/etc/rv/YTMusicPatched.apk"
)

for apk in "${apk_files[@]}"; do
    git rm --cached "$apk" 2>/dev/null || true
done

git add .gitattributes
for apk in "${apk_files[@]}"; do
    git add "$apk"
done

git commit -m "Update apks to latest"

printf '%s\n' "OK: committed with Git LFS pointers."
printf '%s\n' "Next: git lfs ls-files && git push origin main"
