#!/usr/bin/env bash
# List local git repositories under common paths and show remote, last commit, and size.
# Usage: ./scripts/list-local-repos.sh [paths...]

set -euo pipefail

PATHS=("/Users/andy/Documents/GitHub" "/Users/andy/Projects" "/Users/andy")
if [ "$#" -gt 0 ]; then
  PATHS=("$@")
fi

printf "Scanning paths: %s\n" "${PATHS[*]}"
echo

for base in "${PATHS[@]}"; do
  if [ ! -d "$base" ]; then
    continue
  fi
  echo "== Path: $base =="
  # find .git directories up to depth 4
  find "$base" -maxdepth 4 -type d -name .git 2>/dev/null | while read -r d; do
    repo=$(dirname "$d")
    echo "-- Repo: $repo"
    if [ -d "$repo" ]; then
      (cd "$repo" || exit 0
        echo "Remote(s):"
        git remote -v || echo "  (no git remotes)"
        echo "Size: $(du -sh . 2>/dev/null | cut -f1)"
        echo "Last commit:"
        git log -1 --pretty=format:"%h %an %ae %ad %s" || echo "  (no commits)"
        echo "Status:"
        git status --porcelain || true
      )
    else
      echo "  (cannot access repo)"
    fi
    echo
  done
done

echo "Done."
