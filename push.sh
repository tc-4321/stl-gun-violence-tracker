#!/bin/bash
# Publishes the current tracker files to GitHub Pages.
# Run manually any time, or let the launchd job (see SETUP.md) run it daily.
set -e
cd "$(dirname "$0")"

if [ ! -d .git ]; then
  echo "This folder isn't a git repo yet. Do the one-time setup in SETUP.md first."
  exit 1
fi

git add index.html
if git diff --cached --quiet; then
  echo "No changes to publish."
  exit 0
fi

git commit -m "Auto-update tracker data: $(date '+%Y-%m-%d %H:%M')"
git push
echo "Published. Your GitHub Pages URL will refresh within a minute or two."
