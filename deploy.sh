#!/usr/bin/env bash
set -euo pipefail

SERVER_URL="${LESSTRUCT_BASE_URL:-http://localhost:8080}"
BUILD_DIR="_build"

command -v lesstruct-cli >/dev/null 2>&1 || {
  echo "Error: lesstruct-cli is not installed." >&2
  exit 1
}
command -v curl >/dev/null 2>&1 || {
  echo "Error: curl is required to reach the Lesstruct server." >&2
  exit 1
}
: "${LESSTRUCT_API_KEY:?Error: LESSTRUCT_API_KEY is not set.}"

if ! curl -fsS "${SERVER_URL}/api/health" >/dev/null 2>&1; then
  echo "Error: no Lesstruct server at ${SERVER_URL} — start it first (run 'go run .' in the CMS directory)." >&2
  exit 1
fi

rm -rf "$BUILD_DIR"

echo "Generating static site from ${SERVER_URL} ..."
lesstruct-cli ssg --extract-dir "$BUILD_DIR"

git add -A

if git diff --cached --quiet; then
  echo "No changes since last deploy."
else
  git commit -m "Deploy $(date '+%Y-%m-%d %H:%M:%S')"
  git push
fi
