# STL Gun Violence Tracker — Public URL Setup

You already have a working daily pipeline: a scheduled task finds new St. Louis
incidents each morning, updates your dataset and dashboard, and refreshes your
in-Claude Cowork artifact. The only missing piece was a **public, shareable web
address**. This folder adds that — using your full dashboard, map included.

## What's in this folder

- `index.html` — a copy of your live dashboard (charts + Leaflet map + data). This is what gets served at your public URL.
- `push.sh` — publishes `index.html` to GitHub Pages.
- `com.stltracker.autopush.plist` — optional Mac job that runs `push.sh` daily.
- `.gitignore` — keeps log/temp files out of the repo.

## How updates flow

1. Your existing daily task (7 AM) updates the dashboard **and** writes a fresh copy to this folder's `index.html`. (Automatic — Claude does this.)
2. `push.sh` sends that `index.html` to GitHub, which serves your public URL. (Runs on your Mac — Claude's environment is firewalled off from GitHub.)

Pick a publish method in the last section.

---

## ONE-TIME: put the tracker on a public URL (GitHub Pages)

### A. Create the repository

1. Free account at github.com if you don't have one.
2. New repository named `stl-gun-violence-tracker`, set to **Public**. Don't add a README.

### B. Connect this folder and push (Terminal, once)

Open Terminal and paste these one at a time (replace `YOUR-USERNAME`):

    cd ~/Downloads/stl-tracker
    git init
    git add index.html
    git commit -m "Initial tracker"
    git branch -M main
    git remote add origin https://github.com/YOUR-USERNAME/stl-gun-violence-tracker.git
    git push -u origin main

The first push asks you to sign in to GitHub — do it once; macOS remembers it.

### C. Turn on GitHub Pages

1. In the repo on github.com: **Settings → Pages**.
2. Source = **Deploy from a branch**, Branch = **main**, folder = **/ (root)**. Save.
3. After ~1 minute your live URL appears, shaped like:
   `https://YOUR-USERNAME.github.io/stl-gun-violence-tracker/`

That's your live tracker — full map and charts, shareable anywhere.

---

## KEEPING THE URL CURRENT — pick one

### Option 1 — One click, no Terminal (simplest)

1. Install **GitHub Desktop** (desktop.github.com), sign in.
2. Add this folder as the repository (File → Add Local Repository).
3. When you want the live site current: open GitHub Desktop, you'll see the day's
   change, click **Commit** then **Push origin**. Two clicks.

### Option 2 — Fully automatic (Mac auto-push, runs 6:30 AM daily)

Run once in Terminal (after completing step B):

    chmod +x ~/Downloads/stl-tracker/push.sh
    cp ~/Downloads/stl-tracker/com.stltracker.autopush.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.stltracker.autopush.plist

To stop it later:

    launchctl unload ~/Library/LaunchAgents/com.stltracker.autopush.plist

---

## Notes

- The daily task only runs while the Claude desktop app is open; if it was closed at 7 AM, it runs at next launch.
- "Real-time" here means a daily refresh from live web search, not a live feed — there is no free real-time gun-violence API, so this is the honest maximum without a paid data source.
- Your Cowork artifact still updates too; the difference is that this GitHub Pages URL is public and keeps the interactive map (the artifact version drops the map).
