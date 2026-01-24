#!/bin/bash

OWNER="Nekogram"
REPO="Nekogram"
NEKOOUTPUT="proprietary/product/app/nekogram/nekogram.apk"

# Query GitHub API for the latest release's APK asset URL
APK_URL=$(curl -s "https://api.github.com/repos/$OWNER/$REPO/releases/latest" \
  | grep "browser_download_url" \
  | grep ".apk" \
  | head -n 1 \
  | cut -d '"' -f 4)

if [ -z "$APK_URL" ]; then
  echo "❌ Could not find APK URL for the latest release"
  exit 1
fi

rm -rf $NEKOOUTPUT
echo "⬇️ Downloading latest Nekogram APK:"
echo "$APK_URL"
curl -L -o "$NEKOOUTPUT" "$APK_URL"
echo "✅ Saved as $NEKOOUTPUT"
