#!/usr/bin/env bash
# Usage: ./scripts/push-report.sh <branch> <date> [base-branch]
# Requires GITHUB_TOKEN env var with repo scope

set -euo pipefail

BRANCH="${1:?missing branch name}"
DATE="${2:?missing date (YYYY-MM-DD)}"
BASE="${3:-master}"
REPO="if540/f2e-research"
TOKEN="${GITHUB_TOKEN:?GITHUB_TOKEN is not set}"

# Configure remote with token
git remote set-url origin "https://${TOKEN}@github.com/${REPO}.git"

# Sync with base branch before push
git fetch origin "${BASE}"
git rebase "origin/${BASE}"

# Push branch
git push -u origin "${BRANCH}"

# Create PR
PR_URL=$(curl -s -X POST \
  -H "Authorization: token ${TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/${REPO}/pulls" \
  -d "{
    \"title\": \"report: daily trending ${DATE}\",
    \"head\": \"${BRANCH}\",
    \"base\": \"${BASE}\",
    \"body\": \"每日技術趨勢報告 ${DATE}\\n\\n自動產生。詳見 \`reports/${DATE}-trending.md\`。\"
  }" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('html_url','ERROR: '+str(d.get('errors',d))))")

echo "PR: ${PR_URL}"
