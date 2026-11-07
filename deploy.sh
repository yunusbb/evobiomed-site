#!/usr/bin/env bash
# Deploy the EvolBioMed site to GitHub Pages.
#
# Usage:
#   ./deploy.sh                              # first run: prepares repo, prints push command
#   ./deploy.sh git@github.com:you/repo.git  # first run with remote: commits and pushes
#   ./deploy.sh                              # later runs: commit + push to existing origin
#
set -euo pipefail
cd "$(dirname "$0")"

REMOTE="${1:-}"

if [ ! -d .git ]; then
  echo "==> initialising repository"
  git init -q -b main
fi

if [ -n "$REMOTE" ]; then
  if git remote get-url origin >/dev/null 2>&1; then
    git remote set-url origin "$REMOTE"
  else
    git remote add origin "$REMOTE"
  fi
  echo "==> origin set to $REMOTE"
fi

git add -A
if git diff --cached --quiet; then
  echo "==> nothing to commit"
else
  git commit -q -m "Update site $(date +%Y-%m-%d\ %H:%M)"
  echo "==> committed"
fi

if git remote get-url origin >/dev/null 2>&1; then
  echo "==> pushing"
  git push -u origin main
  echo "==> done. GitHub Pages redeploys in ~1 minute."
else
  cat <<'MSG'

==> No remote configured yet. Do this once:

  1. Create an empty PUBLIC repo named  evobiomed-site  at https://github.com/new
     (do NOT add a README, .gitignore or licence — the folder already has files)

  2. Then run:

       ./deploy.sh git@github.com:<your-username>/evobiomed-site.git

  3. On GitHub: Settings -> Pages -> Source: Deploy from a branch -> main / (root)
     The site goes live at https://<your-username>.github.io/evobiomed-site/
     immediately, and at https://evobiomed.org once DNS points there
     (see README-DEPLOY.md step 3).

MSG
fi
