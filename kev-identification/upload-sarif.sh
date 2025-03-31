#!/usr/bin/env bash
# This script uploads a SARIF file to GitHub code scanning alerts.
# It takes two arguments:
# 1. The path to the SARIF file
# 2. The GitHub repository in the format owner/repo

set -e

# gzip the SARIF file and base64 encode it
sarif=$(gzip -c "$1" | base64 -w 0)
repo="$2"

curl -L \
  --fail \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/"$repo"/code-scanning/sarifs \
  -d '{"commit_sha":"'"$GITHUB_SHA"'","ref":"refs/heads/main","sarif": "'"$sarif"'"}'
